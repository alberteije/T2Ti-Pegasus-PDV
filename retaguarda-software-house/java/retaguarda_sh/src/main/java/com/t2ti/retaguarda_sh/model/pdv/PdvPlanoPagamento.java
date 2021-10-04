/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [PDV_PLANO_PAGAMENTO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
package com.t2ti.retaguarda_sh.model.pdv;

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

import org.springframework.lang.Nullable;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.t2ti.retaguarda_sh.model.cadastros.Empresa;

@Entity
@Table(name="PDV_PLANO_PAGAMENTO")
@NamedQuery(name="PdvPlanoPagamento.findAll", query="SELECT t FROM PdvPlanoPagamento t")
public class PdvPlanoPagamento implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_SOLICITACAO")
	private Date dataSolicitacao;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_PAGAMENTO")
	private Date dataPagamento;

    @Column(name="PLANO")
	private String plano;

    @Column(name="VALOR")
	private BigDecimal valor;

    @Column(name="STATUS_PAGAMENTO")
	private String statusPagamento;

    @Column(name="CODIGO_TRANSACAO")
	private String codigoTransacao;

    @Column(name="METODO_PAGAMENTO")
	private String metodoPagamento;

    @Column(name="CODIGO_TIPO_PAGAMENTO")
	private String codigoTipoPagamento;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_PLANO_EXPIRA")
	private Date dataPlanoExpira;

    @Column(name="EMAIL_PAGAMENTO")
	private String emailPagamento;

    @ManyToOne
	@JsonIgnore
	@JoinColumn(name="ID_EMPRESA")
    @Nullable
    private Empresa empresa;

    @ManyToOne
	@JsonIgnore
	@JoinColumn(name="ID_PDV_TIPO_PLANO")
    private PdvTipoPlano pdvTipoPlano;

	public PdvPlanoPagamento() {
		//construtor padrão
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public Date getDataSolicitacao() {
		return this.dataSolicitacao;
	}

	public void setDataSolicitacao(Date dataSolicitacao) {
		this.dataSolicitacao = dataSolicitacao;
	}

    public Date getDataPagamento() {
		return this.dataPagamento;
	}

	public void setDataPagamento(Date dataPagamento) {
		this.dataPagamento = dataPagamento;
	}

    public String getPlano() {
		return this.plano;
	}

	public void setPlano(String plano) {
		this.plano = plano;
	}

    public BigDecimal getValor() {
		return this.valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

    public String getStatusPagamento() {
		return this.statusPagamento;
	}

	public void setStatusPagamento(String statusPagamento) {
		this.statusPagamento = statusPagamento;
	}

    public String getCodigoTransacao() {
		return this.codigoTransacao;
	}

	public void setCodigoTransacao(String codigoTransacao) {
		this.codigoTransacao = codigoTransacao;
	}

    public String getMetodoPagamento() {
		return this.metodoPagamento;
	}

	public void setMetodoPagamento(String metodoPagamento) {
		this.metodoPagamento = metodoPagamento;
	}

    public String getCodigoTipoPagamento() {
		return this.codigoTipoPagamento;
	}

	public void setCodigoTipoPagamento(String codigoTipoPagamento) {
		this.codigoTipoPagamento = codigoTipoPagamento;
	}

    public Date getDataPlanoExpira() {
		return this.dataPlanoExpira;
	}

	public void setDataPlanoExpira(Date dataPlanoExpira) {
		this.dataPlanoExpira = dataPlanoExpira;
	}

    public String getEmailPagamento() {
		return this.emailPagamento;
	}

	public void setEmailPagamento(String emailPagamento) {
		this.emailPagamento = emailPagamento;
	}

    public Empresa getEmpresa() {
		return this.empresa;
	}

	public void setEmpresa(Empresa empresa) {
		this.empresa = empresa;
	}

    public PdvTipoPlano getPdvTipoPlano() {
		return this.pdvTipoPlano;
	}

	public void setPdvTipoPlano(PdvTipoPlano pdvTipoPlano) {
		this.pdvTipoPlano = pdvTipoPlano;
	}

		
}