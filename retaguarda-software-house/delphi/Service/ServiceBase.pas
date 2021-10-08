unit ServiceBase;

interface

uses
  System.SysUtils, UDataModuleConexao, MVCFramework.Serializer.Commons,
  FireDAC.Comp.Client, Rtti, MVCFramework.Logger;

type

  TServiceBase = class
  public
    class procedure Commit;
    class procedure Rollback;
    class procedure StartTransaction;
    class var FDataModuleConexao: TFDataModuleConexao;
    class function GetDataModuleConexao: TFDataModuleConexao;
    class function GetQuery(ASQL: string): TFDQuery;
    class function InserirBase(AObjeto: TObject; ATabela: string): Integer;
    class function AlterarBase(AObjeto: TObject; ATabela: string): Integer;
    class function ExcluirBase(AId: Integer; ATabela: string): Integer;
    class function ExcluirBaseFiltro(ATabela: string; AFiltro: string): Integer;
    class function ExcluirFilho(AId: Integer; ATabela: string; ACampo: string): Integer;
  end;

var
  Query: TFDQuery;
  UpdateSQL: TFDUpdateSQL;

implementation

{ TServiceBase }

class function TServiceBase.GetDataModuleConexao: TFDataModuleConexao;
begin
  if not Assigned(FDataModuleConexao) then
    FDataModuleConexao := TFDataModuleConexao.Create(nil);
  Result := FDataModuleConexao;
end;

class function TServiceBase.GetQuery(ASQL: string): TFDQuery;
var
  teste: string;
begin
  try
    Query := TFDQuery.Create(nil);
    Query.Connection := GetDataModuleConexao.Conexao;
    Query.Open(ASQL);
    Log(ASQL);
    Result := Query;
  except
    on E: Exception do
    begin
      teste := E.Message;
      teste := E.StackTrace;
    end
    else
      raise;
  end;
end;

class function TServiceBase.InserirBase(AObjeto: TObject; ATabela: string): Integer;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, CamposSQL, ValoresSQL: string;
  UltimoID: Integer;
  NomeTipo: string;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(AObjeto.ClassType);

    // começa com o nome da tabela
    ConsultaSQL := 'INSERT INTO ' + ATabela;

    // preenche os nomes dos campos e valores
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is MVCColumnAttribute then
        begin
          if (Propriedade.PropertyType.TypeKind in [tkInteger, tkInt64]) then
          begin
            if (Propriedade.GetValue(AObjeto).AsInteger <> 0) then
            begin
              CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ',';
              ValoresSQL := ValoresSQL + Propriedade.GetValue(AObjeto).ToString + ',';
            end;
          end
          else if (Propriedade.PropertyType.TypeKind in [tkstring, tkUstring]) then
          begin
            if (Propriedade.GetValue(AObjeto).Asstring <> '') then
            begin
              CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ',';
              ValoresSQL := ValoresSQL + QuotedStr(Propriedade.GetValue(AObjeto).ToString) + ',';
            end;
          end
          else if (Propriedade.PropertyType.TypeKind = tkFloat) then
          begin
            NomeTipo := LowerCase(Propriedade.PropertyType.Name);
            if NomeTipo = 'tdatetime' then
            begin
              CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ',';

              if Propriedade.GetValue(AObjeto).AsExtended > 0 then
                ValoresSQL := ValoresSQL + QuotedStr(FormatDateTime('yyyy-mm-dd', Propriedade.GetValue(AObjeto).AsExtended)) + ','
              else
                ValoresSQL := ValoresSQL + 'null,';
            end
            else
            begin
              CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ',';
              ValoresSQL := ValoresSQL + QuotedStr(FormatFloat('0.000000', Propriedade.GetValue(AObjeto).AsExtended)) + ',';
            end;
          end
          else
          begin
            CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ',';
            ValoresSQL := ValoresSQL + QuotedStr(Propriedade.GetValue(AObjeto).ToString) + ',';
          end;
        end;
      end;
    end;

    // retirando as vírgulas que sobraram no final
    Delete(CamposSQL, Length(CamposSQL), 1);
    Delete(ValoresSQL, Length(ValoresSQL), 1);

    ConsultaSQL := ConsultaSQL + '(' + CamposSQL + ') VALUES (' + ValoresSQL + ')';

    if GetDataModuleConexao.Conexao.DriverName = 'FB' then //firebird
    begin
      ConsultaSQL := ConsultaSQL + ' RETURNING ID ';
    end;
    Log(ConsultaSQL);
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := GetDataModuleConexao.Conexao;
      Query.sql.Text := ConsultaSQL;

      UltimoID := 0;
      if GetDataModuleConexao.Conexao.DriverName = 'MySQL' then
      begin
        Query.ExecSQL();
        Query.sql.Text := 'select LAST_INSERT_ID() as id';
        Query.Open();
        UltimoID := Query.FieldByName('id').AsInteger;
      end
      else if GetDataModuleConexao.Conexao.DriverName = 'Firebird' then
      begin
        Query.Open;
        UltimoID := Query.Fields[0].AsInteger;
      end;
    finally
      Query.Close;
      Query.Free;
    end;

    Result := UltimoID;
  finally
    Contexto.Free;
  end;
end;

