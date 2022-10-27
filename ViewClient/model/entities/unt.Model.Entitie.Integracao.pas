unit unt.Model.Entitie.Integracao;

interface

Uses
  System.SysUtils, System.Variants, System.Classes;

Type
  TEnderecoIntegracao = class
  private
  public
    procedure StartIntegracao;
  end;

implementation

uses
  dm.Model.Rest;

{ TEnderecoIntegracao }

procedure TEnderecoIntegracao.StartIntegracao;
begin
  dmRest.PostRequest('integracao','');
end;

end.
