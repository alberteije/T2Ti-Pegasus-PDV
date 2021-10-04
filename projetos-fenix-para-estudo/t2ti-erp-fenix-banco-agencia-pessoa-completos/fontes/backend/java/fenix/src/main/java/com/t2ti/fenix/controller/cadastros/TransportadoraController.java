package com.t2ti.fenix.controller.cadastros;

import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.t2ti.fenix.exception.RecursoNaoEncontradoException;
import com.t2ti.fenix.model.cadastros.Transportadora;
import com.t2ti.fenix.service.cadastros.TransportadoraService;

@RestController
@RequestMapping("/transportadora")
public class TransportadoraController {

	@Autowired
	private TransportadoraService service;
	
	@GetMapping
	public List<Transportadora> listaTodos() {
		return service.listaTodos();
	}

	@GetMapping("/lista/{nome}")
	public List<Transportadora> listaTodos(@PathVariable String nome) {
		return service.listaTodos(nome);
	}
	
	@GetMapping("/{id}")
	public Transportadora buscaPorId(@PathVariable Integer id) {
		try {
			return service.buscaPorId(id);
		} catch (NoSuchElementException e) {
			throw new RecursoNaoEncontradoException("Registro não localizado.");
		}
	}
	
	@PostMapping
	public Transportadora salvaObjeto(@RequestBody Transportadora transportadora) {
		return service.salvaObjeto(transportadora);
	}
	
	@DeleteMapping("/{id}")
	public void excluirObjeto(@PathVariable Integer id) {
		service.excluirObjeto(id);
	}
	
}
