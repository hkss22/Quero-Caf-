program MeuMercado;

uses
  System.StartUpCopy,
  FMX.Forms,
  UniLogin in 'UniLogin.pas' {FrmLogin},
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  Frame.ProdutoCard in 'Frames\Frame.ProdutoCard.pas' {FrameProdutoCard: TFrame},
  UnitSplash in 'UnitSplash.pas' {frmSplash},
  UnitMercado in 'UnitMercado.pas' {FrmMercado},
  UnitProduto in 'UnitProduto.pas' {FrmProduto},
  UnitCarrinho in 'UnitCarrinho.pas' {FrmCarrinho},
  Frame.ProdutoLista in 'Frames\Frame.ProdutoLista.pas' {FrameProdutoLista: TFrame},
  UnitPedido in 'UnitPedido.pas' {FrmPedido},
  UnitPedidoDetalhe in 'UnitPedidoDetalhe.pas' {FrmPedidoDetalhe},
  DataModule.Usuario in 'DataModule\DataModule.Usuario.pas' {DmUsuario: TDataModule},
  uLoading in 'Units\uLoading.pas',
  DataModule.Mercado in 'DataModule\DataModule.Mercado.pas' {DmMercado: TDataModule},
  uConsts in 'Units\uConsts.pas',
  uFunctions in 'Units\uFunctions.pas',
  uSession in 'Units\uSession.pas',
  UnitPerfil in 'UnitPerfil.pas' {FrmPerfil};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TDmUsuario, DmUsuario);
  Application.CreateForm(TDmMercado, DmMercado);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmPerfil, FrmPerfil);
  Application.Run;
end.
