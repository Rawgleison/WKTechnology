unit unt.Model.Config.Server;

interface

Uses
  System.SysUtils, System.Variants, System.Classes, unt.Model.Config.IniFile;

Type
  TmodelConfigServer = class(TModelConfigIniFile)
  private
    class function GetServerPort: String; static;
    class procedure SetServerPort(const Value: String); static;
    class function GetAutoStart: Boolean; static;
    class procedure SetAutoStart(const Value: Boolean); static;
  public
    class property ServerPort: String read GetServerPort write SetServerPort;
    class property AutoStart: Boolean read GetAutoStart write SetAutoStart;
  end;

const cSection = 'Config';

implementation

{ TmodelConfigServer }

class function TmodelConfigServer.GetAutoStart: Boolean;
begin
  Result := StrToBoolDef(GetValue(cSection, 'AutoStart', 'False'), False);
end;

class function TmodelConfigServer.GetServerPort: String;
begin
  Result := GetValue(cSection, 'ServerPort', '8080')
end;

class procedure TmodelConfigServer.SetAutoStart(const Value: Boolean);
begin
  SetValue(cSection, 'AutoStart', Value.ToString);
end;

class procedure TmodelConfigServer.SetServerPort(const Value: String);
begin
  SetValue(cSection, 'ServerPort', Value);
end;

end.
