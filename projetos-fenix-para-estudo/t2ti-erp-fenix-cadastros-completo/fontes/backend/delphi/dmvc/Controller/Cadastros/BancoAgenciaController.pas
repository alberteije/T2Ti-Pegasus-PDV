{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [BANCO_AGENCIA] 
                                                                                
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
unit BancoAgenciaController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD BancoAgencia')]
  [MVCPath('/banco-agencia')]
  TBancoAgenciaController = class(TMVCController)
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

{ TBancoAgenciaController }

uses BancoAgenciaService, BancoAgencia, Commons, Filtro;

procedure TBancoAgenciaController.ConsultarLista(Context: TWebContext);
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
      Render<TBancoAgencia>(TBancoAgenciaService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TBancoAgencia>(TBancoAgenciaService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista BancoAgencia] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TBancoAgenciaController.ConsultarObjeto(id: Integer);
var
  BancoAgencia: TBancoAgencia;
begin
  try
    BancoAgencia := TBancoAgenciaService.ConsultarObjeto(id);

    if Assigned(BancoAgencia) then
      Render(BancoAgencia)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto BancoAgencia]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto BancoAgencia] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TBancoAgenciaController.Inserir(Context: TWebContext);
var
  BancoAgencia: TBancoAgencia;
begin
  try
    BancoAgencia := Context.Request.BodyAs<TBancoAgencia>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir BancoAgencia] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TBancoAgenciaService.Inserir(BancoAgencia);
    Render(TBancoAgenciaService.ConsultarObjeto(BancoAgencia.Id));
  finally
  end;
end;

procedure TBancoAgenciaController.Alterar(id: Integer);
var
  BancoAgencia, BancoAgenciaDB: TBancoAgencia;
begin
  try
    BancoAgencia := Context.Request.BodyAs<TBancoAgencia>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar BancoAgencia] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if BancoAgencia.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar BancoAgencia] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  BancoAgenciaDB := TBancoAgenciaService.ConsultarObjeto(BancoAgencia.id);

  if not Assigned(BancoAgenciaDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar BancoAgencia]',
      '', 0, 400);

  try
    if TBancoAgenciaService.Alterar(BancoAgencia) > 0 then
      Render(TBancoAgenciaService.ConsultarObjeto(BancoAgencia.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar BancoAgencia]',
        '', 0, 500);
  finally
    FreeAndNil(BancoAgenciaDB);
  end;
end;

procedure TBancoAgenciaController.Excluir(id: Integer);
var
  BancoAgencia: TBancoAgencia;
begin
  BancoAgencia := TBancoAgenciaService.ConsultarObjeto(id);

  if not Assigned(BancoAgencia) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir BancoAgencia]',
      '', 0, 400);

  try
    if TBancoAgenciaService.Excluir(BancoAgencia) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir BancoAgencia]',
        '', 0, 500);
  finally
    FreeAndNil(BancoAgencia)
  end;
end;

end.
