package com.t2ti.fenix.model.cadastros;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Cargo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String nome;
	private String descricao;
	private BigDecimal salario;
	@Column(name="CBO_1994")
	private String cbo1994;
	@Column(name="CBO_2002")
	private String cbo2002;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public BigDecimal getSalario() {
		return salario;
	}

	public void setSalario(BigDecimal salario) {
		this.salario = salario;
	}

	public String getCbo1994() {
		return cbo1994;
	}

	public void setCbo1994(String cbo1994) {
		this.cbo1994 = cbo1994;
	}

	public String getCbo2002() {
		return cbo2002;
	}

	public void setCbo2002(String cbo2002) {
		this.cbo2002 = cbo2002;
	}

}
