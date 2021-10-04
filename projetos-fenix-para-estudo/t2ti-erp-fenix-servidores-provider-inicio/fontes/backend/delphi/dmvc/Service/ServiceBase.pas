unit ServiceBase;

interface

uses
  System.SysUtils, UDataModuleConexao, FireDAC.Comp.Client;

type

  TServiceBase = class
  public
    class var FDataModule: TFDataModuleConexao;
    class function GetDataModule: TFDataModuleConexao;
  end;

var
  Query: TFDQuery;
  UpdateSQL: TFDUpdateSQL;

implementation

{ TServiceBase }

class function TServiceBase.GetDataModule: TFDataModuleConexao;
begin
  if not Assigned(FDataModuleConexao) then
    FDataModule := TFDataModuleConexao.Create(nil);
  Result := FDataModule;
end;

end.
