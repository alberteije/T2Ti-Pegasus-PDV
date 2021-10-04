using T2TiERPFenix.Models;

namespace T2TiERPFenix.Extensions
{
    public static class PessoaExtension
    {
        public static void Map(this Pessoa dbPessoa, Pessoa pessoa)
        {
            dbPessoa.Nome = pessoa.Nome;
            dbPessoa.Tipo = pessoa.Tipo;
            dbPessoa.Site = pessoa.Site;
            dbPessoa.Email = pessoa.Email;
            dbPessoa.Cliente = pessoa.Cliente;
            dbPessoa.Fornecedor = pessoa.Fornecedor;
            dbPessoa.Transportadora = pessoa.Transportadora;
            dbPessoa.Colaborador = pessoa.Colaborador;
            dbPessoa.Contador = pessoa.Contador;
        }
    }
}
