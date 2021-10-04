/*******************************************************************************
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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
package com.t2ti.retaguarda_sh.model.nfe;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import java.math.BigDecimal;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.t2ti.retaguarda_sh.model.cadastros.Empresa;

@Entity
@Table(name="NFE_CONFIGURACAO")
@NamedQuery(name="NfeConfiguracao.findAll", query="SELECT t FROM NfeConfiguracao t")
public class NfeConfiguracao implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

    @Column(name="CERTIFICADO_DIGITAL_SERIE")
	private String certificadoDigitalSerie;

    @Column(name="CERTIFICADO_DIGITAL_CAMINHO")
	private String certificadoDigitalCaminho;

    @Column(name="CERTIFICADO_DIGITAL_SENHA")
	private String certificadoDigitalSenha;

    @Column(name="TIPO_EMISSAO")
	private Integer tipoEmissao;

    @Column(name="FORMATO_IMPRESSAO_DANFE")
	private Integer formatoImpressaoDanfe;

    @Column(name="PROCESSO_EMISSAO")
	private Integer processoEmissao;

    @Column(name="VERSAO_PROCESSO_EMISSAO")
	private String versaoProcessoEmissao;

    @Column(name="CAMINHO_LOGOMARCA")
	private String caminhoLogomarca;

    @Column(name="SALVAR_XML")
	private String salvarXml;

    @Column(name="CAMINHO_SALVAR_XML")
	private String caminhoSalvarXml;

    @Column(name="CAMINHO_SCHEMAS")
	private String caminhoSchemas;

    @Column(name="CAMINHO_ARQUIVO_DANFE")
	private String caminhoArquivoDanfe;

    @Column(name="CAMINHO_SALVAR_PDF")
	private String caminhoSalvarPdf;

    @Column(name="WEBSERVICE_UF")
	private String webserviceUf;

    @Column(name="WEBSERVICE_AMBIENTE")
	private Integer webserviceAmbiente;

    @Column(name="WEBSERVICE_PROXY_HOST")
	private String webserviceProxyHost;

    @Column(name="WEBSERVICE_PROXY_PORTA")
	private Integer webserviceProxyPorta;

    @Column(name="WEBSERVICE_PROXY_USUARIO")
	private String webserviceProxyUsuario;

    @Column(name="WEBSERVICE_PROXY_SENHA")
	private String webserviceProxySenha;

    @Column(name="WEBSERVICE_VISUALIZAR")
	private String webserviceVisualizar;

    @Column(name="EMAIL_SERVIDOR_SMTP")
	private String emailServidorSmtp;

    @Column(name="EMAIL_PORTA")
	private Integer emailPorta;

    @Column(name="EMAIL_USUARIO")
	private String emailUsuario;

    @Column(name="EMAIL_SENHA")
	private String emailSenha;

    @Column(name="EMAIL_ASSUNTO")
	private String emailAssunto;

    @Column(name="EMAIL_AUTENTICA_SSL")
	private String emailAutenticaSsl;

    @Column(name="EMAIL_TEXTO")
	private String emailTexto;

    @Column(name="NFCE_ID_CSC")
	private String nfceIdCsc;

    @Column(name="NFCE_CSC")
	private String nfceCsc;

    @Column(name="NFCE_MODELO_IMPRESSAO")
	private String nfceModeloImpressao;

    @Column(name="NFCE_IMPRIMIR_ITENS_UMA_LINHA")
	private String nfceImprimirItensUmaLinha;

    @Column(name="NFCE_IMPRIMIR_DESCONTO_POR_ITEM")
	private String nfceImprimirDescontoPorItem;

    @Column(name="NFCE_IMPRIMIR_QRCODE_LATERAL")
	private String nfceImprimirQrcodeLateral;

    @Column(name="NFCE_IMPRIMIR_GTIN")
	private String nfceImprimirGtin;

    @Column(name="NFCE_IMPRIMIR_NOME_FANTASIA")
	private String nfceImprimirNomeFantasia;

    @Column(name="NFCE_IMPRESSAO_TRIBUTOS")
	private String nfceImpressaoTributos;

    @Column(name="NFCE_MARGEM_SUPERIOR")
	private BigDecimal nfceMargemSuperior;

    @Column(name="NFCE_MARGEM_INFERIOR")
	private BigDecimal nfceMargemInferior;

    @Column(name="NFCE_MARGEM_DIREITA")
	private BigDecimal nfceMargemDireita;

    @Column(name="NFCE_MARGEM_ESQUERDA")
	private BigDecimal nfceMargemEsquerda;

    @Column(name="NFCE_RESOLUCAO_IMPRESSAO")
	private Integer nfceResolucaoImpressao;

    @Column(name="NFCE_TAMANHO_FONTE_ITEM")
	private Integer nfceTamanhoFonteItem;

    @Column(name="RESP_TEC_CNPJ")
	private String respTecCnpj;

    @Column(name="RESP_TEC_CONTATO")
	private String respTecContato;

    @Column(name="RESP_TEC_EMAIL")
	private String respTecEmail;

    @Column(name="RESP_TEC_FONE")
	private String respTecFone;

    @Column(name="RESP_TEC_ID_CSRT")
	private String respTecIdCsrt;

    @Column(name="RESP_TEC_HASH_CSRT")
	private String respTecHashCsrt;

    @ManyToOne
	@JsonIgnore
	@JoinColumn(name="ID_EMPRESA")
    private Empresa empresa;

	public NfeConfiguracao() {
		//construtor padrão
	}

    public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public String getCertificadoDigitalSerie() {
		return this.certificadoDigitalSerie;
	}

	public void setCertificadoDigitalSerie(String certificadoDigitalSerie) {
		this.certificadoDigitalSerie = certificadoDigitalSerie;
	}

    public String getCertificadoDigitalCaminho() {
		return this.certificadoDigitalCaminho;
	}

	public void setCertificadoDigitalCaminho(String certificadoDigitalCaminho) {
		this.certificadoDigitalCaminho = certificadoDigitalCaminho;
	}

    public String getCertificadoDigitalSenha() {
		return this.certificadoDigitalSenha;
	}

	public void setCertificadoDigitalSenha(String certificadoDigitalSenha) {
		this.certificadoDigitalSenha = certificadoDigitalSenha;
	}

    public Integer getTipoEmissao() {
		return this.tipoEmissao;
	}

	public void setTipoEmissao(Integer tipoEmissao) {
		this.tipoEmissao = tipoEmissao;
	}

    public Integer getFormatoImpressaoDanfe() {
		return this.formatoImpressaoDanfe;
	}

	public void setFormatoImpressaoDanfe(Integer formatoImpressaoDanfe) {
		this.formatoImpressaoDanfe = formatoImpressaoDanfe;
	}

    public Integer getProcessoEmissao() {
		return this.processoEmissao;
	}

	public void setProcessoEmissao(Integer processoEmissao) {
		this.processoEmissao = processoEmissao;
	}

    public String getVersaoProcessoEmissao() {
		return this.versaoProcessoEmissao;
	}

	public void setVersaoProcessoEmissao(String versaoProcessoEmissao) {
		this.versaoProcessoEmissao = versaoProcessoEmissao;
	}

    public String getCaminhoLogomarca() {
		return this.caminhoLogomarca;
	}

	public void setCaminhoLogomarca(String caminhoLogomarca) {
		this.caminhoLogomarca = caminhoLogomarca;
	}

    public String getSalvarXml() {
		return this.salvarXml;
	}

	public void setSalvarXml(String salvarXml) {
		this.salvarXml = salvarXml;
	}

    public String getCaminhoSalvarXml() {
		return this.caminhoSalvarXml;
	}

	public void setCaminhoSalvarXml(String caminhoSalvarXml) {
		this.caminhoSalvarXml = caminhoSalvarXml;
	}

    public String getCaminhoSchemas() {
		return this.caminhoSchemas;
	}

	public void setCaminhoSchemas(String caminhoSchemas) {
		this.caminhoSchemas = caminhoSchemas;
	}

    public String getCaminhoArquivoDanfe() {
		return this.caminhoArquivoDanfe;
	}

	public void setCaminhoArquivoDanfe(String caminhoArquivoDanfe) {
		this.caminhoArquivoDanfe = caminhoArquivoDanfe;
	}

    public String getCaminhoSalvarPdf() {
		return this.caminhoSalvarPdf;
	}

	public void setCaminhoSalvarPdf(String caminhoSalvarPdf) {
		this.caminhoSalvarPdf = caminhoSalvarPdf;
	}

    public String getWebserviceUf() {
		return this.webserviceUf;
	}

	public void setWebserviceUf(String webserviceUf) {
		this.webserviceUf = webserviceUf;
	}

    public Integer getWebserviceAmbiente() {
		return this.webserviceAmbiente;
	}

	public void setWebserviceAmbiente(Integer webserviceAmbiente) {
		this.webserviceAmbiente = webserviceAmbiente;
	}

    public String getWebserviceProxyHost() {
		return this.webserviceProxyHost;
	}

	public void setWebserviceProxyHost(String webserviceProxyHost) {
		this.webserviceProxyHost = webserviceProxyHost;
	}

    public Integer getWebserviceProxyPorta() {
		return this.webserviceProxyPorta;
	}

	public void setWebserviceProxyPorta(Integer webserviceProxyPorta) {
		this.webserviceProxyPorta = webserviceProxyPorta;
	}

    public String getWebserviceProxyUsuario() {
		return this.webserviceProxyUsuario;
	}

	public void setWebserviceProxyUsuario(String webserviceProxyUsuario) {
		this.webserviceProxyUsuario = webserviceProxyUsuario;
	}

    public String getWebserviceProxySenha() {
		return this.webserviceProxySenha;
	}

	public void setWebserviceProxySenha(String webserviceProxySenha) {
		this.webserviceProxySenha = webserviceProxySenha;
	}

    public String getWebserviceVisualizar() {
		return this.webserviceVisualizar;
	}

	public void setWebserviceVisualizar(String webserviceVisualizar) {
		this.webserviceVisualizar = webserviceVisualizar;
	}

    public String getEmailServidorSmtp() {
		return this.emailServidorSmtp;
	}

	public void setEmailServidorSmtp(String emailServidorSmtp) {
		this.emailServidorSmtp = emailServidorSmtp;
	}

    public Integer getEmailPorta() {
		return this.emailPorta;
	}

	public void setEmailPorta(Integer emailPorta) {
		this.emailPorta = emailPorta;
	}

    public String getEmailUsuario() {
		return this.emailUsuario;
	}

	public void setEmailUsuario(String emailUsuario) {
		this.emailUsuario = emailUsuario;
	}

    public String getEmailSenha() {
		return this.emailSenha;
	}

	public void setEmailSenha(String emailSenha) {
		this.emailSenha = emailSenha;
	}

    public String getEmailAssunto() {
		return this.emailAssunto;
	}

	public void setEmailAssunto(String emailAssunto) {
		this.emailAssunto = emailAssunto;
	}

    public String getEmailAutenticaSsl() {
		return this.emailAutenticaSsl;
	}

	public void setEmailAutenticaSsl(String emailAutenticaSsl) {
		this.emailAutenticaSsl = emailAutenticaSsl;
	}

    public String getEmailTexto() {
		return this.emailTexto;
	}

	public void setEmailTexto(String emailTexto) {
		this.emailTexto = emailTexto;
	}

    public String getNfceIdCsc() {
		return this.nfceIdCsc;
	}

	public void setNfceIdCsc(String nfceIdCsc) {
		this.nfceIdCsc = nfceIdCsc;
	}

    public String getNfceCsc() {
		return this.nfceCsc;
	}

	public void setNfceCsc(String nfceCsc) {
		this.nfceCsc = nfceCsc;
	}

    public String getNfceModeloImpressao() {
		return this.nfceModeloImpressao;
	}

	public void setNfceModeloImpressao(String nfceModeloImpressao) {
		this.nfceModeloImpressao = nfceModeloImpressao;
	}

    public String getNfceImprimirItensUmaLinha() {
		return this.nfceImprimirItensUmaLinha;
	}

	public void setNfceImprimirItensUmaLinha(String nfceImprimirItensUmaLinha) {
		this.nfceImprimirItensUmaLinha = nfceImprimirItensUmaLinha;
	}

    public String getNfceImprimirDescontoPorItem() {
		return this.nfceImprimirDescontoPorItem;
	}

	public void setNfceImprimirDescontoPorItem(String nfceImprimirDescontoPorItem) {
		this.nfceImprimirDescontoPorItem = nfceImprimirDescontoPorItem;
	}

    public String getNfceImprimirQrcodeLateral() {
		return this.nfceImprimirQrcodeLateral;
	}

	public void setNfceImprimirQrcodeLateral(String nfceImprimirQrcodeLateral) {
		this.nfceImprimirQrcodeLateral = nfceImprimirQrcodeLateral;
	}

    public String getNfceImprimirGtin() {
		return this.nfceImprimirGtin;
	}

	public void setNfceImprimirGtin(String nfceImprimirGtin) {
		this.nfceImprimirGtin = nfceImprimirGtin;
	}

    public String getNfceImprimirNomeFantasia() {
		return this.nfceImprimirNomeFantasia;
	}

	public void setNfceImprimirNomeFantasia(String nfceImprimirNomeFantasia) {
		this.nfceImprimirNomeFantasia = nfceImprimirNomeFantasia;
	}

    public String getNfceImpressaoTributos() {
		return this.nfceImpressaoTributos;
	}

	public void setNfceImpressaoTributos(String nfceImpressaoTributos) {
		this.nfceImpressaoTributos = nfceImpressaoTributos;
	}

    public BigDecimal getNfceMargemSuperior() {
		return this.nfceMargemSuperior;
	}

	public void setNfceMargemSuperior(BigDecimal nfceMargemSuperior) {
		this.nfceMargemSuperior = nfceMargemSuperior;
	}

    public BigDecimal getNfceMargemInferior() {
		return this.nfceMargemInferior;
	}

	public void setNfceMargemInferior(BigDecimal nfceMargemInferior) {
		this.nfceMargemInferior = nfceMargemInferior;
	}

    public BigDecimal getNfceMargemDireita() {
		return this.nfceMargemDireita;
	}

	public void setNfceMargemDireita(BigDecimal nfceMargemDireita) {
		this.nfceMargemDireita = nfceMargemDireita;
	}

    public BigDecimal getNfceMargemEsquerda() {
		return this.nfceMargemEsquerda;
	}

	public void setNfceMargemEsquerda(BigDecimal nfceMargemEsquerda) {
		this.nfceMargemEsquerda = nfceMargemEsquerda;
	}

    public Integer getNfceResolucaoImpressao() {
		return this.nfceResolucaoImpressao;
	}

	public void setNfceResolucaoImpressao(Integer nfceResolucaoImpressao) {
		this.nfceResolucaoImpressao = nfceResolucaoImpressao;
	}

    public Integer getNfceTamanhoFonteItem() {
		return this.nfceTamanhoFonteItem;
	}

	public void setNfceTamanhoFonteItem(Integer nfceTamanhoFonteItem) {
		this.nfceTamanhoFonteItem = nfceTamanhoFonteItem;
	}

    public String getRespTecCnpj() {
		return this.respTecCnpj;
	}

	public void setRespTecCnpj(String respTecCnpj) {
		this.respTecCnpj = respTecCnpj;
	}

    public String getRespTecContato() {
		return this.respTecContato;
	}

	public void setRespTecContato(String respTecContato) {
		this.respTecContato = respTecContato;
	}

    public String getRespTecEmail() {
		return this.respTecEmail;
	}

	public void setRespTecEmail(String respTecEmail) {
		this.respTecEmail = respTecEmail;
	}

    public String getRespTecFone() {
		return this.respTecFone;
	}

	public void setRespTecFone(String respTecFone) {
		this.respTecFone = respTecFone;
	}

    public String getRespTecIdCsrt() {
		return this.respTecIdCsrt;
	}

	public void setRespTecIdCsrt(String respTecIdCsrt) {
		this.respTecIdCsrt = respTecIdCsrt;
	}

    public String getRespTecHashCsrt() {
		return this.respTecHashCsrt;
	}

	public void setRespTecHashCsrt(String respTecHashCsrt) {
		this.respTecHashCsrt = respTecHashCsrt;
	}

    public Empresa getEmpresa() {
		return this.empresa;
	}

	public void setEmpresa(Empresa empresa) {
		this.empresa = empresa;
	}

		
}