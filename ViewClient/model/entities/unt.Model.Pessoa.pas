unit unt.Model.Pessoa;

interface

uses
  System.SysUtils, Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types, dm.Model.Rest,
  System.JSON, REST.Client;

{$M+}

type
  TTipoNatureza = (FISICA = 1,JURIDICA = 2);

  TEndereco = class
  private
    FDscep: string;
    FIdendereco: Integer;
    FIdpessoa: Integer;
  published
    property Dscep: string read FDscep write FDscep;
    property Idendereco: Integer read FIdendereco write FIdendereco;
    property Idpessoa: Integer read FIdpessoa write FIdpessoa;
  public
    procedure insert;
    class procedure delete(pId: integer);
  end;
  
  TPessoa = class(TJsonDTO)
  private
    FDsdocumento: string;
    [SuppressZero]
    FDtregistro: TDateTime;
    [JSONName('enderecos'), JSONMarshalled(False)]
    FEnderecosArray: TArray<TEndereco>;
    [GenericListReflect]
    FEnderecos: TObjectList<TEndereco>;
    FFlnatureza: Integer;
    FIdpessoa: Integer;
    FNmprimeiro: string;
    FNmsegundo: string;
    function GetEnderecos: TObjectList<TEndereco>;
  protected
    function GetAsJson: string; override;
  published
    property Dsdocumento: string read FDsdocumento write FDsdocumento;
    property Dtregistro: TDateTime read FDtregistro write FDtregistro;
    property Enderecos: TObjectList<TEndereco> read GetEnderecos;
    property Flnatureza: Integer read FFlnatureza write FFlnatureza;
    property Idpessoa: Integer read FIdpessoa write FIdpessoa;
    property Nmprimeiro: string read FNmprimeiro write FNmprimeiro;
    property Nmsegundo: string read FNmsegundo write FNmsegundo;
  public
    destructor Destroy; override;
    class function GetAll: TJSONValue; static;
    class function GetById(pId: Integer): TJSONValue; static;
    function insert: TJSONValue;
    function edit: TJSONValue;
    class procedure delete(pId: integer);
    function GetNatureza: TTipoNatureza;
  end;

implementation

uses
  REST.Json;

{ TPessoa }

class procedure TPessoa.delete(pId: integer);
begin
  dmRest.DeleteRequest('pessoa/' + pId.ToString);
end;

destructor TPessoa.Destroy;
begin
  GetEnderecos.Free;
  inherited;
end;

function TPessoa.GetEnderecos: TObjectList<TEndereco>;
begin
  Result := ObjectList<TEndereco>(FEnderecos, FEnderecosArray);
end;

function TPessoa.GetNatureza: TTipoNatureza;
begin
  Result := TTipoNatureza(FFlnatureza);
end;

function TPessoa.insert: TJSONValue;
begin
  Result := dmRest.PutRequest('pessoa',Self.GetAsJson);
end;

function TPessoa.edit: TJSONValue;
begin
  Result := dmRest.PostRequest('pessoa',Self.GetAsJson);
end;

class function TPessoa.GetAll: TJSONValue;
begin
  Result :=  dmRest.GetRequest('pessoa');
end;

function TPessoa.GetAsJson: string;
begin
  RefreshArray<TEndereco>(FEnderecos, FEnderecosArray);
  Result := inherited;
end;

class function TPessoa.GetById(pId: Integer): TJSONValue;
begin
  //Oservidor devolve sempre um array, mesmo buscando pelo id
  //Então voi necessário pegar o primeiro elemento duas vezes
  Result := dmRest.GetRequest('pessoa/'+pId.ToString).A[0].A[0];
end;

{ TEnderecos }

class procedure TEndereco.delete(pId: integer);
begin
  dmRest.DeleteRequest('endereco/'+pId.ToString);
end;

procedure TEndereco.insert;
begin
  dmRest.PutRequest('endereco',TJSON.ObjectToJsonObject(Self).ToJSON);
end;

end.
