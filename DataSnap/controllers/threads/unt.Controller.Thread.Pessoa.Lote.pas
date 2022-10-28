unit unt.Controller.Thread.Pessoa.Lote;

interface

uses
  System.Classes, System.JSON, ds.Model.Connection.FireDac;

type
  TPessoaThread = class(TThread)
  private
    FJson: TJSONArray;
  protected
    procedure Execute; override;
  public
    property Json: TJSONArray read FJson write FJson;
  end;

implementation

uses
  unt.Model.Entitie.Pessoa, FireDAC.Comp.Client;

{ TPessoaThread }

procedure TPessoaThread.Execute;
const qtdExec = 10000;
var
  qr: TFDQuery;
  ja: TJSONArray;
  lastExec, countExec: Integer;
begin
  NameThreadForDebugging('ThBatchInsert');
  qr := dmConnection.CreateFDQuery;
  try
    dmConnection.fdTransaction.StartTransaction;
    try
      qr.ExecSQL('ALTER TABLE pessoa ADD COLUMN IF NOT EXISTS dscep_tmp character varying(15)');

      qr.SQL.Clear;
      qr.SQL.Add('INSERT INTO pessoa(flnatureza, dsdocumento, nmprimeiro, nmsegundo, dscep_tmp) ' +
                 'VALUES(:flnatureza, :dsdocumento, :nmprimeiro, :nmsegundo, :dscep_tmp) ');

      qr.Params.ArraySize := FJson.Count;
      lastExec := 0;
      countExec := 0;

      for var I := 0 to FJson.Count - 1 do
      begin
        qr.Params[0].AsIntegers[I] := FJson[I].GetValue<Integer>('flnatureza');
        qr.Params[1].AsStrings[I]  := FJson[I].GetValue<String>('dsdocumento');
        qr.Params[2].AsStrings[I]  := FJson[I].GetValue<String>('nmprimeiro');
        qr.Params[3].AsStrings[I]  := FJson[I].GetValue<String>('nmsegundo');
        qr.Params[4].AsStrings[I]  := FJson[I].GetValue<String>('dsdocumento');
        inc(countExec);
        if countExec = qtdExec then
        begin
          qr.Execute(I,lastExec);
          lastExec := I;
          countExec := 0;
        end;
      end;
      if lastExec < qr.Params.ArraySize then
      qr.Execute(qr.Params.ArraySize,lastExec);

      qr.SQL.Clear;
      qr.ExecSQL('INSERT INTO endereco(idpessoa,dscep)' +
                 '(SELECT idpessoa, dscep_tmp FROM pessoa WHERE dscep_tmp IS NOT NULL)');

      qr.SQL.Clear;
      qr.ExecSQL('ALTER TABLE pessoa DROP COLUMN dscep_tmp');

      dmConnection.fdTransaction.Commit
    except
      dmConnection.fdTransaction.Rollback;
      raise;
    end;
  finally
    qr.Free;
  end;
end;

end.
