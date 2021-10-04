/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
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

import com.t2ti.fenix.model.cadastros.BancoContaCaixa;

import java.math.BigDecimal;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@Table(name="FIN_CONFIGURACAO_BOLETO")
@NamedQuery(name="FinConfiguracaoBoleto.findAll", query="SELECT t FROM FinConfiguracaoBoleto t")
public class FinConfiguracaoBoleto implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Column(name="INSTRUCAO01")
	private String instrucao01;

    @Column(name="INSTRUCAO02")
	private String instrucao02;

    @Column(name="CAMINHO_ARQUIVO_REMESSA")
	private String caminhoArquivoRemessa;

    @Column(name="CAMINHO_ARQUIVO_RETORNO")
	private String caminhoArquivoRetorno;

    @Column(name="CAMINHO_ARQUIVO_LOGOTIPO")
	private String caminhoArquivoLogotipo;

    @Column(name="CAMINHO_ARQUIVO_PDF")
	private String caminhoArquivoPdf;

    @Column(name="MENSAGEM")
	private String mensagem;

    @Column(name="LOCAL_PAGAMENTO")
	private String localPagamento;

    @Column(name="LAYOUT_REMESSA")
	private String layoutRemessa;

    @Column(name="ACEITE")
	private String aceite;

    @Column(name="ESPECIE")
	private String especie;

    @Column(name="CARTEIRA")
	private String carteira;

    @Column(name="CODIGO_CONVENIO")
	private String codigoConvenio;

    @Column(name="CODIGO_CEDENTE")
	private String codigoCedente;

    @Column(name="TAXA_MULTA")
	private BigDecimal taxaMulta;

    @Column(name="TAXA_JURO")
	private BigDecimal taxaJuro;

    @Column(name="DIAS_PROTESTO")
	private Integer diasProtesto;

    @Column(name="NOSSO_NUMERO_ANTERIOR")
	private String nossoNumeroAnterior;

    @ManyToOne
	@JoinColumn(name="ID_BANCO_CONTA_CAIXA")
    private BancoContaCaixa bancoContaCaixa;

	public FinConfiguracaoBoleto() {
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public String getInstrucao01() {
		return this.instrucao01;
	}

	public void setInstrucao01(String instrucao01) {
		this.instrucao01 = instrucao01;
	}

    public String getInstrucao02() {
		return this.instrucao02;
	}

	public void setInstrucao02(String instrucao02) {
		this.instrucao02 = instrucao02;
	}

    public String getCaminhoArquivoRemessa() {
		return this.caminhoArquivoRemessa;
	}

	public void setCaminhoArquivoRemessa(String caminhoArquivoRemessa) {
		this.caminhoArquivoRemessa = caminhoArquivoRemessa;
	}

    public String getCaminhoArquivoRetorno() {
		return this.caminhoArquivoRetorno;
	}

	public void setCaminhoArquivoRetorno(String caminhoArquivoRetorno) {
		this.caminhoArquivoRetorno = caminhoArquivoRetorno;
	}

    public String getCaminhoArquivoLogotipo() {
		return this.caminhoArquivoLogotipo;
	}

	public void setCaminhoArquivoLogotipo(String caminhoArquivoLogotipo) {
		this.caminhoArquivoLogotipo = caminhoArquivoLogotipo;
	}

    public String getCaminhoArquivoPdf() {
		return this.caminhoArquivoPdf;
	}

	public void setCaminhoArquivoPdf(String caminhoArquivoPdf) {
		this.caminhoArquivoPdf = caminhoArquivoPdf;
	}

    public String getMensagem() {
		return this.mensagem;
	}

	public void setMensagem(String mensagem) {
		this.mensagem = mensagem;
	}

    public String getLocalPagamento() {
		return this.localPagamento;
	}

	public void setLocalPagamento(String localPagamento) {
		this.localPagamento = localPagamento;
	}

    public String getLayoutRemessa() {
		return this.layoutRemessa;
	}

	public void setLayoutRemessa(String layoutRemessa) {
		this.layoutRemessa = layoutRemessa;
	}

    public String getAceite() {
		return this.aceite;
	}

	public void setAceite(String aceite) {
		this.aceite = aceite;
	}

    public String getEspecie() {
		return this.especie;
	}

	public void setEspecie(String especie) {
		this.especie = especie;
	}

    public String getCarteira() {
		return this.carteira;
	}

	public void setCarteira(String carteira) {
		this.carteira = carteira;
	}

    public String getCodigoConvenio() {
		return this.codigoConvenio;
	}

	public void setCodigoConvenio(String codigoConvenio) {
		this.codigoConvenio = codigoConvenio;
	}

    public String getCodigoCedente() {
		return this.codigoCedente;
	}

	public void setCodigoCedente(String codigoCedente) {
		this.codigoCedente = codigoCedente;
	}

    public BigDecimal getTaxaMulta() {
		return this.taxaMulta;
	}

	public void setTaxaMulta(BigDecimal taxaMulta) {
		this.taxaMulta = taxaMulta;
	}

    public BigDecimal getTaxaJuro() {
		return this.taxaJuro;
	}

	public void setTaxaJuro(BigDecimal taxaJuro) {
		this.taxaJuro = taxaJuro;
	}

    public Integer getDiasProtesto() {
		return this.diasProtesto;
	}

	public void setDiasProtesto(Integer diasProtesto) {
		this.diasProtesto = diasProtesto;
	}

    public String getNossoNumeroAnterior() {
		return this.nossoNumeroAnterior;
	}

	public void setNossoNumeroAnterior(String nossoNumeroAnterior) {
		this.nossoNumeroAnterior = nossoNumeroAnterior;
	}

    public BancoContaCaixa getBancoContaCaixa() {
		return this.bancoContaCaixa;
	}

	public void setBancoContaCaixa(BancoContaCaixa bancoContaCaixa) {
		this.bancoContaCaixa = bancoContaCaixa;
	}

		
}