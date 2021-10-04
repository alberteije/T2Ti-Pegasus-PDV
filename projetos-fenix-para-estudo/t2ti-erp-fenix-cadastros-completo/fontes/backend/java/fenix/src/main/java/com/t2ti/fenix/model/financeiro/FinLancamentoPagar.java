/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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

import com.t2ti.fenix.model.cadastros.Fornecedor;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.util.Set;
import javax.persistence.OneToMany;
import javax.persistence.CascadeType;

@Entity
@Table(name="FIN_LANCAMENTO_PAGAR")
@NamedQuery(name="FinLancamentoPagar.findAll", query="SELECT t FROM FinLancamentoPagar t")
public class FinLancamentoPagar implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Column(name="QUANTIDADE_PARCELA")
	private Integer quantidadeParcela;

    @Column(name="VALOR_TOTAL")
	private BigDecimal valorTotal;

    @Column(name="VALOR_A_PAGAR")
	private BigDecimal valorAPagar;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_LANCAMENTO")
	private Date dataLancamento;

    @Column(name="NUMERO_DOCUMENTO")
	private String numeroDocumento;

    @Column(name="IMAGEM_DOCUMENTO")
	private String imagemDocumento;

    @Temporal(TemporalType.DATE)
	@Column(name="PRIMEIRO_VENCIMENTO")
	private Date primeiroVencimento;

    @Column(name="INTERVALO_ENTRE_PARCELAS")
	private Integer intervaloEntreParcelas;

    @Column(name="DIA_FIXO")
	private String diaFixo;

    @ManyToOne
	@JoinColumn(name="ID_FIN_DOCUMENTO_ORIGEM")
    private FinDocumentoOrigem finDocumentoOrigem;

    @ManyToOne
	@JoinColumn(name="ID_FIN_NATUREZA_FINANCEIRA")
    private FinNaturezaFinanceira finNaturezaFinanceira;

    @ManyToOne
	@JoinColumn(name="ID_FORNECEDOR")
    private Fornecedor fornecedor;

    @OneToMany(mappedBy = "finLancamentoPagar", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<FinParcelaPagar> listaFinParcelaPagar;

	public FinLancamentoPagar() {
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public Integer getQuantidadeParcela() {
		return this.quantidadeParcela;
	}

	public void setQuantidadeParcela(Integer quantidadeParcela) {
		this.quantidadeParcela = quantidadeParcela;
	}

    public BigDecimal getValorTotal() {
		return this.valorTotal;
	}

	public void setValorTotal(BigDecimal valorTotal) {
		this.valorTotal = valorTotal;
	}

    public BigDecimal getValorAPagar() {
		return this.valorAPagar;
	}

	public void setValorAPagar(BigDecimal valorAPagar) {
		this.valorAPagar = valorAPagar;
	}

    public Date getDataLancamento() {
		return this.dataLancamento;
	}

	public void setDataLancamento(Date dataLancamento) {
		this.dataLancamento = dataLancamento;
	}

    public String getNumeroDocumento() {
		return this.numeroDocumento;
	}

	public void setNumeroDocumento(String numeroDocumento) {
		this.numeroDocumento = numeroDocumento;
	}

    public String getImagemDocumento() {
		return this.imagemDocumento;
	}

	public void setImagemDocumento(String imagemDocumento) {
		this.imagemDocumento = imagemDocumento;
	}

    public Date getPrimeiroVencimento() {
		return this.primeiroVencimento;
	}

	public void setPrimeiroVencimento(Date primeiroVencimento) {
		this.primeiroVencimento = primeiroVencimento;
	}

    public Integer getIntervaloEntreParcelas() {
		return this.intervaloEntreParcelas;
	}

	public void setIntervaloEntreParcelas(Integer intervaloEntreParcelas) {
		this.intervaloEntreParcelas = intervaloEntreParcelas;
	}

    public String getDiaFixo() {
		return this.diaFixo;
	}

	public void setDiaFixo(String diaFixo) {
		this.diaFixo = diaFixo;
	}

    public FinDocumentoOrigem getFinDocumentoOrigem() {
		return this.finDocumentoOrigem;
	}

	public void setFinDocumentoOrigem(FinDocumentoOrigem finDocumentoOrigem) {
		this.finDocumentoOrigem = finDocumentoOrigem;
	}

    public FinNaturezaFinanceira getFinNaturezaFinanceira() {
		return this.finNaturezaFinanceira;
	}

	public void setFinNaturezaFinanceira(FinNaturezaFinanceira finNaturezaFinanceira) {
		this.finNaturezaFinanceira = finNaturezaFinanceira;
	}

    public Fornecedor getFornecedor() {
		return this.fornecedor;
	}

	public void setFornecedor(Fornecedor fornecedor) {
		this.fornecedor = fornecedor;
	}

    public Set<FinParcelaPagar> getListaFinParcelaPagar() {
		return this.listaFinParcelaPagar;
	}

	public void setListaFinParcelaPagar(Set<FinParcelaPagar> listaFinParcelaPagar) {
		this.listaFinParcelaPagar = listaFinParcelaPagar;
		for (FinParcelaPagar finParcelaPagar : listaFinParcelaPagar) {
			finParcelaPagar.setFinLancamentoPagar(this);
		}
	}

		
}