program articles_crud;

{$APPTYPE CONSOLE}


uses
  System.SysUtils,
  IdHTTPWebBrokerBridge,
  Web.WebReq,
  Web.WebBroker,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  Controllers.Base in 'Controllers.Base.pas',
  Controllers.Articles in 'Controllers.Articles.pas',
  Services in 'Services.pas',
  BusinessObjects in 'BusinessObjects.pas',
  MainDM in 'MainDM.pas' {dmMain: TDataModule},
  Commons in 'Commons.pas',
  UDataModuleConexao in 'UDataModuleConexao.pas' {FDataModuleConexao: TDataModule},
  Banco in 'Model\Banco.pas',
  ModelBase in 'Model\ModelBase.pas',
  BancoController in 'Controller\BancoController.pas',
  BancoService in 'Service\BancoService.pas',
  ServiceBase in 'Service\ServiceBase.pas',
  Filtro in 'Model\Transiente\Filtro.pas';

{$R *.res}


procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
begin
  WriteLn('T2Ti ERP Fenix - versão 0.0.1 - DMVC');
  WriteLn(Format('Servidor iniciado na porta %d', [APort]));
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.DefaultPort := APort;
    LServer.MaxConnections := 1024;
    LServer.Active := True;
    WriteLn('Pressione ENTER para finalizar o servidor');
    ReadLn;
  finally
    LServer.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;
    RunServer(8085);
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end

end.
