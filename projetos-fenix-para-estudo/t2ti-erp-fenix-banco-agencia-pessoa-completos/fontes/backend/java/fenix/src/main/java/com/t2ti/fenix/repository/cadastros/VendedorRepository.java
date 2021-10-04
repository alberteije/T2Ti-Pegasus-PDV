package com.t2ti.fenix.repository.cadastros;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.t2ti.fenix.model.cadastros.Vendedor;

public interface VendedorRepository extends JpaRepository<Vendedor, Integer> {

	List<Vendedor> findFirst10ByColaboradorPessoaNomeContaining(String nome);
	
}