unit unt.Controler.Entitie.Pessoa;

interface

Uses
  System.SysUtils, System.Variants, System.Classes,
  System.JSON, unt.Model.Entitie.Pessoa;

Type
  IPessoaController = interface
  ['{78A105E5-8C5B-4015-B188-F95651F56296}']
    function insert(pJson: TJSONObject): TJSONObject;
    function batchInsert(pJson: TJSONArray): String;
    function update(pJson: TJSONObject): TJSONObject;
    function GetPessoas(pId: Integer): TJSONArray;
    function DeletePessoa(pId: Integer): string;
    function GravaPessoa(pJson: TJSONObject; pOperacao: TOperacao): TJSONObject;
    function ValidarDados(pPessoa: TPessoa; pOperacao: TOperacao): boolean;
  end;

  TPessoaController = class(TInterfacedObject, IPessoaController)
  public
    function insert(pJson: TJSONObject): TJSONObject;
    function batchInsert(pJson: TJSONArray): String;
    function update(pJson: TJSONObject): TJSONObject;
    function GetPessoas(pId: Integer): TJSONArray;
    function DeletePessoa(pId: Integer): string;
    function GravaPessoa(pJson: TJSONObject; pOperacao: TOperacao): TJSONObject;
    function ValidarDados(pPessoa: TPessoa; pOperacao: TOperacao): boolean;
  end;

implementation

uses
  REST.Json, Raul, unt.Controller.Utils.Log;

{ TPessoaController }

function TPessoaController.batchInsert(pJson: TJSONArray): String;
begin
  LogClass.Log('Inicando inserção em Lote de '+pJson.Count.ToString+' registros.');
  TPessoa.BatchInsert(pJson);
  LogClass.Log('Inserção em lote finalizada');
  Result := 'Gravando '+pJson.Count.ToString+' registros no banco. Em breve estarão na base de dados.';
end;

function TPessoaController.deletePessoa(pId: Integer): string;
begin
  if pId < 1 then
    raise Exception.Create('Um id pessoa deve ser pasado.');

    Result := 'Quantidade de registro apagados: '+TPessoa.delete(pId).ToString;

end;

function TPessoaController.GetPessoas(pId: Integer): TJSONArray;
begin
  Result := TPessoa.GetPessoas(pId);
end;

function TPessoaController.GravaPessoa(pJson: TJSONObject; pOperacao: TOperacao): TJSONObject;
var
  pessoa: TPessoa;
  resp: string;
begin
  if pJson.TryGetValue<String>('dtregistro',resp) then
    pJson.RemovePair('dtregistro');
  pessoa := TJSON.JsonToObject<TPessoa>(pJson);
  try
    validarDados(pessoa, pOperacao);

    if pOperacao = TOperacao.INSERT then
      pessoa.insert
    else
      pessoa.edit;

    Result := TJSON.ObjectToJsonObject(pessoa);

    if pOperacao = TOperacao.UPDATE then
      Result.RemovePair('enderecos');
  finally
    pessoa.Free;
  end;
end;

function TPessoaController.insert(pJson: TJSONObject): TJSONObject;
begin
    Result := GravaPessoa(pJson,TOperacao.INSERT);
end;

function TPessoaController.update(pJson: TJSONObject): TJSONObject;
begin
  Result := GravaPessoa(pJson,TOperacao.UPDATE);
end;

function TPessoaController.validarDados(pPessoa: TPessoa; pOperacao: TOperacao): boolean;
begin
  if pOperacao = TOperacao.INSERT then
  begin
    if pPessoa.Enderecos.Count = 0 then
      raise Exception.Create('Ao menos um CEP deve ser passado.');

    if not (pPessoa.Flnatureza in [1,2]) then
      raise Exception.Create('A natureza da pessoa deve ser 1 = Física ou 2 = Jurídica.');

    for var endereco in pPessoa.Enderecos do
    begin
      if  endereco.Dscep.Length <> 8 then
        raise Exception.Create('O CEP deve conter 8 caracteres somente números.');
    end;
  end else    //Se for UPDATE
  begin
    if pPessoa.Enderecos.Count > 0 then
      raise Exception.Create('Para editar uma pessoa, o CEP não deve ser passado.'+#13+
                              ' Para inserir, excluir ou editar um CEP, use o endpoint \cep.');

    if pPessoa.Idpessoa = 0 then
      raise Exception.Create('O idpessoa deve ser passado.');

    if not (pPessoa.Flnatureza in [0,1,2]) then
      raise Exception.Create('A natureza da pessoa deve ser 1 = Física ou 2 = Jurídica.');
  end;

  if pPessoa.Dsdocumento.Length > 20 then
    raise Exception.Create('O documento não pode passar de 20 caracteres.');

  if pPessoa.Nmprimeiro.Length > 100 then
    raise Exception.Create('O primeiro nome não pode passar de 100 caracteres.');

  if pPessoa.Nmsegundo.Length > 100 then
    raise Exception.Create('O segundo nome não pode passar de 100 caracteres.');
end;

end.
