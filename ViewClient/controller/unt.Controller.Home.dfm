object dmHomeController: TdmHomeController
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 255
  Width = 360
  object memTblCEP: TFDMemTable
    ActiveStoredUsage = []
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 60
    Top = 87
    object memTblCEPidpessoa: TIntegerField
      FieldName = 'idpessoa'
    end
    object memTblCEPidendereco: TIntegerField
      FieldName = 'idendereco'
    end
    object memTblCEPdscep: TStringField
      FieldName = 'dscep'
      Size = 15
    end
  end
  object memTablePessoa: TFDMemTable
    ActiveStoredUsage = []
    ObjectView = False
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'memTablePessoaIndex1'
        Fields = 'idpessoa'
      end>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 60
    Top = 24
    object memTablePessoaidpessoa: TIntegerField
      FieldName = 'idpessoa'
    end
    object memTablePessoaflnatureza: TIntegerField
      FieldName = 'flnatureza'
    end
    object memTablePessoadsdocumento: TStringField
      FieldName = 'dsdocumento'
      Size = 15
    end
    object memTablePessoanmprimeiro: TStringField
      FieldName = 'nmprimeiro'
      Size = 100
    end
    object memTablePessoanmsegundo: TStringField
      FieldName = 'nmsegundo'
      Size = 100
    end
  end
  object dsPessoa: TDataSource
    DataSet = memTablePessoa
    Left = 152
    Top = 24
  end
  object dsCEP: TDataSource
    DataSet = memTblCEP
    Left = 152
    Top = 87
  end
end
