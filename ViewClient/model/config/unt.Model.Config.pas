unit unt.Model.Config;

interface

Uses
  System.SysUtils, System.Variants, System.Classes, IniFiles;

Type
  TConfigModel = class
  private
    class function GetFilePath: String;
  public
    class function GetValue(pParamName,pDef: String): String; static;
    class procedure SetValue(pParamName,pValue: String); static;
  end;

var
  ConfigModel: TConfigModel;

implementation

{ TConfigModel }

class function TConfigModel.GetFilePath: String;
begin
  Result := ExtractFilePath(ParamStr(0))+'Config.ini';
end;

class function TConfigModel.GetValue(pParamName,pDef: String): String;
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(GetFilePath);
  try
    Result := iniFile.ReadString('Config',pParamName,pDef);
  finally
    iniFile.Free;
  end;
end;

class procedure TConfigModel.SetValue(pParamName, pValue: String);
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(GetFilePath);
  try
    iniFile.WriteString('Config',pParamName,pValue);
  finally
    iniFile.Free;
  end;
end;

end.
