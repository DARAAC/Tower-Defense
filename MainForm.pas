unit MainForm;

{
  ToDos:
   I - Wenn der Button gedrückt wird, wird der Button markiert bis die Truppe
    hinzugefügt wurde
   I - Truppe darf nicht auf Strasse sein
    I   - Definieren der Strasse über Labels in den Ecken (Klasse "TRoad" zum verwalten von Labels)
     I  - funktion TRoad.PositionIsRoad(x, y)
      I - Hinzufügen der Truppe: Event MapMouseUp erweitern um zu überprüfen,
         ob Position auf Strasse ist

<    - Modelle für Truppen(Fertig) / Karten / ..

    - Funktionalität der Truppe (Klasse für Truppe)
      - Schiessen

    - Zombies

}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, System.UITypes,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Schiessen, Zombie;

type
  TForm1 = class(TForm)
    Main: TPanel;
    Map: TImage;
    Selection: TPanel;
    Troop1: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Troop1Click(Sender: TObject);
    procedure MapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);


  private
    { Private-Deklarationen }
    CurrentTroop: TImage;
    FProjectiles: TList;
    FZombies: TList;
  public
    { Public-Deklarationen }
    procedure Shoot(aPosition, aTarget: TPoint);
    procedure SpawnZombie;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.FormCreate(Sender: TObject);
begin
  FProjectiles := TList.Create;
  FZombies := TList.Create;
  Timer1.Interval := 16;
  Timer1.Enabled := True;

  panel1.Visible := false;
  panel2.Visible := false;
  panel3.Visible := false;
  panel4.Visible := false;
  panel5.Visible := false;
  panel6.Visible := false;
  panel7.Visible := false;
  panel8.Visible := false;

  SpawnZombie;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  aa : Integer;
begin
  Canvas.FillRect(ClientRect);
  for aa := 0 to FProjectiles.Count - 1 do
    TShooting(FProjectiles[aa]).Draw(Canvas);
  for aa := 0 to FZombies.Count - 1 do
    TZombie(FZombies[aa]).Draw;
end;

procedure TForm1.Label1Click(Sender: TObject);
var
  TroopPosition : TImage;
begin
  if CurrentTroop <> nil then
  begin
    CurrentTroop := nil;
  end;

end;

procedure TForm1.MapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  lImage: TImage;
  lMousePoint: TPoint;
begin
  lMousePoint := Point(X,Y);
  if Panel1.BoundsRect.Contains(lMousePoint) or
     Panel2.BoundsRect.Contains(lMousePoint) or
     Panel3.BoundsRect.Contains(lMousePoint) or
     Panel4.BoundsRect.Contains(lMousePoint) or
     Panel5.BoundsRect.Contains(lMousePoint) or
     Panel6.BoundsRect.Contains(lMousePoint) or
     Panel7.BoundsRect.Contains(lMousePoint) then
     begin
     Exit;
     end;

  if CurrentTroop <> Nil then
  begin
    lImage := TImage.Create(Self);
    lImage.Picture.LoadFromFile('..\..\Soldierbck.png');
    lImage.Stretch := True;
    lImage.Height := 90;
    lImage.Width := 90;
    Main.InsertControl(lImage);
    lImage.Left := X;
    lImage.Top := Y;
    CurrentTroop := Nil;
  end;
  Panel8.Visible := False;
end;

procedure TForm1.Shoot(aPosition, aTarget: TPoint);
begin
  FProjectiles.Add(TShooting.Create(aPosition, aTarget, 5, 10));
end;

procedure TForm1.SpawnZombie;
var
  lStartPos, lEndPos: TPoint; 
begin
  lStartPos := Point(0, Map.Height div 2);
  lEndPos := Point(Map.Width, Map.Height div 2);
  FZombies.Add(TZombie.Create(Self, lStartPos, lEndPos, 2, Main));
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  aa: Integer;
  lProjectile: TShooting;
  Zombie: TZombie; 
begin
  for aa := FProjectiles.Count -1 downto 0 do
  begin
    lProjectile := TShooting(FProjectiles[aa]);
    lProjectile.Move;
    if lProjectile.IsHit(lProjectile.FTarget) then
    begin
      FProjectiles.Remove(lProjectile);
      lProjectile.Free;
    end;
  end;

  for aa := FZombies.Count - 1 downto 0 do
  begin
    Zombie := TZombie(FZombies[aa]);
    Zombie.Move;
    if Zombie.HasReachedEnd then
    begin
      FZombies.Remove(Zombie);
      Zombie.Free;
    end;
  end;
  Invalidate;
end;

procedure TForm1.Troop1Click(Sender: TObject);
begin
  CurrentTroop := Troop1;
  Panel8.Color := clMenuHighlight;
  Panel8.Visible := True;
end;

end.
