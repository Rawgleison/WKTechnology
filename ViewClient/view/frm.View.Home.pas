unit frm.View.Home;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, REST.Types, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin,
  Vcl.Buttons, Raul, Vcl.Menus, Vcl.ExtDlgs;

type
  TMyDBGrid = class(TDBGrid);
  TipoNatureza = (FISICA,JURIDICA);
  TfrmHome = class(TForm)
    PageControl1: TPageControl;
    tsCadPessoa: TTabSheet;
    tsOpcoes: TTabSheet;
    GroupBox1: TGroupBox;
    edtServidor: TLabeledEdit;
    edtPorta: TLabeledEdit;
    pnlCadPessoa: TPanel;
    Panel4: TPanel;
    pnlCamposCadPessoa: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtnmprimeiro: TLabeledEdit;
    edtnmsegundo: TLabeledEdit;
    cbNatureza: TComboBox;
    medtDoc: TMaskEdit;
    pnlAddCep: TPanel;
    pnlActionsCadPessoa: TPanel;
    btnGravarPessoa: TBitBtn;
    dbgCep: TDBGrid;
    btnAddCep: TBitBtn;
    edtCep: TMaskEdit;
    Label3: TLabel;
    Panel7: TPanel;
    DBGrid1: TDBGrid;
    pnlActionsListaPessoas: TPanel;
    btnAtualizar: TBitBtn;
    edtIdPessoa: TLabeledEdit;
    ppmCEP: TPopupMenu;
    Excluir1: TMenuItem;
    btnCancelarPessoa: TBitBtn;
    ppmPessoa: TPopupMenu;
    Excluir2: TMenuItem;
    btnIntegracao: TBitBtn;
    btnImportação: TBitBtn;
    OpenTextFileDialog1: TOpenTextFileDialog;
    TabSheet1: TTabSheet;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    procedure cbNaturezaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnGravarPessoaClick(Sender: TObject);
    procedure btnAddCepClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtServidorExit(Sender: TObject);
    procedure edtPortaExit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure btnCancelarPessoaClick(Sender: TObject);
    procedure Excluir2Click(Sender: TObject);
    procedure btnIntegracaoClick(Sender: TObject);
    procedure btnImportaçãoClick(Sender: TObject);
  private
    procedure LerConfig;
    procedure ClearFields;
    procedure carregarPessoa(id: integer);
  public

  end;

var
  frmHome: TfrmHome;

implementation

uses
  dm.Model.Rest, System.JSON, unt.Controller.Config,
  unt.Controller.Home, REST.Client, unt.Model.Entitie.Pessoa, REST.JsonReflect;

{$R *.dfm}

procedure TfrmHome.btnAddCepClick(Sender: TObject);
begin
  dmHomeController.AdicionarCep(edtIdPessoa.Text,'' , edtCep.Text, true);
  edtCep.Clear;
  edtCep.SetFocus;
end;

procedure TfrmHome.btnAtualizarClick(Sender: TObject);
begin
  dmHomeController.AtualizarLista;
end;

procedure TfrmHome.btnCancelarPessoaClick(Sender: TObject);
begin
  ClearFields;
end;

procedure TfrmHome.btnGravarPessoaClick(Sender: TObject);
var
  resp: TRESTResponse;
begin
  dmHomeController.GravarPessoa(
   edtIdPessoa.Text,
   TTipoNatureza(cbNatureza.Items.Objects[cbNatureza.ItemIndex]),
   edtnmprimeiro.Text,
   edtnmsegundo.Text,
   medtDoc.Text
  );
  ClearFields;
  cbNatureza.SetFocus;
end;

procedure TfrmHome.btnImportaçãoClick(Sender: TObject);
begin
  if OpenTextFileDialog1.Execute then
    Memo1.Text := dmHomeController.CsvToJson(OpenTextFileDialog1.FileName).Format();
end;

procedure TfrmHome.btnIntegracaoClick(Sender: TObject);
begin
  dmHomeController.StartIntegracao;
  MessageRaul_AVISO('Integração iniciada');
end;

procedure TfrmHome.carregarPessoa(id: integer);
var
  pessoa: TPessoa;
begin
  pessoa := TPessoa.Create;
  try
    pessoa := dmHomeController.GetPessoa(id);
    edtIdPessoa.Text := pessoa.Idpessoa.ToString;
    cbNatureza.ItemIndex := cbNatureza.Items.IndexOfObject(TObject(pessoa.GetNatureza));
    edtnmprimeiro.Text := pessoa.Nmprimeiro;
    edtnmsegundo.Text := pessoa.Nmsegundo;
    medtDoc.Text := pessoa.Dsdocumento;
    dmHomeController.memTblCEP.EmptyDataSet;
    for var endereco in pessoa.Enderecos do
    begin
      dmHomeController.AdicionarCep(
          endereco.Idpessoa.ToString,
          endereco.Idendereco.ToString,
          endereco.Dscep);
    end;
  finally
    pessoa.Free;
  end;
end;

procedure TfrmHome.cbNaturezaChange(Sender: TObject);
begin
  if TipoNatureza(cbNatureza.ItemIndex) = FISICA then
    medtDoc.EditMask := '999\.999\.999\-99;1;_'
  else
    medtDoc.EditMask := '99\.999\.999\/9999\-99;1;_';
end;

procedure TfrmHome.ClearFields;
begin
  edtIdPessoa.Clear;
 cbNatureza.ItemIndex := 0;
 edtnmprimeiro.Clear;
 edtnmsegundo.Clear;
 medtDoc.Clear;
 if dmHomeController.memTblCEP.Active then
   dmHomeController.memTblCEP.EmptyDataSet;
end;

procedure TfrmHome.DBGrid1DblClick(Sender: TObject);
begin
  carregarPessoa(dmHomeController.memTablePessoa.FieldByName('idpessoa').AsInteger);
end;

procedure TfrmHome.edtPortaExit(Sender: TObject);
begin
  edtPorta.Text := Config.Port;
end;

procedure TfrmHome.edtServidorExit(Sender: TObject);
begin
  COnfig.Servidor := edtServidor.Text;
end;

procedure TfrmHome.Excluir1Click(Sender: TObject);
begin
  dmHomeController.deleteEndereco(dmHomeController.memTblCEP.FieldByName('idendereco').AsInteger);
end;

procedure TfrmHome.Excluir2Click(Sender: TObject);
begin
  dmHomeController.deletePessoa(dmHomeController.memTablePessoa.FieldByName('idpessoa').AsInteger);
  ClearFields;
end;

procedure TfrmHome.FormCreate(Sender: TObject);
begin
  cbNatureza.Items.Clear;
  cbNatureza.AddItem('Física',TObject(TTipoNatureza.FISICA));
  cbNatureza.AddItem('Jurídica',TObject(TTipoNatureza.JURIDICA));
  PageControl1.TabIndex := 0;
end;

procedure TfrmHome.FormShow(Sender: TObject);
begin
  LerConfig;
//  dmHomeController.AtualizarLista;
  ClearFields;
  cbNatureza.SetFocus;
//  TMyDBGrid(dbgCep).DefaultRowHeight := 28;
end;

procedure TfrmHome.LerConfig;
begin
  edtServidor.Text := Config.Servidor;
  edtPorta.Text := Config.Port;

end;

end.
