{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CSOSN] 
                                                                                
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
unit CsosnService;

interface

uses
  Csosn, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TCsosnService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TCsosn>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TCsosn>;
    class function ConsultarObjeto(AId: Integer): TCsosn;
    class procedure Inserir(ACsosn: TCsosn);
    class function Alterar(ACsosn: TCsosn): Integer;
    class function Excluir(ACsosn: TCsosn): Integer;
  end;

var
  sql: string;


implementation

{ TCsosnService }



class function TCsosnService.ConsultarLista: TObjectList<TCsosn>;
begin
  sql := 'SELECT * FROM CSOSN ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCsosn>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCsosnService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TCsosn>;
begin
  sql := 'SELECT * FROM CSOSN where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TCsosn>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCsosnService.ConsultarObjeto(AId: Integer): TCsosn;
begin
  sql := 'SELECT * FROM CSOSN WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCsosn>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TCsosnService.Inserir(ACsosn: TCsosn);
begin
  ACsosn.ValidarInsercao;
  ACsosn.Id := InserirBase(ACsosn, 'CSOSN');
  
end;

class function TCsosnService.Alterar(ACsosn: TCsosn): Integer;
begin
  ACsosn.ValidarAlteracao;
  Result := AlterarBase(ACsosn, 'CSOSN');
  
  
end;


class function TCsosnService.Excluir(ACsosn: TCsosn): Integer;
begin
  ACsosn.ValidarExclusao;
  
  Result := ExcluirBase(ACsosn.Id, 'CSOSN');
end;


end.
