{*******************************************************************************
Title: T2Ti ERP Fenix
Description: Service relacionado ao ACBrMonitor

The MIT License

Copyright: Copyright (C) 2022 T2Ti.COM

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
           t2ti.com@gmail.com

@author Albert Eije (alberteije@gmail.com)
@version 1.0.0
*******************************************************************************}
unit AcbrMonitorService;

interface

uses
  Empresa, ObjetoNfe, EmpresaService,
  System.Classes, System.SysUtils, System.Generics.Collections, ServiceBase,
  MVCFramework.DataSet.Utils, StrUtils, IniFiles, Biblioteca, System.Zip, ShellApi,
  Winapi.Windows;

type

  TAcbrMonitorService = class(TServiceBase)
  private
    class function AguardarArquivoSaida: Boolean;
    class function ApagarArquivoSaida: Boolean;
    class function PassarParaModoOffLine: Boolean;
    class function PassarParaModoOnLine: Boolean;
    class procedure ImprimirDanfe(ACaminhoArquivoXml: string);
    class procedure EnviarNFe(ACaminhoArquivoXml: string);
    class procedure CriarNFe(ACaminhoArquivoIniNfce: string);
    class procedure GerarArquivoEntrada(AComando: string);
    class function PegarRetornoSaida(AOperacao: string): string;
  public
    class function EmitirNfce(ANumero: string; ACnpj: string; ANfceIni: AnsiString): string;
    class function TransmitirNfceContingenciada(AChave: string; ACnpj: string): string;
    class function EmitirNfceContingencia(ANumero: string; ACnpj: string; ANfceIni: AnsiString): string;
    class function TratarNotaAnteriorContingencia(AObjetoNfe: TObjetoNfe): string;
    class function InutilizarNumero(AObjetoNfe: TObjetoNfe): string;
    class function CancelarNfce(AChave: string; AMotivo: string; ACnpj: string): string;
    class function GerarPDFDanfeNFCe(AChave: string; ACnpj: string): string;
    class function GerarZipArquivosXml(APeriodo: string; ACnpj: string): Boolean;
    class procedure AtualizarCertificado(ACertificadoBase64: AnsiString; ASenha: string; ACnpj: string);
  end;

var
  CaminhoComCnpj: string;
  Empresa: TEmpresa;

implementation

{ TAcbrMonitorService }

class function TAcbrMonitorService.EmitirNfce(ANumero: string; ACnpj: string; ANfceIni: AnsiString): string;
var
  CaminhoArquivoIniNfce, CaminhoArquivoXml: string;
begin
  // configurações
  CaminhoComCnpj := 'C:\ACBrMonitor\' + ACnpj + '\';
  // salva o arquivo INI em disco
  CaminhoArquivoIniNfce := CaminhoComCnpj + 'ini\nfce\' + ANumero + '.ini';
  Biblioteca.DecodeFileBase64(ANfceIni, CaminhoArquivoIniNfce);
  // chama o método para criar a nota
  CriarNFe(CaminhoArquivoIniNfce);
  // pega o caminho do XML criado
  CaminhoArquivoXml := PegarRetornoSaida('ARQUIVO-XML');
  // chama o método para criar e enviar a nota
  EnviarNFe(CaminhoArquivoXml);
  // PegarRetornoSaida
  Result := PegarRetornoSaida('Envio');
  if not Result.Contains('ERRO') then
  begin
    // chama o método para gerar o PDF
    ImprimirDanfe(CaminhoArquivoXml);
    // captura o retorno do arquivo SAI
    Result := PegarRetornoSaida('ARQUIVO-PDF');
  end;
end;

class function TAcbrMonitorService.EmitirNfceContingencia(ANumero: string; ACnpj: string; ANfceIni: AnsiString): string;
var
  CaminhoArquivoIniNfce, CaminhoArquivoXml: string;
