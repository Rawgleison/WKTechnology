unit ds.Model.Connection.FireDac;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin, System.JSON, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.Text;

type
  TdmConnection = class(TDataModule)
    Connection: TFDConnection;
    fdTransaction: TFDTransaction;
    qr: TFDQuery;
    FDBatchMoveTextReader1: TFDBatchMoveTextReader;
    procedure ConnectionBeforeConnect(Sender: TObject);
  private
    procedure ReadParam;
  public
    { Public declarations }
    function JsonToDataset(json: TJSONObject): string;
    function DataSetToJSON(pDataSet : TDataset) : TJSONArray;
    function CreateFDQuery: TFDQuery;
    function GetLastId(pSeqName: String): Integer;
    function GetNextId(pSeqName: String): integer;
  end;

var
  dmConnection: TdmConnection;

implementation

uses
  unt.Model.Config.Factory;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConnection.ConnectionBeforeConnect(Sender: TObject);
begin
  ReadParam;
end;

function TdmConnection.JsonToDataset(json: TJSONObject): string;
var
  qr: TFDQuery;
begin
//  try
//    fdTransaction.StartTransaction;
//    tblPessoa.Open;
//    TConverter.New.JSON(json).ToStructure(tblPessoa);
//    tblPessoa.Last;
//    result := tblPessoa.FieldByName('idpessoa').AsString;
//    fdTransaction.Commit;
//  except
//    fdTransaction.Rollback;
//  end;
end;

procedure TdmConnection.readParam;
begin
  Connection.Params.Values['Server']   := Config.DB.host;
  Connection.Params.Values['Port']     := Config.DB.Port;
  Connection.Params.Values['UserName'] := Config.DB.UserName;
  Connection.Params.Values['Password'] := Config.DB.Password;
  Connection.Params.Values['Database'] := Config.DB.Database;
end;

function TdmConnection.CreateFDQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Connection;
  Result.Transaction := fdTransaction;
end;

function TdmConnection.DataSetToJSON(pDataSet : TDataset) : TJSONArray;
Var
  JObject  : TJSONObject;
  i        : Integer;
begin
  Result   := TJSONArray.Create;
  pDataSet.First;
  while Not(pDataSet.Eof) do
  begin
    JObject := TJSONObject.Create;
    for var Field in pDataSet.Fields do
      JObject.AddPair(Field.FieldName, TJSONString.Create(Field.AsString));

    Result.AddElement(JObject);
    pDataSet.Next;
  end;
end;

//Busca o ultimo id da sequencia passada
function TdmConnection.GetLastId(pSeqName: String): Integer;
var
  qr: TFDQuery;
begin
  qr := CreateFDQuery;
  try
    qr.Open('select last_value id from ' + pSeqName);
    Result := qr.FieldByName('id').AsInteger;
  finally
    qr.Free;
  end;
end;

function TdmConnection.GetNextId(pSeqName: String): integer;
var
  qr: TFDQuery;
begin
  qr := CreateFDQuery;
  try
    qr.Open('select nextval(''pessoa_idpessoa_seq''::regclass) id from pessoa_idpessoa_seq;');
    Result := qr.FieldByName('id').AsInteger;
  finally
    qr.Free;
  end;
end;

end.
