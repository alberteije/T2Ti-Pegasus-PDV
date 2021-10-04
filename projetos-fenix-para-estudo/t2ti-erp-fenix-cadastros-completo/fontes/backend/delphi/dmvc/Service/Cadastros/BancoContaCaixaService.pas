{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [BANCO_CONTA_CAIXA] 
                                                                                
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
unit BancoContaCaixaService;

interface

uses
  BancoContaCaixa, BancoAgencia, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TBancoContaCaixaService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaBancoContaCaixa: TObjectList<TBancoContaCaixa>); overload;
    class procedure AnexarObjetosVinculados(ABancoContaCaixa: TBancoContaCaixa); overload;
  public
    class function ConsultarLista: TObjectList<TBancoContaCaixa>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TBancoContaCaixa>;
    class function ConsultarObjeto(AId: Integer): TBancoContaCaixa;
    class procedure Inserir(ABancoContaCaixa: TBancoContaCaixa);
    class function Alterar(ABancoContaCaixa: TBancoContaCaixa): Integer;
    class function Excluir(ABancoContaCaixa: TBancoContaCaixa): Integer;
  end;

var
  sql: string;


implementation

{ TBancoContaCaixaService }

class procedure TBancoContaCaixaService.AnexarObjetosVinculados(ABancoContaCaixa: TBancoContaCaixa);
begin
  // BancoAgencia
  sql := 'SELECT * FROM BANCO_AGENCIA WHERE ID = ' + ABancoContaCaixa.IdBancoAgencia.ToString;
  ABancoContaCaixa.BancoAgencia := GetQuery(sql).AsObject<TBancoAgencia>;

end;

class procedure TBancoContaCaixaService.AnexarObjetosVinculados(AListaBancoContaCaixa: TObjectList<TBancoContaCaixa>);
var
  BancoContaCaixa: TBancoContaCaixa;
begin
  for BancoContaCaixa in AListaBancoContaCaixa do
  begin
    AnexarObjetosVinculados(BancoContaCaixa);
  end;
end;

class function TBancoContaCaixaService.ConsultarLista: TObjectList<TBancoContaCaixa>;
begin
  sql := 'SELECT * FROM BANCO_CONTA_CAIXA ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TBancoContaCaixa>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoContaCaixaService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TBancoContaCaixa>;
begin
  sql := 'SELECT * FROM BANCO_CONTA_CAIXA where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TBancoContaCaixa>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoContaCaixaService.ConsultarObjeto(AId: Integer): TBancoContaCaixa;
begin
  sql := 'SELECT * FROM BANCO_CONTA_CAIXA WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TBancoContaCaixa>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TBancoContaCaixaService.Inserir(ABancoContaCaixa: TBancoContaCaixa);
begin
  ABancoContaCaixa.ValidarInsercao;
  ABancoContaCaixa.Id := InserirBase(ABancoContaCaixa, 'BANCO_CONTA_CAIXA');
  
end;

class function TBancoContaCaixaService.Alterar(ABancoContaCaixa: TBancoContaCaixa): Integer;
begin
  ABancoContaCaixa.ValidarAlteracao;
  Result := AlterarBase(ABancoContaCaixa, 'BANCO_CONTA_CAIXA');
  
  
end;


class function TBancoContaCaixaService.Excluir(ABancoContaCaixa: TBancoContaCaixa): Integer;
begin
  ABancoContaCaixa.ValidarExclusao;
  
  Result := ExcluirBase(ABancoContaCaixa.Id, 'BANCO_CONTA_CAIXA');
end;


end.
