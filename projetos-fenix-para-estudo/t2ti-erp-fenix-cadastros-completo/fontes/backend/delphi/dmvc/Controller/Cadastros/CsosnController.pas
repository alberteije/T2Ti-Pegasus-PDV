{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [CSOSN] 
                                                                                
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
unit CsosnController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD Csosn')]
  [MVCPath('/csosn')]
  TCsosnController = class(TMVCController)
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

{ TCsosnController }

uses CsosnService, Csosn, Commons, Filtro;

procedure TCsosnController.ConsultarLista(Context: TWebContext);
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
      Render<TCsosn>(TCsosnService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TCsosn>(TCsosnService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista Csosn] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TCsosnController.ConsultarObjeto(id: Integer);
var
  Csosn: TCsosn;
begin
  try
    Csosn := TCsosnService.ConsultarObjeto(id);

    if Assigned(Csosn) then
      Render(Csosn)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto Csosn]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto Csosn] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TCsosnController.Inserir(Context: TWebContext);
var
  Csosn: TCsosn;
begin
  try
    Csosn := Context.Request.BodyAs<TCsosn>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir Csosn] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TCsosnService.Inserir(Csosn);
    Render(TCsosnService.ConsultarObjeto(Csosn.Id));
  finally
  end;
end;

procedure TCsosnController.Alterar(id: Integer);
var
  Csosn, CsosnDB: TCsosn;
begin
  try
    Csosn := Context.Request.BodyAs<TCsosn>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar Csosn] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if Csosn.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar Csosn] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  CsosnDB := TCsosnService.ConsultarObjeto(Csosn.id);

  if not Assigned(CsosnDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar Csosn]',
      '', 0, 400);

  try
    if TCsosnService.Alterar(Csosn) > 0 then
      Render(TCsosnService.ConsultarObjeto(Csosn.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar Csosn]',
        '', 0, 500);
  finally
    FreeAndNil(CsosnDB);
  end;
end;

procedure TCsosnController.Excluir(id: Integer);
var
  Csosn: TCsosn;
begin
  Csosn := TCsosnService.ConsultarObjeto(id);

  if not Assigned(Csosn) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir Csosn]',
      '', 0, 400);

  try
    if TCsosnService.Excluir(Csosn) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir Csosn]',
        '', 0, 500);
  finally
    FreeAndNil(Csosn)
  end;
end;

end.
