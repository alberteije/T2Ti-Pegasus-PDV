unit BancoAgenciaService;

interface

uses
  System.SysUtils, System.Generics.Collections, ServiceBase, BancoAgencia, Banco;

type

  TBancoAgenciaService = class(TServiceBase)
  private
    class procedure AnexarObjetosVinculados(const ListaAgencia: TObjectList<TBancoAgencia>); overload;
    class procedure AnexarObjetosVinculados(const Agencia: TBancoAgencia); overload;
  public
    class function ConsultarLista: TObjectList<TBancoAgencia>;
    class function ConsultarListaFiltroValor(campo: string; valor: string): TObjectList<TBancoAgencia>;
    class function ConsultarObjeto(const AId: Integer): TBancoAgencia;
    class procedure Inserir(ABancoAgencia: TBancoAgencia);
    class function Alterar(ABancoAgencia: TBancoAgencia): Integer;
    class function Excluir(ABancoAgencia: TBancoAgencia): Integer;
  end;

var
  sql: string;

implementation

uses
  FireDAC.Stan.Option, FireDAC.Comp.Client, FireDAC.Stan.Param,
  MVCFramework.FireDAC.Utils, MVCFramework.DataSet.Utils,
  MVCFramework.Serializer.Commons, MVCFramework.Commons;

{ TBancoAgenciaService }

class procedure TBancoAgenciaService.AnexarObjetosVinculados(const Agencia: TBancoAgencia);
begin
  sql := 'SELECT * FROM BANCO WHERE ID = ' + Agencia.IdBanco.ToString;
  Agencia.Banco := GetQuery(sql).AsObject<TBanco>;
end;

class procedure TBancoAgenciaService.AnexarObjetosVinculados(const ListaAgencia: TObjectList<TBancoAgencia>);
var
  Agencia: TBancoAgencia;
begin
  for Agencia in ListaAgencia do
  begin
    AnexarObjetosVinculados(Agencia);
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

class function TBancoAgenciaService.ConsultarListaFiltroValor(campo, valor: string): TObjectList<TBancoAgencia>;
begin
  sql := 'SELECT * FROM BANCO_AGENCIA where ' + campo + ' like "%' + valor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TBancoAgencia>;
    AnexarObjetosVinculados(Result);
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoAgenciaService.ConsultarObjeto(const AId: Integer): TBancoAgencia;
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
