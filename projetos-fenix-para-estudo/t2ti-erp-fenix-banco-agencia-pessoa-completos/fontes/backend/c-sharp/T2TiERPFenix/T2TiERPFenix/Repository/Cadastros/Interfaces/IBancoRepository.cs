using System.Collections.Generic;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public interface IBancoRepository : IRepositoryBase<Banco>
    {
        IEnumerable<Banco> ConsultarLista();
        IEnumerable<Banco> ConsultarListaFiltro(Filtro filtro);
        Banco ConsultarObjeto(int id);
        void Inserir(Banco objeto);
        void Alterar(Banco objBanco, Banco objJson);
        void Excluir(Banco objeto);
    }
}
