{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [FIN_TIPO_RECEBIMENTO] 
                                                                                
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
unit FinTipoRecebimentoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD FinTipoRecebimento')]
  [MVCPath('/fin-tipo-recebimento')]
  TFinTipoRecebimentoController = class(TMVCController)
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

{ TFinTipoRecebimentoController }

uses FinTipoRecebimentoService, FinTipoRecebimento, Commons, Filtro;

procedure TFinTipoRecebimentoController.ConsultarLista(Context: TWebContext);
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
      Render<TFinTipoRecebimento>(TFinTipoRecebimentoService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TFinTipoRecebimento>(TFinTipoRecebimentoService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista FinTipoRecebimento] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinTipoRecebimentoController.ConsultarObjeto(id: Integer);
var
  FinTipoRecebimento: TFinTipoRecebimento;
begin
  try
    FinTipoRecebimento := TFinTipoRecebimentoService.ConsultarObjeto(id);

    if Assigned(FinTipoRecebimento) then
      Render(FinTipoRecebimento)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto FinTipoRecebimento]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto FinTipoRecebimento] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TFinTipoRecebimentoController.Inserir(Context: TWebContext);
var
  FinTipoRecebimento: TFinTipoRecebimento;
begin
  try
    FinTipoRecebimento := Context.Request.BodyAs<TFinTipoRecebimento>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir FinTipoRecebimento] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TFinTipoRecebimentoService.Inserir(FinTipoRecebimento);
    Render(TFinTipoRecebimentoService.ConsultarObjeto(FinTipoRecebimento.Id));
  finally
  end;
end;

procedure TFinTipoRecebimentoController.Alterar(id: Integer);
var
  FinTipoRecebimento, FinTipoRecebimentoDB: TFinTipoRecebimento;
begin
  try
    FinTipoRecebimento := Context.Request.BodyAs<TFinTipoRecebimento>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar FinTipoRecebimento] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if FinTipoRecebimento.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar FinTipoRecebimento] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  FinTipoRecebimentoDB := TFinTipoRecebimentoService.ConsultarObjeto(FinTipoRecebimento.id);

  if not Assigned(FinTipoRecebimentoDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar FinTipoRecebimento]',
      '', 0, 400);

  try
    if TFinTipoRecebimentoService.Alterar(FinTipoRecebimento) > 0 then
      Render(TFinTipoRecebimentoService.ConsultarObjeto(FinTipoRecebimento.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar FinTipoRecebimento]',
        '', 0, 500);
  finally
    FreeAndNil(FinTipoRecebimentoDB);
  end;
end;

procedure TFinTipoRecebimentoController.Excluir(id: Integer);
var
  FinTipoRecebimento: TFinTipoRecebimento;
begin
  FinTipoRecebimento := TFinTipoRecebimentoService.ConsultarObjeto(id);

  if not Assigned(FinTipoRecebimento) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir FinTipoRecebimento]',
      '', 0, 400);

  try
    if TFinTipoRecebimentoService.Excluir(FinTipoRecebimento) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir FinTipoRecebimento]',
        '', 0, 500);
  finally
    FreeAndNil(FinTipoRecebimento)
  end;
end;

end.
