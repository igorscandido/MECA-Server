inherited ServiceProduto: TServiceProduto
  OldCreateOrder = True
  inherited Query: TFDQuery
    SQL.Strings = (
      'SELECT * FROM produto'
      
        'WHERE (:descricao IS NULL OR descricao LIKE CONCAT('#39'%'#39',:descrica' +
        'o,'#39'%'#39') )'
      'AND (:preco IS NULL OR preco = :preco)'
      'AND (:fg_status IS NULL OR fg_status = :fg_status)'
      '')
    ParamData = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PRECO'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FG_STATUS'
        DataType = ftFixedChar
        ParamType = ptInput
        Value = Null
      end>
    object Queryidproduto: TFDAutoIncField
      FieldName = 'idproduto'
      Origin = 'idproduto'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object Querydescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 60
    end
    object Querypreco: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'preco'
      Origin = 'preco'
    end
    object Querydcadastro: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'dcadastro'
      Origin = 'dcadastro'
    end
    object Queryfg_status: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'fg_status'
      Origin = 'fg_status'
      FixedChar = True
      Size = 1
    end
  end
  inherited qUpdate: TFDQuery
    SQL.Strings = (
      'SELECT * FROM produto')
    object qUpdateidproduto: TFDAutoIncField
      FieldName = 'idproduto'
      Origin = 'idproduto'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qUpdatedescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 60
    end
    object qUpdatepreco: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'preco'
      Origin = 'preco'
    end
    object qUpdatedcadastro: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'dcadastro'
      Origin = 'dcadastro'
    end
    object qUpdatefg_status: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'fg_status'
      Origin = 'fg_status'
      FixedChar = True
      Size = 1
    end
  end
end
