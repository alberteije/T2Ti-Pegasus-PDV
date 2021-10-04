package com.t2ti.fenix.services.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Fornecedor;
import com.t2ti.fenix.repository.cadastros.FornecedorRepository;

@Service
public class FornecedorService {

	@Autowired
	private FornecedorRepository repository;
	
	public List<Fornecedor> listaTodos() {
		return repository.findAll();
	}
	
	public List<Fornecedor> listaTodos(String nome) {
		return repository.findFirst10ByPessoaNomeContaining(nome);
	}
	
	public Fornecedor buscaPorId(Integer id) {
		return repository.findById(id).get();
	}
	
	public Fornecedor salvaObjeto(Fornecedor fornecedor) {
		return repository.save(fornecedor);
	}
	
	public void excluirObjeto(Integer id) {
		Fornecedor fornecedor = new Fornecedor();
		fornecedor.setId(id);
		repository.delete(fornecedor);
	}
	
}
