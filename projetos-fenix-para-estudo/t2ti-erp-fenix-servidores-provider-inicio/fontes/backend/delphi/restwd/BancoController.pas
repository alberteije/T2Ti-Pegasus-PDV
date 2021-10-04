unit BancoController;

interface

uses
  // Delphi
  System.SysUtils,
  System.StrUtils,
  System.JSON,
  Data.DB,

  // Rest WD
  uDWJSONObject,
  uDWConstsCharset,
  uDWConsts,

  // FireDAC
  FireDAC.Comp.Client;

type
  TBancoController = class
    private
    protected
    public
      class function Consultar(pFiltro: string): string;
      class function Persistir(pObjeto: string): Boolean;
      class function Excluir(pId: Integer): Boolean;
  end;

implementation

{ TBancoController }

uses uDmService;

class function TBancoController.Consultar(pFiltro: string): string;
var
  JSONValue: TJSONValue;
  DataSet: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  DataSet := TFDQuery.Create(nil);
  DataSet.SQL.Add('SELECT * FROM BANCO !WHERE');
  DataSet.Connection := ServerMethodDM.Server_FDConnection;
  try
    DataSet.Close;
    DataSet.Macros[0].AsRaw := IfThen(pFiltro <> '', pFiltro, '');
    DataSet.Open;
    JSONValue.Encoding := esUtf8;
    JSONValue.LoadFromDataset('', DataSet, False, jmPureJSON, 'dd/mm/yyyy', '.');
    Result := JSONValue.ToJSON;
  finally
    JSONValue.Free;
    DataSet.Free;
  end;
end;

class function TBancoController.Persistir(pObjeto: string): Boolean;
var
  JObj: TJSONObject;
  DataSet: TFDQuery;

//  Banco: TBanco;

  ID: Integer;
  CODIGO, NOME, URL: string;
begin
  Result := False;

  DataSet := TFDQuery.Create(nil);
  DataSet.SQL.Add('SELECT * FROM BANCO !WHERE');
  DataSet.Connection := ServerMethodDM.Server_FDConnection;

  JObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(pObjeto), 0) as TJSONObject;
  if Jobj.TryGetValue('ID', ID) then
  begin
    try
      DataSet.Close;
      DataSet.Macros[0].AsRaw := ' WHERE ID = ' + ID.ToString;
      DataSet.Open;

      DataSet.FieldByName('ID').Required := False;

      if DataSet.IsEmpty then
        DataSet.Append
      else
        DataSet.Edit;

      Jobj.TryGetValue('CODIGO', CODIGO);
      Jobj.TryGetValue('NOME', NOME);
      Jobj.TryGetValue('URL', URL);

      DataSet.FieldByName('CODIGO').AsString  := CODIGO;
      DataSet.FieldByName('NOME').AsString   := NOME;
      DataSet.FieldByName('URL').AsString   := URL;

      DataSet.Post;
      ServerMethodDM.Server_FDConnection.Commit;

      Result := True;
    finally
      DataSet.Free;
    end;
  end;
end;

class function TBancoController.Excluir(pId: Integer): Boolean;
var
  DataSet: TFDQuery;
begin
  Result := False;

  DataSet := TFDQuery.Create(nil);
  DataSet.SQL.Add('SELECT * FROM BANCO !WHERE');
  DataSet.Connection := ServerMethodDM.Server_FDConnection;

  try
    DataSet.Close;
    DataSet.Macros[0].AsRaw := ' WHERE ID = ' + pId.ToString;
    DataSet.Open;

    if DataSet.IsEmpty then
      raise Exception.Create('ID não encontrado');

    DataSet.Delete;
    ServerMethodDM.Server_FDConnection.Commit;
    Result := True;
  finally
    DataSet.Free;
  end;
end;

end.

