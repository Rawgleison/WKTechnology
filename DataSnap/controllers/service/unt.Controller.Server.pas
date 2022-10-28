unit unt.Controller.Server;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth,
    REST.Json, FireDAC.Stan.StorageJSON, Data.DB,
    unt.Controler.Entitie.Pessoa, unt.Controller.Entitie.Endereco,
  unt.Model.Entitie.Endereco.Integracao;

type
{$METHODINFO ON}
  IService = interface
  ['{BFE84404-7265-4146-AFE2-CC308CD2D1E7}']
    function Ping: String;
    { Rotas de Pessoa }
    function Pessoa(pId: Integer): TJSONArray; // GET
    function acceptPessoa(pJson: TJSONObject): TJSONObject; // PUT insert
    function acceptPessoas(pJson: TJSONArray): String; //PUT insert em lote
    function cancelPessoa(pId: Integer): String; // DELETE
    function updatePessoa(Json: TJSONObject): TJSONObject; // POST edit
    { Rotas endereco }
    function acceptEndereco(pJson: TJSONObject): TJSONObject;
    function updateEndereco(pJson: TJSONObject): TJSONObject;
    function cancelEndereco(pId: Integer): String;
    {Rotas Endereco integracao}
    procedure updateIntegracao(pId: Integer);
  end;

  Service = class(TComponent, IService)
  private
    FPessoaControl: TPessoaController;
    FEnderecoController: TEnderecoController;
    entInt: TEnderecoIntegracaoModel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    function Ping: String;
    { Rotas de Pessoa }
    function Pessoa(pId: Integer): TJSONArray; // GET
    function acceptPessoa(pJson: TJSONObject): TJSONObject; // PUT insert
    function acceptPessoas(pJson: TJSONArray): String; //PUT insert em lote
    function cancelPessoa(pId: Integer): String; // DELETE
    function updatePessoa(Json: TJSONObject): TJSONObject; // POST edit
    { Rotas endereco }
    function acceptEndereco(pJson: TJSONObject): TJSONObject;
    function updateEndereco(pJson: TJSONObject): TJSONObject;
    function cancelEndereco(pId: Integer): String;
    {Rotas Endereco integracao}
    procedure updateIntegracao(pId: Integer);
  end;
{$METHODINFO OFF}

implementation

uses
  unt.Model.Entitie.Pessoa,
  unt.Controller.Utils.Log;

{ Service }

function Service.acceptEndereco(pJson: TJSONObject): TJSONObject;
begin
  Result :=  FEnderecoController.insert(pJson);
end;

function Service.acceptPessoa(pJson: TJSONObject): TJSONObject;
begin
  Result := FPessoaControl.insert(pJson);
end;

function Service.acceptPessoas(pJson: TJSONArray): String;
begin
  Result := FPessoaControl.batchInsert(pJson);
end;

function Service.cancelEndereco(pId: Integer): String;
begin
  Result := FEnderecoController.delete(pId);
end;

function  Service.cancelPessoa(pId: Integer): String;
begin
  Result := FPessoaControl.DeletePessoa(pId);
end;

constructor Service.Create(AOwner: TComponent);
begin
  inherited;
  FPessoaControl := TPessoaController.Create;
  LogClass.Log('Service criado');
  entInt := TEnderecoIntegracaoModel.Create;
end;

destructor Service.Destroy;
begin
  FPessoaControl.Free;
  entInt.Free;
  inherited;
end;

function Service.Pessoa(pId: Integer): TJSONArray;
begin
  Result := FPessoaControl.GetPessoas(pId);
end;

function Service.Ping: String;
begin
  Result := 'Pong';
end;

function Service.updateEndereco(pJson: TJSONObject): TJSONObject;
begin
  Result :=  FEnderecoController.update(pJson);
end;

procedure Service.updateIntegracao(pId: Integer);
begin
  if Pid > 0 then
  begin
    entInt.Idendereco := pId;
    entInt.SetEndToDB(false);
  end else
    entInt.ExecuteThread;
end;

function Service.updatePessoa(json: TJSONObject): TJSONObject;
begin
  Result := FPessoaControl.update(json);
end;

end.
