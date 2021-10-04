package com.t2ti.fenix.service.cadastros;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Banco;
import com.t2ti.fenix.model.transiente.Filtro;
import com.t2ti.fenix.repository.cadastros.BancoRepository;

@Service
public class BancoService {

	@Autowired
	private BancoRepository repository;
	
	@PersistenceContext
    private EntityManager entityManager;	
	
	public List<Banco> consultarLista() {
		return repository.findAll();
	}

	@SuppressWarnings("unchecked")
	public List<Banco> consultarLista(Filtro filtro) {
		String sql = "select * from banco where " + filtro.getWhere();
		Query query = entityManager.createNativeQuery(sql, Banco.class);
		List<Banco> lista = (List<Banco>) query.getResultList();
		return lista;
	}
	
	public Banco consultarObjeto(Integer id) {
		return repository.findById(id).get();
	}
	
	public Banco salvar(Banco objeto) {
		return repository.save(objeto);
	}
		
	public void excluir(Integer id) {
		Banco objeto = new Banco();
		objeto.setId(id);
		repository.delete(objeto);
	}
	
}
