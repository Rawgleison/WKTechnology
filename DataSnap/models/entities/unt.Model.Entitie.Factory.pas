unit unt.Model.Entitie.Factory;

interface

Uses
  System.SysUtils, System.Variants, System.Classes, unt.Model.Entitie.Pessoa;

Type
  TEntitieFactory = class
  private
    FPessoa: TModelEntitiePessoa;
    { private declarations }
  public
    function Pessoa: TModelEntitiePessoa;
  end;

implementation

{ TEntitieFactory }

function TEntitieFactory.Pessoa: TModelEntitiePessoa;
begin
//  if not Assigned(FPessoa) then
//    FPessoa := TModelEntitiePessoa.cre
end;

end.
