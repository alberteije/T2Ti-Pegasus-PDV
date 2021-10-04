{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [SETOR] 
                                                                                
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
unit SetorService;

interface

uses
  Setor, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TSetorService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TSetor>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TSetor>;
    class function ConsultarObjeto(AId: Integer): TSetor;
    class procedure Inserir(ASetor: TSetor);
    class function Alterar(ASetor: TSetor): Integer;
    class function Excluir(ASetor: TSetor): Integer;
  end;

var
  sql: string;


implementation

{ TSetorService }



class function TSetorService.ConsultarLista: TObjectList<TSetor>;
begin
  sql := 'SELECT * FROM SETOR ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TSetor>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TSetorService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TSetor>;
begin
  sql := 'SELECT * FROM SETOR where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TSetor>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TSetorService.ConsultarObjeto(AId: Integer): TSetor;
begin
  sql := 'SELECT * FROM SETOR WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TSetor>;
      
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TSetorService.Inserir(ASetor: TSetor);
begin
  ASetor.ValidarInsercao;
  ASetor.Id := InserirBase(ASetor, 'SETOR');
  
end;

class function TSetorService.Alterar(ASetor: TSetor): Integer;
begin
  ASetor.ValidarAlteracao;
  Result := AlterarBase(ASetor, 'SETOR');
  
  
end;


class function TSetorService.Excluir(ASetor: TSetor): Integer;
begin
  ASetor.ValidarExclusao;
  
  Result := ExcluirBase(ASetor.Id, 'SETOR');
end;


end.
