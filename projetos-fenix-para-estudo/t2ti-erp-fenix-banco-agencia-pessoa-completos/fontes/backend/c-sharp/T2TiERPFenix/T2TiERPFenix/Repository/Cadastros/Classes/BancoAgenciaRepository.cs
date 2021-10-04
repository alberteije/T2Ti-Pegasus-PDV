using Microsoft.EntityFrameworkCore;
using PoweredSoft.DynamicLinq;
using System;
using System.Collections.Generic;
using System.Linq;
using T2TiERPFenix.Extensions;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public class BancoAgenciaRepository : RepositoryBase<BancoAgencia>, IBancoAgenciaRepository
    {
        public BancoAgenciaRepository(RepositoryContext repositoryContext)
            : base(repositoryContext)
        {
        }

        public IEnumerable<BancoAgencia> ConsultarLista()
        {
            var query = from obj in RepositoryContext.BancoAgencias
                        .Include(bancoAgencia => bancoAgencia.Banco)
                        select obj;
            return query.ToList();

            //return FindAll()
            //    .OrderBy(objeto => objeto.Nome);
        }

        public IEnumerable<BancoAgencia> ConsultarListaFiltro(Filtro filtro)
        {
            var query = RepositoryContext.BancoAgencias
                .Include(bancoAgencia => bancoAgencia.Banco)
                .AsQueryable();
            query = query.Where(filtro.Campo, ConditionOperators.Contains, filtro.Valor, stringComparision: StringComparison.OrdinalIgnoreCase);
            return query.ToList();

            //string sql = "select * from banco_agencia where " + filtro.Where;
            //return RepositoryContext.BancoAgencias.FromSqlRaw(sql).ToList();
        }

        public BancoAgencia ConsultarObjeto(int id)
        {
            var query = from obj in RepositoryContext.BancoAgencias
                        .Include(bancoAgencia => bancoAgencia.Banco)
                        where obj.Id == id
                        select obj;
            return query.SingleOrDefault();

            //return FindByCondition(objeto => objeto.Id.Equals(id))
            //        .FirstOrDefault();
        }

        public void Inserir(BancoAgencia objeto)
        {
            RepositoryContext.Entry(objeto.Banco).State = EntityState.Unchanged; //não queremos inserir o banco
            Create(objeto);
            Save();
        }

        public void Alterar(BancoAgencia objBanco, BancoAgencia objJson)
        {
            objBanco.Map(objJson);
            Update(objBanco);
            Save();
        }

        public void Excluir(BancoAgencia objeto)
        {
            Delete(objeto);
            Save();
        }
    }

}
