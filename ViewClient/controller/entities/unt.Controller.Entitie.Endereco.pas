unit unt.Controller.Entitie.Endereco;

interface

Uses
  System.SysUtils, System.Variants, System.Classes;

Type
  TEnderecoController = class
  public
    class procedure delete(pId: integer);
    class procedure insert(pIdpessoa, pIdEndereco, pCep: String);
  end;

implementation

uses
  unt.Model.Entitie.Pessoa;

{ TEnderecoController }

class procedure TEnderecoController.insert(pIdpessoa, pIdEndereco, pCep: String);
var
  endereco: TEndereco;
begin
  endereco := TEndereco.Create;
  try
    endereco.Idpessoa := StrToIntDef(pIdpessoa,0);
    endereco.Dscep := pCep;
    endereco.insert;
  finally
    endereco.Free;
  end;
end;

class procedure TEnderecoController.delete(pId: integer);
begin
  TEndereco.delete(pId);
end;


end.
