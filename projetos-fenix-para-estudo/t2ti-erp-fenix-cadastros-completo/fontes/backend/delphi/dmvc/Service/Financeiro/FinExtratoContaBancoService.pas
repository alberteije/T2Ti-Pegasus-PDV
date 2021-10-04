{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [FIN_EXTRATO_CONTA_BANCO] 
                                                                                
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
unit FinExtratoContaBancoService;

interface

uses
  FinExtratoContaBanco, BancoContaCaixa, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TFinExtratoContaBancoService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaFinExtratoContaBanco: TObjectList<TFinExtratoContaBanco>); overload;
    class procedure AnexarObjetosVinculados(AFinExtratoContaBanco: TFinExtratoContaBanco); overload;
  public
    class function ConsultarLista: TObjectList<TFinExtratoContaBanco>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TFinExtratoContaBanco>;
    class function ConsultarObjeto(AId: Integer): TFinExtratoContaBanco;
    class procedure Inserir(AFinExtratoContaBanco: TFinExtratoContaBanco);
    class function Alterar(AFinExtratoContaBanco: TFinExtratoContaBanco): Integer;
    class function Excluir(AFinExtratoContaBanco: TFinExtratoContaBanco): Integer;
  end;

var
  sql: string;


implementation

{ TFinExtratoContaBancoService }

class procedure TFinExtratoContaBancoService.AnexarObjetosVinculados(AFinExtratoContaBanco: TFinExtratoContaBanco);
begin
  // BancoContaCaixa
  sql := 'SELECT * FROM BANCO_CONTA_CAIXA WHERE ID = ' + AFinExtratoContaBanco.IdBancoContaCaixa.ToString;
  AFinExtratoContaBanco.BancoContaCaixa := GetQuery(sql).AsObject<TBancoContaCaixa>;

end;

class procedure TFinExtratoContaBancoService.AnexarObjetosVinculados(AListaFinExtratoContaBanco: TObjectList<TFinExtratoContaBanco>);
var
  FinExtratoContaBanco: TFinExtratoContaBanco;
begin
  for FinExtratoContaBanco in AListaFinExtratoContaBanco do
  begin
    AnexarObjetosVinculados(FinExtratoContaBanco);
  end;
end;

class function TFinExtratoContaBancoService.ConsultarLista: TObjectList<TFinExtratoContaBanco>;
begin
  sql := 'SELECT * FROM FIN_EXTRATO_CONTA_BANCO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TFinExtratoContaBanco>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinExtratoContaBancoService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TFinExtratoContaBanco>;
begin
  sql := 'SELECT * FROM FIN_EXTRATO_CONTA_BANCO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TFinExtratoContaBanco>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinExtratoContaBancoService.ConsultarObjeto(AId: Integer): TFinExtratoContaBanco;
begin
  sql := 'SELECT * FROM FIN_EXTRATO_CONTA_BANCO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TFinExtratoContaBanco>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TFinExtratoContaBancoService.Inserir(AFinExtratoContaBanco: TFinExtratoContaBanco);
begin
  AFinExtratoContaBanco.ValidarInsercao;
  AFinExtratoContaBanco.Id := InserirBase(AFinExtratoContaBanco, 'FIN_EXTRATO_CONTA_BANCO');
  
end;

class function TFinExtratoContaBancoService.Alterar(AFinExtratoContaBanco: TFinExtratoContaBanco): Integer;
begin
  AFinExtratoContaBanco.ValidarAlteracao;
  Result := AlterarBase(AFinExtratoContaBanco, 'FIN_EXTRATO_CONTA_BANCO');
  
  
end;


class function TFinExtratoContaBancoService.Excluir(AFinExtratoContaBanco: TFinExtratoContaBanco): Integer;
begin
  AFinExtratoContaBanco.ValidarExclusao;
  
  Result := ExcluirBase(AFinExtratoContaBanco.Id, 'FIN_EXTRATO_CONTA_BANCO');
end;


end.
