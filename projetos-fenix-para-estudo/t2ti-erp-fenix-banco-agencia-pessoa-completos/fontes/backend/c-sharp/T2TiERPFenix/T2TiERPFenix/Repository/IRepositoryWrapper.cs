namespace T2TiERPFenix.Repository
{
    public interface IRepositoryWrapper
    {
        ICargoRepository Cargo { get; }
        IBancoRepository Banco { get; }
        IBancoAgenciaRepository BancoAgencia { get; }
        IPessoaRepository Pessoa { get; }
        }

}
