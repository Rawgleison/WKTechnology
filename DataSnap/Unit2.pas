unit Unit2;

interface

Uses
  System.SysUtils, System.Variants, System.Classes;

Type
  TCliente = class
  private
    Fidade: Integer;
    function GetNome: String;
    procedure SetNome(const Value: String);
    { private declarations }
  public
    { public declarations }
    property Nome: String read GetNome write SetNome;
    property idade: Integer read Fidade write Fidade;
  end;

implementation

{ TCliente }

function TCliente.GetNome: String;
begin

end;

procedure TCliente.SetNome(const Value: String);
begin

end;

end.
