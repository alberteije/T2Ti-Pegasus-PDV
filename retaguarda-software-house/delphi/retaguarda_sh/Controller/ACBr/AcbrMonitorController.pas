{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado ao ACBrMonitor
                                                                                
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
unit AcbrMonitorController;

interface

uses mvcframework, mvcframework.Commons,
  MVCFramework.SystemJSONUtils, MVCFramework.Serializer.Defaults,
  MVCFramework.Serializer.Intf,
  System.SysUtils, System.Classes,
  System.Rtti;

type

  [MVCDoc('AcbrMonitor')]
  [MVCPath('/acbr-monitor')]
  TAcbrMonitorController = class(TMVCController)
  public
    [MVCDoc('Emitir a NFC-e')]
    [MVCPath('/emite-nfce/')]
    [MVCHTTPMethod([httpPOST])]
    procedure EmitirNfce(Context: TWebContext);

    [MVCDoc('Emitir a NFC-e em Contingência')]
    [MVCPath('/emite-nfce-contingencia/')]
    [MVCHTTPMethod([httpPOST])]
    procedure EmitirNfceContingencia(Context: TWebContext);

    [MVCDoc('Transmite NFC-e Contingenciada')]
    [MVCPath('/transmite-nfce-contingenciada/')]
    [MVCHTTPMethod([httpPOST])]
    procedure TransmitirNfceContingenciada(Context: TWebContext);

    [MVCDoc('Tratar Nota Anterior Contingencia')]
    [MVCPath('/trata-nota-anterior-contingencia/')]
    [MVCHTTPMethod([httpPOST])]
    procedure TratarNotaAnteriorContingencia(Context: TWebContext);

    [MVCDoc('Inutilizar Número da NFe')]
    [MVCPath('/inutiliza-numero-nota/')]
    [MVCHTTPMethod([httpPOST])]
    procedure InutilizarNumeroNota(Context: TWebContext);

    [MVCDoc('Cancelar a NFC-e')]
    [MVCPath('/cancela-nfce/')]
    [MVCHTTPMethod([httpPOST])]
    procedure CancelarNfce(Context: TWebContext);

    [MVCDoc('Gerar PDF Danfe NFC-e')]
    [MVCPath('/gera-pdf-danfe-nfce/')]
    [MVCHTTPMethod([httpPOST])]
    procedure GerarPDFDanfeNFCe(Context: TWebContext);

    [MVCDoc('Retorna a lista de arquivos XML para a empresa')]
    [MVCPath('/download-xml-periodo/')]
    [MVCHTTPMethod([httpGET])]
    procedure RetornarArquivosXmlPeriodo(Context: TWebContext);

    [MVCDoc('Grava os dados do certificado')]
    [MVCPath('/atualiza-certificado/')]
    [MVCHTTPMethod([httpPOST])]
    procedure AtualizarCertificado(Context: TWebContext);

  end;

implementation

{ TAcbrMonitorController }

uses AcbrMonitorService, Commons, Filtro, ObjetoNfe, Biblioteca;//,

procedure TAcbrMonitorController.EmitirNfce(Context: TWebContext);
var
  NfceIni: AnsiString;
  Numero, Cnpj, Retorno: string;
  ArquivoPDF: TFileStream;
begin
  try
    NfceIni := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    Numero := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['numero']);
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Emitir NFc-e] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    Retorno := TAcbrMonitorService.EmitirNfce(Numero, Cnpj, NfceIni);
    if Copy(Retorno, 1, 6) <> '[ERRO]' then
    begin
//      Render(418, '999'); // simula erro para emissão da nota em contingência - descomente e comente o bloco de código abaixo
      ArquivoPDF := TFileStream.Create(Retorno, fmOpenRead or fmShareDenyWrite);
      ContentType := 'application/pdf';
      Render(ArquivoPDF, True);
    end
    else
    begin
      Render(418, Retorno); // Erro capturado pelo ACBrMonitor
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Erro ao tentar Emitir a NFC-e [Emitir NFC-e] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorController.EmitirNfceContingencia(Context: TWebContext);
var
  NfceIni: AnsiString;
  Numero, Cnpj, Retorno: string;
  ArquivoPDF: TFileStream;
begin
  try
    NfceIni := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    Numero := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['numero']);
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Emitir NFc-e em Contingência] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    Retorno := TAcbrMonitorService.EmitirNfceContingencia(Numero, Cnpj, NfceIni);
    if Copy(Retorno, 1, 6) <> '[ERRO]' then
    begin
      ArquivoPDF := TFileStream.Create(Retorno, fmOpenRead or fmShareDenyWrite);
      ContentType := 'application/pdf';
      Render(ArquivoPDF, True);
    end
    else
    begin
      Render(418, Retorno); // Erro capturado pelo ACBrMonitor
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Erro ao tentar Emitir a NFC-e em Contingência [Emitir NFC-e em Contingência] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorController.TransmitirNfceContingenciada(Context: TWebContext);
var
  Chave, Cnpj, Retorno: string;
  ArquivoPDF: TFileStream;
