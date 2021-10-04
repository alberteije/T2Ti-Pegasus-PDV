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
                .OrderBy(objeto => objeto.Nome);
        }
           
        public IEnumerable<Banco> ConsultarListaFiltro(Filtro filtro)
        {
            string sql = "select * from banco where " + filtro.Where;
            return RepositoryContext.Bancos.FromSqlRaw(sql).ToList();
        }

        public Banco ConsultarObjeto(int id)
        {
            return FindByCondition(objeto => objeto.Id.Equals(id))
                    .FirstOrDefault();
        }

        public void Inserir(Banco objeto)
        {
            Create(objeto);
            Save();
        }

        public void Alterar(Banco objBanco, Banco objJson)
        {
            objBanco.Map(objJson);
            Update(objBanco);
            Save();
        }

        public void Excluir(Banco objeto)
        {
            Delete(objeto);
            Save();
        }
    }

}