begin
  // configurações
  CaminhoComCnpj := 'C:\ACBrMonitor\' + ACnpj + '\';
  // salva o arquivo INI em disco
  CaminhoArquivoIniNfce := CaminhoComCnpj + 'ini\nfce\' + ANumero + '.ini';
  Biblioteca.DecodeFileBase64(ANfceIni, CaminhoArquivoIniNfce);
  // passa para o modo de emissão off-line
  PassarParaModoOffLine;
  // chama o método para criar a nota
  CriarNFe(CaminhoArquivoIniNfce);
  // pega o caminho do XML criado
  CaminhoArquivoXml := PegarRetornoSaida('ARQUIVO-XML');
  // chama o método para gerar o PDF
  ImprimirDanfe(CaminhoArquivoXml);
  // captura o retorno do arquivo SAI
  Result := PegarRetornoSaida('ARQUIVO-PDF');
  // passa para o modo de emissão on-line
  PassarParaModoOnLine;
end;

class function TAcbrMonitorService.TransmitirNfceContingenciada(AChave: string; ACnpj: string): string;
var
  CaminhoArquivoXml: string;
begin
  // configurações
  CaminhoComCnpj := 'C:\ACBrMonitor\' + ACnpj + '\';
  // pega o caminho do arquivo XML da nota em contingência
  CaminhoArquivoXml := CaminhoComCnpj + 'LOG_NFe\' + AChave + '-nfe.xml';
  // chama o método para criar e enviar a nota
  EnviarNFe(CaminhoArquivoXml);
  // PegarRetornoSaida
  Result := PegarRetornoSaida('Envio');
  if not Result.Contains('ERRO') then
  begin
    // chama o método para gerar o PDF
    ImprimirDanfe(CaminhoArquivoXml);
    // captura o retorno do arquivo SAI
    Result := PegarRetornoSaida('ARQUIVO-PDF');
  end;
end;

class function TAcbrMonitorService.TratarNotaAnteriorContingencia(AObjetoNfe: TObjetoNfe): string;
var
  CaminhoArquivoXml: string;
begin
  // configurações
  CaminhoComCnpj := 'C:\ACBrMonitor\' + AObjetoNfe.Cnpj + '\';
  CaminhoArquivoXml := CaminhoComCnpj + 'LOG_NFe\' + AObjetoNfe.ChaveAcesso + '-nfe.xml';

  // vamos verificar o status da nota
  ApagarArquivoSaida;
  GerarArquivoEntrada('NFE.ConsultarNFe("' + CaminhoArquivoXml + '")');
  AguardarArquivoSaida;

  Result := PegarRetornoSaida('Consulta');
  if not Result.Contains('ERRO') then
  begin
    // se a nota anterior foi emitida = cancela. senão = inutiliza.
    if Result.Contains('Autorizado') then
    begin
      Result := CancelarNfce(AObjetoNfe.ChaveAcesso, AObjetoNfe.Justificativa, AObjetoNfe.Cnpj);
    end
    else
    begin
      Result := InutilizarNumero(AObjetoNfe);
    end;
  end;
end;

class function TAcbrMonitorService.InutilizarNumero(AObjetoNfe: TObjetoNfe): string;
begin
  // configurações
  CaminhoComCnpj := 'C:\ACBrMonitor\' + AObjetoNfe.Cnpj + '\';
  ApagarArquivoSaida;

  GerarArquivoEntrada('NFE.InutilizarNFe('
      +AObjetoNfe.Cnpj +', '
      +AObjetoNfe.Justificativa+', '
      +AObjetoNfe.Ano+', '
      +AObjetoNfe.Modelo+', '
      +AObjetoNfe.Serie+', '
      +AObjetoNfe.NumeroInicial+', '
      +AObjetoNfe.NumeroFinal+')');

  AguardarArquivoSaida;
  Result := PegarRetornoSaida('Inutilizacao');
end;

class function TAcbrMonitorService.CancelarNfce(AChave: string; AMotivo: string; ACnpj: string): string;
begin
  CaminhoComCnpj := 'C:\ACBrMonitor\' + ACnpj + '\';
  ApagarArquivoSaida;
  GerarArquivoEntrada('NFe.CANCELARNFE("' + AChave + '", "' + AMotivo + '", "' + ACnpj + '")');
  AguardarArquivoSaida;
  Result := PegarRetornoSaida('Cancelamento');
