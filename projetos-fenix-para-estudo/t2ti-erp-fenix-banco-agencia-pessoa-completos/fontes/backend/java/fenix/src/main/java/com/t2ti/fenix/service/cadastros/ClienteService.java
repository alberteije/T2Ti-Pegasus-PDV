package com.t2ti.fenix.service.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Cliente;
import com.t2ti.fenix.repository.cadastros.ClienteRepository;

@Service
public class ClienteService {

	@Autowired
	private ClienteRepository repository;
	
	public List<Cliente> listaTodos() {
		return repository.findAll();
	}

	public List<Cliente> listaTodos(String nome) {
		return repository.findFirst10ByPessoaNomeContaining(nome);
	}
	
	public Cliente buscaPorId(Integer id) {
		return repository.findById(id).get();
	}
	
	public Cliente salvaObjeto(Cliente cliente) {
		return repository.save(cliente);
	}
	
	public void excluirObjeto(Integer id) {
		Cliente cliente = new Cliente();
		cliente.setId(id);
		repository.delete(cliente);
	}
	
}
