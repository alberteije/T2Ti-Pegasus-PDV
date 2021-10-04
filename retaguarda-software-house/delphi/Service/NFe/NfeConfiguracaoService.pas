{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
unit NfeConfiguracaoService;

interface

uses
  NfeConfiguracao, Empresa, EmpresaService, Biblioteca, ACbrMonitorPorta, AcbrMonitorPortaService,
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils,
  Vcl.Forms, Winapi.Windows, IniFiles, ShellApi, System.Zip, MVCFramework.Logger;

type

  TNfeConfiguracaoService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TNfeConfiguracao>;
    class function ConsultarListaFiltro(AWhere: string): TObjectList<TNfeConfiguracao>;
    class function ConsultarObjeto(AId: Integer): TNfeConfiguracao;
    class function ConsultarObjetoFiltro(AWhere: string): TNfeConfiguracao;
    class procedure Inserir(ANfeConfiguracao: TNfeConfiguracao);
    class function Atualizar(ANfeConfiguracao: TNfeConfiguracao; ACnpj: string; ADecimaisQuantidade: Integer; ADecimaisValor: Integer): TAcbrMonitorPorta;
    class function Alterar(ANfeConfiguracao: TNfeConfiguracao): Integer;
    class function Excluir(ANfeConfiguracao: TNfeConfiguracao): Integer;
    class procedure CriarPastaAcbrMonitor(ACnpj: string);
    class procedure ConfigurarArquivoIniMonitor(ANfeConfiguracao: TNfeConfiguracao; ADecimaisQuantidade: Integer; ADecimaisValor: Integer; APorta: Integer);
    class procedure AtualizarCertificado(ACertificadoBase64: AnsiString; ASenha: string; ACnpj: string);
    class procedure GerarArquivoEntradaMonitor(ACaminhoCertificado: string; ASenha: string);
    class function GerarZipArquivosXml(APeriodo: string; ACnpj: string): Boolean;
  end;

var
  sql, CaminhoComCnpj: string;
  Empresa: TEmpresa;


implementation


{ TNfeConfiguracaoService }



class function TNfeConfiguracaoService.ConsultarLista: TObjectList<TNfeConfiguracao>;
begin
  sql := 'SELECT * FROM NFE_CONFIGURACAO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TNfeConfiguracao>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TNfeConfiguracaoService.ConsultarListaFiltro(AWhere: string): TObjectList<TNfeConfiguracao>;
begin
  sql := 'SELECT * FROM NFE_CONFIGURACAO where ' + AWhere;
  try
    Result := GetQuery(sql).AsObjectList<TNfeConfiguracao>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TNfeConfiguracaoService.ConsultarObjeto(AId: Integer): TNfeConfiguracao;
begin
  sql := 'SELECT * FROM NFE_CONFIGURACAO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TNfeConfiguracao>;

    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TNfeConfiguracaoService.ConsultarObjetoFiltro(AWhere: string): TNfeConfiguracao;
begin
  sql := 'SELECT * FROM NFE_CONFIGURACAO where ' + AWhere;
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TNfeConfiguracao>;

    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TNfeConfiguracaoService.Atualizar(ANfeConfiguracao: TNfeConfiguracao; ACnpj: string; ADecimaisQuantidade: Integer; ADecimaisValor: Integer): TAcbrMonitorPorta;
var
  Configuracao: TNfeConfiguracao;
  Filtro: string;
  PortaMonitor: TACbrMonitorPorta;
begin
  Filtro := 'CNPJ = "' + ACnpj + '"';
  Empresa := TEmpresaService.ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    ANfeConfiguracao.IdEmpresa := Empresa.Id;
    ANfeConfiguracao.CaminhoSalvarXml := StringReplace(ANfeConfiguracao.CaminhoSalvarXml, '\', '\\', [rfReplaceAll, rfIgnoreCase]);
    ANfeConfiguracao.CaminhoSalvarPdf := StringReplace(ANfeConfiguracao.CaminhoSalvarPdf, '\', '\\', [rfReplaceAll, rfIgnoreCase]);
    Filtro := 'ID_EMPRESA = ' + Empresa.Id.ToString;
    Configuracao := ConsultarObjetoFiltro(filtro);
    if Assigned(Configuracao) then
    begin
      ANfeConfiguracao.Id := Configuracao.Id;
      AlterarBase(ANfeConfiguracao, 'NFE_CONFIGURACAO');
    end
    else
    begin
      ANfeConfiguracao.Id := InserirBase(ANfeConfiguracao, 'NFE_CONFIGURACAO');
    end;

    // verificar se já existe uma porta definida para o monitor da empresa
    // ALTER TABLE acbr_monitor_porta AUTO_INCREMENT=3435; - executa um comando no banco de dados para definir a porta inicial para o ID
    Filtro := 'ID_EMPRESA = ' + Empresa.Id.ToString;
    PortaMonitor := TAcbrMonitorPortaService.ConsultarObjetoFiltro(filtro);
    if not Assigned(PortaMonitor) then
    begin
      PortaMonitor := TACbrMonitorPorta.Create;
      PortaMonitor.IdEmpresa := Empresa.Id;
      PortaMonitor.Id := InserirBase(PortaMonitor, 'ACBR_MONITOR_PORTA');
    end;
    Result := PortaMonitor;

    // criar a pasta do monitor para a empresa
    CriarPastaAcbrMonitor(ACnpj);

    // configurar o arquivo INI
    ConfigurarArquivoIniMonitor(ANfeConfiguracao, ADecimaisQuantidade, ADecimaisValor, PortaMonitor.Id);
  end;
end;

class procedure TNfeConfiguracaoService.CriarPastaAcbrMonitor(ACnpj: string);
begin
  if not System.SysUtils.DirectoryExists('C:\ACBrMonitor\' + ACnpj) then
  begin
    Biblioteca.ExecAndWait('c:\AcbrMonitor\CopiarBase.bat ' + ACnpj, SW_HIDE);
  end;
end;

class procedure TNfeConfiguracaoService.ConfigurarArquivoIniMonitor(ANfeConfiguracao: TNfeConfiguracao; ADecimaisQuantidade: Integer; ADecimaisValor: Integer; APorta: Integer);
var
  ACBrMonitorIni: TIniFile;
  CaminhoExecutavel: PWideChar;
begin
  CaminhoComCnpj := 'C:\ACBrMonitor\' + Empresa.Cnpj + '\';
  ANfeConfiguracao.CaminhoSalvarPdf := CaminhoComCnpj + 'PDF';
  ANfeConfiguracao.CaminhoSalvarXml := CaminhoComCnpj + 'DFes';
  ACBrMonitorIni := TIniFile.Create(CaminhoComCnpj + 'ACBrMonitor.ini');
  try
    //*******************************************************************************************
    //  [ACBrMonitor]
    //*******************************************************************************************
    ACBrMonitorIni.WriteString('ACBrMonitor', 'TCP_Porta', APorta.ToString);

    //*******************************************************************************************
    //  [ACBrNFeMonitor]
    //*******************************************************************************************
    ACBrMonitorIni.WriteString('ACBrNFeMonitor', 'Arquivo_Log_Comp', CaminhoComCnpj + 'LOG_DFe.TXT');
    ACBrMonitorIni.WriteString('ACBrNFeMonitor', 'ArquivoWebServices', CaminhoComCnpj + 'ACBrNFeServicos.ini');
    ACBrMonitorIni.WriteString('ACBrNFeMonitor', 'ArquivoWebServicesCTe', CaminhoComCnpj + 'ACBrCTeServicos.ini');
    ACBrMonitorIni.WriteString('ACBrNFeMonitor', 'ArquivoWebServicesMDFe', CaminhoComCnpj + 'ACBrMDFeServicos.ini');
    ACBrMonitorIni.WriteString('ACBrNFeMonitor', 'ArquivoWebServicesGNRe', CaminhoComCnpj + 'ACBrGNREServicos.ini');
    ACBrMonitorIni.WriteString('ACBrNFeMonitor', 'ArquivoWebServiceseSocial', CaminhoComCnpj + 'ACBreSocialServicos.ini');
    ACBrMonitorIni.WriteString('ACBrNFeMonitor', 'ArquivoWebServicesReinf', CaminhoComCnpj + 'ACBrReinfServicos.ini');
    ACBrMonitorIni.WriteString('ACBrNFeMonitor', 'ArquivoWebServicesBPe', CaminhoComCnpj + 'ACBrBPeServicos.ini');

    //*******************************************************************************************
    //  [WebService]
    //*******************************************************************************************
    // tpAmb - 1-Produção/ 2-Homologação
    // OBS: o monitor leva em conta o índice do Radiogroup, ou seja, será 0 para produção e 1 para homologação
    ACBrMonitorIni.WriteString('WebService', 'Ambiente', (ANfeConfiguracao.WebserviceAmbiente-1).ToString);
    ACBrMonitorIni.WriteString('WebService', 'UF', Empresa.Uf);

    //*******************************************************************************************
    //  [RespTecnico]
    //*******************************************************************************************
    if ANfeConfiguracao.RespTecHashCsrt <> '0' then
      ACBrMonitorIni.WriteString('RespTecnico', 'CSRT', ANfeConfiguracao.RespTecHashCsrt);
    if ANfeConfiguracao.RespTecIdCsrt <> '0' then
      ACBrMonitorIni.WriteString('RespTecnico', 'idCSRT', ANfeConfiguracao.RespTecIdCsrt);

    //*******************************************************************************************
    //  [NFCe]
    //*******************************************************************************************
    ACBrMonitorIni.WriteString('NFCe', 'IdToken', ANfeConfiguracao.NfceIdCsc);
    ACBrMonitorIni.WriteString('NFCe', 'Token', ANfeConfiguracao.NfceCsc);
    if ANfeConfiguracao.NfceModeloImpressao = 'A4' then
      ACBrMonitorIni.WriteString('NFCe', 'ModoImpressaoEvento', '0')
    else
      ACBrMonitorIni.WriteString('NFCe', 'ModoImpressaoEvento', '1');
    if ANfeConfiguracao.NfceImprimirItensUmaLinha = 'S' then
      ACBrMonitorIni.WriteString('NFCe', 'ImprimirItem1Linha', '1')
    else
      ACBrMonitorIni.WriteString('NFCe', 'ImprimirItem1Linha', '0');
    if ANfeConfiguracao.NfceImprimirDescontoPorItem = 'S' then
      ACBrMonitorIni.WriteString('NFCe', 'ImprimirDescAcresItem', '1')
    else
      ACBrMonitorIni.WriteString('NFCe', 'ImprimirDescAcresItem', '0');
    if ANfeConfiguracao.NfceImprimirQrcodeLateral = 'S' then
      ACBrMonitorIni.WriteString('NFCe', 'QRCodeLateral', '1')
    else
      ACBrMonitorIni.WriteString('NFCe', 'QRCodeLateral', '0');
    if ANfeConfiguracao.NfceImprimirGtin = 'S' then
      ACBrMonitorIni.WriteString('NFCe', 'UsaCodigoEanImpressao', '1')
    else
      ACBrMonitorIni.WriteString('NFCe', 'UsaCodigoEanImpressao', '0');
    if ANfeConfiguracao.NfceImprimirNomeFantasia = 'S' then
      ACBrMonitorIni.WriteString('NFCe', 'ImprimeNomeFantasia', '1')
    else
      ACBrMonitorIni.WriteString('NFCe', 'ImprimeNomeFantasia', '0');
    if ANfeConfiguracao.NfceImpressaoTributos = 'S' then
      ACBrMonitorIni.WriteString('NFCe', 'ExibeTotalTributosItem', '1')
    else
      ACBrMonitorIni.WriteString('NFCe', 'ExibeTotalTributosItem', '0');

    //*******************************************************************************************
    //  [DANFCe]
    //*******************************************************************************************
    ACBrMonitorIni.WriteString('DANFCe', 'MargemInf', ANfeConfiguracao.NfceMargemInferior.ToString.Replace('.', ','));
    ACBrMonitorIni.WriteString('DANFCe', 'MargemSup', ANfeConfiguracao.NfceMargemSuperior.ToString.Replace('.', ','));
    ACBrMonitorIni.WriteString('DANFCe', 'MargemDir', ANfeConfiguracao.NfceMargemDireita.ToString.Replace('.', ','));
    ACBrMonitorIni.WriteString('DANFCe', 'MargemEsq', ANfeConfiguracao.NfceMargemEsquerda.ToString.Replace('.', ','));
    ACBrMonitorIni.WriteString('DANFCe', 'LarguraBobina', ANfeConfiguracao.NfceResolucaoImpressao.ToString);

    //*******************************************************************************************
    //  [FonteLinhaItem]
    //*******************************************************************************************
    ACBrMonitorIni.WriteString('FonteLinhaItem', 'Size', ANfeConfiguracao.NfceTamanhoFonteItem.ToString);

    //*******************************************************************************************
    //  [DANFE]
    //*******************************************************************************************
    ACBrMonitorIni.WriteString('DANFE', 'PathPDF', ANfeConfiguracao.CaminhoSalvarPdf);
    ACBrMonitorIni.WriteString('DANFE', 'DecimaisQTD', ADecimaisQuantidade.ToString);
    ACBrMonitorIni.WriteString('DANFE', 'DecimaisValor', ADecimaisValor.ToString);

    //*******************************************************************************************
    //  [Arquivos]
    //*******************************************************************************************
    ACBrMonitorIni.WriteString('Arquivos', 'PathNFe', ANfeConfiguracao.CaminhoSalvarXml);
    ACBrMonitorIni.WriteString('Arquivos', 'PathInu', CaminhoComCnpj + 'Inutilizacao');
    ACBrMonitorIni.WriteString('Arquivos', 'PathDPEC', CaminhoComCnpj + 'EPEC');
    ACBrMonitorIni.WriteString('Arquivos', 'PathEvento', CaminhoComCnpj + 'Evento');
    ACBrMonitorIni.WriteString('Arquivos', 'PathArqTXT', CaminhoComCnpj + 'TXT');
    ACBrMonitorIni.WriteString('Arquivos', 'PathDonwload', CaminhoComCnpj + 'DistribuicaoDFe');

  finally
    Biblioteca.KillTask('ACBrMonitor_' + Empresa.Cnpj + '.exe');
    CaminhoExecutavel := PWideChar(CaminhoComCnpj + 'ACBrMonitor_' + Empresa.Cnpj + '.exe');
    ShellExecute(0, 'open', (CaminhoExecutavel), nil, nil, SW_HIDE);

    ACBrMonitorIni.Free;
  end;
end;

class procedure TNfeConfiguracaoService.AtualizarCertificado(ACertificadoBase64: AnsiString; ASenha: string; ACnpj: string);
var
  ACBrMonitorIni: TIniFile;
  Filtro, CaminhoArquivoCertificado: string;
  CaminhoExecutavel: PWideChar;
begin
  Filtro := 'CNPJ = "' + ACnpj + '"';
  Empresa := TEmpresaService.ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    // encerra o Monitor
    Biblioteca.KillTask('ACBrMonitor_' + Empresa.Cnpj + '.exe');

    // configura os caminhos
    CaminhoComCnpj := 'C:\ACBrMonitor\' + Empresa.Cnpj + '\';
    CaminhoArquivoCertificado := CaminhoComCnpj + Empresa.Cnpj + '.pfx';

    // salva o arquivo base64 em disco
    Biblioteca.DecodeFileBase64(ACertificadoBase64, CaminhoArquivoCertificado);

    // vamos alterar o monitor para receber dados em arquivo TXT para armazenar os dados do certificado
    // faremos dessa maneira porque o monitor criptografa a senha
    ACBrMonitorIni := TIniFile.Create(CaminhoComCnpj + 'ACBrMonitor.ini');
    try
      //*******************************************************************************************
      //  [ACBrMonitor]
      //*******************************************************************************************
      ACBrMonitorIni.WriteString('ACBrMonitor', 'Modo_TCP', '0');
      ACBrMonitorIni.WriteString('ACBrMonitor', 'Modo_TXT', '1');
    finally
      CaminhoExecutavel := PWideChar(CaminhoComCnpj + 'ACBrMonitor_' + Empresa.Cnpj + '.exe');
      ShellExecute(0, 'open', (CaminhoExecutavel), nil, nil, SW_HIDE);

      ACBrMonitorIni.Free;
    end;

    // vamos mandar um arquivo de entrada com os dados do certificado
    GerarArquivoEntradaMonitor(CaminhoArquivoCertificado, ASenha);

    while not FileExists(CaminhoComCnpj + 'sai.txt') do
    begin
    end;

    // altera novamente o monitor para o modo TCP
    ACBrMonitorIni := TIniFile.Create(CaminhoComCnpj + 'ACBrMonitor.ini');
    try
      //*******************************************************************************************
      //  [ACBrMonitor]
      //*******************************************************************************************
      ACBrMonitorIni.WriteString('ACBrMonitor', 'Modo_TCP', '1');
      ACBrMonitorIni.WriteString('ACBrMonitor', 'Modo_TXT', '0');
    finally
      ACBrMonitorIni.Free;

      Biblioteca.KillTask('ACBrMonitor_' + Empresa.Cnpj + '.exe');
      CaminhoExecutavel := PWideChar(CaminhoComCnpj + 'ACBrMonitor_' + Empresa.Cnpj + '.exe');
      ShellExecute(0, 'open', (CaminhoExecutavel), nil, nil, SW_HIDE);
    end;

  end;
end;

class procedure TNfeConfiguracaoService.GerarArquivoEntradaMonitor(ACaminhoCertificado: string; ASenha: string);
var
  ArquivoEntrada: TextFile;
  CaminhoArquivo: PWideChar;
begin
  try
    // apaga o arquivo 'SAI.TXT'
    CaminhoArquivo := PWideChar('c:\ACBrMonitor\' + Empresa.Cnpj + '\SAI.TXT');
    DeleteFile(CaminhoArquivo);

    // cria o arquivo 'ENT.TXT'
    CaminhoArquivo := PWideChar('c:\ACBrMonitor\' + Empresa.Cnpj + '\ENT.TXT');
    AssignFile(ArquivoEntrada, CaminhoArquivo);
    Rewrite(ArquivoEntrada);
    Writeln(ArquivoEntrada, 'NFE.SetCertificado(' + ACaminhoCertificado + ',' + ASenha + ')');
  finally
    CloseFile(ArquivoEntrada);
  end;
end;

class function TNfeConfiguracaoService.GerarZipArquivosXml(APeriodo: string; ACnpj: string): Boolean;
var
  Filtro: string;
begin
  Result := False;
  Filtro := 'CNPJ = "' + ACnpj + '"';
  Empresa := TEmpresaService.ConsultarObjetoFiltro(filtro);
  if Assigned(Empresa) then
  begin
    TZipFile.ZipDirectoryContents('C:\ACBrMonitor\' + ACnpj + '\NotasFiscaisNFCe_' + APeriodo + '.zip', 'C:\ACBrMonitor\' + ACnpj + '\DFes\NFCe\' + APeriodo);
	Result := True;
  end;
end;

class procedure TNfeConfiguracaoService.Inserir(ANfeConfiguracao: TNfeConfiguracao);
begin
  ANfeConfiguracao.ValidarInsercao;
  ANfeConfiguracao.Id := InserirBase(ANfeConfiguracao, 'NFE_CONFIGURACAO');
end;

class function TNfeConfiguracaoService.Alterar(ANfeConfiguracao: TNfeConfiguracao): Integer;
begin
  ANfeConfiguracao.ValidarAlteracao;
  Result := AlterarBase(ANfeConfiguracao, 'NFE_CONFIGURACAO');
end;


class function TNfeConfiguracaoService.Excluir(ANfeConfiguracao: TNfeConfiguracao): Integer;
begin
  ANfeConfiguracao.ValidarExclusao;
  Result := ExcluirBase(ANfeConfiguracao.Id, 'NFE_CONFIGURACAO');
end;


end.
