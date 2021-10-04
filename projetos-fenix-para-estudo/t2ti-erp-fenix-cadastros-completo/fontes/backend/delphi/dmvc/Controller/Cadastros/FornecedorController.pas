{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FORNECEDOR] 
                                                                                
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
unit FornecedorController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD Fornecedor')]
  [MVCPath('/fornecedor')]
  TFornecedorController = class(TMVCController)
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

{ TFornecedorController }

uses FornecedorService, Fornecedor, Commons, Filtro;

procedure TFornecedorController.ConsultarLista(Context: TWebContext);
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
      Render<TFornecedor>(TFornecedorService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TFornecedor>(TFornecedorService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista Fornecedor] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFornecedorController.ConsultarObjeto(id: Integer);
var
  Fornecedor: TFornecedor;
begin
  try
    Fornecedor := TFornecedorService.ConsultarObjeto(id);

    if Assigned(Fornecedor) then
      Render(Fornecedor)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto Fornecedor]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto Fornecedor] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFornecedorController.Inserir(Context: TWebContext);
var
  Fornecedor: TFornecedor;
begin
  try
    Fornecedor := Context.Request.BodyAs<TFornecedor>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir Fornecedor] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TFornecedorService.Inserir(Fornecedor);
    Render(TFornecedorService.ConsultarObjeto(Fornecedor.Id));
  finally
  end;
end;

procedure TFornecedorController.Alterar(id: Integer);
var
  Fornecedor, FornecedorDB: TFornecedor;
begin
  try
    Fornecedor := Context.Request.BodyAs<TFornecedor>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar Fornecedor] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if Fornecedor.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar Fornecedor] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  FornecedorDB := TFornecedorService.ConsultarObjeto(Fornecedor.id);

  if not Assigned(FornecedorDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar Fornecedor]',
      '', 0, 400);

  try
    if TFornecedorService.Alterar(Fornecedor) > 0 then
      Render(TFornecedorService.ConsultarObjeto(Fornecedor.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar Fornecedor]',
        '', 0, 500);
  finally
    FreeAndNil(FornecedorDB);
  end;
end;

procedure TFornecedorController.Excluir(id: Integer);
var
  Fornecedor: TFornecedor;
begin
  Fornecedor := TFornecedorService.ConsultarObjeto(id);

  if not Assigned(Fornecedor) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir Fornecedor]',
      '', 0, 400);

  try
    if TFornecedorService.Excluir(Fornecedor) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir Fornecedor]',
        '', 0, 500);
  finally
    FreeAndNil(Fornecedor)
  end;
end;

end.
