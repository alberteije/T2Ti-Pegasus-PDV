{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [FIN_CHEQUE_RECEBIDO] 
                                                                                
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
unit FinChequeRecebidoService;

interface

uses
  FinChequeRecebido, Pessoa, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TFinChequeRecebidoService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaFinChequeRecebido: TObjectList<TFinChequeRecebido>); overload;
    class procedure AnexarObjetosVinculados(AFinChequeRecebido: TFinChequeRecebido); overload;
  public
    class function ConsultarLista: TObjectList<TFinChequeRecebido>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TFinChequeRecebido>;
    class function ConsultarObjeto(AId: Integer): TFinChequeRecebido;
    class procedure Inserir(AFinChequeRecebido: TFinChequeRecebido);
    class function Alterar(AFinChequeRecebido: TFinChequeRecebido): Integer;
    class function Excluir(AFinChequeRecebido: TFinChequeRecebido): Integer;
  end;

var
  sql: string;


implementation

{ TFinChequeRecebidoService }

class procedure TFinChequeRecebidoService.AnexarObjetosVinculados(AFinChequeRecebido: TFinChequeRecebido);
begin
  // Pessoa
  sql := 'SELECT * FROM PESSOA WHERE ID = ' + AFinChequeRecebido.IdPessoa.ToString;
  AFinChequeRecebido.Pessoa := GetQuery(sql).AsObject<TPessoa>;

end;

class procedure TFinChequeRecebidoService.AnexarObjetosVinculados(AListaFinChequeRecebido: TObjectList<TFinChequeRecebido>);
var
  FinChequeRecebido: TFinChequeRecebido;
begin
  for FinChequeRecebido in AListaFinChequeRecebido do
  begin
    AnexarObjetosVinculados(FinChequeRecebido);
  end;
end;

class function TFinChequeRecebidoService.ConsultarLista: TObjectList<TFinChequeRecebido>;
begin
  sql := 'SELECT * FROM FIN_CHEQUE_RECEBIDO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TFinChequeRecebido>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinChequeRecebidoService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TFinChequeRecebido>;
begin
  sql := 'SELECT * FROM FIN_CHEQUE_RECEBIDO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TFinChequeRecebido>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinChequeRecebidoService.ConsultarObjeto(AId: Integer): TFinChequeRecebido;
begin
  sql := 'SELECT * FROM FIN_CHEQUE_RECEBIDO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TFinChequeRecebido>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TFinChequeRecebidoService.Inserir(AFinChequeRecebido: TFinChequeRecebido);
begin
  AFinChequeRecebido.ValidarInsercao;
  AFinChequeRecebido.Id := InserirBase(AFinChequeRecebido, 'FIN_CHEQUE_RECEBIDO');
  
end;

class function TFinChequeRecebidoService.Alterar(AFinChequeRecebido: TFinChequeRecebido): Integer;
begin
  AFinChequeRecebido.ValidarAlteracao;
  Result := AlterarBase(AFinChequeRecebido, 'FIN_CHEQUE_RECEBIDO');
  
  
end;


class function TFinChequeRecebidoService.Excluir(AFinChequeRecebido: TFinChequeRecebido): Integer;
begin
  AFinChequeRecebido.ValidarExclusao;
  
  Result := ExcluirBase(AFinChequeRecebido.Id, 'FIN_CHEQUE_RECEBIDO');
end;


end.
