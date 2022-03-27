{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [EMPRESA] 
                                                                                
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
unit EmpresaController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils, MVCFramework.Serializer.Defaults, MVCFramework.Logger;

type

  [MVCDoc('CRUD Empresa')]
  [MVCPath('/empresa')]
  TEmpresaController = class(TMVCController)
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

    [MVCDoc('Atualiza os dados')]
    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    procedure Atualizar(Context: TWebContext);

    [MVCDoc('Registra Empresa')]
    [MVCPath('/registra-empresa/')]
    [MVCHTTPMethod([httpPOST])]
    procedure RegistrarEmpresa(Context: TWebContext);

    [MVCDoc('Enviar Email Confirmacao')]
    [MVCPath('/envia-email-confirmacao/')]
    [MVCHTTPMethod([httpPOST])]
    procedure EnviarEmailConfirmacao(Context: TWebContext);

    [MVCDoc('Conferir Codigo Confirmacao')]
    [MVCPath('/confere-codigo-confirmacao/')]
    [MVCHTTPMethod([httpPOST])]
    procedure ConferirCodigoConfirmacao(Context: TWebContext);

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

{ TEmpresaController }

uses EmpresaService, Empresa, Commons, Filtro, Constantes, Biblioteca;

//procedure TEmpresaController.ConsultarLista(Context: TWebContext);
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
//      Render<TEmpresa>(TEmpresaService.ConsultarLista);
//    end
//    else begin
//      // define o objeto filtro
//      FiltroObj := TFiltro.Create(FilterWhere);
//      Render<TEmpresa>(TEmpresaService.ConsultarListaFiltro(FiltroObj.Where));
//    end;
//  except
//    on E: EServiceException do
//    begin
//      raise EMVCException.Create
//        ('Erro no Servidor [Consultar Lista Empresa] - Exceção: ' + E.Message,
//        E.StackTrace, 0, 500);
//    end
//    else
//      raise;
//  end;
//end;
//
//procedure TEmpresaController.ConsultarObjeto(id: Integer);
//var
//  Empresa: TEmpresa;
//begin
//  try
//    Empresa := TEmpresaService.ConsultarObjeto(id);
//
//    if Assigned(Empresa) then
//      Render(Empresa)
//    else
//      raise EMVCException.Create
//        ('Registro não localizado [Consultar Objeto Empresa]', '', 0, 404);
//  except
//    on E: EServiceException do
//    begin
//      raise EMVCException.Create
//        ('Erro no Servidor [Consultar Objeto Empresa] - Exceção: ' + E.Message,
//        E.StackTrace, 0, 500);
//    end
//    else
//      raise;
//  end;
//end;

procedure TEmpresaController.Atualizar(Context: TWebContext);
var
  ObjetoJsonString: string;
  Empresa: TEmpresa;
begin
  Log('== TEmpresaController.Atualizar [BEGIN]');
  try
    Empresa := TEmpresa.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, Empresa);
//    Log(Empresa.Cnpj);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Atualizar Empresa] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TEmpresaService.Atualizar(Empresa);
    Empresa := TEmpresaService.ConsultarObjetoFiltro('CNPJ = "' + Empresa.Cnpj + '"');
    ObjetoJsonString := GetDefaultSerializer.SerializeObject(Empresa);
    Render(Biblioteca.CifrarDCPCrypt(ObjetoJsonString));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na atualização [Atualizar Empresa] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
  Log('== TEmpresaController.Atualizar [END]');
end;

procedure TEmpresaController.RegistrarEmpresa(Context: TWebContext);
var
  ObjetoJsonString: string;
  Empresa: TEmpresa;
begin
  try
    Empresa := TEmpresa.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, Empresa);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Registrar Empresa] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TEmpresaService.Registrar(Empresa);
    Empresa := TEmpresaService.ConsultarObjetoFiltro('CNPJ = "' + Empresa.Cnpj + '"');
    ObjetoJsonString := GetDefaultSerializer.SerializeObject(Empresa);
    Render(Biblioteca.CifrarDCPCrypt(ObjetoJsonString));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas no registro [Registrar Empresa] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TEmpresaController.EnviarEmailConfirmacao(Context: TWebContext);
