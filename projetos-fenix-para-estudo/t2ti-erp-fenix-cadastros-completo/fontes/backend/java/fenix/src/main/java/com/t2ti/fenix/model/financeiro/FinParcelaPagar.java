/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_PARCELA_PAGAR] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
package com.t2ti.fenix.model.financeiro;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.t2ti.fenix.model.cadastros.BancoContaCaixa;

@Entity
@Table(name="FIN_PARCELA_PAGAR")
@NamedQuery(name="FinParcelaPagar.findAll", query="SELECT t FROM FinParcelaPagar t")
public class FinParcelaPagar implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Column(name="NUMERO_PARCELA")
	private Integer numeroParcela;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_EMISSAO")
	private Date dataEmissao;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_VENCIMENTO")
	private Date dataVencimento;

    @Temporal(TemporalType.DATE)
	@Column(name="DESCONTO_ATE")
	private Date descontoAte;

    @Column(name="VALOR")
	private BigDecimal valor;

    @Column(name="TAXA_JURO")
	private BigDecimal taxaJuro;

    @Column(name="TAXA_MULTA")
	private BigDecimal taxaMulta;

    @Column(name="TAXA_DESCONTO")
	private BigDecimal taxaDesconto;

    @Column(name="VALOR_JURO")
	private BigDecimal valorJuro;

    @Column(name="VALOR_MULTA")
	private BigDecimal valorMulta;

    @Column(name="VALOR_DESCONTO")
	private BigDecimal valorDesconto;

    @Column(name="VALOR_PAGO")
	private BigDecimal valorPago;

    @Column(name="HISTORICO")
	private String historico;

    @ManyToOne
	@JoinColumn(name="ID_FIN_STATUS_PARCELA")
    private FinStatusParcela finStatusParcela;

    @ManyToOne
	@JoinColumn(name="ID_BANCO_CONTA_CAIXA")
    private BancoContaCaixa bancoContaCaixa;

    @ManyToOne
	@JoinColumn(name="ID_FIN_TIPO_PAGAMENTO")
    private FinTipoPagamento finTipoPagamento;

    @ManyToOne
	@JoinColumn(name="ID_FIN_CHEQUE_EMITIDO")
    private FinChequeEmitido finChequeEmitido;

    @ManyToOne
	@JsonIgnore
	@JoinColumn(name="ID_FIN_LANCAMENTO_PAGAR")
    private FinLancamentoPagar finLancamentoPagar;

	public FinParcelaPagar() {
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public Integer getNumeroParcela() {
		return this.numeroParcela;
	}

	public void setNumeroParcela(Integer numeroParcela) {
		this.numeroParcela = numeroParcela;
	}

    public Date getDataEmissao() {
		return this.dataEmissao;
	}

	public void setDataEmissao(Date dataEmissao) {
		this.dataEmissao = dataEmissao;
	}

    public Date getDataVencimento() {
		return this.dataVencimento;
	}

	public void setDataVencimento(Date dataVencimento) {
		this.dataVencimento = dataVencimento;
	}

    public Date getDescontoAte() {
		return this.descontoAte;
	}

	public void setDescontoAte(Date descontoAte) {
		this.descontoAte = descontoAte;
	}

    public BigDecimal getValor() {
		return this.valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

    public BigDecimal getTaxaJuro() {
		return this.taxaJuro;
	}

	public void setTaxaJuro(BigDecimal taxaJuro) {
		this.taxaJuro = taxaJuro;
	}

    public BigDecimal getTaxaMulta() {
		return this.taxaMulta;
	}

	public void setTaxaMulta(BigDecimal taxaMulta) {
		this.taxaMulta = taxaMulta;
	}

    public BigDecimal getTaxaDesconto() {
		return this.taxaDesconto;
	}

	public void setTaxaDesconto(BigDecimal taxaDesconto) {
		this.taxaDesconto = taxaDesconto;
	}

    public BigDecimal getValorJuro() {
		return this.valorJuro;
	}

	public void setValorJuro(BigDecimal valorJuro) {
		this.valorJuro = valorJuro;
	}

    public BigDecimal getValorMulta() {
		return this.valorMulta;
	}

	public void setValorMulta(BigDecimal valorMulta) {
		this.valorMulta = valorMulta;
	}

    public BigDecimal getValorDesconto() {
		return this.valorDesconto;
	}

	public void setValorDesconto(BigDecimal valorDesconto) {
		this.valorDesconto = valorDesconto;
	}

    public BigDecimal getValorPago() {
		return this.valorPago;
	}

	public void setValorPago(BigDecimal valorPago) {
		this.valorPago = valorPago;
	}

    public String getHistorico() {
		return this.historico;
	}

	public void setHistorico(String historico) {
		this.historico = historico;
	}

    public FinLancamentoPagar getFinLancamentoPagar() {
		return this.finLancamentoPagar;
	}

	public void setFinLancamentoPagar(FinLancamentoPagar finLancamentoPagar) {
		this.finLancamentoPagar = finLancamentoPagar;
	}

    public FinStatusParcela getFinStatusParcela() {
		return this.finStatusParcela;
	}

	public void setFinStatusParcela(FinStatusParcela finStatusParcela) {
		this.finStatusParcela = finStatusParcela;
	}

    public BancoContaCaixa getBancoContaCaixa() {
		return this.bancoContaCaixa;
	}

	public void setBancoContaCaixa(BancoContaCaixa bancoContaCaixa) {
		this.bancoContaCaixa = bancoContaCaixa;
	}

    public FinTipoPagamento getFinTipoPagamento() {
		return this.finTipoPagamento;
	}

	public void setFinTipoPagamento(FinTipoPagamento finTipoPagamento) {
		this.finTipoPagamento = finTipoPagamento;
	}

    public FinChequeEmitido getFinChequeEmitido() {
		return this.finChequeEmitido;
	}

	public void setFinChequeEmitido(FinChequeEmitido finChequeEmitido) {
		this.finChequeEmitido = finChequeEmitido;
	}

		
}