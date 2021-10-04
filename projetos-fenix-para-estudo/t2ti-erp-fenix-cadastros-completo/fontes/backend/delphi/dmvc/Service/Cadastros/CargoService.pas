{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CARGO] 
                                                                                
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
unit CargoService;

interface

uses
  Cargo, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TCargoService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TCargo>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TCargo>;
    class function ConsultarObjeto(AId: Integer): TCargo;
    class procedure Inserir(ACargo: TCargo);
    class function Alterar(ACargo: TCargo): Integer;
    class function Excluir(ACargo: TCargo): Integer;
  end;

var
  sql: string;


implementation

{ TCargoService }



class function TCargoService.ConsultarLista: TObjectList<TCargo>;
begin
  sql := 'SELECT * FROM CARGO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCargo>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCargoService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TCargo>;
begin
  sql := 'SELECT * FROM CARGO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TCargo>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCargoService.ConsultarObjeto(AId: Integer): TCargo;
begin
  sql := 'SELECT * FROM CARGO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCargo>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TCargoService.Inserir(ACargo: TCargo);
begin
  ACargo.ValidarInsercao;
  ACargo.Id := InserirBase(ACargo, 'CARGO');
  
end;

class function TCargoService.Alterar(ACargo: TCargo): Integer;
begin
  ACargo.ValidarAlteracao;
  Result := AlterarBase(ACargo, 'CARGO');
  
  
end;


class function TCargoService.Excluir(ACargo: TCargo): Integer;
begin
  ACargo.ValidarExclusao;
  
  Result := ExcluirBase(ACargo.Id, 'CARGO');
end;


end.
