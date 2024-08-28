program TowerDefnseApp;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  Schiessen in 'Schiessen.pas',
  Zombie in 'Zombie.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
