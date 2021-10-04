{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [CLIENTE] 
                                                                                
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
unit ClienteService;

interface

uses
  Cliente, Pessoa, 
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TClienteService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaCliente: TObjectList<TCliente>); overload;
    class procedure AnexarObjetosVinculados(ACliente: TCliente); overload;
  public
    class function ConsultarLista: TObjectList<TCliente>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TCliente>;
    class function ConsultarObjeto(AId: Integer): TCliente;
    class procedure Inserir(ACliente: TCliente);
    class function Alterar(ACliente: TCliente): Integer;
    class function Excluir(ACliente: TCliente): Integer;
  end;

var
  sql: string;


implementation

{ TClienteService }

class procedure TClienteService.AnexarObjetosVinculados(ACliente: TCliente);
begin
  // Pessoa
  sql := 'SELECT * FROM PESSOA WHERE ID = ' + ACliente.IdPessoa.ToString;
  ACliente.Pessoa := GetQuery(sql).AsObject<TPessoa>;

end;

class procedure TClienteService.AnexarObjetosVinculados(AListaCliente: TObjectList<TCliente>);
var
  Cliente: TCliente;
begin
  for Cliente in AListaCliente do
  begin
    AnexarObjetosVinculados(Cliente);
  end;
end;

class function TClienteService.ConsultarLista: TObjectList<TCliente>;
begin
  sql := 'SELECT * FROM CLIENTE ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TCliente>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TClienteService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TCliente>;
begin
  sql := 'SELECT * FROM CLIENTE where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TCliente>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TClienteService.ConsultarObjeto(AId: Integer): TCliente;
begin
  sql := 'SELECT * FROM CLIENTE WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TCliente>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TClienteService.Inserir(ACliente: TCliente);
begin
  ACliente.ValidarInsercao;
  ACliente.Id := InserirBase(ACliente, 'CLIENTE');
  
end;

class function TClienteService.Alterar(ACliente: TCliente): Integer;
begin
  ACliente.ValidarAlteracao;
  Result := AlterarBase(ACliente, 'CLIENTE');
  
  
end;


class function TClienteService.Excluir(ACliente: TCliente): Integer;
begin
  ACliente.ValidarExclusao;
  
  Result := ExcluirBase(ACliente.Id, 'CLIENTE');
end;


end.
