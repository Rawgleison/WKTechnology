unit Raul;

interface

Uses Classes, Controls, Dialogs, Forms, Windows, SysUtils,FireDAC.Comp.Client
    ,IniFiles, ShellApi, filectrl, Gauges, StdCtrls;

type
    TChars = set of Char;

  {Simplificador do MessageDialog}
  procedure MessageRaul_AVISO(Msg: string);
  procedure MessageRaul_ATENCAO(Msg: string);
  procedure MessageRaul_ERRO(Msg: string);
  function  MessageRaul_Confirma(Msg: string):boolean;
  function  MessageRaul_ERRO_Confirma(Msg: string):boolean;

  {Retona a Versão do Executável}
  function VersaoEXE(ExeName: String=''): string;

  {Função que criptografa e descriptografa uma string}
  function CriptoGramRaul(sSource: String; bDecrypt: Boolean = False; iTableSize: Integer = 94): String;

  { Filtra caracteres inválidos }
  function FilterChars(const S: string; const ValidChars: TChars): string;

  {Função que completa uma string com zeros a esquerda}
  function StrZeros(text: string; nqtde: integer): string;

  { Função que retorna a quantidade de dias do Mes }
  function DiasPorMes(Ano, Mes: Integer): Integer;

  { Repete uma Cadeia de Caracteres }
  function REPL(Caractere: char; nCaracteres: integer): string;

  { Tira todos os Espaços em Branco da String }
  function AllTrim(InString: string): string;

  { Função que Verifica se o ano é Bi-Sexto }
  function AnoBiSexto(Ano: Integer): Boolean;

  { Tira os Espaços à Esquerda de uma String }
  function LTrim(Text: string): string;

  { Tira os Zeros à Esquerda de uma String }
  function LTiraZeros(Text: string): string;


  { Alinha à Direita }
  function Rtrim(Text: string): string;

  {Função que completa um campo de data}
  function FiltraData(Data: String): string;

  {Função que converte Booleano em Inteiro (True=1 e False=0)}
  function BoolToInt(Bool: Boolean):Integer;

  {Função que converte Inteiro Booleano (1=True e 0=False)}
  function IntToBool(I: Integer):Boolean;

  {Função que verifica se existe uma Barra "\" no final de um caminho de pasta
   e se não tiver ela coloca}
  function VerifBarra(Path: String):String;

  {Pega parametros do arquivo GigaERP.ini}
  procedure ConectaGigaERP(var Conexao: TFDConnection;ArqPath: String='');

  {Conecta ao banco MySQL}
  procedure ConectaMySQL(var Conexao: TFDConnection;ArqPath: String='';Cript: Boolean=False);

  {Executa programa externo e aguarda até que o mesmo seja finalizado}
  function ExecAndWait(const FileName, Params: string; const WindowState: Word): boolean;

  {Procedimento para renomear diretorio}
  procedure RenameDir(DirFrom, DirTo: string);

  {Função para apagar uma pasta inteira}
  function DeleteFolder(FolderName: String; LeaveFolder: Boolean): Boolean;

  function CopyFiles(Source, Destination: string; Gauge:TGauge; sLabel:TLabel):Boolean;

  {Retira todo o caractere que não é um número}
  function RetiraNaoNumero(Str: String; Desc: String=''): String;

  {Libera memoria}
  procedure TrimAppMemorySize;

  {Coloca a mascara de acordo com o documento passado CPF ou CNPJ}
  function ColocaMascaraDOC(DOC: string):string;

  {Gerador de Log Padrão}
  procedure GeraLogRaul(Msg: String;Nivel: Integer=1;Erro: Boolean=False);

  {Retira os acentas de uma string}
  function Retira_Acento(str: string): string;

  {Retorna o codigo da tabela ASCII}
  function AsciiToInt(Caracter: Char): Integer;

  { Rotina para Teste e Calculo do Digito Verificador CPF }
  function ECPF(Numero: string): Boolean;



implementation

{Simplificador do MessageDialog}

procedure MessageRaul_AVISO(Msg: string);
begin
  MessageDlg(Msg,mtInformation,[mbOK],0);
end;

{Simplificador do MessageDialog}
procedure MessageRaul_ATENCAO(Msg: string);
begin
  MessageDlg(Msg,mtWarning,[mbOK],0);
end;

