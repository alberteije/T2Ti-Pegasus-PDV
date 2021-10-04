using System.Collections.Generic;
using System.Linq;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public class PessoaContatoRepository : RepositoryBase<PessoaContato>, IPessoaContatoRepository
    {
        public PessoaContatoRepository(RepositoryContext repositoryContext)
            : base(repositoryContext)
        {
        }

        public IEnumerable<PessoaContato> ConsultarLista()
        {
            return FindAll()
                .OrderBy(pessoaContato => pessoaContato.Nome);
        }

        public PessoaContato ConsultarObjeto(int pessoaContatoId)
        {
            return FindByCondition(pessoaContato => pessoaContato.Id.Equals(pessoaContatoId))
                    .FirstOrDefault();
        }

        public void Inserir(PessoaContato pessoaContato)
        {
            Create(pessoaContato);
            Save();
        }

        public void Alterar(PessoaContato pessoaContato)
        {
            //dbPessoaContato.Map(pessoaContato);
            Update(pessoaContato);
            Save();
        }

        public void Excluir(PessoaContato pessoaContato)
        {
            Delete(pessoaContato);
            Save();
        }
    }

}
