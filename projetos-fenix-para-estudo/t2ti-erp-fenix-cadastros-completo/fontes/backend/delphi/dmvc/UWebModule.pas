unit UWebModule;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, mvcframework;

type
  TFWebModule = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
  private
    FEngine: TMVCEngine;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TFWebModule;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses BancoController,
  BancoAgenciaController,
  PessoaController,
  ProdutoController,
  ProdutoGrupoController,
  ProdutoSubgrupoController,
  ProdutoMarcaController,
  ProdutoUnidadeController,
  EstadoCivilController,
  NivelFormacaoController,
  CargoController,
  BancoContaCaixaController,
  CepController,
  CfopController,
  ClienteController,
  CnaeController,
  ColaboradorController,
  ContadorController,
  CsosnController,
  CstCofinsController,
  CstIcmsController,
  CstIpiController,
  CstPisController,
  FornecedorController,
  MunicipioController,
  NcmController,
  SetorController,
  TransportadoraController,
  UfController,
  UsuarioController,
  VendedorController,
  PapelController,
  FinChequeEmitidoController,
  FinChequeRecebidoController,
  FinConfiguracaoBoletoController,
  FinDocumentoOrigemController,
  FinExtratoContaBancoController,
  FinFechamentoCaixaBancoController,
  FinLancamentoPagarController,
  FinLancamentoReceberController,
  FinNaturezaFinanceiraController,
  FinStatusParcelaController,
  FinTipoPagamentoController,
  FinTipoRecebimentoController,
  TalonarioChequeController,
  ViewPessoaColaboradorController,
  
  MVCFramework.Middleware.CORS, MVCFramework.Middleware.Compression;

{$R *.dfm}

procedure TFWebModule.WebModuleCreate(Sender: TObject);
begin
  FEngine := TMVCEngine.Create(self);

  FEngine.AddController(TBancoController);
  FEngine.AddController(TBancoAgenciaController);
  FEngine.AddController(TPessoaController);
  FEngine.AddController(TProdutoController);
  FEngine.AddController(TProdutoGrupoController);
  FEngine.AddController(TProdutoSubgrupoController);
  FEngine.AddController(TProdutoMarcaController);
  FEngine.AddController(TProdutoUnidadeController);
  FEngine.AddController(TEstadoCivilController);
  FEngine.AddController(TNivelFormacaoController);
  FEngine.AddController(TCargoController);
  FEngine.AddMiddleware(TCORSMiddleware.Create);
  FEngine.AddController(TBancoContaCaixaController);
  FEngine.AddController(TCepController);
  FEngine.AddController(TCfopController);
  FEngine.AddController(TClienteController);
  FEngine.AddController(TCnaeController);
  FEngine.AddController(TColaboradorController);
  FEngine.AddController(TContadorController);
  FEngine.AddController(TCsosnController);
  FEngine.AddController(TCstCofinsController);
  FEngine.AddController(TCstIcmsController);
  FEngine.AddController(TCstIpiController);
  FEngine.AddController(TCstPisController);
  FEngine.AddController(TFornecedorController);
  FEngine.AddController(TMunicipioController);
  FEngine.AddController(TNcmController);
  FEngine.AddController(TSetorController);
  FEngine.AddController(TTransportadoraController);
  FEngine.AddController(TUfController);
  FEngine.AddController(TUsuarioController);
  FEngine.AddController(TVendedorController);
  FEngine.AddController(TPapelController);
  FEngine.AddController(TFinChequeEmitidoController);
  FEngine.AddController(TFinChequeRecebidoController);
  FEngine.AddController(TFinConfiguracaoBoletoController);
  FEngine.AddController(TFinDocumentoOrigemController);
  FEngine.AddController(TFinExtratoContaBancoController);
  FEngine.AddController(TFinFechamentoCaixaBancoController);
  FEngine.AddController(TFinLancamentoPagarController);
  FEngine.AddController(TFinLancamentoReceberController);
  FEngine.AddController(TFinNaturezaFinanceiraController);
  FEngine.AddController(TFinStatusParcelaController);
  FEngine.AddController(TFinTipoPagamentoController);
  FEngine.AddController(TFinTipoRecebimentoController);
  FEngine.AddController(TTalonarioChequeController);
  FEngine.AddController(TViewPessoaColaboradorController);

  FEngine.AddMiddleware(TMVCCompressionMiddleware.Create(256));

end;

end.
