namespace T2TiERPFenix.Repository
{
    public class RepositoryWrapper : IRepositoryWrapper
    {
        private RepositoryContext _repoContext;

		private ICargoRepository _cargo;
		public ICargoRepository Cargo
		{
			get
			{
				if (_cargo == null)
				{
					_cargo = new CargoRepository(_repoContext);
				}

				return _cargo;
			}
		}

		private IBancoRepository _banco;
        public IBancoRepository Banco
        {
            get
            {
                if (_banco == null)
                {
                    _banco = new BancoRepository(_repoContext);
                }

                return _banco;
            }
        }

        private IBancoAgenciaRepository _bancoAgencia;
        public IBancoAgenciaRepository BancoAgencia
        {
            get
            {
                if (_bancoAgencia == null)
                {
                    _bancoAgencia = new BancoAgenciaRepository(_repoContext);
                }

                return _bancoAgencia;
            }
        }

        private IPessoaRepository _pessoa;
        public IPessoaRepository Pessoa
        {
            get
            {
                if (_pessoa == null)
                {
                    _pessoa = new PessoaRepository(_repoContext);
                }

                return _pessoa;
            }
        }

        private IProdutoRepository _produto;
        public IProdutoRepository Produto
        {
            get
            {
                if (_produto == null)
                {
                    _produto = new ProdutoRepository(_repoContext);
                }

                return _produto;
            }
        }

        private IEstadoCivilRepository _estadoCivil;
        public IEstadoCivilRepository EstadoCivil
        {
            get
            {
                if (_estadoCivil == null)
                {
                    _estadoCivil = new EstadoCivilRepository(_repoContext);
                }

                return _estadoCivil;
            }
        }

        private INivelFormacaoRepository _nivelFormacao;
        public INivelFormacaoRepository NivelFormacao
        {
            get
            {
                if (_nivelFormacao == null)
                {
                    _nivelFormacao = new NivelFormacaoRepository(_repoContext);
                }

                return _nivelFormacao;
            }
        }

        private IProdutoUnidadeRepository _produtoUnidade;
        public IProdutoUnidadeRepository ProdutoUnidade
        {
            get
            {
                if (_produtoUnidade == null)
                {
                    _produtoUnidade = new ProdutoUnidadeRepository(_repoContext);
                }

                return _produtoUnidade;
            }
        }

        private IProdutoSubgrupoRepository _produtoSubgrupo;
        public IProdutoSubgrupoRepository ProdutoSubgrupo
        {
            get
            {
                if (_produtoSubgrupo == null)
                {
                    _produtoSubgrupo = new ProdutoSubgrupoRepository(_repoContext);
                }

                return _produtoSubgrupo;
            }
        }

        private IProdutoMarcaRepository _produtoMarca;
        public IProdutoMarcaRepository ProdutoMarca
        {
            get
            {
                if (_produtoMarca == null)
                {
                    _produtoMarca = new ProdutoMarcaRepository(_repoContext);
                }

                return _produtoMarca;
            }
        }
        
        private IProdutoGrupoRepository _produtoGrupo;
        public IProdutoGrupoRepository ProdutoGrupo
        {
            get
            {
                if (_produtoGrupo == null)
                {
                    _produtoGrupo = new ProdutoGrupoRepository(_repoContext);
                }

                return _produtoGrupo;
            }
        }

		private IBancoContaCaixaRepository _bancoContaCaixa;
		public IBancoContaCaixaRepository BancoContaCaixa
		{
			get
			{
				if (_bancoContaCaixa == null)
				{
					_bancoContaCaixa = new BancoContaCaixaRepository(_repoContext);
				}

				return _bancoContaCaixa;
			}
		}

		private ICepRepository _cep;
		public ICepRepository Cep
		{
			get
			{
				if (_cep == null)
				{
					_cep = new CepRepository(_repoContext);
				}

				return _cep;
			}
		}