{Simplificador do MessageDialog}
procedure MessageRaul_ERRO(Msg: string);
begin
  MessageDlg(Msg,mtError,[mbOK],0);
end;

{Simplificador do MessageDialog}
function  MessageRaul_Confirma(Msg: string):boolean;
begin
  Result:=MessageDlg(Msg,mtConfirmation,[mbYes,mbNo],0)=mrYes;
end;

{Simplificador do MessageDialog}
function  MessageRaul_ERRO_Confirma(Msg: string):boolean;
begin
  Result:=MessageDlg(Msg,mtError,[mbYes,mbNo],0)=mrYes;
end;

{Retona a Versão do Executável}
function VersaoEXE(ExeName: String): string;
var
  Dummy: Cardinal;
  BufferSize, Len: Integer;
  Buffer: PChar;
  LoCharSet, HiCharSet: Word;
  Translate, Return: Pointer;
  StrFileInfo: string;
begin
  if ExeName='' then
    ExeName:=Application.ExeName;
  BufferSize := GetFileVersionInfoSize(PChar(ExeName), Dummy);
  if BufferSize <> 0 then
  begin
    GetMem(Buffer, Succ(BufferSize));
    try
      if GetFileVersionInfo(PChar(ExeName), 0, BufferSize, Buffer) then
        if VerQueryValue(Buffer, '\VarFileInfo\Translation', Translate, UINT(Len)) then
        begin
          LoCharSet := LoWord(Longint(Translate^));
          HiCharSet := HiWord(Longint(Translate^));
          StrFileInfo := Format('\StringFileInfo\0%x0%x\%s', [LoCharSet, HiCharSet, 'FileVersion']);
          if VerQueryValue(Buffer, PChar(StrFileInfo), Return, UINT(Len)) then
            Result := strpas(PChar(Return));
        end;
    except
      Result := '';
    end;
  end;
end;

{Função que criptografa e descriptografa uma string}
function CriptoGramRaul(sSource: String; bDecrypt: Boolean = False; iTableSize: Integer = 94): String;
var
  i, iPosText, iPosKey: Integer;
  sTable, sKey: string;
  ch: Char;
begin
  try
  sKey:=inttostr(length(sSource));
//Criar nossa Tabela Cipher
  i:= 32;
  While i <= (iTableSize + 32) do
  Begin
      ch:=Chr(i);
      sTable:= ConCat(sTable, Chr(i));
      inc(i);
  end;

//Adicione a chave do mesmo tamanho ou maior que o de origem
  while Length(sSource) >= Length(sKey) do
    sKey:= ConCat(sKey,sKey);

//Remover linha Feed & Carrage retorna de Cipher
  i:=0;
  while i<=Length(sSource) do
  if (sSource[i]=Chr(10)) or (sSource[i]=Chr(13)) then
    Delete(sSource, i, 1)
  else
    Inc(i);

{Uncomment if you need to remove spaces
//Remove Spaces from Cipher
  i:=0;
  while i<=Length(sSource) do
  if (sSource[i]=' ')  then
    Delete(sSource, i, 1)
  else
    Inc(i);
}

//Vegenere Encryption/Decryption routine
  i:= 1;
  while i <= Length(sSource) do
  Begin
    ch:=sSource[i];
    iPosText := pred(pos(sSource[i],sTable));
    ch:=sKey[i];
    iPosKey := pred(pos(sKey[i],sTable));
//Encrypt or Decrypt(Default is Encrypt)
  ch:=sTable[((iPosText + iPosKey) mod iTableSize) + 1];
  Case bDecrypt of
    False: Result := Result + sTable[((iPosText + iPosKey) mod iTableSize) + 1];
    True : Result := Result + sTable[(((iPosText + iTableSize) - iPosKey) mod iTableSize) + 1];
  end;
  inc(i);
  end;
  Except
  on E:Exception do
    Result:='***'+E.Message+'***';
  end;
end;

function FiltraData(Data: String): string;
var wDia, wMes, wAno: Word;
  sDia, sMes, sAno: string;
