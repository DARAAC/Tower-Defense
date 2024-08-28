unit Schiessen;

interface
  uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Math, Zombie;

  Type
   TShooting = class
    private
     FPos: TPoint;
     FSpeed: Single;
     FDirection: TPoint;
     FDamage: Integer;
  public FTarget: TPoint;
     function Hypot(dx, dy: Single): Single;
    public
     constructor Create(aPos, aTarget: TPoint; aSpeed: Single; aDamage: Integer);
     procedure Move;
     procedure Draw(aCanvas: TCanvas);
     function IsHit(aTarget: TPoint): Boolean;
     property Position: TPoint read FPos;
     property Damage: Integer read FDamage;
   end;
implementation


{ TShooting }

constructor TShooting.Create(aPos, aTarget: TPoint; aSpeed: Single;
  aDamage: Integer);
var
  Distance: Single; 
begin
  FPos := aPos;
  FTarget := aTarget;
  FSpeed := aSpeed;
  FDamage := aDamage;

  FDirection.X := aTarget.X - aPos.X;
  FDirection.Y := aTarget.Y - aPos.Y;
  Distance := Hypot(FDirection.X, FDirection.Y);
  if Distance <> 0 then
  begin
    FDirection := Point(Round(FDirection.X / Distance * FSpeed),
                        Round(FDirection.Y / Distance * FSpeed)); 
  end;
end;

procedure TShooting.Draw(aCanvas: TCanvas);
begin
  aCanvas.Brush.Color := clRed;
  aCanvas.Ellipse(FPos.X - 3, FPos.Y - 3, FPos.X + 3, FPos.Y + 3);
end;

function TShooting.Hypot(dx, dy: Single): Single;
begin
  Result := Sqrt(Sqr(dx) + Sqr(Dy));
end;

function TShooting.IsHit(aTarget: TPoint): Boolean;
begin
  Result := (Abs(FPos.X - aTarget.X) < 5) and (Abs(FPos.Y - aTarget.Y) < 5);
end;

procedure TShooting.Move;
begin
  FPos.X := Fpos.X + FDirection.X;
  FPos.Y := FPos.Y + FDirection.Y;
end;

end.
