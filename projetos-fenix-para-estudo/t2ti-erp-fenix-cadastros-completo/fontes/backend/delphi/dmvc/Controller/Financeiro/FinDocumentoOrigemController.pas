{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_DOCUMENTO_ORIGEM] 
                                                                                
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
unit FinDocumentoOrigemController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD FinDocumentoOrigem')]
  [MVCPath('/fin-documento-origem')]
  TFinDocumentoOrigemController = class(TMVCController)
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

{ TFinDocumentoOrigemController }

uses FinDocumentoOrigemService, FinDocumentoOrigem, Commons, Filtro;

procedure TFinDocumentoOrigemController.ConsultarLista(Context: TWebContext);
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
      Render<TFinDocumentoOrigem>(TFinDocumentoOrigemService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TFinDocumentoOrigem>(TFinDocumentoOrigemService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista FinDocumentoOrigem] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinDocumentoOrigemController.ConsultarObjeto(id: Integer);
var
  FinDocumentoOrigem: TFinDocumentoOrigem;
begin
  try
    FinDocumentoOrigem := TFinDocumentoOrigemService.ConsultarObjeto(id);

    if Assigned(FinDocumentoOrigem) then
      Render(FinDocumentoOrigem)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto FinDocumentoOrigem]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto FinDocumentoOrigem] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinDocumentoOrigemController.Inserir(Context: TWebContext);
var
  FinDocumentoOrigem: TFinDocumentoOrigem;
begin
  try
    FinDocumentoOrigem := Context.Request.BodyAs<TFinDocumentoOrigem>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir FinDocumentoOrigem] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TFinDocumentoOrigemService.Inserir(FinDocumentoOrigem);
    Render(TFinDocumentoOrigemService.ConsultarObjeto(FinDocumentoOrigem.Id));
  finally
  end;
end;

procedure TFinDocumentoOrigemController.Alterar(id: Integer);
var
  FinDocumentoOrigem, FinDocumentoOrigemDB: TFinDocumentoOrigem;
begin
  try
    FinDocumentoOrigem := Context.Request.BodyAs<TFinDocumentoOrigem>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar FinDocumentoOrigem] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if FinDocumentoOrigem.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar FinDocumentoOrigem] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  FinDocumentoOrigemDB := TFinDocumentoOrigemService.ConsultarObjeto(FinDocumentoOrigem.id);

  if not Assigned(FinDocumentoOrigemDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar FinDocumentoOrigem]',
      '', 0, 400);

  try
    if TFinDocumentoOrigemService.Alterar(FinDocumentoOrigem) > 0 then
      Render(TFinDocumentoOrigemService.ConsultarObjeto(FinDocumentoOrigem.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar FinDocumentoOrigem]',
        '', 0, 500);
  finally
    FreeAndNil(FinDocumentoOrigemDB);
  end;
end;

procedure TFinDocumentoOrigemController.Excluir(id: Integer);
var
  FinDocumentoOrigem: TFinDocumentoOrigem;
begin
  FinDocumentoOrigem := TFinDocumentoOrigemService.ConsultarObjeto(id);

  if not Assigned(FinDocumentoOrigem) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir FinDocumentoOrigem]',
      '', 0, 400);

  try
    if TFinDocumentoOrigemService.Excluir(FinDocumentoOrigem) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir FinDocumentoOrigem]',
        '', 0, 500);
  finally
    FreeAndNil(FinDocumentoOrigem)
  end;
end;

end.