begin
  DecodeDate(Date, wAno, wMes, wDia); // Data atual
  sDia := FilterChars(trim(copy(Data, 1, 2)), ['0'..'9']);
  sMes := FilterChars(trim(copy(Data, 4, 2)), ['0'..'9']);
  sAno := FilterChars(trim(copy(Data, 7, 4)), ['0'..'9']);

  if (sAno = '') then
    sAno := inttostr(wAno)
  else if (Length(sAno) <> 4) then
  begin
    if (Length(sAno) <= 2) then
    begin
      if strtoint(sAno) <= 20 then
        sAno := inttostr(2000 + strtoint(sAno))
      else
        sAno := inttostr(1900 + strtoint(sAno));
    end
    else sAno := inttostr(wAno);
  end;

  if (sMes = '') or (strtoint(sMes) = 0) or (strtoint(sMes) > 12) then
    sMes := strzeros(inttostr(wMes), 2)
  else if strtoint(sMes) <> 0 then
    sMes := strzeros(sMes, 2);
  if (sDia = '') or (strtoint(sDia) = 0) then
    sDia := strzeros(inttostr(wDia), 2)
  else if (strtoint(sDia) > DiasPorMes(strtoint(sAno), strtoint(sMes))) then
    sDia := inttostr(DiasPorMes(strtoint(sAno), strtoint(sMes)))
  else if strtoint(sDia) <> 0 then
    sDia := strzeros(sDia, 2);
  Data := sDia + '/' + sMes + '/' + sAno;
  Result := Data;
end;

{ Filtra caracteres inválidos }
function FilterChars(const S: string; const ValidChars: TChars): string;
var
  I: integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[I] in ValidChars then
      Result := Result + S[I];
end;

{Função que completa uma string com zeros a esquerda}
function StrZeros(text: string; nqtde: integer): string;
begin
  StrZeros := REPL('0', nQtde - Length(text)) + alltrim(text);
end;

{ Função que retorna a quantidade de dias do Mes }
function DiasPorMes(Ano, Mes: Integer): Integer;
const DiasNoMes: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DiasNoMes[Mes];
  if (Mes = 2) and AnoBiSexto(Ano) then
    Inc(Result);
end;

{ Repete uma Cadeia de Caracteres }
function REPL(Caractere: char; nCaracteres: integer): string;
var n: integer; CadeiaCar: string;
begin
  CadeiaCar := '';
  for n := 1 to nCaracteres do
    CadeiaCar := CadeiaCar + Caractere;
  Result := CadeiaCar;
end;

{ Tira todos os Espaços em Branco da String }
function AllTrim(InString: string): string;
begin
  Result:=StringReplace(InString,' ','',[rfReplaceAll,rfIgnoreCase]);
end;

{ Função que Verifica se o ano é Bi-Sexto }
function AnoBiSexto(Ano: Integer): Boolean;
begin
  Result := (Ano mod 4 = 0) and ((Ano mod 100 <> 0) or (Ano mod 400 = 0));
end;

{ Tira os Espaços à Esquerda de uma String }
function LTrim(Text: string): string;
var
  n: integer;
begin
  for n := 1 to length(Text) do
  begin
    if Copy(Text, n, 1) <> ' ' then break;
    Delete(Text, n, 1);
  end;
  Result := Text;
end;

{ Tira os Zeros à Esquerda de uma String }
function LTiraZeros(Text: string): string;
var
  n: integer;
  str: string;
begin
  str:=Text;
  for n := 1 to length(Text) do
  begin
    if Copy(Text, 1, 1) <> '0' then break;
    Delete(Text, 1, 1);
  end;
  Result := Text;
end;

{ Alinha à Direita }
function Rtrim(Text: string): string;
var
  n: integer;
begin
  for n := length(Text) downto 1 do
  begin
    if Copy(Text, n, 1) <> ' ' then break;
    Delete(Text, n, 1);
  end;
  Result := Text;
end;

{Função que converte Booleano em Inteiro (True=1 e False=0)}
function BoolToInt(Bool: Boolean):Integer;
begin
  if Bool then
    Result:=1
  else
    Result:=0;
end;

{Função que converte Inteiro Booleano (1=True e 0=False)}
function IntToBool(I: Integer):Boolean;
begin
  Result:=I=1;
end;

{Função que verifica se existe uma Barra "\" no final de um caminho de pasta
e se não tiver ela coloca}
function VerifBarra(Path: String):String;
var
  Rede: Boolean;
