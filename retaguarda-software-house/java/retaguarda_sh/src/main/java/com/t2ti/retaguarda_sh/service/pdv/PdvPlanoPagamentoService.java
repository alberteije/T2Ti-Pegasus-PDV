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
package com.t2ti.retaguarda_sh.service.pdv;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.retaguarda_sh.model.cadastros.Empresa;
import com.t2ti.retaguarda_sh.model.pdv.PdvPlanoPagamento;
import com.t2ti.retaguarda_sh.model.pdv.PdvTipoPlano;
import com.t2ti.retaguarda_sh.model.transiente.Filtro;
import com.t2ti.retaguarda_sh.model.transiente.ObjetoPagSeguro;
import com.t2ti.retaguarda_sh.repository.pdv.PdvPlanoPagamentoRepository;
import com.t2ti.retaguarda_sh.service.cadastros.EmpresaService;
import com.t2ti.retaguarda_sh.util.Biblioteca;

@Service
public class PdvPlanoPagamentoService {

	@Autowired
	private PdvPlanoPagamentoRepository repository;
	@Autowired
	private PdvTipoPlanoService tipoPlanoService;
	@Autowired
	private EmpresaService empresaService;
	
	@PersistenceContext
    private EntityManager entityManager;	
	
	public List<PdvPlanoPagamento> consultarLista() {
		return repository.findAll();
	}

	@SuppressWarnings("unchecked")
	public List<PdvPlanoPagamento> consultarLista(Filtro filtro) {
		String sql = "select * from PDV_PLANO_PAGAMENTO where " + filtro.getWhere();
		Query query = entityManager.createNativeQuery(sql, PdvPlanoPagamento.class);
		return query.getResultList();
	}
	
	public PdvPlanoPagamento consultarObjetoFiltro(String filtro) {
		String sql = "select * from PDV_PLANO_PAGAMENTO where " + filtro;
		Query query = entityManager.createNativeQuery(sql, PdvPlanoPagamento.class);
		if (query.getResultList().size() > 0) {
			return (PdvPlanoPagamento) query.getResultList().get(0);
		} else {
			return null;
		}
	}
	
	public PdvPlanoPagamento consultarObjeto(Integer id) {
		return repository.findById(id).get();
	}
	
	public PdvPlanoPagamento salvar(PdvPlanoPagamento objeto) {
		return repository.save(objeto);
	}
	
	public PdvPlanoPagamento consultarPlanoAtivo(String cnpj) {
		String filtro = "CNPJ = '" + cnpj + "'";
		Empresa empresa = empresaService.consultarObjetoFiltro(filtro);
		if (empresa != null) {
			filtro = "ID_EMPRESA = " + empresa.getId().toString() + " AND DATA_PLANO_EXPIRA >= " + Biblioteca.dateToSQL(new Date());
			return consultarObjetoFiltro(filtro);
		} else {
			return null;
		}
	}
	
	public int confirmarTransacao(String codigoTransacao, String cnpj) {
		// remove qualquer hifen que tenha sido colocado pelo usuário
		codigoTransacao = codigoTransacao.replaceAll("-", "");
		
		// primeiro verifica se existe o código da transação
		String filtro = "CODIGO_TRANSACAO = '" + codigoTransacao + "'";
		PdvPlanoPagamento pdvPlanoPagamento = consultarObjetoFiltro(filtro);	
		if (pdvPlanoPagamento != null) {
			if (pdvPlanoPagamento.getEmpresa() != null) {
				// achou o código da transação, mas o código já foi utilizado
				return 418;				
			} else {
			    // achou o código da transação e não está vinculado a nenhuma empresa
			    // vamos vincular o id da empresa e o e-mail de pagamento
			    // retorna 200
				filtro = "CNPJ = '" + cnpj + "'";
				Empresa empresa = empresaService.consultarObjetoFiltro(filtro);
				empresa.setEmailPagamento(pdvPlanoPagamento.getEmailPagamento());
				empresaService.salvar(empresa);
				
				pdvPlanoPagamento.setEmpresa(empresa);
				salvar(pdvPlanoPagamento);

				return 200;
			}
		} else {			
		    // não achou o código da transação, retorna 404
			return 404;
		}		
	}
	
