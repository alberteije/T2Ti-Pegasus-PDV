{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [PAPEL] 
                                                                                
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
unit PapelService;

interface

uses
  Papel, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TPapelService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaPapel: TObjectList<TPapel>); overload;
    class procedure AnexarObjetosVinculados(APapel: TPapel); overload;
  public
    class function ConsultarLista: TObjectList<TPapel>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TPapel>;
    class function ConsultarObjeto(AId: Integer): TPapel;
    class procedure Inserir(APapel: TPapel);
    class function Alterar(APapel: TPapel): Integer;
    class function Excluir(APapel: TPapel): Integer;
  end;

var
  sql: string;


implementation

{ TPapelService }

class procedure TPapelService.AnexarObjetosVinculados(APapel: TPapel);
begin
end;

class procedure TPapelService.AnexarObjetosVinculados(AListaPapel: TObjectList<TPapel>);
var
  Papel: TPapel;
begin
  for Papel in AListaPapel do
  begin
    AnexarObjetosVinculados(Papel);
  end;
end;

class function TPapelService.ConsultarLista: TObjectList<TPapel>;
begin
  sql := 'SELECT * FROM PAPEL ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TPapel>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPapelService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TPapel>;
begin
  sql := 'SELECT * FROM PAPEL where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TPapel>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPapelService.ConsultarObjeto(AId: Integer): TPapel;
begin
  sql := 'SELECT * FROM PAPEL WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TPapel>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TPapelService.Inserir(APapel: TPapel);
begin
  APapel.ValidarInsercao;
  APapel.Id := InserirBase(APapel, 'PAPEL');
  
end;

class function TPapelService.Alterar(APapel: TPapel): Integer;
begin
  APapel.ValidarAlteracao;
  Result := AlterarBase(APapel, 'PAPEL');
  
  
end;


class function TPapelService.Excluir(APapel: TPapel): Integer;
begin
  APapel.ValidarExclusao;
  
  Result := ExcluirBase(APapel.Id, 'PAPEL');
end;


end.
