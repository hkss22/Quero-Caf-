unit UnitSplash;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.ExtCtrls;
type
  TfrmSplash = class(TForm)
    Image1: TImage;
    Timer: TTimer; // Declare apenas se você usar o designer
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  frmSplash: TfrmSplash;
implementation
uses
  UniLogin; // Unidade do seu formulário de login
{$R *.fmx}
procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Timer := TTimer.Create(Self); // Cria o Timer
  Timer.Interval := 3000; // Define o tempo de exibição (3 segundos)
  Timer.OnTimer := TimerTimer; // Vincula o evento OnTimer
  Timer.Enabled := True; // Ativa o Timer
end;
procedure TfrmSplash.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False; // Desativa o Timer
  Hide; // Oculta o formulário splash
  frmLogin := TfrmLogin.Create(Application); // Cria o formulário de login
  frmLogin.Show; // Mostra o formulário de login
end;
end.
