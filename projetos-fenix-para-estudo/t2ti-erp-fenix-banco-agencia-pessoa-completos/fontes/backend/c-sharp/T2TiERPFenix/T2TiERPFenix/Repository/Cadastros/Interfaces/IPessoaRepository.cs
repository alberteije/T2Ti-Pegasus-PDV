using System.Collections.Generic;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public interface IPessoaRepository : IRepositoryBase<Pessoa>
    {
        IEnumerable<Pessoa> ConsultarLista();
        IEnumerable<Pessoa> ConsultarListaFiltro(Filtro filtro);
        Pessoa ConsultarObjeto(int pessoaId);
        void Inserir(Pessoa objeto);
        void Alterar(Pessoa objBanco, Pessoa objJson);
        void Excluir(Pessoa objeto);
    }
}
