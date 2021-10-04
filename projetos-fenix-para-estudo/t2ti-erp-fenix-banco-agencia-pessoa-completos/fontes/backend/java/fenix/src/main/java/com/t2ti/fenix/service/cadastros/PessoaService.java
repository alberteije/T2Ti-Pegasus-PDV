package com.t2ti.fenix.service.cadastros;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Pessoa;
import com.t2ti.fenix.repository.cadastros.PessoaRepository;
import com.t2ti.fenix.model.transiente.Filtro;

@Service
public class PessoaService {

	@Autowired
	private PessoaRepository repository;
	
	@PersistenceContext
    private EntityManager entityManager;	
	
	public List<Pessoa> consultarLista() {
		return repository.findAll();
	}

	@SuppressWarnings("unchecked")
	public List<Pessoa> consultarLista(Filtro filtro) {
		String sql = "select * from pessoa where " + filtro.getWhere();
		Query query = entityManager.createNativeQuery(sql, Pessoa.class);
		List<Pessoa> lista = (List<Pessoa>) query.getResultList();
		return lista;
	}
	
	public Pessoa consultarObjeto(Integer id) {
		return repository.findById(id).get();
	}
	
	public Pessoa salvar(Pessoa objeto) {
		return repository.save(objeto);
	}
		
	public void excluir(Integer id) {
		Pessoa objeto = consultarObjeto(id);
		repository.delete(objeto);
	}
	
}