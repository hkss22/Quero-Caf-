object DmUsuario: TDmUsuario
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object TabUsuario: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 64
    Top = 200
  end
  object conn: TFDConnection
    AfterConnect = connAfterConnect
    BeforeConnect = connBeforeConnect
    Left = 328
    Top = 208
  end
  object QryGeral: TFDQuery
    Connection = conn
    Left = 176
    Top = 368
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 336
    Top = 376
  end
  object QryUsuario: TFDQuery
    Connection = conn
    Left = 240
    Top = 360
  end
  object TabPedido: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 160
    Top = 200
  end
end
