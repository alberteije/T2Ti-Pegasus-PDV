package com.t2ti.fenix.services.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Pessoa;
import com.t2ti.fenix.repository.cadastros.PessoaRepository;

@Service
public class PessoaService {

	@Autowired
	private PessoaRepository repository;
	
	public List<Pessoa> consultarLista() {
		return repository.findAll();
	}
		
	public Pessoa consultarObjeto(Integer id) {
		return repository.findById(id).get();
	}
	
	public Pessoa salvar(Pessoa pessoa) {
		return repository.save(pessoa);
	}
	
	public void excluir(Integer id) {
		Pessoa pessoa = new Pessoa();
		pessoa.setId(id);
		repository.delete(pessoa);
	}
	
}
