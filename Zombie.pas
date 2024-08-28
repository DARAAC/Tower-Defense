unit Zombie;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, System.UITypes,
  Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TZombie = Class
    Private
      FPos: TPoint;
      FSpeed: Single;
      FImage: TImage;
      FEndPos: TPoint;
    Public
      constructor Create(aOwner: TComponent; aStartPos, aEndPos: TPoint; aSpeed: Single; aParent: TWinControl);
      procedure Move;
      procedure Draw;
      function HasReachedEnd: Boolean;
      property Position: TPoint read FPos;
  End;

  Type
    TCordArray = Array of TZombie;

implementation

{ TZombie }

constructor TZombie.Create(aOwner: TComponent; aStartPos, aEndPos: TPoint;
  aSpeed: Single; aParent: TWinControl);
begin
  FPos := aStartPos;
  FEndPos := aEndPos;
  FSpeed := aSpeed;

  FImage := TImage.Create(aOwner);
  FImage.Parent := aParent;
  FImage.Picture.LoadFromFile('..\..\ZombieNB.png');
  FImage.Stretch := True;
  FImage.Height := 50;
  FImage.Width := 50;
  FImage.Left := FPos.X;
  FImage.Top := FPos.Y;
end;

procedure TZombie.Draw;
begin

end;

function TZombie.HasReachedEnd: Boolean;
begin
  Result := (Abs(Fpos.X - FEndPos.X) < 5) and (Abs(FPos.Y - FEndPos.Y) < 5);
end;

procedure TZombie.Move;
var
  Direction: TPoint;
  Distance: Single;
begin
  Direction.X := FEndPos.X - FPos.X;
  Direction.Y := FEndPos.Y - FPos.Y;
  Distance := Sqrt(Sqr(Direction.X) + Sqr(Direction.Y));

  if Distance <> 0 then
  begin
    Direction.X := Round(Direction.X / Distance * FSpeed);
    Direction.Y := Round(Direction.Y / Distance * FSpeed);

    FPos.X := FPos.X + Direction.X;
    FPos.Y := FPos.Y + Direction.Y;

    FImage.Left := FPos.X;
    FImage.Top := FPos.Y;
  end;
end;

end.
