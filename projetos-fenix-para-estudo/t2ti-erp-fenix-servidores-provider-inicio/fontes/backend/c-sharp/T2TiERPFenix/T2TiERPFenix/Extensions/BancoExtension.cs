using T2TiERPFenix.Models;

namespace T2TiERPFenix.Extensions
{
    public static class BancoExtension
    {
        public static void Map(this Banco dbBanco, Banco banco)
        {
            dbBanco.Codigo = banco.Codigo;
            dbBanco.Nome = banco.Nome;
            dbBanco.Url = banco.Url;
        }
    }
}
