using T2TiERPFenix.Models;

namespace T2TiERPFenix.Extensions
{
    public static class PessoaExtension
    {
        public static void Map(this Pessoa objBanco, Pessoa objJson)
        {
            objBanco.Nome = objJson.Nome;
            objBanco.Tipo = objJson.Tipo;
            objBanco.Site = objJson.Site;
            objBanco.Email = objJson.Email;
            objBanco.Cliente = objJson.Cliente;
            objBanco.Fornecedor = objJson.Fornecedor;
            objBanco.Transportadora = objJson.Transportadora;
            objBanco.Colaborador = objJson.Colaborador;
            objBanco.Contador = objJson.Contador;

            objBanco.PessoaFisica = objJson.PessoaFisica;
            objBanco.PessoaJuridica = objJson.PessoaJuridica;
            objBanco.ListaPessoaContato = objJson.ListaPessoaContato;
            objBanco.ListaPessoaTelefone = objJson.ListaPessoaTelefone;
            objBanco.ListaPessoaEndereco = objJson.ListaPessoaEndereco;
        }
    }
}
