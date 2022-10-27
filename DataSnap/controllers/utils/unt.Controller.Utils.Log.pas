unit unt.Controller.Utils.Log;

interface

Uses
  System.SysUtils, System.Variants, System.Classes;

Type
  TLogCallBack = procedure(pMsg: String; pError: Boolean=false) of object;

  TLogController = class
  private
    class var FLogController: TLogController;
  strict private
    FLog: TLogCallBack;
    class function GetInstance: TLogController; static;
  public
    class property Instance: TLogController read GetInstance;
    property OnLog: TLogCallBack write FLog;
    property Log: TLogCallBack read FLog;
  end;

var
  LogClass: TLogController;

implementation

{ TLogController }

class function TLogController.GetInstance: TLogController;
begin
  if not Assigned(FLogController) then
    FLogController := TLogController.Create;

  Result := FLogController;
end;

end.
