program WKDataSnap;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Pkg.Json.DTO in 'helpers\Pkg.Json.DTO.pas',
  unt.UserInterface.Vew in 'views\unt.UserInterface.Vew.pas' {frmUserInterface},
  unt.Web.Module in 'controllers\module\unt.Web.Module.pas' {WebModule1: TWebModule},
  unt.Model.Config.IniFile in 'models\configurations\unt.Model.Config.IniFile.pas',
  unt.Model.Config.DB in 'models\configurations\unt.Model.Config.DB.pas',
  unt.Model.Config.Server in 'models\configurations\unt.Model.Config.Server.pas',
  unt.Model.Config.Factory in 'models\configurations\unt.Model.Config.Factory.pas',
  unt.Controller.Server in 'controllers\service\unt.Controller.Server.pas',
  unt.Model.Entitie.Pessoa in 'models\entities\unt.Model.Entitie.Pessoa.pas',
  unt.Model.Entitie.Endereco in 'models\entities\unt.Model.Entitie.Endereco.pas',
  ds.Model.Connection.FireDac in 'models\connection\ds.Model.Connection.FireDac.pas' {dmConnection: TDataModule},
  unt.Controler.Entitie.Pessoa in 'controllers\entities\unt.Controler.Entitie.Pessoa.pas',
  ClassHelper.StringUtils in 'helpers\ClassHelper.StringUtils.pas',
  DataSetConverter4D.Helper in 'helpers\DataSetConverter\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in 'helpers\DataSetConverter\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in 'helpers\DataSetConverter\DataSetConverter4D.pas',
  DataSetConverter4D.Util in 'helpers\DataSetConverter\DataSetConverter4D.Util.pas',
  unt.Controller.Entitie.Endereco in 'controllers\entities\unt.Controller.Entitie.Endereco.pas',
  Raul in 'helpers\Raul.pas',
  unt.Model.Entitie.Endereco.Integracao in 'models\entities\unt.Model.Entitie.Endereco.Integracao.pas',
  unt.Controller.Utils.Log in 'controllers\utils\unt.Controller.Utils.Log.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmUserInterface, frmUserInterface);
  Application.CreateForm(TdmConnection, dmConnection);
  Application.Run;
end.
