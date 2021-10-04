namespace T2TiERPFenix.Repository
{
    public class RepositoryWrapper : IRepositoryWrapper
    {
        private RepositoryContext _repoContext;
        private ICargoRepository _cargo;
        private IBancoRepository _banco;
        private IPessoaRepository _pessoa;
        private IPessoaJuridicaRepository _pessoaJuridica;
        private IPessoaContatoRepository _pessoaContato;

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

        public IPessoaJuridicaRepository PessoaJuridica
        {
            get
            {
                if (_pessoaJuridica == null)
                {
                    _pessoaJuridica = new PessoaJuridicaRepository(_repoContext);
                }

                return _pessoaJuridica;
            }
        }

        public IPessoaContatoRepository PessoaContato
        {
            get
            {
                if (_pessoaContato == null)
                {
                    _pessoaContato = new PessoaContatoRepository(_repoContext);
                }

                return _pessoaContato;
            }
        }


        public RepositoryWrapper(RepositoryContext repositoryContext)
        {
            _repoContext = repositoryContext;
        }
    }
}
