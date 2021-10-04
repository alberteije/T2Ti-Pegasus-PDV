{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [VENDEDOR] 
                                                                                
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
unit VendedorController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD Vendedor')]
  [MVCPath('/vendedor')]
  TVendedorController = class(TMVCController)
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

{ TVendedorController }

uses VendedorService, Vendedor, Commons, Filtro;

procedure TVendedorController.ConsultarLista(Context: TWebContext);
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
      Render<TVendedor>(TVendedorService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TVendedor>(TVendedorService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista Vendedor] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TVendedorController.ConsultarObjeto(id: Integer);
var
  Vendedor: TVendedor;
begin
  try
    Vendedor := TVendedorService.ConsultarObjeto(id);

    if Assigned(Vendedor) then
      Render(Vendedor)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto Vendedor]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto Vendedor] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TVendedorController.Inserir(Context: TWebContext);
var
  Vendedor: TVendedor;
begin
  try
    Vendedor := Context.Request.BodyAs<TVendedor>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir Vendedor] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TVendedorService.Inserir(Vendedor);
    Render(TVendedorService.ConsultarObjeto(Vendedor.Id));
  finally
  end;
end;

procedure TVendedorController.Alterar(id: Integer);
var
  Vendedor, VendedorDB: TVendedor;
begin
  try
    Vendedor := Context.Request.BodyAs<TVendedor>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar Vendedor] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if Vendedor.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar Vendedor] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  VendedorDB := TVendedorService.ConsultarObjeto(Vendedor.id);

  if not Assigned(VendedorDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar Vendedor]',
      '', 0, 400);

  try
    if TVendedorService.Alterar(Vendedor) > 0 then
      Render(TVendedorService.ConsultarObjeto(Vendedor.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar Vendedor]',
        '', 0, 500);
  finally
    FreeAndNil(VendedorDB);
  end;
end;

procedure TVendedorController.Excluir(id: Integer);
var
  Vendedor: TVendedor;
begin
  Vendedor := TVendedorService.ConsultarObjeto(id);

  if not Assigned(Vendedor) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir Vendedor]',
      '', 0, 400);

  try
    if TVendedorService.Excluir(Vendedor) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir Vendedor]',
        '', 0, 500);
  finally
    FreeAndNil(Vendedor)
  end;
end;

end.
