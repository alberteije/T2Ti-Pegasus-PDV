package com.t2ti.retaguarda_sh.model.transiente;

import java.io.Serializable;

public class ObjetoNfe implements Serializable {
	private static final long serialVersionUID = 1L;

	private String cnpj;
	private String justificativa;
	private String ano;
	private String modelo;
	private String serie;
	private String numeroInicial;
	private String numeroFinal;
	private String chaveAcesso;

	public ObjetoNfe() {}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public String getJustificativa() {
		return justificativa;
	}

	public void setJustificativa(String justificativa) {
		this.justificativa = justificativa;
	}

	public String getAno() {
		return ano;
	}

	public void setAno(String ano) {
		this.ano = ano;
	}

	public String getModelo() {
		return modelo;
	}

	public void setModelo(String modelo) {
		this.modelo = modelo;
	}

	public String getSerie() {
		return serie;
	}

	public void setSerie(String serie) {
		this.serie = serie;
	}

	public String getNumeroInicial() {
		return numeroInicial;
	}

	public void setNumeroInicial(String numeroInicial) {
		this.numeroInicial = numeroInicial;
	}

	public String getNumeroFinal() {
		return numeroFinal;
	}

	public void setNumeroFinal(String numeroFinal) {
		this.numeroFinal = numeroFinal;
	}

	public String getChaveAcesso() {
		return chaveAcesso;
	}

	public void setChaveAcesso(String chaveAcesso) {
		this.chaveAcesso = chaveAcesso;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}


}