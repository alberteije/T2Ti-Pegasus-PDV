package com.t2ti.fenix.model.cadastros;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


/**
 * The persistent class for the produto_sub_grupo database table.
 * 
 */
@Entity
@Table(name="produto_sub_grupo")
@NamedQuery(name="ProdutoSubGrupo.findAll", query="SELECT p FROM ProdutoSubGrupo p")
public class ProdutoSubGrupo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private Integer id;

	@Lob
	private String descricao;

	private String nome;

	//bi-directional many-to-one association to ProdutoGrupo
	@ManyToOne
	@JoinColumn(name="ID_GRUPO")
	private ProdutoGrupo produtoGrupo;

	public ProdutoSubGrupo() {
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

	public ProdutoGrupo getProdutoGrupo() {
		return this.produtoGrupo;
	}

	public void setProdutoGrupo(ProdutoGrupo produtoGrupo) {
		this.produtoGrupo = produtoGrupo;
	}

}