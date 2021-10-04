package com.t2ti.fenix.service.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.TipoColaborador;
import com.t2ti.fenix.repository.cadastros.TipoColaboradorRepository;

@Service
public class TipoColaboradorService {

	@Autowired
	private TipoColaboradorRepository repository;
	
	public List<TipoColaborador> listaTodos() {
		return repository.findAll();
	}
	
	public List<TipoColaborador> listaTodos(String nome) {
		return repository.findFirst10ByNomeContaining(nome);
	}
	
	public TipoColaborador buscaPorId(Integer id) {
		return repository.findById(id).get();
	}
	
	public TipoColaborador salvaObjeto(TipoColaborador tipoColaborador) {
		return repository.save(tipoColaborador);
	}
	
	public void excluirObjeto(Integer id) {
		TipoColaborador tipoColaborador = new TipoColaborador();
		tipoColaborador.setId(id);
		repository.delete(tipoColaborador);
	}
	
}
