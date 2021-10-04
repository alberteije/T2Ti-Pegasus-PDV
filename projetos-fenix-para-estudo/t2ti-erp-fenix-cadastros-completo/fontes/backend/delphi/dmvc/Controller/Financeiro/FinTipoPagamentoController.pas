{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_TIPO_PAGAMENTO] 
                                                                                
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
unit FinTipoPagamentoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD FinTipoPagamento')]
  [MVCPath('/fin-tipo-pagamento')]
  TFinTipoPagamentoController = class(TMVCController)
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

{ TFinTipoPagamentoController }

uses FinTipoPagamentoService, FinTipoPagamento, Commons, Filtro;

procedure TFinTipoPagamentoController.ConsultarLista(Context: TWebContext);
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
      Render<TFinTipoPagamento>(TFinTipoPagamentoService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TFinTipoPagamento>(TFinTipoPagamentoService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista FinTipoPagamento] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinTipoPagamentoController.ConsultarObjeto(id: Integer);
var
  FinTipoPagamento: TFinTipoPagamento;
begin
  try
    FinTipoPagamento := TFinTipoPagamentoService.ConsultarObjeto(id);

    if Assigned(FinTipoPagamento) then
      Render(FinTipoPagamento)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto FinTipoPagamento]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto FinTipoPagamento] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinTipoPagamentoController.Inserir(Context: TWebContext);
var
  FinTipoPagamento: TFinTipoPagamento;
begin
  try
    FinTipoPagamento := Context.Request.BodyAs<TFinTipoPagamento>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir FinTipoPagamento] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TFinTipoPagamentoService.Inserir(FinTipoPagamento);
    Render(TFinTipoPagamentoService.ConsultarObjeto(FinTipoPagamento.Id));
  finally
  end;
end;

procedure TFinTipoPagamentoController.Alterar(id: Integer);
var
  FinTipoPagamento, FinTipoPagamentoDB: TFinTipoPagamento;
begin
  try
    FinTipoPagamento := Context.Request.BodyAs<TFinTipoPagamento>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar FinTipoPagamento] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if FinTipoPagamento.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar FinTipoPagamento] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  FinTipoPagamentoDB := TFinTipoPagamentoService.ConsultarObjeto(FinTipoPagamento.id);

  if not Assigned(FinTipoPagamentoDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar FinTipoPagamento]',
      '', 0, 400);

  try
    if TFinTipoPagamentoService.Alterar(FinTipoPagamento) > 0 then
      Render(TFinTipoPagamentoService.ConsultarObjeto(FinTipoPagamento.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar FinTipoPagamento]',
        '', 0, 500);
  finally
    FreeAndNil(FinTipoPagamentoDB);
  end;
end;

procedure TFinTipoPagamentoController.Excluir(id: Integer);
var
  FinTipoPagamento: TFinTipoPagamento;
begin
  FinTipoPagamento := TFinTipoPagamentoService.ConsultarObjeto(id);

  if not Assigned(FinTipoPagamento) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir FinTipoPagamento]',
      '', 0, 400);

  try
    if TFinTipoPagamentoService.Excluir(FinTipoPagamento) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir FinTipoPagamento]',
        '', 0, 500);
  finally
    FreeAndNil(FinTipoPagamento)
  end;
end;

end.
