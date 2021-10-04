package com.t2ti.fenix.repository.cadastros;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.t2ti.fenix.model.cadastros.TipoColaborador;

public interface TipoColaboradorRepository extends JpaRepository<TipoColaborador, Integer> {

	List<TipoColaborador> findFirst10ByNomeContaining(String nome);
	
}