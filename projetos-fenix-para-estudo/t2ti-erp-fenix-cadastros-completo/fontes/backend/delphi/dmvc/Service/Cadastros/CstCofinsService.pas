{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CST_COFINS] 
                                                                                
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
unit CstCofinsService;

interface

uses
  CstCofins, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TCstCofinsService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TCstCofins>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TCstCofins>;
    class function ConsultarObjeto(AId: Integer): TCstCofins;
    class procedure Inserir(ACstCofins: TCstCofins);
    class function Alterar(ACstCofins: TCstCofins): Integer;
    class function Excluir(ACstCofins: TCstCofins): Integer;
  end;

var
  sql: string;


implementation

{ TCstCofinsService }



class function TCstCofinsService.ConsultarLista: TObjectList<TCstCofins>;
begin
  sql := 'SELECT * FROM CST_COFINS ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCstCofins>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCstCofinsService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TCstCofins>;
begin
  sql := 'SELECT * FROM CST_COFINS where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TCstCofins>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCstCofinsService.ConsultarObjeto(AId: Integer): TCstCofins;
begin
  sql := 'SELECT * FROM CST_COFINS WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCstCofins>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TCstCofinsService.Inserir(ACstCofins: TCstCofins);
begin
  ACstCofins.ValidarInsercao;
  ACstCofins.Id := InserirBase(ACstCofins, 'CST_COFINS');
  
end;

class function TCstCofinsService.Alterar(ACstCofins: TCstCofins): Integer;
begin
  ACstCofins.ValidarAlteracao;
  Result := AlterarBase(ACstCofins, 'CST_COFINS');
  
  
end;


class function TCstCofinsService.Excluir(ACstCofins: TCstCofins): Integer;
begin
  ACstCofins.ValidarExclusao;
  
  Result := ExcluirBase(ACstCofins.Id, 'CST_COFINS');
end;


end.
