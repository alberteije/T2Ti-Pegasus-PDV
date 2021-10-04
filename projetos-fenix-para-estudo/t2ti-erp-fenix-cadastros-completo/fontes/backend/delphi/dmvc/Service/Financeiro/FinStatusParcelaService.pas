{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [FIN_STATUS_PARCELA] 
                                                                                
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
unit FinStatusParcelaService;

interface

uses
  FinStatusParcela, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TFinStatusParcelaService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaFinStatusParcela: TObjectList<TFinStatusParcela>); overload;
    class procedure AnexarObjetosVinculados(AFinStatusParcela: TFinStatusParcela); overload;
  public
    class function ConsultarLista: TObjectList<TFinStatusParcela>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TFinStatusParcela>;
    class function ConsultarObjeto(AId: Integer): TFinStatusParcela;
    class procedure Inserir(AFinStatusParcela: TFinStatusParcela);
    class function Alterar(AFinStatusParcela: TFinStatusParcela): Integer;
    class function Excluir(AFinStatusParcela: TFinStatusParcela): Integer;
  end;

var
  sql: string;


implementation

{ TFinStatusParcelaService }

class procedure TFinStatusParcelaService.AnexarObjetosVinculados(AFinStatusParcela: TFinStatusParcela);
begin
end;

class procedure TFinStatusParcelaService.AnexarObjetosVinculados(AListaFinStatusParcela: TObjectList<TFinStatusParcela>);
var
  FinStatusParcela: TFinStatusParcela;
begin
  for FinStatusParcela in AListaFinStatusParcela do
  begin
    AnexarObjetosVinculados(FinStatusParcela);
  end;
end;

class function TFinStatusParcelaService.ConsultarLista: TObjectList<TFinStatusParcela>;
begin
  sql := 'SELECT * FROM FIN_STATUS_PARCELA ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TFinStatusParcela>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinStatusParcelaService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TFinStatusParcela>;
begin
  sql := 'SELECT * FROM FIN_STATUS_PARCELA where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TFinStatusParcela>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TFinStatusParcelaService.ConsultarObjeto(AId: Integer): TFinStatusParcela;
begin
  sql := 'SELECT * FROM FIN_STATUS_PARCELA WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TFinStatusParcela>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TFinStatusParcelaService.Inserir(AFinStatusParcela: TFinStatusParcela);
begin
  AFinStatusParcela.ValidarInsercao;
  AFinStatusParcela.Id := InserirBase(AFinStatusParcela, 'FIN_STATUS_PARCELA');
  
end;

class function TFinStatusParcelaService.Alterar(AFinStatusParcela: TFinStatusParcela): Integer;
begin
  AFinStatusParcela.ValidarAlteracao;
  Result := AlterarBase(AFinStatusParcela, 'FIN_STATUS_PARCELA');
  
  
end;


class function TFinStatusParcelaService.Excluir(AFinStatusParcela: TFinStatusParcela): Integer;
begin
  AFinStatusParcela.ValidarExclusao;
  
  Result := ExcluirBase(AFinStatusParcela.Id, 'FIN_STATUS_PARCELA');
end;


end.
