{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CST_ICMS] 
                                                                                
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
unit CstIcmsService;

interface

uses
  CstIcms, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TCstIcmsService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TCstIcms>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TCstIcms>;
    class function ConsultarObjeto(AId: Integer): TCstIcms;
    class procedure Inserir(ACstIcms: TCstIcms);
    class function Alterar(ACstIcms: TCstIcms): Integer;
    class function Excluir(ACstIcms: TCstIcms): Integer;
  end;

var
  sql: string;


implementation

{ TCstIcmsService }



class function TCstIcmsService.ConsultarLista: TObjectList<TCstIcms>;
begin
  sql := 'SELECT * FROM CST_ICMS ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCstIcms>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCstIcmsService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TCstIcms>;
begin
  sql := 'SELECT * FROM CST_ICMS where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TCstIcms>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCstIcmsService.ConsultarObjeto(AId: Integer): TCstIcms;
begin
  sql := 'SELECT * FROM CST_ICMS WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCstIcms>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TCstIcmsService.Inserir(ACstIcms: TCstIcms);
begin
  ACstIcms.ValidarInsercao;
  ACstIcms.Id := InserirBase(ACstIcms, 'CST_ICMS');
  
end;

class function TCstIcmsService.Alterar(ACstIcms: TCstIcms): Integer;
begin
  ACstIcms.ValidarAlteracao;
  Result := AlterarBase(ACstIcms, 'CST_ICMS');
  
  
end;


class function TCstIcmsService.Excluir(ACstIcms: TCstIcms): Integer;
begin
  ACstIcms.ValidarExclusao;
  
  Result := ExcluirBase(ACstIcms.Id, 'CST_ICMS');
end;


end.