		private ICfopRepository _cfop;
		public ICfopRepository Cfop
		{
			get
			{
				if (_cfop == null)
				{
					_cfop = new CfopRepository(_repoContext);
				}

				return _cfop;
			}
		}

		private IClienteRepository _cliente;
		public IClienteRepository Cliente
		{
			get
			{
				if (_cliente == null)
				{
					_cliente = new ClienteRepository(_repoContext);
				}

				return _cliente;
			}
		}
		
		private ICnaeRepository _cnae;
		public ICnaeRepository Cnae
		{
			get
			{
				if (_cnae == null)
				{
					_cnae = new CnaeRepository(_repoContext);
				}

				return _cnae;
			}
		}

		private IColaboradorRepository _colaborador;
		public IColaboradorRepository Colaborador
		{
			get
			{
				if (_colaborador == null)
				{
					_colaborador = new ColaboradorRepository(_repoContext);
				}

				return _colaborador;
			}
		}

		private IContadorRepository _contador;
		public IContadorRepository Contador
		{
			get
			{
				if (_contador == null)
				{
					_contador = new ContadorRepository(_repoContext);
				}

				return _contador;
			}
		}

		private ICsosnRepository _csosn;
		public ICsosnRepository Csosn
		{
			get
			{
				if (_csosn == null)
				{
					_csosn = new CsosnRepository(_repoContext);
				}

				return _csosn;
			}
		}

		private ICstCofinsRepository _cstCofins;
		public ICstCofinsRepository CstCofins
		{
			get
			{
				if (_cstCofins == null)
				{
					_cstCofins = new CstCofinsRepository(_repoContext);
				}

				return _cstCofins;
			}
		}

		private ICstIcmsRepository _cstIcms;
		public ICstIcmsRepository CstIcms
		{
			get
			{
				if (_cstIcms == null)
				{
					_cstIcms = new CstIcmsRepository(_repoContext);
				}

				return _cstIcms;
			}
		}

		private ICstIpiRepository _cstIpi;
		public ICstIpiRepository CstIpi
		{
			get
			{
				if (_cstIpi == null)
				{
					_cstIpi = new CstIpiRepository(_repoContext);
				}

				return _cstIpi;
			}
		}
		
		private ICstPisRepository _cstPis;
		public ICstPisRepository CstPis
		{
			get
			{
				if (_cstPis == null)
				{
					_cstPis = new CstPisRepository(_repoContext);
				}

				return _cstPis;
			}
		}
		
		private IFornecedorRepository _fornecedor;
		public IFornecedorRepository Fornecedor
		{
			get
			{
				if (_fornecedor == null)
				{
					_fornecedor = new FornecedorRepository(_repoContext);
				}

				return _fornecedor;
			}
		}

		private IMunicipioRepository _municipio;
		public IMunicipioRepository Municipio
		{
			get
			{
				if (_municipio == null)
				{
					_municipio = new MunicipioRepository(_repoContext);
				}

				return _municipio;
			}
		}

		private INcmRepository _ncm;
		public INcmRepository Ncm
		{
			get
			{
				if (_ncm == null)
				{
					_ncm = new NcmRepository(_repoContext);
				}

				return _ncm;
			}
		}

		private ISetorRepository _setor;
		public ISetorRepository Setor
		{
			get
			{
				if (_setor == null)
				{
					_setor = new SetorRepository(_repoContext);
				}

				return _setor;
			}
		}

		private ITransportadoraRepository _transportadora;
		public ITransportadoraRepository Transportadora
		{
			get
			{
				if (_transportadora == null)
				{
					_transportadora = new TransportadoraRepository(_repoContext);
				}

				return _transportadora;
			}
		}

		private IUfRepository _uf;
		public IUfRepository Uf
		{
			get
			{
				if (_uf == null)
				{
					_uf = new UfRepository(_repoContext);
				}

				return _uf;
			}
		}

