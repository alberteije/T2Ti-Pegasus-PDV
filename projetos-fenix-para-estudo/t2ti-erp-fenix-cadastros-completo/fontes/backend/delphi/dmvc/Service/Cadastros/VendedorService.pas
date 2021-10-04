{*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Service relacionado à tabela [VENDEDOR] 
                                                                                
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
unit VendedorService;

interface

uses
  Vendedor, Colaborador, Pessoa,
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TVendedorService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaVendedor: TObjectList<TVendedor>); overload;
    class procedure AnexarObjetosVinculados(AVendedor: TVendedor); overload;
  public
    class function ConsultarLista: TObjectList<TVendedor>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TVendedor>;
    class function ConsultarObjeto(AId: Integer): TVendedor;
    class procedure Inserir(AVendedor: TVendedor);
    class function Alterar(AVendedor: TVendedor): Integer;
    class function Excluir(AVendedor: TVendedor): Integer;
  end;

var
  sql: string;


implementation

{ TVendedorService }

class procedure TVendedorService.AnexarObjetosVinculados(AVendedor: TVendedor);
begin
  // Colaborador
  sql := 'SELECT * FROM COLABORADOR WHERE ID = ' + AVendedor.IdColaborador.ToString;
  AVendedor.Colaborador := GetQuery(sql).AsObject<TColaborador>;

  // Pessoa
  sql := 'SELECT * FROM PESSOA WHERE ID = ' + AVendedor.Colaborador.IdPessoa.ToString;
  AVendedor.Colaborador.Pessoa := GetQuery(sql).AsObject<TPessoa>;

end;

class procedure TVendedorService.AnexarObjetosVinculados(AListaVendedor: TObjectList<TVendedor>);
var
  Vendedor: TVendedor;
begin
  for Vendedor in AListaVendedor do
  begin
    AnexarObjetosVinculados(Vendedor);
  end;
end;

class function TVendedorService.ConsultarLista: TObjectList<TVendedor>;
begin
  sql := 'SELECT * FROM VENDEDOR ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TVendedor>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TVendedorService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TVendedor>;
begin
  sql := 'SELECT * FROM VENDEDOR where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TVendedor>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TVendedorService.ConsultarObjeto(AId: Integer): TVendedor;
begin
  sql := 'SELECT * FROM VENDEDOR WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TVendedor>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TVendedorService.Inserir(AVendedor: TVendedor);
begin
  AVendedor.ValidarInsercao;
  AVendedor.Id := InserirBase(AVendedor, 'VENDEDOR');
  
end;

class function TVendedorService.Alterar(AVendedor: TVendedor): Integer;
begin
  AVendedor.ValidarAlteracao;
  Result := AlterarBase(AVendedor, 'VENDEDOR');
  
  
end;


class function TVendedorService.Excluir(AVendedor: TVendedor): Integer;
begin
  AVendedor.ValidarExclusao;
  
  Result := ExcluirBase(AVendedor.Id, 'VENDEDOR');
end;


end.