begin
  Path:=Path+'\';
  Rede:=(Copy(Path,1,2)='\\');
  Path:=StringReplace(Path,'\\','\',[rfReplaceAll,rfIgnoreCase]);
  if Rede then
    Result:='\'+Path
  else
    Result:=Path;
end;

{Pega parametros do arquivo GigaERP.ini}
procedure ConectaGigaERP(var Conexao: TFDConnection;ArqPath: String='');
var
  ArqIni: TIniFile;
  DataBase, Port, Server: String;
begin
  try
    if ArqPath='' then
      ArqPath:=ExtractFilePath(Application.ExeName);
    ArqPath:=VerifBarra(ArqPath);
    ArqPath:=ArqPath+'GigaERP.ini';
    if not FileExists(ArqPath) then
      raise Exception.Create('Arquivo de configuração não encontrado'+#13+'Arquivo: '+ArqPath);
    ArqIni:=TIniFile.Create(ArqPath);
    try
      DataBase:=ArqIni.ReadString('DB_CONF','Database','');
      Server:=Copy(Database,1,pos('/',Database)-1);
      Port:=Copy(Database,pos('/',Database)+1,4);
      Database:=Copy(Database,pos(':',Database)+1,length(Database));
      Conexao.Params.Values['Server']:=Server;
      Conexao.Params.Values['Port']:=Port;
      Conexao.Params.Values['Database']:=Database;
      Conexao.Params.Values['User_Name']:=ArqIni.ReadString('DB_CONF','User_Name','');
      Conexao.Params.Values['Password']:=ArqIni.ReadString('DB_CONF','Password','');
      COnexao.Open();
    finally
      ArqIni.Free;
    end;

  except
    on E:Exception do
      raise Exception.Create('[URotinasRaul_XE8.GigaParametros]'+#13+E.Message);
  end;
end;

{Conecta ao banco MySQL}
procedure ConectaMySQL(var Conexao: TFDConnection;ArqPath: String='';Cript: Boolean=False);
Var
  ArqIni: TiniFile;
begin
  try
    if ArqPath='' then
      ArqPath:=ExtractFilePath(Application.ExeName)+'\MySQLConnection.ini'
    else
      ArqPath:=ArqPath+'\MySQLConnection.ini';
    if not FileExists(ArqPath) then
      raise Exception.Create('Arquivo de configuração não encontrado.');
    ArqIni:=TIniFile.Create(ArqPath);
    try
      Conexao.Close;
      Conexao.Params.Values['Database']:=ArqIni.ReadString('MySQLConnection','Database','');
      Conexao.Params.Values['Server']:=ArqIni.ReadString('MySQLConnection','Server','');
      Conexao.Params.Values['User_Name']:=ArqIni.ReadString('MySQLConnection','User_Name','');
      if Cript then
        Conexao.Params.Values['Password']:=CriptoGramRaul(ArqIni.ReadString('MySQLConnection','Password',''),True)
      else
        Conexao.Params.Values['Password']:=ArqIni.ReadString('MySQLConnection','Password','');
      Conexao.Open();
    finally
      ArqIni.Free;
    end;
  except
    on E:Exception do
      raise Exception.Create('[URotinasRaul_XE8.ConectaMySQL]'+#13+E.Message);
  end;
end;

{Executa programa externo e aguarda até que o mesmo seja finalizado}
function ExecAndWait(const FileName, Params: string; const WindowState: Word): boolean;
var
  SUInfo: TStartUpInfo;
  ProcInfo: TProcessInformation;
  CmdLine: String;
begin
  CmdLine := '"' + Filename + '"' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);

  with SUInfo do
  begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;

  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, false,
  CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
  PChar(ExtractFilePath(Filename)), SUInfo, ProcInfo);

  { Aguarda até ser finalizado }
  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    { Libera os Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;

end;

procedure RenameDir(DirFrom, DirTo: string);
var
  shellinfo: TSHFileOpStruct;
begin
  with shellinfo do
  begin
    Wnd := 0;
    wFunc := FO_RENAME;
    pFrom := PChar(DirFrom);
    pTo := PChar(DirTo);
    fFlags := FOF_FILESONLY or FOF_ALLOWUNDO or
    FOF_SILENT or FOF_NOCONFIRMATION;
  end;
  SHFileOperation(shellinfo);
end;

function DeleteFolder(FolderName: String; LeaveFolder: Boolean): Boolean;
var
  r: TshFileOpStruct;
begin
  Result:=False;
  if not SysUtils.DirectoryExists(FolderName) then
      Exit;
  if LeaveFolder then
    FolderName := FolderName + ' *.* '
  else
    if FolderName[Length(FolderName)] = ' \\ ' then
      Delete(FolderName,Length(FolderName), 1);
  FillChar(r, SizeOf(r), 0);
  r.wFunc := FO_DELETE;
  r.pFrom := PChar(FolderName);
  r.fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION;
  Result := ((ShFileOperation(r) = 0) and (not r.fAnyOperationsAborted));
end;

function CopyFiles(Source, Destination: string; Gauge:TGauge; sLabel:TLabel):Boolean;
var
  FromF, ToF: file of byte;
  Buffer: array[0..4096] of char;
  NumRead: integer;
  LengthArq:Longint;
  iLength  :Longint;
  Rec:    TSearchRec;
  Res:    Integer;
  sFile: file of byte;
  ArqOri:String;
  ArqDst:String;
begin
  Res := FindFirst(Source+'\*.*', faAnyFile, Rec);
  iLength:= 0;
  while Res = 0 do
  begin
    Application.ProcessMessages;
    if Rec.Attr = faArchive then
    begin
       ArqOri := Source+'\' + Rec.Name;
       AssignFile(sFile,ArqOri);
       Reset(sFile);
       iLength:= iLength + FileSize(sFile);
       CloseFile(sFile);
    end;
    Res := FindNext(Rec);
  end;
  FindClose(Rec);

  Gauge.MinValue:= 0;
  Gauge.MaxValue:= iLength;

  Res := FindFirst(Source+'\*.*', faAnyFile, Rec);
  while Res = 0 do
  begin
    Application.ProcessMessages;
    if Rec.Attr = faArchive then
    begin
      ArqOri := Source+'\' + Rec.Name;
      ArqDst := Destination+'\' + Rec.Name;
      sLabel.Caption:= 'Copiando... '+Rec.Name;

      AssignFile(FromF, ArqOri);
      reset(FromF);
      AssignFile(ToF, ArqDst);
      rewrite(ToF);
      LengthArq:= FileSize(FromF);
      while LengthArq > 0 do
      begin
        Application.ProcessMessages;
        BlockRead(FromF, Buffer[0], SizeOf(Buffer), NumRead);
        LengthArq := LengthArq - NumRead;
        BlockWrite(ToF, Buffer[0], NumRead);
        Gauge.AddProgress( NumRead );
      end;
      CloseFile(FromF);
      CloseFile(ToF);
    end;
    Res := FindNext(Rec);
  end;

  sLabel.Caption:= '';
  Gauge.Progress:= 0;
  FindClose(Rec);
end;

{Retira todo o caractere que não é um número}
function RetiraNaoNumero(Str: String; Desc: String=''): String;
var
  I: Integer;
  Res: String;
  L: Char;
begin
  Res:='';
  for I := 1 to length(Str) do
  begin
    L:=Str[I];
    if (L in (['0'..'9'])) then
      Res:=Res+L;
  end;
  Result:=Trim(Res);
end;

procedure TrimAppMemorySize;
var
MainHandle : THandle;
begin
try
MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID) ;
SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
CloseHandle(MainHandle) ;
except
end;
Application.ProcessMessages;
end;

function ColocaMascaraDOC(DOC: string):string;
begin
  case Length(DOC) of
    11:   Result:=copy(DOC, 1, 3) + '.' + copy(DOC, 4, 3) + '.' + copy(DOC, 7, 3) + '-' + copy(DOC, 10, 2);
    14:   Result:=copy(DOC, 1, 2) + '.' + copy(DOC, 3, 3) + '.' + copy(DOC, 6, 3) + '/' + copy(DOC, 9, 4) + '-' + copy(DOC, 13, 2);
    else Result:=DOC;
  end
end;

{Gerador de Log Padrão}
procedure GeraLogRaul(Msg: String;Nivel: Integer=1;Erro: Boolean=False);
var
  Arq: TStringList;
  FileName, NomeApp, ArqErro: String;
begin
  try
    Arq:=TStringList.Create;
    NomeApp:=StringReplace(ExtractFileName(Application.ExeName),'.exe','',[]);
    FileName:=ExtractFilePath(Application.ExeName)+'Log_'+NomeApp+'\'+NomeApp+'_'+FormatDateTime('yyyy.mm.dd',now)+'.log';
    try
      if not DirectoryExists(ExtractFilePath(FileName)) then
        ForceDirectories(ExtractFilePath(FileName));
      if FileExists(FileName) then
        Arq.LoadFromFile(FileName);
      if Erro then
        ArqErro:='Erro'
      else
        ArqErro:='    ';
      Arq.Add(ArqErro+FormatDateTime('|hh:mm:ss|',now)+Msg);
      Arq.SaveToFile(FileName);
    finally
      Arq.Free;
    end;
  except

  end;
end;

{Retira os acentas de uma string}
function Retira_Acento(str: string): string;
var
  i: Integer;
begin
  for i := 1 to Length(str) do
  begin
    case str[i] of
      'á': str[i] := 'a';
      'é': str[i] := 'e';
      'í': str[i] := 'i';
      'ó': str[i] := 'o';
      'ú': str[i] := 'u';
      'à': str[i] := 'a';
      'è': str[i] := 'e';
      'ì': str[i] := 'i';
      'ò': str[i] := 'o';
      'ù': str[i] := 'u';
      'â': str[i] := 'a';
      'ê': str[i] := 'e';
      'î': str[i] := 'i';
      'ô': str[i] := 'o';
      'û': str[i] := 'u';
      'ä': str[i] := 'a';
      'ë': str[i] := 'e';
      'ï': str[i] := 'i';
      'ö': str[i] := 'o';
      'ü': str[i] := 'u';
      'ã': str[i] := 'a';
      'õ': str[i] := 'o';
      'ñ': str[i] := 'n';
      'ç': str[i] := 'c';
      'Á': str[i] := 'A';
      'É': str[i] := 'E';
      'Í': str[i] := 'I';
      'Ó': str[i] := 'O';
      'Ú': str[i] := 'U';
      'À': str[i] := 'A';
      'È': str[i] := 'E';
      'Ì': str[i] := 'I';
      'Ò': str[i] := 'O';
      'Ù': str[i] := 'U';
      'Â': str[i] := 'A';
      'Ê': str[i] := 'E';
      'Î': str[i] := 'I';
      'Ô': str[i] := 'O';
      'Û': str[i] := 'U';
      'Ä': str[i] := 'A';
      'Ë': str[i] := 'E';
      'Ï': str[i] := 'I';
      'Ö': str[i] := 'O';
      'Ü': str[i] := 'U';
      'Ã': str[i] := 'A';
      'Õ': str[i] := 'O';
      'Ñ': str[i] := 'N';
      'Ç': str[i] := 'C';
      'º': str[i] := 'o';
      'ª': str[i] := 'a';
    end;
  end;
  Result := str;
end;

function AsciiToInt(Caracter: Char): Integer;
var
  i: Integer;
begin
  i := 32;
  while i < 255 do begin
    if Chr(i) = Caracter then
      Break;
    i := i + 1;
  end;
  Result := i;
end;

{ Rotina para Teste e Calculo do Digito Verificador CPF }
function ECPF(Numero: string): Boolean;
var
  I, DF, Pridigi, SegDigi: integer;
  Texto1, Texto2: string;
  D: array[1..9] of integer;
begin
  { Para validar o CPF, retorna F/V }
  Numero := RetiraNaoNumero(Numero);
  Numero := StrZeros(Numero, 11);
  for I := 1 to 9 do
    D[I] := StrToInt(Numero[I]);

  { Calcula 1o.Digito }
  DF := (10 * D[1]) + (9 * D[2]) + (8 * D[3]) + (7 * D[4]) + (6 * D[5]) + (5 * D[6])
    + (4 * D[7]) + (3 * D[8]) + (2 * D[9]);
  PriDigi := (DF * 10) mod 11;
  if (PriDigi = 10) then PriDigi := 0;

  { Calcula 2o.Digito }
  DF := (11 * D[1]) + (10 * D[2]) + (9 * D[3]) + (8 * D[4]) + (7 * D[5]) + (6 * D[6])
    + (5 * D[7]) + (4 * D[8]) + (3 * D[9]) + (2 * PriDigi);
  SegDigi := (DF * 10) mod 11;
  if (SegDigi = 10) then SegDigi := 0;

  if (PriDigi <> StrToInt(Numero[10])) or (SegDigi <> StrToInt(Numero[11])) then
  begin
    Texto2 := 'Atenção ' + #0;
    Texto1 := 'CPF/MF invalido!' + #0;
    //MessageBox(0,@Texto1[1],@Texto2[1],MB_IconExclamation+Mb_OK);
    ECPF := False;
  end
  else ECPF := True;
end;

end.
