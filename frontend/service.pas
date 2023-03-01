unit service;

interface

uses
  Data.DB,
  serviceinterfaces,
  restclient;

type
  TService = class(TInterfacedObject, iService)
  private
    FHttpClient: iHttpClient;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iService;
    function ListarTodos(Resource: String): iService;
    function ToCreate(Resource: String) : iService;
    function Body(Value: String) : iService;
    function Headers(aKey: String; aValue: Variant): iService;
    function DataSet(Value: TDataSet): iService;
    function ETag(var Value: String): iService;
    function Content(var Value: String): iService;
    function StatusCode : Integer;
  end;

implementation

function TService.Body(Value: String): iService;
begin
  Result := Self;
  FHttpClient.Body(Value);
end;

function TService.Content(var Value: String): iService;
begin
  Result := Self;
  FHttpClient.Content(Value);
end;

constructor TService.Create;
begin
  FHttpClient := TRestClient.New;
end;

function TService.DataSet(Value: TDataSet): iService;
begin
  Result := Self;
  FHttpClient.DataSet(Value);
end;

destructor TService.Destroy;
begin

  inherited;
end;

function TService.ETag(var Value: String): iService;
var
  I: Integer;
begin
  Result := Self;
  Value:= FHttpClient.ETag;
end;

function TService.Headers(aKey: String; aValue: Variant): iService;
begin
  Result := Self;
  FHttpClient.Headers(aKey,aValue);
end;

function TService.ListarTodos(Resource: String): iService;
begin
  Result := Self;
  FHttpClient.GetAll(Resource);
end;

class function TService.New: iService;
begin
  Result := Self.Create;
end;

function TService.StatusCode: Integer;
begin
  Result := FHttpClient.Status;
end;

function TService.ToCreate(Resource: String): iService;
begin
  Result := Self;
  FHttpClient.Post(Resource);
end;

end.
