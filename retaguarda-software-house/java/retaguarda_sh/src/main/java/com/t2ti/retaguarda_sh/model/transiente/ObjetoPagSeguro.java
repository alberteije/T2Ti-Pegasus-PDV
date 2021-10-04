package com.t2ti.retaguarda_sh.model.transiente;

import java.io.Serializable;
import java.math.BigDecimal;

public class ObjetoPagSeguro implements Serializable {
	private static final long serialVersionUID = 1L;

	private String codigoTransacao;
	private String statusTransacao;
	private String codigoStatusTransacao;
	private String emailCliente;
	private String metodoPagamento;
	private String codigoTipoPagamento;
	private String codigoProduto;
	private String descricaoProduto;
	private BigDecimal valorUnitario;

	public ObjetoPagSeguro() {}

	public String getCodigoTransacao() {
		return codigoTransacao;
	}

	public void setCodigoTransacao(String codigoTransacao) {
		this.codigoTransacao = codigoTransacao;
	}

	public String getStatusTransacao() {
		return statusTransacao;
	}

	public void setStatusTransacao(String statusTransacao) {
		this.statusTransacao = statusTransacao;
	}

	public String getCodigoStatusTransacao() {
		return codigoStatusTransacao;
	}

	public void setCodigoStatusTransacao(String codigoStatusTransacao) {
		this.codigoStatusTransacao = codigoStatusTransacao;
	}

	public String getEmailCliente() {
		return emailCliente;
	}

	public void setEmailCliente(String emailCliente) {
		this.emailCliente = emailCliente;
	}

	public String getMetodoPagamento() {
		return metodoPagamento;
	}

	public void setMetodoPagamento(String metodoPagamento) {
		this.metodoPagamento = metodoPagamento;
	}

	public String getCodigoTipoPagamento() {
		return codigoTipoPagamento;
	}

	public void setCodigoTipoPagamento(String codigoTipoPagamento) {
		this.codigoTipoPagamento = codigoTipoPagamento;
	}

	public String getCodigoProduto() {
		return codigoProduto;
	}

	public void setCodigoProduto(String codigoProduto) {
		this.codigoProduto = codigoProduto;
	}

	public String getDescricaoProduto() {
		return descricaoProduto;
	}

	public void setDescricaoProduto(String descricaoProduto) {
		this.descricaoProduto = descricaoProduto;
	}

	public BigDecimal getValorUnitario() {
		return valorUnitario;
	}

	public void setValorUnitario(BigDecimal valorUnitario) {
		this.valorUnitario = valorUnitario;
	}
	

}