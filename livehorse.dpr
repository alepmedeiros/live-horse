program livehorse;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.Paginate,
  System.SysUtils,
  livehorse.connection.interfaces in 'src\livehorse.connection.interfaces.pas',
  livehorse.connection in 'src\livehorse.connection.pas',
  livehorse.query in 'src\livehorse.query.pas',
  livehorse.DAOGeneric in 'src\livehorse.DAOGeneric.pas';

begin
  THorse
  .Use(Paginate)
    .Use(Jhonson);

  THorse.Listen(9000);
end.
