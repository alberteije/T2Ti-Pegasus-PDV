using T2TiERPFenix.Models;

namespace T2TiERPFenix.Extensions
{
    public static class CargoExtension
    {
        public static void Map(this Cargo dbCargo, Cargo cargo)
        {
            dbCargo.Nome = cargo.Nome;
            dbCargo.Descricao = cargo.Descricao;
            dbCargo.Salario = cargo.Salario;
            dbCargo.CBO1994 = cargo.CBO1994;
            dbCargo.CBO2002 = cargo.CBO2002;
        }
    }
}
