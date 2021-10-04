{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Controller relacionado à tabela [TALONARIO_CHEQUE] 
                                                                                
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
unit TalonarioChequeController;

interface

uses mvcframework, mvcframework.Commons,
  System.SysUtils,
  MVCFramework.SystemJSONUtils;

type

  [MVCDoc('CRUD TalonarioCheque')]
  [MVCPath('/talonario-cheque')]
  TTalonarioChequeController = class(TMVCController)
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

{ TTalonarioChequeController }

uses TalonarioChequeService, TalonarioCheque, Commons, Filtro;

procedure TTalonarioChequeController.ConsultarLista(Context: TWebContext);
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
      Render<TTalonarioCheque>(TTalonarioChequeService.ConsultarLista);
    end
    else begin
      // define o objeto filtro
      FiltroObj := TFiltro.Create(FilterWhere);
      Render<TTalonarioCheque>(TTalonarioChequeService.ConsultarListaFiltroValor(FiltroObj.Campo, FiltroObj.Valor));
    end;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Lista TalonarioCheque] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TTalonarioChequeController.ConsultarObjeto(id: Integer);
var
  TalonarioCheque: TTalonarioCheque;
begin
  try
    TalonarioCheque := TTalonarioChequeService.ConsultarObjeto(id);

    if Assigned(TalonarioCheque) then
      Render(TalonarioCheque)
    else
      raise EMVCException.Create
        ('Registro não localizado [Consultar Objeto TalonarioCheque]', '', 0, 404);
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create
        ('Erro no Servidor [Consultar Objeto TalonarioCheque] - Exceção: ' + E.Message,
        E.StackTrace, 0, 500);
    end
    else
      raise;
  end;
end;

procedure TTalonarioChequeController.Inserir(Context: TWebContext);
var
  TalonarioCheque: TTalonarioCheque;
begin
  try
    TalonarioCheque := Context.Request.BodyAs<TTalonarioCheque>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Inserir TalonarioCheque] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  try
    TTalonarioChequeService.Inserir(TalonarioCheque);
    Render(TTalonarioChequeService.ConsultarObjeto(TalonarioCheque.Id));
  finally
  end;
end;

procedure TTalonarioChequeController.Alterar(id: Integer);
var
  TalonarioCheque, TalonarioChequeDB: TTalonarioCheque;
begin
  try
    TalonarioCheque := Context.Request.BodyAs<TTalonarioCheque>;
  except
    on E: EServiceException do
    begin
      raise EMVCException.Create('Objeto inválido [Alterar TalonarioCheque] - Exceção: ' +
        E.Message, E.StackTrace, 0, 400);
    end
    else
      raise;
  end;

  if TalonarioCheque.Id <> id then
    raise EMVCException.Create('Objeto inválido [Alterar TalonarioCheque] - ID do objeto difere do ID da URL.',
      '', 0, 400);

  TalonarioChequeDB := TTalonarioChequeService.ConsultarObjeto(TalonarioCheque.id);

  if not Assigned(TalonarioChequeDB) then
    raise EMVCException.Create('Objeto com ID inválido [Alterar TalonarioCheque]',
      '', 0, 400);

  try
    if TTalonarioChequeService.Alterar(TalonarioCheque) > 0 then
      Render(TTalonarioChequeService.ConsultarObjeto(TalonarioCheque.Id))
    else
      raise EMVCException.Create('Nenhum registro foi alterado [Alterar TalonarioCheque]',
        '', 0, 500);
  finally
    FreeAndNil(TalonarioChequeDB);
  end;
end;

procedure TTalonarioChequeController.Excluir(id: Integer);
var
  TalonarioCheque: TTalonarioCheque;
begin
  TalonarioCheque := TTalonarioChequeService.ConsultarObjeto(id);

  if not Assigned(TalonarioCheque) then
    raise EMVCException.Create('Objeto com ID inválido [Excluir TalonarioCheque]',
      '', 0, 400);

  try
    if TTalonarioChequeService.Excluir(TalonarioCheque) > 0 then
      Render(200, 'Objeto excluído com sucesso.')
    else
      raise EMVCException.Create('Nenhum registro foi excluído [Excluir TalonarioCheque]',
        '', 0, 500);
  finally
    FreeAndNil(TalonarioCheque)
  end;
end;

end.
