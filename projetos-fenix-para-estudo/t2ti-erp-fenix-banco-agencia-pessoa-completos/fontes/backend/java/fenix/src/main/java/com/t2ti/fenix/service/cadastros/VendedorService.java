package com.t2ti.fenix.service.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Vendedor;
import com.t2ti.fenix.repository.cadastros.VendedorRepository;

@Service
public class VendedorService {

	@Autowired
	private VendedorRepository repository;
	
	public List<Vendedor> listaTodos() {
		return repository.findAll();
	}

	public List<Vendedor> listaTodos(String nome) {
		return repository.findFirst10ByColaboradorPessoaNomeContaining(nome);
	}
	
	public Vendedor buscaPorId(Integer id) {
		return repository.findById(id).get();
	}
	
	public Vendedor salvaObjeto(Vendedor vendedor) {
		return repository.save(vendedor);
	}
	
	public void excluirObjeto(Integer id) {
		Vendedor vendedor = new Vendedor();
		vendedor.setId(id);
		repository.delete(vendedor);
	}
	
}
