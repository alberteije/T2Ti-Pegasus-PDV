{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [CST_IPI] 
                                                                                
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
unit CstIpiController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD CstIpi')]
  [MVCPath('/cst-ipi')]
  TCstIpiController = class(TMVCController)
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

{ TCstIpiController }

uses CstIpiService, CstIpi, Commons, Filtro;

procedure TCstIpiController.ConsultarLista(Context: TWebContext);
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
      Render<TCstIpi>(TCstIpiService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TCstIpi>(TCstIpiService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista CstIpi] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TCstIpiController.ConsultarObjeto(id: Integer);
var
  CstIpi: TCstIpi;
begin
  try
    CstIpi := TCstIpiService.ConsultarObjeto(id);

    if Assigned(CstIpi) then
      Render(CstIpi)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto CstIpi]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto CstIpi] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TCstIpiController.Inserir(Context: TWebContext);
var
  CstIpi: TCstIpi;
begin
  try
    CstIpi := Context.Request.BodyAs<TCstIpi>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir CstIpi] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TCstIpiService.Inserir(CstIpi);
    Render(TCstIpiService.ConsultarObjeto(CstIpi.Id));
  finally
  end;
end;

procedure TCstIpiController.Alterar(id: Integer);
var
  CstIpi, CstIpiDB: TCstIpi;
begin
  try
    CstIpi := Context.Request.BodyAs<TCstIpi>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar CstIpi] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if CstIpi.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar CstIpi] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  CstIpiDB := TCstIpiService.ConsultarObjeto(CstIpi.id);

  if not Assigned(CstIpiDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar CstIpi]',
      '', 0, 400);

  try
    if TCstIpiService.Alterar(CstIpi) > 0 then
      Render(TCstIpiService.ConsultarObjeto(CstIpi.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar CstIpi]',
        '', 0, 500);
  finally
    FreeAndNil(CstIpiDB);
  end;
end;

procedure TCstIpiController.Excluir(id: Integer);
var
  CstIpi: TCstIpi;
begin
  CstIpi := TCstIpiService.ConsultarObjeto(id);

  if not Assigned(CstIpi) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir CstIpi]',
      '', 0, 400);

  try
    if TCstIpiService.Excluir(CstIpi) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir CstIpi]',
        '', 0, 500);
  finally
    FreeAndNil(CstIpi)
  end;
end;

end.
