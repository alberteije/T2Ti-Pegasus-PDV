{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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
unit FinLancamentoPagarService;

interface

uses
  FinLancamentoPagar, FinParcelaPagar, FinDocumentoOrigem, FinNaturezaFinanceira, Fornecedor, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TFinLancamentoPagarService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaFinLancamentoPagar: TObjectList<TFinLancamentoPagar>); overload;
    class procedure AnexarObjetosVinculados(AFinLancamentoPagar: TFinLancamentoPagar); overload;
    class procedure InserirObjetosFilhos(AFinLancamentoPagar: TFinLancamentoPagar);
    class procedure ExcluirObjetosFilhos(AFinLancamentoPagar: TFinLancamentoPagar);
  public
    class function ConsultarLista: TObjectList<TFinLancamentoPagar>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TFinLancamentoPagar>;
    class function ConsultarObjeto(AId: Integer): TFinLancamentoPagar;
    class procedure Inserir(AFinLancamentoPagar: TFinLancamentoPagar);
    class function Alterar(AFinLancamentoPagar: TFinLancamentoPagar): Integer;
    class function Excluir(AFinLancamentoPagar: TFinLancamentoPagar): Integer;
  end;

var
  sql: string;


implementation

{ TFinLancamentoPagarService }

class procedure TFinLancamentoPagarService.AnexarObjetosVinculados(AFinLancamentoPagar: TFinLancamentoPagar);
begin
  // FinParcelaPagar
  sql := 'SELECT * FROM FIN_PARCELA_PAGAR WHERE ID_FIN_LANCAMENTO_PAGAR = ' + AFinLancamentoPagar.Id.ToString;
  AFinLancamentoPagar.ListaFinParcelaPagar := GetQuery(sql).AsObjectList<TFinParcelaPagar>;

  // FinDocumentoOrigem
  sql := 'SELECT * FROM FIN_DOCUMENTO_ORIGEM WHERE ID = ' + AFinLancamentoPagar.IdFinDocumentoOrigem.ToString;
  AFinLancamentoPagar.FinDocumentoOrigem := GetQuery(sql).AsObject<TFinDocumentoOrigem>;

  // FinNaturezaFinanceira
  sql := 'SELECT * FROM FIN_NATUREZA_FINANCEIRA WHERE ID = ' + AFinLancamentoPagar.IdFinNaturezaFinanceira.ToString;
  AFinLancamentoPagar.FinNaturezaFinanceira := GetQuery(sql).AsObject<TFinNaturezaFinanceira>;

  // Fornecedor
  sql := 'SELECT * FROM FORNECEDOR WHERE ID = ' + AFinLancamentoPagar.IdFornecedor.ToString;
  AFinLancamentoPagar.Fornecedor := GetQuery(sql).AsObject<TFornecedor>;

end;

class procedure TFinLancamentoPagarService.AnexarObjetosVinculados(AListaFinLancamentoPagar: TObjectList<TFinLancamentoPagar>);
var
  FinLancamentoPagar: TFinLancamentoPagar;
begin
  for FinLancamentoPagar in AListaFinLancamentoPagar do
  begin
    AnexarObjetosVinculados(FinLancamentoPagar);
  end;
end;

class function TFinLancamentoPagarService.ConsultarLista: TObjectList<TFinLancamentoPagar>;
begin
  sql := 'SELECT * FROM FIN_LANCAMENTO_PAGAR ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TFinLancamentoPagar>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinLancamentoPagarService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TFinLancamentoPagar>;
begin
  sql := 'SELECT * FROM FIN_LANCAMENTO_PAGAR where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TFinLancamentoPagar>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinLancamentoPagarService.ConsultarObjeto(AId: Integer): TFinLancamentoPagar;
begin
  sql := 'SELECT * FROM FIN_LANCAMENTO_PAGAR WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TFinLancamentoPagar>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TFinLancamentoPagarService.Inserir(AFinLancamentoPagar: TFinLancamentoPagar);
begin
  AFinLancamentoPagar.ValidarInsercao;
  AFinLancamentoPagar.Id := InserirBase(AFinLancamentoPagar, 'FIN_LANCAMENTO_PAGAR');
  InserirObjetosFilhos(AFinLancamentoPagar);
end;

class function TFinLancamentoPagarService.Alterar(AFinLancamentoPagar: TFinLancamentoPagar): Integer;
begin
  AFinLancamentoPagar.ValidarAlteracao;
  Result := AlterarBase(AFinLancamentoPagar, 'FIN_LANCAMENTO_PAGAR');
  ExcluirObjetosFilhos(AFinLancamentoPagar);
  InserirObjetosFilhos(AFinLancamentoPagar);
end;

class procedure TFinLancamentoPagarService.InserirObjetosFilhos(AFinLancamentoPagar: TFinLancamentoPagar);
var
  FinParcelaPagar: TFinParcelaPagar;
begin
  // FinParcelaPagar
  for FinParcelaPagar in AFinLancamentoPagar.ListaFinParcelaPagar do
  begin
    FinParcelaPagar.IdFinLancamentoPagar := AFinLancamentoPagar.Id;
    InserirBase(FinParcelaPagar, 'FIN_PARCELA_PAGAR');
  end;

end;

class function TFinLancamentoPagarService.Excluir(AFinLancamentoPagar: TFinLancamentoPagar): Integer;
begin
  AFinLancamentoPagar.ValidarExclusao;
  ExcluirObjetosFilhos(AFinLancamentoPagar);
  Result := ExcluirBase(AFinLancamentoPagar.Id, 'FIN_LANCAMENTO_PAGAR');
end;

class procedure TFinLancamentoPagarService.ExcluirObjetosFilhos(AFinLancamentoPagar: TFinLancamentoPagar);
begin
  ExcluirFilho(AFinLancamentoPagar.Id, 'FIN_PARCELA_PAGAR', 'ID_FIN_LANCAMENTO_PAGAR');
end;

end.
