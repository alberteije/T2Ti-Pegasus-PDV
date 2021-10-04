package com.t2ti.fenix.repository.cadastros;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.t2ti.fenix.model.cadastros.ContaCaixa;

public interface ContaCaixaRepository extends JpaRepository<ContaCaixa, Integer> {

	List<ContaCaixa> findFirst10ByNomeContaining(String nome);
	
}