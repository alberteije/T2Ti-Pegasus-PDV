using System.Collections.Generic;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public interface IBancoAgenciaRepository : IRepositoryBase<BancoAgencia>
    {
        IEnumerable<BancoAgencia> ConsultarLista();
        IEnumerable<BancoAgencia> ConsultarListaFiltro(Filtro filtro);
        BancoAgencia ConsultarObjeto(int id);
        void Inserir(BancoAgencia objeto);
        void Alterar(BancoAgencia objBanco, BancoAgencia objJson);
        void Excluir(BancoAgencia objeto);
    }
}
