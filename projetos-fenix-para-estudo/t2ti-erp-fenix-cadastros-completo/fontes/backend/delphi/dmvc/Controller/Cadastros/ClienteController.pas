{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [CLIENTE] 
                                                                                
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
unit ClienteController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD Cliente')]
  [MVCPath('/cliente')]
  TClienteController = class(TMVCController)
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

{ TClienteController }

uses ClienteService, Cliente, Commons, Filtro;

procedure TClienteController.ConsultarLista(Context: TWebContext);
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
      Render<TCliente>(TClienteService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TCliente>(TClienteService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista Cliente] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TClienteController.ConsultarObjeto(id: Integer);
var
  Cliente: TCliente;
begin
  try
    Cliente := TClienteService.ConsultarObjeto(id);

    if Assigned(Cliente) then
      Render(Cliente)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto Cliente]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto Cliente] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TClienteController.Inserir(Context: TWebContext);
var
  Cliente: TCliente;
begin
  try
    Cliente := Context.Request.BodyAs<TCliente>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir Cliente] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TClienteService.Inserir(Cliente);
    Render(TClienteService.ConsultarObjeto(Cliente.Id));
  finally
  end;
end;

procedure TClienteController.Alterar(id: Integer);
var
  Cliente, ClienteDB: TCliente;
begin
  try
    Cliente := Context.Request.BodyAs<TCliente>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar Cliente] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if Cliente.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar Cliente] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  ClienteDB := TClienteService.ConsultarObjeto(Cliente.id);

  if not Assigned(ClienteDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar Cliente]',
      '', 0, 400);

  try
    if TClienteService.Alterar(Cliente) > 0 then
      Render(TClienteService.ConsultarObjeto(Cliente.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar Cliente]',
        '', 0, 500);
  finally
    FreeAndNil(ClienteDB);
  end;
end;

procedure TClienteController.Excluir(id: Integer);
var
  Cliente: TCliente;
begin
  Cliente := TClienteService.ConsultarObjeto(id);

  if not Assigned(Cliente) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir Cliente]',
      '', 0, 400);

  try
    if TClienteService.Excluir(Cliente) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir Cliente]',
        '', 0, 500);
  finally
    FreeAndNil(Cliente)
  end;
end;

end.
