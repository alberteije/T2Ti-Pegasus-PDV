{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_NATUREZA_FINANCEIRA] 
                                                                                
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
unit FinNaturezaFinanceiraController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD FinNaturezaFinanceira')]
  [MVCPath('/fin-natureza-financeira')]
  TFinNaturezaFinanceiraController = class(TMVCController)
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

{ TFinNaturezaFinanceiraController }

uses FinNaturezaFinanceiraService, FinNaturezaFinanceira, Commons, Filtro;

procedure TFinNaturezaFinanceiraController.ConsultarLista(Context: TWebContext);
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
      Render<TFinNaturezaFinanceira>(TFinNaturezaFinanceiraService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TFinNaturezaFinanceira>(TFinNaturezaFinanceiraService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista FinNaturezaFinanceira] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinNaturezaFinanceiraController.ConsultarObjeto(id: Integer);
var
  FinNaturezaFinanceira: TFinNaturezaFinanceira;
begin
  try
    FinNaturezaFinanceira := TFinNaturezaFinanceiraService.ConsultarObjeto(id);

    if Assigned(FinNaturezaFinanceira) then
      Render(FinNaturezaFinanceira)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto FinNaturezaFinanceira]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto FinNaturezaFinanceira] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinNaturezaFinanceiraController.Inserir(Context: TWebContext);
var
  FinNaturezaFinanceira: TFinNaturezaFinanceira;
begin
  try
    FinNaturezaFinanceira := Context.Request.BodyAs<TFinNaturezaFinanceira>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir FinNaturezaFinanceira] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TFinNaturezaFinanceiraService.Inserir(FinNaturezaFinanceira);
    Render(TFinNaturezaFinanceiraService.ConsultarObjeto(FinNaturezaFinanceira.Id));
  finally
  end;
end;

procedure TFinNaturezaFinanceiraController.Alterar(id: Integer);
var
  FinNaturezaFinanceira, FinNaturezaFinanceiraDB: TFinNaturezaFinanceira;
begin
  try
    FinNaturezaFinanceira := Context.Request.BodyAs<TFinNaturezaFinanceira>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar FinNaturezaFinanceira] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if FinNaturezaFinanceira.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar FinNaturezaFinanceira] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  FinNaturezaFinanceiraDB := TFinNaturezaFinanceiraService.ConsultarObjeto(FinNaturezaFinanceira.id);

  if not Assigned(FinNaturezaFinanceiraDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar FinNaturezaFinanceira]',
      '', 0, 400);

  try
    if TFinNaturezaFinanceiraService.Alterar(FinNaturezaFinanceira) > 0 then
      Render(TFinNaturezaFinanceiraService.ConsultarObjeto(FinNaturezaFinanceira.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar FinNaturezaFinanceira]',
        '', 0, 500);
  finally
    FreeAndNil(FinNaturezaFinanceiraDB);
  end;
end;

procedure TFinNaturezaFinanceiraController.Excluir(id: Integer);
var
  FinNaturezaFinanceira: TFinNaturezaFinanceira;
begin
  FinNaturezaFinanceira := TFinNaturezaFinanceiraService.ConsultarObjeto(id);

  if not Assigned(FinNaturezaFinanceira) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir FinNaturezaFinanceira]',
      '', 0, 400);

  try
    if TFinNaturezaFinanceiraService.Excluir(FinNaturezaFinanceira) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir FinNaturezaFinanceira]',
        '', 0, 500);
  finally
    FreeAndNil(FinNaturezaFinanceira)
  end;
end;

end.
