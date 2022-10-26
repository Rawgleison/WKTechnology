unit unt.UserInterface.Vew;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, IdGlobal, Web.HTTPApp,
  Vcl.ExtCtrls, IniFiles, Vcl.ComCtrls, IdComponent, unt.Model.Config.Factory;

type
  TfrmUserInterface = class(TForm)
    ButtonStart: TButton;
    edtServerPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    gbDBConfig: TGroupBox;
    edtConnectionHost: TLabeledEdit;
    edtConnectionPorta: TLabeledEdit;
    edtConnectionUserName: TLabeledEdit;
    edtConnectionPassword: TLabeledEdit;
    chkInicioAutomatico: TCheckBox;
    edtConnectionDatabase: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    procedure StopService;
    procedure saveConnectionParam;
    procedure readConnectionParam;
  end;

var
  frmUserInterface: TfrmUserInterface;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession, unt.Model.Config.Server,
  unt.Model.Config.DB;

procedure TfrmUserInterface.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Caption := iif(Fserver.Active,'Stop','Start');
  gbDBConfig.Enabled := not FServer.Active;
  edtServerPort.Enabled := not FServer.Active;
end;


procedure TfrmUserInterface.ButtonStartClick(Sender: TObject);
begin
  if FServer.Active then
    StopService
  else
    StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TfrmUserInterface.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  saveConnectionParam;
end;

procedure TfrmUserInterface.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TfrmUserInterface.FormShow(Sender: TObject);
begin
  readConnectionParam;
  if chkInicioAutomatico.Checked then
    StartServer;
end;

procedure TfrmUserInterface.readConnectionParam;
begin
  chkInicioAutomatico.Checked := Config.Server.AutoStart;
  edtServerPort.Text          := Config.Server.ServerPort;
  edtConnectionHost.Text      := Config.DB.Host;
  edtConnectionPorta.Text     := Config.DB.Port;
  edtConnectionUserName.Text  := Config.DB.UserName;
  edtCOnnectionPassword.Text  := Config.DB.Password;
  edtConnectionDatabase.Text  := Config.DB.Database;
end;

procedure TfrmUserInterface.saveConnectionParam;
begin
  Config.Server.AutoStart  := chkInicioAutomatico.Checked;
  Config.Server.ServerPort := edtServerPort.Text;
  Config.DB.Host           := edtConnectionHost.Text;
  Config.DB.Port           := edtConnectionPorta.Text;
  Config.DB.UserName       := edtConnectionUserName.Text;
  Config.DB.Password       := edtConnectionPassword.Text;
  Config.DB.Database       := edtConnectionDatabase.Text;
end;

procedure TfrmUserInterface.StartServer;
begin
  if FServer.Active then
    Exit;
  saveConnectionParam;
  FServer.Bindings.Clear;
  FServer.DefaultPort := StrToInt(edtServerPort.Text);
  FServer.Active := True;
end;

procedure TfrmUserInterface.StopService;
begin
  if not FServer.Active then
    Exit;
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

end.
