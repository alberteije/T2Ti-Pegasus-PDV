{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [PRODUTO] 
                                                                                
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
unit ProdutoService;

interface

uses
  Produto, ProdutoSubgrupo, ProdutoMarca, ProdutoUnidade, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TProdutoService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaProduto: TObjectList<TProduto>); overload;
    class procedure AnexarObjetosVinculados(AProduto: TProduto); overload;
  public
    class function ConsultarLista: TObjectList<TProduto>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TProduto>;
    class function ConsultarObjeto(AId: Integer): TProduto;
    class procedure Inserir(AProduto: TProduto);
    class function Alterar(AProduto: TProduto): Integer;
    class function Excluir(AProduto: TProduto): Integer;
  end;

var
  sql: string;


implementation

{ TProdutoService }

class procedure TProdutoService.AnexarObjetosVinculados(AProduto: TProduto);
begin
  // ProdutoSubgrupo
  sql := 'SELECT * FROM PRODUTO_SUBGRUPO WHERE ID = ' + AProduto.IdProdutoSubgrupo.ToString;
  AProduto.ProdutoSubgrupo := GetQuery(sql).AsObject<TProdutoSubgrupo>;

  // ProdutoMarca
  sql := 'SELECT * FROM PRODUTO_MARCA WHERE ID = ' + AProduto.IdProdutoMarca.ToString;
  AProduto.ProdutoMarca := GetQuery(sql).AsObject<TProdutoMarca>;

  // ProdutoUnidade
  sql := 'SELECT * FROM PRODUTO_UNIDADE WHERE ID = ' + AProduto.IdProdutoUnidade.ToString;
  AProduto.ProdutoUnidade := GetQuery(sql).AsObject<TProdutoUnidade>;

end;

class procedure TProdutoService.AnexarObjetosVinculados(AListaProduto: TObjectList<TProduto>);
var
  Produto: TProduto;
begin
  for Produto in AListaProduto do
  begin
    AnexarObjetosVinculados(Produto);
  end;
end;

class function TProdutoService.ConsultarLista: TObjectList<TProduto>;
begin
  sql := 'SELECT * FROM PRODUTO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TProduto>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TProdutoService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TProduto>;
begin
  sql := 'SELECT * FROM PRODUTO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TProduto>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TProdutoService.ConsultarObjeto(AId: Integer): TProduto;
begin
  sql := 'SELECT * FROM PRODUTO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TProduto>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TProdutoService.Inserir(AProduto: TProduto);
begin
  AProduto.ValidarInsercao;
  AProduto.Id := InserirBase(AProduto, 'PRODUTO');
  
end;

class function TProdutoService.Alterar(AProduto: TProduto): Integer;
begin
  AProduto.ValidarAlteracao;
  Result := AlterarBase(AProduto, 'PRODUTO');
  
  
end;


class function TProdutoService.Excluir(AProduto: TProduto): Integer;
begin
  AProduto.ValidarExclusao;
  
  Result := ExcluirBase(AProduto.Id, 'PRODUTO');
end;


end.