begin
  try
    Chave := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['chave']);
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Dados inválidos [Transmitir NFC-e Contingenciada] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    Retorno := TAcbrMonitorService.TransmitirNfceContingenciada(Chave, Cnpj);
    if Copy(Retorno, 1, 6) <> '[ERRO]' then
    begin
      ArquivoPDF := TFileStream.Create(Retorno, fmOpenRead or fmShareDenyWrite);
      ContentType := 'application/pdf';
      Render(ArquivoPDF, True);
    end
    else
    begin
      Render(418, Retorno); // Erro capturado pelo ACBrMonitor
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Erro ao tentar Transmitir a NFC-e Contingenciada [Transmitir NFC-e Contingenciada] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorController.TratarNotaAnteriorContingencia(Context: TWebContext);
var
  objetoNfe: TObjetoNfe;
  ObjetoJsonString, Retorno: string;
begin
  try
    objetoNfe := TObjetoNfe.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, objetoNfe);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Tratar Nota Anterior Contingencia] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    Retorno := TAcbrMonitorService.TratarNotaAnteriorContingencia(objetoNfe);
    Render(Biblioteca.CifrarDCPCrypt(Retorno));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Erro ao tentar realizar o procedimento [Tratar Nota Anterior Contingencia] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorController.InutilizarNumeroNota(Context: TWebContext);
var
  objetoNfe: TObjetoNfe;
  ObjetoJsonString, Retorno: string;
begin
  try
    objetoNfe := TObjetoNfe.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, objetoNfe);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inutilizar Numero Nota] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    Retorno := TAcbrMonitorService.InutilizarNumero(objetoNfe);
    Render(Biblioteca.CifrarDCPCrypt(Retorno));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Erro ao tentar Inutilizar o Numero da Nota [Inutilizar Numero Nota] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorController.CancelarNfce(Context: TWebContext);
var
  objetoNfe: TObjetoNfe;
  ObjetoJsonString, Retorno: string;
begin
  try
    objetoNfe := TObjetoNfe.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, objetoNfe);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Cancelar NFC-e] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    Retorno := TAcbrMonitorService.CancelarNfce(objetoNfe.ChaveAcesso, objetoNfe.Justificativa, objetoNfe.Cnpj);
    Render(Biblioteca.CifrarDCPCrypt(Retorno));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Erro ao tentar Cancelar a NFC-e [Cancelar NFC-e] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorController.GerarPDFDanfeNFCe(Context: TWebContext);
var
  Chave, Cnpj, Retorno: string;
  ArquivoPDF: TFileStream;
begin
  try
    Chave := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['chave']);
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Gerar PDF Danfe NFC-e] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    Retorno := TAcbrMonitorService.GerarPDFDanfeNFCe(Chave, Cnpj);
    if Copy(Retorno, 1, 6) <> '[ERRO]' then
    begin
      ArquivoPDF := TFileStream.Create(Retorno, fmOpenRead or fmShareDenyWrite);
      ContentType := 'application/pdf';
      Render(ArquivoPDF, True);
    end
    else
    begin
      Render(418, Retorno); // Erro capturado pelo ACBrMonitor
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Erro ao tentar realizar o procedimento [Gerar PDF Danfe NFC-e] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorController.RetornarArquivosXmlPeriodo(Context: TWebContext);
var
  Cnpj, Periodo: string;
  ArquivoZip: TFileStream;
  Retorno: Boolean;
begin
  try
    Periodo := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['periodo']);
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
    Retorno := TAcbrMonitorService.GerarZipArquivosXml(Periodo, Cnpj);
    if Retorno then
    begin
      ArquivoZip := TFileStream.Create('C:\ACBrMonitor\' + Cnpj + '\NotasFiscaisNFCe_' + Periodo + '.zip', fmOpenRead or fmShareDenyWrite);
      ContentType := 'application/zip';
      Render(ArquivoZip, True);
    end
    else
    begin
      raise EMVCException.Create('Problemas na criação do arquivo [Retornar XML Período]', 'ERRO', 0, 500);
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas no download [Retornar XML Período] - Exceção: ' + E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorController.AtualizarCertificado(Context: TWebContext);
var
  CertificadoBase64: AnsiString;
  Senha, Cnpj: string;
begin
  try
    CertificadoBase64 := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    Senha := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['hash-registro']);
    Cnpj := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['cnpj']);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Conteúdo inválido [Atualizar Certificado] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TAcbrMonitorService.AtualizarCertificado(CertificadoBase64, Senha, Cnpj);
    Render(200, 'Certificado atualizado com sucesso.')
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na atualização [Atualizar Certificado] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

end.
