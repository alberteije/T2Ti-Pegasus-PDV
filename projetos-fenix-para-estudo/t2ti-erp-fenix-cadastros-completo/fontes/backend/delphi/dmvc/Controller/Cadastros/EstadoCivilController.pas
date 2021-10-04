{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [ESTADO_CIVIL] 
                                                                                
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
unit EstadoCivilController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD EstadoCivil')]
  [MVCPath('/estado-civil')]
  TEstadoCivilController = class(TMVCController)
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

{ TEstadoCivilController }

uses EstadoCivilService, EstadoCivil, Commons, Filtro;

procedure TEstadoCivilController.ConsultarLista(Context: TWebContext);
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
      Render<TEstadoCivil>(TEstadoCivilService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TEstadoCivil>(TEstadoCivilService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista EstadoCivil] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TEstadoCivilController.ConsultarObjeto(id: Integer);
var
  EstadoCivil: TEstadoCivil;
begin
  try
    EstadoCivil := TEstadoCivilService.ConsultarObjeto(id);

    if Assigned(EstadoCivil) then
      Render(EstadoCivil)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto EstadoCivil]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto EstadoCivil] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TEstadoCivilController.Inserir(Context: TWebContext);
var
  EstadoCivil: TEstadoCivil;
begin
  try
    EstadoCivil := Context.Request.BodyAs<TEstadoCivil>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir EstadoCivil] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TEstadoCivilService.Inserir(EstadoCivil);
    Render(TEstadoCivilService.ConsultarObjeto(EstadoCivil.Id));
  finally
  end;
end;

procedure TEstadoCivilController.Alterar(id: Integer);
var
  EstadoCivil, EstadoCivilDB: TEstadoCivil;
begin
  try
    EstadoCivil := Context.Request.BodyAs<TEstadoCivil>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar EstadoCivil] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if EstadoCivil.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar EstadoCivil] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  EstadoCivilDB := TEstadoCivilService.ConsultarObjeto(EstadoCivil.id);

  if not Assigned(EstadoCivilDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar EstadoCivil]',
      '', 0, 400);

  try
    if TEstadoCivilService.Alterar(EstadoCivil) > 0 then
      Render(TEstadoCivilService.ConsultarObjeto(EstadoCivil.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar EstadoCivil]',
        '', 0, 500);
  finally
    FreeAndNil(EstadoCivilDB);
  end;
end;

procedure TEstadoCivilController.Excluir(id: Integer);
var
  EstadoCivil: TEstadoCivil;
begin
  EstadoCivil := TEstadoCivilService.ConsultarObjeto(id);

  if not Assigned(EstadoCivil) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir EstadoCivil]',
      '', 0, 400);

  try
    if TEstadoCivilService.Excluir(EstadoCivil) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir EstadoCivil]',
        '', 0, 500);
  finally
    FreeAndNil(EstadoCivil)
  end;
end;

end.
