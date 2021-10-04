using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace T2TiERPFenix.Repository
{
    public interface IRepositoryBase<T>
    {
        IEnumerable<T> FindAll();
        IEnumerable<T> FindByCondition(Expression<Func<T, bool>> expression);
        void Create(T entity);
        void Update(T entity);
        void Delete(T entity);
        void Save();
    }

}
