{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [BANCO] 
                                                                                
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
unit BancoService;

interface

uses
  Banco, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TBancoService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TBanco>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TBanco>;
    class function ConsultarObjeto(AId: Integer): TBanco;
    class procedure Inserir(ABanco: TBanco);
    class function Alterar(ABanco: TBanco): Integer;
    class function Excluir(ABanco: TBanco): Integer;
  end;

var
  sql: string;


implementation

{ TBancoService }



class function TBancoService.ConsultarLista: TObjectList<TBanco>;
begin
  sql := 'SELECT * FROM BANCO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TBanco>;
	
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TBanco>;
begin
  sql := 'SELECT * FROM BANCO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TBanco>;
	
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoService.ConsultarObjeto(AId: Integer): TBanco;
begin
  sql := 'SELECT * FROM BANCO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TBanco>;
  	  
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TBancoService.Inserir(ABanco: TBanco);
begin
  ABanco.ValidarInsercao;
  ABanco.Id := InserirBase(ABanco, 'BANCO');
  
end;

class function TBancoService.Alterar(ABanco: TBanco): Integer;
begin
  ABanco.ValidarAlteracao;
  Result := AlterarBase(ABanco, 'BANCO');
  
  
end;


class function TBancoService.Excluir(ABanco: TBanco): Integer;
begin
  ABanco.ValidarExclusao;
  
  Result := ExcluirBase(ABanco.Id, 'BANCO');
end;


end.
