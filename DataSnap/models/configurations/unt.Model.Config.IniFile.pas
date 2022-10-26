{----------------------------------------------------------------
  Descrição: Classe Stática para manipulação do arquvo
    de configuração do programa.

  Autor: Rawgleison

  Cração: 24/10/2022
----------------------------------------------------------------}
unit unt.Model.Config.IniFile;

interface

uses
  System.SysUtils, System.Classes, IniFiles;

type
  TModelConfigIniFile = class
  protected
    class function GetValue(pSection, pField, pDef: String): String; static;
    class procedure SetValue(pSection, pField, pValue: String); static;
    class function getFileName: String;
  public

  end;

var
  ConfigFile : TModelConfigIniFile;

implementation

uses
  Vcl.Forms;

{ TModelConfigIniFile }
// Pega o nome do arwuivo
class function TModelConfigIniFile.GetFileName: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'Config.ini';
end;
// Pega um determinado valor de um campo no arquivo ini
class function TModelConfigIniFile.GetValue(pSection, pField, pDef: String): String;
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(getFileName);
  try
    Result := iniFile.ReadString(pSection, pField, pDef);
  finally
    iniFile.Free;
  end;
end;
// Seta o valor em um terminado campo no arquivo ini
class procedure TModelConfigIniFile.SetValue(pSection, pField, pValue: String);
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(getFileName);
  try
    iniFile.WriteString(pSection, pField, pValue);
  finally
    iniFile.Free;
  end;
end;

end.
