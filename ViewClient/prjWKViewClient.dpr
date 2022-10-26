program prjWKViewClient;

uses
  Vcl.Forms,
  frm.View.Home in 'view\frm.View.Home.pas' {frmHome},
  dm.Model.Rest in 'model\rest\dm.Model.Rest.pas' {dmRest: TDataModule},
  unt.Model.Config in 'model\config\unt.Model.Config.pas',
  unt.Controller.Config in 'controller\unt.Controller.Config.pas',
  DataSet.Serialize.Config in 'helpers\serialize\DataSet.Serialize.Config.pas',
  DataSet.Serialize.Consts in 'helpers\serialize\DataSet.Serialize.Consts.pas',
  DataSet.Serialize.Export in 'helpers\serialize\DataSet.Serialize.Export.pas',
  DataSet.Serialize.Import in 'helpers\serialize\DataSet.Serialize.Import.pas',
  DataSet.Serialize.Language in 'helpers\serialize\DataSet.Serialize.Language.pas',
  DataSet.Serialize in 'helpers\serialize\DataSet.Serialize.pas',
  DataSet.Serialize.UpdatedStatus in 'helpers\serialize\DataSet.Serialize.UpdatedStatus.pas',
  DataSet.Serialize.Utils in 'helpers\serialize\DataSet.Serialize.Utils.pas',
  Raul in 'helpers\Raul\Raul.pas',
  unt.Controller.Home in 'controller\unt.Controller.Home.pas' {dmHomeController: TDataModule},
  unt.Model.Pessoa in 'model\entities\unt.Model.Pessoa.pas',
  Pkg.Json.DTO in 'helpers\Pkg.Json.DTO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TdmRest, dmRest);
  Application.CreateForm(TdmHomeController, dmHomeController);
  Application.Run;
end.