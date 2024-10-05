unit UnitCarrinho;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, uFunctions,
  uLoading, System.JSON;

type
  TFrmCarrinho = class(TForm)
    lytToolbar: TLayout;
    lblTitulo: TLabel;
    imgVoltar: TImage;
    lytEndereco: TLayout;
    lblNome: TLabel;
    lblEndereco: TLabel;
    btnFinalizar: TButton;
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Label2: TLabel;
    lblSubTotal: TLabel;
    Layout2: TLayout;
    Label4: TLabel;
    lblTaxa: TLabel;
    Layout3: TLayout;
    Label6: TLabel;
    lblTotal: TLabel;
    Label8: TLabel;
    lblEndEntrega: TLabel;
    lbProdutos: TListBox;
    btnLimpar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    procedure AddProduto(id_produto: integer;
                                  descricao, url_foto: string;
                                  qtd, valor_unit: double);
    procedure CarregarCarrinho;
    procedure DownloadFoto(lb: TListBox);
    procedure ThreadPedidoTerminate(Sender: TObject);
    procedure AtualizarInterface;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCarrinho: TFrmCarrinho;

implementation

{$R *.fmx}

uses UnitPrincipal, Frame.ProdutoLista, DataModule.Mercado, DataModule.Usuario;

procedure TFrmCarrinho.DownloadFoto(lb: TListBox);
var
    t: TThread;
    frame: TFrameProdutoLista;
begin
    // Carregar imagens...
    t := TThread.CreateAnonymousThread(procedure
    var
        i : integer;
    begin

        for i := 0 to lb.Items.Count - 1 do
        begin
            frame := TFrameProdutoLista(lb.ItemByIndex(i).Components[0]);

            if frame.imgFoto.TagString <> '' then
                LoadImageFromURL(frame.imgFoto.Bitmap, frame.imgFoto.TagString);
        end;

    end);

    t.Start;
end;

procedure TFrmCarrinho.AddProduto(id_produto: integer;
                                  descricao, url_foto: string;
                                  qtd, valor_unit: double);

var
    item: TListBoxItem;
    frame: TFrameProdutoLista;
begin
     item := TListBoxItem.Create(lbProdutos);
     item.Selectable := false;
     item.Text := '';
     item.Height := 80;
     item.Tag := id_produto;

     //Frame...
     frame := TFrameProdutoLista.Create(item);
     frame.imgFoto.TagString := url_foto;
     frame.lblDescricao.text := descricao;
     frame.lblQtd.text := qtd.ToString + ' x ' + FormatFloat('R$ #,##0.00', valor_unit);
     frame.lblValor.text := FormatFloat('R$ #,##0.00', qtd * valor_unit);

     item.AddObject(frame);

     lbProdutos.AddObject(item);
end;

procedure TFrmCarrinho.ThreadPedidoTerminate(Sender: TObject);
begin
    TLoading.Hide;
    if Assigned(TThread(Sender).FatalException) then
    begin
        ShowMessage('Erro ao finalizar a compra: ' + Exception(TThread(Sender).FatalException).Message);
        Exit;
    end;
    // Exibe a mensagem de sucesso
    ShowMessage('Compra realizada com sucesso!');
    // Limpa o carrinho após a compra
    DmMercado.LimparCarrinhoLocal;
    Close; // Fecha o formulário
end;

procedure TFrmCarrinho.btnFinalizarClick(Sender: TObject);
var
    t: TThread;
    jsonPedido: TJsonObject;
begin
    TLoading.Show(FrmCarrinho, 'Finalizando compra...');
    t := TThread.CreateAnonymousThread(procedure
    begin
        try
            // Criar o JSON do pedido
            jsonPedido := DmMercado.JsonPedido(lblSubTotal.TagFloat, lblTaxa.TagFloat, lblTotal.TagFloat);
            jsonPedido.AddPair('itens', DmMercado.JsonPedidoItem);
            // Inserir o pedido no banco de dados
            DmMercado.InserirPedido(jsonPedido);
        finally
            jsonPedido.DisposeOf;
        end;
    end);
    // Define o evento OnTerminate para o thread
    t.OnTerminate := ThreadPedidoTerminate;
    t.Start;
end;

procedure TFrmCarrinho.btnLimparClick(Sender: TObject);
begin
var
    t: TThread;
