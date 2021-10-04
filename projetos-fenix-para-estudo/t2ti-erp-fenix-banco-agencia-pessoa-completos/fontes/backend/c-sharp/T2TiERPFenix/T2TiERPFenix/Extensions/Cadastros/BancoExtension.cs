using T2TiERPFenix.Models;

namespace T2TiERPFenix.Extensions
{
    public static class BancoExtension
    {
        public static void Map(this Banco objBanco, Banco objJson)
        {
            objBanco.Codigo = objJson.Codigo;
            objBanco.Nome = objJson.Nome;
            objBanco.Url = objJson.Url;
        }
    }
}