	public PdvPlanoPagamento atualizar(ObjetoPagSeguro objetoPagSeguroEnviado) {
		// primeiro verifica se já existe um registro armazenado para a transação, pois neste caso iremos apenas atualizar o registro
		String filtro = "";
		filtro = "CODIGO_TRANSACAO = '" + objetoPagSeguroEnviado.getCodigoTransacao() + "'";		
		PdvPlanoPagamento pdvPlanoPagamentoDB = consultarObjetoFiltro(filtro);
		if (pdvPlanoPagamentoDB != null) {
	
		    // atualiza o status
		    pdvPlanoPagamentoDB.setStatusPagamento(objetoPagSeguroEnviado.getCodigoStatusTransacao());

		    // se o status for pago, então atualiza a data de pagamento e de expiração do plano
		    if (pdvPlanoPagamentoDB.getStatusPagamento().equals("3")) {
		    	pdvPlanoPagamentoDB.setDataPagamento(new Date());
		    	Calendar calendar = Calendar.getInstance();
		    	//calendar.
		    	switch(pdvPlanoPagamentoDB.getPlano()) {
		            case "M": 
		            	calendar.add(Calendar.MONTH, 1);
		            	pdvPlanoPagamentoDB.setDataPlanoExpira(calendar.getTime());
		                break;
		            case "S":  
		            	calendar.add(Calendar.MONTH, 6);
		            	pdvPlanoPagamentoDB.setDataPlanoExpira(calendar.getTime());
		                break;
		            case "A":  
		            	calendar.add(Calendar.MONTH, 12);
		            	pdvPlanoPagamentoDB.setDataPlanoExpira(calendar.getTime());
		                break;	            
		            default: 
		            	break;
		        }		    	
		    }

		    return salvar(pdvPlanoPagamentoDB);
		} else {		
		    // a falta de registro no banco indica que devemos criar um novo registro no banco de dados
		    // que só será inserido se tiver vindo um tipo de plano válido na requisição
		    String planoContratado = Biblioteca.pegarPlanoPdv(objetoPagSeguroEnviado.getDescricaoProduto());
		    String moduloFiscal = Biblioteca.pegarModuloFiscalPdv(objetoPagSeguroEnviado.getDescricaoProduto());
		    filtro = "PLANO = '" + planoContratado + "' AND MODULO_FISCAL = '" + moduloFiscal + "'";
		    PdvTipoPlano tipoPlano = tipoPlanoService.consultarObjetoFiltro(filtro);
			if (tipoPlano != null) {
				PdvPlanoPagamento pdvPlanoPagamento = new PdvPlanoPagamento();
				pdvPlanoPagamento.setPdvTipoPlano(tipoPlano);
				pdvPlanoPagamento.setCodigoTransacao(objetoPagSeguroEnviado.getCodigoTransacao());
				pdvPlanoPagamento.setStatusPagamento(objetoPagSeguroEnviado.getCodigoStatusTransacao());
				pdvPlanoPagamento.setMetodoPagamento(objetoPagSeguroEnviado.getMetodoPagamento());
				pdvPlanoPagamento.setCodigoTipoPagamento(objetoPagSeguroEnviado.getCodigoTipoPagamento());
				pdvPlanoPagamento.setValor(objetoPagSeguroEnviado.getValorUnitario());
				pdvPlanoPagamento.setEmailPagamento(objetoPagSeguroEnviado.getEmailCliente());
				pdvPlanoPagamento.setDataSolicitacao(new Date());
				pdvPlanoPagamento.setPlano(planoContratado);

				// tenta encontrar a empresa pelo e-mail - se não encontrar, o usuário terá
				// que informar o código da transação na App para reconhecer o seu pagamento
				filtro = "EMAIL = '" + objetoPagSeguroEnviado.getEmailCliente() + "'";
				Empresa empresa = empresaService.consultarObjetoFiltro(filtro);
				if (empresa != null) {
					pdvPlanoPagamento.setEmpresa(empresa);
				}
			
			    return salvar(pdvPlanoPagamento);
			} else {
				return null;
			}		
		}		
	}	
		
	public void excluir(Integer id) {
		PdvPlanoPagamento objeto = consultarObjeto(id);
		repository.delete(objeto);
	}
	
}