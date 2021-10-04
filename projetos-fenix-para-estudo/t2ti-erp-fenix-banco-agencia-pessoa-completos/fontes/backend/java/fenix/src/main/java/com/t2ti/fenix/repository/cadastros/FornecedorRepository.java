package com.t2ti.fenix.repository.cadastros;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.t2ti.fenix.model.cadastros.Fornecedor;

public interface FornecedorRepository extends JpaRepository<Fornecedor, Integer> {

	List<Fornecedor> findFirst10ByPessoaNomeContaining(String nome);
	
}