var
  ObjetoJsonString: string;
  Empresa: TEmpresa;
begin
  try
    Empresa := TEmpresa.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, Empresa);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Enviar Email Confirmacao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TEmpresaService.EnviarEmailConfirmacao(Empresa);
    Empresa := TEmpresaService.ConsultarObjetoFiltro('CNPJ = "' + Empresa.Cnpj + '"');
    ObjetoJsonString := GetDefaultSerializer.SerializeObject(Empresa);
    Render(Biblioteca.CifrarDCPCrypt(ObjetoJsonString));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas no procedimento [Enviar Email Confirmacao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TEmpresaController.ConferirCodigoConfirmacao(Context: TWebContext);
var
  ObjetoJsonString, CodigoConfirmacao: string;
  Empresa: TEmpresa;
begin
  try
    CodigoConfirmacao := Biblioteca.DecifrarDCPCrypt(Context.Request.Headers['codigo-confirmacao']);
    Empresa := TEmpresa.Create;
    ObjetoJsonString := Biblioteca.DecifrarDCPCrypt(Context.Request.Body);
    GetDefaultSerializer.DeserializeObject(ObjetoJsonString, Empresa);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Conferir Codigo Confirmacao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TEmpresaService.ConferirCodigoConfirmacao(Empresa, CodigoConfirmacao);
    Empresa := TEmpresaService.ConsultarObjetoFiltro('CNPJ = "' + Empresa.Cnpj + '"');
    ObjetoJsonString := GetDefaultSerializer.SerializeObject(Empresa);
    Render(Biblioteca.CifrarDCPCrypt(ObjetoJsonString));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas no procedimento [Conferir Codigo Confirmacao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

//procedure TEmpresaController.Alterar(id: Integer);
//var
//  Empresa, EmpresaDB: TEmpresa;
//begin
//  try
//    Empresa := Context.Request.BodyAs<TEmpresa>;
//  except
//    on E: EServiceException do
//    begin
//      raise EMVCException.Create('Objeto inválido [Alterar Empresa] - Exceção: ' +
//        E.Message, E.StackTrace, 0, 400);
//    end
//    else
//      raise;
//  end;
//
//  if Empresa.Id <> id then
//    raise EMVCException.Create('Objeto inválido [Alterar Empresa] - ID do objeto difere do ID da URL.',
//      '', 0, 400);
//
//  EmpresaDB := TEmpresaService.ConsultarObjeto(Empresa.id);
//
//  if not Assigned(EmpresaDB) then
//    raise EMVCException.Create('Objeto com ID inválido [Alterar Empresa]',
//      '', 0, 400);
//
//  try
//    if TEmpresaService.Alterar(Empresa) > 0 then
//      Render(TEmpresaService.ConsultarObjeto(Empresa.Id))
//    else
//      raise EMVCException.Create('Nenhum registro foi alterado [Alterar Empresa]',
//        '', 0, 500);
//  finally
//    FreeAndNil(EmpresaDB);
//  end;
//end;
//
//procedure TEmpresaController.Excluir(id: Integer);
//var
//  Empresa: TEmpresa;
//begin
//  Empresa := TEmpresaService.ConsultarObjeto(id);
//
//  if not Assigned(Empresa) then
//    raise EMVCException.Create('Objeto com ID inválido [Excluir Empresa]',
//      '', 0, 400);
//
//  try
//    if TEmpresaService.Excluir(Empresa) > 0 then
//      Render(200, 'Objeto excluído com sucesso.')
//    else
//      raise EMVCException.Create('Nenhum registro foi excluído [Excluir Empresa]',
//        '', 0, 500);
//  finally
//    FreeAndNil(Empresa);
//  end;
//end;

end.
