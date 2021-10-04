using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using T2TiERPFenix.Extensions;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public class BancoRepository : RepositoryBase<Banco>, IBancoRepository
    {
        public BancoRepository(RepositoryContext repositoryContext)
            : base(repositoryContext)
        {
        }

        public IEnumerable<Banco> ConsultarLista()
        {
            return FindAll()
                .OrderBy(banco => banco.Nome);
        }
           
        public IEnumerable<Banco> ConsultarListaFiltro(Filtro filtro)
        {
            string sql = "select * from banco where " + filtro.Where;
            return RepositoryContext.Bancos.FromSqlRaw(sql).ToList();
        }

        public Banco ConsultarObjeto(int bancoId)
        {
            return FindByCondition(banco => banco.Id.Equals(bancoId))
                    .FirstOrDefault();
        }

        public void Inserir(Banco banco)
        {
            Create(banco);
            Save();
        }

        public void Alterar(Banco dbBanco, Banco banco)
        {
            dbBanco.Map(banco);
            Update(dbBanco);
            Save();
        }

        public void Excluir(Banco banco)
        {
            Delete(banco);
            Save();
        }
    }

}
