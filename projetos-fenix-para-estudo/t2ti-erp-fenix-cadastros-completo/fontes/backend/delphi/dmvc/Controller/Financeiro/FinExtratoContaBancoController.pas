{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_EXTRATO_CONTA_BANCO] 
                                                                                
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
unit FinExtratoContaBancoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD FinExtratoContaBanco')]
  [MVCPath('/fin-extrato-conta-banco')]
  TFinExtratoContaBancoController = class(TMVCController)
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

{ TFinExtratoContaBancoController }

uses FinExtratoContaBancoService, FinExtratoContaBanco, Commons, Filtro;

procedure TFinExtratoContaBancoController.ConsultarLista(Context: TWebContext);
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
      Render<TFinExtratoContaBanco>(TFinExtratoContaBancoService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TFinExtratoContaBanco>(TFinExtratoContaBancoService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista FinExtratoContaBanco] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinExtratoContaBancoController.ConsultarObjeto(id: Integer);
var
  FinExtratoContaBanco: TFinExtratoContaBanco;
begin
  try
    FinExtratoContaBanco := TFinExtratoContaBancoService.ConsultarObjeto(id);

    if Assigned(FinExtratoContaBanco) then
      Render(FinExtratoContaBanco)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto FinExtratoContaBanco]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto FinExtratoContaBanco] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinExtratoContaBancoController.Inserir(Context: TWebContext);
var
  FinExtratoContaBanco: TFinExtratoContaBanco;
begin
  try
    FinExtratoContaBanco := Context.Request.BodyAs<TFinExtratoContaBanco>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir FinExtratoContaBanco] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TFinExtratoContaBancoService.Inserir(FinExtratoContaBanco);
    Render(TFinExtratoContaBancoService.ConsultarObjeto(FinExtratoContaBanco.Id));
  finally
  end;
end;

procedure TFinExtratoContaBancoController.Alterar(id: Integer);
var
  FinExtratoContaBanco, FinExtratoContaBancoDB: TFinExtratoContaBanco;
begin
  try
    FinExtratoContaBanco := Context.Request.BodyAs<TFinExtratoContaBanco>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar FinExtratoContaBanco] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if FinExtratoContaBanco.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar FinExtratoContaBanco] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  FinExtratoContaBancoDB := TFinExtratoContaBancoService.ConsultarObjeto(FinExtratoContaBanco.id);

  if not Assigned(FinExtratoContaBancoDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar FinExtratoContaBanco]',
      '', 0, 400);

  try
    if TFinExtratoContaBancoService.Alterar(FinExtratoContaBanco) > 0 then
      Render(TFinExtratoContaBancoService.ConsultarObjeto(FinExtratoContaBanco.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar FinExtratoContaBanco]',
        '', 0, 500);
  finally
    FreeAndNil(FinExtratoContaBancoDB);
  end;
end;

procedure TFinExtratoContaBancoController.Excluir(id: Integer);
var
  FinExtratoContaBanco: TFinExtratoContaBanco;
begin
  FinExtratoContaBanco := TFinExtratoContaBancoService.ConsultarObjeto(id);

  if not Assigned(FinExtratoContaBanco) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir FinExtratoContaBanco]',
      '', 0, 400);

  try
    if TFinExtratoContaBancoService.Excluir(FinExtratoContaBanco) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir FinExtratoContaBanco]',
        '', 0, 500);
  finally
    FreeAndNil(FinExtratoContaBanco)
  end;
end;

end.
