{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [FORNECEDOR] 
                                                                                
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
unit FornecedorService;

interface

uses
  Fornecedor, Pessoa, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TFornecedorService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaFornecedor: TObjectList<TFornecedor>); overload;
    class procedure AnexarObjetosVinculados(AFornecedor: TFornecedor); overload;
  public
    class function ConsultarLista: TObjectList<TFornecedor>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TFornecedor>;
    class function ConsultarObjeto(AId: Integer): TFornecedor;
    class procedure Inserir(AFornecedor: TFornecedor);
    class function Alterar(AFornecedor: TFornecedor): Integer;
    class function Excluir(AFornecedor: TFornecedor): Integer;
  end;

var
  sql: string;


implementation

{ TFornecedorService }

class procedure TFornecedorService.AnexarObjetosVinculados(AFornecedor: TFornecedor);
begin
  // Pessoa
  sql := 'SELECT * FROM PESSOA WHERE ID = ' + AFornecedor.IdPessoa.ToString;
  AFornecedor.Pessoa := GetQuery(sql).AsObject<TPessoa>;

end;

class procedure TFornecedorService.AnexarObjetosVinculados(AListaFornecedor: TObjectList<TFornecedor>);
var
  Fornecedor: TFornecedor;
begin
  for Fornecedor in AListaFornecedor do
  begin
    AnexarObjetosVinculados(Fornecedor);
  end;
end;

class function TFornecedorService.ConsultarLista: TObjectList<TFornecedor>;
begin
  sql := 'SELECT * FROM FORNECEDOR ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TFornecedor>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFornecedorService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TFornecedor>;
begin
  sql := 'SELECT * FROM FORNECEDOR where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TFornecedor>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFornecedorService.ConsultarObjeto(AId: Integer): TFornecedor;
begin
  sql := 'SELECT * FROM FORNECEDOR WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TFornecedor>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TFornecedorService.Inserir(AFornecedor: TFornecedor);
begin
  AFornecedor.ValidarInsercao;
  AFornecedor.Id := InserirBase(AFornecedor, 'FORNECEDOR');
  
end;

class function TFornecedorService.Alterar(AFornecedor: TFornecedor): Integer;
begin
  AFornecedor.ValidarAlteracao;
  Result := AlterarBase(AFornecedor, 'FORNECEDOR');
  
  
end;


class function TFornecedorService.Excluir(AFornecedor: TFornecedor): Integer;
begin
  AFornecedor.ValidarExclusao;
  
  Result := ExcluirBase(AFornecedor.Id, 'FORNECEDOR');
end;


end.
