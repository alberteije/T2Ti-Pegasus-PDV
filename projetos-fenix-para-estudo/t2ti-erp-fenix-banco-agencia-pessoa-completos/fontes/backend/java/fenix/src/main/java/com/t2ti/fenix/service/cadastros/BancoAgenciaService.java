package com.t2ti.fenix.service.cadastros;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.BancoAgencia;
import com.t2ti.fenix.model.transiente.Filtro;
import com.t2ti.fenix.repository.cadastros.BancoAgenciaRepository;

@Service
public class BancoAgenciaService {

	@Autowired
	private BancoAgenciaRepository repository;
	
	@PersistenceContext
    private EntityManager entityManager;	
	
	public List<BancoAgencia> consultarLista() {
		return repository.findAll();
	}

	@SuppressWarnings("unchecked")
	public List<BancoAgencia> consultarLista(Filtro filtro) {
		String sql = "select * from banco_agencia where " + filtro.getWhere();
		Query query = entityManager.createNativeQuery(sql, BancoAgencia.class);
		List<BancoAgencia> lista = (List<BancoAgencia>) query.getResultList();
		return lista;
	}
	
	public BancoAgencia consultarObjeto(Integer id) {
		return repository.findById(id).get();
	}
	
	public BancoAgencia salvar(BancoAgencia objeto) {
		return repository.save(objeto);
	}
		
	public void excluir(Integer id) {
		BancoAgencia objeto = new BancoAgencia();
		objeto.setId(id);
		repository.delete(objeto);
	}
	
}
