{*******************************************************************************
Title: T2Ti ERP Fenix
Description: Service relacionado à tabela [COLABORADOR]

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
unit ColaboradorService;

interface

uses
  Colaborador, Usuario, Pessoa, Cargo, Setor,
  System.SysUtils, System.Generics.Collections, ServiceBase, MVCFramework.DataSet.Utils;

type

  TColaboradorService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(AListaColaborador: TObjectList<TColaborador>); overload;
    class procedure AnexarObjetosVinculados(AColaborador: TColaborador); overload;
    class procedure InserirObjetosFilhos(AColaborador: TColaborador);
    class procedure ExcluirObjetosFilhos(AColaborador: TColaborador);
  public
    class function ConsultarLista: TObjectList<TColaborador>;
    class function ConsultarListaFiltroValor(ACampo: string; AValor: string): TObjectList<TColaborador>;
    class function ConsultarObjeto(AId: Integer): TColaborador;
    class procedure Inserir(AColaborador: TColaborador);
    class function Alterar(AColaborador: TColaborador): Integer;
    class function Excluir(AColaborador: TColaborador): Integer;
  end;

var
  sql: string;


implementation

{ TColaboradorService }

class procedure TColaboradorService.AnexarObjetosVinculados(AColaborador: TColaborador);
begin
  // Usuario
  sql := 'SELECT * FROM USUARIO WHERE ID_COLABORADOR = ' + AColaborador.Id.ToString;
  AColaborador.Usuario := GetQuery(sql).AsObject<TUsuario>;

  // Pessoa
  sql := 'SELECT * FROM PESSOA WHERE ID = ' + AColaborador.IdPessoa.ToString;
  AColaborador.Pessoa := GetQuery(sql).AsObject<TPessoa>;

  // Cargo
  sql := 'SELECT * FROM CARGO WHERE ID = ' + AColaborador.IdCargo.ToString;
  AColaborador.Cargo := GetQuery(sql).AsObject<TCargo>;

  // Setor
  sql := 'SELECT * FROM SETOR WHERE ID = ' + AColaborador.IdSetor.ToString;
  AColaborador.Setor := GetQuery(sql).AsObject<TSetor>;

end;

class procedure TColaboradorService.AnexarObjetosVinculados(AListaColaborador: TObjectList<TColaborador>);
var
  Colaborador: TColaborador;
begin
  for Colaborador in AListaColaborador do
  begin
    AnexarObjetosVinculados(Colaborador);
  end;
end;

class function TColaboradorService.ConsultarLista: TObjectList<TColaborador>;
begin
  sql := 'SELECT * FROM COLABORADOR ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TColaborador>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TColaboradorService.ConsultarListaFiltroValor(ACampo, AValor: string): TObjectList<TColaborador>;
begin
  sql := 'SELECT * FROM COLABORADOR where ' + ACampo + ' like "%' + AValor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TColaborador>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TColaboradorService.ConsultarObjeto(AId: Integer): TColaborador;
begin
  sql := 'SELECT * FROM COLABORADOR WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
    begin
      Result := Query.AsObject<TColaborador>;
      AnexarObjetosVinculados(Result);
    end
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TColaboradorService.Inserir(AColaborador: TColaborador);
begin
  AColaborador.ValidarInsercao;
  AColaborador.Id := InserirBase(AColaborador, 'COLABORADOR');
  InserirObjetosFilhos(AColaborador);
end;

class function TColaboradorService.Alterar(AColaborador: TColaborador): Integer;
begin
  AColaborador.ValidarAlteracao;
  Result := AlterarBase(AColaborador, 'COLABORADOR');
  ExcluirObjetosFilhos(AColaborador);
  InserirObjetosFilhos(AColaborador);
end;

class procedure TColaboradorService.InserirObjetosFilhos(AColaborador: TColaborador);
begin
  // Usuario
  AColaborador.Usuario.IdColaborador := AColaborador.Id;
  InserirBase(AColaborador.Usuario, 'USUARIO');

end;

class function TColaboradorService.Excluir(AColaborador: TColaborador): Integer;
begin
  AColaborador.ValidarExclusao;
  ExcluirObjetosFilhos(AColaborador);
  Result := ExcluirBase(AColaborador.Id, 'COLABORADOR');
end;

class procedure TColaboradorService.ExcluirObjetosFilhos(AColaborador: TColaborador);
begin
  ExcluirFilho(AColaborador.Id, 'USUARIO', 'ID_COLABORADOR');
end;

end.