		private IUsuarioRepository _usuario;
		public IUsuarioRepository Usuario
		{
			get
			{
				if (_usuario == null)
				{
					_usuario = new UsuarioRepository(_repoContext);
				}

				return _usuario;
			}
		}

		private IVendedorRepository _vendedor;
		public IVendedorRepository Vendedor
		{
			get
			{
				if (_vendedor == null)
				{
					_vendedor = new VendedorRepository(_repoContext);
				}

				return _vendedor;
			}
		}

		private IPapelRepository _papel;
		public IPapelRepository Papel
		{
			get
			{
				if (_papel == null)
				{
					_papel = new PapelRepository(_repoContext);
				}

				return _papel;
			}
		}

		private IFinChequeEmitidoRepository _finChequeEmitido;
		public IFinChequeEmitidoRepository FinChequeEmitido
		{
			get
			{
				if (_finChequeEmitido == null)
				{
					_finChequeEmitido = new FinChequeEmitidoRepository(_repoContext);
				}

				return _finChequeEmitido;
			}
		}
			
		private IFinChequeRecebidoRepository _finChequeRecebido;
		public IFinChequeRecebidoRepository FinChequeRecebido
		{
			get
			{
				if (_finChequeRecebido == null)
				{
					_finChequeRecebido = new FinChequeRecebidoRepository(_repoContext);
				}

				return _finChequeRecebido;
			}
		}
		
		private IFinConfiguracaoBoletoRepository _finConfiguracaoBoleto;
		public IFinConfiguracaoBoletoRepository FinConfiguracaoBoleto
		{
			get
			{
				if (_finConfiguracaoBoleto == null)
				{
					_finConfiguracaoBoleto = new FinConfiguracaoBoletoRepository(_repoContext);
				}

				return _finConfiguracaoBoleto;
			}
		}
		
		private IFinExtratoContaBancoRepository _finExtratoContaBanco;
		public IFinExtratoContaBancoRepository FinExtratoContaBanco
		{
			get
			{
				if (_finExtratoContaBanco == null)
				{
					_finExtratoContaBanco = new FinExtratoContaBancoRepository(_repoContext);
				}

				return _finExtratoContaBanco;
			}
		}

		private IFinDocumentoOrigemRepository _finDocumentoOrigem;
		public IFinDocumentoOrigemRepository FinDocumentoOrigem
		{
			get
			{
				if (_finDocumentoOrigem == null)
				{
					_finDocumentoOrigem = new FinDocumentoOrigemRepository(_repoContext);
				}

				return _finDocumentoOrigem;
			}
		}

		private IFinFechamentoCaixaBancoRepository _finFechamentoCaixaBanco;
		public IFinFechamentoCaixaBancoRepository FinFechamentoCaixaBanco
		{
			get
			{
				if (_finFechamentoCaixaBanco == null)
				{
					_finFechamentoCaixaBanco = new FinFechamentoCaixaBancoRepository(_repoContext);
				}

				return _finFechamentoCaixaBanco;
			}
		}
		
		private IFinLancamentoPagarRepository _finLancamentoPagar;
		public IFinLancamentoPagarRepository FinLancamentoPagar
		{
			get
			{
				if (_finLancamentoPagar == null)
				{
					_finLancamentoPagar = new FinLancamentoPagarRepository(_repoContext);
				}

				return _finLancamentoPagar;
			}
		}
		
		private IFinLancamentoReceberRepository _finLancamentoReceber;
		public IFinLancamentoReceberRepository FinLancamentoReceber
		{
			get
			{
				if (_finLancamentoReceber == null)
				{
					_finLancamentoReceber = new FinLancamentoReceberRepository(_repoContext);
				}

				return _finLancamentoReceber;
			}
		}
		
		private IFinNaturezaFinanceiraRepository _finNaturezaFinanceira;
		public IFinNaturezaFinanceiraRepository FinNaturezaFinanceira
		{
			get
			{
				if (_finNaturezaFinanceira == null)
				{
					_finNaturezaFinanceira = new FinNaturezaFinanceiraRepository(_repoContext);
				}

				return _finNaturezaFinanceira;
			}
		}
		
