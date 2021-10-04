{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [TRANSPORTADORA] 
                                                                                
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
unit TransportadoraService;

interface

uses
  Transportadora, Pessoa, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TTransportadoraService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaTransportadora: TObjectList<TTransportadora>); overload;
    class procedure AnexarObjetosVinculados(ATransportadora: TTransportadora); overload;
  public
    class function ConsultarLista: TObjectList<TTransportadora>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TTransportadora>;
    class function ConsultarObjeto(AId: Integer): TTransportadora;
    class procedure Inserir(ATransportadora: TTransportadora);
    class function Alterar(ATransportadora: TTransportadora): Integer;
    class function Excluir(ATransportadora: TTransportadora): Integer;
  end;

var
  sql: string;


implementation

{ TTransportadoraService }

class procedure TTransportadoraService.AnexarObjetosVinculados(ATransportadora: TTransportadora);
begin
  // Pessoa
  sql := 'SELECT * FROM PESSOA WHERE ID = ' + ATransportadora.IdPessoa.ToString;
  ATransportadora.Pessoa := GetQuery(sql).AsObject<TPessoa>;

end;

class procedure TTransportadoraService.AnexarObjetosVinculados(AListaTransportadora: TObjectList<TTransportadora>);
var
  Transportadora: TTransportadora;
begin
  for Transportadora in AListaTransportadora do
  begin
    AnexarObjetosVinculados(Transportadora);
  end;
end;

class function TTransportadoraService.ConsultarLista: TObjectList<TTransportadora>;
begin
  sql := 'SELECT * FROM TRANSPORTADORA ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TTransportadora>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TTransportadoraService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TTransportadora>;
begin
  sql := 'SELECT * FROM TRANSPORTADORA where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TTransportadora>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TTransportadoraService.ConsultarObjeto(AId: Integer): TTransportadora;
begin
  sql := 'SELECT * FROM TRANSPORTADORA WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TTransportadora>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TTransportadoraService.Inserir(ATransportadora: TTransportadora);
begin
  ATransportadora.ValidarInsercao;
  ATransportadora.Id := InserirBase(ATransportadora, 'TRANSPORTADORA');
  
end;

class function TTransportadoraService.Alterar(ATransportadora: TTransportadora): Integer;
begin
  ATransportadora.ValidarAlteracao;
  Result := AlterarBase(ATransportadora, 'TRANSPORTADORA');
  
  
end;


class function TTransportadoraService.Excluir(ATransportadora: TTransportadora): Integer;
begin
  ATransportadora.ValidarExclusao;
  
  Result := ExcluirBase(ATransportadora.Id, 'TRANSPORTADORA');
end;


end.
