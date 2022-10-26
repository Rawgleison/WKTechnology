unit Raul.Messages;

interface

Uses
  Dialogs, WinAPI.Windows, System.UITypes;

procedure MessageRaul_AVISO(Msg: string);
procedure MessageRaul_ATENCAO(Msg: string);
procedure MessageRaul_ERRO(Msg: string);
function MessageRaul_Confirma(Msg: string): boolean;
function MessageRaul_ATENCAO_Confirma(Msg: string): boolean;
function MessageRaul_ERRO_Confirma(Msg: string): boolean;

implementation

procedure MessageRaul_AVISO(Msg: string);
begin
  MessageDlg(Msg, mtInformation, [mbOK], 0);
end;

{ Simplificador do MessageDialog }
procedure MessageRaul_ATENCAO(Msg: string);
begin
  MessageDlg(Msg, mtWarning, [mbOK], 0);
end;

{ Simplificador do MessageDialog }
procedure MessageRaul_ERRO(Msg: string);
begin
  MessageBeep(MB_ICONERROR);
  MessageDlg(Msg, mtError, [mbOK], 0);
end;

{ Simplificador do MessageDialog }
function MessageRaul_Confirma(Msg: string): boolean;
begin
  Result:=MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

function MessageRaul_ATENCAO_Confirma(Msg: string): boolean;
begin
  Result:=MessageDlg(Msg, mtWarning, [mbYes, mbNo], 0) = mrYes;
end;

{ Simplificador do MessageDialog }
function MessageRaul_ERRO_Confirma(Msg: string): boolean;
begin
  Result:=MessageDlg(Msg, mtError, [mbYes, mbNo], 0) = mrYes;
end;


end.
