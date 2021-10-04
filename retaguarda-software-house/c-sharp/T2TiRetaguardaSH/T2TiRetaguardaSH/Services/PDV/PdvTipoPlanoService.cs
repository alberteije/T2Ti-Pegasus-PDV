/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [PDV_TIPO_PLANO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
using NHibernate;
using System.Collections.Generic;
using T2TiRetaguardaSH.Models;
using T2TiRetaguardaSH.NHibernate;

namespace T2TiRetaguardaSH.Services
{
    public class PdvTipoPlanoService
    {

        public IEnumerable<PdvTipoPlano> ConsultarLista()
        {
            IList<PdvTipoPlano> Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvTipoPlano> DAL = new NHibernateDAL<PdvTipoPlano>(Session);
                Resultado = DAL.Select(new PdvTipoPlano());
            }
            return Resultado;
        }

        public IEnumerable<PdvTipoPlano> ConsultarListaFiltro(Filtro filtro)
        {
            IList<PdvTipoPlano> Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                var consultaSql = "from PdvTipoPlano where " + filtro.Where;
                NHibernateDAL<PdvTipoPlano> DAL = new NHibernateDAL<PdvTipoPlano>(Session);
                Resultado = DAL.SelectListaSql<PdvTipoPlano>(consultaSql);
            }
            return Resultado;
        }
		
        public PdvTipoPlano ConsultarObjeto(int id)
        {
            PdvTipoPlano Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvTipoPlano> DAL = new NHibernateDAL<PdvTipoPlano>(Session);
                Resultado = DAL.SelectId<PdvTipoPlano>(id);
            }
            return Resultado;
        }

        public PdvTipoPlano ConsultarObjetoFiltro(string filtro)
        {
            PdvTipoPlano Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                var consultaSql = "from PdvTipoPlano where " + filtro;
                NHibernateDAL<PdvTipoPlano> DAL = new NHibernateDAL<PdvTipoPlano>(Session);
                Resultado = DAL.SelectObjetoSql<PdvTipoPlano>(consultaSql);
            }
            return Resultado;
        }
        public void Inserir(PdvTipoPlano objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvTipoPlano> DAL = new NHibernateDAL<PdvTipoPlano>(Session);
                DAL.SaveOrUpdate(objeto);
                Session.Flush();
            }
        }

        public void Alterar(PdvTipoPlano objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvTipoPlano> DAL = new NHibernateDAL<PdvTipoPlano>(Session);
                DAL.SaveOrUpdate(objeto);
                Session.Flush();
            }
        }

        public void Excluir(PdvTipoPlano objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvTipoPlano> DAL = new NHibernateDAL<PdvTipoPlano>(Session);
                DAL.Delete(objeto);
                Session.Flush();
            }
        }
		
    }

}