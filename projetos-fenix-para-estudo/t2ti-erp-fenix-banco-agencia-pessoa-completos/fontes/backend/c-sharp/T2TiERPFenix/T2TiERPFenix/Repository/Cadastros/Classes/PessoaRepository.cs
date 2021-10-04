using Microsoft.EntityFrameworkCore;
using PoweredSoft.DynamicLinq;
using System;
using System.Collections.Generic;
using System.Linq;
using T2TiERPFenix.Extensions;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public class PessoaRepository : RepositoryBase<Pessoa>, IPessoaRepository
    {
        public PessoaRepository(RepositoryContext repositoryContext)
            : base(repositoryContext)
        {
        }

        public IEnumerable<Pessoa> ConsultarLista()
        {
            var query = from obj in RepositoryContext.Pessoas
                            .Include(pessoa => pessoa.PessoaFisica)
                            .Include(pessoa => pessoa.PessoaJuridica)
                            .Include(pessoa => pessoa.ListaPessoaContato)
                            .Include(pessoa => pessoa.ListaPessoaTelefone)
                            .Include(pessoa => pessoa.ListaPessoaEndereco)
                        select obj;
            return query.ToList();
        }

        public IEnumerable<Pessoa> ConsultarListaFiltro(Filtro filtro)
        {
            var query = RepositoryContext.Pessoas
                            .Include(pessoa => pessoa.PessoaFisica)
                            .Include(pessoa => pessoa.PessoaJuridica)
                            .Include(pessoa => pessoa.ListaPessoaContato)
                            .Include(pessoa => pessoa.ListaPessoaTelefone)
                            .Include(pessoa => pessoa.ListaPessoaEndereco)
                .AsQueryable();
            query = query.Where(filtro.Campo, ConditionOperators.Contains, filtro.Valor, stringComparision: StringComparison.OrdinalIgnoreCase);
            return query.ToList();
        }

        public Pessoa ConsultarObjeto(int id)
        {
            var query = from obj in RepositoryContext.Pessoas
                            .Include(pessoa => pessoa.PessoaFisica)
                            .Include(pessoa => pessoa.PessoaJuridica)
                            .Include(pessoa => pessoa.ListaPessoaContato)
                            .Include(pessoa => pessoa.ListaPessoaTelefone)
                            .Include(pessoa => pessoa.ListaPessoaEndereco)
                        where obj.Id == id
                        select obj;
            return query.SingleOrDefault();
        }

        public void Inserir(Pessoa objeto)
        {
            Create(objeto);
            Save();
        }

        public void Alterar(Pessoa objBanco, Pessoa objJson)
        {
            objBanco.Map(objJson);
            Update(objBanco);
            Save();
        }

        public void Excluir(Pessoa objeto)
        {
            Delete(objeto);
            Save();
        }

    }

}