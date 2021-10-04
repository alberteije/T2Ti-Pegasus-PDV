{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [ACBR_MONITOR_PORTA] 
                                                                                
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
unit AcbrMonitorPortaController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD AcbrMonitorPorta')]
  [MVCPath('/acbr-monitor-porta')]
  TAcbrMonitorPortaController = class(TMVCController)
  public
    [MVCDoc('Retorna uma lista de objetos')]
    [MVCPath('/($filtro)')]
    [MVCHTTPMethod([httpGET])]
    procedure ConsultarLista(Context: TWebContext);

    [MVCDoc('Retorna um objeto com base no ID')]
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure ConsultarObjeto(id: Integer);

    [MVCDoc('Insere um novo objeto')]
    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    procedure Inserir(Context: TWebContext);

    [MVCDoc('Altera um objeto com base no ID')]
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpPUT])]
    procedure Alterar(id: Integer);

    [MVCDoc('Exclui um objeto com base no ID')]
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpDelete])]
    procedure Excluir(id: Integer);
  end;

implementation

{ TAcbrMonitorPortaController }

uses AcbrMonitorPortaService, AcbrMonitorPorta, Commons, Filtro;

procedure TAcbrMonitorPortaController.ConsultarLista(Context: TWebContext);
var
  FiltroUrl, FilterWhere: string;
  FiltroObj: TFiltro;
begin
  FiltroUrl := Context.Request.Params['filtro'];
  if FiltroUrl <> '' then
  begin
    ConsultarObjeto(StrToInt(FiltroUrl));
    exit;
  end;

  FilterWhere := Context.Request.Params['filter'];
  try
    if FilterWhere = '' then
    begin
      Render<TAcbrMonitorPorta>(TAcbrMonitorPortaService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TAcbrMonitorPorta>(TAcbrMonitorPortaService.ConsultarListaFiltro(FiltroObj.Where));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista AcbrMonitorPorta] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorPortaController.ConsultarObjeto(id: Integer);
var
  AcbrMonitorPorta: TAcbrMonitorPorta;
begin
  try
    AcbrMonitorPorta := TAcbrMonitorPortaService.ConsultarObjeto(id);

    if Assigned(AcbrMonitorPorta) then
      Render(AcbrMonitorPorta)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto AcbrMonitorPorta]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto AcbrMonitorPorta] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorPortaController.Inserir(Context: TWebContext);
var
  AcbrMonitorPorta: TAcbrMonitorPorta;
begin
  try
    AcbrMonitorPorta := Context.Request.BodyAs<TAcbrMonitorPorta>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir AcbrMonitorPorta] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TAcbrMonitorPortaService.Inserir(AcbrMonitorPorta);
    Render(TAcbrMonitorPortaService.ConsultarObjeto(AcbrMonitorPorta.Id));
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Problemas na inserção [Inserir AcbrMonitorPorta] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;
end;

procedure TAcbrMonitorPortaController.Alterar(id: Integer);
var
  AcbrMonitorPorta, AcbrMonitorPortaDB: TAcbrMonitorPorta;
begin
  try
    AcbrMonitorPorta := Context.Request.BodyAs<TAcbrMonitorPorta>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar AcbrMonitorPorta] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if AcbrMonitorPorta.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar AcbrMonitorPorta] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  AcbrMonitorPortaDB := TAcbrMonitorPortaService.ConsultarObjeto(AcbrMonitorPorta.id);

  if not Assigned(AcbrMonitorPortaDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar AcbrMonitorPorta]',
      '', 0, 400);

  try
    if TAcbrMonitorPortaService.Alterar(AcbrMonitorPorta) > 0 then
      Render(TAcbrMonitorPortaService.ConsultarObjeto(AcbrMonitorPorta.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar AcbrMonitorPorta]',
        '', 0, 500);
  finally
    FreeAndNil(AcbrMonitorPortaDB);
  end;
end;

procedure TAcbrMonitorPortaController.Excluir(id: Integer);
var
  AcbrMonitorPorta: TAcbrMonitorPorta;
begin
  AcbrMonitorPorta := TAcbrMonitorPortaService.ConsultarObjeto(id);

  if not Assigned(AcbrMonitorPorta) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir AcbrMonitorPorta]',
      '', 0, 400);

  try
    if TAcbrMonitorPortaService.Excluir(AcbrMonitorPorta) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir AcbrMonitorPorta]',
        '', 0, 500);
  finally
    FreeAndNil(AcbrMonitorPorta);
  end;
end;

end.
