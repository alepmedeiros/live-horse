unit livehorse.query;

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
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet, livehorse.connection;

type
  TQuery = class(TInterfacedObject, iQuery)
  private
    FConn: iConnection;
    FQuery: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iQuery;
    function SQL(Value: String): iQuery;
    function Open: iQuery;
    function ExecSQL: iQuery;
  end;

implementation

constructor TQuery.Create;
begin
  FQuery:= TFDQuery.Create(nil);
  FQuery.Connection := TFDConnection(TConnection.New.Conn);
end;

destructor TQuery.Destroy;
begin
  FQuery.free;
  inherited;
end;

function TQuery.ExecSQL: iQuery;
begin
  result := self;
  fquery.ExecSQL;
end;

class function TQuery.New: iQuery;
begin
  Result := Self.Create;
end;

function TQuery.Open: iQuery;
begin
  result := self;
  FQuery.Open;
end;

function TQuery.SQL(Value: String): iQuery;
begin
  result := Self;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Value);
end;

end.
