{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [TALONARIO_CHEQUE] 
                                                                                
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
unit TalonarioChequeService;

interface

uses
  TalonarioCheque, Cheque, BancoContaCaixa, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TTalonarioChequeService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaTalonarioCheque: TObjectList<TTalonarioCheque>); overload;
    class procedure AnexarObjetosVinculados(ATalonarioCheque: TTalonarioCheque); overload;
    class procedure InserirObjetosFilhos(ATalonarioCheque: TTalonarioCheque);
    class procedure ExcluirObjetosFilhos(ATalonarioCheque: TTalonarioCheque);
  public
    class function ConsultarLista: TObjectList<TTalonarioCheque>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TTalonarioCheque>;
    class function ConsultarObjeto(AId: Integer): TTalonarioCheque;
    class procedure Inserir(ATalonarioCheque: TTalonarioCheque);
    class function Alterar(ATalonarioCheque: TTalonarioCheque): Integer;
    class function Excluir(ATalonarioCheque: TTalonarioCheque): Integer;
  end;

var
  sql: string;


implementation

{ TTalonarioChequeService }

class procedure TTalonarioChequeService.AnexarObjetosVinculados(ATalonarioCheque: TTalonarioCheque);
begin
  // Cheque
  sql := 'SELECT * FROM CHEQUE WHERE ID_TALONARIO_CHEQUE = ' + ATalonarioCheque.Id.ToString;
  ATalonarioCheque.ListaCheque := GetQuery(sql).AsObjectList<TCheque>;

  // BancoContaCaixa
  sql := 'SELECT * FROM BANCO_CONTA_CAIXA WHERE ID = ' + ATalonarioCheque.IdBancoContaCaixa.ToString;
  ATalonarioCheque.BancoContaCaixa := GetQuery(sql).AsObject<TBancoContaCaixa>;

end;

class procedure TTalonarioChequeService.AnexarObjetosVinculados(AListaTalonarioCheque: TObjectList<TTalonarioCheque>);
var
  TalonarioCheque: TTalonarioCheque;
begin
  for TalonarioCheque in AListaTalonarioCheque do
  begin
    AnexarObjetosVinculados(TalonarioCheque);
  end;
end;

class function TTalonarioChequeService.ConsultarLista: TObjectList<TTalonarioCheque>;
begin
  sql := 'SELECT * FROM TALONARIO_CHEQUE ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TTalonarioCheque>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TTalonarioChequeService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TTalonarioCheque>;
begin
  sql := 'SELECT * FROM TALONARIO_CHEQUE where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TTalonarioCheque>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TTalonarioChequeService.ConsultarObjeto(AId: Integer): TTalonarioCheque;
begin
  sql := 'SELECT * FROM TALONARIO_CHEQUE WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TTalonarioCheque>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TTalonarioChequeService.Inserir(ATalonarioCheque: TTalonarioCheque);
begin
  ATalonarioCheque.ValidarInsercao;
  ATalonarioCheque.Id := InserirBase(ATalonarioCheque, 'TALONARIO_CHEQUE');
  InserirObjetosFilhos(ATalonarioCheque);
end;

class function TTalonarioChequeService.Alterar(ATalonarioCheque: TTalonarioCheque): Integer;
begin
  ATalonarioCheque.ValidarAlteracao;
  Result := AlterarBase(ATalonarioCheque, 'TALONARIO_CHEQUE');
  ExcluirObjetosFilhos(ATalonarioCheque);
  InserirObjetosFilhos(ATalonarioCheque);
end;

class procedure TTalonarioChequeService.InserirObjetosFilhos(ATalonarioCheque: TTalonarioCheque);
var
  Cheque: TCheque;
begin
  // Cheque
  for Cheque in ATalonarioCheque.ListaCheque do
  begin
    Cheque.IdTalonarioCheque := ATalonarioCheque.Id;
    InserirBase(Cheque, 'CHEQUE');
  end;

end;

class function TTalonarioChequeService.Excluir(ATalonarioCheque: TTalonarioCheque): Integer;
begin
  ATalonarioCheque.ValidarExclusao;
  ExcluirObjetosFilhos(ATalonarioCheque);
  Result := ExcluirBase(ATalonarioCheque.Id, 'TALONARIO_CHEQUE');
end;

class procedure TTalonarioChequeService.ExcluirObjetosFilhos(ATalonarioCheque: TTalonarioCheque);
begin
  ExcluirFilho(ATalonarioCheque.Id, 'CHEQUE', 'ID_TALONARIO_CHEQUE');
end;

end.
