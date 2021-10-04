package com.t2ti.fenix.service.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.ContaCaixa;
import com.t2ti.fenix.repository.cadastros.ContaCaixaRepository;

@Service
public class ContaCaixaService {

	@Autowired
	private ContaCaixaRepository repository;
	
	public List<ContaCaixa> listaTodos() {
		return repository.findAll();
	}

	public List<ContaCaixa> listaTodos(String nome) {
		return repository.findFirst10ByNomeContaining(nome);
	}
	
	public ContaCaixa buscaPorId(Integer id) {
		return repository.findById(id).get();
	}
	
	public ContaCaixa salvaObjeto(ContaCaixa contaCaixa) {
		return repository.save(contaCaixa);
	}
	
	public void excluirObjeto(Integer id) {
		ContaCaixa contaCaixa = new ContaCaixa();
		contaCaixa.setId(id);
		repository.delete(contaCaixa);
	}
	
}
