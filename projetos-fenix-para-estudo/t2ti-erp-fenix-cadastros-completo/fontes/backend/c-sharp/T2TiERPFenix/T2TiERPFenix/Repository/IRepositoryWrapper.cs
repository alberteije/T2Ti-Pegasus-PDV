namespace T2TiERPFenix.Repository
{
    public interface IRepositoryWrapper
    {
		ICargoRepository Cargo { get; }
		IBancoRepository Banco { get; }
        IBancoAgenciaRepository BancoAgencia { get; }
        IPessoaRepository Pessoa { get; }
        IProdutoRepository Produto { get; }
        IEstadoCivilRepository EstadoCivil { get; }
        INivelFormacaoRepository NivelFormacao { get; }
        IProdutoUnidadeRepository ProdutoUnidade { get; }
        IProdutoSubgrupoRepository ProdutoSubgrupo { get; }
        IProdutoMarcaRepository ProdutoMarca { get; }
        IProdutoGrupoRepository ProdutoGrupo { get; }
		IBancoContaCaixaRepository BancoContaCaixa { get; }
		ICepRepository Cep { get; }
		ICfopRepository Cfop { get; }
		IClienteRepository Cliente { get; }
		ICnaeRepository Cnae { get; }
		IColaboradorRepository Colaborador { get; }
		IContadorRepository Contador { get; }
		ICsosnRepository Csosn { get; }
		ICstCofinsRepository CstCofins { get; }
		ICstIcmsRepository CstIcms { get; }
		ICstIpiRepository CstIpi { get; }
		ICstPisRepository CstPis { get; }
		IFornecedorRepository Fornecedor { get; }
		IMunicipioRepository Municipio { get; }
		INcmRepository Ncm { get; }
		ISetorRepository Setor { get; }
		ITransportadoraRepository Transportadora { get; }
		IUfRepository Uf { get; }
		IUsuarioRepository Usuario { get; }
		IVendedorRepository Vendedor { get; }
		IPapelRepository Papel { get; }
		IFinChequeEmitidoRepository FinChequeEmitido { get; }
		IFinChequeRecebidoRepository FinChequeRecebido { get; }
		IFinConfiguracaoBoletoRepository FinConfiguracaoBoleto { get; }
		IFinExtratoContaBancoRepository FinExtratoContaBanco { get; }
		IFinDocumentoOrigemRepository FinDocumentoOrigem { get; }
		IFinFechamentoCaixaBancoRepository FinFechamentoCaixaBanco { get; }
		IFinLancamentoPagarRepository FinLancamentoPagar { get; }
		IFinLancamentoReceberRepository FinLancamentoReceber { get; }
		IFinNaturezaFinanceiraRepository FinNaturezaFinanceira { get; }
		IFinStatusParcelaRepository FinStatusParcela { get; }
		IFinTipoPagamentoRepository FinTipoPagamento { get; }
		IFinTipoRecebimentoRepository FinTipoRecebimento { get; }
		ITalonarioChequeRepository TalonarioCheque { get; }
		IViewPessoaColaboradorRepository ViewPessoaColaborador { get; }

		
		
	}

}
