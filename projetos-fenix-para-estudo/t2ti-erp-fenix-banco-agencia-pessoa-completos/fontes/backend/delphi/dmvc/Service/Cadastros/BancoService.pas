unit BancoService;

interface

uses
  System.SysUtils, System.Generics.Collections, ServiceBase, Banco;

type

  TBancoService = class(TServiceBase)
  public
    class function ConsultarLista: TObjectList<TBanco>;
    class function ConsultarListaFiltroValor(campo: string; valor: string): TObjectList<TBanco>;
    class function ConsultarObjeto(const AId: Integer): TBanco;
    class procedure Inserir(var ABanco: TBanco);
    class function Alterar(ABanco: TBanco): Integer;
    class function Excluir(ABanco: TBanco): Integer;
  end;

var
  sql: string;

implementation

uses
  FireDAC.Stan.Option, FireDAC.Comp.Client, FireDAC.Stan.Param,
  MVCFramework.FireDAC.Utils, MVCFramework.DataSet.Utils,
  MVCFramework.Serializer.Commons, MVCFramework.Commons;

{ TBancoService }

class function TBancoService.ConsultarLista: TObjectList<TBanco>;
begin
  sql := 'SELECT * FROM BANCO ORDER BY ID';
  try
    Result := GetQuery(sql).AsObjectList<TBanco>;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoService.ConsultarListaFiltroValor(campo, valor: string): TObjectList<TBanco>;
begin
  sql := 'SELECT * FROM BANCO where ' + campo + ' like "%' + valor + '%"';
  try
    Result := GetQuery(sql).AsObjectList<TBanco>;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoService.ConsultarObjeto(const AId: Integer): TBanco;
begin
  sql := 'SELECT * FROM BANCO WHERE ID = ' + IntToStr(AId);
  try
    GetQuery(sql);
    if not Query.Eof then
      Result := Query.AsObject<TBanco>
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TBancoService.Inserir(var ABanco: TBanco);
begin
  ABanco.ValidarInsercao;
  ABanco.Id := InserirBase(ABanco, 'BANCO');
end;

class function TBancoService.Alterar(ABanco: TBanco): Integer;
begin
  ABanco.ValidarAlteracao;
  Result := AlterarBase(ABanco, 'BANCO');
end;

class function TBancoService.Excluir(ABanco: TBanco): Integer;
begin
  ABanco.ValidarExclusao;
  Result := ExcluirBase(ABanco.Id, 'BANCO');
end;

end.
