package com.t2ti.fenix.model.cadastros;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


/**
 * The persistent class for the produto_grupo database table.
 * 
 */
@Entity
@Table(name="produto_grupo")
@NamedQuery(name="ProdutoGrupo.findAll", query="SELECT p FROM ProdutoGrupo p")
public class ProdutoGrupo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private Integer id;

	@Lob
	private String descricao;

	private String nome;

	public ProdutoGrupo() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDescricao() {
		return this.descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

}