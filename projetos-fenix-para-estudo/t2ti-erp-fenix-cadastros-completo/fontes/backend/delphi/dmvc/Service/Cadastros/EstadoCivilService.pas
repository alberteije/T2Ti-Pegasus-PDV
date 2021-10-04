{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [ESTADO_CIVIL] 
                                                                                
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
unit EstadoCivilService;

interface

uses
  EstadoCivil, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TEstadoCivilService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TEstadoCivil>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TEstadoCivil>;
    class function ConsultarObjeto(AId: Integer): TEstadoCivil;
    class procedure Inserir(AEstadoCivil: TEstadoCivil);
    class function Alterar(AEstadoCivil: TEstadoCivil): Integer;
    class function Excluir(AEstadoCivil: TEstadoCivil): Integer;
  end;

var
  sql: string;


implementation

{ TEstadoCivilService }



class function TEstadoCivilService.ConsultarLista: TObjectList<TEstadoCivil>;
begin
  sql := 'SELECT * FROM ESTADO_CIVIL ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TEstadoCivil>;
	
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TEstadoCivilService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TEstadoCivil>;
begin
  sql := 'SELECT * FROM ESTADO_CIVIL where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TEstadoCivil>;
	
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TEstadoCivilService.ConsultarObjeto(AId: Integer): TEstadoCivil;
begin
  sql := 'SELECT * FROM ESTADO_CIVIL WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TEstadoCivil>;
  	  
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TEstadoCivilService.Inserir(AEstadoCivil: TEstadoCivil);
begin
  AEstadoCivil.ValidarInsercao;
  AEstadoCivil.Id := InserirBase(AEstadoCivil, 'ESTADO_CIVIL');
  
end;

class function TEstadoCivilService.Alterar(AEstadoCivil: TEstadoCivil): Integer;
begin
  AEstadoCivil.ValidarAlteracao;
  Result := AlterarBase(AEstadoCivil, 'ESTADO_CIVIL');
  
  
end;


class function TEstadoCivilService.Excluir(AEstadoCivil: TEstadoCivil): Integer;
begin
  AEstadoCivil.ValidarExclusao;
  
  Result := ExcluirBase(AEstadoCivil.Id, 'ESTADO_CIVIL');
end;


end.