class function TServiceBase.AlterarBase(AObjeto: TObject; ATabela: string): Integer;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  ConsultaSQL, CamposSQL, FiltroSQL: string;
  NomeTipo: string;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(AObjeto.ClassType);

    // começa com o nome da tabela
    ConsultaSQL := 'UPDATE ' + ATabela + ' SET ';

    // preenche os nomes dos campos e filtro
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is MVCColumnAttribute then
        begin
          if not (Atributo as MVCColumnAttribute).IsPK then // se não for a chave primária
          begin
            if (Propriedade.PropertyType.TypeKind in [tkInteger, tkInt64]) then
            begin
              if (Propriedade.GetValue(AObjeto).AsInteger <> 0) then
                CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ' = ' + Propriedade.GetValue(AObjeto).ToString + ','
              else
                CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ' = ' + 'null' + ',';
            end

            else if (Propriedade.PropertyType.TypeKind in [tkString, tkUString]) then
            begin
              if (Propriedade.GetValue(AObjeto).AsString <> '') then
                CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ' = ' + QuotedStr(Propriedade.GetValue(AObjeto).ToString) + ','
              else
                CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ' = ' + 'null' + ',';
            end

            else if (Propriedade.PropertyType.TypeKind = tkFloat) then
            begin
              if Propriedade.GetValue(AObjeto).AsExtended <> 0 then
              begin
                NomeTipo := LowerCase(Propriedade.PropertyType.Name);
                if NomeTipo = 'tdatetime' then
                  CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ' = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', Propriedade.GetValue(AObjeto).AsExtended)) + ','
                else
                  CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ' = ' + QuotedStr(FormatFloat('0.000000', Propriedade.GetValue(AObjeto).AsExtended)) + ',';
              end
              else if Propriedade.GetValue(AObjeto).AsExtended = 0 then
              begin
                NomeTipo := LowerCase(Propriedade.PropertyType.Name);
                if NomeTipo = 'tdatetime' then
                  CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ' = ' + 'null' + ','; // adicionado em 07102021 para passar uma data para nulo se ela vier zerada na aplicação
              end;

            end

            else if Propriedade.GetValue(AObjeto).ToString <> '' then
              CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ' = ' + QuotedStr(Propriedade.GetValue(AObjeto).ToString) + ','
            else
              CamposSQL := CamposSQL + (Atributo as MVCColumnAttribute).FieldName + ' = ' + 'null' + ',';
          end
          else // se for a chave primária
          begin
            FiltroSQL := ' WHERE ' + (Atributo as MVCColumnAttribute).FieldName + ' = ' + QuotedStr(Propriedade.GetValue(AObjeto).ToString);
          end;
        end;
      end;
    end;

    // retirando as vírgulas que sobraram no final
    Delete(CamposSQL, Length(CamposSQL), 1);

    ConsultaSQL := ConsultaSQL + CamposSQL + FiltroSQL;
    Log(ConsultaSQL);

    Query := TFDQuery.Create(nil);
    Query.Connection := GetDataModuleConexao.Conexao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL;
    Result := Query.RowsAffected;
  finally
    Contexto.Free;
    FreeAndNil(Query);
  end;
end;

class function TServiceBase.ExcluirBase(AId: Integer; ATabela: string): Integer;
var
  ConsultaSQL, FiltroSQL: string;
begin
  try
    ConsultaSQL := 'DELETE FROM ' + ATabela;
    FiltroSQL := ' WHERE ID = ' + AId.ToString;
    ConsultaSQL := ConsultaSQL + FiltroSQL;
    Log(ConsultaSQL);

    Query := TFDQuery.Create(nil);
    Query.Connection := GetDataModuleConexao.Conexao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL;
    Result := Query.RowsAffected;
  finally
    FreeAndNil(Query);
  end;
end;

class function TServiceBase.ExcluirBaseFiltro(ATabela: string; AFiltro: string): Integer;
var
  ConsultaSQL, FiltroSQL: string;
begin
  try
    ConsultaSQL := 'DELETE FROM ' + ATabela;
    FiltroSQL := ' WHERE ' + AFiltro;
    ConsultaSQL := ConsultaSQL + FiltroSQL;
    Log(ConsultaSQL);

    Query := TFDQuery.Create(nil);
    Query.Connection := GetDataModuleConexao.Conexao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL;
    Result := Query.RowsAffected;
  finally
    FreeAndNil(Query);
  end;
end;

class function TServiceBase.ExcluirFilho(AId: Integer; ATabela, ACampo: string): Integer;
var
  ConsultaSQL, FiltroSQL: string;
begin
  try
    ConsultaSQL := 'DELETE FROM ' + ATabela;
    FiltroSQL := ' WHERE ' + ACampo + ' = ' + AId.ToString;
    ConsultaSQL := ConsultaSQL + FiltroSQL;
    Log(ConsultaSQL);

    Query := TFDQuery.Create(nil);
    Query.Connection := GetDataModuleConexao.Conexao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL;
    Result := Query.RowsAffected;
  finally
    FreeAndNil(Query);
  end;
end;

class procedure TServiceBase.Commit;
begin
  GetDataModuleConexao.Conexao.Commit;
end;

class procedure TServiceBase.Rollback;
begin
  GetDataModuleConexao.Conexao.Rollback;
end;

class procedure TServiceBase.StartTransaction;
begin
  GetDataModuleConexao.Conexao.StartTransaction;
end;

end.
