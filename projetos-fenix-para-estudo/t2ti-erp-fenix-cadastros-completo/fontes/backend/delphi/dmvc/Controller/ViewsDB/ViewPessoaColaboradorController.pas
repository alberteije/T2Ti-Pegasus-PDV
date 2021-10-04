{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [VIEW_PESSOA_COLABORADOR] 
                                                                                
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
unit ViewPessoaColaboradorController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD ViewPessoaColaborador')]
  [MVCPath('/view-pessoa-colaborador')]
  TViewPessoaColaboradorController = class(TMVCController)
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

{ TViewPessoaColaboradorController }

uses ViewPessoaColaboradorService, ViewPessoaColaborador, Commons, Filtro;

procedure TViewPessoaColaboradorController.ConsultarLista(Context: TWebContext);
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
      Render<TViewPessoaColaborador>(TViewPessoaColaboradorService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TViewPessoaColaborador>(TViewPessoaColaboradorService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista ViewPessoaColaborador] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TViewPessoaColaboradorController.ConsultarObjeto(id: Integer);
var
  ViewPessoaColaborador: TViewPessoaColaborador;
begin
  try
    ViewPessoaColaborador := TViewPessoaColaboradorService.ConsultarObjeto(id);

    if Assigned(ViewPessoaColaborador) then
      Render(ViewPessoaColaborador)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto ViewPessoaColaborador]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto ViewPessoaColaborador] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TViewPessoaColaboradorController.Inserir(Context: TWebContext);
var
  ViewPessoaColaborador: TViewPessoaColaborador;
begin
  try
    ViewPessoaColaborador := Context.Request.BodyAs<TViewPessoaColaborador>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir ViewPessoaColaborador] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TViewPessoaColaboradorService.Inserir(ViewPessoaColaborador);
    Render(TViewPessoaColaboradorService.ConsultarObjeto(ViewPessoaColaborador.Id));
  finally
  end;
end;

procedure TViewPessoaColaboradorController.Alterar(id: Integer);
var
  ViewPessoaColaborador, ViewPessoaColaboradorDB: TViewPessoaColaborador;
begin
  try
    ViewPessoaColaborador := Context.Request.BodyAs<TViewPessoaColaborador>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar ViewPessoaColaborador] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if ViewPessoaColaborador.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar ViewPessoaColaborador] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  ViewPessoaColaboradorDB := TViewPessoaColaboradorService.ConsultarObjeto(ViewPessoaColaborador.id);

  if not Assigned(ViewPessoaColaboradorDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar ViewPessoaColaborador]',
      '', 0, 400);

  try
    if TViewPessoaColaboradorService.Alterar(ViewPessoaColaborador) > 0 then
      Render(TViewPessoaColaboradorService.ConsultarObjeto(ViewPessoaColaborador.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar ViewPessoaColaborador]',
        '', 0, 500);
  finally
    FreeAndNil(ViewPessoaColaboradorDB);
  end;
end;

procedure TViewPessoaColaboradorController.Excluir(id: Integer);
var
  ViewPessoaColaborador: TViewPessoaColaborador;
begin
  ViewPessoaColaborador := TViewPessoaColaboradorService.ConsultarObjeto(id);

  if not Assigned(ViewPessoaColaborador) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir ViewPessoaColaborador]',
      '', 0, 400);

  try
    if TViewPessoaColaboradorService.Excluir(ViewPessoaColaborador) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir ViewPessoaColaborador]',
        '', 0, 500);
  finally
    FreeAndNil(ViewPessoaColaborador)
  end;
end;

end.
