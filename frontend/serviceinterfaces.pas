unit serviceinterfaces;

interface

uses
  Data.DB,
  System.Classes;

type
  iHttpClient = interface
    function GetAll(Url: String) : iHttpClient;
    function Post(Url: String) : iHttpClient;
    function Body(Value: String) : iHttpClient;
    function Headers(aKey: String; aValue: Variant) : iHttpClient;
    function ETag : String;
    function DataSet(Value: TDataSet) : iHttpClient;
    function Content(var Value: String) : iHttpClient;
    function Status : Integer;
  end;

  iService = interface
    function ListarTodos(Resource: String) : iService;
    function ToCreate(Resource: String) : iService;
    function Body(Value: String) : iService;
    function Headers(aKey: String; aValue: Variant) : iService;
    function DataSet(Value: TDataSet) : iService;
    function ETag(var Value: String) : iService;
    function Content(var Value: String) : iService;
    function StatusCode : Integer;
  end;

implementation

end.
