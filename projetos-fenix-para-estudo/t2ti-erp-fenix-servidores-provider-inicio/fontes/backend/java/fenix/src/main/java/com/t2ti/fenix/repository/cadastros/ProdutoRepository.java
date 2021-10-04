package com.t2ti.fenix.repository.cadastros;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.t2ti.fenix.model.cadastros.Produto;

public interface ProdutoRepository extends JpaRepository<Produto, Integer> {

	List<Produto> findFirst10ByNomeContaining(String nome);
	
}