end;

class function TAcbrMonitorService.GerarPDFDanfeNFCe(AChave: string; ACnpj: string): string;
var
  CaminhoArquivoXml: string;
begin
  // configurações
  CaminhoComCnpj := 'C:\ACBrMonitor\' + ACnpj + '\';
  // pega o caminho do arquivo XML da nota em contingência
  CaminhoArquivoXml := CaminhoComCnpj + 'LOG_NFe\' + AChave + '-nfe.xml';
  // chama o método para gerar o PDF
  ImprimirDanfe(CaminhoArquivoXml);
  // captura o retorno do arquivo SAI
  Result := PegarRetornoSaida('ARQUIVO-PDF');
end;

class procedure TAcbrMonitorService.EnviarNFe(ACaminhoArquivoXml: string);
begin
  ApagarArquivoSaida;
  GerarArquivoEntrada('NFE.EnviarNFe("' + ACaminhoArquivoXml + '", "001", , , , "1", , )');
  AguardarArquivoSaida;
end;

class procedure TAcbrMonitorService.CriarNFe(ACaminhoArquivoIniNfce: string);
begin
  ApagarArquivoSaida;
  GerarArquivoEntrada('NFE.CriarNFe("' + ACaminhoArquivoIniNfce + '")');
  AguardarArquivoSaida;
end;

class procedure TAcbrMonitorService.ImprimirDanfe(ACaminhoArquivoXml: string);
begin
  ApagarArquivoSaida;
  GerarArquivoEntrada('NFE.ImprimirDANFEPDF("'+ ACaminhoArquivoXml + '", , , "1",)');
  AguardarArquivoSaida;
end;

class function TAcbrMonitorService.PassarParaModoOffLine: Boolean;
begin
  Result := False;
  ApagarArquivoSaida;
  GerarArquivoEntrada('NFE.SetFormaEmissao(9)'); // 9=offline
  Result := AguardarArquivoSaida;
end;

class function TAcbrMonitorService.PassarParaModoOnLine: Boolean;
begin
  Result := False;
  ApagarArquivoSaida;
  GerarArquivoEntrada('NFE.SetFormaEmissao(1)'); // 1=normal
  Result := AguardarArquivoSaida;
end;

class function TAcbrMonitorService.GerarZipArquivosXml(APeriodo: string; ACnpj: string): Boolean;
var
  Filtro, NomeArquivoZIP, Caminho: string;
begin
  Result := False;
  Filtro := 'CNPJ = "' + ACnpj + '"';
  Empresa := TEmpresaService.ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    NomeArquivoZIP := 'C:\ACBrMonitor\' + ACnpj + '\NotasFiscaisNFCe_' + APeriodo + '.zip';
    Caminho := 'C:\ACBrMonitor\' + ACnpj + '\DFes\' + APeriodo;
    TZipFile.ZipDirectoryContents(NomeArquivoZIP, Caminho);
  	Result := True;
  end;
end;

class procedure TAcbrMonitorService.AtualizarCertificado(ACertificadoBase64: AnsiString; ASenha: string; ACnpj: string);
var
  ACBrMonitorIni: TIniFile;
  Filtro, CaminhoArquivoCertificado: string;
  CaminhoExecutavel: PWideChar;
begin
  Filtro := 'CNPJ = "' + ACnpj + '"';
  Empresa := TEmpresaService.ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    // configura os caminhos
    CaminhoComCnpj := 'C:\ACBrMonitor\' + Empresa.Cnpj + '\';
    CaminhoArquivoCertificado := CaminhoComCnpj + Empresa.Cnpj + '.pfx';

    // salva o arquivo base64 em disco
    Biblioteca.DecodeFileBase64(ACertificadoBase64, CaminhoArquivoCertificado);

    ApagarArquivoSaida;
    GerarArquivoEntrada('NFE.SetCertificado(' + CaminhoArquivoCertificado + ',' + ASenha + ')');
    AguardarArquivoSaida;

    Biblioteca.KillTask('ACBrMonitor_' + Empresa.Cnpj + '.exe');
    CaminhoExecutavel := PWideChar(CaminhoComCnpj + 'ACBrMonitor_' + Empresa.Cnpj + '.exe');
    ShellExecute(0, 'open', (CaminhoExecutavel), nil, nil, SW_HIDE);
  end;
