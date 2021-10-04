using System.Collections.Generic;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public interface IPessoaContatoRepository : IRepositoryBase<PessoaContato>
    {
        IEnumerable<PessoaContato> ConsultarLista();
        PessoaContato ConsultarObjeto(int pessoaContatoId);
        void Inserir(PessoaContato pessoaContato);
        void Alterar(PessoaContato pessoaContato);
        void Excluir(PessoaContato pessoaContato);
    }
}
