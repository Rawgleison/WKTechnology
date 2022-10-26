unit unt.Model.Entitie.Endereco;

interface

uses
  System.SysUtils, System.Classes,
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  IEndereco = interface
  end;

  TEndereco = class
  private
    [JSONName('dscep')]
    FDscep: string;
    [JSONName('idendereco')]
    FIdendereco: Integer;
    [JSONName('idpessoa')]
    FIdpessoa: Integer;
  published
    property Dscep: string read FDscep write FDscep;
    property Idendereco: Integer read FIdendereco write FIdendereco;
    property Idpessoa: Integer read FIdpessoa write FIdpessoa;
  public
    procedure insert;
    procedure edit;
    class function delete(pId: Integer): integer;
  end;

implementation

uses
  Data.DB, FireDAC.Comp.Client, ds.Model.Connection.FireDac;

{ TEndereco }

class function TEndereco.delete(pId: Integer): integer;
begin
  Result := dmConnection.qr.ExecSQL('delete from endereco where idendereco = '+pId.ToString);
end;

procedure TEndereco.edit;
var
  qr: TFDQuery;
begin
  qr := TFDQuery.Create(nil);
  try
    qr.Connection := dmConnection.Connection;
    qr.Open('select * from endereco where idendereco = '+fidendereco.ToString);
    if qr.RecordCount=0 then
      raise Exception.Create('CEP não encontrado na base de ados com o idendereco '+idendereco.ToString);
    qr.Edit;
    qr.FieldByName('dscep').AsString := Dscep;
    qr.Post;
    Idpessoa := qr.FieldByName('idpessoa').AsInteger;
  finally
    qr.Free;
  end;
end;

procedure TEndereco.insert;
var
  qr: TFDQuery;
begin
  qr := TFDQuery.Create(nil);
  try
    qr.Connection := dmConnection.Connection;
    qr.Open('select * from endereco where 1=2');
    qr.FieldByName('idendereco').AutoGenerateValue := arAutoInc;
    qr.Insert;
    qr.FieldByName('idpessoa').AsInteger := Idpessoa;
    qr.FieldByName('dscep').AsString := Dscep;
    qr.Post;
    Idendereco := qr.FieldByName('idendereco').AsInteger;
  finally
    qr.Free;
  end;
end;

end.
