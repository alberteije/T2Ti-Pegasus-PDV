unit PessoaController;

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
  TPessoaController = class
    private
    protected
    public
      class function Consultar(pFiltro: string): string;
      class function Persistir(pObjeto: string): Boolean;
      class function Excluir(pId: Integer): Boolean;
  end;

implementation

{ TPessoaController }

uses uDmService;

class function TPessoaController.Consultar(pFiltro: string): string;
var
  JSONValue: TJSONValue;
  DataSet: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  DataSet := TFDQuery.Create(nil);
  DataSet.SQL.Add('SELECT * FROM PESSOA !WHERE');
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

class function TPessoaController.Persistir(pObjeto: string): Boolean;
var
  JObj: TJSONObject;
  DataSet: TFDQuery;

  //Pessoa Fisica
  DataSetPF: TFDQuery;
  PessoaFisicaJSON: TJSONObject;
  ParPF: TJsonPair;
  CPF, RG: string;

  //Contatos
  DataSetContatos: TFDQuery;
  ContatoJSON: TJSONObject;
  ParContato: TJsonPair;

//  PESSOA: TPESSOA;

  ID: Integer;
  TIPO, NOME, SITE, EMAIL, CLIENTE, FORNECEDOR, TRANSPORTADORA, COLABORADOR, CONTADOR: string;
begin
  Result := False;

  DataSet := TFDQuery.Create(nil);
  DataSet.SQL.Add('SELECT * FROM PESSOA !WHERE');
  DataSet.Connection := ServerMethodDM.Server_FDConnection;

  // pessoa física
  DataSetPF := TFDQuery.Create(nil);
  DataSetPF.SQL.Add('SELECT * FROM PESSOA_FISICA !WHERE');
  DataSetPF.Connection := ServerMethodDM.Server_FDConnection;

  // contatos
  DataSetContatos := TFDQuery.Create(nil);
  DataSetContatos.SQL.Add('SELECT * FROM PESSOA_CONTATO !WHERE');
  DataSetContatos.Connection := ServerMethodDM.Server_FDConnection;

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

      Jobj.TryGetValue('TIPO', TIPO);
      Jobj.TryGetValue('NOME', NOME);
      Jobj.TryGetValue('SITE', SITE);
      Jobj.TryGetValue('EMAIL', EMAIL);
      Jobj.TryGetValue('CLIENTE', CLIENTE);
      Jobj.TryGetValue('FORNECEDOR', FORNECEDOR);
      Jobj.TryGetValue('TRANSPORTADORA', TRANSPORTADORA);
      Jobj.TryGetValue('COLABORADOR', COLABORADOR);
      Jobj.TryGetValue('CONTADOR', CONTADOR);

      DataSet.FieldByName('TIPO').AsString  := TIPO;
      DataSet.FieldByName('NOME').AsString   := NOME;
      DataSet.FieldByName('SITE').AsString   := SITE;
      DataSet.FieldByName('EMAIL').AsString   := EMAIL;
      DataSet.FieldByName('CLIENTE').AsString   := CLIENTE;
      DataSet.FieldByName('FORNECEDOR').AsString   := FORNECEDOR;
      DataSet.FieldByName('TRANSPORTADORA').AsString   := TRANSPORTADORA;
      DataSet.FieldByName('COLABORADOR').AsString   := COLABORADOR;
      DataSet.FieldByName('CONTADOR').AsString   := CONTADOR;

      DataSet.Post;
      ServerMethodDM.Server_FDConnection.Commit;

      // pessoa física
      ParPF := Jobj.Get(12);
      PessoaFisicaJSON := TJsonObject(ParPF.JsonValue);
      if PessoaFisicaJSON.TryGetValue('ID', ID) then
      begin
        DataSetPF.Close;
        DataSetPF.Macros[0].AsRaw := ' WHERE ID = ' + ID.ToString;
        DataSetPF.Open;

        DataSetPF.FieldByName('ID').Required := False;

        if DataSetPF.IsEmpty then
          DataSetPF.Append
        else
          DataSetPF.Edit;

        PessoaFisicaJSON.TryGetValue('CPF', CPF);
        PessoaFisicaJSON.TryGetValue('RG', RG);

        DataSetPF.FieldByName('CPF').AsString  := CPF;
        DataSetPF.FieldByName('RG').AsString   := RG;

        DataSetPF.Post;
        ServerMethodDM.Server_FDConnection.Commit;
      end;

      // contatos
      ParContato := Jobj.Get(10);
      ContatoJSON := TJsonObject(TJsonObject(ParContato.JsonValue).Get(0));
      if ContatoJSON.TryGetValue('ID', ID) then
      begin
        DataSetContatos.Close;
        DataSetContatos.Macros[0].AsRaw := ' WHERE ID = ' + ID.ToString;
        DataSetContatos.Open;

        DataSetContatos.FieldByName('ID').Required := False;

        if DataSetContatos.IsEmpty then
          DataSetContatos.Append
        else
          DataSetContatos.Edit;

        ContatoJSON.TryGetValue('NOME', NOME);
        ContatoJSON.TryGetValue('EMAIL', EMAIL);

        DataSetContatos.FieldByName('NOME').AsString  := NOME;
        DataSetContatos.FieldByName('EMAIL').AsString   := EMAIL;

        DataSetContatos.Post;
        ServerMethodDM.Server_FDConnection.Commit;
      end;

      Result := True;
    finally
      DataSet.Free;
      DataSetPF.Free;
      DataSetContatos.Free;
    end;
  end;
end;

class function TPessoaController.Excluir(pId: Integer): Boolean;
var
  DataSet: TFDQuery;
begin
  Result := False;

  DataSet := TFDQuery.Create(nil);
  DataSet.SQL.Add('SELECT * FROM PESSOA !WHERE');
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

