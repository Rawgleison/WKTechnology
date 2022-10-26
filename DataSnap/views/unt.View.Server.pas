unit unt.View.Server;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth,
    REST.Json, FireDAC.Stan.StorageJSON, Data.DB;

type
{$METHODINFO ON}
  Service = class(TComponent)
  private
  public
    function Ping: String;
    function Pessoa(pId: Integer): TDataSet;
    function acceptPessoa(json: TJSONObject):String;
  end;
{$METHODINFO OFF}

implementation

{ Service }

function Service.acceptPessoa(json: TJSONObject): String;
begin

end;

function Service.Pessoa(pId: Integer): TDataSet;
//var
//  PessoaDAO: TPessoaDAO;
begin
//  PessoaDAO := TPessoaDAO.Create;
//  try
//    Result := PessoaDAO.GetPessoas(pId);
//  finally
//    PessoaDAO.Free;
//  end;
end;

function Service.Ping: String;
begin
  Result := 'Pong';
end;

end.

