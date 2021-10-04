{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [CST_PIS] 
                                                                                
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
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************}
unit CstPisController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD CstPis')]
  [MVCPath('/cst-pis')]
  TCstPisController = class(TMVCController)
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

{ TCstPisController }

uses CstPisService, CstPis, Commons, Filtro;

procedure TCstPisController.ConsultarLista(Context: TWebContext);
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

  filterWhere := Context.Request.Params['filter'];
  try
    if FilterWhere = '' then
    begin
      Render<TCstPis>(TCstPisService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TCstPis>(TCstPisService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista CstPis] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TCstPisController.ConsultarObjeto(id: Integer);
var
  CstPis: TCstPis;
begin
  try
    CstPis := TCstPisService.ConsultarObjeto(id);

    if Assigned(CstPis) then
      Render(CstPis)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto CstPis]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto CstPis] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TCstPisController.Inserir(Context: TWebContext);
var
  CstPis: TCstPis;
begin
  try
    CstPis := Context.Request.BodyAs<TCstPis>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir CstPis] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TCstPisService.Inserir(CstPis);
    Render(TCstPisService.ConsultarObjeto(CstPis.Id));
  finally
  end;
end;

procedure TCstPisController.Alterar(id: Integer);
var
  CstPis, CstPisDB: TCstPis;
begin
  try
    CstPis := Context.Request.BodyAs<TCstPis>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar CstPis] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if CstPis.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar CstPis] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  CstPisDB := TCstPisService.ConsultarObjeto(CstPis.id);

  if not Assigned(CstPisDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar CstPis]',
      '', 0, 400);

  try
    if TCstPisService.Alterar(CstPis) > 0 then
      Render(TCstPisService.ConsultarObjeto(CstPis.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar CstPis]',
        '', 0, 500);
  finally
    FreeAndNil(CstPisDB);
  end;
end;

procedure TCstPisController.Excluir(id: Integer);
var
  CstPis: TCstPis;
begin
  CstPis := TCstPisService.ConsultarObjeto(id);

  if not Assigned(CstPis) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir CstPis]',
      '', 0, 400);

  try
    if TCstPisService.Excluir(CstPis) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir CstPis]',
        '', 0, 500);
  finally
    FreeAndNil(CstPis)
  end;
end;

end.
