{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CST_IPI] 
                                                                                
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
unit CstIpiService;

interface

uses
  CstIpi, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TCstIpiService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TCstIpi>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TCstIpi>;
    class function ConsultarObjeto(AId: Integer): TCstIpi;
    class procedure Inserir(ACstIpi: TCstIpi);
    class function Alterar(ACstIpi: TCstIpi): Integer;
    class function Excluir(ACstIpi: TCstIpi): Integer;
  end;

var
  sql: string;


implementation

{ TCstIpiService }



class function TCstIpiService.ConsultarLista: TObjectList<TCstIpi>;
begin
  sql := 'SELECT * FROM CST_IPI ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCstIpi>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCstIpiService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TCstIpi>;
begin
  sql := 'SELECT * FROM CST_IPI where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TCstIpi>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCstIpiService.ConsultarObjeto(AId: Integer): TCstIpi;
begin
  sql := 'SELECT * FROM CST_IPI WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCstIpi>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TCstIpiService.Inserir(ACstIpi: TCstIpi);
begin
  ACstIpi.ValidarInsercao;
  ACstIpi.Id := InserirBase(ACstIpi, 'CST_IPI');
  
end;

class function TCstIpiService.Alterar(ACstIpi: TCstIpi): Integer;
begin
  ACstIpi.ValidarAlteracao;
  Result := AlterarBase(ACstIpi, 'CST_IPI');
  
  
end;


class function TCstIpiService.Excluir(ACstIpi: TCstIpi): Integer;
begin
  ACstIpi.ValidarExclusao;
  
  Result := ExcluirBase(ACstIpi.Id, 'CST_IPI');
end;


end.
