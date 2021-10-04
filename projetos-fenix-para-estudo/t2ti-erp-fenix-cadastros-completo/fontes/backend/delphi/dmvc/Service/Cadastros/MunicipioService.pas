{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [MUNICIPIO] 
                                                                                
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
unit MunicipioService;

interface

uses
  Municipio, Uf, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TMunicipioService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaMunicipio: TObjectList<TMunicipio>); overload;
    class procedure AnexarObjetosVinculados(AMunicipio: TMunicipio); overload;
  public
    class function ConsultarLista: TObjectList<TMunicipio>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TMunicipio>;
    class function ConsultarObjeto(AId: Integer): TMunicipio;
    class procedure Inserir(AMunicipio: TMunicipio);
    class function Alterar(AMunicipio: TMunicipio): Integer;
    class function Excluir(AMunicipio: TMunicipio): Integer;
  end;

var
  sql: string;


implementation

{ TMunicipioService }

class procedure TMunicipioService.AnexarObjetosVinculados(AMunicipio: TMunicipio);
begin
  // Uf
  sql := 'SELECT * FROM UF WHERE ID = ' + AMunicipio.IdUf.ToString;
  AMunicipio.Uf := GetQuery(sql).AsObject<TUf>;

end;

class procedure TMunicipioService.AnexarObjetosVinculados(AListaMunicipio: TObjectList<TMunicipio>);
var
  Municipio: TMunicipio;
begin
  for Municipio in AListaMunicipio do
  begin
    AnexarObjetosVinculados(Municipio);
  end;
end;

class function TMunicipioService.ConsultarLista: TObjectList<TMunicipio>;
begin
  sql := 'SELECT * FROM MUNICIPIO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TMunicipio>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TMunicipioService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TMunicipio>;
begin
  sql := 'SELECT * FROM MUNICIPIO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TMunicipio>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TMunicipioService.ConsultarObjeto(AId: Integer): TMunicipio;
begin
  sql := 'SELECT * FROM MUNICIPIO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TMunicipio>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TMunicipioService.Inserir(AMunicipio: TMunicipio);
begin
  AMunicipio.ValidarInsercao;
  AMunicipio.Id := InserirBase(AMunicipio, 'MUNICIPIO');
  
end;

class function TMunicipioService.Alterar(AMunicipio: TMunicipio): Integer;
begin
  AMunicipio.ValidarAlteracao;
  Result := AlterarBase(AMunicipio, 'MUNICIPIO');
  
  
end;


class function TMunicipioService.Excluir(AMunicipio: TMunicipio): Integer;
begin
  AMunicipio.ValidarExclusao;
  
  Result := ExcluirBase(AMunicipio.Id, 'MUNICIPIO');
end;


end.
