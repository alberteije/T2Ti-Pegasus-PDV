package com.t2ti.fenix.model.cadastros;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


/**
 * The persistent class for the banco_agencia database table.
 * 
 */
@Entity
@Table(name="banco_agencia")
@NamedQuery(name="BancoAgencia.findAll", query="SELECT ba FROM BancoAgencia ba")
public class BancoAgencia implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name="NUMERO")
	private String numero;

	@Column(name="DIGITO")
	private String digito;
	
	@Column(name="NOME")
	private String nome;

	@Column(name="TELEFONE")
	private String telefone;

	@Column(name="CONTATO")
	private String contato;

	@Column(name="OBSERVACAO")
	private String observacao;

	@Column(name="GERENTE")
	private String gerente;

	//bi-directional many-to-one association to Banco
	@ManyToOne
	@JoinColumn(name="ID_BANCO")
	private Banco banco;
	
	public BancoAgencia() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	public String getDigito() {
		return digito;
	}

	public void setDigito(String digito) {
		this.digito = digito;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getContato() {
		return contato;
	}

	public void setContato(String contato) {
		this.contato = contato;
	}

	public String getObservacao() {
		return observacao;
	}

	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}

	public String getGerente() {
		return gerente;
	}

	public void setGerente(String gerente) {
		this.gerente = gerente;
	}

	public Banco getBanco() {
		return banco;
	}

	public void setBanco(Banco banco) {
		this.banco = banco;
	}

}