package com.t2ti.fenix.repository.cadastros;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.t2ti.fenix.model.cadastros.Transportadora;

public interface TransportadoraRepository extends JpaRepository<Transportadora, Integer> {

	List<Transportadora> findFirst10ByPessoaNomeContaining(String nome);
	
}