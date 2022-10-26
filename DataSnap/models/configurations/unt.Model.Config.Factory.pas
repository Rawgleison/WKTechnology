unit unt.Model.Config.Factory;

interface

Uses
  System.SysUtils, System.Variants, System.Classes, unt.Model.Config.Server,
  unt.Model.Config.DB;

Type
  TModelConfigFactory = class
  private
    FServer: TmodelConfigServer;
    FDB: TModelConfigDB;
    { private declarations }
  public
    property Server: TmodelConfigServer read FServer;
    property DB: TModelConfigDB read FDB;
  end;

var
  Config: TModelConfigFactory;

implementation

{ TModelConfigFactory }

end.
