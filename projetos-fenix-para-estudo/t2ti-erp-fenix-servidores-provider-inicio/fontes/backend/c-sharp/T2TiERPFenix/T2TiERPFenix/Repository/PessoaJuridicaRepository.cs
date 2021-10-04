using System.Collections.Generic;
using System.Linq;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public class PessoaJuridicaRepository : RepositoryBase<PessoaJuridica>, IPessoaJuridicaRepository
    {
        public PessoaJuridicaRepository(RepositoryContext repositoryContext)
            : base(repositoryContext)
        {
        }

        public IEnumerable<PessoaJuridica> ConsultarLista()
        {
            return FindAll()
                .OrderBy(pessoaJuridica => pessoaJuridica.NomeFantasia);
        }

        public PessoaJuridica ConsultarObjeto(int pessoaJuridicaId)
        {
            return FindByCondition(pessoaJuridica => pessoaJuridica.Id.Equals(pessoaJuridicaId))
                    .FirstOrDefault();
        }

        public void Inserir(PessoaJuridica pessoaJuridica)
        {
            Create(pessoaJuridica);
            Save();
        }

        public void Alterar(PessoaJuridica pessoaJuridica)
        {
            //dbPessoaJuridica.Map(pessoaJuridica);
            Update(pessoaJuridica);
            Save();
        }

        public void Excluir(PessoaJuridica pessoaJuridica)
        {
            Delete(pessoaJuridica);
            Save();
        }
    }

}
