unit unt.Controller.Entitie.Endereco;

interface

Uses
  System.SysUtils, System.Variants, System.Classes, System.JSON,
  unt.Model.Entitie.Endereco, REST.Json, unt.Model.Entitie.Pessoa;

Type
  IEnderecoController = interface
  ['{386B0D44-F0B2-41AF-BBF0-3C0A6591640E}']
    procedure validarDados(pEndereco: TEndereco; pOperacao: TOperacao);
    function GravarEndereco(pJson: TJSONObject; pOperacao: TOperacao)
      : TJSONObject;
    function insert(pJson: TJSONObject): TJSONObject;
    function update(pJson: TJSONObject): TJSONObject;
    function delete(pId: integer): string;
  end;

  TEnderecoController = class(TInterfacedObject, IEnderecoController)
  public
    function insert(pJson: TJSONObject): TJSONObject;
    function update(pJson: TJSONObject): TJSONObject;
    function delete(pId: integer): String;
    procedure validarDados(pEndereco: TEndereco; pOperacao: TOperacao);
    function GravarEndereco(pJson: TJSONObject; pOperacao: TOperacao)
      : TJSONObject;
  end;

implementation

{ TEnderecoController }

function TEnderecoController.delete(pId: integer): String;
begin
  Result := 'Quantidade de registro apagados: '+TEndereco.delete(pId).ToString;
end;

function TEnderecoController.GravarEndereco(pJson: TJSONObject;
  pOperacao: TOperacao): TJSONObject;
var
  endereco: TEndereco;
begin
  endereco := TJSON.JsonToObject<TEndereco>(pJson);
  try
    validarDados(endereco, pOperacao);
    if pOperacao = TOperacao.INSERT then
      endereco.insert
    else
      endereco.edit;

    Result := TJSON.ObjectToJsonObject(endereco);
  finally
    endereco.Free;
  end;
end;

function TEnderecoController.insert(pJson: TJSONObject): TJSONObject;
begin
  Result := GravarEndereco(pJson,TOperacao.INSERT);
end;

function TEnderecoController.update(pJson: TJSONObject): TJSONObject;
begin
  Result := GravarEndereco(pJson,TOperacao.UPDATE);
end;

procedure TEnderecoController.validarDados(pEndereco: TEndereco;
  pOperacao: TOperacao);
begin
  if pOperacao = TOperacao.UPDATE then
  begin
    if pEndereco.Idendereco < 1 then
      raise Exception.Create('O idendereco deve ser passado.');
  end else
    if pEndereco.Idpessoa < 1 then
      raise Exception.Create('O idpessoa deve ser passado.');

  if pEndereco.Dscep.Length <> 8 then
    raise Exception.Create('O Cep deve conter 8 digitos.[cep '+pEndereco.Dscep);
end;

end.
