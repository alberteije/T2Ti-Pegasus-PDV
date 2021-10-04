using System.Collections.Generic;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public interface ICargoRepository : IRepositoryBase<Cargo>
    {
        IEnumerable<Cargo> ConsultarLista();
        Cargo ConsultarObjeto(int cargoId);
        void Inserir(Cargo cargo);
        void Alterar(Cargo dbCargo, Cargo cargo);
        void Excluir(Cargo cargo);
    }
}
