package com.t2ti.fenix.model.cadastros;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


/**
 * The persistent class for the unidade_produto database table.
 * 
 */
@Entity
@Table(name="unidade_produto")
@NamedQuery(name="UnidadeProduto.findAll", query="SELECT u FROM UnidadeProduto u")
public class UnidadeProduto implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private Integer id;

	@Lob
	private String descricao;

	@Column(name="PODE_FRACIONAR")
	private String podeFracionar;

	private String sigla;

	public UnidadeProduto() {
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

	public String getPodeFracionar() {
		return this.podeFracionar;
	}

	public void setPodeFracionar(String podeFracionar) {
		this.podeFracionar = podeFracionar;
	}

	public String getSigla() {
		return this.sigla;
	}

	public void setSigla(String sigla) {
		this.sigla = sigla;
	}

}