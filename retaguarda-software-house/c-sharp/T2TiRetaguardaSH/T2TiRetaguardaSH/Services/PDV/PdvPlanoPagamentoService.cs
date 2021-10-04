/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Service relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
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
    public class PdvPlanoPagamentoService
    {

        public IEnumerable<PdvPlanoPagamento> ConsultarLista()
        {
            IList<PdvPlanoPagamento> Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvPlanoPagamento> DAL = new NHibernateDAL<PdvPlanoPagamento>(Session);
                Resultado = DAL.Select(new PdvPlanoPagamento());
            }
            return Resultado;
        }

        public IEnumerable<PdvPlanoPagamento> ConsultarListaFiltro(Filtro filtro)
        {
            IList<PdvPlanoPagamento> Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                var consultaSql = "from PdvPlanoPagamento where " + filtro.Where;
                NHibernateDAL<PdvPlanoPagamento> DAL = new NHibernateDAL<PdvPlanoPagamento>(Session);
                Resultado = DAL.SelectListaSql<PdvPlanoPagamento>(consultaSql);
            }
            return Resultado;
        }
		
        public PdvPlanoPagamento ConsultarObjeto(int id)
        {
            PdvPlanoPagamento Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvPlanoPagamento> DAL = new NHibernateDAL<PdvPlanoPagamento>(Session);
                Resultado = DAL.SelectId<PdvPlanoPagamento>(id);
            }
            return Resultado;
        }

        public PdvPlanoPagamento ConsultarPlanoAtivo(string cnpj)
        {
            string filtro = "CNPJ = '" + cnpj + "'";
            Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
            if (empresa != null)
            {
                filtro = "ID_EMPRESA = " + empresa.Id.ToString() + " AND DATA_PLANO_EXPIRA >= " + Biblioteca.DataParaTexto(DateTime.Now);
                return ConsultarObjetoFiltro(filtro);
            }
            else
            {
                return null;
            }
        }

        public int ConfirmarTransacao(string codigoTransacao, string cnpj)
        {
            // remove qualquer hifen que tenha sido colocado pelo usuário
            codigoTransacao = codigoTransacao.Replace("-", "");

            // primeiro verifica se existe o código da transação
            string filtro = "CODIGO_TRANSACAO = '" + codigoTransacao + "'";
            PdvPlanoPagamento pdvPlanoPagamento = ConsultarObjetoFiltro(filtro);
            if (pdvPlanoPagamento != null)
            {
                if (pdvPlanoPagamento.Empresa != null)
                {
                    // achou o código da transação, mas o código já foi utilizado
                    return 418;
                }
                else
                {
                    // achou o código da transação e não está vinculado a nenhuma empresa
                    // vamos vincular o id da empresa e o e-mail de pagamento
                    // retorna 200
                    EmpresaService empresaService = new EmpresaService();
                    filtro = "CNPJ = '" + cnpj + "'";
                    Empresa empresa = empresaService.ConsultarObjetoFiltro(filtro);
                    empresa.EmailPagamento = pdvPlanoPagamento.EmailPagamento;
                    empresaService.Alterar(empresa);

                    pdvPlanoPagamento.Empresa = empresa;
                    Alterar(pdvPlanoPagamento);

                    return 200;
                }
            }
            else
            {
                // não achou o código da transação, retorna 404
                return 404;
            }
        }

        public PdvPlanoPagamento ConsultarObjetoFiltro(string filtro)
        {
            PdvPlanoPagamento Resultado = null;
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                var consultaSql = "from PdvPlanoPagamento where " + filtro;
                NHibernateDAL<PdvPlanoPagamento> DAL = new NHibernateDAL<PdvPlanoPagamento>(Session);
                Resultado = DAL.SelectObjetoSql<PdvPlanoPagamento>(consultaSql);
            }
            return Resultado;
        }

        public void Inserir(PdvPlanoPagamento objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvPlanoPagamento> DAL = new NHibernateDAL<PdvPlanoPagamento>(Session);
                DAL.SaveOrUpdate(objeto);
                Session.Flush();
            }
        }

        public PdvPlanoPagamento Atualizar(ObjetoPagSeguro objetoPagSeguroEnviado)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                // primeiro verifica se já existe um registro armazenado para a transação, pois neste caso iremos apenas atualizar o registro
                string filtro = "";
                filtro = "CodigoTransacao = '" + objetoPagSeguroEnviado.CodigoTransacao + "'";
                PdvPlanoPagamento pdvPlanoPagamentoDB = ConsultarObjetoFiltro(filtro);
                if (pdvPlanoPagamentoDB != null)
                {
                    // atualiza o status
                    pdvPlanoPagamentoDB.StatusPagamento = objetoPagSeguroEnviado.CodigoStatusTransacao;

                    // se o status for pago, então atualiza a data de pagamento e de expiração do plano
                    if (pdvPlanoPagamentoDB.StatusPagamento == "3")
                    {
                        pdvPlanoPagamentoDB.DataPagamento = DateTime.Now;
                        switch (pdvPlanoPagamentoDB.Plano)
                        {
                            case "M":
                                pdvPlanoPagamentoDB.DataPlanoExpira = DateTime.Now.AddMonths(1);
                                break;
                            case "S":
                                pdvPlanoPagamentoDB.DataPlanoExpira = DateTime.Now.AddMonths(6);
                                break;
                            case "A":
                                pdvPlanoPagamentoDB.DataPlanoExpira = DateTime.Now.AddMonths(12);
                                break;
                            default:
                                break;
                        }
                    }

                    Inserir(pdvPlanoPagamentoDB);
                    Session.Flush();
                    return pdvPlanoPagamentoDB;
                }
                else
                {
                    // a falta de registro no banco indica que devemos criar um novo registro no banco de dados
                    // que só será inserido se tiver vindo um tipo de plano válido na requisição
                    String planoContratado = Biblioteca.PegarPlanoPdv(objetoPagSeguroEnviado.DescricaoProduto);
                    String moduloFiscal = Biblioteca.PegarModuloFiscalPdv(objetoPagSeguroEnviado.DescricaoProduto);
                    filtro = "Plano = '" + planoContratado + "' AND ModuloFiscal = '" + moduloFiscal + "'";
                    PdvTipoPlano tipoPlano = new PdvTipoPlanoService().ConsultarObjetoFiltro(filtro);
                    if (tipoPlano != null)
                    {
                        PdvPlanoPagamento pdvPlanoPagamento = new PdvPlanoPagamento();
                        pdvPlanoPagamento.PdvTipoPlano = tipoPlano;
                        pdvPlanoPagamento.CodigoTransacao = objetoPagSeguroEnviado.CodigoTransacao;
                        pdvPlanoPagamento.StatusPagamento = objetoPagSeguroEnviado.CodigoStatusTransacao;
                        pdvPlanoPagamento.MetodoPagamento = objetoPagSeguroEnviado.MetodoPagamento;
                        pdvPlanoPagamento.CodigoTipoPagamento = objetoPagSeguroEnviado.CodigoTipoPagamento;
                        pdvPlanoPagamento.Valor = objetoPagSeguroEnviado.ValorUnitario;
                        pdvPlanoPagamento.EmailPagamento = objetoPagSeguroEnviado.EmailCliente;
                        pdvPlanoPagamento.DataSolicitacao = DateTime.Now;
                        pdvPlanoPagamento.Plano = planoContratado;

                        // tenta encontrar a empresa pelo e-mail - se não encontrar, o usuário terá
                        // que informar o código da transação na App para reconhecer o seu pagamento
                        filtro = "Email = '" + objetoPagSeguroEnviado.EmailCliente + "'";
                        Empresa empresa = new EmpresaService().ConsultarObjetoFiltro(filtro);
                        if (empresa != null)
                        {
                            pdvPlanoPagamento.Empresa = empresa;
                        }

                        Alterar(pdvPlanoPagamento);
                        Session.Flush();
                        return pdvPlanoPagamento;
                    }
                    else
                    {
                        return null;
                    }
                }

            }
        }

        public void Alterar(PdvPlanoPagamento objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvPlanoPagamento> DAL = new NHibernateDAL<PdvPlanoPagamento>(Session);
                DAL.SaveOrUpdate(objeto);
                Session.Flush();
            }
        }

        public void Excluir(PdvPlanoPagamento objeto)
        {
            using (ISession Session = NHibernateHelper.GetSessionFactory().OpenSession())
            {
                NHibernateDAL<PdvPlanoPagamento> DAL = new NHibernateDAL<PdvPlanoPagamento>(Session);
                DAL.Delete(objeto);
                Session.Flush();
            }
        }
		
    }

}