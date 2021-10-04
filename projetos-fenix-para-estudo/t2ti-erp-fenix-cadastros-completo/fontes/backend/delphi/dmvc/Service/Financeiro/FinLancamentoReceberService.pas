{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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
unit FinLancamentoReceberService;

interface

uses
  FinLancamentoReceber, FinParcelaReceber, FinDocumentoOrigem, FinNaturezaFinanceira, Cliente, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TFinLancamentoReceberService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaFinLancamentoReceber: TObjectList<TFinLancamentoReceber>); overload;
    class procedure AnexarObjetosVinculados(AFinLancamentoReceber: TFinLancamentoReceber); overload;
    class procedure InserirObjetosFilhos(AFinLancamentoReceber: TFinLancamentoReceber);
    class procedure ExcluirObjetosFilhos(AFinLancamentoReceber: TFinLancamentoReceber);
  public
    class function ConsultarLista: TObjectList<TFinLancamentoReceber>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TFinLancamentoReceber>;
    class function ConsultarObjeto(AId: Integer): TFinLancamentoReceber;
    class procedure Inserir(AFinLancamentoReceber: TFinLancamentoReceber);
    class function Alterar(AFinLancamentoReceber: TFinLancamentoReceber): Integer;
    class function Excluir(AFinLancamentoReceber: TFinLancamentoReceber): Integer;
  end;

var
  sql: string;


implementation

{ TFinLancamentoReceberService }

class procedure TFinLancamentoReceberService.AnexarObjetosVinculados(AFinLancamentoReceber: TFinLancamentoReceber);
begin
  // FinParcelaReceber
  sql := 'SELECT * FROM FIN_PARCELA_RECEBER WHERE ID_FIN_LANCAMENTO_RECEBER = ' + AFinLancamentoReceber.Id.ToString;
  AFinLancamentoReceber.ListaFinParcelaReceber := GetQuery(sql).AsObjectList<TFinParcelaReceber>;

  // FinDocumentoOrigem
  sql := 'SELECT * FROM FIN_DOCUMENTO_ORIGEM WHERE ID = ' + AFinLancamentoReceber.IdFinDocumentoOrigem.ToString;
  AFinLancamentoReceber.FinDocumentoOrigem := GetQuery(sql).AsObject<TFinDocumentoOrigem>;

  // FinNaturezaFinanceira
  sql := 'SELECT * FROM FIN_NATUREZA_FINANCEIRA WHERE ID = ' + AFinLancamentoReceber.IdFinNaturezaFinanceira.ToString;
  AFinLancamentoReceber.FinNaturezaFinanceira := GetQuery(sql).AsObject<TFinNaturezaFinanceira>;

  // Cliente
  sql := 'SELECT * FROM CLIENTE WHERE ID = ' + AFinLancamentoReceber.IdCliente.ToString;
  AFinLancamentoReceber.Cliente := GetQuery(sql).AsObject<TCliente>;

end;

class procedure TFinLancamentoReceberService.AnexarObjetosVinculados(AListaFinLancamentoReceber: TObjectList<TFinLancamentoReceber>);
var
  FinLancamentoReceber: TFinLancamentoReceber;
begin
  for FinLancamentoReceber in AListaFinLancamentoReceber do
  begin
    AnexarObjetosVinculados(FinLancamentoReceber);
  end;
end;

class function TFinLancamentoReceberService.ConsultarLista: TObjectList<TFinLancamentoReceber>;
begin
  sql := 'SELECT * FROM FIN_LANCAMENTO_RECEBER ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TFinLancamentoReceber>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinLancamentoReceberService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TFinLancamentoReceber>;
begin
  sql := 'SELECT * FROM FIN_LANCAMENTO_RECEBER where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TFinLancamentoReceber>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinLancamentoReceberService.ConsultarObjeto(AId: Integer): TFinLancamentoReceber;
begin
  sql := 'SELECT * FROM FIN_LANCAMENTO_RECEBER WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TFinLancamentoReceber>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TFinLancamentoReceberService.Inserir(AFinLancamentoReceber: TFinLancamentoReceber);
begin
  AFinLancamentoReceber.ValidarInsercao;
  AFinLancamentoReceber.Id := InserirBase(AFinLancamentoReceber, 'FIN_LANCAMENTO_RECEBER');
  InserirObjetosFilhos(AFinLancamentoReceber);
end;

class function TFinLancamentoReceberService.Alterar(AFinLancamentoReceber: TFinLancamentoReceber): Integer;
begin
  AFinLancamentoReceber.ValidarAlteracao;
  Result := AlterarBase(AFinLancamentoReceber, 'FIN_LANCAMENTO_RECEBER');
  ExcluirObjetosFilhos(AFinLancamentoReceber);
  InserirObjetosFilhos(AFinLancamentoReceber);
end;

class procedure TFinLancamentoReceberService.InserirObjetosFilhos(AFinLancamentoReceber: TFinLancamentoReceber);
var
  FinParcelaReceber: TFinParcelaReceber;
begin
  // FinParcelaReceber
  for FinParcelaReceber in AFinLancamentoReceber.ListaFinParcelaReceber do
  begin
    FinParcelaReceber.IdFinLancamentoReceber := AFinLancamentoReceber.Id;
    InserirBase(FinParcelaReceber, 'FIN_PARCELA_RECEBER');
  end;

end;

class function TFinLancamentoReceberService.Excluir(AFinLancamentoReceber: TFinLancamentoReceber): Integer;
begin
  AFinLancamentoReceber.ValidarExclusao;
  ExcluirObjetosFilhos(AFinLancamentoReceber);
  Result := ExcluirBase(AFinLancamentoReceber.Id, 'FIN_LANCAMENTO_RECEBER');
end;

class procedure TFinLancamentoReceberService.ExcluirObjetosFilhos(AFinLancamentoReceber: TFinLancamentoReceber);
begin
  ExcluirFilho(AFinLancamentoReceber.Id, 'FIN_PARCELA_RECEBER', 'ID_FIN_LANCAMENTO_RECEBER');
end;

end.
