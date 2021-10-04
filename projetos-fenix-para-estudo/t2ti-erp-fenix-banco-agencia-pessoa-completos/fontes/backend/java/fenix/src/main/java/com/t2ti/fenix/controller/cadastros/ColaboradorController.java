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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.t2ti.fenix.exception.RecursoNaoEncontradoException;
//import com.t2ti.fenix.exception.UploadException;
import com.t2ti.fenix.model.cadastros.Colaborador;
import com.t2ti.fenix.service.cadastros.ColaboradorService;

@RestController
@RequestMapping("/colaborador")
public class ColaboradorController {

	@Autowired
	private ColaboradorService service;
	
	@GetMapping
	public List<Colaborador> listaTodos() {
		return service.listaTodos();
	}
	
	@GetMapping("/{id}")
	public Colaborador buscaPorId(@PathVariable Integer id) {
		try {
			return service.buscaPorId(id);
		} catch (NoSuchElementException e) {
			throw new RecursoNaoEncontradoException("Registro não localizado.");
		}
	}
	
	@PostMapping
	public Colaborador salvaObjeto(@RequestBody Colaborador colaborador) {
		return service.salvaObjeto(colaborador);
	}
	
	@DeleteMapping("/{id}")
	public void excluirObjeto(@PathVariable Integer id) {
		service.excluirObjeto(id);
	}

	@PostMapping("/upload/{id}")
	public void uploadFoto(@RequestParam("foto") MultipartFile file, @PathVariable Integer id) {
		try {
			service.uploadFoto(file, id);
		} catch (Exception e) {
//			throw new UploadException(e.getMessage());
		}
	}
}
