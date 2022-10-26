object dmRest: TdmRest
  OldCreateOrder = False
  Height = 349
  Width = 408
  object RESTClient: TRESTClient
    ContentType = 'application/json'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 72
    Top = 56
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPUT
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'bodyBE0C9C0388C64EA4BDF12B7215E2B300'
        Value = 
          '{'#13#10'   "flnatureza":1,'#13#10'   "dsdocumento":"35665498755",'#13#10'   "nmpr' +
          'imeiro":"Paulo Vinicius",'#13#10'   "nmsegundo":"Parra Brito",'#13#10'   "en' +
          'derecos":['#13#10'      {'#13#10'         "dscep5":"16201999"'#13#10'      },'#13#10'   ' +
          '   {'#13#10'         "dscep":"16201555"'#13#10'      }'#13#10'   ]'#13#10'}'
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse
    Left = 160
    Top = 48
  end
  object RESTResponse: TRESTResponse
    RootElement = 'result'
    Left = 256
    Top = 48
  end
end
