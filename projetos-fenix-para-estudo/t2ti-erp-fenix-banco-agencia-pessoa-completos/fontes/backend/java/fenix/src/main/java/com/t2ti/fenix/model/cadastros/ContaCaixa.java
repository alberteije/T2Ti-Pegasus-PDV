package com.t2ti.fenix.model.cadastros;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


/**
 * The persistent class for the conta_caixa database table.
 * 
 */
@Entity
@Table(name="conta_caixa")
@NamedQuery(name="ContaCaixa.findAll", query="SELECT c FROM ContaCaixa c")
public class ContaCaixa implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private String codigo;

	@Lob
	private String descricao;

	private String digito;

	private String nome;

	private String tipo;

	//bi-directional many-to-one association to AgenciaBanco
	@ManyToOne
	@JoinColumn(name="ID_AGENCIA_BANCO")
	private BancoAgencia agenciaBanco;


	public ContaCaixa() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCodigo() {
		return this.codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getDescricao() {
		return this.descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getDigito() {
		return this.digito;
	}

	public void setDigito(String digito) {
		this.digito = digito;
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getTipo() {
		return this.tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public BancoAgencia getAgenciaBanco() {
		return this.agenciaBanco;
	}

	public void setAgenciaBanco(BancoAgencia agenciaBanco) {
		this.agenciaBanco = agenciaBanco;
	}

}