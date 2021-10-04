/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [EMPRESA] 
                                                                                
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
package com.t2ti.retaguarda_sh.model.cadastros;

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

import com.t2ti.retaguarda_sh.model.nfe.NfeConfiguracao;
import com.t2ti.retaguarda_sh.model.pdv.PdvPlanoPagamento;

import java.util.Set;
import javax.persistence.OneToMany;
import javax.persistence.CascadeType;

@Entity
@Table(name="EMPRESA")
@NamedQuery(name="Empresa.findAll", query="SELECT t FROM Empresa t")
public class Empresa implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Column(name="RAZAO_SOCIAL")
	private String razaoSocial;

    @Column(name="NOME_FANTASIA")
	private String nomeFantasia;

    @Column(name="CNPJ")
	private String cnpj;

    @Column(name="INSCRICAO_ESTADUAL")
	private String inscricaoEstadual;

    @Column(name="INSCRICAO_MUNICIPAL")
	private String inscricaoMunicipal;

    @Column(name="TIPO_REGIME")
	private String tipoRegime;

    @Column(name="CRT")
	private String crt;

    @Temporal(TemporalType.DATE)
	@Column(name="DATA_CONSTITUICAO")
	private Date dataConstituicao;

    @Column(name="TIPO")
	private String tipo;

    @Column(name="EMAIL")
	private String email;

    @Column(name="ALIQUOTA_PIS")
	private BigDecimal aliquotaPis;

    @Column(name="ALIQUOTA_COFINS")
	private BigDecimal aliquotaCofins;

    @Column(name="LOGRADOURO")
	private String logradouro;

    @Column(name="NUMERO")
	private String numero;

    @Column(name="COMPLEMENTO")
	private String complemento;

    @Column(name="CEP")
	private String cep;

    @Column(name="BAIRRO")
	private String bairro;

    @Column(name="CIDADE")
	private String cidade;

    @Column(name="UF")
	private String uf;

    @Column(name="FONE")
	private String fone;

    @Column(name="CONTATO")
	private String contato;

    @Column(name="CODIGO_IBGE_CIDADE")
	private Integer codigoIbgeCidade;

    @Column(name="CODIGO_IBGE_UF")
	private Integer codigoIbgeUf;

    @Column(name="LOGOTIPO")
	private String logotipo;

    @Column(name="REGISTRADO")
	private String registrado;

    @Column(name="NATUREZA_JURIDICA")
	private String naturezaJuridica;

    @Column(name="SIMEI")
	private String simei;

    @Column(name="EMAIL_PAGAMENTO")
	private String emailPagamento;

    @Column(name="DATA_REGISTRO")
    private Date dataRegistro;

    @Column(name="HORA_REGISTRO")
	private String horaRegistro;

    @OneToMany(mappedBy = "empresa", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<NfeConfiguracao> listaNfeConfiguracao;

    @OneToMany(mappedBy = "empresa", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<PdvPlanoPagamento> listaPdvPlanoPagamento;

	public Empresa() {
		//construtor padrão
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public String getRazaoSocial() {
		return this.razaoSocial;
	}

	public void setRazaoSocial(String razaoSocial) {
		this.razaoSocial = razaoSocial;
	}

    public String getNomeFantasia() {
		return this.nomeFantasia;
	}

	public void setNomeFantasia(String nomeFantasia) {
		this.nomeFantasia = nomeFantasia;
	}

    public String getCnpj() {
		return this.cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

    public String getInscricaoEstadual() {
		return this.inscricaoEstadual;
	}

	public void setInscricaoEstadual(String inscricaoEstadual) {
		this.inscricaoEstadual = inscricaoEstadual;
	}

    public String getInscricaoMunicipal() {
		return this.inscricaoMunicipal;
	}

	public void setInscricaoMunicipal(String inscricaoMunicipal) {
		this.inscricaoMunicipal = inscricaoMunicipal;
	}

    public String getTipoRegime() {
		return this.tipoRegime;
	}

	public void setTipoRegime(String tipoRegime) {
		this.tipoRegime = tipoRegime;
	}

    public String getCrt() {
		return this.crt;
	}

	public void setCrt(String crt) {
		this.crt = crt;
	}

    public Date getDataConstituicao() {
		return this.dataConstituicao;
	}

	public void setDataConstituicao(Date dataConstituicao) {
		this.dataConstituicao = dataConstituicao;
	}

    public String getTipo() {
		return this.tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

    public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

    public BigDecimal getAliquotaPis() {
		return this.aliquotaPis;
	}

	public void setAliquotaPis(BigDecimal aliquotaPis) {
		this.aliquotaPis = aliquotaPis;
	}

    public BigDecimal getAliquotaCofins() {
		return this.aliquotaCofins;
	}

	public void setAliquotaCofins(BigDecimal aliquotaCofins) {
		this.aliquotaCofins = aliquotaCofins;
	}

    public String getLogradouro() {
		return this.logradouro;
	}

	public void setLogradouro(String logradouro) {
		this.logradouro = logradouro;
	}

    public String getNumero() {
		return this.numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

    public String getComplemento() {
		return this.complemento;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

    public String getCep() {
		return this.cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

    public String getBairro() {
		return this.bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

    public String getCidade() {
		return this.cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

    public String getUf() {
		return this.uf;
	}

	public void setUf(String uf) {
		this.uf = uf;
	}

    public String getFone() {
		return this.fone;
	}

	public void setFone(String fone) {
		this.fone = fone;
	}

    public String getContato() {
		return this.contato;
	}

	public void setContato(String contato) {
		this.contato = contato;
	}

    public Integer getCodigoIbgeCidade() {
		return this.codigoIbgeCidade;
	}

	public void setCodigoIbgeCidade(Integer codigoIbgeCidade) {
		this.codigoIbgeCidade = codigoIbgeCidade;
	}

    public Integer getCodigoIbgeUf() {
		return this.codigoIbgeUf;
	}

	public void setCodigoIbgeUf(Integer codigoIbgeUf) {
		this.codigoIbgeUf = codigoIbgeUf;
	}

    public String getLogotipo() {
		return this.logotipo;
	}

	public void setLogotipo(String logotipo) {
		this.logotipo = logotipo;
	}

    public String getRegistrado() {
		return this.registrado;
	}

	public void setRegistrado(String registrado) {
		this.registrado = registrado;
	}

    public String getNaturezaJuridica() {
		return this.naturezaJuridica;
	}

	public void setNaturezaJuridica(String naturezaJuridica) {
		this.naturezaJuridica = naturezaJuridica;
	}

    public String getSimei() {
		return this.simei;
	}

	public void setSimei(String simei) {
		this.simei = simei;
	}

    public String getEmailPagamento() {
		return this.emailPagamento;
	}

	public void setEmailPagamento(String emailPagamento) {
		this.emailPagamento = emailPagamento;
	}

    public Date getDataRegistro() {
		return dataRegistro;
	}

	public void setDataRegistro(Date dataRegistro) {
		this.dataRegistro = dataRegistro;
	}

	public String getHoraRegistro() {
		return horaRegistro;
	}

	public void setHoraRegistro(String horaRegistro) {
		this.horaRegistro = horaRegistro;
	}

	public Set<NfeConfiguracao> getListaNfeConfiguracao() {
		return this.listaNfeConfiguracao;
	}

	public void setListaNfeConfiguracao(Set<NfeConfiguracao> listaNfeConfiguracao) {
		this.listaNfeConfiguracao = listaNfeConfiguracao;
		for (NfeConfiguracao nfeConfiguracao : listaNfeConfiguracao) {
			nfeConfiguracao.setEmpresa(this);
		}
	}

    public Set<PdvPlanoPagamento> getListaPdvPlanoPagamento() {
		return this.listaPdvPlanoPagamento;
	}

	public void setListaPdvPlanoPagamento(Set<PdvPlanoPagamento> listaPdvPlanoPagamento) {
		this.listaPdvPlanoPagamento = listaPdvPlanoPagamento;
		for (PdvPlanoPagamento pdvPlanoPagamento : listaPdvPlanoPagamento) {
			pdvPlanoPagamento.setEmpresa(this);
		}
	}

		
}