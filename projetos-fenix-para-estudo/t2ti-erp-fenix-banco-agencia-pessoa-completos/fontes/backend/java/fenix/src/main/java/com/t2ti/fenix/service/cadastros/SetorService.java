package com.t2ti.fenix.service.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Setor;
import com.t2ti.fenix.repository.cadastros.SetorRepository;

@Service
public class SetorService {

	@Autowired
	private SetorRepository repository;
	
	public List<Setor> listaTodos() {
		return repository.findAll();
	}
	
	public List<Setor> listaTodos(String nome) {
		return repository.findFirst10ByNomeContaining(nome);
	}
	
	public Setor buscaPorId(Integer id) {
		return repository.findById(id).get();
	}
	
	public Setor salvaObjeto(Setor setor) {
		return repository.save(setor);
	}
	
	public void excluirObjeto(Integer id) {
		Setor setor = new Setor();
		setor.setId(id);
		repository.delete(setor);
	}
	
}
