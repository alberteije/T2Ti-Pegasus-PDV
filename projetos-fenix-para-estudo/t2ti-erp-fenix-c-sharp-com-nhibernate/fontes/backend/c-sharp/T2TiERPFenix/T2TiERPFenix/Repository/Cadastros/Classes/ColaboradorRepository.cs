/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Repository relacionado à tabela [COLABORADOR] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using PoweredSoft.DynamicLinq;
using System;
using System.Linq;
using T2TiERPFenix.Extensions;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public class ColaboradorRepository : RepositoryBase<Colaborador>, IColaboradorRepository
    {
        public ColaboradorRepository(RepositoryContext repositoryContext)
            : base(repositoryContext)
        {
        }

        public IEnumerable<Colaborador> ConsultarLista()
        {
            var query = from obj in RepositoryContext.Colaboradors
						.Include(colaborador => colaborador.Usuario)
						.Include(colaborador => colaborador.Pessoa)
						.Include(colaborador => colaborador.Cargo)
						.Include(colaborador => colaborador.Setor)
                        select obj;
            return query.AsNoTracking().ToList();
        }

        public IEnumerable<Colaborador> ConsultarListaFiltro(Filtro filtro)
        {
            var query = RepositoryContext.Colaboradors
						.Include(colaborador => colaborador.Usuario)
						.Include(colaborador => colaborador.Pessoa)
						.Include(colaborador => colaborador.Cargo)
						.Include(colaborador => colaborador.Setor)
                .AsQueryable();
            query = query.Where(filtro.Campo, ConditionOperators.Contains, filtro.Valor, stringComparision: StringComparison.OrdinalIgnoreCase);
            return query.AsNoTracking().ToList();
        }

        public Colaborador ConsultarObjeto(int id)
        {
            var query = from obj in RepositoryContext.Colaboradors
						.Include(colaborador => colaborador.Usuario)
						.Include(colaborador => colaborador.Pessoa)
						.Include(colaborador => colaborador.Cargo)
						.Include(colaborador => colaborador.Setor)
                        where obj.Id == id
                        select obj;
            return query.AsNoTracking().SingleOrDefault();
        }

        public void Inserir(Colaborador objeto)
        {
			RepositoryContext.Entry(objeto.Pessoa).State = EntityState.Unchanged; //não queremos inserir o objeto vinculado
			RepositoryContext.Entry(objeto.Cargo).State = EntityState.Unchanged; //não queremos inserir o objeto vinculado
			RepositoryContext.Entry(objeto.Setor).State = EntityState.Unchanged; //não queremos inserir o objeto vinculado
            RepositoryContext.Entry(objeto.Usuario.Papel).State = EntityState.Unchanged; //não queremos inserir o objeto vinculado
            Create(objeto);
            Save();
        }

        public void Alterar(Colaborador objBanco, Colaborador objJson)
        {
            objBanco.Map(objJson);
            Update(objBanco);
            Save();
        }

        public void Excluir(Colaborador objeto)
        {
            Delete(objeto);
            Save();
        }

    }

}