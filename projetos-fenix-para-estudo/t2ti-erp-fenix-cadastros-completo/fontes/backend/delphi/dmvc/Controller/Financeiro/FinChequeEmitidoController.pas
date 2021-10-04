{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_CHEQUE_EMITIDO] 
                                                                                
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
unit FinChequeEmitidoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD FinChequeEmitido')]
  [MVCPath('/fin-cheque-emitido')]
  TFinChequeEmitidoController = class(TMVCController)
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

{ TFinChequeEmitidoController }

uses FinChequeEmitidoService, FinChequeEmitido, Commons, Filtro;

procedure TFinChequeEmitidoController.ConsultarLista(Context: TWebContext);
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
      Render<TFinChequeEmitido>(TFinChequeEmitidoService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TFinChequeEmitido>(TFinChequeEmitidoService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista FinChequeEmitido] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinChequeEmitidoController.ConsultarObjeto(id: Integer);
var
  FinChequeEmitido: TFinChequeEmitido;
begin
  try
    FinChequeEmitido := TFinChequeEmitidoService.ConsultarObjeto(id);

    if Assigned(FinChequeEmitido) then
      Render(FinChequeEmitido)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto FinChequeEmitido]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto FinChequeEmitido] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinChequeEmitidoController.Inserir(Context: TWebContext);
var
  FinChequeEmitido: TFinChequeEmitido;
begin
  try
    FinChequeEmitido := Context.Request.BodyAs<TFinChequeEmitido>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir FinChequeEmitido] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TFinChequeEmitidoService.Inserir(FinChequeEmitido);
    Render(TFinChequeEmitidoService.ConsultarObjeto(FinChequeEmitido.Id));
  finally
  end;
end;

procedure TFinChequeEmitidoController.Alterar(id: Integer);
var
  FinChequeEmitido, FinChequeEmitidoDB: TFinChequeEmitido;
begin
  try
    FinChequeEmitido := Context.Request.BodyAs<TFinChequeEmitido>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar FinChequeEmitido] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if FinChequeEmitido.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar FinChequeEmitido] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  FinChequeEmitidoDB := TFinChequeEmitidoService.ConsultarObjeto(FinChequeEmitido.id);

  if not Assigned(FinChequeEmitidoDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar FinChequeEmitido]',
      '', 0, 400);

  try
    if TFinChequeEmitidoService.Alterar(FinChequeEmitido) > 0 then
      Render(TFinChequeEmitidoService.ConsultarObjeto(FinChequeEmitido.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar FinChequeEmitido]',
        '', 0, 500);
  finally
    FreeAndNil(FinChequeEmitidoDB);
  end;
end;

procedure TFinChequeEmitidoController.Excluir(id: Integer);
var
  FinChequeEmitido: TFinChequeEmitido;
begin
  FinChequeEmitido := TFinChequeEmitidoService.ConsultarObjeto(id);

  if not Assigned(FinChequeEmitido) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir FinChequeEmitido]',
      '', 0, 400);

  try
    if TFinChequeEmitidoService.Excluir(FinChequeEmitido) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir FinChequeEmitido]',
        '', 0, 500);
  finally
    FreeAndNil(FinChequeEmitido)
  end;
end;

end.
