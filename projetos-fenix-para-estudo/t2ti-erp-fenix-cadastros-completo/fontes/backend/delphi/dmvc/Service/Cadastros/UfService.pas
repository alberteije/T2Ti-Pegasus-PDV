{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [UF] 
                                                                                
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
unit UfService;

interface

uses
  Uf, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TUfService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TUf>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TUf>;
    class function ConsultarObjeto(AId: Integer): TUf;
    class procedure Inserir(AUf: TUf);
    class function Alterar(AUf: TUf): Integer;
    class function Excluir(AUf: TUf): Integer;
  end;

var
  sql: string;


implementation

{ TUfService }



class function TUfService.ConsultarLista: TObjectList<TUf>;
begin
  sql := 'SELECT * FROM UF ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TUf>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TUfService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TUf>;
begin
  sql := 'SELECT * FROM UF where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TUf>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TUfService.ConsultarObjeto(AId: Integer): TUf;
begin
  sql := 'SELECT * FROM UF WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TUf>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TUfService.Inserir(AUf: TUf);
begin
  AUf.ValidarInsercao;
  AUf.Id := InserirBase(AUf, 'UF');
  
end;

class function TUfService.Alterar(AUf: TUf): Integer;
begin
  AUf.ValidarAlteracao;
  Result := AlterarBase(AUf, 'UF');
  
  
end;


class function TUfService.Excluir(AUf: TUf): Integer;
begin
  AUf.ValidarExclusao;
  
  Result := ExcluirBase(AUf.Id, 'UF');
end;


end.
