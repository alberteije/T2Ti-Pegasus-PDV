{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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
unit FinLancamentoPagarController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD FinLancamentoPagar')]
  [MVCPath('/fin-lancamento-pagar')]
  TFinLancamentoPagarController = class(TMVCController)
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

{ TFinLancamentoPagarController }

uses FinLancamentoPagarService, FinLancamentoPagar, Commons, Filtro;

procedure TFinLancamentoPagarController.ConsultarLista(Context: TWebContext);
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
      Render<TFinLancamentoPagar>(TFinLancamentoPagarService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TFinLancamentoPagar>(TFinLancamentoPagarService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista FinLancamentoPagar] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinLancamentoPagarController.ConsultarObjeto(id: Integer);
var
  FinLancamentoPagar: TFinLancamentoPagar;
begin
  try
    FinLancamentoPagar := TFinLancamentoPagarService.ConsultarObjeto(id);

    if Assigned(FinLancamentoPagar) then
      Render(FinLancamentoPagar)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto FinLancamentoPagar]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto FinLancamentoPagar] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinLancamentoPagarController.Inserir(Context: TWebContext);
var
  FinLancamentoPagar: TFinLancamentoPagar;
begin
  try
    FinLancamentoPagar := Context.Request.BodyAs<TFinLancamentoPagar>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir FinLancamentoPagar] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TFinLancamentoPagarService.Inserir(FinLancamentoPagar);
    Render(TFinLancamentoPagarService.ConsultarObjeto(FinLancamentoPagar.Id));
  finally
  end;
end;

procedure TFinLancamentoPagarController.Alterar(id: Integer);
var
  FinLancamentoPagar, FinLancamentoPagarDB: TFinLancamentoPagar;
begin
  try
    FinLancamentoPagar := Context.Request.BodyAs<TFinLancamentoPagar>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar FinLancamentoPagar] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if FinLancamentoPagar.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar FinLancamentoPagar] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  FinLancamentoPagarDB := TFinLancamentoPagarService.ConsultarObjeto(FinLancamentoPagar.id);

  if not Assigned(FinLancamentoPagarDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar FinLancamentoPagar]',
      '', 0, 400);

  try
    if TFinLancamentoPagarService.Alterar(FinLancamentoPagar) > 0 then
      Render(TFinLancamentoPagarService.ConsultarObjeto(FinLancamentoPagar.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar FinLancamentoPagar]',
        '', 0, 500);
  finally
    FreeAndNil(FinLancamentoPagarDB);
  end;
end;

procedure TFinLancamentoPagarController.Excluir(id: Integer);
var
  FinLancamentoPagar: TFinLancamentoPagar;
begin
  FinLancamentoPagar := TFinLancamentoPagarService.ConsultarObjeto(id);

  if not Assigned(FinLancamentoPagar) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir FinLancamentoPagar]',
      '', 0, 400);

  try
    if TFinLancamentoPagarService.Excluir(FinLancamentoPagar) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir FinLancamentoPagar]',
        '', 0, 500);
  finally
    FreeAndNil(FinLancamentoPagar)
  end;
end;

end.
