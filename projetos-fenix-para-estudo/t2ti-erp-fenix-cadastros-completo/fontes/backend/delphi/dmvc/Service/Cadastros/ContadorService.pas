{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CONTADOR] 
                                                                                
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
unit ContadorService;

interface

uses
  Contador, Pessoa, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TContadorService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaContador: TObjectList<TContador>); overload;
    class procedure AnexarObjetosVinculados(AContador: TContador); overload;
  public
    class function ConsultarLista: TObjectList<TContador>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TContador>;
    class function ConsultarObjeto(AId: Integer): TContador;
    class procedure Inserir(AContador: TContador);
    class function Alterar(AContador: TContador): Integer;
    class function Excluir(AContador: TContador): Integer;
  end;

var
  sql: string;


implementation

{ TContadorService }

class procedure TContadorService.AnexarObjetosVinculados(AContador: TContador);
begin
  // Pessoa
  sql := 'SELECT * FROM PESSOA WHERE ID = ' + AContador.IdPessoa.ToString;
  AContador.Pessoa := GetQuery(sql).AsObject<TPessoa>;

end;

class procedure TContadorService.AnexarObjetosVinculados(AListaContador: TObjectList<TContador>);
var
  Contador: TContador;
begin
  for Contador in AListaContador do
  begin
    AnexarObjetosVinculados(Contador);
  end;
end;

class function TContadorService.ConsultarLista: TObjectList<TContador>;
begin
  sql := 'SELECT * FROM CONTADOR ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TContador>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TContadorService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TContador>;
begin
  sql := 'SELECT * FROM CONTADOR where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TContador>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TContadorService.ConsultarObjeto(AId: Integer): TContador;
begin
  sql := 'SELECT * FROM CONTADOR WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TContador>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TContadorService.Inserir(AContador: TContador);
begin
  AContador.ValidarInsercao;
  AContador.Id := InserirBase(AContador, 'CONTADOR');
  
end;

class function TContadorService.Alterar(AContador: TContador): Integer;
begin
  AContador.ValidarAlteracao;
  Result := AlterarBase(AContador, 'CONTADOR');
  
  
end;


class function TContadorService.Excluir(AContador: TContador): Integer;
begin
  AContador.ValidarExclusao;
  
  Result := ExcluirBase(AContador.Id, 'CONTADOR');
end;


end.
