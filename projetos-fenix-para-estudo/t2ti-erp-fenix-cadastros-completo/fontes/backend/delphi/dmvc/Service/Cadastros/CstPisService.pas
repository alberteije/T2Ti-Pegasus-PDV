{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CST_PIS] 
                                                                                
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
unit CstPisService;

interface

uses
  CstPis, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TCstPisService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TCstPis>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TCstPis>;
    class function ConsultarObjeto(AId: Integer): TCstPis;
    class procedure Inserir(ACstPis: TCstPis);
    class function Alterar(ACstPis: TCstPis): Integer;
    class function Excluir(ACstPis: TCstPis): Integer;
  end;

var
  sql: string;


implementation

{ TCstPisService }



class function TCstPisService.ConsultarLista: TObjectList<TCstPis>;
begin
  sql := 'SELECT * FROM CST_PIS ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCstPis>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCstPisService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TCstPis>;
begin
  sql := 'SELECT * FROM CST_PIS where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TCstPis>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCstPisService.ConsultarObjeto(AId: Integer): TCstPis;
begin
  sql := 'SELECT * FROM CST_PIS WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCstPis>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TCstPisService.Inserir(ACstPis: TCstPis);
begin
  ACstPis.ValidarInsercao;
  ACstPis.Id := InserirBase(ACstPis, 'CST_PIS');
  
end;

class function TCstPisService.Alterar(ACstPis: TCstPis): Integer;
begin
  ACstPis.ValidarAlteracao;
  Result := AlterarBase(ACstPis, 'CST_PIS');
  
  
end;


class function TCstPisService.Excluir(ACstPis: TCstPis): Integer;
begin
  ACstPis.ValidarExclusao;
  
  Result := ExcluirBase(ACstPis.Id, 'CST_PIS');
end;


end.