begin
    TLoading.Show(FrmCarrinho, 'Limpando carrinho...');
    t := TThread.CreateAnonymousThread(procedure
    begin
        try
            // Limpa os itens do carrinho
            DmMercado.LimparCarrinhoLocal; // Chama a função para limpar o carrinho
        finally
            // Chama um método para atualizar a interface após a limpeza
            TThread.Synchronize(nil, procedure
            begin
                AtualizarInterface; // Atualiza a interface do carrinho
                TLoading.Hide; // Esconde a tela de loading
                ShowMessage('O carrinho foi limpo com sucesso!'); // Mensagem de sucesso
            end);
        end;
    end);
    t.Start;
end;
end;

procedure TFrmCarrinho.AtualizarInterface;
begin
    // Limpa a lista de produtos do carrinho
    lbProdutos.Items.Clear; // Limpa a lista de itens do carrinho
    // Reseta os rótulos
    lblNome.Text := ''; // Limpa o nome do mercado
    lblEndereco.Text := ''; // Limpa o endereço do mercado
    lblSubTotal.Text := 'R$ 0,00'; // Reseta o subtotal
    lblSubTotal.TagFloat := 0.0; // Reseta o valor do subtotal
    lblTaxa.Text := 'R$ 0,00'; // Reseta a taxa
    lblTaxa.TagFloat := 0.0; // Reseta o valor da taxa
    lblTotal.Text := 'R$ 0,00'; // Reseta o total
    lblTotal.TagFloat := 0.0; // Reseta o valor total
    lblEndEntrega.Text := ''; // Limpa o endereço do usuario
end;

procedure TFrmCarrinho.CarregarCarrinho;
var
    subtotal: double;
    taxaEntrega: double;
begin
    try
        DmMercado.ListarCarrinhoLocal;
        DmMercado.ListarItemCarrinhoLocal;
        DmUsuario.ListarUsuarioLocal;

        // Dados Mercado...
        lblNome.Text := DmMercado.QryCarrinho.FieldByName('NOME_MERCADO').AsString;
        lblEndereco.Text := DmMercado.QryCarrinho.FieldByName('ENDERECO_MERCADO').AsString;
        taxaEntrega := DmMercado.QryCarrinho.FieldByName('TAXA_ENTREGA').AsFloat;
        lblTaxa.Text := FormatFloat('R$#,##0.00', DmMercado.QryCarrinho.FieldByName('TAXA_ENTREGA').AsFloat);
        lblTaxa.TagFloat := DmMercado.QryCarrinho.FieldByName('TAXA_ENTREGA').AsFloat;

        // Verifica se a taxa de entrega é 0
        if taxaEntrega = 0 then
        begin
            lblEndEntrega.Text := 'Retirar'; // Exibe "Retirar"
            lblEndEntrega.Visible := True; // Garante que o label esteja visível
        end
        else
        begin
            lblEndEntrega.Text := DmUsuario.QryUsuario.FieldByName('ENDERECO').AsString + ' - ' +
                              DmUsuario.QryUsuario.FieldByName('BAIRRO').AsString + ' - ' +
                              DmUsuario.QryUsuario.FieldByName('CIDADE').AsString + ' - ' +
                              DmUsuario.QryUsuario.FieldByName('UF').AsString;
            lblEndEntrega.Visible := True; // Mostra o endereço de entrega
        end;

        // Itens do carrinho...
        subtotal := 0;
        lbProdutos.Items.Clear;
        with DmMercado.QryCarrinhoItem do
        begin
            while NOT EOF do
            begin
                AddProduto(FieldByName('id_produto').AsInteger,
                           FieldByName('nome').AsString,
                           FieldByName('url_foto').AsString,
                           FieldByName('qtd').AsFloat,
                           FieldByName('valor_unitario').AsFloat);

                subtotal := subtotal + FieldByName('valor_total').AsFloat;

                Next;
            end;
        end;

        lblSubTotal.Text := FormatFloat('R$#,##0.00', subtotal);
        lblSubTotal.TagFloat := subtotal;

        lblTotal.Text := FormatFloat('R$#,##0.00', subtotal + lblTaxa.TagFloat);
        lblTotal.TagFloat := subtotal + lblTaxa.TagFloat;

        // Carrega as fotos...
        DownloadFoto(lbProdutos);

    except on ex:exception do
         showmessage('Erro ao carregar carrinho: ' + ex.Message);
    end;
end;

procedure TFrmCarrinho.FormShow(Sender: TObject);
begin
    CarregarCarrinho;
end;

procedure TFrmCarrinho.imgVoltarClick(Sender: TObject);
begin
    close;
end;

end.
