package com.t2ti.fenix.service.cadastros;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.t2ti.fenix.model.cadastros.Produto;
import com.t2ti.fenix.repository.cadastros.ProdutoRepository;

@Service
public class ProdutoService {

	@Autowired
	private ProdutoRepository repository;
	
	public List<Produto> listaTodos() {
		return repository.findAll();
	}
	
	public List<Produto> listaTodos(String nome) {
		return repository.findFirst10ByNomeContaining(nome);
	}
	
	public Produto buscaPorId(Integer id) {
		return repository.findById(id).get();
	}
	
	public Produto salvaObjeto(Produto produto) {
		return repository.save(produto);
	}
	
	public void excluirObjeto(Integer id) {
		Produto produto = new Produto();
		produto.setId(id);
		repository.delete(produto);
	}
	
}
