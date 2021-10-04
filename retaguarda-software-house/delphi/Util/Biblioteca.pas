{*******************************************************************************
Title: T2Ti ERP
Description: Biblioteca de funções.

The MIT License

Copyright: Copyright (C) 2020 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

The author may be contacted at:
t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM)
@version 3.0
*******************************************************************************}

unit Biblioteca;

interface

uses
  Messages, SysUtils, StrUtils, Classes, Controls, Forms, Windows,
  IdHashMessageDigest, Constantes, Math, IdGlobal, TlHelp32, EncdDecd,
  // email
  IniFiles,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdBaseComponent,
  IdMessage,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdAttachmentFile,
  IdText;

function Modulo11(Numero: String): String;
Function ValidaCNPJ(xCNPJ: String): Boolean;
Function ValidaCPF(xCPF: String): Boolean;
Function ValidaEstado(Dado: string): Boolean;
Function MixCase(InString: String): String;
Function Hora_Seg(Horas: string): LongInt;
Function Seg_Hora(Seg: LongInt): string;
Function Minuscula(InString: String): String;
Function StrZero(Num: Real; Zeros, Deci: integer): string;
function MD5File(const fileName: string): string;
function MD5FileGed(const pArquivo: TStringStream): string;
function MD5String(const texto: string): string;
Function TruncaValor(Value: Extended; Casas: integer): Extended;
Function ArredondaTruncaValor(Operacao: String; Value: Extended; Casas: integer): Extended;
function UltimoDiaMes(Mdt: TDateTime): String; overload;
function UltimoDiaMes(pMes: String): String; overload;
function FormataFloat(Tipo: String; Valor: Extended): string; // Tipo => 'Q'=Quantidade | 'V'=Valor
procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
function CriaGuidStr: string;
function CaminhoApp: string;
function TextoParaData(pData: string): TDate;
function DataParaTexto(pData: TDate): string;
function DateToSQL(pDate: TDateTime; pComAspas: Boolean = True; pComHoras: Boolean = True): string;
function DatesToSQL(pDataInicial, pDataFinal: TDateTime; pCondicao: string; pIncluirHora: Boolean): string;
function UFToInt(pUF: String): Integer;
function IntToUF(pUF: Integer): String;
function VerificaInteiro(Value: String): Boolean;
function FileSize(FileName: string): Int64;
function Codifica(Action, Src: String): String;
function PeriodoAnterior(pMesAno: String): String;
function PeriodoPosterior(pMesAno: String): String;
function RetiraMascara(Texto:String): String;
function PegarPlanoPdv(DescricaoProduto: string): string;
function PegarModuloFiscalPdv(DescricaoProduto: string): string;
function ExecAndWait(ExeNameAndParams: string; ncmdShow: Integer = SW_SHOWNORMAL): Integer;
function KillTask(ExeFileName: string): Integer;
procedure DecodeFileBase64(const base64: AnsiString; const FileName: string);
function EnviarEmail(AAssunto: string; ADestino: string; ACorpo: string): Boolean;

var
  InString: String;

implementation

function EnviarEmail(AAssunto: string; ADestino: string; ACorpo: string): Boolean;
// Fonte: http://portal.tdevrocks.com.br/2017/05/05/tutorial-como-enviar-e-mail-pelo-gmail-com-delphi-10/
var
  IniFile              : TIniFile;
  sFrom                : String;
  sBccList             : String;
  sHost                : String;
  iPort                : Integer;
  sUserName            : String;
  sPassword            : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  Corpo: TStringList;