		private IFinStatusParcelaRepository _finStatusParcela;
		public IFinStatusParcelaRepository FinStatusParcela
		{
			get
			{
				if (_finStatusParcela == null)
				{
					_finStatusParcela = new FinStatusParcelaRepository(_repoContext);
				}

				return _finStatusParcela;
			}
		}

		private IFinTipoPagamentoRepository _finTipoPagamento;
		public IFinTipoPagamentoRepository FinTipoPagamento
		{
			get
			{
				if (_finTipoPagamento == null)
				{
					_finTipoPagamento = new FinTipoPagamentoRepository(_repoContext);
				}

				return _finTipoPagamento;
			}
		}

		private IFinTipoRecebimentoRepository _finTipoRecebimento;
		public IFinTipoRecebimentoRepository FinTipoRecebimento
		{
			get
			{
				if (_finTipoRecebimento == null)
				{
					_finTipoRecebimento = new FinTipoRecebimentoRepository(_repoContext);
				}

				return _finTipoRecebimento;
			}
		}

		private ITalonarioChequeRepository _talonarioCheque;
		public ITalonarioChequeRepository TalonarioCheque
		{
			get
			{
				if (_talonarioCheque == null)
				{
					_talonarioCheque = new TalonarioChequeRepository(_repoContext);
				}

				return _talonarioCheque;
			}
		}

		private IFinParcelaPagarRepository _finParcelaPagar;
		public IFinParcelaPagarRepository FinParcelaPagar
		{
			get
			{
				if (_finParcelaPagar == null)
				{
					_finParcelaPagar = new FinParcelaPagarRepository(_repoContext);
				}

				return _finParcelaPagar;
			}
		}

		private IFinParcelaReceberRepository _finParcelaReceber;
		public IFinParcelaReceberRepository FinParcelaReceber
		{
			get
			{
				if (_finParcelaReceber == null)
				{
					_finParcelaReceber = new FinParcelaReceberRepository(_repoContext);
				}

				return _finParcelaReceber;
			}
		}


		
		
		
		



		private IViewPessoaColaboradorRepository _viewPessoaColaborador;
		public IViewPessoaColaboradorRepository ViewPessoaColaborador
		{
			get
			{
				if (_viewPessoaColaborador == null)
				{
					_viewPessoaColaborador = new ViewPessoaColaboradorRepository(_repoContext);
				}

				return _viewPessoaColaborador;
			}
		}

		private IViewFinLancamentoPagarRepository _viewFinLancamentoPagar;
		public IViewFinLancamentoPagarRepository ViewFinLancamentoPagar
		{
			get
			{
				if (_viewFinLancamentoPagar == null)
				{
					_viewFinLancamentoPagar = new ViewFinLancamentoPagarRepository(_repoContext);
				}

				return _viewFinLancamentoPagar;
			}
		}

		private IViewPessoaClienteRepository _viewPessoaCliente;
		public IViewPessoaClienteRepository ViewPessoaCliente
		{
			get
			{
				if (_viewPessoaCliente == null)
				{
					_viewPessoaCliente = new ViewPessoaClienteRepository(_repoContext);
				}

				return _viewPessoaCliente;
			}
		}

		private IViewPessoaFornecedorRepository _viewPessoaFornecedor;
		public IViewPessoaFornecedorRepository ViewPessoaFornecedor
		{
			get
			{
				if (_viewPessoaFornecedor == null)
				{
					_viewPessoaFornecedor = new ViewPessoaFornecedorRepository(_repoContext);
				}

				return _viewPessoaFornecedor;
			}
		}


		
		
		public RepositoryWrapper(RepositoryContext repositoryContext)
        {
            _repoContext = repositoryContext;
        }
    }
	
}
