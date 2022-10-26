unit dm.Model.Rest;

interface

uses
  System.SysUtils, System.Classes, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON;

type
  TdmRest = class(TDataModule)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
  private
    function Request(pTypeReq: TRESTRequestMethod;pClass: String; pBody: String): TJSONValue;
  public
    function GetRequest(pClass: String; pBody: String=''): TJSONValue;
    function PutRequest(pClass: String; pBody: String): TJSONValue;
    function PostRequest(pClass, pBody: String): TJSONValue;
    function DeleteRequest(pClass: String): TJSONValue;

  end;

var
  dmRest: TdmRest;

implementation

uses
  unt.Controller.Config;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmRest }

function TdmRest.DeleteRequest(pClass: String): TJSONValue;
begin
  Result := Request(rmDELETE,pClass,'');
end;

function TdmRest.GetRequest(pClass: String; pBody: String): TJSONValue;
begin
  Result := Request(rmGET,pClass,pBody);
end;

function TdmRest.PostRequest(pClass, pBody: String): TJSONValue;
begin
  Result := Request(rmPOST,pClass,pBody);
end;

function TdmRest.PutRequest(pClass: String; pBody: String): TJSONValue;
begin
  Result := Request(rmPUT,pClass,pBody);
end;

function TdmRest.Request(pTypeReq: TRESTRequestMethod;pClass: String; pBody: String): TJSONValue;
begin
  try
  dmRest.RESTClient.BaseURL := 'http://'+Config.Servidor+':'+Config.Port+'/datasnap/rest/service/'+pClass;
  dmRest.RESTRequest.Method := pTypeReq;
  dmRest.RESTRequest.Params.Clear;
  dmRest.RESTRequest.Params.AddBody(pBody,TRESTContentType.ctAPPLICATION_JSON);
  dmRest.RESTRequest.Execute;

  if dmRest.RESTResponse.Status.Success then
    Result := dmRest.RESTResponse.JSONValue.Clone as TJSONValue
  else
    raise Exception.Create(dmRest.RESTResponse.StatusText+' : ' + dmRest.RESTResponse.Content);
  except on E: Exception do
    raise Exception.Create(E.Message);

  end;

end;

end.
