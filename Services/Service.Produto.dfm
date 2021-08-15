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
  end
  inherited qUpdate: TFDQuery
    SQL.Strings = (
      'SELECT * FROM produto')
  end
end
