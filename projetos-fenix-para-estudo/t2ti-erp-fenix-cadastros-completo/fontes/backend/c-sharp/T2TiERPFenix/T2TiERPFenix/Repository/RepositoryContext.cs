using Microsoft.EntityFrameworkCore;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public class RepositoryContext : DbContext
    {

        public RepositoryContext(DbContextOptions options)
                    : base(options)
        {
        }

        public DbSet<Cargo> Cargos { get; set; }
        public DbSet<Banco> Bancos { get; set; }
        public DbSet<BancoAgencia> BancoAgencias { get; set; }
        public DbSet<Pessoa> Pessoas { get; set; }
        public DbSet<Produto> Produtos { get; set; }
        public DbSet<EstadoCivil> EstadoCivils { get; set; }
        public DbSet<NivelFormacao> NivelFormacaos { get; set; }
        public DbSet<ProdutoGrupo> ProdutoGrupos { get; set; }
        public DbSet<ProdutoMarca> ProdutoMarcas { get; set; }
        public DbSet<ProdutoSubgrupo> ProdutoSubgrupos { get; set; }
        public DbSet<ProdutoUnidade> ProdutoUnidades { get; set; }
		public DbSet<BancoContaCaixa> BancoContaCaixas { get; set; }
		public DbSet<Cep> Ceps { get; set; }
		public DbSet<Cfop> Cfops { get; set; }
		public DbSet<Cliente> Clientes { get; set; }
		public DbSet<Cnae> Cnaes { get; set; }
		public DbSet<Colaborador> Colaboradors { get; set; }
		public DbSet<Contador> Contadors { get; set; }
		public DbSet<Csosn> Csosns { get; set; }
		public DbSet<CstCofins> CstCofinss { get; set; }
		public DbSet<CstIcms> CstIcmss { get; set; }
		public DbSet<CstIpi> CstIpis { get; set; }
		public DbSet<CstPis> CstPiss { get; set; }
		public DbSet<Fornecedor> Fornecedors { get; set; }
		public DbSet<Municipio> Municipios { get; set; }
		public DbSet<Ncm> Ncms { get; set; }
		public DbSet<Papel> Papels { get; set; }
		public DbSet<Setor> Setors { get; set; }
		public DbSet<Transportadora> Transportadoras { get; set; }
		public DbSet<Uf> Ufs { get; set; }
		public DbSet<Usuario> Usuarios { get; set; }
		public DbSet<Vendedor> Vendedors { get; set; }
		public DbSet<FinChequeEmitido> FinChequeEmitidos { get; set; }
		public DbSet<FinChequeRecebido> FinChequeRecebidos { get; set; }
		public DbSet<FinConfiguracaoBoleto> FinConfiguracaoBoletos { get; set; }
		public DbSet<FinExtratoContaBanco> FinExtratoContaBancos { get; set; }
		public DbSet<FinDocumentoOrigem> FinDocumentoOrigems { get; set; }
		public DbSet<FinFechamentoCaixaBanco> FinFechamentoCaixaBancos { get; set; }
		public DbSet<FinLancamentoPagar> FinLancamentoPagars { get; set; }
		public DbSet<FinLancamentoReceber> FinLancamentoRecebers { get; set; }
		public DbSet<FinNaturezaFinanceira> FinNaturezaFinanceiras { get; set; }
		public DbSet<FinStatusParcela> FinStatusParcelas { get; set; }
		public DbSet<FinTipoPagamento> FinTipoPagamentos { get; set; }
		public DbSet<FinTipoRecebimento> FinTipoRecebimentos { get; set; }
		public DbSet<TalonarioCheque> TalonarioCheques { get; set; }
		public DbSet<ViewPessoaColaborador> ViewPessoaColaboradors { get; set; }


	}
}