begin
  try
    try
      //Criação e leitura do arquivo INI com as configurações
      IniFile := TIniFile.Create('c:\t2ti\ini\config-email.ini');
      sFrom := IniFile.ReadString('Email', 'From', sFrom);
      sBccList := IniFile.ReadString('Email', 'BccList', sBccList);
      sHost := IniFile.ReadString('Email', 'Host', sHost);
      iPort := IniFile.ReadInteger('Email', 'Port', iPort);
      sUserName := IniFile.ReadString('Email', 'UserName', sUserName);
      sPassword := IniFile.ReadString('Email', 'Password', sPassword);

      //Configura os parâmetros necessários para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create;
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Variável referente a mensagem
      idMsg                            := TIdMessage.Create;
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'T2Ti.COM';
      idMsg.From.Address               := sFrom;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Destinatário(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;
//      idMsg.CCList.EMailAddresses      := 'PARA@DOMINIO.COM.BR';
//      idMsg.BccList.EMailAddresses    := sBccList;
//      idMsg.BccList.EMailAddresses    := 'PARA@DOMINIO.COM.BR'; //Cópia Oculta

      //Corpo
      idText := TIdText.Create(idMsg.MessageParts);
      idText.Body.Add(ACorpo);
      idText.ContentType := 'text/html; text/plain; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create;
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := sUserName;
      IdSMTP.Password                  := sPassword;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

//      if AAnexo &lt;&gt; EmptyStr then
//        if FileExists(AAnexo) then
//          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conexão foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        IdSMTP.Send(idMsg);
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally
      IniFile.Free;
      UnLoadOpenSSLLibrary;

      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Modulo11(Numero: String): String;
var
  i, k: integer;
  Soma: integer;
  Digito: integer;
begin
  Result := '';
  Try
    Soma := 0;
    k := 2;
    for i := Length(Numero) downto 1 do
    begin
      Soma := Soma + (StrToInt(Numero[i]) * k);
      inc(k);
      if k > 9 then
        k := 2;
    end;
    Digito := 11 - Soma mod 11;
    if Digito >= 10 then
      Digito := 0;
    Result := Result + Chr(Digito + Ord('0'));
  except
    Result := 'X';
  end;
end;

{ Valida o CNPJ digitado }
function ValidaCNPJ(xCNPJ: String): Boolean;
Var
  d1, d4, xx, nCount, fator, resto, digito1, digito2: integer;
  Check: String;
begin
  d1 := 0;
  d4 := 0;
  xx := 1;
  for nCount := 1 to Length(xCNPJ) - 2 do
  begin
    if Pos(Copy(xCNPJ, nCount, 1), '/-.') = 0 then
    begin
      if xx < 5 then
      begin
        fator := 6 - xx;
      end
      else
      begin
        fator := 14 - xx;
      end;
      d1 := d1 + StrToInt(Copy(xCNPJ, nCount, 1)) * fator;
      if xx < 6 then
      begin
        fator := 7 - xx;
      end
      else
      begin
        fator := 15 - xx;
      end;
      d4 := d4 + StrToInt(Copy(xCNPJ, nCount, 1)) * fator;
      xx := xx + 1;
    end;
  end;
  resto := (d1 mod 11);
  if resto < 2 then
  begin
    digito1 := 0;
  end
  else
  begin
    digito1 := 11 - resto;
  end;
  d4 := d4 + 2 * digito1;
  resto := (d4 mod 11);
  if resto < 2 then
  begin
    digito2 := 0;
  end
  else
  begin
    digito2 := 11 - resto;
  end;
  Check := IntToStr(digito1) + IntToStr(digito2);
  if Check <> Copy(xCNPJ, succ(Length(xCNPJ) - 2), 2) then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

{ Valida o CPF digitado }
function ValidaCPF(xCPF: String): Boolean;
Var
  d1, d4, xx, nCount, resto, digito1, digito2: integer;
  Check: String;
Begin
  d1 := 0;
  d4 := 0;
  xx := 1;
  for nCount := 1 to Length(xCPF) - 2 do
  begin
    if Pos(Copy(xCPF, nCount, 1), '/-.') = 0 then
    begin
      d1 := d1 + (11 - xx) * StrToInt(Copy(xCPF, nCount, 1));
      d4 := d4 + (12 - xx) * StrToInt(Copy(xCPF, nCount, 1));
      xx := xx + 1;
    end;
  end;
  resto := (d1 mod 11);
  if resto < 2 then
  begin
    digito1 := 0;
  end
  else
  begin
    digito1 := 11 - resto;
  end;
  d4 := d4 + 2 * digito1;
  resto := (d4 mod 11);
  if resto < 2 then
  begin
    digito2 := 0;
  end
  else
  begin
    digito2 := 11 - resto;
  end;
  Check := IntToStr(digito1) + IntToStr(digito2);
  if Check <> Copy(xCPF, succ(Length(xCPF) - 2), 2) then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

{ Valida a UF digitada }
function ValidaEstado(Dado: string): Boolean;
const
  Estados = 'SPMGRJRSSCPRESDFMTMSGOTOBASEALPBPEMARNCEPIPAAMAPFNACRRRO';
var
  Posicao: integer;
begin
  Result := True;
  if Dado <> '' then
  begin
    Posicao := Pos(UpperCase(Dado), Estados);
    if (Posicao = 0) or ((Posicao mod 2) = 0) then
    begin
      Result := False;
    end;
  end;
end;

{ Corrige a string que contenha caracteres maiusculos
  inseridos no meio dela para tudo minusculo e com a
  primeira letra maiuscula }
Function MixCase(InString: String): String;
Var
  i: integer;
Begin
  Result := LowerCase(InString);
  Result[1] := UpCase(Result[1]);
  For i := 1 To Length(InString) - 1 Do
  Begin
    If (Result[i] = ' ') Or (Result[i] = '''') Or (Result[i] = '"') Or (Result[i] = '-') Or (Result[i] = '.') Or (Result[i] = '(') Then
      Result[i + 1] := UpCase(Result[i + 1]);
    if Result[i] = 'Ç' then
      Result[i] := 'ç';
    if Result[i] = 'Ã' then
      Result[i] := 'ã';
    if Result[i] = 'Á' then
      Result[i] := 'á';
    if Result[i] = 'É' then
      Result[i] := 'é';
    if Result[i] = 'Í' then
      Result[i] := 'í';
    if Result[i] = 'Õ' then
      Result[i] := 'õ';
    if Result[i] = 'Ó' then
      Result[i] := 'ó';
    if Result[i] = 'Ú' then
      Result[i] := 'ú';
    if Result[i] = 'Â' then
      Result[i] := 'â';
    if Result[i] = 'Ê' then
      Result[i] := 'ê';
    if Result[i] = 'Ô' then
      Result[i] := 'ô';
  End;
End;

{ Converte de hora para segundos }
function Hora_Seg(Horas: string): LongInt;
Var
  Hor, Min, Seg: LongInt;
begin
  Horas[Pos(':', Horas)] := '[';
  Horas[Pos(':', Horas)] := ']';
  Hor := StrToInt(Copy(Horas, 1, Pos('[', Horas) - 1));
  Min := StrToInt(Copy(Horas, Pos('[', Horas) + 1, (Pos(']', Horas) - Pos('[', Horas) - 1)));
  if Pos(':', Horas) > 0 then
    Seg := StrToInt(Copy(Horas, Pos(']', Horas) + 1, (Pos(':', Horas) - Pos(']', Horas) - 1)))
  else
    Seg := StrToInt(Copy(Horas, Pos(']', Horas) + 1, 2));
  Result := Seg + (Hor * 3600) + (Min * 60);
end;

{ Converte de segundos para hora }
function Seg_Hora(Seg: LongInt): string;
Var
  Hora, Min: LongInt;
  Tmp: Double;
begin
  Tmp := Seg / 3600;
  Hora := Round(Int(Tmp));
  Seg := Round(Seg - (Hora * 3600));
  Tmp := Seg / 60;
  Min := Round(Int(Tmp));
  Seg := Round(Seg - (Min * 60));
  Result := StrZero(Hora, 2, 0) + ':' + StrZero(Min, 2, 0) + ':' + StrZero(Seg, 2, 0);
end;

{ converte tudo para minuscula }
Function Minuscula(InString: String): String;
Var
  i: integer;
Begin
  Result := LowerCase(InString);
  For i := 1 To Length(InString) - 1 Do
  Begin
    If (Result[i] = ' ') Or (Result[i] = '''') Or (Result[i] = '"') Or (Result[i] = '-') Or (Result[i] = '.') Or (Result[i] = '(') Then
      Result[i] := UpCase(Result[i]);
    if Result[i] = 'Ç' then
      Result[i] := 'ç';
    if Result[i] = 'Ã' then
      Result[i] := 'ã';
    if Result[i] = 'Á' then
      Result[i] := 'á';
    if Result[i] = 'É' then
      Result[i] := 'é';
    if Result[i] = 'Í' then
      Result[i] := 'í';
    if Result[i] = 'Õ' then
      Result[i] := 'õ';
    if Result[i] = 'Ó' then
      Result[i] := 'ó';
    if Result[i] = 'Ú' then
      Result[i] := 'ú';
    if Result[i] = 'Â' then
      Result[i] := 'â';
    if Result[i] = 'Ê' then
      Result[i] := 'ê';
    if Result[i] = 'Ô' then
      Result[i] := 'ô';
  End;
End;

function StrZero(Num: Real; Zeros, Deci: integer): string;
var
  Tam, Z: integer;
  Res, Zer: string;
begin
{$WARNINGS OFF}
  Str(Num: Zeros: Deci, Res);
  Res := Trim(Res);
  Tam := Length(Res);
  Zer := '';
  for Z := 01 to (Zeros - Tam) do
    Zer := Zer + '0';
  Result := Zer + Res;
{$WARNINGS ON}
end;

function MD5File(const fileName: string): string;
var
  idmd5: TIdHashMessageDigest5;
  fs: TFileStream;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  fs := TFileStream.Create(fileName, fmOpenRead OR fmShareDenyWrite);
  try
    Result := idmd5.HashStreamAsHex(fs);
  finally
    fs.Free;
    idmd5.Free;
  end;
end;

function MD5FileGed(const pArquivo: TStringStream): string;
var
  idmd5: TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    Result := idmd5.HashBytesAsHex(TIdBytes(pArquivo.Bytes));
  finally
    idmd5.Free;
  end;
end;

function MD5String(const texto: string): string;
var
  idmd5: TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    Result := LowerCase(idmd5.HashStringAsHex(texto));
  finally
    idmd5.Free;
  end;
end;

Function TruncaValor(Value: Extended; Casas: integer): Extended;
Var
  sValor: String;
  nPos: integer;
begin
  // Transforma o valor em string
  sValor := FloatToStr(Value);

  // Verifica se possui ponto decimal
  nPos := Pos(FormatSettings.DecimalSeparator, sValor);
  If (nPos > 0) Then
  begin
    sValor := Copy(sValor, 1, nPos + Casas);
  End;

  Result := StrToFloat(sValor);
end;

Function ArredondaTruncaValor(Operacao: String; Value: Extended; Casas: integer): Extended;
Var
  sValor: String;
  nPos: integer;
begin
  if Operacao = 'A' then
    Result := SimpleRoundTo(Value, Casas * -1)
  else
  begin
    // Transforma o valor em string
    sValor := FloatToStr(Value);

    // Verifica se possui ponto decimal
    nPos := Pos(FormatSettings.DecimalSeparator, sValor);
    If (nPos > 0) Then
    begin
      sValor := Copy(sValor, 1, nPos + Casas);
    End;

    Result := StrToFloat(sValor);
  end;
end;

function UltimoDiaMes(Mdt: TDateTime): String;
var
  ano, mes, dia: word;
  mDtTemp: TDateTime;
begin
  Decodedate(Mdt, ano, mes, dia);
  mDtTemp := (Mdt - dia) + 33;
  Decodedate(mDtTemp, ano, mes, dia);
  mDtTemp := mDtTemp - dia;
  Decodedate(mDtTemp, ano, mes, dia);
  Result := IntToStr(dia)
end;

function UltimoDiaMes(pMes: String): String;
var
  ano, mes, dia: word;
  mDtTemp: TDateTime;
  Mdt: TDateTime;
begin
  Mdt := StrToDateTime('01/' + pMes + '/' + FormatDateTime('YYYY', Now));
  Decodedate(Mdt, ano, mes, dia);
  mDtTemp := (Mdt - dia) + 33;
  Decodedate(mDtTemp, ano, mes, dia);
  mDtTemp := mDtTemp - dia;
  Decodedate(mDtTemp, ano, mes, dia);
  Result := IntToStr(dia)
end;

function FormataFloat(Tipo: String; Valor: Extended): string; // Tipo => 'Q'=Quantidade | 'V'=Valor
var
  i: integer;
  Mascara: String;
begin
  Mascara := '0.';

  if Tipo = 'Q' then
  begin
    for i := 1 to Constantes.TConstantes.DECIMAIS_QUANTIDADE do
      Mascara := Mascara + '0';
  end
  else if Tipo = 'V' then
  begin
    for i := 1 to Constantes.TConstantes.DECIMAIS_VALOR do
      Mascara := Mascara + '0';
  end;

  Result := FormatFloat(Mascara, Valor);
end;

procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

function CriaGuidStr: string;
var
  Guid: TGUID;
begin
  CreateGUID(Guid);
  Result := GUIDToString(Guid);
end;

function CaminhoApp: string;
begin
  Result := ExtractFileDir(GetCurrentDir);
end;

function TextoParaData(pData: string): TDate;
var
  dia, mes, ano: integer;
begin
  if (pData <> '') AND (pData <> '0000-00-00') then
  begin
    dia := StrToInt(Copy(pData, 9, 2));
    mes := StrToInt(Copy(pData, 6, 2));
    ano := StrToInt(Copy(pData, 1, 4));
    Result := EncodeDate(ano, mes, dia);
  end
  else
  begin
    Result := 0;
  end;
end;

function DataParaTexto(pData: TDate): string;
begin
  if pData > 0 then
    Result := FormatDateTime('YYYY-MM-DD', pData)
  else
    Result := '0000-00-00';
end;

function DateToSQL(pDate: TDateTime; pComAspas: Boolean = True; pComHoras: Boolean = True): string;
var
  ano, mes, dia, Hora, Minuto, Segundo, MileSegundo: word;
begin
  Decodedate(pDate, ano, mes, dia);

  Result := IntToStr(ano) + '-' + IntToStr(mes) + '-' + IntToStr(dia);

  DecodeTime(pDate, Hora, Minuto, Segundo, MileSegundo);

  if ((Hora + Minuto + Segundo) > 0) and (pComHoras) then
  begin
    Result := Result + ' ' + IntToStr(Hora) + ':' + IntToStr(Minuto) + ':' + IntToStr(Segundo);
  end;

  if pComAspas then
  begin
    Result := QuotedStr(Result);
  end;
end;

function DatesToSQL(pDataInicial, pDataFinal: TDateTime; pCondicao: string; pIncluirHora: Boolean): string;
begin
  if (pDataInicial > 0) and (pDataFinal > 0) then
  begin
    if pIncluirHora then
    begin
      Result := pCondicao + ' BETWEEN ' + QuotedStr(DateToSQL(pDataInicial, False, False) + ' 00:00:00') + ' AND ' + QuotedStr(DateToSQL(pDataFinal, False, False) + ' 23:59:59');
    end
    else
    begin
      Result := pCondicao + ' BETWEEN ' + DateToSQL(pDataInicial, True, False) + ' AND ' + DateToSQL(pDataFinal, True, False);
    end;
  end
  else if (pDataInicial > 0) and (pDataFinal = 0) then
    Result := pCondicao + ' >= ' + DateToSQL(pDataInicial, True, False)
  else if (pDataInicial = 0) and (pDataFinal > 0) then
  begin
    if pIncluirHora then
    begin
      Result := pCondicao + ' <= ' + QuotedStr(DateToSQL(pDataFinal, False, False) + ' 23:59:59');
    end
    else
    begin
      Result := pCondicao + ' <= ' + DateToSQL(pDataFinal, True, False);
    end;
  end
  else
    Result := '';
end;

// função auxiliar para converte UF do cliente para codigo
function UFToInt(pUF: String): integer;
begin
  Result := 0;
  if pUF = 'RO' then
    Result := 11;
  if pUF = 'AC' then
    Result := 12;
  if pUF = 'AM' then
    Result := 13;
  if pUF = 'RR' then
    Result := 14;
  if pUF = 'PA' then
    Result := 15;
  if pUF = 'AP' then
    Result := 16;
  if pUF = 'TO' then
    Result := 17;
  if pUF = 'MA' then
    Result := 21;
  if pUF = 'PI' then
    Result := 22;
  if pUF = 'CE' then
    Result := 23;
  if pUF = 'RN' then
    Result := 24;
  if pUF = 'PB' then
    Result := 25;
  if pUF = 'PE' then
    Result := 26;
  if pUF = 'AL' then
    Result := 27;
  if pUF = 'SE' then
    Result := 28;
  if pUF = 'BA' then
    Result := 29;
  if pUF = 'MG' then
    Result := 31;
  if pUF = 'ES' then
    Result := 32;
  if pUF = 'RJ' then
    Result := 33;
  if pUF = 'SP' then
    Result := 35;
  if pUF = 'PR' then
    Result := 41;
  if pUF = 'SC' then
    Result := 42;
  if pUF = 'RS' then
    Result := 43;
  if pUF = 'MS' then
    Result := 50;
  if pUF = 'MT' then
    Result := 51;
  if pUF = 'GO' then
    Result := 52;
  if pUF = 'DF' then
    Result := 53;
end;

// função auxiliar para converte Codigo UF do cliente para UF
function IntToUF(pUF: integer): String;
begin
  Result := '';
  if pUF = 11 then
    Result := 'RO';
  if pUF = 12 then
    Result := 'AC';
  if pUF = 13 then
    Result := 'AM';
  if pUF = 14 then
    Result := 'RR';
  if pUF = 15 then
    Result := 'PA';
  if pUF = 16 then
    Result := 'AP';
  if pUF = 17 then
    Result := 'TO';
  if pUF = 21 then
    Result := 'MA';
  if pUF = 22 then
    Result := 'PI';
  if pUF = 23 then
    Result := 'CE';
  if pUF = 24 then
    Result := 'RN';
  if pUF = 25 then
    Result := 'PB';
  if pUF = 26 then
    Result := 'PE';
  if pUF = 27 then
    Result := 'AL';
  if pUF = 28 then
    Result := 'SE';
  if pUF = 29 then
    Result := 'BA';
  if pUF = 31 then
    Result := 'MG';
  if pUF = 32 then
    Result := 'ES';
  if pUF = 33 then
    Result := 'RJ';
  if pUF = 35 then
    Result := 'SP';
  if pUF = 41 then
    Result := 'PR';
  if pUF = 42 then
    Result := 'SC';
  if pUF = 43 then
    Result := 'RS';
  if pUF = 50 then
    Result := 'MS';
  if pUF = 51 then
    Result := 'MT';
  if pUF = 52 then
    Result := 'GO';
  if pUF = 53 then
    Result := 'DF';
end;

function VerificaInteiro(Value: String): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to 9 do
  begin
    if Pos(IntToStr(i), Value) <> 0 then
    begin
      Result := True;
      exit;
    end;
  end;
end;

function FileSize(FileName: string): Int64;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(FileName, faAnyFile, SearchRec) = 0 then // se achou o arquivo
    // SearchRec.Size funciona legal para arquivos menores que 2GB
    Result := Int64(SearchRec.FindData.nFileSizeHigh) shl Int64(32) + // calcula o tamanho
      Int64(SearchRec.FindData.nFileSizeLow)
  else
    Result := 0;
//  FindClose(SearchRec); // fecha
end;

function Codifica(Action, Src: String): String;
Label Fim; //Função para criptografar e descriptografar string's
var
  KeyLen : Integer;
  KeyPos : Integer;
  OffSet : Integer;
  Dest, Key : String;
  SrcPos : Integer;
  SrcAsc : Integer;
  TmpSrcAsc : Integer;
  Range : Integer;
begin
  try
    if (Src = '') Then
    begin
      Result:= '';
      Goto Fim;
    end;
    Key := 'YUQL23KL23DF90WI5E1JAS467NMCXXL6JAOAUWWMCL0AOMM4A4VZYW9KHJUI2347EJHJKDF3424SKL K3LAKDJSL9RTIKJ';
    Dest := '';
    KeyLen := Length(Key);
    KeyPos := 0;
    SrcPos := 0;
    SrcAsc := 0;
    Range := 256;
    if (Action = UpperCase('C')) then
    begin
      Randomize;
      OffSet := Random(Range);
      Dest := Format('%1.2x',[OffSet]);
      for SrcPos := 1 to Length(Src) do
      begin
        Application.ProcessMessages;
        SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
        if KeyPos < KeyLen then KeyPos := KeyPos + 1 else KeyPos := 1;
        SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
        Dest := Dest + Format('%1.2x',[SrcAsc]);
        OffSet := SrcAsc;
      end;
    end
    Else if (Action = UpperCase('D')) then
    begin
      OffSet := StrToInt('$'+ copy(Src,1,2));
      SrcPos := 3;
    repeat
      SrcAsc := StrToInt('$'+ copy(Src,SrcPos,2));
      if (KeyPos < KeyLen) Then KeyPos := KeyPos + 1 else KeyPos := 1;
      TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(Src));
    end;
    Result:= Dest;
    Fim:
  Except
    Result:= '1';
  end;
end;

function PeriodoAnterior(pMesAno: String): String;
var
  Mes, Ano: Integer;
begin
  Mes := StrToInt(Copy(pMesAno, 1, 2));
  Ano := StrToInt(Copy(pMesAno, 4, 4));
  if Mes = 1 then
  begin
    Mes := 12;
    Ano := Ano - 1;
    Result := IntToStr(Mes) + '/' + IntToStr(Ano);
  end
  else
    Result := StringOfChar('0', 2 - Length(IntToStr(Mes - 1))) + IntToStr(Mes - 1) + '/' + IntToStr(Ano);
end;

function PeriodoPosterior(pMesAno: String): String;
var
  Mes, Ano: Integer;
begin
  Mes := StrToInt(Copy(pMesAno, 1, 2));
  Ano := StrToInt(Copy(pMesAno, 4, 4));
  if Mes = 12 then
  begin
    Mes := 1;
    Ano := Ano + 1;
    Result := IntToStr(Mes) + '/' + IntToStr(Ano);
  end
  else
    Result := StringOfChar('0', 2 - Length(IntToStr(Mes + 1))) + IntToStr(Mes + 1) + '/' + IntToStr(Ano);
end;

function RetiraMascara(Texto: String): String;
begin
  Result := Texto;
  Result := StringReplace(Result,'*','',[rfReplaceAll]);
  Result := StringReplace(Result,'.','',[rfReplaceAll]);
  Result := StringReplace(Result,'-','',[rfReplaceAll]);
  Result := StringReplace(Result,'/','',[rfReplaceAll]);
  Result := StringReplace(Result,'\','',[rfReplaceAll]);
end;

function PegarPlanoPdv(DescricaoProduto: string): string;
begin
  if ContainsText(DescricaoProduto, 'Mensal') then
    Result := 'M'
  else if ContainsText(DescricaoProduto, 'Semestral') then
    Result := 'S'
  else if ContainsText(DescricaoProduto, 'Anual') then
    Result := 'A';
end;

function PegarModuloFiscalPdv(DescricaoProduto: string): string;
begin
  if ContainsText(DescricaoProduto, 'NFC') then
    Result := 'NFC'
  else if ContainsText(DescricaoProduto, 'SAT') then
    Result := 'SAT'
  else if ContainsText(DescricaoProduto, 'MFE') then
    Result := 'MFE';
end;

function ExecAndWait(ExeNameAndParams: string; ncmdShow: Integer = SW_SHOWNORMAL): Integer;
var
    StartupInfo: TStartupInfo;
    ProcessInformation: TProcessInformation;
    Res: Bool;
    lpExitCode: DWORD;
begin
    with StartupInfo do //you can play with this structure
    begin
        cb := SizeOf(TStartupInfo);
        lpReserved := nil;
        lpDesktop := nil;
        lpTitle := nil;
        dwFlags := STARTF_USESHOWWINDOW;
        wShowWindow := ncmdShow;
        cbReserved2 := 0;
        lpReserved2 := nil;
    end;
    Res := CreateProcess(nil, PChar(ExeNameAndParams), nil, nil, True,
        CREATE_DEFAULT_ERROR_MODE
        or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInformation);
    while True do
    begin
        GetExitCodeProcess(ProcessInformation.hProcess, lpExitCode);
        if lpExitCode <> STILL_ACTIVE then
            Break;
        Application.ProcessMessages;
    end;
    Result := Integer(lpExitCode);
end;

function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure DecodeFileBase64(const base64: AnsiString; const FileName: string);
var
  stream: TBytesStream;
begin
  stream := TBytesStream.Create(DecodeBase64(base64));
  try
    stream.SaveToFile(Filename);
  finally
    stream.Free;
  end;
end;

end.{*******************************************************************************
Title: T2Ti ERP
Description: Biblioteca de funções.

The MIT License

Copyright: Copyright (C) 2020 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

The author may be contacted at:
t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM)
@version 3.0
*******************************************************************************}

unit Biblioteca;

interface

uses
  Messages, SysUtils, StrUtils, Classes, Controls, Forms, Windows,
  IdHashMessageDigest, Constantes, Math, IdGlobal, TlHelp32, EncdDecd,
  // email
  IniFiles,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdBaseComponent,
  IdMessage,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdAttachmentFile,
  IdText;

function Modulo11(Numero: String): String;
Function ValidaCNPJ(xCNPJ: String): Boolean;
Function ValidaCPF(xCPF: String): Boolean;
Function ValidaEstado(Dado: string): Boolean;
Function MixCase(InString: String): String;
Function Hora_Seg(Horas: string): LongInt;
Function Seg_Hora(Seg: LongInt): string;
Function Minuscula(InString: String): String;
Function StrZero(Num: Real; Zeros, Deci: integer): string;
function MD5File(const fileName: string): string;
function MD5FileGed(const pArquivo: TStringStream): string;
function MD5String(const texto: string): string;
Function TruncaValor(Value: Extended; Casas: integer): Extended;
Function ArredondaTruncaValor(Operacao: String; Value: Extended; Casas: integer): Extended;
function UltimoDiaMes(Mdt: TDateTime): String; overload;
function UltimoDiaMes(pMes: String): String; overload;
function FormataFloat(Tipo: String; Valor: Extended): string; // Tipo => 'Q'=Quantidade | 'V'=Valor
procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
function CriaGuidStr: string;
function CaminhoApp: string;
function TextoParaData(pData: string): TDate;
function DataParaTexto(pData: TDate): string;
function DateToSQL(pDate: TDateTime; pComAspas: Boolean = True; pComHoras: Boolean = True): string;
function DatesToSQL(pDataInicial, pDataFinal: TDateTime; pCondicao: string; pIncluirHora: Boolean): string;
function UFToInt(pUF: String): Integer;
function IntToUF(pUF: Integer): String;
function VerificaInteiro(Value: String): Boolean;
function FileSize(FileName: string): Int64;
function Codifica(Action, Src: String): String;
function PeriodoAnterior(pMesAno: String): String;
function PeriodoPosterior(pMesAno: String): String;
function RetiraMascara(Texto:String): String;
function PegarPlanoPdv(DescricaoProduto: string): string;
function PegarModuloFiscalPdv(DescricaoProduto: string): string;
function ExecAndWait(ExeNameAndParams: string; ncmdShow: Integer = SW_SHOWNORMAL): Integer;
function KillTask(ExeFileName: string): Integer;
procedure DecodeFileBase64(const base64: AnsiString; const FileName: string);
function EnviarEmail(AAssunto: string; ADestino: string; ACorpo: string): Boolean;

var
  InString: String;

implementation

function EnviarEmail(AAssunto: string; ADestino: string; ACorpo: string): Boolean;
var
  IniFile              : TIniFile;
  sFrom                : String;
  sBccList             : String;
  sHost                : String;
  iPort                : Integer;
  sUserName            : String;
  sPassword            : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;

  Corpo: TStringList;
begin
  try
    try
      //Criação e leitura do arquivo INI com as configurações
      IniFile := TIniFile.Create('c:\t2ti\config-email.ini');
      sFrom := IniFile.ReadString('Email', 'From', sFrom);
      sBccList := IniFile.ReadString('Email', 'BccList', sBccList);
      sHost := IniFile.ReadString('Email', 'Host', sHost);
      iPort := IniFile.ReadInteger('Email', 'Port', iPort);
      sUserName := IniFile.ReadString('Email', 'UserName', sUserName);
      sPassword := IniFile.ReadString('Email', 'Password', sPassword);

      //Configura os parâmetros necessários para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create;
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Variável referente a mensagem
      idMsg                            := TIdMessage.Create;
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := 'T2Ti.COM';
      idMsg.From.Address               := sFrom;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Destinatário(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;
//      idMsg.CCList.EMailAddresses      := 'PARA@DOMINIO.COM.BR';
//      idMsg.BccList.EMailAddresses    := sBccList;
//      idMsg.BccList.EMailAddresses    := 'PARA@DOMINIO.COM.BR'; //Cópia Oculta

      //Corpo
      idText := TIdText.Create(idMsg.MessageParts);
      idText.Body.Add(ACorpo);
      idText.ContentType := 'text/html; text/plain; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create;
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := sUserName;
      IdSMTP.Password                  := sPassword;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

//      if AAnexo &lt;&gt; EmptyStr then
//        if FileExists(AAnexo) then
//          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conexão foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        IdSMTP.Send(idMsg);
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally
      IniFile.Free;
      UnLoadOpenSSLLibrary;

      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

function Modulo11(Numero: String): String;
var
  i, k: integer;
  Soma: integer;
  Digito: integer;
begin
  Result := '';
  Try
    Soma := 0;
    k := 2;
    for i := Length(Numero) downto 1 do
    begin
      Soma := Soma + (StrToInt(Numero[i]) * k);
      inc(k);
      if k > 9 then
        k := 2;
    end;
    Digito := 11 - Soma mod 11;
    if Digito >= 10 then
      Digito := 0;
    Result := Result + Chr(Digito + Ord('0'));
  except
    Result := 'X';
  end;
end;

{ Valida o CNPJ digitado }
function ValidaCNPJ(xCNPJ: String): Boolean;
Var
  d1, d4, xx, nCount, fator, resto, digito1, digito2: integer;
  Check: String;
begin
  d1 := 0;
  d4 := 0;
  xx := 1;
  for nCount := 1 to Length(xCNPJ) - 2 do
  begin
    if Pos(Copy(xCNPJ, nCount, 1), '/-.') = 0 then
    begin
      if xx < 5 then
      begin
        fator := 6 - xx;
      end
      else
      begin
        fator := 14 - xx;
      end;
      d1 := d1 + StrToInt(Copy(xCNPJ, nCount, 1)) * fator;
      if xx < 6 then
      begin
        fator := 7 - xx;
      end
      else
      begin
        fator := 15 - xx;
      end;
      d4 := d4 + StrToInt(Copy(xCNPJ, nCount, 1)) * fator;
      xx := xx + 1;
    end;
  end;
  resto := (d1 mod 11);
  if resto < 2 then
  begin
    digito1 := 0;
  end
  else
  begin
    digito1 := 11 - resto;
  end;
  d4 := d4 + 2 * digito1;
  resto := (d4 mod 11);
  if resto < 2 then
  begin
    digito2 := 0;
  end
  else
  begin
    digito2 := 11 - resto;
  end;
  Check := IntToStr(digito1) + IntToStr(digito2);
  if Check <> Copy(xCNPJ, succ(Length(xCNPJ) - 2), 2) then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

{ Valida o CPF digitado }
function ValidaCPF(xCPF: String): Boolean;
Var
  d1, d4, xx, nCount, resto, digito1, digito2: integer;
  Check: String;
Begin
  d1 := 0;
  d4 := 0;
  xx := 1;
  for nCount := 1 to Length(xCPF) - 2 do
  begin
    if Pos(Copy(xCPF, nCount, 1), '/-.') = 0 then
    begin
      d1 := d1 + (11 - xx) * StrToInt(Copy(xCPF, nCount, 1));
      d4 := d4 + (12 - xx) * StrToInt(Copy(xCPF, nCount, 1));
      xx := xx + 1;
    end;
  end;
  resto := (d1 mod 11);
  if resto < 2 then
  begin
    digito1 := 0;
  end
  else
  begin
    digito1 := 11 - resto;
  end;
  d4 := d4 + 2 * digito1;
  resto := (d4 mod 11);
  if resto < 2 then
  begin
    digito2 := 0;
  end
  else
  begin
    digito2 := 11 - resto;
  end;
  Check := IntToStr(digito1) + IntToStr(digito2);
  if Check <> Copy(xCPF, succ(Length(xCPF) - 2), 2) then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

{ Valida a UF digitada }
function ValidaEstado(Dado: string): Boolean;
const
  Estados = 'SPMGRJRSSCPRESDFMTMSGOTOBASEALPBPEMARNCEPIPAAMAPFNACRRRO';
var
  Posicao: integer;
begin
  Result := True;
  if Dado <> '' then
  begin
    Posicao := Pos(UpperCase(Dado), Estados);
    if (Posicao = 0) or ((Posicao mod 2) = 0) then
    begin
      Result := False;
    end;
  end;
end;

{ Corrige a string que contenha caracteres maiusculos
  inseridos no meio dela para tudo minusculo e com a
  primeira letra maiuscula }
Function MixCase(InString: String): String;
Var
  i: integer;
Begin
  Result := LowerCase(InString);
  Result[1] := UpCase(Result[1]);
  For i := 1 To Length(InString) - 1 Do
  Begin
    If (Result[i] = ' ') Or (Result[i] = '''') Or (Result[i] = '"') Or (Result[i] = '-') Or (Result[i] = '.') Or (Result[i] = '(') Then
      Result[i + 1] := UpCase(Result[i + 1]);
    if Result[i] = 'Ç' then
      Result[i] := 'ç';
    if Result[i] = 'Ã' then
      Result[i] := 'ã';
    if Result[i] = 'Á' then
      Result[i] := 'á';
    if Result[i] = 'É' then
      Result[i] := 'é';
    if Result[i] = 'Í' then
      Result[i] := 'í';
    if Result[i] = 'Õ' then
      Result[i] := 'õ';
    if Result[i] = 'Ó' then
      Result[i] := 'ó';
    if Result[i] = 'Ú' then
      Result[i] := 'ú';
    if Result[i] = 'Â' then
      Result[i] := 'â';
    if Result[i] = 'Ê' then
      Result[i] := 'ê';
    if Result[i] = 'Ô' then
      Result[i] := 'ô';
  End;
End;

{ Converte de hora para segundos }
function Hora_Seg(Horas: string): LongInt;
Var
  Hor, Min, Seg: LongInt;
begin
  Horas[Pos(':', Horas)] := '[';
  Horas[Pos(':', Horas)] := ']';
  Hor := StrToInt(Copy(Horas, 1, Pos('[', Horas) - 1));
  Min := StrToInt(Copy(Horas, Pos('[', Horas) + 1, (Pos(']', Horas) - Pos('[', Horas) - 1)));
  if Pos(':', Horas) > 0 then
    Seg := StrToInt(Copy(Horas, Pos(']', Horas) + 1, (Pos(':', Horas) - Pos(']', Horas) - 1)))
  else
    Seg := StrToInt(Copy(Horas, Pos(']', Horas) + 1, 2));
  Result := Seg + (Hor * 3600) + (Min * 60);
end;

{ Converte de segundos para hora }
function Seg_Hora(Seg: LongInt): string;
Var
  Hora, Min: LongInt;
  Tmp: Double;
begin
  Tmp := Seg / 3600;
  Hora := Round(Int(Tmp));
  Seg := Round(Seg - (Hora * 3600));
  Tmp := Seg / 60;
  Min := Round(Int(Tmp));
  Seg := Round(Seg - (Min * 60));
  Result := StrZero(Hora, 2, 0) + ':' + StrZero(Min, 2, 0) + ':' + StrZero(Seg, 2, 0);
end;

{ converte tudo para minuscula }
Function Minuscula(InString: String): String;
Var
  i: integer;
Begin
  Result := LowerCase(InString);
  For i := 1 To Length(InString) - 1 Do
  Begin
    If (Result[i] = ' ') Or (Result[i] = '''') Or (Result[i] = '"') Or (Result[i] = '-') Or (Result[i] = '.') Or (Result[i] = '(') Then
      Result[i] := UpCase(Result[i]);
    if Result[i] = 'Ç' then
      Result[i] := 'ç';
    if Result[i] = 'Ã' then
      Result[i] := 'ã';
    if Result[i] = 'Á' then
      Result[i] := 'á';
    if Result[i] = 'É' then
      Result[i] := 'é';
    if Result[i] = 'Í' then
      Result[i] := 'í';
    if Result[i] = 'Õ' then
      Result[i] := 'õ';
    if Result[i] = 'Ó' then
      Result[i] := 'ó';
    if Result[i] = 'Ú' then
      Result[i] := 'ú';
    if Result[i] = 'Â' then
      Result[i] := 'â';
    if Result[i] = 'Ê' then
      Result[i] := 'ê';
    if Result[i] = 'Ô' then
      Result[i] := 'ô';
  End;
End;

function StrZero(Num: Real; Zeros, Deci: integer): string;
var
  Tam, Z: integer;
  Res, Zer: string;
begin
{$WARNINGS OFF}
  Str(Num: Zeros: Deci, Res);
  Res := Trim(Res);
  Tam := Length(Res);
  Zer := '';
  for Z := 01 to (Zeros - Tam) do
    Zer := Zer + '0';
  Result := Zer + Res;
{$WARNINGS ON}
end;

function MD5File(const fileName: string): string;
var
  idmd5: TIdHashMessageDigest5;
  fs: TFileStream;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  fs := TFileStream.Create(fileName, fmOpenRead OR fmShareDenyWrite);
  try
    Result := idmd5.HashStreamAsHex(fs);
  finally
    fs.Free;
    idmd5.Free;
  end;
end;

function MD5FileGed(const pArquivo: TStringStream): string;
var
  idmd5: TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    Result := idmd5.HashBytesAsHex(TIdBytes(pArquivo.Bytes));
  finally
    idmd5.Free;
  end;
end;

function MD5String(const texto: string): string;
var
  idmd5: TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    Result := LowerCase(idmd5.HashStringAsHex(texto));
  finally
    idmd5.Free;
  end;
end;

Function TruncaValor(Value: Extended; Casas: integer): Extended;
Var
  sValor: String;
  nPos: integer;
begin
  // Transforma o valor em string
  sValor := FloatToStr(Value);

  // Verifica se possui ponto decimal
  nPos := Pos(FormatSettings.DecimalSeparator, sValor);
  If (nPos > 0) Then
  begin
    sValor := Copy(sValor, 1, nPos + Casas);
  End;

  Result := StrToFloat(sValor);
end;

Function ArredondaTruncaValor(Operacao: String; Value: Extended; Casas: integer): Extended;
Var
  sValor: String;
  nPos: integer;
begin
  if Operacao = 'A' then
    Result := SimpleRoundTo(Value, Casas * -1)
  else
  begin
    // Transforma o valor em string
    sValor := FloatToStr(Value);

    // Verifica se possui ponto decimal
    nPos := Pos(FormatSettings.DecimalSeparator, sValor);
    If (nPos > 0) Then
    begin
      sValor := Copy(sValor, 1, nPos + Casas);
    End;

    Result := StrToFloat(sValor);
  end;
end;

function UltimoDiaMes(Mdt: TDateTime): String;
var
  ano, mes, dia: word;
  mDtTemp: TDateTime;
begin
  Decodedate(Mdt, ano, mes, dia);
  mDtTemp := (Mdt - dia) + 33;
  Decodedate(mDtTemp, ano, mes, dia);
  mDtTemp := mDtTemp - dia;
  Decodedate(mDtTemp, ano, mes, dia);
  Result := IntToStr(dia)
end;

function UltimoDiaMes(pMes: String): String;
var
  ano, mes, dia: word;
  mDtTemp: TDateTime;
  Mdt: TDateTime;
begin
  Mdt := StrToDateTime('01/' + pMes + '/' + FormatDateTime('YYYY', Now));
  Decodedate(Mdt, ano, mes, dia);
  mDtTemp := (Mdt - dia) + 33;
  Decodedate(mDtTemp, ano, mes, dia);
  mDtTemp := mDtTemp - dia;
  Decodedate(mDtTemp, ano, mes, dia);
  Result := IntToStr(dia)
end;

function FormataFloat(Tipo: String; Valor: Extended): string; // Tipo => 'Q'=Quantidade | 'V'=Valor
var
  i: integer;
  Mascara: String;
begin
  Mascara := '0.';

  if Tipo = 'Q' then
  begin
    for i := 1 to Constantes.TConstantes.DECIMAIS_QUANTIDADE do
      Mascara := Mascara + '0';
  end
  else if Tipo = 'V' then
  begin
    for i := 1 to Constantes.TConstantes.DECIMAIS_VALOR do
      Mascara := Mascara + '0';
  end;

  Result := FormatFloat(Mascara, Valor);
end;

procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

function CriaGuidStr: string;
var
  Guid: TGUID;
begin
  CreateGUID(Guid);
  Result := GUIDToString(Guid);
end;

function CaminhoApp: string;
begin
  Result := ExtractFileDir(GetCurrentDir);
end;

function TextoParaData(pData: string): TDate;
var
  dia, mes, ano: integer;
begin
  if (pData <> '') AND (pData <> '0000-00-00') then
  begin
    dia := StrToInt(Copy(pData, 9, 2));
    mes := StrToInt(Copy(pData, 6, 2));
    ano := StrToInt(Copy(pData, 1, 4));
    Result := EncodeDate(ano, mes, dia);
  end
  else
  begin
    Result := 0;
  end;
end;

function DataParaTexto(pData: TDate): string;
begin
  if pData > 0 then
    Result := FormatDateTime('YYYY-MM-DD', pData)
  else
    Result := '0000-00-00';
end;

function DateToSQL(pDate: TDateTime; pComAspas: Boolean = True; pComHoras: Boolean = True): string;
var
  ano, mes, dia, Hora, Minuto, Segundo, MileSegundo: word;
begin
  Decodedate(pDate, ano, mes, dia);

  Result := IntToStr(ano) + '-' + IntToStr(mes) + '-' + IntToStr(dia);

  DecodeTime(pDate, Hora, Minuto, Segundo, MileSegundo);

  if ((Hora + Minuto + Segundo) > 0) and (pComHoras) then
  begin
    Result := Result + ' ' + IntToStr(Hora) + ':' + IntToStr(Minuto) + ':' + IntToStr(Segundo);
  end;

  if pComAspas then
  begin
    Result := QuotedStr(Result);
  end;
end;

function DatesToSQL(pDataInicial, pDataFinal: TDateTime; pCondicao: string; pIncluirHora: Boolean): string;
begin
  if (pDataInicial > 0) and (pDataFinal > 0) then
  begin
    if pIncluirHora then
    begin
      Result := pCondicao + ' BETWEEN ' + QuotedStr(DateToSQL(pDataInicial, False, False) + ' 00:00:00') + ' AND ' + QuotedStr(DateToSQL(pDataFinal, False, False) + ' 23:59:59');
    end
    else
    begin
      Result := pCondicao + ' BETWEEN ' + DateToSQL(pDataInicial, True, False) + ' AND ' + DateToSQL(pDataFinal, True, False);
    end;
  end
  else if (pDataInicial > 0) and (pDataFinal = 0) then
    Result := pCondicao + ' >= ' + DateToSQL(pDataInicial, True, False)
  else if (pDataInicial = 0) and (pDataFinal > 0) then
  begin
    if pIncluirHora then
    begin
      Result := pCondicao + ' <= ' + QuotedStr(DateToSQL(pDataFinal, False, False) + ' 23:59:59');
    end
    else
    begin
      Result := pCondicao + ' <= ' + DateToSQL(pDataFinal, True, False);
    end;
  end
  else
    Result := '';
end;

// função auxiliar para converte UF do cliente para codigo
function UFToInt(pUF: String): integer;
begin
  Result := 0;
  if pUF = 'RO' then
    Result := 11;
  if pUF = 'AC' then
    Result := 12;
  if pUF = 'AM' then
    Result := 13;
  if pUF = 'RR' then
    Result := 14;
  if pUF = 'PA' then
    Result := 15;
  if pUF = 'AP' then
    Result := 16;
  if pUF = 'TO' then
    Result := 17;
  if pUF = 'MA' then
    Result := 21;
  if pUF = 'PI' then
    Result := 22;
  if pUF = 'CE' then
    Result := 23;
  if pUF = 'RN' then
    Result := 24;
  if pUF = 'PB' then
    Result := 25;
  if pUF = 'PE' then
    Result := 26;
  if pUF = 'AL' then
    Result := 27;
  if pUF = 'SE' then
    Result := 28;
  if pUF = 'BA' then
    Result := 29;
  if pUF = 'MG' then
    Result := 31;
  if pUF = 'ES' then
    Result := 32;
  if pUF = 'RJ' then
    Result := 33;
  if pUF = 'SP' then
    Result := 35;
  if pUF = 'PR' then
    Result := 41;
  if pUF = 'SC' then
    Result := 42;
  if pUF = 'RS' then
    Result := 43;
  if pUF = 'MS' then
    Result := 50;
  if pUF = 'MT' then
    Result := 51;
  if pUF = 'GO' then
    Result := 52;
  if pUF = 'DF' then
    Result := 53;
end;

// função auxiliar para converte Codigo UF do cliente para UF
function IntToUF(pUF: integer): String;
begin
  Result := '';
  if pUF = 11 then
    Result := 'RO';
  if pUF = 12 then
    Result := 'AC';
  if pUF = 13 then
    Result := 'AM';
  if pUF = 14 then
    Result := 'RR';
  if pUF = 15 then
    Result := 'PA';
  if pUF = 16 then
    Result := 'AP';
  if pUF = 17 then
    Result := 'TO';
  if pUF = 21 then
    Result := 'MA';
  if pUF = 22 then
    Result := 'PI';
  if pUF = 23 then
    Result := 'CE';
  if pUF = 24 then
    Result := 'RN';
  if pUF = 25 then
    Result := 'PB';
  if pUF = 26 then
    Result := 'PE';
  if pUF = 27 then
    Result := 'AL';
  if pUF = 28 then
    Result := 'SE';
  if pUF = 29 then
    Result := 'BA';
  if pUF = 31 then
    Result := 'MG';
  if pUF = 32 then
    Result := 'ES';
  if pUF = 33 then
    Result := 'RJ';
  if pUF = 35 then
    Result := 'SP';
  if pUF = 41 then
    Result := 'PR';
  if pUF = 42 then
    Result := 'SC';
  if pUF = 43 then
    Result := 'RS';
  if pUF = 50 then
    Result := 'MS';
  if pUF = 51 then
    Result := 'MT';
  if pUF = 52 then
    Result := 'GO';
  if pUF = 53 then
    Result := 'DF';
end;

function VerificaInteiro(Value: String): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to 9 do
  begin
    if Pos(IntToStr(i), Value) <> 0 then
    begin
      Result := True;
      exit;
    end;
  end;
end;

function FileSize(FileName: string): Int64;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(FileName, faAnyFile, SearchRec) = 0 then // se achou o arquivo
    // SearchRec.Size funciona legal para arquivos menores que 2GB
    Result := Int64(SearchRec.FindData.nFileSizeHigh) shl Int64(32) + // calcula o tamanho
      Int64(SearchRec.FindData.nFileSizeLow)
  else
    Result := 0;
//  FindClose(SearchRec); // fecha
end;

function Codifica(Action, Src: String): String;
Label Fim; //Função para criptografar e descriptografar string's
var
  KeyLen : Integer;
  KeyPos : Integer;
  OffSet : Integer;
  Dest, Key : String;
  SrcPos : Integer;
  SrcAsc : Integer;
  TmpSrcAsc : Integer;
  Range : Integer;
begin
  try
    if (Src = '') Then
    begin
      Result:= '';
      Goto Fim;
    end;
    Key := 'YUQL23KL23DF90WI5E1JAS467NMCXXL6JAOAUWWMCL0AOMM4A4VZYW9KHJUI2347EJHJKDF3424SKL K3LAKDJSL9RTIKJ';
    Dest := '';
    KeyLen := Length(Key);
    KeyPos := 0;
    SrcPos := 0;
    SrcAsc := 0;
    Range := 256;
    if (Action = UpperCase('C')) then
    begin
      Randomize;
      OffSet := Random(Range);
      Dest := Format('%1.2x',[OffSet]);
      for SrcPos := 1 to Length(Src) do
      begin
        Application.ProcessMessages;
        SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
        if KeyPos < KeyLen then KeyPos := KeyPos + 1 else KeyPos := 1;
        SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
        Dest := Dest + Format('%1.2x',[SrcAsc]);
        OffSet := SrcAsc;
      end;
    end
    Else if (Action = UpperCase('D')) then
    begin
      OffSet := StrToInt('$'+ copy(Src,1,2));
      SrcPos := 3;
    repeat
      SrcAsc := StrToInt('$'+ copy(Src,SrcPos,2));
      if (KeyPos < KeyLen) Then KeyPos := KeyPos + 1 else KeyPos := 1;
      TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(Src));
    end;
    Result:= Dest;
    Fim:
  Except
    Result:= '1';
  end;
end;

function PeriodoAnterior(pMesAno: String): String;
var
  Mes, Ano: Integer;
begin
  Mes := StrToInt(Copy(pMesAno, 1, 2));
  Ano := StrToInt(Copy(pMesAno, 4, 4));
  if Mes = 1 then
  begin
    Mes := 12;
    Ano := Ano - 1;
    Result := IntToStr(Mes) + '/' + IntToStr(Ano);
  end
  else
    Result := StringOfChar('0', 2 - Length(IntToStr(Mes - 1))) + IntToStr(Mes - 1) + '/' + IntToStr(Ano);
end;

function PeriodoPosterior(pMesAno: String): String;
var
  Mes, Ano: Integer;
begin
  Mes := StrToInt(Copy(pMesAno, 1, 2));
  Ano := StrToInt(Copy(pMesAno, 4, 4));
  if Mes = 12 then
  begin
    Mes := 1;
    Ano := Ano + 1;
    Result := IntToStr(Mes) + '/' + IntToStr(Ano);
  end
  else
    Result := StringOfChar('0', 2 - Length(IntToStr(Mes + 1))) + IntToStr(Mes + 1) + '/' + IntToStr(Ano);
end;

function RetiraMascara(Texto: String): String;
begin
  Result := Texto;
  Result := StringReplace(Result,'*','',[rfReplaceAll]);
  Result := StringReplace(Result,'.','',[rfReplaceAll]);
  Result := StringReplace(Result,'-','',[rfReplaceAll]);
  Result := StringReplace(Result,'/','',[rfReplaceAll]);
  Result := StringReplace(Result,'\','',[rfReplaceAll]);
end;

function PegarPlanoPdv(DescricaoProduto: string): string;
begin
  if ContainsText(DescricaoProduto, 'Mensal') then
    Result := 'M'
  else if ContainsText(DescricaoProduto, 'Semestral') then
    Result := 'S'
  else if ContainsText(DescricaoProduto, 'Anual') then
    Result := 'A';
end;

function PegarModuloFiscalPdv(DescricaoProduto: string): string;
begin
  if ContainsText(DescricaoProduto, 'NFC') then
    Result := 'NFC'
  else if ContainsText(DescricaoProduto, 'SAT') then
    Result := 'SAT'
  else if ContainsText(DescricaoProduto, 'MFE') then
    Result := 'MFE';
end;

function ExecAndWait(ExeNameAndParams: string; ncmdShow: Integer = SW_SHOWNORMAL): Integer;
var
    StartupInfo: TStartupInfo;
    ProcessInformation: TProcessInformation;
    Res: Bool;
    lpExitCode: DWORD;
begin
    with StartupInfo do //you can play with this structure
    begin
        cb := SizeOf(TStartupInfo);
        lpReserved := nil;
        lpDesktop := nil;
        lpTitle := nil;
        dwFlags := STARTF_USESHOWWINDOW;
        wShowWindow := ncmdShow;
        cbReserved2 := 0;
        lpReserved2 := nil;
    end;
    Res := CreateProcess(nil, PChar(ExeNameAndParams), nil, nil, True,
        CREATE_DEFAULT_ERROR_MODE
        or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInformation);
    while True do
    begin
        GetExitCodeProcess(ProcessInformation.hProcess, lpExitCode);
        if lpExitCode <> STILL_ACTIVE then
            Break;
        Application.ProcessMessages;
    end;
    Result := Integer(lpExitCode);
end;

function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure DecodeFileBase64(const base64: AnsiString; const FileName: string);
var
  stream: TBytesStream;
begin
  stream := TBytesStream.Create(DecodeBase64(base64));
  try
    stream.SaveToFile(Filename);
  finally
    stream.Free;
  end;
end;

end.
