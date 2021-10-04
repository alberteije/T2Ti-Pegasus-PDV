using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using T2TiERPFenix.Extensions;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public class CargoRepository : RepositoryBase<Cargo>, ICargoRepository
    {
        public CargoRepository(RepositoryContext repositoryContext)
            : base(repositoryContext)
        {
        }

        public IEnumerable<Cargo> ConsultarLista()
        {
            return FindAll().OrderBy(cargo => cargo.Nome);
        }

        public Cargo ConsultarObjeto(int cargoId)
        {
            return FindByCondition(cargo => cargo.Id.Equals(cargoId))
                    .FirstOrDefault();
        }

        public void Inserir(Cargo cargo)
        {
            Create(cargo);
            Save();
        }

        public void Alterar(Cargo dbCargo, Cargo cargo)
        {
            dbCargo.Map(cargo);
            Update(dbCargo);
            Save();
        }

        public void Excluir(Cargo cargo)
        {
            Delete(cargo);
            Save();
        }
    }

}
