{*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [PDV_TIPO_PLANO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
unit PdvTipoPlanoService;

interface

uses
  PdvTipoPlano, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TPdvTipoPlanoService = class(TServiceBase)
  private
  public
    class function ConsultarLista: TObjectList<TPdvTipoPlano>;
    class function ConsultarListaFiltro(AWhere: string): TObjectList<TPdvTipoPlano>;
    class function ConsultarObjeto(AId: Integer): TPdvTipoPlano;
    class function ConsultarObjetoFiltro(AWhere: string): TPdvTipoPlano;
    class procedure Inserir(APdvTipoPlano: TPdvTipoPlano);
    class function Alterar(APdvTipoPlano: TPdvTipoPlano): Integer;
    class function Excluir(APdvTipoPlano: TPdvTipoPlano): Integer;
  end;

var
  sql: string;


implementation

{ TPdvTipoPlanoService }



class function TPdvTipoPlanoService.ConsultarLista: TObjectList<TPdvTipoPlano>;
begin
  sql := 'SELECT * FROM PDV_TIPO_PLANO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TPdvTipoPlano>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPdvTipoPlanoService.ConsultarListaFiltro(AWhere: string): TObjectList<TPdvTipoPlano>;
begin
  sql := 'SELECT * FROM PDV_TIPO_PLANO where ' + AWhere;
  try
    Result := GetQuery(sql).AsObjectList<TPdvTipoPlano>;
    
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPdvTipoPlanoService.ConsultarObjeto(AId: Integer): TPdvTipoPlano;
begin
  sql := 'SELECT * FROM PDV_TIPO_PLANO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TPdvTipoPlano>;

    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TPdvTipoPlanoService.ConsultarObjetoFiltro(AWhere: string): TPdvTipoPlano;
begin
  sql := 'SELECT * FROM PDV_TIPO_PLANO where ' + AWhere;
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TPdvTipoPlano>;

    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TPdvTipoPlanoService.Inserir(APdvTipoPlano: TPdvTipoPlano);
begin
  APdvTipoPlano.ValidarInsercao;
  APdvTipoPlano.Id := InserirBase(APdvTipoPlano, 'PDV_TIPO_PLANO');
  
end;

class function TPdvTipoPlanoService.Alterar(APdvTipoPlano: TPdvTipoPlano): Integer;
begin
  APdvTipoPlano.ValidarAlteracao;
  Result := AlterarBase(APdvTipoPlano, 'PDV_TIPO_PLANO');
  
  
end;


class function TPdvTipoPlanoService.Excluir(APdvTipoPlano: TPdvTipoPlano): Integer;
begin
  APdvTipoPlano.ValidarExclusao;
  
  Result := ExcluirBase(APdvTipoPlano.Id, 'PDV_TIPO_PLANO');
end;


end.
