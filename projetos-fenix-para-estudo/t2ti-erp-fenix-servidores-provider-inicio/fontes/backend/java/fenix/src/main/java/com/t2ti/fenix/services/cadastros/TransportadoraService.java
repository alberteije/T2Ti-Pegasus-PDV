package com.t2ti.fenix.services.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Transportadora;
import com.t2ti.fenix.repository.cadastros.TransportadoraRepository;

@Service
public class TransportadoraService {

	@Autowired
	private TransportadoraRepository repository;
	
	public List<Transportadora> listaTodos() {
		return repository.findAll();
	}

	public List<Transportadora> listaTodos(String nome) {
		return repository.findFirst10ByPessoaNomeContaining(nome);
	}
	
	public Transportadora buscaPorId(Integer id) {
		return repository.findById(id).get();
	}
	
	public Transportadora salvaObjeto(Transportadora transportadora) {
		return repository.save(transportadora);
	}
	
	public void excluirObjeto(Integer id) {
		Transportadora transportadora = new Transportadora();
		transportadora.setId(id);
		repository.delete(transportadora);
	}
	
}
