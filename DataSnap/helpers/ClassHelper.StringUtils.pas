unit ClassHelper.StringUtils;

interface

Uses
  System.SysUtils, System.Variants, System.Classes;

Type
  TStringUltils = record Helper for String
  public
    function SoNumeros: String;
  end;

implementation

{ TStringUltils }

function TStringUltils.SoNumeros: String;
var
  I  : Integer;
  Res: String;
  L  : Char;
begin
  Res  :='';
  for I:=1 to length(Self) do
  begin
    L:=Self[I];
    if (L in (['0' .. '9'])) or (L=#0) then
      Res:=Res + L;
  end;
  Result:=trim(Res);
end;

end.
