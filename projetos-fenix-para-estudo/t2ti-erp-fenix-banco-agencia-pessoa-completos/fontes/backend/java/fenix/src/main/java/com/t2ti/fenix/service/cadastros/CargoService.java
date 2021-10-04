package com.t2ti.fenix.service.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Cargo;
import com.t2ti.fenix.repository.cadastros.CargoRepository;

@Service
public class CargoService {

	@Autowired
	private CargoRepository repository;
	
	public List<Cargo> consultarLista() {
		return repository.findAll();
	}
	
	public Cargo consultarObjeto(Integer id) {
		return repository.findById(id).get();
	}
	
	public Cargo salvar(Cargo cargo) {
		return repository.save(cargo);
	}
	
	public void excluir(Integer id) {
		Cargo cargo = new Cargo();
		cargo.setId(id);
		repository.delete(cargo);
	}
	
}
