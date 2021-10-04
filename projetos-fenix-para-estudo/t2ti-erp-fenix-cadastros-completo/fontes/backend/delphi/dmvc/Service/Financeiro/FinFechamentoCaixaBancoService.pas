{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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
unit FinFechamentoCaixaBancoService;

interface

uses
  FinFechamentoCaixaBanco, BancoContaCaixa, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TFinFechamentoCaixaBancoService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaFinFechamentoCaixaBanco: TObjectList<TFinFechamentoCaixaBanco>); overload;
    class procedure AnexarObjetosVinculados(AFinFechamentoCaixaBanco: TFinFechamentoCaixaBanco); overload;
  public
    class function ConsultarLista: TObjectList<TFinFechamentoCaixaBanco>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TFinFechamentoCaixaBanco>;
    class function ConsultarObjeto(AId: Integer): TFinFechamentoCaixaBanco;
    class procedure Inserir(AFinFechamentoCaixaBanco: TFinFechamentoCaixaBanco);
    class function Alterar(AFinFechamentoCaixaBanco: TFinFechamentoCaixaBanco): Integer;
    class function Excluir(AFinFechamentoCaixaBanco: TFinFechamentoCaixaBanco): Integer;
  end;

var
  sql: string;


implementation

{ TFinFechamentoCaixaBancoService }

class procedure TFinFechamentoCaixaBancoService.AnexarObjetosVinculados(AFinFechamentoCaixaBanco: TFinFechamentoCaixaBanco);
begin
  // BancoContaCaixa
  sql := 'SELECT * FROM BANCO_CONTA_CAIXA WHERE ID = ' + AFinFechamentoCaixaBanco.IdBancoContaCaixa.ToString;
  AFinFechamentoCaixaBanco.BancoContaCaixa := GetQuery(sql).AsObject<TBancoContaCaixa>;

end;

class procedure TFinFechamentoCaixaBancoService.AnexarObjetosVinculados(AListaFinFechamentoCaixaBanco: TObjectList<TFinFechamentoCaixaBanco>);
var
  FinFechamentoCaixaBanco: TFinFechamentoCaixaBanco;
begin
  for FinFechamentoCaixaBanco in AListaFinFechamentoCaixaBanco do
  begin
    AnexarObjetosVinculados(FinFechamentoCaixaBanco);
  end;
end;

class function TFinFechamentoCaixaBancoService.ConsultarLista: TObjectList<TFinFechamentoCaixaBanco>;
begin
  sql := 'SELECT * FROM FIN_FECHAMENTO_CAIXA_BANCO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TFinFechamentoCaixaBanco>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinFechamentoCaixaBancoService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TFinFechamentoCaixaBanco>;
begin
  sql := 'SELECT * FROM FIN_FECHAMENTO_CAIXA_BANCO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TFinFechamentoCaixaBanco>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinFechamentoCaixaBancoService.ConsultarObjeto(AId: Integer): TFinFechamentoCaixaBanco;
begin
  sql := 'SELECT * FROM FIN_FECHAMENTO_CAIXA_BANCO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TFinFechamentoCaixaBanco>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TFinFechamentoCaixaBancoService.Inserir(AFinFechamentoCaixaBanco: TFinFechamentoCaixaBanco);
begin
  AFinFechamentoCaixaBanco.ValidarInsercao;
  AFinFechamentoCaixaBanco.Id := InserirBase(AFinFechamentoCaixaBanco, 'FIN_FECHAMENTO_CAIXA_BANCO');
  
end;

class function TFinFechamentoCaixaBancoService.Alterar(AFinFechamentoCaixaBanco: TFinFechamentoCaixaBanco): Integer;
begin
  AFinFechamentoCaixaBanco.ValidarAlteracao;
  Result := AlterarBase(AFinFechamentoCaixaBanco, 'FIN_FECHAMENTO_CAIXA_BANCO');
  
  
end;


class function TFinFechamentoCaixaBancoService.Excluir(AFinFechamentoCaixaBanco: TFinFechamentoCaixaBanco): Integer;
begin
  AFinFechamentoCaixaBanco.ValidarExclusao;
  
  Result := ExcluirBase(AFinFechamentoCaixaBanco.Id, 'FIN_FECHAMENTO_CAIXA_BANCO');
end;


end.
