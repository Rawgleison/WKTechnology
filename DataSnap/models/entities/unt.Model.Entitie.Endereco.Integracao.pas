unit unt.Model.Entitie.Endereco.Integracao;

interface

Uses
  System.SysUtils, System.Variants, System.Classes,
  REST.Client;

Type
  TEnderecoIntegracaoModel = class
  private
    { private declarations }
  public
    function GetEndFromCep(pCep: String):Boolean;
  end;

implementation

{ TEnderecoIntegracaoModel }

function TEnderecoIntegracaoModel.GetEndFromCep(pCep: String): Boolean;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
begin
  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  try
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTClient.BaseURL :=  'https://viacep.com.br/ws/'+pCep+'/json';
  finally
    RESTClient.Free;
    RESTRequest.Free;
    RESTResponse.Free;
  end;

end;

end.
