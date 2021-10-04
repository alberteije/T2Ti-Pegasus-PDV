package com.t2ti.fenix.repository.cadastros;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.t2ti.fenix.model.cadastros.Setor;

public interface SetorRepository extends JpaRepository<Setor, Integer> {

	List<Setor> findFirst10ByNomeContaining(String nome);
	
}