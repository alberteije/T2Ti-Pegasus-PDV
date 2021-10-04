/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [EMPRESA] 
                                                                                
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
using System;
using System.Collections.Generic;
using T2TiRetaguardaSH.Models;
using T2TiRetaguardaSH.NHibernate;
using T2TiRetaguardaSH.Util;

namespace T2TiRetaguardaSH.Services
{
    public class EmpresaService
    {

        public IEnumerable<Empresa> ConsultarLista()
        {
            IList<Empresa> Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                Resultado = DAL.Select(new Empresa());
            }
            return Resultado;
        }

        public IEnumerable<Empresa> ConsultarListaFiltro(Filtro filtro)
        {
            IList<Empresa> Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                var consultaSql = "from Empresa where " + filtro.Where;
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                Resultado = DAL.SelectListaSql<Empresa>(consultaSql);
            }
            return Resultado;
        }
		
        public Empresa ConsultarObjeto(int id)
        {
            Empresa Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                Resultado = DAL.SelectId<Empresa>(id);
            }
            return Resultado;
        }

        public Empresa ConsultarObjetoFiltro(string filtro)
        {
            Empresa Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                var consultaSql = "from Empresa where " + filtro;
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                Resultado = DAL.SelectObjetoSql<Empresa>(consultaSql);
            }
            return Resultado;
        }

        public void Inserir(Empresa objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                DAL.SaveOrUpdate(objeto);
                Session.Flush();
            }
        }

        public void Alterar(Empresa objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                DAL.SaveOrUpdate(objeto);
                Session.Flush();
            }
        }

        public void Atualizar(Empresa objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                // TODO: salva a imagem em disco
                objeto.Logotipo = "";
                DAL.SaveOrUpdate(objeto);
                Session.Flush();
            }
        }

        public void Registrar(Empresa objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                objeto.Logotipo = "";

                string filtro = "CNPJ = '" + objeto.Cnpj + "'";
                Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
                if (empresa != null)
                {
                    if (empresa.Registrado != "P")
                    {
                        objeto.Id = empresa.Id;
                        objeto.Registrado = "P";
                        DAL.SaveOrUpdate(objeto);
                        Session.Flush();
                        EnviarEmailConfirmacao(objeto);
                    }
                }                
            }
        }

        public void EnviarEmailConfirmacao(Empresa objeto)
        {
            string codigo = Biblioteca.MD5String(objeto.Cnpj + Constantes.CHAVE);
            
            string corpo = "";
            corpo = corpo + "<html>";
            corpo = corpo + "<body>";
            corpo = corpo + "<p>Olá " + objeto.NomeFantasia + ", </p>";
            corpo = corpo + "<p>Parabéns pelo seu cadastro na aplicação T2Ti Pegasus PDV. Segue o código de confirmação para liberar o uso da aplicação.</p>";
            corpo = corpo + "<p>Informe o seguinte código na aplicação: " + codigo + "</p>";
            corpo = corpo + "<p>Atenciosamente,</p>";
            corpo = corpo + "<p>Equipe T2Ti.COM</p>";
            corpo = corpo + "</body>";
            corpo = corpo + "</html>";

            Biblioteca.EnviarEmail("T2Ti Pegasus PDV - Código de Confirmação", objeto.Email, corpo);
        }

        public void ConferirCodigoConfirmacao(Empresa objeto, string codigoConfirmacao)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                objeto.Logotipo = "";
                string codigo = Biblioteca.MD5String(objeto.Cnpj + Constantes.CHAVE);
                if (codigo == codigoConfirmacao)
                {
                    string filtro = "CNPJ = '" + objeto.Cnpj + "'";
                    Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
                    if (empresa != null)
                    {
                        objeto.Id = empresa.Id;
                        objeto.Registrado = "S";
                        objeto.DataRegistro = DateTime.Now;
                        objeto.HoraRegistro = Biblioteca.DataParaHora(DateTime.Now);
                        DAL.SaveOrUpdate(objeto);
                        Session.Flush();
                    }
                }
            }
        }

        public void Excluir(Empresa objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<Empresa> DAL = new NHibernateDAL<Empresa>(Session);
                DAL.Delete(objeto);
                Session.Flush();
            }
        }
		
    }

}