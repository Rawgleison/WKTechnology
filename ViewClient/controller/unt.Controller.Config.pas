unit unt.Controller.Config;

interface

Uses
  System.SysUtils, System.Variants, System.Classes, unt.Model.Config;

Type
  TConfigController = class
  private
   class function GetServidor: String; static;
   class procedure SetServidor(const Value: String); static;
   class function GetPort: String; static;
   class procedure SetPort(const Value: String); static;
  public
    class property Servidor: String read GetServidor write SetServidor;
    class property Port: String read GetPort write SetPort;
  end;

var
  Config: TConfigController;

implementation

{ TCOnfigController }

class function TConfigController.GetPort: String;
begin
  Result := ConfigModel.GetValue('Port','8080');
end;

class function TCOnfigController.GetServidor: String;
begin
  Result := ConfigModel.GetValue('Servidor','localhost');
end;

class procedure TConfigController.SetPort(const Value: String);
begin
  ConfigModel.SetValue('Port',Value);
end;

class procedure TCOnfigController.SetServidor(const Value: String);
begin
  ConfigModel.SetValue('Servidor',Value);
end;

end.
