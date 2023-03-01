unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.Effects;

type
  TFrameUsers = class(TFrame)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Layout3: TLayout;
    Layout4: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Layout5: TLayout;
    lblNome: TLabel;
    lblTelefone: TLabel;
    ShadowEffect1: TShadowEffect;
  private
    { Private declarations }
  public
    class function New(AOwner: TComponent) : TFrameUsers;
    function NameFrame(Value: String) : TFrameUsers;
    function Alinhamento(Value: TAlignLayout)  : TFrameUsers;
    function Nome(Value: String) : TFrameUsers;
    function Telefone(Value: String) : TFrameUsers;
  end;

implementation

{$R *.fmx}

{ TFrameCities }

function TFrameUsers.Alinhamento(VAlue: TAlignLayout): TFrameUsers;
begin
  Result := Self;
  Self.Align := Value;
end;

function TFrameUsers.NameFrame(Value: String): TFrameUsers;
begin
  Result := Self;
  Self.Name := Value;
end;

class function TFrameUsers.New(AOwner: TComponent) : TFrameUsers;
begin
  Result := Self.Create(AOwner);
  Result.Parent := TFMXObject(AOwner);
end;

function TFrameUsers.Nome(Value: String) : TFrameUsers;
begin
  Result := Self;
  lblNome.Text := Value;
end;

function TFrameUsers.Telefone(Value: String) : TFrameUsers;
begin
  Result := Self;
  lblTelefone.Text := Value;
end;

end.
