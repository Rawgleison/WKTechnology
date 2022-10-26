unit unt.Controller.Server;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth,
    REST.Json, FireDAC.Stan.StorageJSON, Data.DB,
    unt.Controler.Entitie.Pessoa, unt.Controller.Entitie.Endereco;

type
{$METHODINFO ON}
  IService = interface
  ['{BFE84404-7265-4146-AFE2-CC308CD2D1E7}']
    function Ping: string;
    function Pessoa(pId: Integer): TJSONArray;
    function acceptPessoa(Json: TJSONObject): TJSONObject;
    function cancelPessoa(pId: Integer): string;
    function updatePessoa(Json: TJSONObject): TJSONObject;
    function acceptEndereco(pJson: TJSONObject): TJSONObject;
    function updateEndereco(pJson: TJSONObject): TJSONObject;
    function cancelEndereco(pId: Integer): string;
  end;

  Service = class(TComponent, IService)
  private
    FPessoaControl: TPessoaController;
    FEnderecoController: TEnderecoController;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    function Ping: String;
    { Rotas de Pessoa }
    function Pessoa(pId: Integer): TJSONArray; // GET
    function acceptPessoa(Json: TJSONObject): TJSONObject; // PUT insert
    function cancelPessoa(pId: Integer): String; // DELETE
    function updatePessoa(Json: TJSONObject): TJSONObject; // POST edit
    { Rotas endereco }
    function acceptEndereco(pJson: TJSONObject): TJSONObject;
    function updateEndereco(pJson: TJSONObject): TJSONObject;
    function cancelEndereco(pId: Integer): String;
  end;
{$METHODINFO OFF}

implementation

uses
  unt.Model.Entitie.Pessoa;

{ Service }

function Service.acceptEndereco(pJson: TJSONObject): TJSONObject;
begin
  Result :=  FEnderecoController.insert(pJson);
end;

function Service.acceptPessoa(json: TJSONObject): TJSONObject;
begin
  Result := FPessoaControl.insert(json);
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
end;

destructor Service.Destroy;
begin
  FPessoaControl.Free;
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

function Service.updatePessoa(json: TJSONObject): TJSONObject;
begin
  Result := FPessoaControl.update(json);
end;

end.
