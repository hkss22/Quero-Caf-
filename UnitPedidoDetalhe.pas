unit UnitPedidoDetalhe;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, uLoading,
  System.JSON, uFunctions;

type
  TFrmPedidoDetalhe = class(TForm)
    lytToolbar: TLayout;
    lblTitulo: TLabel;
    imgVoltar: TImage;
    lytEndereco: TLayout;
    lblMercado: TLabel;
    lblMercadoEnd: TLabel;
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Label2: TLabel;
    lblSubtotal: TLabel;
    Layout2: TLayout;
    Label4: TLabel;
    lblTaxaEntrega: TLabel;
    Layout3: TLayout;
    Label6: TLabel;
    lblTotal: TLabel;
    Label8: TLabel;
    lblEndereco: TLabel;
    lbProdutos: TListBox;
    procedure FormShow(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
  private
    Fid_pedido: integer;
    procedure AddProduto(id_produto: integer;
                                  descricao, url_foto: string;
                                  qtd, valor_unit: double);
    procedure CarregarPedido;
    procedure ThreadDadosTerminate(Sender: TObject);
    procedure DownloadFoto(lb: TListBox);
    function SafeStrToInt(const S: string): Integer;
    { Private declarations }
  public
    property id_pedido: integer read Fid_pedido write Fid_pedido;
  end;

var
  FrmPedidoDetalhe: TFrmPedidoDetalhe;

implementation

{$R *.fmx}

uses Frame.ProdutoLista, DataModule.Usuario;

function TFrmPedidoDetalhe.SafeStrToInt(const S: string): Integer;
var
  CleanStr: string;
begin
  CleanStr := StringReplace(S, '.', '', [rfReplaceAll]); // Remove o ponto
  CleanStr := StringReplace(CleanStr, ',', '', [rfReplaceAll]); // Remove a v�rgula, se necess�rio
  Result := StrToInt(CleanStr); // Agora converte para inteiro
end;

procedure TFrmPedidoDetalhe.DownloadFoto(lb: TListBox);
var
    t: TThread;
    foto: TBitmap;
    frame: TFrameProdutoLista;
begin
    // Carregar imagens...
    t := TThread.CreateAnonymousThread(procedure
    var
        i : integer;
    begin

        for i := 0 to lb.Items.Count - 1 do
        begin
            //sleep(1000);
            frame := TFrameProdutoLista(lb.ItemByIndex(i).Components[0]);


            if frame.imgFoto.TagString <> '' then
            begin
                foto := TBitmap.Create;
                LoadImageFromURL(foto, frame.imgFoto.TagString);

                frame.imgFoto.TagString := '';
                frame.imgFoto.bitmap := foto;
            end;
        end;

    end);

    t.Start;
end;

procedure TFrmPedidoDetalhe.AddProduto(id_produto: integer;
                                  descricao, url_foto: string;
                                  qtd, valor_unit: double);
var
    item: TListBoxItem;
    frame: TFrameProdutoLista;
    FormatSettings: TFormatSettings;
    quantidade: integer; // Para armazenar a quantidade inteira
begin
  // Cria as configura��es de formato
    FormatSettings := TFormatSettings.Create;
    FormatSettings.DecimalSeparator := ',';
    FormatSettings.ThousandSeparator := '.';

    // Converte a quantidade decimal para inteiro
    quantidade := Trunc(qtd); // Use Round(qtd) se quiser arredondar

    item := TListBoxItem.Create(lbProdutos);
    item.Selectable := false;
    item.Text := '';
    item.Height := 80;
    item.Tag := id_produto;

    // Frame...
    frame := TFrameProdutoLista.Create(item);
    frame.imgFoto.TagString := url_foto;
    frame.lblDescricao.text := descricao;

    // Atualiza a exibi��o da quantidade e do valor
    frame.lblQtd.Text := IntToStr(quantidade) + ' x ' + FormatFloat('R$ #,##0.00', valor_unit, FormatSettings);
    frame.lblValor.Text := FormatFloat('R$ #,##0.00', quantidade * valor_unit, FormatSettings);

    item.AddObject(frame);

    lbProdutos.AddObject(item);
end;

procedure TFrmPedidoDetalhe.ThreadDadosTerminate(Sender: TObject);
begin
    TLoading.Hide;

    if Sender is TThread then
    begin
        if Assigned(TThread(Sender).FatalException) then
        begin
            showmessage(Exception(TThread(sender).FatalException).Message);
            exit;
        end;
    end;

    DownloadFoto(lbProdutos);
end;

procedure TFrmPedidoDetalhe.CarregarPedido;
var
    t: TThread;
    jsonObj: TJsonObject;
    arrayItem: TJSONArray;
    vl_entrega: double;
begin
    TLoading.Show(FrmPedidoDetalhe, '');
    lbProdutos.Items.Clear;

    t := TThread.CreateAnonymousThread(procedure
    begin
        jsonObj := DmUsuario.JsonPedido(id_pedido);

        TThread.Synchronize(TThread.CurrentThread, procedure
        var
            x : integer;
        begin
            lblTitulo.Text := 'Pedido #' + jsonObj.GetValue<string>('id_pedido', '');
            lblMercado.Text := jsonObj.GetValue<string>('nome_mercado', '');
            lblMercadoEnd.Text := jsonObj.GetValue<string>('endereco_mercado', '');
            lblSubtotal.Text := FormatFloat('R$ #,##0.00', jsonObj.GetValue<double>('vl_subtotal', 0), FormatSettings);
            vl_entrega := jsonObj.GetValue<double>('vl_entrega', 0);
            lblTaxaEntrega.Text := FormatFloat('R$ #,##0.00', jsonObj.GetValue<double>('vl_entrega', 0), FormatSettings);
            lblTotal.Text := FormatFloat('R$ #,##0.00', jsonObj.GetValue<double>('vl_total', 0), FormatSettings);
            lblEndereco.Text := jsonObj.GetValue<string>('endereco', '');

            // Verifique se vl_entrega � 0
            if vl_entrega = 0 then
            begin
                lblEndereco.Text := 'Retirar'; // Exibe "Retirar"
            end
            else
            begin
                lblEndereco.Text := jsonObj.GetValue<string>('endereco', ''); // Exibe o endere�o
                lblMercadoEnd.Visible := True; // Mostra o endere�o do mercado
            end;

            // Itens...
            arrayItem := jsonObj.GetValue<TJSONArray>('itens');

            for x := 0 to arrayItem.Size - 1 do
            begin
                AddProduto(arrayItem.Get(x).GetValue<integer>('id_produto', 0),
                           arrayItem.Get(x).GetValue<string>('descricao', ''),
                           arrayItem.Get(x).GetValue<string>('url_foto', ''),
                           Trunc(arrayItem.Get(x).GetValue<double>('qtd', 0)),
                           arrayItem.Get(x).GetValue<double>('vl_unitario', 0));
            end;
        end);

        jsonObj.DisposeOf;

    end);

    t.OnTerminate := ThreadDadosTerminate;
    t.Start;
end;


procedure TFrmPedidoDetalhe.FormShow(Sender: TObject);
begin
    CarregarPedido;
end;

procedure TFrmPedidoDetalhe.imgVoltarClick(Sender: TObject);
begin
    close;
end;

end.
