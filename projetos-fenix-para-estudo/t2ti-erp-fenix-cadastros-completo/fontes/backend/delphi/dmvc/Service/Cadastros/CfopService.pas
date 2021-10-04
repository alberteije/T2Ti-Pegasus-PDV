{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CFOP] 
                                                                                
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
unit CfopService;

interface

uses
  Cfop, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TCfopService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TCfop>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TCfop>;
    class function ConsultarObjeto(AId: Integer): TCfop;
    class procedure Inserir(ACfop: TCfop);
    class function Alterar(ACfop: TCfop): Integer;
    class function Excluir(ACfop: TCfop): Integer;
  end;

var
  sql: string;


implementation

{ TCfopService }



class function TCfopService.ConsultarLista: TObjectList<TCfop>;
begin
  sql := 'SELECT * FROM CFOP ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCfop>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCfopService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TCfop>;
begin
  sql := 'SELECT * FROM CFOP where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TCfop>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TCfopService.ConsultarObjeto(AId: Integer): TCfop;
begin
  sql := 'SELECT * FROM CFOP WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCfop>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TCfopService.Inserir(ACfop: TCfop);
begin
  ACfop.ValidarInsercao;
  ACfop.Id := InserirBase(ACfop, 'CFOP');
  
end;

class function TCfopService.Alterar(ACfop: TCfop): Integer;
begin
  ACfop.ValidarAlteracao;
  Result := AlterarBase(ACfop, 'CFOP');
  
  
end;


class function TCfopService.Excluir(ACfop: TCfop): Integer;
begin
  ACfop.ValidarExclusao;
  
  Result := ExcluirBase(ACfop.Id, 'CFOP');
end;


end.
