unit unt.Model.Config.DB;

interface

uses
  System.SysUtils, System.Classes, IniFiles, unt.Model.Config.IniFile;

type
  TModelConfigDB = class(TModelConfigIniFile)
  private
    class function GetHost: String; static;
    class procedure SetHost(const Value: String); static;
    class function GetPassword: String; static;
    class function GetPort: String; static;
    class function GetUserName: String; static;
    class procedure SetPassword(const Value: String); static;
    class procedure SetPort(const Value: String); static;
    class procedure SetUserName(const Value: String); static;
    class function GetDatabase: String; static;
    class procedure SetDatabase(const Value: String); static;
  public
    class property Host: String read GetHost write SetHost;
    class property Port: String read GetPort write SetPort;
    class property UserName: String read GetUserName write SetUserName;
    class property Password: String read GetPassword write SetPassword;
    class property Database: String read GetDatabase write SetDatabase;
  end;

const cSection = 'PostGreSQL';

implementation

uses
  Vcl.Forms;

{ TModelConfigDB }

class function TModelConfigDB.GetDatabase: String;
begin
  Result := GetValue(cSection,'Database','WKDatabase');
end;

class function TModelConfigDB.GetHost: String;
begin
  Result := GetValue(cSection,'Host','localhost');
end;

class function TModelConfigDB.GetPassword: String;
begin
  Result := GetValue(cSection,'Password','1234');
end;

class function TModelConfigDB.GetPort: String;
begin
  Result := GetValue(cSection,'Port','5432');
end;

class function TModelConfigDB.GetUserName: String;
begin
  Result := GetValue(cSection,'UserName','postgres');
end;

class procedure TModelConfigDB.SetDatabase(const Value: String);
begin
  SetValue(cSection,'Database',Value);
end;

class procedure TModelConfigDB.SetHost(const Value: String);
begin
  SetValue(cSection,'Host',Value);
end;

class procedure TModelConfigDB.SetPassword(const Value: String);
begin
  SetValue(cSection,'Password',Value);
end;

class procedure TModelConfigDB.SetPort(const Value: String);
begin
  SetValue(cSection,'Port',Value);
end;

class procedure TModelConfigDB.SetUserName(const Value: String);
begin
  SetValue(cSection,'UserName',Value);
end;

end.
