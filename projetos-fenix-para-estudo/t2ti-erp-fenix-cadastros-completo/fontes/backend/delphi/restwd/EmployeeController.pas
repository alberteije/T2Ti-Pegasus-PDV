unit EmployeeController;

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
  TEmployeeController = class
    private
    protected
    public
      class function Consultar(pFiltro: string): string;
      class function Persistir(pObjeto: string): Boolean;
      class function Excluir(pId: Integer): Boolean;
  end;

implementation

{ TEmployeeController }

uses uDmService;

class function TEmployeeController.Consultar(pFiltro: string): string;
var
  JSONValue: TJSONValue;
  DataSet: TFDQuery;
begin
  JSONValue := TJSONValue.Create;
  DataSet := TFDQuery.Create(nil);
  DataSet.SQL.Add('SELECT * FROM EMPLOYEE !WHERE');
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

class function TEmployeeController.Persistir(pObjeto: string): Boolean;
var
  JObj: TJSONObject;
  DataSet: TFDQuery;

//  Employee: TEmployee;

  EMP_NO: Integer;
  FIRST_NAME, LAST_NAME, PHONE_EXT: string;
  SALARY: Currency;
begin
  Result := False;

  DataSet := TFDQuery.Create(nil);
  DataSet.SQL.Add('SELECT * FROM EMPLOYEE !WHERE');
  DataSet.Connection := ServerMethodDM.Server_FDConnection;

  JObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(pObjeto), 0) as TJSONObject;
  if Jobj.TryGetValue('EMP_NO', EMP_NO) then
  begin
    try
      DataSet.Close;
      DataSet.Macros[0].AsRaw := ' WHERE EMP_NO = ' + EMP_NO.ToString;
      DataSet.Open;

      DataSet.FieldByName('EMP_NO').Required := False;
      DataSet.FieldByName('HIRE_DATE').Required := False;

      if DataSet.IsEmpty then
        DataSet.Append
      else
        DataSet.Edit;

      Jobj.TryGetValue('FIRST_NAME', FIRST_NAME);
      Jobj.TryGetValue('LAST_NAME', LAST_NAME);
      Jobj.TryGetValue('PHONE_EXT', PHONE_EXT);
      Jobj.TryGetValue('SALARY', SALARY);

      DataSet.FieldByName('FIRST_NAME').AsString  := FIRST_NAME;
      DataSet.FieldByName('LAST_NAME').AsString   := LAST_NAME;
      DataSet.FieldByName('PHONE_EXT').AsString   := PHONE_EXT;

      if DataSet.State = dsInsert then
      begin
        DataSet.FieldByName('DEPT_NO').AsString     := '600';
        DataSet.FieldByName('JOB_CODE').AsString    := 'VP';
        DataSet.FieldByName('JOB_GRADE').AsInteger  := 2;
        DataSet.FieldByName('JOB_COUNTRY').AsString := 'USA';
      end;

      DataSet.FieldByName('SALARY').AsCurrency      := SALARY;
      DataSet.Post;
      ServerMethodDM.Server_FDConnection.Commit;

      Result := True;
    finally
      DataSet.Free;
    end;
  end;
end;

class function TEmployeeController.Excluir(pId: Integer): Boolean;
var
  DataSet: TFDQuery;
begin
  Result := False;

  DataSet := TFDQuery.Create(nil);
  DataSet.SQL.Add('SELECT * FROM EMPLOYEE !WHERE');
  DataSet.Connection := ServerMethodDM.Server_FDConnection;

  try
    DataSet.Close;
    DataSet.Macros[0].AsRaw := ' WHERE EMP_NO = ' + pId.ToString;
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
