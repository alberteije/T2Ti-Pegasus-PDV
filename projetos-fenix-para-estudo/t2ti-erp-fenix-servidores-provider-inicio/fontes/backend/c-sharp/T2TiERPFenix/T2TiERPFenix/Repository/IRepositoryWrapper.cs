namespace T2TiERPFenix.Repository
{
    public interface IRepositoryWrapper
    {
        ICargoRepository Cargo { get; }
        IBancoRepository Banco { get; }
        IPessoaRepository Pessoa { get; }
        IPessoaJuridicaRepository PessoaJuridica { get; }
        IPessoaContatoRepository PessoaContato { get; }
    }

}
