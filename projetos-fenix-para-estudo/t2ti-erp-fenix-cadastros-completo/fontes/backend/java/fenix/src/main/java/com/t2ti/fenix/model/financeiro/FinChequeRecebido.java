/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CHEQUE_RECEBIDO] 
                                                                                
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

import com.t2ti.fenix.model.cadastros.Pessoa;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@Table(name="FIN_CHEQUE_RECEBIDO")
@NamedQuery(name="FinChequeRecebido.findAll", query="SELECT t FROM FinChequeRecebido t")
public class FinChequeRecebido implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Column(name="CPF")
	private String cpf;

    @Column(name="CNPJ")
	private String cnpj;

    @Column(name="NOME")
	private String nome;

    @Column(name="CODIGO_BANCO")
	private String codigoBanco;

    @Column(name="CODIGO_AGENCIA")
	private String codigoAgencia;

    @Column(name="CONTA")
	private String conta;

    @Column(name="NUMERO")
	private Integer numero;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_EMISSAO")
	private Date dataEmissao;

    @Temporal(TemporalType.DATE)
	@Column(name="BOM_PARA")
	private Date bomPara;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_COMPENSACAO")
	private Date dataCompensacao;

    @Column(name="VALOR")
	private BigDecimal valor;

    @Temporal(TemporalType.DATE)
	@Column(name="CUSTODIA_DATA")
	private Date custodiaData;

    @Column(name="CUSTODIA_TARIFA")
	private BigDecimal custodiaTarifa;

    @Column(name="CUSTODIA_COMISSAO")
	private BigDecimal custodiaComissao;

    @Temporal(TemporalType.DATE)
	@Column(name="DESCONTO_DATA")
	private Date descontoData;

    @Column(name="DESCONTO_TARIFA")
	private BigDecimal descontoTarifa;

    @Column(name="DESCONTO_COMISSAO")
	private BigDecimal descontoComissao;

    @Column(name="VALOR_RECEBIDO")
	private BigDecimal valorRecebido;

    @ManyToOne
	@JoinColumn(name="ID_PESSOA")
    private Pessoa pessoa;

	public FinChequeRecebido() {
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public String getCpf() {
		return this.cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

    public String getCnpj() {
		return this.cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

    public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

    public String getCodigoBanco() {
		return this.codigoBanco;
	}

	public void setCodigoBanco(String codigoBanco) {
		this.codigoBanco = codigoBanco;
	}

    public String getCodigoAgencia() {
		return this.codigoAgencia;
	}

	public void setCodigoAgencia(String codigoAgencia) {
		this.codigoAgencia = codigoAgencia;
	}

    public String getConta() {
		return this.conta;
	}

	public void setConta(String conta) {
		this.conta = conta;
	}

    public Integer getNumero() {
		return this.numero;
	}

	public void setNumero(Integer numero) {
		this.numero = numero;
	}

    public Date getDataEmissao() {
		return this.dataEmissao;
	}

	public void setDataEmissao(Date dataEmissao) {
		this.dataEmissao = dataEmissao;
	}

    public Date getBomPara() {
		return this.bomPara;
	}

	public void setBomPara(Date bomPara) {
		this.bomPara = bomPara;
	}

    public Date getDataCompensacao() {
		return this.dataCompensacao;
	}

	public void setDataCompensacao(Date dataCompensacao) {
		this.dataCompensacao = dataCompensacao;
	}

    public BigDecimal getValor() {
		return this.valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

    public Date getCustodiaData() {
		return this.custodiaData;
	}

	public void setCustodiaData(Date custodiaData) {
		this.custodiaData = custodiaData;
	}

    public BigDecimal getCustodiaTarifa() {
		return this.custodiaTarifa;
	}

	public void setCustodiaTarifa(BigDecimal custodiaTarifa) {
		this.custodiaTarifa = custodiaTarifa;
	}

    public BigDecimal getCustodiaComissao() {
		return this.custodiaComissao;
	}

	public void setCustodiaComissao(BigDecimal custodiaComissao) {
		this.custodiaComissao = custodiaComissao;
	}

    public Date getDescontoData() {
		return this.descontoData;
	}

	public void setDescontoData(Date descontoData) {
		this.descontoData = descontoData;
	}

    public BigDecimal getDescontoTarifa() {
		return this.descontoTarifa;
	}

	public void setDescontoTarifa(BigDecimal descontoTarifa) {
		this.descontoTarifa = descontoTarifa;
	}

    public BigDecimal getDescontoComissao() {
		return this.descontoComissao;
	}

	public void setDescontoComissao(BigDecimal descontoComissao) {
		this.descontoComissao = descontoComissao;
	}

    public BigDecimal getValorRecebido() {
		return this.valorRecebido;
	}

	public void setValorRecebido(BigDecimal valorRecebido) {
		this.valorRecebido = valorRecebido;
	}

    public Pessoa getPessoa() {
		return this.pessoa;
	}

	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}

		
}