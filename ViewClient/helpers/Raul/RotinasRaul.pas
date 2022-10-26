unit RotinasRaul;

interface

Uses System.Classes, System.UITypes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.Windows, System.SysUtils,
  FireDAC.Comp.Client, System.IniFiles, ShellApi, Vcl.filectrl, Vcl.Samples.Gauges, Vcl.Graphics,
  Vcl.ExtCtrls, Vcl.Mask, JvValidateEdit, IdHTTP, JvEdit, WinSvc,
  IdBaseComponent, IdComponent                                              // Units Genéricas do Indy
    , IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL // Objeto SSL
    , IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP                             // Objeto SMTP
    , IdMessage                      // Objeto de Mensagem
    , IdAttachmentFile, Vcl.StdCtrls // Objeto de Arquivos Anexos
    , Vcl.Grids, ComObj, System.Variants, System.Win.Registry, untAutoUpdate, TLHelp32, ShlObj,
  Data.DB, Vcl.Printers, Messages, REST.Types,

  untDM_RotinasRaul;

type
  TChars = set of Char;

const
  iwNaoIniciar       = 0;
  iwIniciarAllUser   = 1;
  iwIniciarAtualUser = 2;
  iwVerificar        = 3;

  { Simplificador do MessageDialog }
procedure MessageRaul_AVISO(Msg: string);
procedure MessageRaul_ATENCAO(Msg: string);
procedure MessageRaul_ERRO(Msg: string);
function MessageRaul_Confirma(Msg: string): boolean;
function MessageRaul_ATENCAO_Confirma(Msg: string): boolean;
function MessageRaul_ERRO_Confirma(Msg: string): boolean;

{ Retona a Versão do Executável }
function VersaoEXE(ExeName: String = ''): string;

{ Função que criptografa e descriptografa uma string }
function CriptoGramRaul(sSource: String; bDecrypt: boolean = False; iTableSize: Integer = 94): String;

{ Função que criptografa com o padrão GigaERP }
function gigacriptografa(acao, fonte, contrachave: String): string;

function Crypt_(Action, Src: String): String;

{ Filtra caracteres inválidos }
function FilterChars(const S: string; const ValidChars: TChars): string;

{ Função que completa uma string com zeros a esquerda }
function StrZeros(text: string; nqtde: Integer): string;

{ Função que completa uma string com um carac a esquerda }
function StrCarac(text: string; Carac: Char; nqtde: Integer): string;

{ Função que completa uma string com um caractere a direita }
function StrCaracDir(text: string; Carac: Char; nqtde: Integer): string;

{ Função que retorna a quantidade de dias do Mes }
function DiasPorMes(Ano, Mes: Integer): Integer;

{ Repete uma Cadeia de Caracteres }
function REPL(Caractere: Char; nCaracteres: Integer): string;

{ Tira todos os Espaços em Branco da String }
function AllTrim(InString: string): string;

{ Função que Verifica se o ano é Bi-Sexto }
function AnoBiSexto(Ano: Integer): boolean;

{ Tira os Espaços à Esquerda de uma String }
function LTrim(text: string): string;

{ Tira os Zeros à Esquerda de uma String }
function LTiraZeros(text: string): string;

{ Alinha à Direita }
function Rtrim(text: string): string;

{ Função que completa um campo de data }
function FiltraData(Data: String): string;

{ Função que converte Booleano em Inteiro (True=1 e False=0) }
function BoolToInt(Bool: boolean): Integer;

{ Função que converte Inteiro em Booleano (1=True e 0=False) }
function IntToBool(I: Integer): boolean;

{ Função que verifica se existe uma Barra "\" no final de um caminho de pasta
  e se não tiver ela coloca }
function VerifBarra(Path: String): String;

{ Pega parametros do arquivo GigaERP.ini }
procedure ConectaGigaERP(var Conexao: TFDConnection; ArqPath: String = '');

{ Pega parametros do arquivo GigaERP.ini }
procedure GetConfigConnectGigaERP(var Conexao: TFDConnection; ArqPath: String = '');

{ Pega parametros do arquivo .ini
  precisa conter apenas os parametros
  Database(com server/porta:caminhoDB),
  Password e User_Name }
procedure ConectaFireBird(var Conexao: TFDConnection; ArqName: String = '');

{ Conecta ao banco MySQL }
procedure ConectaMySQL(var Conexao: TFDConnection; ArqPath: String = ''; Cript: boolean = False);

{ Executa programa externo e aguarda até que o mesmo seja finalizado }
function ExecAndWait(const FileName, Params: string; const WindowState: Word): boolean;

{ Procedimento para renomear diretorio }
procedure RenameDir(DirFrom, DirTo: string);

{ Função que limpa uma pasta, e confere se a pasta ficou vazia }
function limparPasta(pasta: String): boolean;

{ Função para apagar uma pasta inteira }
function DeleteFolder(FolderName: String; LeaveFolder: boolean): boolean;

function CopyFiles(Source, Destination: string; Gauge: TGauge; sLabel: TLabel): boolean;