end;

class procedure TAcbrMonitorService.GerarArquivoEntrada(AComando: string);
var
  ArquivoEntrada: TextFile;
begin
  AssignFile(ArquivoEntrada, PWideChar(CaminhoComCnpj + 'ent.txt'));
  Rewrite(ArquivoEntrada);
  Writeln(ArquivoEntrada, AComando);
  CloseFile(ArquivoEntrada);
end;

class function TAcbrMonitorService.PegarRetornoSaida(AOperacao: string): string;
var
  ArquivoSaida: TIniFile;
  Resposta, Motivo, CodigoStatus, CaminhoArquivoXml, CaminhoArquivoPdf: string;
  ArquivoCompleto: TStringList;
begin
  Result := '';

  ArquivoSaida := TIniFile.Create(CaminhoComCnpj + 'sai.txt');
  ArquivoCompleto := TStringList.Create;
  ArquivoCompleto.LoadFromFile(CaminhoComCnpj + 'sai.txt');

  CodigoStatus := ArquivoSaida.ReadString(AOperacao, 'CStat', '');
  Motivo := ArquivoSaida.ReadString(AOperacao, 'XMotivo', '');

  try
    if AOperacao = 'ARQUIVO-XML' then // não está no formato INI
    begin
      CaminhoArquivoXml := ArquivoCompleto[0];
      CaminhoArquivoXml := StringReplace(CaminhoArquivoXml, 'OK: ', '', [rfReplaceAll, rfIgnoreCase]);
      CaminhoArquivoXml := Trim(CaminhoArquivoXml);
      Result := CaminhoArquivoXml;
    end
    else if AOperacao = 'ARQUIVO-PDF' then // não está no formato INI
    begin
      CaminhoArquivoPdf := ArquivoCompleto.Text;
      CaminhoArquivoPdf := StringReplace(CaminhoArquivoPdf, 'OK: Arquivo criado em: ', '', [rfReplaceAll, rfIgnoreCase]);
      Result := Trim(CaminhoArquivoPdf);
    end
    else if AOperacao = 'Cancelamento' then
    begin
      Result := Motivo;
    end
    else if AOperacao = 'Consulta' then
    begin
      Result := Motivo;
    end
    else if AOperacao = 'Inutilizacao' then // não está no formato INI
    begin
      Result := ArquivoCompleto.Text;
    end;

    if not MatchStr(CodigoStatus, // se o status não for um dos que estiverem nessa lista, vamos retornar um erro.
        [
        '',     // efetuando alguma operação que não retorna código de status
        '100',  // Autorizado o uso da NF-e
        '102',  // Inutilização de número homologado
        '135'   // Evento registrado e vinculado a NF-e (cancelamento)
        ]
    ) then
    begin
      Result := '[ERRO] - [' + CodigoStatus + '] ' + Motivo;
    end;
  finally
    ArquivoSaida.Free;
    ArquivoCompleto.Free;
  end;
end;

class function TAcbrMonitorService.ApagarArquivoSaida: Boolean;
begin
  DeleteFile(PWideChar(CaminhoComCnpj + 'sai.txt'));
end;

class function TAcbrMonitorService.AguardarArquivoSaida: Boolean;
var
  TempoEspera: Integer;
begin
  Result := False;
  TempoEspera := 0;
  // aguarda o arquivo de saída
  while not FileExists(CaminhoComCnpj + 'sai.txt') do
  begin
    Sleep(1000);
    Inc(TempoEspera);

    if TempoEspera > 30 then
    begin
      // ocorreu algum problema, demorou 10 segundos esperando o arquivo sai
      Exit;
    end;

    Result := True;
  end;
end;

end.
