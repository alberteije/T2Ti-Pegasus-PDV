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
    Left = 144
    Top = 120
  end
  object FDTransaction: TFDTransaction
    Connection = Conexao
    Left = 224
    Top = 176
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 264
    Top = 104
  end
end
