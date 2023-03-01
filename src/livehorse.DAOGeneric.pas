unit livehorse.DAOGeneric;

interface

uses
  System.JSON;

type
  iDao<T : class> = interface
    function Find : TJSONArray; overload;
    function Find(const aID : String) : TJSONObject; overload;
    function Insert(const Value: TJSONObject) : TJSONObject;
    function Update(const Value: TJSONObject) : TJSONObject;
    function Delete(aField, aValue: String) : TJSONObject;
  end;

implementation

end.
