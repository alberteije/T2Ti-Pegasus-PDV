{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [FIN_DOCUMENTO_ORIGEM] 
                                                                                
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
unit FinDocumentoOrigemService;

interface

uses
  FinDocumentoOrigem, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TFinDocumentoOrigemService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaFinDocumentoOrigem: TObjectList<TFinDocumentoOrigem>); overload;
    class procedure AnexarObjetosVinculados(AFinDocumentoOrigem: TFinDocumentoOrigem); overload;
  public
    class function ConsultarLista: TObjectList<TFinDocumentoOrigem>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TFinDocumentoOrigem>;
    class function ConsultarObjeto(AId: Integer): TFinDocumentoOrigem;
    class procedure Inserir(AFinDocumentoOrigem: TFinDocumentoOrigem);
    class function Alterar(AFinDocumentoOrigem: TFinDocumentoOrigem): Integer;
    class function Excluir(AFinDocumentoOrigem: TFinDocumentoOrigem): Integer;
  end;

var
  sql: string;


implementation

{ TFinDocumentoOrigemService }

class procedure TFinDocumentoOrigemService.AnexarObjetosVinculados(AFinDocumentoOrigem: TFinDocumentoOrigem);
begin
end;

class procedure TFinDocumentoOrigemService.AnexarObjetosVinculados(AListaFinDocumentoOrigem: TObjectList<TFinDocumentoOrigem>);
var
  FinDocumentoOrigem: TFinDocumentoOrigem;
begin
  for FinDocumentoOrigem in AListaFinDocumentoOrigem do
  begin
    AnexarObjetosVinculados(FinDocumentoOrigem);
  end;
end;

class function TFinDocumentoOrigemService.ConsultarLista: TObjectList<TFinDocumentoOrigem>;
begin
  sql := 'SELECT * FROM FIN_DOCUMENTO_ORIGEM ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TFinDocumentoOrigem>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinDocumentoOrigemService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TFinDocumentoOrigem>;
begin
  sql := 'SELECT * FROM FIN_DOCUMENTO_ORIGEM where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TFinDocumentoOrigem>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinDocumentoOrigemService.ConsultarObjeto(AId: Integer): TFinDocumentoOrigem;
begin
  sql := 'SELECT * FROM FIN_DOCUMENTO_ORIGEM WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TFinDocumentoOrigem>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TFinDocumentoOrigemService.Inserir(AFinDocumentoOrigem: TFinDocumentoOrigem);
begin
  AFinDocumentoOrigem.ValidarInsercao;
  AFinDocumentoOrigem.Id := InserirBase(AFinDocumentoOrigem, 'FIN_DOCUMENTO_ORIGEM');
  
end;

class function TFinDocumentoOrigemService.Alterar(AFinDocumentoOrigem: TFinDocumentoOrigem): Integer;
begin
  AFinDocumentoOrigem.ValidarAlteracao;
  Result := AlterarBase(AFinDocumentoOrigem, 'FIN_DOCUMENTO_ORIGEM');
  
  
end;


class function TFinDocumentoOrigemService.Excluir(AFinDocumentoOrigem: TFinDocumentoOrigem): Integer;
begin
  AFinDocumentoOrigem.ValidarExclusao;
  
  Result := ExcluirBase(AFinDocumentoOrigem.Id, 'FIN_DOCUMENTO_ORIGEM');
end;


end.
