unit unt.Web.Module;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Web.WebFileDispatcher, Web.HTTPProd,
  Datasnap.DSAuth,
  Datasnap.DSProxyJavaScript, IPPeerServer, Datasnap.DSMetadata,
  Datasnap.DSServerMetadata, Datasnap.DSClientMetadata, Datasnap.DSCommonServer,
  Datasnap.DSHTTP, unt.Controller.Utils.Log, Data.DBXCommon,
  Data.DBCommonTypes;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher: TDSHTTPWebDispatcher;
    DSServer: TDSServer;
    DSServerClass: TDSServerClass;
    DSAuthenticationManager: TDSAuthenticationManager;
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManagerUserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DSServerError(DSErrorEventObject: TDSErrorEventObject);
    function DSServerTrace(TraceInfo: TDBXTraceInfo): CBRType;
    procedure DSHTTPWebDispatcherHTTPTrace(Sender: TObject;
      AContext: TDSHTTPContext; ARequest: TDSHTTPRequest;
      AResponse: TDSHTTPResponse);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{$R *.dfm}

uses Web.WebReq, unt.Controller.Server;

procedure TWebModule1.DSAuthenticationManagerUserAuthenticate(Sender: TObject;
  const Protocol, Context, User, Password: string; var valid: Boolean;
  UserRoles: TStrings);
begin
  //Na proposta não solicitava a autenticação, para entregar em tempo ábil
  //decidi não implementar
  valid := true;
end;

procedure TWebModule1.DSHTTPWebDispatcherHTTPTrace(Sender: TObject;
  AContext: TDSHTTPContext; ARequest: TDSHTTPRequest;
  AResponse: TDSHTTPResponse);
begin
  LogClass.Log(ARequest.RemoteIP+'/'+ARequest.Command+'/'+ARequest.Params.Text);
end;

procedure TWebModule1.DSServerClassGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := Service;
end;

procedure TWebModule1.DSServerError(DSErrorEventObject: TDSErrorEventObject);
begin
  LogClass.Log(DSErrorEventObject.Error.ClassName+': '+DSErrorEventObject.Error.Message);
end;

function TWebModule1.DSServerTrace(TraceInfo: TDBXTraceInfo): CBRType;
begin
  LogClass.Log(TraceInfo.Message);
end;

initialization

finalization

Web.WebReq.FreeWebModules;

end.
