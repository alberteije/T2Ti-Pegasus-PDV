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
            return FindAll()
                .OrderBy(pessoa => pessoa.Nome);
        }

        public Pessoa ConsultarObjeto(int pessoaId)
        {
            return FindByCondition(pessoa => pessoa.Id.Equals(pessoaId))
                    .FirstOrDefault();
        }

        public void Inserir(Pessoa pessoa)
        {
            Create(pessoa);
            Save();
        }

        public void Alterar(Pessoa dbPessoa, Pessoa pessoa)
        {
            dbPessoa.Map(pessoa);
            Update(dbPessoa);
            Save();
        }

        public void Excluir(Pessoa pessoa)
        {
            Delete(pessoa);
            Save();
        }
    }

}
