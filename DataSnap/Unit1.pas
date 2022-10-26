unit Unit1;

interface

Uses
  System.SysUtils, System.Variants, System.Classes;

Type
  TClassTeste = class
  private
    FPropDois: String;
    function GetPropUm: Integer;
    procedure SetPropUm(const Value: Integer);
    { private declarations }
  public
    property PropUm: Integer read GetPropUm write SetPropUm;
    property PropDois: String read FPropDois write FPropDois;
  end;

implementation

{ TClassTeste }

function TClassTeste.GetPropUm: Integer;
begin

end;

procedure TClassTeste.SetPropUm(const Value: Integer);
begin

end;

end.
