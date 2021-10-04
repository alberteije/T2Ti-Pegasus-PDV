{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [BANCO_CONTA_CAIXA] 
                                                                                
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
unit BancoContaCaixaController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD BancoContaCaixa')]
  [MVCPath('/banco-conta-caixa')]
  TBancoContaCaixaController = class(TMVCController)
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

{ TBancoContaCaixaController }

uses BancoContaCaixaService, BancoContaCaixa, Commons, Filtro;

procedure TBancoContaCaixaController.ConsultarLista(Context: TWebContext);
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
      Render<TBancoContaCaixa>(TBancoContaCaixaService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TBancoContaCaixa>(TBancoContaCaixaService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista BancoContaCaixa] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TBancoContaCaixaController.ConsultarObjeto(id: Integer);
var
  BancoContaCaixa: TBancoContaCaixa;
begin
  try
    BancoContaCaixa := TBancoContaCaixaService.ConsultarObjeto(id);

    if Assigned(BancoContaCaixa) then
      Render(BancoContaCaixa)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto BancoContaCaixa]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto BancoContaCaixa] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TBancoContaCaixaController.Inserir(Context: TWebContext);
var
  BancoContaCaixa: TBancoContaCaixa;
begin
  try
    BancoContaCaixa := Context.Request.BodyAs<TBancoContaCaixa>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir BancoContaCaixa] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TBancoContaCaixaService.Inserir(BancoContaCaixa);
    Render(TBancoContaCaixaService.ConsultarObjeto(BancoContaCaixa.Id));
  finally
  end;
end;

procedure TBancoContaCaixaController.Alterar(id: Integer);
var
  BancoContaCaixa, BancoContaCaixaDB: TBancoContaCaixa;
begin
  try
    BancoContaCaixa := Context.Request.BodyAs<TBancoContaCaixa>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar BancoContaCaixa] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if BancoContaCaixa.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar BancoContaCaixa] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  BancoContaCaixaDB := TBancoContaCaixaService.ConsultarObjeto(BancoContaCaixa.id);

  if not Assigned(BancoContaCaixaDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar BancoContaCaixa]',
      '', 0, 400);

  try
    if TBancoContaCaixaService.Alterar(BancoContaCaixa) > 0 then
      Render(TBancoContaCaixaService.ConsultarObjeto(BancoContaCaixa.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar BancoContaCaixa]',
        '', 0, 500);
  finally
    FreeAndNil(BancoContaCaixaDB);
  end;
end;

procedure TBancoContaCaixaController.Excluir(id: Integer);
var
  BancoContaCaixa: TBancoContaCaixa;
begin
  BancoContaCaixa := TBancoContaCaixaService.ConsultarObjeto(id);

  if not Assigned(BancoContaCaixa) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir BancoContaCaixa]',
      '', 0, 400);

  try
    if TBancoContaCaixaService.Excluir(BancoContaCaixa) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir BancoContaCaixa]',
        '', 0, 500);
  finally
    FreeAndNil(BancoContaCaixa)
  end;
end;

end.
