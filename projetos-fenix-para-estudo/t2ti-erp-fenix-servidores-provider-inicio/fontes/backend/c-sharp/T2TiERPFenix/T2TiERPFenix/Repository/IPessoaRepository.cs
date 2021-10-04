using System.Collections.Generic;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public interface IPessoaRepository : IRepositoryBase<Pessoa>
    {
        IEnumerable<Pessoa> ConsultarLista();
        Pessoa ConsultarObjeto(int pessoaId);
        void Inserir(Pessoa pessoa);
        void Alterar(Pessoa dbPessoa, Pessoa pessoa);
        void Excluir(Pessoa pessoa);
    }
}
