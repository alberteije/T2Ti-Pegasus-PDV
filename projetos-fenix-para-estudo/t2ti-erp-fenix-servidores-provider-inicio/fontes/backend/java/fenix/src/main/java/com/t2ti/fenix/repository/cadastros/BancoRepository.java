package com.t2ti.fenix.repository.cadastros;

import org.springframework.data.jpa.repository.JpaRepository;

import com.t2ti.fenix.model.cadastros.Banco;

public interface BancoRepository extends JpaRepository<Banco, Integer> {}