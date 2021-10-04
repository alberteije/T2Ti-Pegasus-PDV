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

import com.fasterxml.jackson.annotation.JsonIgnore;


/**
 * The persistent class for the pessoa_endereco database table.
 * 
 */
@Entity
@Table(name="pessoa_endereco")
@NamedQuery(name="PessoaEndereco.findAll", query="SELECT pe FROM PessoaEndereco pe")
public class PessoaEndereco implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name="LOGRADOURO")
	private String logradouro;

	@Column(name="NUMERO")
	private String numero;

	@Column(name="BAIRRO")
	private String bairro;
	
	@Column(name="MUNICIPIO_IBGE")
	private Integer municipioIbge;
	
	@Column(name="COMPLEMENTO")
	private String complemento;

	@Column(name="PRINCIPAL")
	private String principal;
	
	@Column(name="ENTREGA")
	private String entrega;
	
	@Column(name="COBRANCA")
	private String cobranca;

	@Column(name="CORRESPONDENCIA")
	private String correspondencia;

	@Column(name="UF")
	private String uf;

	@Column(name="CEP")
	private String cep;

	@Column(name="CIDADE")
	private String cidade;
	
	@ManyToOne
	@JsonIgnore
	@JoinColumn(name="ID_PESSOA")
	private Pessoa pessoa;

	public PessoaEndereco() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLogradouro() {
		return logradouro;
	}

	public void setLogradouro(String logradouro) {
		this.logradouro = logradouro;
	}

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public Integer getMunicipioIbge() {
		return municipioIbge;
	}

	public void setMunicipioIbge(Integer municipioIbge) {
		this.municipioIbge = municipioIbge;
	}

	public String getComplemento() {
		return complemento;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

	public String getPrincipal() {
		return principal;
	}

	public void setPrincipal(String principal) {
		this.principal = principal;
	}

	public String getEntrega() {
		return entrega;
	}

	public void setEntrega(String entrega) {
		this.entrega = entrega;
	}

	public String getCobranca() {
		return cobranca;
	}

	public void setCobranca(String cobranca) {
		this.cobranca = cobranca;
	}

	public String getCorrespondencia() {
		return correspondencia;
	}

	public void setCorrespondencia(String correspondencia) {
		this.correspondencia = correspondencia;
	}

	public String getUf() {
		return uf;
	}

	public void setUf(String uf) {
		this.uf = uf;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public Pessoa getPessoa() {
		return pessoa;
	}

	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}


}