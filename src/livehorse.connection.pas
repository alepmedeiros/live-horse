unit livehorse.connection;

interface

uses
  livehorse.connection.interfaces,
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.ConsoleUI.Wait,
  Data.DB,
  FireDAC.Comp.Client;

type
  TConnection = class(TInterfacedObject, iConnection)
  private
    FConn : TFDConnection;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iConnection;
    function Conn: TComponent;
  end;

implementation

function TConnection.Conn: TComponent;
begin
  Result := FConn;
end;

constructor TConnection.Create;
begin
  FConn := TFDConnection.Create(nil);
end;

destructor TConnection.Destroy;
begin
  FConn.Free;
  inherited;
end;

class function TConnection.New: iConnection;
begin
  Result := Self.Create;
end;

end.
