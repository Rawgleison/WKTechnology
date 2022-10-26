unit unt.Controller.Home;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Raul, Vcl.StdCtrls, REST.Client,
  System.JSON, unt.Model.Pessoa;

type
  TTypeTransiction = (INSERT, EDIT);
  TdmHomeController = class(TDataModule)
    memTblCEP: TFDMemTable;
    memTblCEPidpessoa: TIntegerField;
    memTblCEPidendereco: TIntegerField;
    memTblCEPdscep: TStringField;
    memTablePessoa: TFDMemTable;
    memTablePessoaidpessoa: TIntegerField;
    memTablePessoaflnatureza: TIntegerField;
    memTablePessoadsdocumento: TStringField;
    memTablePessoanmprimeiro: TStringField;
    memTablePessoanmsegundo: TStringField;
    dsPessoa: TDataSource;
    dsCEP: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure VerificarDados(pPessoa: TPessoa; pInserindo: boolean);
  public
    procedure AdicionarCep(pIdpessoa, pIdEndereco, pCep: String; pInsert: Boolean=false);
    procedure insertEndereco(pIdpessoa, pIdEndereco, pCep: String);
    procedure deleteEndereco(pId: integer);
    procedure deletePessoa(pId: integer);
    procedure AtualizarLista;
    function GravarPessoa(pIdpessoa: String; pNatureza: TTipoNatureza; pNmprimeiro,
  pNmsegundo, pdsdocumento: String): TJSONValue;
    function GetPessoa(pId: Integer): TPessoa;

  end;

var
  dmHomeController: TdmHomeController;

implementation

uses
  DataSet.Serialize, REST.Json;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmHomeController.AdicionarCep(pIdpessoa, pIdEndereco, pCep: String; pInsert: Boolean=false);
begin
  pCep := RetiraNaoNumero(pCep);
  if pCep.Length <> 8 then
    raise Exception.Create('O Cep deve conter 8 caracteres.');

  memTblCEP.Filter := 'dscep = '+pCep;
  memTblCEP.Filtered := true;
  try
    if memTblCEP.IsEmpty then
    begin
      if pInsert and (not pIdpessoa.IsEmpty) then
        insertEndereco(pIdpessoa,pIdEndereco,pCep);

      memTblCEP.Append;
      memTblCEP.FieldByName('idpessoa').AsString := pIdpessoa;
      memTblCEP.FieldByName('dscep').AsString := RetiraNaoNumero(pCep);
      memTblCEP.Post;
    end else
      MessageRaul_AVISO('CEP j� informado.');
  finally
    memTblCEP.Filtered := false;
  end;
end;

procedure TdmHomeController.AtualizarLista;
var
  ja: TJSONArray;
begin
  ja := TPessoa.GetAll as TJSONArray;
  memTablePessoa.Close;
  memTablePessoa.LoadFromJSON(ja);
end;

procedure TdmHomeController.DataModuleCreate(Sender: TObject);
begin
  memTblCEP.Open;
  memTablePessoa.Open;
end;

procedure TdmHomeController.deleteEndereco(pId: integer);
begin
  if pid > 0 then
    TEndereco.delete(pId);
  memTblCEP.Delete;
end;

procedure TdmHomeController.deletePessoa(pId: integer);
begin
  TPessoa.delete(pId);
  AtualizarLista;
end;

function TdmHomeController.GetPessoa(pId: Integer): TPessoa;
begin
  Result := TJSON.JsonToObject<TPessoa>(TPessoa.GetById(pId).ToJSON);
end;

function TdmHomeController.GravarPessoa(pIdpessoa: String; pNatureza: TTipoNatureza; pNmprimeiro,
  pNmsegundo, pdsdocumento: String): TJSONValue;
var
  jo: TJSONObject;
  pessoa: TPessoa;
  inserindo: boolean;
begin
  inserindo := pIdpessoa.IsEmpty;

  jo := TJSONObject.Create;
  jo.AddPair('idpessoa',pIdpessoa);
  jo.AddPair('flnatureza' , Ord(pNatureza).ToString);
  jo.AddPair('dsdocumento',pdsdocumento);
  jo.AddPair('nmprimeiro' ,pNmprimeiro);
  jo.AddPair('nmsegundo'  ,pNmsegundo);

  //Somente inser��o, os endere�os s�o inseridos no mesmo endpoint pessoa
  //Na edi��o, pra inserir um novo cep, ou excluir, deve-se usar o endpoit
  //espec�fico endereco
  if inserindo then
    jo.AddPair('enderecos', memTblCEP.ToJSONArray());

  pessoa := TJSON.JsonToObject<TPessoa>(jo.ToJSON);

  VerificarDados(pessoa,inserindo);

  try
    if inserindo then
      Result := pessoa.insert
    else
      Result := pessoa.edit;

    AtualizarLista;
  finally
    pessoa.Free;
  end;
end;


procedure TdmHomeController.insertEndereco(pIdpessoa, pIdEndereco, pCep: String);
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

procedure TdmHomeController.VerificarDados(pPessoa: TPessoa; pInserindo: boolean);
begin
  if not pPessoa.Flnatureza in [1,2] then
    raise Exception.Create('Inconsist�ncia no campo natureza');

   if pPessoa.Dsdocumento.Length < 11 then
    raise Exception.Create('O campo documento deve conter mais de 10 caractres.');

   if pPessoa.Nmprimeiro.IsEmpty then
    raise Exception.Create('O campo primeiro nome deve ser preenchido.');

   if pPessoa.Nmsegundo.IsEmpty then
    raise Exception.Create('O campo sobrenomedeve ser preenchido.');

   if pInserindo and memTblCEP.IsEmpty then
    raise Exception.Create('O registro deve conter pelo menos um CEP.');
end;

end.
