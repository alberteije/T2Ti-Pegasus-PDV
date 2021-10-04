using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace T2TiERPFenix.NHibernate
{
    public interface IDAL<DTO>
    {
        T Save<T>(T objeto);
        T SaveOrUpdate<T>(T objeto);
        T Update<T>(T objeto);
        int Delete<T>(T objeto);
        IList<T> Select<T>(T objeto); 
        T SelectObjeto<T>(T objeto);
        T SelectId<T>(int id);
        IList<T> SelectPagina<T>(int primeiroResultado, int quantidadeResultados, T objeto);
        T SelectObjetoSql<T>(String consultaSql);
        IList<T> SelectListaSql<T>(String consultaSql);
    }
}
