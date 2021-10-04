package com.t2ti.fenix.controller.cadastros;

import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.t2ti.fenix.exception.ExcecaoGenericaServidorException;
import com.t2ti.fenix.exception.RecursoNaoEncontradoException;
import com.t2ti.fenix.exception.RequisicaoRuimException;
import com.t2ti.fenix.model.cadastros.Banco;
import com.t2ti.fenix.model.transiente.Filtro;
import com.t2ti.fenix.services.cadastros.BancoService;

@RestController
@RequestMapping("/banco")
public class BancoController {

	@Autowired
	private BancoService service;
	
	@GetMapping
	public List<Banco> consultarLista(@RequestParam(required = false) String filter) {
		try {
			if (filter == null) {
				return service.consultarLista();
			} else {
				// define o filtro
				Filtro filtro = new Filtro(filter);
				return service.consultarLista(filtro);				
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Consultar Lista Banco] - Exceção: " + e.getMessage());
		}
	}

	/*
	 * @RequestMapping(path = "/{campo}/{valor}", method = RequestMethod.GET) public
	 * List<Banco> consultarListaFiltroValor(@PathVariable String
	 * campo, @PathVariable String valor) { try { // define o filtro Filtro filtro =
	 * new Filtro(); filtro.setCampo(campo); filtro.setValor(valor);
	 * 
	 * return service.consultarLista(filtro); } catch (Exception e) { throw new
	 * ExcecaoGenericaServidorException("Erro no Servidor [Lista Banco Filtro Padrão] - Exceção: "
	 * + e.getMessage()); } }
	 */
	
	@GetMapping("/{id}")
	public Banco ConsultarObjeto(@PathVariable Integer id) {
		try {
			try {
				return service.consultarObjeto(id);
			} catch (NoSuchElementException e) {
				throw new RecursoNaoEncontradoException("Registro não localizado [Consultar Objeto Banco].");
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Consultar Objeto Banco] - Exceção: " + e.getMessage());
		}
	}
	
	@PostMapping
	public Banco inserir(@RequestBody Banco banco) {
		try {
			return service.salvar(banco);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Inserir Banco] - Exceção: " + e.getMessage());
		}
	}

	@PutMapping("/{id}")
	public Banco alterar(@RequestBody Banco banco, @PathVariable Integer id) {	
		try {			
			if (!banco.getId().equals(id)) {
				throw new RequisicaoRuimException("Objeto inválido [Alterar Banco] - ID do objeto difere do ID da URL.");
			}

			Banco objeto = service.consultarObjeto(banco.getId());
			if (objeto != null) {
				return service.salvar(banco);				
			} else
			{
				throw new RequisicaoRuimException("Objeto com ID inválido [Alterar Banco].");				
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Alterar Banco] - Exceção: " + e.getMessage());
		}
	}
	
	@DeleteMapping("/{id}")
	public void excluir(@PathVariable Integer id) {
		try {
			service.excluir(id);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Excluir Banco] - Exceção: " + e.getMessage());
		}
	}
	
}