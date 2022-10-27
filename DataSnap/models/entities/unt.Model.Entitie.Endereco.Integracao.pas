unit unt.Model.Entitie.Endereco.Integracao;

interface

Uses
  System.SysUtils, System.Variants, System.Classes, System.Types,
  REST.Client, ds.Model.Connection.FireDac, REST.Json.Types, REST.Json;

Type
  TEnderecoIntegracaoModel = class
  private
    FIdendereco: Integer;
    FDsuf: String;
    FNmcidade: String;
    FNmbairro: String;
    FNmlogradouro: String;
    FDscomplemento: String;
    FCEP: String;
    { private declarations }
  published
    property Idendereco: Integer read FIdendereco write FIdendereco;
    property Dsuf: String read FDsuf write FDsuf;
    property Nmcidade: String read FNmcidade write FNmcidade;
    property Nmbairro: String read FNmbairro write FNmbairro;
    property Nmlogradouro: String read FNmlogradouro write FNmlogradouro;
    property Dscomplemento: String read FDscomplemento write FDscomplemento;
    property CEP: String read FCEP write FCEP;
  public
    function GetEndFromCep: Boolean;
    procedure upsert(pIgnore: Boolean);
    procedure SetEndToDB(pIgnore: Boolean);
    procedure SetAllEndToDB(pIgnore: Boolean);
    procedure ExecuteThread;
  end;

implementation

uses
  FireDAC.Comp.Client, System.JSON, unt.Controller.Utils.Log;

{ TEnderecoIntegracaoModel }

procedure TEnderecoIntegracaoModel.ExecuteThread;
begin
  TThread.CreateAnonymousThread(
  procedure
  var
    ei: TEnderecoIntegracaoModel;
  begin
    LogClass.Log('Iniciando processo de integração');
    ei := TEnderecoIntegracaoModel.Create;
    try
      ei.SetAllEndToDB(false);
    finally
      ei.Free;
    end;
    LogClass.Log('processo de integração finalizado');
  end
  ).Start;
end;

function TEnderecoIntegracaoModel.GetEndFromCep: Boolean;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  jo: TJSONObject;
begin
  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  try
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTClient.BaseURL :=  'https://viacep.com.br/ws/'+FCEP+'/json';
    RESTRequest.Execute;

    result := RESTResponse.Status.Success;

    if result then
    begin
      jo := RESTResponse.JSONValue as TJSONObject;
      FDsuf          := jo.GetValue('uf').ToString;
      FNmbairro      := jo.GetValue('bairro').ToString;
      FNmcidade      := jo.GetValue('localidade').ToString;
      FNmlogradouro  := jo.GetValue('logradouro').ToString;
      FDscomplemento := jo.GetValue('complemento').ToString;
    end;
//     else
//     raise Exception.Create(RESTResponse.StatusText);


  finally
    RESTClient.Free;
    RESTRequest.Free;
    RESTResponse.Free;
//    jo.Free;
  end;

end;

procedure TEnderecoIntegracaoModel.SetAllEndToDB(pIgnore: Boolean);
var
  qr: TFDQuery;
begin
  qr := dmConnection.CreateFDQuery;
  try
    qr.Open('select idendereco, dscep from endereco');
    while not qr.Eof do
    begin
      FIdendereco := qr.FieldByName('idendereco').AsInteger;
      FCEP := qr.FieldByName('dscep').AsString;
      if GetEndFromCep then
        upsert(pIgnore);
      qr.Next;
    end;
  finally
    qr.Free;
  end;
end;

procedure TEnderecoIntegracaoModel.SetEndToDB(pIgnore: Boolean);
var
  qr: TFDQuery;
begin
  qr := dmConnection.CreateFDQuery;
  try
    qr.Open('select dscep from endereco where idendereco = '+Fidendereco.ToString);
    FCEP := qr.FieldByName('dscep').AsString;
    if GetEndFromCep then
      upsert(pIgnore);
  finally
    qr.Free;
  end;
end;


//Procedimento que tenta inserir um registro
//se já existir com o idendereco ele pode ignorar se o parametro pIgnore for true
//ou editar caso contrário
procedure TEnderecoIntegracaoModel.upsert(pIgnore: Boolean);
var
  qr: TFDQuery;
begin
  qr := dmConnection.CreateFDQuery;
  try
    qr.SQL.Add('INSERT INTO endereco_integracao');
    qr.SQL.Add('(idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento) ');
    qr.SQL.Add('VALUES(:idendereco, :dsuf, :nmcidade, :nmbairro, :nmlogradouro, :dscomplemento) ');
    qr.SQL.Add('ON CONFLICT (idendereco) ');

    if pIgnore  then
      qr.SQL.Add('DO NOTHING')
    else
    begin
      qr.SQL.Add('DO UPDATE SET ');
      qr.SQL.Add('dsuf = excluded.dsuf, ');
      qr.SQL.Add('nmcidade = excluded.nmcidade, ');
      qr.SQL.Add('nmbairro = excluded.nmbairro, ');
      qr.SQL.Add('nmlogradouro = excluded.nmlogradouro, ');
      qr.SQL.Add('dscomplemento = excluded.dscomplemento ');
    end;

    qr.ParamByName('idendereco').AsInteger := FIdendereco;
    qr.ParamByName('dsuf').AsString := FDsuf;
    qr.ParamByName('nmcidade').AsString := FNmcidade;
    qr.ParamByName('nmbairro').AsString := Nmbairro;
    qr.ParamByName('nmlogradouro').AsString := Nmlogradouro;
    qr.ParamByName('dscomplemento').AsString := Dscomplemento;
    qr.Execute();
  finally
    qr.Free;
  end;
end;

end.
