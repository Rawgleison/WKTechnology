unit unt.Controller.Utils.Log;

interface

Uses
  System.SysUtils, System.Variants, System.Classes;

Type
  TLogCallBack = procedure(pMsg: String; pError: Boolean) of object;

  TLogController = class
  private
    class var FLogController: TLogController;
    FLog: TLogCallBack;
    class function GetInstance: TLogController; static;
    procedure SetLog(const Value: TLogCallBack);
  public
    class property Instance: TLogController read GetInstance;
    property OnLog: TLogCallBack write SetLog;
    class procedure Log(pMsg: String; pError: Boolean=False); static;
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

class procedure TLogController.Log(pMsg: String; pError: Boolean);
begin
  if Assigned(FLog) then
    FLog(pMsg,PError);
end;

procedure TLogController.SetLog(const Value: TLogCallBack);
begin
  FLog := Value;
end;

initialization

finalization
  LogClass.Free;

end.
