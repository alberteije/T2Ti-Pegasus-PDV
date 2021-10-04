{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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
unit NfeConfiguracaoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD NfeConfiguracao')]
  [MVCPath('/nfe-configuracao')]
  TNfeConfiguracaoController = class(TMVCController)
  public
//    [MVCDoc('Retorna uma lista de objetos')]
//    [MVCPath('/($filtro)')]
//    [MVCHTTPMethod([httpGET])]
//    procedure ConsultarLista(Context: TWebContext);
//
//    [MVCDoc('Retorna um objeto com base no ID')]
//    [MVCPath('/($id)')]
//    [MVCHTTPMethod([httpGET])]
//    procedure ConsultarObjeto(id: Integer);

    [MVCDoc('Retorna a lista de arquivos XML para a empresa')]
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure RetornarArquivosXmlPeriodo(Context: TWebContext);

    [MVCDoc('Atualiza os dados')]
    [MVCPath('/($cnpj)')]
    [MVCHTTPMethod([httpPOST])]
    procedure Atualizar(cnpj: string);

    [MVCDoc('Grava os dados do certificado')]
    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    procedure AtualizarCertificado(Context: TWebContext);

//    [MVCDoc('Altera um objeto com base no ID')]
//    [MVCPath('/($id)')]
//    [MVCHTTPMethod([httpPUT])]
//    procedure Alterar(id: Integer);
//
//    [MVCDoc('Exclui um objeto com base no ID')]
//    [MVCPath('/($id)')]
//    [MVCHTTPMethod([httpDelete])]
//    procedure Excluir(id: Integer);
  end;

implementation

{ TNfeConfiguracaoController }

uses NfeConfiguracaoService, NfeConfiguracao, Commons, Filtro,
MVCFramework.Serializer.JsonDataObjects, JsonDataObjects, Constantes,
ACbrMonitorPorta, System.Classes;

//procedure TNfeConfiguracaoController.ConsultarLista(Context: TWebContext);
//var
//  FiltroUrl, FilterWhere: string;
//  FiltroObj: TFiltro;
//begin
//  FiltroUrl := Context.Request.Params['filtro'];
//  if FiltroUrl <> '' then
//  begin
//    ConsultarObjeto(StrToInt(FiltroUrl));
//    exit;
//  end;
//
//  FilterWhere := Context.Request.Params['filter'];
//  try
//    if FilterWhere = '' then
//    begin
//      Render<TNfeConfiguracao>(TNfeConfiguracaoService.ConsultarLista);
//    end
//    else begin
//      // define o objeto filtro
//      FiltroObj := TFiltro.Create(FilterWhere);
//      Render<TNfeConfiguracao>(TNfeConfiguracaoService.ConsultarListaFiltro(FiltroObj.Where));
//    end;
//  except
//    on E: EServiceException do
//    begin
//      raise EMVCException.Create
//        ('Erro no Servidor [Consultar Lista NfeConfiguracao] - Exceção: ' + E.Message,
//        E.StackTrace, 0, 500);
//    end
//    else
//      raise;
//  end;
//end;
//
//procedure TNfeConfiguracaoController.ConsultarObjeto(id: Integer);
//var
//  NfeConfiguracao: TNfeConfiguracao;
//begin
//  try
//    NfeConfiguracao := TNfeConfiguracaoService.ConsultarObjeto(id);
//
//    if Assigned(NfeConfiguracao) then
//      Render(NfeConfiguracao)
//    else
//      raise EMVCException.Create
//        ('Registro não localizado [Consultar Objeto NfeConfiguracao]', '', 0, 404);
//  except
//    on E: EServiceException do
//    begin
//      raise EMVCException.Create
//        ('Erro no Servidor [Consultar Objeto NfeConfiguracao] - Exceção: ' + E.Message,
//        E.StackTrace, 0, 500);
//    end
//    else
//      raise;
//  end;
//end;

procedure TNfeConfiguracaoController.Atualizar(cnpj: string);
var
  NfeConfiguracao: TNfeConfiguracao;
  SerializarJson: TMVCJsonDataObjectsSerializer;
  PdvConfiguracaoJson: TJsonObject;
  DecimaisQuantidade, DecimaisValor, I: Integer;
  PortaMonitor: TACbrMonitorPorta;
begin
  try
    NfeConfiguracao := Context.Request.BodyAs<TNfeConfiguracao>;
    SerializarJson := TMVCJsonDataObjectsSerializer.Create;
    PdvConfiguracaoJson := SerializarJson.ParseObject(Context.Request.Headers['pdv-configuracao']);
    for i := 1 to PdvConfiguracaoJson.Count do
    begin
      if PdvConfiguracaoJson.Names[I] = 'decimaisQuantidade' then
        DecimaisQuantidade := StrToInt(PdvConfiguracaoJson.Items[I].Value);
      if PdvConfiguracaoJson.Names[I] = 'decimaisValor' then
        DecimaisValor := StrToInt(PdvConfiguracaoJson.Items[I].Value);
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Atualizar NfeConfiguracao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    PortaMonitor := TNfeConfiguracaoService.Atualizar(NfeConfiguracao, cnpj, DecimaisQuantidade, DecimaisValor);
	if Assigned(PortaMonitor) then
	begin
		Context.Response.SetCustomHeader('endereco-monitor', TConstantes.ENDERECO_SERVIDOR);
		Context.Response.SetCustomHeader('porta-monitor', PortaMonitor.Id.ToString);
	end;	
    Render(TNfeConfiguracaoService.ConsultarObjeto(NfeConfiguracao.Id));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na inserção [Atualizar NfeConfiguracao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TNfeConfiguracaoController.AtualizarCertificado(Context: TWebContext);
var
  CertificadoBase64: AnsiString;
  Senha, Cnpj: string;
begin
  try
    CertificadoBase64 := Context.Request.Body;
    Senha := Context.Request.Headers['hash-registro'];
    Cnpj := Context.Request.Headers['cnpj'];
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
    TNfeConfiguracaoService.AtualizarCertificado(CertificadoBase64, Senha, Cnpj);
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

procedure TNfeConfiguracaoController.RetornarArquivosXmlPeriodo(Context: TWebContext);
var
  Cnpj, Periodo: string;
  ArquivoZip: TFileStream;
  Retorno: Boolean;
begin
  try
    Periodo := Context.Request.Headers['periodo'];
    Cnpj := Context.Request.Headers['cnpj'];
    Retorno := TNfeConfiguracaoService.GerarZipArquivosXml(Periodo, Cnpj);
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

//procedure TNfeConfiguracaoController.Alterar(id: Integer);
//var
//  NfeConfiguracao, NfeConfiguracaoDB: TNfeConfiguracao;
//begin
//  try
//    NfeConfiguracao := Context.Request.BodyAs<TNfeConfiguracao>;
//  except
//    on E: EServiceException do
//    begin
//      raise EMVCException.Create('Objeto inválido [Alterar NfeConfiguracao] - Exceção: ' +
//        E.Message, E.StackTrace, 0, 400);
//    end
//    else
//      raise;
//  end;
//
//  if NfeConfiguracao.Id <> id then
//    raise EMVCException.Create('Objeto inválido [Alterar NfeConfiguracao] - ID do objeto difere do ID da URL.',
//      '', 0, 400);
//
//  NfeConfiguracaoDB := TNfeConfiguracaoService.ConsultarObjeto(NfeConfiguracao.id);
//
//  if not Assigned(NfeConfiguracaoDB) then
//    raise EMVCException.Create('Objeto com ID inválido [Alterar NfeConfiguracao]',
//      '', 0, 400);
//
//  try
//    if TNfeConfiguracaoService.Alterar(NfeConfiguracao) > 0 then
//      Render(TNfeConfiguracaoService.ConsultarObjeto(NfeConfiguracao.Id))
//    else
//      raise EMVCException.Create('Nenhum registro foi alterado [Alterar NfeConfiguracao]',
//        '', 0, 500);
//  finally
//    FreeAndNil(NfeConfiguracaoDB);
//  end;
//end;
//
//procedure TNfeConfiguracaoController.Excluir(id: Integer);
//var
//  NfeConfiguracao: TNfeConfiguracao;
//begin
//  NfeConfiguracao := TNfeConfiguracaoService.ConsultarObjeto(id);
//
//  if not Assigned(NfeConfiguracao) then
//    raise EMVCException.Create('Objeto com ID inválido [Excluir NfeConfiguracao]',
//      '', 0, 400);
//
//  try
//    if TNfeConfiguracaoService.Excluir(NfeConfiguracao) > 0 then
//      Render(200, 'Objeto excluído com sucesso.')
//    else
//      raise EMVCException.Create('Nenhum registro foi excluído [Excluir NfeConfiguracao]',
//        '', 0, 500);
//  finally
//    FreeAndNil(NfeConfiguracao);
//  end;
//end;

end.
