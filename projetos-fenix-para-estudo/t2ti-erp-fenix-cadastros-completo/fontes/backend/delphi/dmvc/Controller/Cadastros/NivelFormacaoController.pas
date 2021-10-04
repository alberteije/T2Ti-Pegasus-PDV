{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [NIVEL_FORMACAO] 
                                                                                
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
unit NivelFormacaoController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD NivelFormacao')]
  [MVCPath('/nivel-formacao')]
  TNivelFormacaoController = class(TMVCController)
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

{ TNivelFormacaoController }

uses NivelFormacaoService, NivelFormacao, Commons, Filtro;

procedure TNivelFormacaoController.ConsultarLista(Context: TWebContext);
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
      Render<TNivelFormacao>(TNivelFormacaoService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TNivelFormacao>(TNivelFormacaoService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista NivelFormacao] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TNivelFormacaoController.ConsultarObjeto(id: Integer);
var
  NivelFormacao: TNivelFormacao;
begin
  try
    NivelFormacao := TNivelFormacaoService.ConsultarObjeto(id);

    if Assigned(NivelFormacao) then
      Render(NivelFormacao)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto NivelFormacao]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto NivelFormacao] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TNivelFormacaoController.Inserir(Context: TWebContext);
var
  NivelFormacao: TNivelFormacao;
begin
  try
    NivelFormacao := Context.Request.BodyAs<TNivelFormacao>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir NivelFormacao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TNivelFormacaoService.Inserir(NivelFormacao);
    Render(TNivelFormacaoService.ConsultarObjeto(NivelFormacao.Id));
  finally
  end;
end;

procedure TNivelFormacaoController.Alterar(id: Integer);
var
  NivelFormacao, NivelFormacaoDB: TNivelFormacao;
begin
  try
    NivelFormacao := Context.Request.BodyAs<TNivelFormacao>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar NivelFormacao] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if NivelFormacao.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar NivelFormacao] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  NivelFormacaoDB := TNivelFormacaoService.ConsultarObjeto(NivelFormacao.id);

  if not Assigned(NivelFormacaoDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar NivelFormacao]',
      '', 0, 400);

  try
    if TNivelFormacaoService.Alterar(NivelFormacao) > 0 then
      Render(TNivelFormacaoService.ConsultarObjeto(NivelFormacao.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar NivelFormacao]',
        '', 0, 500);
  finally
    FreeAndNil(NivelFormacaoDB);
  end;
end;

procedure TNivelFormacaoController.Excluir(id: Integer);
var
  NivelFormacao: TNivelFormacao;
begin
  NivelFormacao := TNivelFormacaoService.ConsultarObjeto(id);

  if not Assigned(NivelFormacao) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir NivelFormacao]',
      '', 0, 400);

  try
    if TNivelFormacaoService.Excluir(NivelFormacao) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir NivelFormacao]',
        '', 0, 500);
  finally
    FreeAndNil(NivelFormacao)
  end;
end;

end.
