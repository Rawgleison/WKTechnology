unit unt.Model.Entitie.Pessoa;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types,
  Data.DB, System.JSON, unt.Model.Entitie.Endereco,
  DataSetConverter4D.Helper, idGlobal, Raul, FireDAC.Stan.Intf;

{$M+}

type
  TNatureza = (FISICA, JURIDICA);
  TOperacao = (INSERT, UPDATE);

  TPessoa = class(TJsonDTO)
  private
    FDsdocumento: string;
    FDtregistro: TDateTime;
    [JSONName('enderecos'), JSONMarshalled(False)]
    FEnderecosArray: TArray<TEndereco>;
    [GenericListReflect]
    FEnderecos: TObjectList<TEndereco>;
    FFlnatureza: Integer;
    FIdpessoa: Integer;
    FNmprimeiro: string;
    FNmsegundo: string;
    function GetEnderecos: TObjectList<TEndereco>;
  private
  protected
    function GetAsJson: string; override;
    procedure AtualizaDados(pId: Integer);
  published
    property Idpessoa: Integer read FIdpessoa write FIdpessoa;
    property Flnatureza: Integer read FFlnatureza write FFlnatureza;
    property Dsdocumento: string read FDsdocumento write FDsdocumento;
    property Nmprimeiro: string read FNmprimeiro write FNmprimeiro;
    property Nmsegundo: string read FNmsegundo write FNmsegundo;
    property Dtregistro: TDateTime read FDtregistro write FDtregistro;
    property Enderecos: TObjectList<TEndereco> read GetEnderecos;
  public
    constructor Create(json: TJSONObject); overload;
    destructor Destroy; override;

    procedure insert;
    procedure edit;

    class function GetPessoas(pId: Integer): TJSONArray; static;
    class function delete(pId: Integer): Integer; static;
    class procedure BatchInsert(pJson: TJSONArray);
//    class procedure CsvToInsert(pJson: TJSON)
  end;

  IPessoa = interface
  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils, ds.Model.Connection.FireDac, REST.Json;

{ TRoot }

procedure TPessoa.AtualizaDados(pId: Integer);
var
  qr: TFDQuery;
begin
  qr := dmConnection.CreateFDQuery;
  try
    qr.Open('select * from pessoa where idpessoa = '+pId.ToString);
    FIdpessoa    := qr.FieldByName('idpessoa').AsInteger;
    FFlnatureza  := qr.FieldByName('flnatureza').AsInteger;
    FDsdocumento := qr.FieldByName('dsdocumento').AsString;
    FNmprimeiro  := qr.FieldByName('nmprimeiro').AsString;
    FNmsegundo   := qr.FieldByName('nmsegundo').AsString;
    FDtregistro  := qr.FieldByName('dtregistro').AsDateTime;
    qr.Close;
  finally
    qr.Free;
  end;
end;

constructor TPessoa.Create(json: TJSONObject);
begin
  Self.SetAsJson(json.ToJSON);
end;

destructor TPessoa.Destroy;
begin
  GetEnderecos.Free;
  inherited;
end;

function TPessoa.GetEnderecos: TObjectList<TEndereco>;
begin
  Result := ObjectList<TEndereco>(FEnderecos, FEnderecosArray);
end;


class function TPessoa.delete(pId: Integer): Integer;
var
  qr: TFDQuery;
begin
  qr := dmConnection.CreateFDQuery;
  try
    result := qr.ExecSQL('delete from pessoa where idpessoa = ' + pId.ToString);
  finally
    qr.Free;
  end;
end;

procedure TPessoa.edit;
var
  qr: TFDQuery;
begin
  qr := dmConnection.CreateFDQuery;
  try
    dmConnection.fdTransaction.StartTransaction;
    try
      qr.Open('select * from pessoa where idpessoa = ' + idpessoa.ToString);

      if qr.RecordCount = 0 then
        raise Exception.Create('Pessoa não encontrada com o id '+idpessoa.ToString);

      qr.Edit;
      if FFlnatureza > 0 then
        qr.FieldByName('flnatureza').AsInteger := FFlnatureza;
      if not FDsdocumento.IsEmpty then
        qr.FieldByName('dsdocumento').AsString := FDsdocumento;
      if not FNmprimeiro.IsEmpty then
       qr.FieldByName('nmprimeiro').AsString := FNmprimeiro;
      if not FNmsegundo.IsEmpty then
        qr.FieldByName('nmsegundo').AsString := FNmsegundo;
      qr.Post;

      dmConnection.fdTransaction.Commit;

      AtualizaDados(Idpessoa);
    except
      dmConnection.fdTransaction.Rollback;
      raise;
    end;
  finally
    qr.Free;
  end;end;

