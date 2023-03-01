unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.Effects;

type
  TFrameCustomers = class(TFrame)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Layout3: TLayout;
    Layout4: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Layout5: TLayout;
    lblCodigo: TLabel;
    lblNome: TLabel;
    ShadowEffect1: TShadowEffect;
  private

  public
    class function New(AOwner: TComponent) : TFrameCustomers;
    function NameFrame(Value: String) : TFrameCustomers;
    function Alinhamento(Value: TAlignLayout) : TFrameCustomers;
    function Codigo(Value: String) : TFrameCustomers;
    function Nome(Value: String) : TFrameCustomers;
  end;

implementation

{$R *.fmx}

{ TFrameUser }


function TFrameCustomers.NameFrame(Value: String): TFrameCustomers;
begin
  Result := Self;
  Self.Name := Value;
end;

class function TFrameCustomers.New(AOwner: TComponent) : TFrameCustomers;
begin
  Result := Self.Create(AOwner);
  Result.Parent := TFMXObject(AOwner);
end;

function TFrameCustomers.Nome(Value: String) : TFrameCustomers;
begin
  Result := Self;
  lblNome.Text := Value;
end;

function TFrameCustomers.Alinhamento(Value: TAlignLayout): TFrameCustomers;
begin
  Result := Self;
  Self.Align := Value;
end;

function TFrameCustomers.Codigo(Value: String) : TFrameCustomers;
begin
  Result := Self;
  lblcodigo.Text := Value;
end;

end.
