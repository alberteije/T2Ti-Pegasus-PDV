program T2TiRetaguardaSH;

{$APPTYPE CONSOLE}


uses
  System.SysUtils,
  IdHTTPWebBrokerBridge,
  Web.WebReq,
  Web.WebBroker,
  Commons in 'Commons.pas',
  UAuthCriteria in 'UAuthCriteria.pas',
  UDataModuleConexao in 'UDataModuleConexao.pas' {FDataModuleConexao: TDataModule},
  UWebModule in 'UWebModule.pas' {FWebModule: TWebModule},
  EmpresaController in 'Controller\Cadastros\EmpresaController.pas',
  NfeConfiguracaoController in 'Controller\NFe\NfeConfiguracaoController.pas',
  PdvPlanoPagamentoController in 'Controller\PDV\PdvPlanoPagamentoController.pas',
  PdvTipoPlanoController in 'Controller\PDV\PdvTipoPlanoController.pas',
  Empresa in 'Model\Cadastros\Empresa.pas',
  ModelBase in 'Model\ModelBase.pas',
  PdvPlanoPagamento in 'Model\PDV\PdvPlanoPagamento.pas',
  PdvTipoPlano in 'Model\PDV\PdvTipoPlano.pas',
  NfeConfiguracao in 'Model\NFe\NfeConfiguracao.pas',
  ServiceBase in 'Service\ServiceBase.pas',
  EmpresaService in 'Service\Cadastros\EmpresaService.pas',
  NfeConfiguracaoService in 'Service\NFe\NfeConfiguracaoService.pas',
  PdvPlanoPagamentoService in 'Service\PDV\PdvPlanoPagamentoService.pas',
  PdvTipoPlanoService in 'Service\PDV\PdvTipoPlanoService.pas',
  Biblioteca in 'Util\Biblioteca.pas',
  Constantes in 'Util\Constantes.pas',
  Filtro in 'Model\Transiente\Filtro.pas',
  ObjetoPagSeguro in 'Model\Transiente\ObjetoPagSeguro.pas',
  AcbrMonitorPortaController in 'Controller\Cadastros\AcbrMonitorPortaController.pas',
  AcbrMonitorPorta in 'Model\Cadastros\AcbrMonitorPorta.pas',
  AcbrMonitorPortaService in 'Service\Cadastros\AcbrMonitorPortaService.pas';

{$R *.res}


procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
begin
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
//    FDataModule := TFDataModule.Create(nil);
    TConstantes.Create;
    FormatSettings.DecimalSeparator := '.';
    LServer.DefaultPort := StrToInt(TConstantes.PORTA_SERVIDOR);
    LServer.MaxConnections := 1024;
    LServer.Active := True;
    WriteLn('Retaguarda SH - versão 0.0.1 - DMVC');
    WriteLn(Format('Servidor iniciado na porta %d', [StrToInt(TConstantes.PORTA_SERVIDOR)]));
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
    RunServer(8086);
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end

end.
