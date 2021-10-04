program T2TiERPFenix;

{$APPTYPE CONSOLE}


uses
  System.SysUtils,
  IdHTTPWebBrokerBridge,
  Web.WebReq,
  Web.WebBroker,
  UWebModule in 'UWebModule.pas' {FWebModule: TWebModule},
  UDataModuleConexao in 'UDataModuleConexao.pas' {FDataModuleConexao: TDataModule},
  ModelBase in 'Model\ModelBase.pas',
  ServiceBase in 'Service\ServiceBase.pas',
  Filtro in 'Model\Transiente\Filtro.pas',
  Commons in 'Commons.pas',
  BancoAgenciaController in 'Controller\Cadastros\BancoAgenciaController.pas',
  BancoContaCaixaController in 'Controller\Cadastros\BancoContaCaixaController.pas',
  BancoController in 'Controller\Cadastros\BancoController.pas',
  CargoController in 'Controller\Cadastros\CargoController.pas',
  CepController in 'Controller\Cadastros\CepController.pas',
  CfopController in 'Controller\Cadastros\CfopController.pas',
  ClienteController in 'Controller\Cadastros\ClienteController.pas',
  CnaeController in 'Controller\Cadastros\CnaeController.pas',
  ColaboradorController in 'Controller\Cadastros\ColaboradorController.pas',
  ContadorController in 'Controller\Cadastros\ContadorController.pas',
  CsosnController in 'Controller\Cadastros\CsosnController.pas',
  CstCofinsController in 'Controller\Cadastros\CstCofinsController.pas',
  CstIcmsController in 'Controller\Cadastros\CstIcmsController.pas',
  CstIpiController in 'Controller\Cadastros\CstIpiController.pas',
  CstPisController in 'Controller\Cadastros\CstPisController.pas',
  EstadoCivilController in 'Controller\Cadastros\EstadoCivilController.pas',
  FornecedorController in 'Controller\Cadastros\FornecedorController.pas',
  MunicipioController in 'Controller\Cadastros\MunicipioController.pas',
  NcmController in 'Controller\Cadastros\NcmController.pas',
  NivelFormacaoController in 'Controller\Cadastros\NivelFormacaoController.pas',
  PessoaController in 'Controller\Cadastros\PessoaController.pas',
  ProdutoController in 'Controller\Cadastros\ProdutoController.pas',
  ProdutoGrupoController in 'Controller\Cadastros\ProdutoGrupoController.pas',
  ProdutoMarcaController in 'Controller\Cadastros\ProdutoMarcaController.pas',
  ProdutoSubgrupoController in 'Controller\Cadastros\ProdutoSubgrupoController.pas',
  ProdutoUnidadeController in 'Controller\Cadastros\ProdutoUnidadeController.pas',
  SetorController in 'Controller\Cadastros\SetorController.pas',
  TransportadoraController in 'Controller\Cadastros\TransportadoraController.pas',
  UfController in 'Controller\Cadastros\UfController.pas',
  UsuarioController in 'Controller\Cadastros\UsuarioController.pas',
  VendedorController in 'Controller\Cadastros\VendedorController.pas',
  Banco in 'Model\Cadastros\Banco.pas',
  BancoAgencia in 'Model\Cadastros\BancoAgencia.pas',
  BancoContaCaixa in 'Model\Cadastros\BancoContaCaixa.pas',
  Cargo in 'Model\Cadastros\Cargo.pas',
  Cep in 'Model\Cadastros\Cep.pas',
  Cfop in 'Model\Cadastros\Cfop.pas',
  Cliente in 'Model\Cadastros\Cliente.pas',
  Cnae in 'Model\Cadastros\Cnae.pas',
  Colaborador in 'Model\Cadastros\Colaborador.pas',
  Contador in 'Model\Cadastros\Contador.pas',
  Csosn in 'Model\Cadastros\Csosn.pas',
  CstCofins in 'Model\Cadastros\CstCofins.pas',
  CstIcms in 'Model\Cadastros\CstIcms.pas',
  CstIpi in 'Model\Cadastros\CstIpi.pas',
  CstPis in 'Model\Cadastros\CstPis.pas',
  EstadoCivil in 'Model\Cadastros\EstadoCivil.pas',
  Fornecedor in 'Model\Cadastros\Fornecedor.pas',
  Municipio in 'Model\Cadastros\Municipio.pas',
  Ncm in 'Model\Cadastros\Ncm.pas',
  NivelFormacao in 'Model\Cadastros\NivelFormacao.pas',
  Pessoa in 'Model\Cadastros\Pessoa.pas',
  PessoaContato in 'Model\Cadastros\PessoaContato.pas',
  PessoaEndereco in 'Model\Cadastros\PessoaEndereco.pas',
  PessoaFisica in 'Model\Cadastros\PessoaFisica.pas',
  PessoaJuridica in 'Model\Cadastros\PessoaJuridica.pas',
  PessoaTelefone in 'Model\Cadastros\PessoaTelefone.pas',
  Produto in 'Model\Cadastros\Produto.pas',
  ProdutoGrupo in 'Model\Cadastros\ProdutoGrupo.pas',
  ProdutoMarca in 'Model\Cadastros\ProdutoMarca.pas',
  ProdutoSubgrupo in 'Model\Cadastros\ProdutoSubgrupo.pas',
  ProdutoUnidade in 'Model\Cadastros\ProdutoUnidade.pas',
  Setor in 'Model\Cadastros\Setor.pas',
  Transportadora in 'Model\Cadastros\Transportadora.pas',
  Uf in 'Model\Cadastros\Uf.pas',
  Usuario in 'Model\Cadastros\Usuario.pas',
  Vendedor in 'Model\Cadastros\Vendedor.pas',
  BancoAgenciaService in 'Service\Cadastros\BancoAgenciaService.pas',
  BancoContaCaixaService in 'Service\Cadastros\BancoContaCaixaService.pas',
  BancoService in 'Service\Cadastros\BancoService.pas',
  CargoService in 'Service\Cadastros\CargoService.pas',
  CepService in 'Service\Cadastros\CepService.pas',
  CfopService in 'Service\Cadastros\CfopService.pas',
  ClienteService in 'Service\Cadastros\ClienteService.pas',
  CnaeService in 'Service\Cadastros\CnaeService.pas',
  ColaboradorService in 'Service\Cadastros\ColaboradorService.pas',
  ContadorService in 'Service\Cadastros\ContadorService.pas',
  CsosnService in 'Service\Cadastros\CsosnService.pas',
  CstCofinsService in 'Service\Cadastros\CstCofinsService.pas',
  CstIcmsService in 'Service\Cadastros\CstIcmsService.pas',
  CstIpiService in 'Service\Cadastros\CstIpiService.pas',
  CstPisService in 'Service\Cadastros\CstPisService.pas',
  EstadoCivilService in 'Service\Cadastros\EstadoCivilService.pas',
  FornecedorService in 'Service\Cadastros\FornecedorService.pas',
  MunicipioService in 'Service\Cadastros\MunicipioService.pas',
  NcmService in 'Service\Cadastros\NcmService.pas',
  NivelFormacaoService in 'Service\Cadastros\NivelFormacaoService.pas',
  PessoaService in 'Service\Cadastros\PessoaService.pas',
  ProdutoGrupoService in 'Service\Cadastros\ProdutoGrupoService.pas',
  ProdutoMarcaService in 'Service\Cadastros\ProdutoMarcaService.pas',
  ProdutoService in 'Service\Cadastros\ProdutoService.pas',
  ProdutoSubgrupoService in 'Service\Cadastros\ProdutoSubgrupoService.pas',
  ProdutoUnidadeService in 'Service\Cadastros\ProdutoUnidadeService.pas',
  SetorService in 'Service\Cadastros\SetorService.pas',
  TransportadoraService in 'Service\Cadastros\TransportadoraService.pas',
  UfService in 'Service\Cadastros\UfService.pas',
  UsuarioService in 'Service\Cadastros\UsuarioService.pas',
  VendedorService in 'Service\Cadastros\VendedorService.pas',
  Papel in 'Model\Cadastros\Papel.pas',
  PapelController in 'Controller\Cadastros\PapelController.pas',
  PapelService in 'Service\Cadastros\PapelService.pas',
  FinChequeEmitidoController in 'Controller\Financeiro\FinChequeEmitidoController.pas',
  FinChequeRecebidoController in 'Controller\Financeiro\FinChequeRecebidoController.pas',
  FinConfiguracaoBoletoController in 'Controller\Financeiro\FinConfiguracaoBoletoController.pas',
  FinDocumentoOrigemController in 'Controller\Financeiro\FinDocumentoOrigemController.pas',
  FinExtratoContaBancoController in 'Controller\Financeiro\FinExtratoContaBancoController.pas',
  FinFechamentoCaixaBancoController in 'Controller\Financeiro\FinFechamentoCaixaBancoController.pas',
  FinLancamentoPagarController in 'Controller\Financeiro\FinLancamentoPagarController.pas',
  FinLancamentoReceberController in 'Controller\Financeiro\FinLancamentoReceberController.pas',
  FinNaturezaFinanceiraController in 'Controller\Financeiro\FinNaturezaFinanceiraController.pas',
  FinStatusParcelaController in 'Controller\Financeiro\FinStatusParcelaController.pas',
  FinTipoPagamentoController in 'Controller\Financeiro\FinTipoPagamentoController.pas',
  FinTipoRecebimentoController in 'Controller\Financeiro\FinTipoRecebimentoController.pas',
  TalonarioChequeController in 'Controller\Financeiro\TalonarioChequeController.pas',
  Cheque in 'Model\Financeiro\Cheque.pas',
  FinChequeEmitido in 'Model\Financeiro\FinChequeEmitido.pas',
  FinChequeRecebido in 'Model\Financeiro\FinChequeRecebido.pas',
  FinConfiguracaoBoleto in 'Model\Financeiro\FinConfiguracaoBoleto.pas',
  FinDocumentoOrigem in 'Model\Financeiro\FinDocumentoOrigem.pas',
  FinExtratoContaBanco in 'Model\Financeiro\FinExtratoContaBanco.pas',
  FinFechamentoCaixaBanco in 'Model\Financeiro\FinFechamentoCaixaBanco.pas',
  FinLancamentoPagar in 'Model\Financeiro\FinLancamentoPagar.pas',
  FinLancamentoReceber in 'Model\Financeiro\FinLancamentoReceber.pas',
  FinNaturezaFinanceira in 'Model\Financeiro\FinNaturezaFinanceira.pas',
  FinParcelaPagar in 'Model\Financeiro\FinParcelaPagar.pas',
  FinParcelaReceber in 'Model\Financeiro\FinParcelaReceber.pas',
  FinStatusParcela in 'Model\Financeiro\FinStatusParcela.pas',
  FinTipoPagamento in 'Model\Financeiro\FinTipoPagamento.pas',
  FinTipoRecebimento in 'Model\Financeiro\FinTipoRecebimento.pas',
  TalonarioCheque in 'Model\Financeiro\TalonarioCheque.pas',
  FinChequeEmitidoService in 'Service\Financeiro\FinChequeEmitidoService.pas',
  FinChequeRecebidoService in 'Service\Financeiro\FinChequeRecebidoService.pas',
  FinConfiguracaoBoletoService in 'Service\Financeiro\FinConfiguracaoBoletoService.pas',
  FinDocumentoOrigemService in 'Service\Financeiro\FinDocumentoOrigemService.pas',
  FinExtratoContaBancoService in 'Service\Financeiro\FinExtratoContaBancoService.pas',
  FinFechamentoCaixaBancoService in 'Service\Financeiro\FinFechamentoCaixaBancoService.pas',
  FinLancamentoPagarService in 'Service\Financeiro\FinLancamentoPagarService.pas',
  FinLancamentoReceberService in 'Service\Financeiro\FinLancamentoReceberService.pas',
  FinNaturezaFinanceiraService in 'Service\Financeiro\FinNaturezaFinanceiraService.pas',
  FinStatusParcelaService in 'Service\Financeiro\FinStatusParcelaService.pas',
  FinTipoPagamentoService in 'Service\Financeiro\FinTipoPagamentoService.pas',
  FinTipoRecebimentoService in 'Service\Financeiro\FinTipoRecebimentoService.pas',
  TalonarioChequeService in 'Service\Financeiro\TalonarioChequeService.pas',
  ViewPessoaColaboradorController in 'Controller\ViewsDB\ViewPessoaColaboradorController.pas',
  ViewPessoaColaborador in 'Model\ViewsDB\ViewPessoaColaborador.pas',
  ViewPessoaColaboradorService in 'Service\ViewsDB\ViewPessoaColaboradorService.pas';

{$R *.res}


procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
begin
  WriteLn('T2Ti ERP Fenix - versão 0.0.1 - DMVC');
  WriteLn(Format('Servidor iniciado na porta %d', [APort]));
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    FormatSettings.DecimalSeparator := '.';
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
