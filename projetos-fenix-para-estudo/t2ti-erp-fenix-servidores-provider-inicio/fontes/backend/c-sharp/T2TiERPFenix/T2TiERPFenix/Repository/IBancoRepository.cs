using System.Collections.Generic;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public interface IBancoRepository : IRepositoryBase<Banco>
    {
        IEnumerable<Banco> ConsultarLista();
        IEnumerable<Banco> ConsultarListaFiltro(Filtro filtro);
        Banco ConsultarObjeto(int bancoId);
        void Inserir(Banco banco);
        void Alterar(Banco dbBanco, Banco banco);
        void Excluir(Banco banco);
    }
}
