object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\MyRepository\live-horse\database\dados.sdb'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 40
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 128
    Top = 88
  end
end
