{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [PRODUTO_SUBGRUPO] 
                                                                                
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
unit ProdutoSubgrupoService;

interface

uses
  ProdutoSubgrupo, ProdutoGrupo, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TProdutoSubgrupoService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaProdutoSubgrupo: TObjectList<TProdutoSubgrupo>); overload;
    class procedure AnexarObjetosVinculados(AProdutoSubgrupo: TProdutoSubgrupo); overload;
  public
    class function ConsultarLista: TObjectList<TProdutoSubgrupo>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TProdutoSubgrupo>;
    class function ConsultarObjeto(AId: Integer): TProdutoSubgrupo;
    class procedure Inserir(AProdutoSubgrupo: TProdutoSubgrupo);
    class function Alterar(AProdutoSubgrupo: TProdutoSubgrupo): Integer;
    class function Excluir(AProdutoSubgrupo: TProdutoSubgrupo): Integer;
  end;

var
  sql: string;


implementation

{ TProdutoSubgrupoService }

class procedure TProdutoSubgrupoService.AnexarObjetosVinculados(AProdutoSubgrupo: TProdutoSubgrupo);
begin
  // ProdutoGrupo
  sql := 'SELECT * FROM PRODUTO_GRUPO WHERE ID = ' + AProdutoSubgrupo.IdProdutoGrupo.ToString;
  AProdutoSubgrupo.ProdutoGrupo := GetQuery(sql).AsObject<TProdutoGrupo>;

end;

class procedure TProdutoSubgrupoService.AnexarObjetosVinculados(AListaProdutoSubgrupo: TObjectList<TProdutoSubgrupo>);
var
  ProdutoSubgrupo: TProdutoSubgrupo;
begin
  for ProdutoSubgrupo in AListaProdutoSubgrupo do
  begin
    AnexarObjetosVinculados(ProdutoSubgrupo);
  end;
end;

class function TProdutoSubgrupoService.ConsultarLista: TObjectList<TProdutoSubgrupo>;
begin
  sql := 'SELECT * FROM PRODUTO_SUBGRUPO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TProdutoSubgrupo>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TProdutoSubgrupoService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TProdutoSubgrupo>;
begin
  sql := 'SELECT * FROM PRODUTO_SUBGRUPO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TProdutoSubgrupo>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TProdutoSubgrupoService.ConsultarObjeto(AId: Integer): TProdutoSubgrupo;
begin
  sql := 'SELECT * FROM PRODUTO_SUBGRUPO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TProdutoSubgrupo>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TProdutoSubgrupoService.Inserir(AProdutoSubgrupo: TProdutoSubgrupo);
begin
  AProdutoSubgrupo.ValidarInsercao;
  AProdutoSubgrupo.Id := InserirBase(AProdutoSubgrupo, 'PRODUTO_SUBGRUPO');
  
end;

class function TProdutoSubgrupoService.Alterar(AProdutoSubgrupo: TProdutoSubgrupo): Integer;
begin
  AProdutoSubgrupo.ValidarAlteracao;
  Result := AlterarBase(AProdutoSubgrupo, 'PRODUTO_SUBGRUPO');
  
  
end;


class function TProdutoSubgrupoService.Excluir(AProdutoSubgrupo: TProdutoSubgrupo): Integer;
begin
  AProdutoSubgrupo.ValidarExclusao;
  
  Result := ExcluirBase(AProdutoSubgrupo.Id, 'PRODUTO_SUBGRUPO');
end;


end.
