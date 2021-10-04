package com.t2ti.fenix.model.cadastros;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;


/**
 * The persistent class for the pessoa database table.
 * 
 */
@Entity
@Table(name="pessoa")
@NamedQuery(name="Pessoa.findAll", query="SELECT p FROM Pessoa p")
public class Pessoa implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name="NOME")
	private String nome;

	@Column(name="TIPO")
	private String tipo;

	@Column(name="SITE")
	private String site;

	@Column(name="EMAIL")
	private String email;

	@Column(name="CLIENTE")
	private String cliente;

	@Column(name="FORNECEDOR")
	private String fornecedor;

	@Column(name="TRANSPORTADORA")
	private String transportadora;

	@Column(name="COLABORADOR")
	private String colaborador;
	
	@Column(name="CONTADOR")
	private String contador;

	@OneToOne(mappedBy = "pessoa", cascade = CascadeType.ALL, orphanRemoval = true)	
	private PessoaJuridica pessoaJuridica;

	@OneToOne(mappedBy = "pessoa", cascade = CascadeType.ALL, orphanRemoval = true)	
	private PessoaFisica pessoaFisica;
	
	@OneToMany(mappedBy = "pessoa", cascade = CascadeType.ALL, orphanRemoval = true)	
	private Set<PessoaContato> listaPessoaContato;

	@OneToMany(mappedBy = "pessoa", cascade = CascadeType.ALL, orphanRemoval = true)	
	private Set<PessoaEndereco> listaPessoaEndereco;

	@OneToMany(mappedBy = "pessoa", cascade = CascadeType.ALL, orphanRemoval = true)	
	private Set<PessoaTelefone> listaPessoaTelefone;
	
	public Pessoa() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCliente() {
		return this.cliente;
	}

	public void setCliente(String cliente) {
		this.cliente = cliente;
	}

	public String getColaborador() {
		return this.colaborador;
	}

	public void setColaborador(String colaborador) {
		this.colaborador = colaborador;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFornecedor() {
		return this.fornecedor;
	}

	public void setFornecedor(String fornecedor) {
		this.fornecedor = fornecedor;
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getSite() {
		return this.site;
	}

	public void setSite(String site) {
		this.site = site;
	}

	public String getTipo() {
		return this.tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getTransportadora() {
		return this.transportadora;
	}

	public void setTransportadora(String transportadora) {
		this.transportadora = transportadora;
	}

	public String getContador() {
		return contador;
	}

	public void setContador(String contador) {
		this.contador = contador;
	}

	public PessoaJuridica getPessoaJuridica() {
		return pessoaJuridica;
	}

	public void setPessoaJuridica(PessoaJuridica pessoaJuridica) {
		this.pessoaJuridica = pessoaJuridica;
		if (pessoaJuridica != null) {
			pessoaJuridica.setPessoa(this);
		}
	}

	public PessoaFisica getPessoaFisica() {
		return pessoaFisica;
	}

	public void setPessoaFisica(PessoaFisica pessoaFisica) {
		this.pessoaFisica = pessoaFisica;
		if (pessoaFisica != null) {
			pessoaFisica.setPessoa(this);
		}
	}
	
	public Set<PessoaContato> getListaPessoaContato() {
		return listaPessoaContato;
	}

	public void setListaPessoaContato(Set<PessoaContato> listaPessoaContato) {
		this.listaPessoaContato = listaPessoaContato;
		for (PessoaContato pessoaContato : listaPessoaContato) {
			pessoaContato.setPessoa(this);
		}		
	}

	public Set<PessoaEndereco> getListaPessoaEndereco() {
		return listaPessoaEndereco;
	}

	public void setListaPessoaEndereco(Set<PessoaEndereco> listaPessoaEndereco) {
		this.listaPessoaEndereco = listaPessoaEndereco;
		for (PessoaEndereco pessoaEndereco : listaPessoaEndereco) {
			pessoaEndereco.setPessoa(this);
		}		
	}

	public Set<PessoaTelefone> getListaPessoaTelefone() {
		return listaPessoaTelefone;
	}

	public void setListaPessoaTelefone(Set<PessoaTelefone> listaPessoaTelefone) {
		this.listaPessoaTelefone = listaPessoaTelefone;
		for (PessoaTelefone pessoaTelefone : listaPessoaTelefone) {
			pessoaTelefone.setPessoa(this);
		}		
	}
	
}