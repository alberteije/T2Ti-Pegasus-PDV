{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [CARGO] 
                                                                                
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
unit CargoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD Cargo')]
  [MVCPath('/cargo')]
  TCargoController = class(TMVCController)
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

{ TCargoController }

uses CargoService, Cargo, Commons, Filtro;

procedure TCargoController.ConsultarLista(Context: TWebContext);
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
      Render<TCargo>(TCargoService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TCargo>(TCargoService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista Cargo] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TCargoController.ConsultarObjeto(id: Integer);
var
  Cargo: TCargo;
begin
  try
    Cargo := TCargoService.ConsultarObjeto(id);

    if Assigned(Cargo) then
      Render(Cargo)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto Cargo]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto Cargo] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TCargoController.Inserir(Context: TWebContext);
var
  Cargo: TCargo;
begin
  try
    Cargo := Context.Request.BodyAs<TCargo>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir Cargo] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TCargoService.Inserir(Cargo);
    Render(TCargoService.ConsultarObjeto(Cargo.Id));
  finally
  end;
end;

procedure TCargoController.Alterar(id: Integer);
var
  Cargo, CargoDB: TCargo;
begin
  try
    Cargo := Context.Request.BodyAs<TCargo>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar Cargo] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if Cargo.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar Cargo] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  CargoDB := TCargoService.ConsultarObjeto(Cargo.id);

  if not Assigned(CargoDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar Cargo]',
      '', 0, 400);

  try
    if TCargoService.Alterar(Cargo) > 0 then
      Render(TCargoService.ConsultarObjeto(Cargo.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar Cargo]',
        '', 0, 500);
  finally
    FreeAndNil(CargoDB);
  end;
end;

procedure TCargoController.Excluir(id: Integer);
var
  Cargo: TCargo;
begin
  Cargo := TCargoService.ConsultarObjeto(id);

  if not Assigned(Cargo) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir Cargo]',
      '', 0, 400);

  try
    if TCargoService.Excluir(Cargo) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir Cargo]',
        '', 0, 500);
  finally
    FreeAndNil(Cargo)
  end;
end;

end.
