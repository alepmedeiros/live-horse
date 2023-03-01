unit livehorse.connection.interfaces;

interface

uses
  System.Classes;

type
  iConnection = interface
    function Conn : TComponent;
  end;

  iQuery = interface
    function SQL(Value: String) : iQuery;
    function Open : iQuery;
    function ExecSQL : iQuery;
  end;

implementation

end.
