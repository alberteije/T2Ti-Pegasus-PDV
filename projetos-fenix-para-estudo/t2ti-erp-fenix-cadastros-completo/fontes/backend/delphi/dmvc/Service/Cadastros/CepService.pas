{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CEP] 
                                                                                
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
unit CepService;

interface

uses
  Cep, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TCepService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TCep>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TCep>;
    class function ConsultarObjeto(AId: Integer): TCep;
    class procedure Inserir(ACep: TCep);
    class function Alterar(ACep: TCep): Integer;
    class function Excluir(ACep: TCep): Integer;
  end;

var
  sql: string;


implementation

{ TCepService }



class function TCepService.ConsultarLista: TObjectList<TCep>;
begin
  sql := 'SELECT * FROM CEP ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCep>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCepService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TCep>;
begin
  sql := 'SELECT * FROM CEP where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TCep>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCepService.ConsultarObjeto(AId: Integer): TCep;
begin
  sql := 'SELECT * FROM CEP WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCep>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TCepService.Inserir(ACep: TCep);
begin
  ACep.ValidarInsercao;
  ACep.Id := InserirBase(ACep, 'CEP');
  
end;

class function TCepService.Alterar(ACep: TCep): Integer;
begin
  ACep.ValidarAlteracao;
  Result := AlterarBase(ACep, 'CEP');
  
  
end;


class function TCepService.Excluir(ACep: TCep): Integer;
begin
  ACep.ValidarExclusao;
  
  Result := ExcluirBase(ACep.Id, 'CEP');
end;


end.
