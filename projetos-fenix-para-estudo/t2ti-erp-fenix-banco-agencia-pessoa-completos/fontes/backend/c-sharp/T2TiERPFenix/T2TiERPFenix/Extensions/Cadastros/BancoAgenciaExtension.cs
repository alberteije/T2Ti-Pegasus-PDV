using T2TiERPFenix.Models;

namespace T2TiERPFenix.Extensions
{
    public static class BancoAgenciaExtension
    {
        public static void Map(this BancoAgencia objBanco, BancoAgencia objJson)
        {
            objBanco.Numero = objJson.Numero;
            objBanco.Digito = objJson.Digito;
            objBanco.Nome = objJson.Nome;
            objBanco.Telefone = objJson.Telefone;
            objBanco.Contato = objJson.Contato;
            objBanco.Observacao = objJson.Observacao;
            objBanco.Gerente = objJson.Gerente;
        }
    }
}
