/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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

import com.t2ti.fenix.model.cadastros.BancoContaCaixa;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@Table(name="FIN_FECHAMENTO_CAIXA_BANCO")
@NamedQuery(name="FinFechamentoCaixaBanco.findAll", query="SELECT t FROM FinFechamentoCaixaBanco t")
public class FinFechamentoCaixaBanco implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_FECHAMENTO")
	private Date dataFechamento;

    @Column(name="MES_ANO")
	private String mesAno;

    @Column(name="MES")
	private String mes;

    @Column(name="ANO")
	private String ano;

    @Column(name="SALDO_ANTERIOR")
	private BigDecimal saldoAnterior;

    @Column(name="RECEBIMENTOS")
	private BigDecimal recebimentos;

    @Column(name="PAGAMENTOS")
	private BigDecimal pagamentos;

    @Column(name="SALDO_CONTA")
	private BigDecimal saldoConta;

    @Column(name="CHEQUE_NAO_COMPENSADO")
	private BigDecimal chequeNaoCompensado;

    @Column(name="SALDO_DISPONIVEL")
	private BigDecimal saldoDisponivel;

    @ManyToOne
	@JoinColumn(name="ID_BANCO_CONTA_CAIXA")
    private BancoContaCaixa bancoContaCaixa;

	public FinFechamentoCaixaBanco() {
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public Date getDataFechamento() {
		return this.dataFechamento;
	}

	public void setDataFechamento(Date dataFechamento) {
		this.dataFechamento = dataFechamento;
	}

    public String getMesAno() {
		return this.mesAno;
	}

	public void setMesAno(String mesAno) {
		this.mesAno = mesAno;
	}

    public String getMes() {
		return this.mes;
	}

	public void setMes(String mes) {
		this.mes = mes;
	}

    public String getAno() {
		return this.ano;
	}

	public void setAno(String ano) {
		this.ano = ano;
	}

    public BigDecimal getSaldoAnterior() {
		return this.saldoAnterior;
	}

	public void setSaldoAnterior(BigDecimal saldoAnterior) {
		this.saldoAnterior = saldoAnterior;
	}

    public BigDecimal getRecebimentos() {
		return this.recebimentos;
	}

	public void setRecebimentos(BigDecimal recebimentos) {
		this.recebimentos = recebimentos;
	}

    public BigDecimal getPagamentos() {
		return this.pagamentos;
	}

	public void setPagamentos(BigDecimal pagamentos) {
		this.pagamentos = pagamentos;
	}

    public BigDecimal getSaldoConta() {
		return this.saldoConta;
	}

	public void setSaldoConta(BigDecimal saldoConta) {
		this.saldoConta = saldoConta;
	}

    public BigDecimal getChequeNaoCompensado() {
		return this.chequeNaoCompensado;
	}

	public void setChequeNaoCompensado(BigDecimal chequeNaoCompensado) {
		this.chequeNaoCompensado = chequeNaoCompensado;
	}

    public BigDecimal getSaldoDisponivel() {
		return this.saldoDisponivel;
	}

	public void setSaldoDisponivel(BigDecimal saldoDisponivel) {
		this.saldoDisponivel = saldoDisponivel;
	}

    public BancoContaCaixa getBancoContaCaixa() {
		return this.bancoContaCaixa;
	}

	public void setBancoContaCaixa(BancoContaCaixa bancoContaCaixa) {
		this.bancoContaCaixa = bancoContaCaixa;
	}

		
}