function TPessoa.GetAsJson: string;
begin
  RefreshArray<TEndereco>(FEnderecos, FEnderecosArray);
  Result := inherited;
end;

//Função estática que retorna a lista ou um registro de pessoas contendo o endereco
class function TPessoa.GetPessoas(pId: Integer): TJSONArray;
var
  sql: String;
  jsonStr: String;
  qr: TFDQuery;
begin
  //O Json é criado pelo próprio banco
  //sei que gera acoplamento, mas é pra sair mais rápido
  //em uma situação normal, eu geraria usando query
  sql :=
  'select json_agg(row_to_json(t)) pessoas    ' +
  'from (select pe.*,                         ' +
  '(select json_agg(row_to_Json(en))          ' +
  'from endereco en                           ' +
  'where en.idpessoa = pe.idpessoa) enderecos ' +
  'from pessoa pe) t                          ' ;

  //Se vier o id então retorna sómente um registro
  if pId > 0 then
    sql := sql + 'where idpessoa = ' + pId.ToString;

  qr := dmConnection.CreateFDQuery;
  try
    qr.Open(sql);

    //O Sql retorna apenas um campo, contendo o json
    jsonStr := qr.Fields[0].AsString;

    //Convertendo a string json em Array Json
    Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(jsonStr),0) As TJSONArray;
  finally
    qr.Free;
  end;
end;

procedure TPessoa.insert;
var
  qr: TFDQuery;
begin
  qr := dmConnection.CreateFDQuery;
  try
    dmConnection.fdTransaction.StartTransaction;
    try
      qr.Open('select * from pessoa where 1=2');
      qr.FieldByName('idpessoa').AutoGenerateValue := arAutoInc;
      qr.FieldByName('dtregistro').AutoGenerateValue := arAutoInc;

      qr.Append;
      qr.FieldByName('flnatureza').AsInteger := FFlnatureza;
      qr.FieldByName('dsdocumento').AsString := FDsdocumento;
      qr.FieldByName('nmprimeiro').AsString := FNmprimeiro;
      qr.FieldByName('nmsegundo').AsString := FNmsegundo;
      qr.Post;
      idpessoa := qr.FieldByName('idpessoa').AsInteger;
      Dtregistro := qr.FieldByName('dtregistro').AsDateTime;

      qr.Close;
      qr.Open('select * from endereco where idpessoa = '+idpessoa.ToString);
      qr.FieldByName('idendereco').AutoGenerateValue := arAutoInc;

      for var endereco in FEnderecos do
      begin
        endereco.Idpessoa := Idpessoa;
        endereco.insert;
      end;
      dmConnection.fdTransaction.Commit;
    except
      dmConnection.fdTransaction.Rollback;
      raise;
    end;
  finally
    qr.Free;
  end;
end;

class procedure TPessoa.BatchInsert(pJson: TJSONArray);
const qtdExec = 10000;
var
  qr: TFDQuery;
  ja: TJSONArray;
  lastExec, countExec: Integer;
begin
  qr := dmConnection.CreateFDQuery;
  try
    dmConnection.fdTransaction.StartTransaction;
    try
      qr.ExecSQL('ALTER TABLE pessoa ADD COLUMN IF NOT EXISTS dscep_tmp character varying(15)');

      qr.SQL.Clear;
      qr.SQL.Add('INSERT INTO pessoa(flnatureza, dsdocumento, nmprimeiro, nmsegundo, dscep_tmp) ' +
                 'VALUES(:flnatureza, :dsdocumento, :nmprimeiro, :nmsegundo, :dscep_tmp) ');

      qr.Params.ArraySize := pJson.Count;
      lastExec := 0;
      countExec := 0;

      for var I := 0 to pJson.Count - 1 do
      begin
        qr.Params[0].AsIntegers[I] := pJson[I].GetValue<Integer>('flnatureza');
        qr.Params[1].AsStrings[I]  := pJson[I].GetValue<String>('dsdocumento');
        qr.Params[2].AsStrings[I]  := pJson[I].GetValue<String>('nmprimeiro');
        qr.Params[3].AsStrings[I]  := pJson[I].GetValue<String>('nmsegundo');
        qr.Params[4].AsStrings[I]  := pJson[I].GetValue<String>('dsdocumento');
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
