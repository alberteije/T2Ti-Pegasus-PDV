{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [PRODUTO] 
                                                                                
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
unit ProdutoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD Produto')]
  [MVCPath('/produto')]
  TProdutoController = class(TMVCController)
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

{ TProdutoController }

uses ProdutoService, Produto, Commons, Filtro;

procedure TProdutoController.ConsultarLista(Context: TWebContext);
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
      Render<TProduto>(TProdutoService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TProduto>(TProdutoService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista Produto] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TProdutoController.ConsultarObjeto(id: Integer);
var
  Produto: TProduto;
begin
  try
    Produto := TProdutoService.ConsultarObjeto(id);

    if Assigned(Produto) then
      Render(Produto)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto Produto]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto Produto] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TProdutoController.Inserir(Context: TWebContext);
var
  Produto: TProduto;
begin
  try
    Produto := Context.Request.BodyAs<TProduto>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir Produto] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TProdutoService.Inserir(Produto);
    Render(TProdutoService.ConsultarObjeto(Produto.Id));
  finally
  end;
end;

procedure TProdutoController.Alterar(id: Integer);
var
  Produto, ProdutoDB: TProduto;
begin
  try
    Produto := Context.Request.BodyAs<TProduto>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar Produto] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if Produto.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar Produto] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  ProdutoDB := TProdutoService.ConsultarObjeto(Produto.id);

  if not Assigned(ProdutoDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar Produto]',
      '', 0, 400);

  try
    if TProdutoService.Alterar(Produto) > 0 then
      Render(TProdutoService.ConsultarObjeto(Produto.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar Produto]',
        '', 0, 500);
  finally
    FreeAndNil(ProdutoDB);
  end;
end;

procedure TProdutoController.Excluir(id: Integer);
var
  Produto: TProduto;
begin
  Produto := TProdutoService.ConsultarObjeto(id);

  if not Assigned(Produto) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir Produto]',
      '', 0, 400);

  try
    if TProdutoService.Excluir(Produto) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir Produto]',
        '', 0, 500);
  finally
    FreeAndNil(Produto)
  end;
end;

end.
