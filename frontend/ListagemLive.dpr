program ListagemLive;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {FrameCustomers: TFrame},
  Unit3 in 'Unit3.pas' {FrameUsers: TFrame},
  serviceinterfaces in 'serviceinterfaces.pas',
  restclient in 'restclient.pas',
  service in 'service.pas',
  utils in 'utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
