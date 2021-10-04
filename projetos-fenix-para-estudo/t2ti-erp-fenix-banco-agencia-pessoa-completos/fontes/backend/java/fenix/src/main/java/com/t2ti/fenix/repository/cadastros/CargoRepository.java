package com.t2ti.fenix.repository.cadastros;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.t2ti.fenix.model.cadastros.Cargo;

public interface CargoRepository extends JpaRepository<Cargo, Integer> {

	List<Cargo> findFirst10ByNomeContaining(String nome);
	
}