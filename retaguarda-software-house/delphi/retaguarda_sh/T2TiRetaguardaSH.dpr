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
  AcbrMonitorPortaService in 'Service\Cadastros\AcbrMonitorPortaService.pas',
  AcbrMonitorController in 'Controller\ACBr\AcbrMonitorController.pas',
  AcbrMonitorService in 'Service\ACBr\AcbrMonitorService.pas',
  ObjetoNfe in 'Model\Transiente\ObjetoNfe.pas',
  ObjetoPdvConfiguracao in 'Model\Transiente\ObjetoPdvConfiguracao.pas',
  Cliente in 'Model\Sincroniza\Cliente.pas',
  Colaborador in 'Model\Sincroniza\Colaborador.pas',
  CompraPedidoCabecalho in 'Model\Sincroniza\CompraPedidoCabecalho.pas',
  CompraPedidoDetalhe in 'Model\Sincroniza\CompraPedidoDetalhe.pas',
  ContasPagar in 'Model\Sincroniza\ContasPagar.pas',
  ContasReceber in 'Model\Sincroniza\ContasReceber.pas',
  Fornecedor in 'Model\Sincroniza\Fornecedor.pas',
  ObjetoSincroniza in 'Model\Sincroniza\ObjetoSincroniza.pas',
  PdvTipoPagamento in 'Model\Sincroniza\PdvTipoPagamento.pas',
  Produto in 'Model\Sincroniza\Produto.pas',
  ProdutoFichaTecnica in 'Model\Sincroniza\ProdutoFichaTecnica.pas',
  ProdutoGrupo in 'Model\Sincroniza\ProdutoGrupo.pas',
  ProdutoImagem in 'Model\Sincroniza\ProdutoImagem.pas',
  ProdutoPromocao in 'Model\Sincroniza\ProdutoPromocao.pas',
  ProdutoSubgrupo in 'Model\Sincroniza\ProdutoSubgrupo.pas',
  ProdutoTipo in 'Model\Sincroniza\ProdutoTipo.pas',
  ProdutoUnidade in 'Model\Sincroniza\ProdutoUnidade.pas',
  TributCofins in 'Model\Sincroniza\TributCofins.pas',
  TributConfiguraOfGt in 'Model\Sincroniza\TributConfiguraOfGt.pas',
  TributGrupoTributario in 'Model\Sincroniza\TributGrupoTributario.pas',
  TributIcmsCustomCab in 'Model\Sincroniza\TributIcmsCustomCab.pas',
  TributIcmsCustomDet in 'Model\Sincroniza\TributIcmsCustomDet.pas',
  TributIcmsUf in 'Model\Sincroniza\TributIcmsUf.pas',
  TributIpi in 'Model\Sincroniza\TributIpi.pas',
  TributIss in 'Model\Sincroniza\TributIss.pas',
  TributOperacaoFiscal in 'Model\Sincroniza\TributOperacaoFiscal.pas',
  TributPis in 'Model\Sincroniza\TributPis.pas',
  SincronizaController in 'Controller\Sincroniza\SincronizaController.pas',
  SincronizaService in 'Service\Sincroniza\SincronizaService.pas';

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
