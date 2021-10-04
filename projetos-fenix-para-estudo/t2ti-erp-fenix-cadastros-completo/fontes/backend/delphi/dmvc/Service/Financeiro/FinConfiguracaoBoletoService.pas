{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
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
unit FinConfiguracaoBoletoService;

interface

uses
  FinConfiguracaoBoleto, BancoContaCaixa, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TFinConfiguracaoBoletoService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaFinConfiguracaoBoleto: TObjectList<TFinConfiguracaoBoleto>); overload;
    class procedure AnexarObjetosVinculados(AFinConfiguracaoBoleto: TFinConfiguracaoBoleto); overload;
  public
    class function ConsultarLista: TObjectList<TFinConfiguracaoBoleto>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TFinConfiguracaoBoleto>;
    class function ConsultarObjeto(AId: Integer): TFinConfiguracaoBoleto;
    class procedure Inserir(AFinConfiguracaoBoleto: TFinConfiguracaoBoleto);
    class function Alterar(AFinConfiguracaoBoleto: TFinConfiguracaoBoleto): Integer;
    class function Excluir(AFinConfiguracaoBoleto: TFinConfiguracaoBoleto): Integer;
  end;

var
  sql: string;


implementation

{ TFinConfiguracaoBoletoService }

class procedure TFinConfiguracaoBoletoService.AnexarObjetosVinculados(AFinConfiguracaoBoleto: TFinConfiguracaoBoleto);
begin
  // BancoContaCaixa
  sql := 'SELECT * FROM BANCO_CONTA_CAIXA WHERE ID = ' + AFinConfiguracaoBoleto.IdBancoContaCaixa.ToString;
  AFinConfiguracaoBoleto.BancoContaCaixa := GetQuery(sql).AsObject<TBancoContaCaixa>;

end;

class procedure TFinConfiguracaoBoletoService.AnexarObjetosVinculados(AListaFinConfiguracaoBoleto: TObjectList<TFinConfiguracaoBoleto>);
var
  FinConfiguracaoBoleto: TFinConfiguracaoBoleto;
begin
  for FinConfiguracaoBoleto in AListaFinConfiguracaoBoleto do
  begin
    AnexarObjetosVinculados(FinConfiguracaoBoleto);
  end;
end;

class function TFinConfiguracaoBoletoService.ConsultarLista: TObjectList<TFinConfiguracaoBoleto>;
begin
  sql := 'SELECT * FROM FIN_CONFIGURACAO_BOLETO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TFinConfiguracaoBoleto>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinConfiguracaoBoletoService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TFinConfiguracaoBoleto>;
begin
  sql := 'SELECT * FROM FIN_CONFIGURACAO_BOLETO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TFinConfiguracaoBoleto>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinConfiguracaoBoletoService.ConsultarObjeto(AId: Integer): TFinConfiguracaoBoleto;
begin
  sql := 'SELECT * FROM FIN_CONFIGURACAO_BOLETO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TFinConfiguracaoBoleto>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TFinConfiguracaoBoletoService.Inserir(AFinConfiguracaoBoleto: TFinConfiguracaoBoleto);
begin
  AFinConfiguracaoBoleto.ValidarInsercao;
  AFinConfiguracaoBoleto.Id := InserirBase(AFinConfiguracaoBoleto, 'FIN_CONFIGURACAO_BOLETO');
  
end;

class function TFinConfiguracaoBoletoService.Alterar(AFinConfiguracaoBoleto: TFinConfiguracaoBoleto): Integer;
begin
  AFinConfiguracaoBoleto.ValidarAlteracao;
  Result := AlterarBase(AFinConfiguracaoBoleto, 'FIN_CONFIGURACAO_BOLETO');
  
  
end;


class function TFinConfiguracaoBoletoService.Excluir(AFinConfiguracaoBoleto: TFinConfiguracaoBoleto): Integer;
begin
  AFinConfiguracaoBoleto.ValidarExclusao;
  
  Result := ExcluirBase(AFinConfiguracaoBoleto.Id, 'FIN_CONFIGURACAO_BOLETO');
end;


end.
