object FDataModuleConexao: TFDataModuleConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 308
  Width = 418
  object Conexao: TFDConnection
    Params.Strings = (
      'POOL_MaximumItems=5000'
      'DriverID=MySQL')
    ConnectedStoredUsage = []
    LoginPrompt = False
    UpdateTransaction = FDTransaction
    Left = 32
    Top = 32
  end
  object FDTransaction: TFDTransaction
    Connection = Conexao
    Left = 256
    Top = 32
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 128
    Top = 32
  end
end
