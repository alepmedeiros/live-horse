unit restclient;

interface

uses
  System.Classes,
  Data.DB,
  RESTRequest4D,
  serviceinterfaces;

type
  TRestClient = class(TInterfacedObject, iHttpClient)
    private
      FReq: IRequest;
      FResp: IResponse;

      CONST
        BASE_URL = 'http://localhost:9000';
        CONTENT_TYPE = 'Content-Type';
        APPLICATION_JSON = 'application/json';
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iHttpClient;
      function GetAll(Url: String) : iHttpClient;
      function Post(Url: String) : iHttpClient;
      function Body(Value: String) : iHttpClient;
      function Headers(aKey: String; aValue: Variant) : iHttpClient;
      function DataSet(Value: TDataSet) : iHttpClient;
      function Content(var Value: String) : iHttpClient;
      function Status : Integer;
      function ETag : String;
  end;

implementation

function TRestClient.Body(Value: String): iHttpClient;
begin
  Result := Self;
  FReq.AddBody(Value);
end;

function TRestClient.Content(var Value: String): iHttpClient;
begin
  Result := Self;
  Value := FResp.Content;
end;

constructor TRestClient.Create;
begin
  FReq := TRequest.New.BaseURL(BASE_URL);
end;

function TRestClient.DataSet(Value: TDataSet): iHttpClient;
begin
  Result := Self;
  FReq.DataSetAdapter(Value);
end;

destructor TRestClient.Destroy;
begin

  inherited;
end;

function TRestClient.ETag: String;
begin
  Result := FResp.Headers.Values['ETag'];
end;

function TRestClient.GetAll(Url: String): iHttpClient;
begin
  Result := Self;

  FResp :=
    FReq
      .Resource(Url)
      .Get;
end;

class function TRestClient.New : iHttpClient;
begin
  Result := Self.Create;
end;

function TRestClient.Post(Url: String): iHttpClient;
begin
  Result := Self;
  FResp :=
    FReq
      .Resource(Url)
      .AddHeader(CONTENT_TYPE, APPLICATION_JSON)
      .Post;
end;

function TRestClient.Status : Integer;
begin
  Result := FResp.StatusCode;
end;

function TRestClient.Headers(aKey: String; aValue: Variant): iHttpClient;
begin
  Result := Self;

  FReq.AddHeader(aKey, aValue);
end;

end.
