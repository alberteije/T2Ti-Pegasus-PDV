namespace T2TiERPFenix.Repository
{
    public class RepositoryWrapper : IRepositoryWrapper
    {
        private RepositoryContext _repoContext;
        private ICargoRepository _cargo;
        private IBancoRepository _banco;
        private IBancoAgenciaRepository _bancoAgencia;
        private IPessoaRepository _pessoa;

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


        public RepositoryWrapper(RepositoryContext repositoryContext)
        {
            _repoContext = repositoryContext;
        }
    }
}
