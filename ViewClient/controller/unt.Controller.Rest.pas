unit unt.Controller.Rest;

interface

Uses
  System.SysUtils, System.Variants, System.Classes, REST.Json, Json,
  unt.Controller.Config, Data.DB;

Type
  TServer = class
  private
    function GetPessoas(pId: integer): TJSONObject;
  public
  end;

var
  Server: TServer;

implementation

uses
  dm.Model.Rest, REST.Types;

{ TServer }

function TServer.GetPessoas(pId: integer): TJSONObject;
begin

end;

end.
