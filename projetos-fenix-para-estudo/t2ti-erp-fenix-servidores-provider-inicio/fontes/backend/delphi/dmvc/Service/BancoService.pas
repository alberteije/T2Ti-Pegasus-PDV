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
    class procedure Inserir(ABanco: TBanco);
    class procedure Alterar(ABanco: TBanco);
    class procedure Excluir(ABanco: TBanco);
  end;

const
  INSERT = 'INSERT INTO BANCO '+
           '(ID, CODIGO, NOME, URL) '+
           'VALUES (:NEW_ID, :NEW_CODIGO, :NEW_NOME, :NEW_URL)';
  UPDATE = 'UPDATE BANCO '+
           'SET ID = :NEW_ID, CODIGO = :NEW_CODIGO, NOME = :NEW_NOME, '+
           'URL = :NEW_URL '+
           'WHERE ID = :OLD_ID';
  DELETE = 'DELETE FROM BANCO WHERE ID = :OLD_ID';


implementation

uses
  FireDAC.Stan.Option, FireDAC.Comp.Client, FireDAC.Stan.Param,
  MVCFramework.FireDAC.Utils, MVCFramework.DataSet.Utils,
  MVCFramework.Serializer.Commons, MVCFramework.Commons;

{ TBancoService }

class function TBancoService.ConsultarLista: TObjectList<TBanco>;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := GetDataModule.Conexao;
  try
    Query.Open('SELECT * FROM BANCO ORDER BY ID');
    Result := Query.AsObjectList<TBanco>;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoService.ConsultarListaFiltroValor(campo, valor: string): TObjectList<TBanco>;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := GetDataModule.Conexao;
  try
    Query.Open('SELECT * FROM BANCO where ' + campo + ' like "%' + valor + '%"');
    Result := Query.AsObjectList<TBanco>;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class function TBancoService.ConsultarObjeto(const AId: Integer): TBanco;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := GetDataModule.Conexao;
  try
    Query.Open('SELECT * FROM BANCO WHERE ID = :ID', [AId]);
    if not Query.Eof then
      Result := Query.AsObject<TBanco>
    else
      Result := nil;
  finally
    Query.Close;
    Query.Free;
  end;
end;

class procedure TBancoService.Inserir(ABanco: TBanco);
var
  Cmd: TFDCustomCommand;
begin
  ABanco.ValidarInsercao;

  UpdateSQL := TFDUpdateSQL.Create(nil);
  UpdateSQL.Connection := GetDataModule.Conexao;
  UpdateSQL.InsertSQL.Add(INSERT);
  try
    Cmd := UpdateSQL.Commands[arInsert];
    TFireDACUtils.ObjectToParameters(Cmd.Params, ABanco, 'NEW_');
    Cmd.Execute;
  finally
    UpdateSQL.Free;
  end;
end;

class procedure TBancoService.Alterar(ABanco: TBanco);
var
  Cmd: TFDCustomCommand;
begin
  ABanco.ValidarAlteracao;

  UpdateSQL := TFDUpdateSQL.Create(nil);
  UpdateSQL.Connection := GetDataModule.Conexao;
  UpdateSQL.ModifySQL.Add(UPDATE);
  try
    Cmd := UpdateSQL.Commands[arUpdate];
    TFireDACUtils.ObjectToParameters(Cmd.Params, ABanco, 'NEW_');
    Cmd.ParamByName('OLD_ID').AsInteger := ABanco.Id;
    Cmd.Execute;
    if Cmd.RowsAffected <> 1 then
      raise EMVCException.Create('Objeto com ID inválido [Alterar Banco]', '', 0, 400);
  finally
    UpdateSQL.Free;
  end;
end;

class procedure TBancoService.Excluir(ABanco: TBanco);
var
  Cmd: TFDCustomCommand;
begin
  ABanco.ValidarExclusao;

  UpdateSQL := TFDUpdateSQL.Create(nil);
  UpdateSQL.Connection := GetDataModule.Conexao;
  UpdateSQL.DeleteSQL.Add(DELETE);
  try
    Cmd := UpdateSQL.Commands[arDelete];
    TFireDACUtils.ObjectToParameters(Cmd.Params, ABanco, 'OLD_');
    Cmd.Execute;
  finally
    UpdateSQL.Free;
  end;
end;

end.
