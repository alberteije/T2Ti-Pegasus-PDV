{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [BANCO_AGENCIA] 
                                                                                
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
unit BancoAgenciaService;

interface

uses
  BancoAgencia, Banco, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TBancoAgenciaService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaBancoAgencia: TObjectList<TBancoAgencia>); overload;
    class procedure AnexarObjetosVinculados(ABancoAgencia: TBancoAgencia); overload;
  public
    class function ConsultarLista: TObjectList<TBancoAgencia>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TBancoAgencia>;
    class function ConsultarObjeto(AId: Integer): TBancoAgencia;
    class procedure Inserir(ABancoAgencia: TBancoAgencia);
    class function Alterar(ABancoAgencia: TBancoAgencia): Integer;
    class function Excluir(ABancoAgencia: TBancoAgencia): Integer;
  end;

var
  sql: string;


implementation

{ TBancoAgenciaService }

class procedure TBancoAgenciaService.AnexarObjetosVinculados(ABancoAgencia: TBancoAgencia);
begin
  // Banco
  sql := 'SELECT * FROM BANCO WHERE ID = ' + ABancoAgencia.IdBanco.ToString;
  ABancoAgencia.Banco := GetQuery(sql).AsObject<TBanco>;

end;

class procedure TBancoAgenciaService.AnexarObjetosVinculados(AListaBancoAgencia: TObjectList<TBancoAgencia>);
var
  BancoAgencia: TBancoAgencia;
begin
  for BancoAgencia in AListaBancoAgencia do
  begin
    AnexarObjetosVinculados(BancoAgencia);
  end;
end;

class function TBancoAgenciaService.ConsultarLista: TObjectList<TBancoAgencia>;
begin
  sql := 'SELECT * FROM BANCO_AGENCIA ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TBancoAgencia>;
	AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoAgenciaService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TBancoAgencia>;
begin
  sql := 'SELECT * FROM BANCO_AGENCIA where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TBancoAgencia>;
	AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoAgenciaService.ConsultarObjeto(AId: Integer): TBancoAgencia;
begin
  sql := 'SELECT * FROM BANCO_AGENCIA WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TBancoAgencia>;
  	  AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TBancoAgenciaService.Inserir(ABancoAgencia: TBancoAgencia);
begin
  ABancoAgencia.ValidarInsercao;
  ABancoAgencia.Id := InserirBase(ABancoAgencia, 'BANCO_AGENCIA');
  
end;

class function TBancoAgenciaService.Alterar(ABancoAgencia: TBancoAgencia): Integer;
begin
  ABancoAgencia.ValidarAlteracao;
  Result := AlterarBase(ABancoAgencia, 'BANCO_AGENCIA');
  
  
end;


class function TBancoAgenciaService.Excluir(ABancoAgencia: TBancoAgencia): Integer;
begin
  ABancoAgencia.ValidarExclusao;
  
  Result := ExcluirBase(ABancoAgencia.Id, 'BANCO_AGENCIA');
end;


end.
