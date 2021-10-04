{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [NIVEL_FORMACAO] 
                                                                                
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
unit NivelFormacaoService;

interface

uses
  NivelFormacao, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TNivelFormacaoService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TNivelFormacao>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TNivelFormacao>;
    class function ConsultarObjeto(AId: Integer): TNivelFormacao;
    class procedure Inserir(ANivelFormacao: TNivelFormacao);
    class function Alterar(ANivelFormacao: TNivelFormacao): Integer;
    class function Excluir(ANivelFormacao: TNivelFormacao): Integer;
  end;

var
  sql: string;


implementation

{ TNivelFormacaoService }



class function TNivelFormacaoService.ConsultarLista: TObjectList<TNivelFormacao>;
begin
  sql := 'SELECT * FROM NIVEL_FORMACAO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TNivelFormacao>;
	
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TNivelFormacaoService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TNivelFormacao>;
begin
  sql := 'SELECT * FROM NIVEL_FORMACAO where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TNivelFormacao>;
	
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TNivelFormacaoService.ConsultarObjeto(AId: Integer): TNivelFormacao;
begin
  sql := 'SELECT * FROM NIVEL_FORMACAO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TNivelFormacao>;
  	  
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TNivelFormacaoService.Inserir(ANivelFormacao: TNivelFormacao);
begin
  ANivelFormacao.ValidarInsercao;
  ANivelFormacao.Id := InserirBase(ANivelFormacao, 'NIVEL_FORMACAO');
  
end;

class function TNivelFormacaoService.Alterar(ANivelFormacao: TNivelFormacao): Integer;
begin
  ANivelFormacao.ValidarAlteracao;
  Result := AlterarBase(ANivelFormacao, 'NIVEL_FORMACAO');
  
  
end;


class function TNivelFormacaoService.Excluir(ANivelFormacao: TNivelFormacao): Integer;
begin
  ANivelFormacao.ValidarExclusao;
  
  Result := ExcluirBase(ANivelFormacao.Id, 'NIVEL_FORMACAO');
end;


end.
