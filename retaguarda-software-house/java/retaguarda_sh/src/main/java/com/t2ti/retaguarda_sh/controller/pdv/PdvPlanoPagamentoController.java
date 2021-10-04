/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Controller relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
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
package com.t2ti.retaguarda_sh.controller.pdv;

import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.t2ti.retaguarda_sh.exception.ExcecaoGenericaServidorException;
import com.t2ti.retaguarda_sh.exception.RecursoNaoEncontradoException;
import com.t2ti.retaguarda_sh.exception.RequisicaoRuimException;
import com.t2ti.retaguarda_sh.model.pdv.PdvPlanoPagamento;
import com.t2ti.retaguarda_sh.model.transiente.Filtro;
import com.t2ti.retaguarda_sh.model.transiente.ObjetoPagSeguro;
import com.t2ti.retaguarda_sh.service.pdv.PdvPlanoPagamentoService;

@RestController
@RequestMapping(value = "/pdv-plano-pagamento", produces = "application/json;charset=UTF-8")
public class PdvPlanoPagamentoController {

	@Autowired
	private PdvPlanoPagamentoService service;
	
	@GetMapping
	public List<PdvPlanoPagamento> consultarLista(@RequestParam(required = false) String filter) {
		try {
			if (filter == null) {
				return service.consultarLista();
			} else {
				// define o filtro
				Filtro filtro = new Filtro(filter);
				return service.consultarLista(filtro);				
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Consultar Lista PdvPlanoPagamento] - Exceção: " + e.getMessage());
		}
	}

	@GetMapping("/{cnpj}")
	public PdvPlanoPagamento consultarObjeto(@RequestHeader("cnpj") String cnpj) {
		try {
			return service.consultarPlanoAtivo(cnpj);
		} catch (NoSuchElementException e) {
			throw new RecursoNaoEncontradoException("Registro não localizado [Consultar Objeto PdvPlanoPagamento].");
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException(
					"Erro no Servidor [Consultar Objeto PdvPlanoPagamento] - Exceção: " + e.getMessage());
		}
	}
	
	@PostMapping
	public PdvPlanoPagamento inserir(@RequestBody ObjetoPagSeguro objJson) {
		try {
			return service.atualizar(objJson);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Atualizar PdvPlanoPagamento] - Exceção: " + e.getMessage());
		}
	}

	@PostMapping("/{codigo}")
	public int confirmarTransacao(@PathVariable String codigo, @RequestHeader("cnpj") String cnpj) {
		try {
		    /*
    	      Vamos usar os códigos HTTP para nossa conveniência:
    	      200 - achou a transação e vinculou o ID da empresa
    	      404 - não achou o código da transação no banco de dados
    	      418 - achou o código da transação, mas ele já foi utilizado
		    */			
			return service.confirmarTransacao(codigo, cnpj);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Atualizar PdvPlanoPagamento] - Exceção: " + e.getMessage());
		}
	}
	
	@PutMapping("/{id}")
	public PdvPlanoPagamento alterar(@RequestBody PdvPlanoPagamento objJson, @PathVariable Integer id) {	
		try {			
			if (!objJson.getId().equals(id)) {
				throw new RequisicaoRuimException("Objeto inválido [Alterar PdvPlanoPagamento] - ID do objeto difere do ID da URL.");
			}

			PdvPlanoPagamento objeto = service.consultarObjeto(objJson.getId());
			if (objeto != null) {
				return service.salvar(objJson);				
			} else
			{
				throw new RequisicaoRuimException("Objeto com ID inválido [Alterar PdvPlanoPagamento].");				
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Alterar PdvPlanoPagamento] - Exceção: " + e.getMessage());
		}
	}
	
	@DeleteMapping("/{id}")
	public void excluir(@PathVariable Integer id) {
		try {
			service.excluir(id);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Excluir PdvPlanoPagamento] - Exceção: " + e.getMessage());
		}
	}
	
}