{ Retira todo o caractere que não é um número }
function RetiraNaoNumero(Str: String; Desc: Char = #0): String;

{ Libera memoria }
procedure TrimAppMemorySize;

{ Rotina que coloca mascara no campo telefone de acordo com o tipo de numero passado
  Telefone ou Celular com ou sem DDD e Nono digito }
function ColocaMacaraTelefone(Tel: String): string;
procedure ColocaMacaraTelefoneOnChange(Sender: TObject);

{ Coloca a mascara de acordo com o documento passado CPF ou CNPJ }
function ColocaMascaraDOC(DOC: string): string;
procedure ColocaMAscaraDOCOnChange(Sender: TObject);

{Coloca mascara de CEP}
function ColoaMascaraCEP(CEP: String):String;
procedure ColocaMascaraCEPOnChange(Sender: TObject);

{ Retira os acentos de uma string }
function Retira_Acento(Str: string): string;

{ Retorna o codigo da tabela ASCII }
function AsciiToInt(Caracter: Char): Integer;

{ Rotina para Teste e Calculo do Digito Verificador CPF }
function ECPF(Numero: string): boolean;

{ Rotina que altera cor do Edit, quando entra e quando sai do mesmo }
procedure AlteraCor(var Sender: TObject; Entra: boolean);

{ Função que verifica a licença da GP Informatica }
function VerificaLicenca(CNPJ_CPF: String): Boolean;

{ Função que verifica se a aplicação é Free }
function VerificaFREE: boolean;

{ Comando if then simplificado }
function SE(Cond: boolean; SeVerd, SeFalso: Variant): Variant;

{ COALESCE do Firebird porem de string }
function CoalesceStr(Str, NullStr: String): String;

{ Retorna o status de um serviço }
Function GetStatusWinService(const sWinService: string; const sComputerName: string = ''): Integer;

{ Rotina que Envia Email }
function EnviarEmail(aHost: String; aPort: Integer; aLogin, aSenha, aListaEmail, aAssunto, aCorpo: String; anexo: TStringList; aAuth, aAuthSSL: boolean): boolean;

{ Rotina que abre um arquivo excel em um StringGrid }
function XlsToStringGrid(XStringGrid: TStringGrid; xFileXLS: string; var Gauge: TGauge; var Lab: TLabel; ColFixo: boolean = False): boolean;

// Procedimento que coloca o programa para iniciar com o Windows
function IniciarComWindows(Func: Integer; Param: string = ''): Integer;

{ Extrai só os 3 ultimos digitos da versão do
  arquivo paar comparação }
function VersaoInt(Versao: String): Integer;

{Extrai o código do app pela versão.}
function CodApp: String;

{ Retorna a versão atual e o link pra download de uma palicação GP }
function versaoAtual(var Versao, link: String; COD_APP: Integer): boolean;

{ Converte a data no formato MySQL (yyy-mm-dd hh:mm:ss) para formato padrão (dd/mm/yyyy hh:mm:ss) }
function datahoraMysql(Data: String): string;

{ Procedimento que gera o autoupdate da aplicação }
procedure autoupdate;

// Checa apenas se tem uma nova versão, mas não atualiza, usado para botão
function ChecaVersaoSimple: String;

{ Função que testa a conexão com a internet }
function TesteInternet: String;

{ Função que retorna a data de modificação de um arquivo }
function dataModifArq(const TheFile: string): string;

{ Lista arquivos de um diretório e subdiretórios em um TMemo passado }
procedure ListarArquivos(Diretorio: string; Sub: boolean; var Lista: TStringList);

// Matar Processos
function KillTask(ExeFileName: string): Integer;

// Funcção que para um serviço do windos e retorna se deu certo ou não
function ServiceStop(sMachine, sService: string): boolean;

// Função de inicia um serviço do windows e retona se foi executado com sucesso.
function ServiceStart(sMachine, sService: string): boolean;

// Função que converte um número inteiro segundos em formato hh:mm:ss
function SegundosToTime(Segundos: Cardinal): String;

// Retona a quantidade de vezes que um subtexto apareceu no texto
function CountPos(const subtext: string; text: string): Integer;

// Função que retorna um caminho da pasta do windows de acordo com o parametro passado
// usa as constantes inciadas com CSIDL, declarar ShlObj na Uses
function GetSpecialFolderPath(CSIDLFolder: Integer): string;

{ Retorna a SQL gerada pela query com os parametros }
function QueryToLog(Q: TFDQuery): string;

{ Verifica se um processo está rodando no gerenciador de tarefas }
function ProcessExists(ExeFileName: string): boolean;

{ Retorna o nome da impressora padrão do Windows }
function GetDefaultPrinterName: string;

{ Define a impressoa padrão pelo nome
  Em caso de impressão temporária, usar com GetDefaultPrinterName }
procedure SetDefaultPrinter(PrinterName: String);

{ Procedimento que le as configuração de conexão do arquivo ini e seção passados }
procedure LerConfigDB(con: TFDConnection; ArqIniName: string; Section: String);

// Le a tag passada
function LerTag(XML, Tag: String): String;

// Seta O texto em uma tag passada
function SetTag(Str, Tag: String): String;

//Usado no lugar do http, tanto para POST (rmPOST), quanto para Get (rmGET)
function restGET(url: String; rm: TRESTRequestMethod; post: TStringList=nil): string;

function GetOSVersion(var MajorVersion, MinorVersion, Build: DWORD) : String;

function TrataLinkHttps(Link: string): string;

//Modifica as datas de um arquivo
function SetFileDateTime(FileName: string; CreateTime, ModifyTime, AcessTime: TDateTime): Boolean;

//Clareia uma Cor
function GetHighlightColor(BaseColor: TColor): TColor;

//Escurece uma cor
function GetShadowColor(BaseColor: TColor): TColor;

//Inverte uma Cor
function InverteColor(const Cor: TColor): TColor;

implementation

uses
  untDMLicenca, REST.Client;

  { Simplificador do MessageDialog }

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

{ Retona a Versão do Executável }
function VersaoEXE(ExeName: String): string;
var
  Dummy               : Cardinal;
  BufferSize, Len     : Integer;
  Buffer              : PChar;
  LoCharSet, HiCharSet: Word;
  Translate, Return   : Pointer;
  StrFileInfo         : string;
  iLastError: DWord;
begin
  if ExeName = '' then
    ExeName :=Application.ExeName;
  BufferSize:=GetFileVersionInfoSize(PChar(ExeName), Dummy);
  if BufferSize <> 0 then
  begin
    GetMem(Buffer, Succ(BufferSize));
    try
    try
      if GetFileVersionInfo(PChar(ExeName), 0, BufferSize, Buffer) then
        if VerQueryValue(Buffer, '\VarFileInfo\Translation', Translate, UINT(Len)) then
        begin
          LoCharSet  :=LoWord(Longint(Translate^));
          HiCharSet  :=HiWord(Longint(Translate^));
          StrFileInfo:=Format('\StringFileInfo\0%x0%x\%s', [LoCharSet, HiCharSet, 'FileVersion']);
          if VerQueryValue(Buffer, PChar(StrFileInfo), Return, UINT(Len)) then
            Result:=strpas(PChar(Return));
        end;
    except
      Result:='';
    end;
    finally
      FreeMem(Buffer, Succ(BufferSize));
    end;
  end
  else
  begin
    iLastError := GetLastError;
    raise Exception.Create(Format('GetFileVersionInfo failed: (%d) %s',
                  [iLastError, SysErrorMessage(iLastError)]));
  end;
end;

{ Função que criptografa e decriptografa uma string }
function CriptoGramRaul(sSource: String; bDecrypt: boolean = False; iTableSize: Integer = 94): String;
var
  I, iPosText, iPosKey: Integer;
  sTable, sKey        : string;
begin
  try
    sKey:=inttostr(length(Trim(sSource)));
    if (length(Trim(sSource)))=0 then
    begin
      Result:='';
      Exit;
    end;
    // Criar nossa Tabela Cipher
    I:=32;
    While I <= (iTableSize + 32) do
    Begin
      sTable:=ConCat(sTable, Chr(I));
      inc(I);
    end;

    // Adicione a chave do mesmo tamanho ou maior que o de origem
    while length(sSource) >= length(sKey) do
      sKey:=ConCat(sKey, sKey);

    // Remover linha Feed & Carrage retorna de Cipher
    I:=0;
    while I <= length(sSource) do
      if (sSource[I] = Chr(10)) or (sSource[I] = Chr(13)) then
        Delete(sSource, I, 1)
      else
        inc(I);

    { Uncomment if you need to remove spaces
      //Remove Spaces from Cipher
      i:=0;
      while i<=Length(sSource) do
      if (sSource[i]=' ')  then
      Delete(sSource, i, 1)
      else
      Inc(i);
    }

    // Vegenere Encryption/Decryption routine
    I:=1;
    while I <= length(sSource) do
    Begin
      iPosText:=pred(pos(sSource[I], sTable));
      iPosKey :=pred(pos(sKey[I], sTable));
      // Encrypt or Decrypt(Default is Encrypt)
      Case bDecrypt of
        False:
          Result:=Result + sTable[((iPosText + iPosKey) mod iTableSize) + 1];
        True:
          Result:=Result + sTable[(((iPosText + iTableSize) - iPosKey) mod iTableSize) + 1];
      end;
      inc(I);
    end;
  Except
    on E: Exception do
      Result:='***' + E.Message + '***';
  end;
end;

{ Função que criptografa com o padrão GigaERP
EX: gigacriptografa('C',Senha,'')}
function gigacriptografa(acao, fonte, contrachave: String): string;
var
  key       : String;
  dest      : String;
  keyLen    : Integer;
  keyPos    : Integer;
  offset    : Integer;
  I         : Integer;
  arrayFonte: String;
  arrayKey  : String;
  fonteASCII: Integer;
  hexa      : String;
begin
  Result:='';
  if fonte = '' then
    Exit;
  key       :=contrachave + '%G1&g@$Tr#0n%*MM4A4VZYW9KHJUI2347EJHJKDF3425SKL';
  dest      :='';
  keyLen    :=length(key);
  keyPos    :=-1;
  arrayFonte:=fonte;
  arrayKey  :=key;
  if (UpperCase(acao) = 'C') then // criptografar
  begin
    // $offSet = rand(0, $range);
    offset:=0;
    dest  :='0' + intToHex(offset, 1);
    for I :=0 to length(fonte) - 1 do
    begin
      fonteASCII:=((Ord(arrayFonte[I + 1]) + offset) mod 255); // resto da divisão
      if (keyPos <= keyLen) then
        inc(keyPos)
      else
        keyPos  :=1;
      fonteASCII:=fonteASCII xor Ord(arrayKey[keyPos + 1]); // xor
      hexa      :=intToHex(fonteASCII, 1);
      if (length(hexa) < 2) then
        hexa:='0' + hexa;
      offset:=fonteASCII;
      dest  :=dest + hexa;
    end;
    Result:=UpperCase(dest);
  end;
end;

function Crypt_(Action, Src: String): String;
Label Fim;
var
  keyLen   : Integer;
  keyPos   : Integer;
  offset   : Integer;
  dest, key: String;
  SrcPos   : Integer;
  SrcAsc   : Integer;
  TmpSrcAsc: Integer;
  range    : Integer;
begin
  if (Src = '') Then
  begin
    Result:='';
    Goto Fim;
  end;
  key   :='%G1&g@\$Tr#0n%*MM4A4VZYW9KHJUI2347EJHJKDF3425SKL';
  dest  :='';
  keyLen:=length(key);
  keyPos:=0;
  range :=256;
  if (Action = UpperCase('C')) then
  begin
    Randomize;
    offset    :=Random(range);
    dest      :=Format('%1.2x', [offset]);
    for SrcPos:=1 to length(Src) do
    begin
      SrcAsc:=(Ord(Src[SrcPos]) + offset) Mod 255;
      if keyPos < keyLen then
        keyPos:=keyPos + 1
      else
        keyPos:=1;
      SrcAsc  :=SrcAsc Xor Ord(key[keyPos]);
      dest    :=dest + Format('%1.2x', [SrcAsc]);
      offset  :=SrcAsc;
    end;
  end
  Else if (Action = UpperCase('D')) then
  begin
    offset:=StrToInt('$' + copy(Src, 1, 2));
    SrcPos:=3;
    repeat
      SrcAsc:=StrToInt('$' + copy(Src, SrcPos, 2));
      if (keyPos < keyLen) Then
        keyPos:=keyPos + 1
      else
        keyPos :=1;
      TmpSrcAsc:=SrcAsc Xor Ord(key[keyPos]);
      if TmpSrcAsc <= offset then
        TmpSrcAsc:=255 + TmpSrcAsc - offset
      else
        TmpSrcAsc:=TmpSrcAsc - offset;
      dest       :=dest + Chr(TmpSrcAsc);
      offset     :=SrcAsc;
      SrcPos     :=SrcPos + 2;
    until (SrcPos >= length(Src));
  end;
  Result:=dest;
Fim:
end;

function FiltraData(Data: String): string;
var
  wDia, wMes, wAno: Word;
  sDia, sMes, sAno: string;
begin
  DecodeDate(Date, wAno, wMes, wDia); // Data atual
  sDia:=FilterChars(trim(copy(Data, 1, 2)), ['0' .. '9']);
  sMes:=FilterChars(trim(copy(Data, 4, 2)), ['0' .. '9']);
  sAno:=FilterChars(trim(copy(Data, 7, 4)), ['0' .. '9']);

  if (sAno = '') then
    sAno:=inttostr(wAno)
  else if (length(sAno) <> 4) then
  begin
    if (length(sAno) <= 2) then
    begin
      if StrToInt(sAno) <= 20 then
        sAno:=inttostr(2000 + StrToInt(sAno))
      else
        sAno:=inttostr(1900 + StrToInt(sAno));
    end
    else
      sAno:=inttostr(wAno);
  end;

  if (sMes = '') or (StrToInt(sMes) = 0) or (StrToInt(sMes) > 12) then
    sMes:=StrZeros(inttostr(wMes), 2)
  else if StrToInt(sMes) <> 0 then
    sMes:=StrZeros(sMes, 2);
  if (sDia = '') or (StrToInt(sDia) = 0) then
    sDia:=StrZeros(inttostr(wDia), 2)
  else if (StrToInt(sDia) > DiasPorMes(StrToInt(sAno), StrToInt(sMes))) then
    sDia:=inttostr(DiasPorMes(StrToInt(sAno), StrToInt(sMes)))
  else if StrToInt(sDia) <> 0 then
    sDia:=StrZeros(sDia, 2);
  Data  :=sDia + '/' + sMes + '/' + sAno;
  Result:=Data;
end;

{ Filtra caracteres inválidos }
function FilterChars(const S: string; const ValidChars: TChars): string;
var
  I: Integer;
begin
  Result:='';
  for I :=1 to length(S) do
    if S[I] in ValidChars then
      Result:=Result + S[I];
end;

{ Função que completa uma string com zeros a esquerda }
function StrZeros(text: string; nqtde: Integer): string;
begin
  text    :=trim(text);
  StrZeros:=REPL('0', nqtde - length(text)) + text;
end;

{ Função que completa uma string com um caractere a esquerda }
function StrCarac(text: string; Carac: Char; nqtde: Integer): string;
begin
  text    :=trim(text);
  StrCarac:=REPL(' ', nqtde - length(text)) + text;
end;

{ Função que completa uma string com um caractere a direita }
function StrCaracDir(text: string; Carac: Char; nqtde: Integer): string;
begin
  text       :=trim(text);
  StrCaracDir:=text + REPL(' ', nqtde - length(text));
end;

{ Função que retorna a quantidade de dias do Mes }
function DiasPorMes(Ano, Mes: Integer): Integer;
const
  DiasNoMes: array [1 .. 12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result:=DiasNoMes[Mes];
  if (Mes = 2) and AnoBiSexto(Ano) then
    inc(Result);
end;

{ Repete uma Cadeia de Caracteres }
function REPL(Caractere: Char; nCaracteres: Integer): string;
var
  n        : Integer;
  CadeiaCar: string;
begin
  CadeiaCar  :='';
  for n      :=1 to nCaracteres do
    CadeiaCar:=CadeiaCar + Caractere;
  Result     :=CadeiaCar;
end;

{ Tira todos os Espaços em Branco da String }
function AllTrim(InString: string): string;
begin
  Result:=StringReplace(InString, ' ', '', [rfReplaceAll, rfIgnoreCase]);
end;

{ Função que Verifica se o ano é Bi-Sexto }
function AnoBiSexto(Ano: Integer): boolean;
begin
  Result:=(Ano mod 4 = 0) and ((Ano mod 100 <> 0) or (Ano mod 400 = 0));
end;

{ Tira os Espaços à Esquerda de uma String }
function LTrim(text: string): string;
var
  n: Integer;
begin
  for n:=1 to length(text) do
  begin
    if copy(text, n, 1) <> ' ' then
      break;
    Delete(text, n, 1);
  end;
  Result:=text;
end;

{ Tira os Zeros à Esquerda de uma String }
function LTiraZeros(text: string): string;
var
  n  : Integer;
  Str: string;
begin
  Str  :=text;
  for n:=1 to length(text) do
  begin
    if copy(text, 1, 1) <> '0' then
      break;
    Delete(text, 1, 1);
  end;
  Result:=text;
end;

{ Alinha à Direita }
function Rtrim(text: string): string;
var
  n: Integer;
begin
  for n:=length(text) downto 1 do
  begin
    if copy(text, n, 1) <> ' ' then
      break;
    Delete(text, n, 1);
  end;
  Result:=text;
end;

{ Função que converte Booleano em Inteiro (True=1 e False=0) }
function BoolToInt(Bool: boolean): Integer;
begin
  if Bool then
    Result:=1
  else
    Result:=0;
end;

{ Função que converte Inteiro Booleano (1=True e 0=False) }
function IntToBool(I: Integer): boolean;
begin
  Result:=I = 1;
end;

{ Função que verifica se existe uma Barra "\" no final de um caminho de pasta
  e se não tiver ela coloca }
function VerifBarra(Path: String): String;
var
  Rede: boolean;
begin
  Path:=Path + '\';
  Rede:=(copy(Path, 1, 2) = '\\');
  Path:=StringReplace(Path, '\\', '\', [rfReplaceAll, rfIgnoreCase]);
  if Rede then
    Result:='\' + Path
  else
    Result:=Path;
end;

{ Pega parametros do arquivo GigaERP.ini }
procedure ConectaGigaERP(var Conexao: TFDConnection; ArqPath: String = '');
var
  ArqIni                : TIniFile;
  DataBase, Port, Server: String;
begin
  try
    if ArqPath = '' then
      ArqPath:=ExtractFilePath(Application.ExeName);
    ArqPath  :=VerifBarra(ArqPath);
    ArqPath  :=ArqPath + 'GigaERP.ini';
    if not FileExists(ArqPath) then
      raise Exception.Create('Arquivo de configuração não encontrado' + #13 + 'Arquivo: ' + ArqPath);
    ArqIni:=TIniFile.Create(ArqPath);
    try
      Conexao.Params.text               :='Database=' + #13 + 'User_Name=sysdba' + #13 + 'Password=*****' + #13 + 'Server=LocalHost' + #13 + 'Port=3060' + #13 + 'DriverID=FB' + #13 + 'Pooled=False';
      DataBase                          :=ArqIni.ReadString('DB_CONF', 'Database', '');
      Server                            :=copy(DataBase, 1, pos('/', DataBase) - 1);
      Port                              :=copy(DataBase, pos('/', DataBase) + 1, 4);
      DataBase                          :=copy(DataBase, pos(':', DataBase) + 1, length(DataBase));
      Conexao.Params.Values['Server']   :=Server;
      Conexao.Params.Values['Port']     :=Port;
      Conexao.Params.Values['Database'] :=DataBase;
      Conexao.Params.Values['User_Name']:=ArqIni.ReadString('DB_CONF', 'User_Name', '');
      Conexao.Params.Values['Password'] :=ArqIni.ReadString('DB_CONF', 'Password', '');
      // if not FileExists(DataBase) then
      // raise Exception.Create('Banco de dados não encontrado. '+DataBase);
      Conexao.Open();
    finally
      ArqIni.Free;
    end;

  except
    on E: Exception do
      raise Exception.Create('[URotinasRaul.ConectaGigaERP]' + #13 + E.Message);
  end;
end;

{ Pega parametros do arquivo GigaERP.ini }
procedure GetConfigConnectGigaERP(var Conexao: TFDConnection; ArqPath: String = '');
var
  ArqIni                : TIniFile;
  DataBase, Port, Server: String;
begin
  try
    if ArqPath = '' then
      ArqPath:=ExtractFilePath(ParamStr(0));
    ArqPath  :=VerifBarra(ArqPath);
    ArqPath  :=ArqPath + '\GigaERP.ini';
    if not FileExists(ArqPath) then
      raise Exception.Create('Arquivo de configuração não encontrado' + #13 + 'Arquivo: ' + ArqPath);
    ArqIni:=TIniFile.Create(ArqPath);
    try
      Conexao.Params.text               :='Database=        ' + #13 +
                                          'User_Name=sysdba ' + #13 +
                                          'Password=*****   ' + #13 +
                                          'Server=LocalHost ' + #13 +
                                          'Port=3060        ' + #13 +
                                          'DriverID=FB      ' + #13 +
                                          'Pooled=False     ';
      DataBase                          :=ArqIni.ReadString('DB_CONF', 'Database', '');
      Server                            :=copy(DataBase, 1, pos('/', DataBase) - 1);
      Port                              :=copy(DataBase, pos('/', DataBase) + 1, 4);
      DataBase                          :=copy(DataBase, pos(':', DataBase) + 1, length(DataBase));
      Conexao.Params.Values['Server']   :=Server;
      Conexao.Params.Values['Port']     :=Port;
      Conexao.Params.Values['Database'] :=DataBase;
      Conexao.Params.Values['User_Name']:=ArqIni.ReadString('DB_CONF', 'User_Name', '');
      Conexao.Params.Values['Password'] :=ArqIni.ReadString('DB_CONF', 'Password', '');
    finally
      ArqIni.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create(E.UnitName+ #13 + E.Message);
  end;
end;

{ Pega parametros do arquivo .ini
  precisa conter apenas os parametros
  Database(com server/porta:caminhoDB),
  Password e User_Name }
procedure ConectaFireBird(var Conexao: TFDConnection; ArqName: String = '');
var
  ArqIni                : TIniFile;
  DataBase, Port, Server: String;
begin
  if trim(ArqName) = '' then
    ArqName:=StringReplace(Application.ExeName, '.exe', '.ini', [rfIgnoreCase]);
  if not FileExists(ArqName) then
    raise Exception.Create('Arquivo de configuração não encontrado' + #13 + 'Arquivo: ' + ArqName);
  ArqIni:=TIniFile.Create(ArqName);
  try
    Conexao.Params.text               :='Database=' + #13 + 'User_Name=sysdba' + #13 + 'Password=*****' + #13 + 'Server=LocalHost' + #13 + 'Port=3060' + #13 + 'DriverID=FB' + #13 + 'Pooled=False';
    DataBase                          :=ArqIni.ReadString('DB_CONF', 'Database', '');
    Server                            :=copy(DataBase, 1, pos('/', DataBase) - 1);
    Port                              :=copy(DataBase, pos('/', DataBase) + 1, 4);
    DataBase                          :=copy(DataBase, pos(':', DataBase) + 1, length(DataBase));
    Conexao.Params.Values['Server']   :=Server;
    Conexao.Params.Values['Port']     :=Port;
    Conexao.Params.Values['Database'] :=DataBase;
    Conexao.Params.Values['User_Name']:=ArqIni.ReadString('DB_CONF', 'User_Name', '');
    Conexao.Params.Values['Password'] :=ArqIni.ReadString('DB_CONF', 'Password', '');
    Conexao.Open();
  finally
    ArqIni.Free;
  end;
end;

{ Conecta ao banco MySQL }
procedure ConectaMySQL(var Conexao: TFDConnection; ArqPath: String = ''; Cript: boolean = False);
Var
  ArqIni: TIniFile;
begin
  try
    if ArqPath = '' then
      ArqPath:=ExtractFilePath(Application.ExeName) + '\MySQLConnection.ini'
    else
      ArqPath:=ArqPath + '\MySQLConnection.ini';
    if not FileExists(ArqPath) then
      raise Exception.Create('Arquivo de configuração não encontrado.');
    ArqIni:=TIniFile.Create(ArqPath);
    try
      Conexao.Close;
      Conexao.Params.Values['Database'] :=ArqIni.ReadString('MySQLConnection', 'Database', '');
      Conexao.Params.Values['Server']   :=ArqIni.ReadString('MySQLConnection', 'Server', '');
      Conexao.Params.Values['User_Name']:=ArqIni.ReadString('MySQLConnection', 'User_Name', '');
      if Cript then
        Conexao.Params.Values['Password']:=CriptoGramRaul(ArqIni.ReadString('MySQLConnection', 'Password', ''), True)
      else
        Conexao.Params.Values['Password']:=ArqIni.ReadString('MySQLConnection', 'Password', '');
      Conexao.Open();
    finally
      ArqIni.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('[URotinasRaul_XE8.ConectaMySQL]' + #13 + E.Message);
  end;
end;

{ Executa programa externo e aguarda até que o mesmo seja finalizado }
function ExecAndWait(const FileName, Params: string; const WindowState: Word): boolean;
var
  SUInfo  : TStartUpInfo;
  ProcInfo: TProcessInformation;
  CmdLine : String;
begin
  CmdLine:='"' + FileName + '"' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);

  with SUInfo do
  begin
    cb         :=SizeOf(SUInfo);
    dwFlags    :=STARTF_USESHOWWINDOW;
    wShowWindow:=WindowState;
  end;

  Result:=CreateProcess(nil, PChar(CmdLine), nil, nil, False, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, PChar(ExtractFilePath(FileName)), SUInfo, ProcInfo);

  { Aguarda até ser finalizado }
  // if Result then
  // begin
  // WaitForSingleObject(ProcInfo.hProcess, INFINITE);
  // { Libera os Handles }
  // CloseHandle(ProcInfo.hProcess);
  // CloseHandle(ProcInfo.hThread);
  // end;

end;

procedure RenameDir(DirFrom, DirTo: string);
var
  shellinfo: TSHFileOpStruct;
begin
  with shellinfo do
  begin
    Wnd   :=0;
    wFunc :=FO_RENAME;
    pFrom :=PChar(DirFrom);
    pTo   :=PChar(DirTo);
    fFlags:=FOF_FILESONLY or FOF_ALLOWUNDO or FOF_SILENT or FOF_NOCONFIRMATION;
  end;
  SHFileOperation(shellinfo);
end;

{ Função que limpa uma pasta, e confere se a pasta ficou vazia }
function limparPasta(pasta: String): boolean;
var
  I  : Integer;
  sr : TSearchRec;
  II : Integer;
begin
  I:=FindFirst(pasta + '*.*', faAnyFile, sr);

  while I = 0 do
  begin
    DeleteFile(pasta + sr.Name);
    I:=FindNext(sr);
  end;

  I:=FindFirst(pasta + '*.*', faAnyFile, sr);

  for II:=1 to 2 do
    if (sr.Name = '.') or (sr.Name = '..') then
      I:=FindNext(sr);

  Result:=I <> 0;
end;

function DeleteFolder(FolderName: String; LeaveFolder: boolean): boolean;
var
  r: TSHFileOpStruct;
begin
  Result:=False;
  if not System.SysUtils.DirectoryExists(FolderName) then
    Exit;
  if LeaveFolder then
    FolderName:=FolderName + '*.* '
  else if FolderName[length(FolderName)] = ' \\ ' then
    Delete(FolderName, length(FolderName), 1);
  FillChar(r, SizeOf(r), 0);
  r.wFunc :=FO_DELETE;
  r.pFrom :=PChar(FolderName);
  r.fFlags:=FOF_ALLOWUNDO or FOF_NOCONFIRMATION;
  Result  :=((SHFileOperation(r) = 0) and (not r.fAnyOperationsAborted));
end;

function CopyFiles(Source, Destination: string; Gauge: TGauge; sLabel: TLabel): boolean;
var
  FromF, ToF: file of byte;
  Buffer    : array [0 .. 4096] of Char;
  NumRead   : Integer;
  LengthArq : Longint;
  iLength   : Longint;
  Rec       : TSearchRec;
  Res       : Integer;
  sFile     : file of byte;
  ArqOri    : String;
  ArqDst    : String;
begin
  Result:=False;
  Res    :=FindFirst(Source + '\*.*', faAnyFile, Rec);
  iLength:=0;
  while Res = 0 do
  begin
    Application.ProcessMessages;
    if Rec.Attr = faArchive then
    begin
      ArqOri:=Source + '\' + Rec.Name;
      AssignFile(sFile, ArqOri);
      Reset(sFile);
      iLength:=iLength + FileSize(sFile);
      CloseFile(sFile);
    end;
    Res:=FindNext(Rec);
  end;
  FindClose(Rec);

  Gauge.MinValue:=0;
  Gauge.MaxValue:=iLength;

  Res:=FindFirst(Source + '\*.*', faAnyFile, Rec);
  while Res = 0 do
  begin
    Application.ProcessMessages;
    if Rec.Attr = faArchive then
    begin
      ArqOri        :=Source + '\' + Rec.Name;
      ArqDst        :=Destination + '\' + Rec.Name;
      sLabel.Caption:='Copiando... ' + Rec.Name;

      AssignFile(FromF, ArqOri);
      Reset(FromF);
      AssignFile(ToF, ArqDst);
      rewrite(ToF);
      LengthArq:=FileSize(FromF);
      while LengthArq > 0 do
      begin
        Application.ProcessMessages;
        BlockRead(FromF, Buffer[0], SizeOf(Buffer), NumRead);
        LengthArq:=LengthArq - NumRead;
        BlockWrite(ToF, Buffer[0], NumRead);
        Gauge.AddProgress(NumRead);
      end;
      CloseFile(FromF);
      CloseFile(ToF);
    end;
    Res:=FindNext(Rec);
  end;

  sLabel.Caption:='';
  Gauge.Progress:=0;
  FindClose(Rec);
end;

{ Retira todo o caractere que não é um número }
function RetiraNaoNumero(Str: String; Desc: Char = #0): String;
var
  I  : Integer;
  Res: String;
  L  : Char;
begin
  Res  :='';
  for I:=1 to length(Str) do
  begin
    L:=Str[I];
    if (L in (['0' .. '9'])) or (L=Desc) then
      Res:=Res + L;
  end;
  Result:=trim(Res);
end;

procedure TrimAppMemorySize;
var
  MainHandle: THandle;
begin
  try
    MainHandle:=OpenProcess(PROCESS_ALL_ACCESS, False, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
  except
  end;
  Application.ProcessMessages;
end;

{ Rotina que coloca mascara no campo telefone de acordo com o tipo de numero passado
  Telefone ou Celular com ou sem DDD e Nono digito }
function ColocaMacaraTelefone(Tel: String): string;
begin
  case length(Tel) of
    11:
      Result:='(' + copy(Tel, 1, 2) + ') ' + copy(Tel, 3, 5) + '-' + copy(Tel, 8, 4);
    10:
      Result:='(' + copy(Tel, 1, 2) + ') ' + copy(Tel, 3, 4) + '-' + copy(Tel, 7, 4);
    9:
      Result:=copy(Tel, 1, 5) + '-' + copy(Tel, 6, 4);
    8:
      Result:=copy(Tel, 1, 4) + '-' + copy(Tel, 5, 4);
  else
    Result:=Tel;
  end

end;

procedure ColocaMacaraTelefoneOnChange(Sender: TObject);
var
  Tel: String;
begin
  if not (Sender is TCustomEdit) then
    raise Exception.Create('[ColocaMacaraTelefoneOnChange] O objeto precisa ser do tipo TCustomEdit');

  Tel := RetiraNaoNumero(TEdit(Sender).Text);

  case Tel.Length of
    0: Tel := '';
    1,2: Tel := '('+Tel;
    3,4,5,6: Tel := '('+Copy(Tel,1,2)+') '+Copy(Tel,3,10);
    7,8,9,10: Tel := '('+Copy(Tel,1,2)+') '+Copy(Tel,3,4)+'-'+Copy(Tel,7,4);
    11: Tel := '('+Copy(Tel,1,2)+') '+Copy(Tel,3,5)+'-'+Copy(Tel,8,4);
    else
      Tel := '('+Copy(Tel,1,2)+') '+Copy(Tel,3,5)+'-'+Copy(Tel,8,4);
  end;

  TEdit(Sender).Text := Tel;
  TEdit(Sender).SelStart := Tel.Length;
end;

{ Coloca a mascara de acordo com o documento passado CPF ou CNPJ }
function ColocaMascaraDOC(DOC: string): string;
begin
  DOC:=RetiraNaoNumero(DOC);
  case length(DOC) of
    11:
      Result:=copy(DOC, 1, 3) + '.' + copy(DOC, 4, 3) + '.' + copy(DOC, 7, 3) + '-' + copy(DOC, 10, 2);
    14:
      Result:=copy(DOC, 1, 2) + '.' + copy(DOC, 3, 3) + '.' + copy(DOC, 6, 3) + '/' + copy(DOC, 9, 4) + '-' + copy(DOC, 13, 2);
  else
    Result:=DOC;
  end
end;

procedure ColocaMAscaraDOCOnChange(Sender: TObject);
var
  Doc: String;
begin
  if not (Sender is TCustomEdit) then
    raise Exception.Create('[ColocaMacaraTelefoneOnChange] O objeto precisa ser do tipo TCustomEdit');

  Doc := RetiraNaoNumero(TEdit(Sender).Text);

  case Doc.Length of
    0: Doc := '';
    1,2,3: Doc := Doc;
    4,5,6: Doc := Copy(Doc,1,3)+'.'+Copy(Doc,4,3);
    7,8,9: Doc := Copy(Doc,1,3)+'.'+Copy(Doc,4,3)+'.'+Copy(Doc,7,3);
    10,11: Doc := Copy(Doc,1,3)+'.'+Copy(Doc,4,3)+'.'+Copy(Doc,7,3)+'-'+Copy(Doc,10,2);
    else
      Doc := Copy(Doc,1,2)+'.'+Copy(Doc,3,3)+'.'+Copy(Doc,6,3)+'/'+Copy(Doc,9,4)+'-'+Copy(Doc,13,2);
  end;

  TEdit(Sender).Text := Doc;
  TEdit(Sender).SelStart := Doc.Length;
end;

{Coloca mascara de CEP}
function ColoaMascaraCEP(CEP: String):String;
Begin
  CEP := RetiraNaoNumero(CEP);
  Result := Copy(CEP,1,2)+'.'+Copy(CEP,3,3)+'-'+Copy(CEP,6,3);
End;

procedure ColocaMascaraCEPOnChange(Sender: TObject);
var
  CEP: String;
begin
  if not (Sender is TCustomEdit) then
    raise Exception.Create('[ColocaMacaraTelefoneOnChange] O objeto precisa ser do tipo TCustomEdit');

  CEP := RetiraNaoNumero(TEdit(Sender).Text);

  case CEP.Length of
    0: CEP := '';
    1,2: CEP := CEP;
    3,4,5: CEP := Copy(CEP,1,2)+'.'+Copy(CEP,3,3);
    else
      CEP := Copy(CEP,1,2)+'.'+Copy(CEP,3,3)+'-'+Copy(CEP,6,3);
  end;

  TEdit(Sender).Text := CEP;
  TEdit(Sender).SelStart := CEP.Length;
end;

{ Retira os acentas de uma string }
function Retira_Acento(Str: string): string;
var
  I: Integer;
begin
  for I:=1 to length(Str) do
  begin
    case Str[I] of
      'á':
        Str[I]:='a';
      'é':
        Str[I]:='e';
      'í':
        Str[I]:='i';
      'ó':
        Str[I]:='o';
      'ú':
        Str[I]:='u';
      'à':
        Str[I]:='a';
      'è':
        Str[I]:='e';
      'ì':
        Str[I]:='i';
      'ò':
        Str[I]:='o';
      'ù':
        Str[I]:='u';
      'â':
        Str[I]:='a';
      'ê':
        Str[I]:='e';
      'î':
        Str[I]:='i';
      'ô':
        Str[I]:='o';
      'û':
        Str[I]:='u';
      'ä':
        Str[I]:='a';
      'ë':
        Str[I]:='e';
      'ï':
        Str[I]:='i';
      'ö':
        Str[I]:='o';
      'ü':
        Str[I]:='u';
      'ã':
        Str[I]:='a';
      'õ':
        Str[I]:='o';
      'ñ':
        Str[I]:='n';
      'ç':
        Str[I]:='c';
      'Á':
        Str[I]:='A';
      'É':
        Str[I]:='E';
      'Í':
        Str[I]:='I';
      'Ó':
        Str[I]:='O';
      'Ú':
        Str[I]:='U';
      'À':
        Str[I]:='A';
      'È':
        Str[I]:='E';
      'Ì':
        Str[I]:='I';
      'Ò':
        Str[I]:='O';
      'Ù':
        Str[I]:='U';
      'Â':
        Str[I]:='A';
      'Ê':
        Str[I]:='E';
      'Î':
        Str[I]:='I';
      'Ô':
        Str[I]:='O';
      'Û':
        Str[I]:='U';
      'Ä':
        Str[I]:='A';
      'Ë':
        Str[I]:='E';
      'Ï':
        Str[I]:='I';
      'Ö':
        Str[I]:='O';
      'Ü':
        Str[I]:='U';
      'Ã':
        Str[I]:='A';
      'Õ':
        Str[I]:='O';
      'Ñ':
        Str[I]:='N';
      'Ç':
        Str[I]:='C';
      'º':
        Str[I]:='o';
      'ª':
        Str[I]:='a';
    end;
  end;
  Result:=Str;
end;

function AsciiToInt(Caracter: Char): Integer;
var
  I: Integer;
begin
  I:=32;
  while I < 255 do
  begin
    if Chr(I) = Caracter then
      break;
    I:=I + 1;
  end;
  Result:=I;
end;

{ Rotina para Teste e Calculo do Digito Verificador CPF }
function ECPF(Numero: string): boolean;
var
  I, DF, Pridigi, SegDigi: Integer;
  Texto1, Texto2         : string;
  D                      : array [1 .. 9] of Integer;
begin
  { Para validar o CPF, retorna F/V }
  Numero:=RetiraNaoNumero(Numero);
  Numero:=StrZeros(Numero, 11);
  for I :=1 to 9 do
    D[I]:=StrToInt(Numero[I]);

  { Calcula 1o.Digito }
  DF     :=(10 * D[1]) + (9 * D[2]) + (8 * D[3]) + (7 * D[4]) + (6 * D[5]) + (5 * D[6]) + (4 * D[7]) + (3 * D[8]) + (2 * D[9]);
  Pridigi:=(DF * 10) mod 11;
  if (Pridigi = 10) then
    Pridigi:=0;

  { Calcula 2o.Digito }
  DF     :=(11 * D[1]) + (10 * D[2]) + (9 * D[3]) + (8 * D[4]) + (7 * D[5]) + (6 * D[6]) + (5 * D[7]) + (4 * D[8]) + (3 * D[9]) + (2 * Pridigi);
  SegDigi:=(DF * 10) mod 11;
  if (SegDigi = 10) then
    SegDigi:=0;

  if (Pridigi <> StrToInt(Numero[10])) or (SegDigi <> StrToInt(Numero[11])) then
  begin
    Texto2:='Atenção ' + #0;
    Texto1:='CPF/MF invalido!' + #0;
    // MessageBox(0,@Texto1[1],@Texto2[1],MB_IconExclamation+Mb_OK);
    ECPF:=False;
  end
  else
    ECPF:=True;
end;

{ Rotina que altera cor do Edit, quando entra e quando sai do mesmo }
procedure AlteraCor(var Sender: TObject; Entra: boolean);
var
  Cor: TColor;
begin
  if Entra then
    Cor:=$00B3FDFB
  else
    Cor:=clWindow;
  if (Sender is TLabeledEdit) then
    (Sender as TLabeledEdit).Color:=Cor
  else if (Sender is TEdit) then
    (Sender as TEdit).Color:=Cor
  else if (Sender is TJvEdit) then
    (Sender as TJvEdit).Color:=Cor
  else if (Sender is TComboBox) then
    (Sender as TComboBox).Color:=Cor
  else if (Sender is TMaskEdit) then
    (Sender as TMaskEdit).Color:=Cor
  else if (Sender is TMemo) then
    (Sender as TMemo).Color:=Cor
  else if (Sender is TJvValidateEdit) then
    (Sender as TJvValidateEdit).Color:=Cor;
end;

{ Função que verifica a licença da GP Informatica }
function VerificaLicenca(CNPJ_CPF: String): Boolean;
type // Cria o tipo arquivo de licenca, para abrir somente por esse procedimento
  ArqLicenca = Record
    HASH: String[120];
    FILTRO: string[255];
  end;
var
  HASH         : ArqLicenca; // Variavel do tipo arquivo licenca
  Arquivo      : File of ArqLicenca;
  NomeArq      : String; // Nome do arquivo licença
  DataStr      : String; // String da data do Hash
  DecHash      : String; // Hash descriptografado
  CNPJ_CPF_H   : String; // CNPJ_CPF do Hash
  Cod_App_verif: String;
  COD_APP: String; // Codigo da aplicação
  StatusCode: Integer; //Cód HTTP de resposta da API
  RespMsg: string; //Msg de resposta da API
  ADM_Licenca: TdmLicencas;
begin
  ADM_Licenca:=TdmLicencas.Create(nil);
  try
    COD_APP := CodApp;

    { 1ª Parte (Lendo o Hash, online ou offline) }
    // Criando o nome do arquivo de licença
    NomeArq:=StringReplace(Application.ExeName, '.exe', '.lic', [rfIgnoreCase]);
    AssignFile(Arquivo, NomeArq);

    // Se o arquivo existe abre, se não cria.
    if FileExists(NomeArq) then
      Reset(Arquivo)
    else
    begin
      rewrite(Arquivo);
      Write(Arquivo, HASH);
    end;

      // Verificando licença online pelo CNPJ
      try
        ADM_Licenca.checkLicenca(CNPJ_CPF,COD_APP);
        StatusCode := ADM_Licenca.RESTResponse1.StatusCode;
        RespMsg := ADM_Licenca.RESTResponse1.JSONValue.Value;
      except
        on E:Exception do
          StatusCode := 0;
      end;

      // Se a resposta do POST for '1' então licença OK
      case StatusCode of
        000: //Sem internet, lê o arquivo
          begin
            // Coloca o ponteiro no inicio da variavel arquivo
            seek(Arquivo, 0);

            // Loop para ler byte a byte do arquivo e grava no na variavel hash
            repeat
              Read(Arquivo, HASH);
            until eof(Arquivo);

            if HASH.HASH = '' then
              MessageRaul_ERRO('Não foi possível obter a licença.');
          end;
        200: //Resposta da API OK, renova o arquivo;
          begin
            // Cria um novo hash.
            HASH.HASH  :=CriptoGramRaul('<codapp>' + COD_APP + '</codapp><datahora>' + FormatDateTime('dd/mm/yyyy', now + 30) + '</datahora>' + '<cnpj>' + CNPJ_CPF + '</cnpj>');
            HASH.FILTRO:=CriptoGramRaul(LerTag(CNPJ_CPF, 'cnpj'));
            Write(Arquivo, HASH); // escreve novo hash no arquivo
          end;
        203: MessageRaul_ERRO(RespMsg+#13+'Tivemos um problema com sua licença.'+#13+'Contate o suporte.'); //Licença Vencida
        400: MessageRaul_ERRO(RespMsg); //CNPJ ou COD_APP vazio
        401: MessageRaul_ERRO(RespMsg); //Licença não encontrada
        500: MessageRaul_ERRO(RespMsg);  //Erro Interno
      end;
    CloseFile(Arquivo);

    { 2ª Parte (Verifica o hash) }
    if (trim(HASH.HASH) <> '') then
    begin

      DecHash      :=CriptoGramRaul(HASH.HASH, True); // Descriptografa o Hash
      Cod_App_verif:=LerTag(DecHash, 'codapp');       // Pega ocódigo do app
      DataStr      :=LerTag(DecHash, 'datahora');     // Pega a data do Hash
      CNPJ_CPF_H   :=LerTag(DecHash, 'cnpj');         // Pega o CNPJ do Hash

      // Verifica se a data não venceu, os CNPJs batem e o Cód_App Bate
      Result := ((StrToDate(DataStr) > now) and (CNPJ_CPF_H = CNPJ_CPF) and (COD_APP = Cod_App_verif));

      // Se o CNPJ não bater então a empresa não é licenciada.
      if (CNPJ_CPF_H <> CNPJ_CPF) then
      begin
        MessageRaul_ATENCAO('A empresa da licença e do banco não conhecidem.'+#13+
                         'Apague o arquivo .lic na pasta de instalação, e tente novamente.');
        Exit;
      end;

      if not (StrToDate(DataStr) > now) then
      begin
        MessageRaul_ATENCAO('Licença vencida.');
        Exit;
      end;
    end
    else // Se Hash vazio, então está bloqueado.
    begin
//      MessageRaul_ERRO('Arquivo de licença vazio.');
      Result:=False;
    end;
  finally
    ADM_Licenca.Free;
  end;
end;

{ Função que verifica se a aplicação é Free }
function VerificaFREE: boolean;
var
  versao_exe: string;
  COD_APP   : String;
  Resp      : string;
  DM: TDM_RotinasRaul;
begin
  { Pega apenas a segunda parte da versão do exe,
    que é o código da aplicação no banco online }
  versao_exe:=VersaoEXE;
  COD_APP   :=copy(versao_exe, pos('.', versao_exe) + 1, length(versao_exe));
  COD_APP   :=copy(COD_APP, 0, pos('.', COD_APP) - 1);

  DM:=TDM_RotinasRaul.Create(nil);
  try
    // Verificando licença online pelo CNPJ
    try
      with DM do
      begin
        RESTRequestFREE.Params.ParameterByName('COD_APP').Value := COD_APP;
        RESTRequestFREE.Execute;
        if RESTResponseFREE.StatusCode = 200 then
          Resp := RESTResponseFREE.Content;
      end;
    except on E:Exception do
      begin
        MessageRaul_ERRO(E.Message);
        Application.Terminate;
//        raise Exception.Create(E.Message);
      end;
    end;
  finally
    DM.Free;
  end;

  if Resp = 'INATIVO' then
  begin
    MessageRaul_ERRO('APLICAÇÃO MUDOU O NÍVEL DE LICENÇA' + #13 + 'ENTRE EM CONTATO COM O SUPORTE.');
    Application.Terminate;
    Result:=False;
  end
  else if VersaoInt(Resp) <= VersaoInt(VersaoEXE) then
    Result:=True
  else if copy(trim(Resp), 0, 1) = '1' then
  begin
    if MessageRaul_ATENCAO_Confirma('ESSA VERSÃO DA APLICAÇÃO, ESTÁ DEFASADA' + #13 + 'OBTENHA UMA NOVA VERSÃO.' + #13 + 'VERSÃO DESSA APLICAÇÃO: ' + VersaoEXE + #13 + 'VERSÃO ATUALIZADA: ' + Resp +
      #13 + 'Deseja baixar a nova versão agora?') then
      ShellExecute(0, 'Open', PChar('https://www.raul.gigatronbirigui.com.br/download.php?cod_app=' + COD_APP), '', '', SW_HIDE);
    Application.Terminate;
    Result:=False;
  end
  else
  begin
    MessageRaul_ERRO('ALGO, NÃO PERMITIU A VERIFICAÇÃO DA LICENÇA GRATUITA.' + #13 + 'CERTIFIQUE QUE A APLICAÇÃO TENHA CESSO A INTERNET.' + #13 + 'SE O ERRO PERSISTIR, PROCURE O SUPORTE.');
    Application.Terminate;
    Result:=False;
  end;
end;

{ Comande if then simplificado }
function SE(Cond: boolean; SeVerd, SeFalso: Variant): Variant;
begin
  if Cond then
    Result:=SeVerd
  else
    Result:=SeFalso;
end;

{ COALESCE do Firebird porem de string }
function CoalesceStr(Str, NullStr: String): String;
begin
  if trim(Str) = '' then
    Result:=NullStr
  else
    Result:=Str;
end;

Function GetStatusWinService(const sWinService: string; const sComputerName: string = ''): Integer;
{ ============================================================================== }
{ Autor: Gustavo Zicatti Raimundo }
{ Data: 14/12/2005 }
{ Nome da Função: fncGetStatusWinService }
{ ------------------------------------------------------------------------------ }
{ Objetivos: }
{ Deve-se fornecer o nome da máquina e o serviço a que se deseja obter o }
{ status de funcionamento. }
{ Parametros: }
{ sWinService: deve ser o nome do serviço registrado no Windows e não o }
{ nome de exibição ou descrição do serviço, este parametros é }
{ obrigatótio. }
{ sComputerName: deve ser o nome da máquina que o serviço deve estar }
{ rodando, não aceita localhost como em padrões de rede, caso seja a }
{ própria máquina este parametro deve ser omitido. }
{ Retornos: }
{ -2  -> Máquina não foi localizada. }
{ -1  -> Serviço não foi localizado. }
{ 0   -> Erro desconhecido. }
{ 4   -> Serviço rodando/startado. }
{ Caso o retorno não seja nenhum destes acima verificar a tabela dos }
{ possíveis valores da variável dwCurrentState da estrutura }
{ SERVICE_STATUS retornada pela função QUERYSERVICESTATUS no site }
{ https://msdn.microsoft.com/library/default.asp?url=/library/en-us/ }
{ dllproc/base/service_status_str.asp. }
{ Observações: }
{ Para incluir esta função em sua UNIT deve-se adicionar na uses as units }
{ System, Windows e WinSvc. }
{ ============================================================================== }
var
  { Nome do computador onde esta localizado o serviço }
  sComputerNameEx: string;
  chrComputerName: array [0 .. 255] of Char;
  cSize          : Cardinal;
  { Handle do Gerenciador de Serviços }
  hServiceControl: SC_Handle;
  { Handle do Serviço }
  hService: SC_Handle;
  { Status do Serviço }
  tStatus: TServiceStatus;
  { Status Atual do Serviço }
  iStatus: Integer;
begin
  iStatus:=0;
  { Verifica se nome do computador foi declarado }
  if (sComputerName = '') then
  begin
    { Caso não tenha sido declarado captura o nome do computador local }
    FillChar(chrComputerName, SizeOf(chrComputerName), #0);
    GetComputerName(chrComputerName, cSize);
    sComputerNameEx:=chrComputerName;
  end
  else
    sComputerNameEx:=sComputerName;
  { Conecta ao Gerenciador de Serviços }
  hServiceControl:=OpenSCManager(PChar(sComputerNameEx), nil, SC_MANAGER_CONNECT);
  { Se conseguiu se conectar }
  if not(hServiceControl = 0) then
  begin
    { Conecta o Serviço Especificado }
    { Solicitando SERVICE_QUERY_STATUS ou o status do serviço }
    hService:=OpenService(hServiceControl, PChar(sWinService), SERVICE_QUERY_STATUS);
    { Se conseguiu se conectar }
    if not(hService = 0) then
    begin
      if (QueryServiceStatus(hService, tStatus)) then
      begin
        iStatus:=tStatus.dwCurrentState;
      end;
      { Fecha Handle do Serviço }
      CloseServiceHandle(hService);
    end
    else
      iStatus:=-1;
    { Fecha conexão com o Gerenciador de Serviços }
    CloseServiceHandle(hServiceControl);
  end
  else
    iStatus:=-2;
  { Retorna o valor do Status para a função }
  Result:=iStatus;
end;

{ Para o uso dessa função é necessário o uso das dll's libeay23.dll e ssleay23.dll
  Encontrados no link: https://indy.fulgan.com/SSL/
  Baixar a ultima versão do arquivo openssl-... }
function EnviarEmail(aHost: String; aPort: Integer; aLogin, aSenha, aListaEmail, aAssunto, aCorpo: String; anexo: TStringList; aAuth, aAuthSSL: boolean): boolean;
var
  AuthSSL  : TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP   : TIdSMTP;
  IdMessage: TIdMessage;
  I        : Integer;
begin
  IdSMTP   :=TIdSMTP.Create(nil);
  IdMessage:=TIdMessage.Create(nil);
  try
    IdSMTP.Host    :=aHost;
    IdSMTP.Port    :=aPort;
    IdSMTP.AuthType:=satDefault;
    IdSMTP.Username:=aLogin;
    IdSMTP.Password:=aSenha;
    if aAuthSSL then
    begin
      AuthSSL                  :=TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      IdSMTP.IOHandler         :=AuthSSL;
      IdSMTP.UseTLS            :=utUseImplicitTLS;
      AuthSSL.SSLOptions.Method:=sslvSSLv23;
      AuthSSL.SSLOptions.Mode  :=sslmClient;
    end;
    if aAuth then
      IdSMTP.AuthType:=satDefault
    else
      IdSMTP.AuthType:=satNone;
    try
      IdSMTP.Connect;

      IdMessage.From.Address             :=aLogin;
      IdMessage.Recipients.EMailAddresses:=aListaEmail;
      IdMessage.Subject                  :=aAssunto;
      IdMessage.Body.text                :='Data/Hora: ' + FormatDateTime('dd/MM/yyyy HH:mm:ss', now) + #13#10#13#10 + aCorpo;
      // IdMessage.Body.LoadFromFile(anexo);
      IdMessage.MessageParts.Clear; // Limpa os anexos da lista

      if anexo <> nil then
      begin
        for I:=0 to anexo.Count - 1 do
        begin
          // frmPadrao.GeraLog('Anexo['+inttostr(I)+']: '+anexo.Strings[I]);
          if anexo[I] <> '' then
            TIdAttachmentFile.Create(IdMessage.MessageParts, TFileName(anexo.Strings[I]));
          // adiciona anexo na lista, pode ser utilizado com looping
        end;
      end;

      IdSMTP.Send(IdMessage);
      // GeraLogRaul('E-Mail Enviado com sucesso para: ' +  aListaEmail);
    except
      on E: Exception do
      begin
        // GeraLogRaul('Erro ao enviar E-Mail:'+E.Message);
        Raise Exception.Create(E.Message);
        Exit;
      end;
    end;
  finally
    IdSMTP.Disconnect;
    FreeAndNil(IdSMTP);
    FreeAndNil(IdMessage);
    if AuthSSL <> nil then
      FreeAndNil(AuthSSL);
  end;
  Result:=True;
end;

function XlsToStringGrid(XStringGrid: TStringGrid; xFileXLS: string; var Gauge: TGauge; var Lab: TLabel; ColFixo: boolean = False): boolean;
const
  xlCellTypeLastCell = $0000000B;
var
  XLSAplicacao, AbaXLS : OLEVariant;
  RangeMatrix          : Variant;
  x, y, k, r, colOffSet: Integer;
begin
  Lab.Caption:='Abrindo Excel';
  Application.ProcessMessages;
  Result   :=False;
  colOffSet:=1;
  // Cria Excel- OLE Object
  XLSAplicacao:=CreateOleObject('Excel.Application');
  try
    // Esconde Excel
    XLSAplicacao.Visible:=False;
    // Abre o Workbook
    Lab.Caption:='Abrindo o Arquivo: ' + xFileXLS;
    Application.ProcessMessages;
    XLSAplicacao.Workbooks.Open(xFileXLS);

    { Selecione aqui a aba que você deseja abrir primeiro - 1,2,3,4.... }
//    XLSAplicacao.WorkSheets[1].Activate;
    { Selecione aqui a aba que você deseja ativar - começando sempre no 1 (1,2,3,4) }
//    AbaXLS:=XLSAplicacao.Workbooks[ExtractFileName(xFileXLS)].WorkSheets[1];

    AbaXLS.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    // Pegar o número da última linha
    x:=XLSAplicacao.ActiveCell.Row;
    // Pegar o número da última coluna
    y:=XLSAplicacao.ActiveCell.Column;
    // Se ColFixo então screscenta uma coluna, e inicia da coluna 2
    if ColFixo then
    begin
      inc(y);
      Dec(colOffSet);
    end;
    // Seta xStringGrid linha e coluna
    XStringGrid.RowCount:=x;
    XStringGrid.ColCount:=y;

    Lab.Caption:='Carregando arquivo na memória.';
    TrimAppMemorySize;
    Application.ProcessMessages;
    // Associaca a variant WorkSheet com a variant do Delphi
//    RangeMatrix:=XLSAplicacao.range['A1', XLSAplicacao.Cells.Item[x, y]].Value;
    // Cria o loop para listar os registros no TStringGrid
    k             :=1;
    Gauge.MaxValue:=x;
    repeat
      Gauge.AddProgress(1);
      Application.ProcessMessages;
      for r                                        :=1 to y do
        XStringGrid.Cells[(r - colOffSet), (k - 1)]:=RangeMatrix[k, r];
      inc(k, 1);
    until k > x;
    RangeMatrix:=Unassigned;
  finally
    // Fecha o Microsoft Excel
    if not VarIsEmpty(XLSAplicacao) then
    begin
      XLSAplicacao.Quit;
      XLSAplicacao:=Unassigned;
      AbaXLS      :=Unassigned;
      Result      :=True;
    end;
  end;
end;

// Procedimento que coloca o programa para iniciar com o Windows
{ Func: 0=Não Iniciar com Windows
  1=Iniciar Todos Usuários
  2=Iniciar Sómente para o usuário atual
  3=Apenas Verificar se está iniciando

  Resp: 0=Não Inicia com Windows
  1=Inicia com Windows para todos os usuários
  2=Inicia com Windows para o usuário Atual }
function IniciarComWindows(Func: Integer; Param: string = ''): Integer;
var
  reg             : TRegistry;
  AllUser, CurUser: boolean;
  NameApp         : String;
  procedure abreChave(RootKey: HKEY);
  begin
    reg.RootKey:=RootKey;
    reg.OpenKey('SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\RUN', True);
  end;
  function VerificaChave(RootKey: HKEY): boolean;
  begin
    reg:=TRegistry.Create;
    try
      abreChave(RootKey);
      Result:=reg.ValueExists(NameApp);
      reg.CloseKey;
    finally
      reg.Free;
    end;
  end;
  procedure GravaChave(RootKey: HKEY);
  begin
    reg:=TRegistry.Create;
    try
      abreChave(RootKey);
      reg.WriteString(NameApp, '"' + ParamStr(0) + '" ' + trim(Param));
      reg.CloseKey;
    finally
      reg.Free;
    end;
  end;
  procedure DeletaChave(RootKey: HKEY);
  begin
    reg:=TRegistry.Create;
    try
      abreChave(RootKey);
      reg.DeleteValue(NameApp);
      reg.CloseKey;
    finally
      reg.Free;
    end;
  end;

begin
  NameApp:=ExtractFileName(ChangeFileExt(ParamStr(0), ''));
  try
    AllUser := False;
    CurUser := False;
    // Se não for só conferir, deleta os registros pra garantir a troca.
    if Func <> 3 then
    begin                              // Não iniciar com o windows
      DeletaChave(HKEY_LOCAL_MACHINE); // Deleta chave todos usuários
      DeletaChave(HKEY_CURRENT_USER);  // Deleta chave usuário atual
    end;

    case Func of
      1:
        GravaChave(HKEY_LOCAL_MACHINE); // Iniciar para todos os usuários
      2:
        GravaChave(HKEY_CURRENT_USER); // Iniciar apenas para usuário Atual
      3:                               { Conferindo Chaves }
        begin
          AllUser:=VerificaChave(HKEY_LOCAL_MACHINE); // Confere todos usuários
          CurUser:=VerificaChave(HKEY_CURRENT_USER);  // Confere usuário Atual
        end;
    end;

    if AllUser then
      Result:=1
    else if CurUser then
      Result:=2
    else
      Result:=0;

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

{ Extrai só os 3 ultimos digitos da versão do
  arquivo paar comparação }
function VersaoInt(Versao: String): Integer;
var
  ponto: Integer;
begin
  ponto :=pos('.', Versao, pos('.', Versao, pos('.', Versao) + 1) + 1) + 1;
  Result:=StrToInt(copy(Versao, ponto, 3));
end;

function CodApp: String;
var
  versao_exe: string;
  COD_APP: String;
begin
  { Pega apenas a segunda parte da versão do exe,
    que é o código da aplicação no banco online }
  versao_exe:=VersaoEXE;
  COD_APP   :=copy(versao_exe, pos('.', versao_exe) + 1, length(versao_exe));
  COD_APP   :=copy(COD_APP, 0, pos('.', COD_APP) - 1);
  Result := COD_APP;
end;

{ Retorna a versão atual e o link pra download de uma palicação GP }
function versaoAtual(var Versao, link: String; COD_APP: Integer): boolean;
var
  IdHTTP: TIdHTTP;
  Post  : TStringList;
  Resp  : string;
begin
  IdHTTP:=TIdHTTP.Create(nil);
  Post  :=TStringList.Create;
  try
    Post.Add('cod_app=' + inttostr(COD_APP));
    Resp  :=IdHTTP.Post('https://raul.gigatronbirigui.com.br/autoupdate/index.php', Post);
    Versao:=copy(Resp, 0, pos('&', Resp) - 1);
    link  :=copy(Resp, pos('&', Resp) + 1, length(Resp));
    Result:=not(Resp = '0');
  finally
    IdHTTP.Free;
    Post.Free;
  end;
end;

{ Converte a data no formato MySQL (yyyy-mm-dd hh:mm:ss) para formato padrão (dd/mm/yyyy hh:mm:ss) }
function datahoraMysql(Data: String): string;
var
  Ano, Mes, dia, hora: string;
begin
  Ano :=copy(Data, 0, 4);
  Mes :=copy(Data, 6, 2);
  dia :=copy(Data, 9, 2);
  hora:=copy(Data, 12, 8);

  Result:=dia + '/' + Mes + '/' + Ano + ' ' + hora;
end;

{ Procedimento que gera o autoupdate da aplicação }
{ Para funcionar o autoupdate, os seguintes passos deverão serem seguidos
  1 - Subir o arquivo para a pasta com o nome da aplicação, dentro
  da pasta autoupdate no host raul.gigatronbirigui.com.br
  2 - A aplicação deve ser cadastrada no banco autoupdate no host.
  Considerando os campos
  COD_APP = Código interno único da aplicação.
  NOME_APP = O nome interno da aplicação, a pasta dentro da pasta autoupdate
  deve conter esse mesmo nome obedecendo o char case por causa do link.
  NOME_INSTALL = É o nome do instalador, porem na parte onde vai a versão deve
  ser colocada a tag {$versao }{ pois a aplicação monta dinamicamente o nome do instalador
  trocando essa tag pela versão atual da aplicação.
  VERSAO_APP = Esse campo vai a versão atual da aplicação. O procediemneto confere apenas o ultimo número,
  porem nesse campo deve ser passado todos os numeros separados por ponto.
  3 - Deve se ser observada o datalhe na versão do exe, onde o segundo número é o código da aplicação,
  pois é através desse número que o procedimento busca os dados no banco online. }
procedure autoupdate;
var
  ArqLog : TStringList;
  Logname: string;
begin
  try
    with TfrmAutoUpdate.Create(nil) do
    begin
      try
        if ChecaVersao then
        begin
          if copy(Application.ExeName, 0, 2) = '\\' then
            MessageRaul_ATENCAO('Essa aplicação precisa ser atualizada.' + #13 + 'Execute-a no servidor para ela se auto-atualizar, ou contate o suporte.')
          else
            ShowModal;
          if not _Erro then
            Application.Terminate;
        end;
      finally
        Free
      end;
    end;
  except
    on E: Exception do
    begin
      ArqLog:=TStringList.Create;
      try
        Logname:='Autoupdate_Exception_' + FormatDateTime('dd.mm.yyyy', now) + '.log';
        if FileExists(Logname) then
          ArqLog.LoadFromFile(Logname);
        ArqLog.Add(FormatDateTime('hh:mm:ss|', now) + E.Message);
        ArqLog.SaveToFile(Logname);
      finally
        ArqLog.Free;
      end;
    end;
  end;
end;

// Checa apenas se tem uma nova versão, mas não atualiza, usado para botão
function ChecaVersaoSimple: String;
begin
  try
    with TfrmAutoUpdate.Create(nil) do
      try
        if ChecaVersao then
          Result:=versao_atual
        else
          Result:='OK';
      finally
        Free
      end;
  except
    Result:='OK';
  end;
end;

{ Função que testa a conexão com a internet }
function TesteInternet: String;
begin
  try
      Result:=restGet(TrataLinkHttps('https://raul.gigatronbirigui.com.br/raul.php'),rmGET);
  except
    on E: Exception do
      Result:='Erro: ' + E.Message;
  end;
end;

{ Função que retorna a data de modificação de um arquivo }
function dataModifArq(const TheFile: string): string;
var
  FileH           : THandle;
  LocalFT         : TFileTime;
  DosFT           : DWORD;
  LastAccessedTime: TDateTime;
  FindData        : TWin32FindData;
begin
  Result:='';
  FileH :=FindFirstFile(PChar(TheFile), FindData);
  if FileH <> INVALID_HANDLE_VALUE then
  begin
    // Windows.FindClose(Handle) ;
    if (FindData.dwFileAttributes AND FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFT);
      FileTimeToDosDateTime(LocalFT, LongRec(DosFT).Hi, LongRec(DosFT).Lo);
      LastAccessedTime:=FileDateToDateTime(DosFT);
      Result          :=DateTimeToStr(LastAccessedTime);
    end;
  end;
end;

{ Lista arquivos de um diretório e subdiretórios em um TMemo passado }
procedure ListarArquivos(Diretorio: string; Sub: boolean; var Lista: TStringList);
var
  F       : TSearchRec;
  Ret     : Integer;
  TempNome: string;

  function TemAtributo(Attr, Val: Integer): boolean;
  begin
    Result:=Attr and Val = Val;
  end;

begin
  Ret:=FindFirst(Diretorio + '\*.*', faAnyFile, F);
  try
    while Ret = 0 do
    begin
      if TemAtributo(F.Attr, faDirectory) then
      begin
        if (F.Name <> '.') And (F.Name <> '..') then
          if Sub = True then
          begin
            TempNome:=Diretorio + '\' + F.Name;
            ListarArquivos(TempNome, True, Lista);
          end;
      end
      else
      begin
        Lista.Add(Diretorio + '\' + F.Name);
      end;
      Ret:=FindNext(F);
    end;
  finally
    begin
      FindClose(F);
    end;
  end;
end;

// Matar Processos
function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop   : Bool;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result                :=0;
  FSnapshotHandle       :=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize:=SizeOf(FProcessEntry32);
  ContinueLoop          :=Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))) then
      Result    :=Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, Bool(0), FProcessEntry32.th32ProcessID), 0));
    ContinueLoop:=Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

// Funcção que para um serviço do windos e retorna se deu certo ou não
function ServiceStop(sMachine, sService: string): boolean;
var
  // service control
  // manager handle
  schm,
  // service handle
  schs: SC_Handle;
  // service status
  ss: TServiceStatus;
  // check point
  dwChkP: DWORD;
begin
  // connect to the service
  // control manager
  schm:=OpenSCManager(PChar(sMachine), Nil, SC_MANAGER_CONNECT);
  // if successful...
  if (schm > 0) then
  begin
    // open a handle to
    // the specified service
    schs:=OpenService(schm, PChar(sService),
      // we want to
      // stop the service and
      SERVICE_STOP or
      // query service status
      SERVICE_QUERY_STATUS);
    // if successful...
    if (schs > 0) then
    begin
      if (ControlService(schs, SERVICE_CONTROL_STOP, ss)) then
      begin
        // check status
        if (QueryServiceStatus(schs, ss)) then
        begin
          while (SERVICE_STOPPED <> ss.dwCurrentState) do
          begin

            // dwCheckPoint contains a
            // value that the service
            // increments periodically
            // to report its progress
            // during a lengthy
            // operation.
            //
            // save current value
            //
            dwChkP:=ss.dwCheckPoint;

            // wait a bit before
            // checking status again
            //
            // dwWaitHint is the
            // estimated amount of time
            // the calling program
            // should wait before calling
            // QueryServiceStatus() again
            //
            // idle events should be
            // handled here...
            //
            Sleep(ss.dwWaitHint);
            if (not QueryServiceStatus(schs, ss)) then
            begin
              // couldn't check status
              // break from the loop
              break;
            end;
            if (ss.dwCheckPoint < dwChkP) then
            begin
              // QueryServiceStatus
              // didn't increment
              // dwCheckPoint as it
              // should have.
              // avoid an infinite
              // loop by breaking
              break;
            end;
          end;
        end;
      end;
      // close service handle
      CloseServiceHandle(schs);
    end;
    // close service control
    // manager handle
    CloseServiceHandle(schm);
  end;
  // return TRUE if
  // the service status is stopped
  Result:=SERVICE_STOPPED = ss.dwCurrentState;
end;

// Função de inicia um serviço do windows e retona se foi executado com sucesso.
function ServiceStart(sMachine, sService: string): boolean;
var
  //
  // service control
  // manager handle
  schm,
  //
  // service handle
  schs: SC_Handle;
  //
  // service status
  ss: TServiceStatus;
  //
  // temp char pointer
  psTemp: PChar;
  //
  // check point
  dwChkP: DWORD;
begin
  ss.dwCurrentState:=0;
  // connect to the service
  // control manager
  schm:=OpenSCManager(PChar(sMachine), Nil, SC_MANAGER_CONNECT);
  // if successful...
  if (schm > 0) then
  begin
    // open a handle to
    // the specified service
    schs:=OpenService(schm, PChar(sService),
      // we want to
      // start the service and
      SERVICE_START or
      // query service status
      SERVICE_QUERY_STATUS);
    // if successful...
    if (schs > 0) then
    begin
      psTemp:=Nil;
      if (StartService(schs, 0, psTemp)) then
      begin
        // check status
        if (QueryServiceStatus(schs, ss)) then
        begin
          while (SERVICE_RUNNING <> ss.dwCurrentState) do
          begin
            //
            // dwCheckPoint contains a
            // value that the service
            // increments periodically
            // to report its progress
            // during a lengthy
            // operation.
            //
            // save current value
            //
            dwChkP:=ss.dwCheckPoint;
            //
            // wait a bit before
            // checking status again
            //
            // dwWaitHint is the
            // estimated amount of time
            // the calling program
            // should wait before calling
            // QueryServiceStatus() again
            //
            // idle events should be
            // handled here...
            //
            Sleep(ss.dwWaitHint);
            if (not QueryServiceStatus(schs, ss)) then
            begin
              // couldn't check status
              // break from the loop
              break;
            end;
            if (ss.dwCheckPoint < dwChkP) then
            begin
              // QueryServiceStatus
              // didn't increment
              // dwCheckPoint as it
              // should have.
              // avoid an infinite
              // loop by breaking
              break;
            end;
          end;
        end;
      end;
      // close service handle
      CloseServiceHandle(schs);
    end;
    // close service control
    // manager handle
    CloseServiceHandle(schm);
  end;
  // return TRUE if
  // the service status is running
  Result:=SERVICE_RUNNING = ss.dwCurrentState;
end;

// Função que converte um número inteiro segundos em formato hh:mm:ss
function SegundosToTime(Segundos: Cardinal): String;
var
  Seg, Min, hora: Cardinal;
begin
  hora:=Segundos div 3600;
  Seg :=Segundos mod 3600;
  Min :=Seg div 60;
  Seg :=Seg mod 60;

  Result:=FormatFloat(',00', hora) + ':' + FormatFloat('00', Min) + ':' + FormatFloat('00', Seg);
end;

// Retona a quantidade de vezes que um subtexto apareceu no texto
function CountPos(const subtext: string; text: string): Integer;
begin
  if (length(subtext) = 0) or (length(text) = 0) or (pos(subtext, text) = 0) then
    Result:=0
  else
    Result:=(length(text) - length(StringReplace(text, subtext, '', [rfReplaceAll]))) div length(subtext);
end;

// Função que retorna um caminho da pasta do windows de acordo com o parametro passado
// usa as constantes inciadas com CSIDL, declarar ShlObj na Uses
function GetSpecialFolderPath(CSIDLFolder: Integer): string;
var
  FilePath: array [0 .. MAX_PATH] of Char;
begin
  SHGetFolderPath(0, CSIDLFolder, 0, 0, FilePath);
  Result:=FilePath;
end;

{ Retorna a SQL gerada pela query com os parametros }
function QueryToLog(Q: TFDQuery): string;
var
  I: Integer;
  r: string;
begin
  Result:=Q.SQL.text;
  for I :=0 to Q.Params.Count - 1 do
  begin
    case Q.Params.Items[I].DataType of
      ftString, ftDate, ftDateTime:
        r:=QuotedStr(Q.Params[I].AsString);
    else
      r:=Q.Params[I].AsString;
    end;
    Result:=StringReplace(Result, ':' + Q.Params.Items[I].Name, r, [rfReplaceAll]);
  end;
end;

{ Verifica se um processo está rodando no gerenciador de tarefas }
function ProcessExists(ExeFileName: string): boolean;
var
  ContinueLoop   : Bool;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle       :=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize:=SizeOf(FProcessEntry32);
  ContinueLoop          :=Process32First(FSnapshotHandle, FProcessEntry32);
  Result                :=False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName))) then
    begin
      Result:=True;
    end;
    ContinueLoop:=Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

{ Retorna o nome da impressora padrão do Windows }
function GetDefaultPrinterName: string;
begin
  if (Printer.PrinterIndex >= 0) then
  begin
    Result:=Printer.Printers[Printer.PrinterIndex];
  end
  else
  begin
    Result:='Nenhuma impressora Padrão foi detectada';
  end;
end;

{ Define a impressoa padrão pelo nome
  Em caso de impressão temporária, usar com GetDefaultPrinterName }
procedure SetDefaultPrinter(PrinterName: String);
var
  I          : Integer;
  Device     : PChar;
  Driver     : PChar;
  Port       : PChar;
  HdeviceMode: THandle;
  aPrinter   : TPrinter;
begin
  Printer.PrinterIndex:=-1;
  GetMem(Device, 255);
  GetMem(Driver, 255);
  GetMem(Port, 255);
  aPrinter:=TPrinter.Create;
  for I   :=0 to Printer.Printers.Count - 1 do
  begin
    if Printer.Printers[I] = PrinterName then
    begin
      aPrinter.PrinterIndex:=I;
      aPrinter.getprinter(Device, Driver, Port, HdeviceMode);
      StrCat(Device, ',');
      StrCat(Device, Driver);
      StrCat(Device, Port);
      WriteProfileString('windows', 'device', Device);
      StrCopy(Device, 'windows');
      SendMessage(HWND_BROADCAST, WM_WININICHANGE, 0, Longint(@Device));
    end;
  end;
  Freemem(Device, 255);
  Freemem(Driver, 255);
  Freemem(Port, 255);
  aPrinter.Free;
end;

{ Procedimento que le as configuração de conexão do arquivo ini e seção passados }
procedure LerConfigDB(con: TFDConnection; ArqIniName: string; Section: String);
var
  ArqIni: TIniFile;
begin
  ArqIni:=TIniFile.Create(ArqIniName);
  try
    con.Close;
    ArqIni.ReadSectionValues(Section, con.Params);
  finally
    ArqIni.Free;
  end;
end;

// Le a tag passada
function LerTag(XML, Tag: String): String;
var
  PosIni, PosFin, LengTag: Integer;
begin
  LengTag:=length(Tag);
  PosIni :=pos('<' + Tag + '>', XML) + 2 + LengTag;
  PosFin :=pos('</' + Tag + '>', XML);
  Result :=copy(XML, PosIni, PosFin - PosIni);
end;

// Seta O texto em uma tag passada
function SetTag(Str, Tag: String): String;
begin
  Result:='<'+Tag+'>'+Str+'</'+Tag+'>';
end;

//Usado no lugar do Idhttp, tanto para POST (rmPOST), quanto para Get (rmGET)
function restGET(url: String; rm: TRESTRequestMethod; post: TStringList=nil): string;
var
  restClient: TRESTClient;
  restRequest: TRESTRequest;
  restResponse: TRESTResponse;
  I: Integer;
begin
  restClient:=TRESTClient.Create(url);
  restRequest:=TRESTRequest.Create(nil);
  restResponse:=TRESTResponse.Create(nil);
  try
    restClient.RaiseExceptionOn500 := False;
    restClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    restClient.AcceptCharset := 'utf-8, *;q=0.8';

    if rm=rmPOST then
    begin
      restRequest.Method := rmPOST;
      restRequest.Params.Clear;
      for I := 0 to post.Count-1 do
        restRequest.AddParameter(post.Names[I],post.Values[post.Names[I]]);
    end;

    restRequest.Client := restClient;
    restRequest.Response := restResponse;
    restRequest.Execute;

    result:=restResponse.Content;
  finally
    restClient.Free;
    restRequest.Free;
    restResponse.Free;
  end;
end;


function GetOSVersion(var MajorVersion, MinorVersion, Build: DWORD) : String;
var
  VersionInfo: TOSVersionInfo;
  vPlatform: string;
begin
  VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);
  GetVersionEx(VersionInfo);

  with VersionInfo do
  begin
    case dwPlatformId of
      VER_PLATFORM_WIN32s:
        vPlatform := 'Windows 3x';
      VER_PLATFORM_WIN32_WINDOWS:
        vPlatform := 'Windows 95';
      VER_PLATFORM_WIN32_NT:
        vPlatform := 'Windows NT'; // 2000, XP, Vista, 7, 8, 8.1
    end;

    MajorVersion := dwMajorVersion;
    MinorVersion := dwMinorVersion;
    Build := dwBuildNumber;

    Result := vPlatform;
  end;
end;

function TrataLinkHttps(Link: string): string;
var
  Mai, Men, Bu: Cardinal;
begin
  GetOSVersion(Mai, Men, Bu);
  if Mai<7 then
    Result:=StringReplace(Link,'s://','://',[rfIgnoreCase])
  else
    Result:=Link;
end;

//Modifica as datas de um arquivo
function SetFileDateTime(FileName: string; CreateTime, ModifyTime, AcessTime: TDateTime): Boolean;
  function ConvertToFileTime(DateTime :TDateTime) :PFileTime;
  var
    FileTime :TFileTime;
    LFT: TFileTime;
    LST: TSystemTime;
  begin
    Result := nil;
    if DateTime > 0 then
    begin
      DecodeDate(DateTime, LST.wYear, LST.wMonth, LST.wDay);
      DecodeTime(DateTime, LST.wHour, LST.wMinute, LST.wSecond, LST.wMilliSeconds);
      if SystemTimeToFileTime(LST, LFT) then
        if LocalFileTimeToFileTime(LFT, FileTime) then
        begin
          New(Result);
          Result^ := FileTime;
        end;
    end;
  end;
var
  FileHandle: Integer;
  ftCreateTime,
  ftModifyTime,
  ftAcessTime: PFileTime;
begin
  try
    ftCreateTime := ConvertToFileTime(CreateTime);
    ftModifyTime := ConvertToFileTime(ModifyTime);
    ftAcessTime  := ConvertToFileTime(AcessTime);
    try
      FileHandle := 0;
      FileHandle := FileOpen(FileName, fmOpenReadWrite or fmShareExclusive);
      Result := SetFileTime(FileHandle, ftCreateTime, ftAcessTime, ftModifyTime);
    finally
      FileClose(FileHandle);
    end;
  finally
    Dispose(ftCreateTime);
    Dispose(ftAcessTime);
    Dispose(ftModifyTime);
  end;
end;

function Min(X, Y: Integer): Integer;
begin
   if X < Y then
      Result := X
   else
      Result := Y;
end;

function Max(X, Y: Integer): Integer;
begin
   if X > Y then
      Result := X
   else
      Result := Y;
end;

//Clareia uma Cor
function GetHighlightColor(BaseColor: TColor): TColor;
begin
  Result := RGB(Min(GetRValue(ColorToRGB(BaseColor)) + 64, 255),
    Min(GetGValue(ColorToRGB(BaseColor)) + 64, 255),
    Min(GetBValue(ColorToRGB(BaseColor)) + 64, 255));
end;

//Escurece uma cor
function GetShadowColor(BaseColor: TColor): TColor;
begin
  Result := RGB(Max(GetRValue(ColorToRGB(BaseColor)) - 64, 0),
    Max(GetGValue(ColorToRGB(BaseColor)) - 64, 0),
    Max(GetBValue(ColorToRGB(BaseColor)) - 64, 0));
end;

//Inverte uma Cor
function InverteColor(const Cor: TColor): TColor;
begin
  Result := RGB(255 - GetRValue(Cor), 255 - GetGValue(Cor), 255 - GetBValue(Cor));
end;

end.
