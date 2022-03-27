package com.t2ti.retaguarda_sh.model.transiente;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class ObjetoPdvConfiguracao implements Serializable {
	private static final long serialVersionUID = 1L;

	  private int id;
	  private int idEcfImpressora;
	  private int idPdvCaixa;
	  private int idTributOperacaoFiscalPadrao;
	  private String mensagemCupom;
	  private String portaEcf;
	  private String ipServidor;
	  private String ipSitef;
	  private String tipoTef;
	  private String tituloTelaCaixa;
	  private String caminhoImagensProdutos;
	  private String caminhoImagensMarketing;
	  private String corJanelasInternas;
	  private String marketingAtivo;
	  private int cfopEcf;
	  private int timeoutEcf;
	  private int intervaloEcf;
	  private String descricaoSuprimento;
	  private String descricaoSangria;
	  private int tefTipoGp;
	  private int tefTempoEspera;
	  private int tefEsperaSts;
	  private int tefNumeroVias;
	  private int decimaisQuantidade;
	  private int decimaisValor;
	  private int bitsPorSegundo;
	  private int quantidadeMaximaCartoes;
	  private String pesquisaParte;
	  private String laudo;
	  private Date dataAtualizacaoEstoque;
	  private String pedeCpfCupom;
	  private int tipoIntegracao;
	  private int timerIntegracao;
	  private String gavetaSinalInvertido;
	  private int gavetaUtilizacao;
	  private String usaTecladoReduzido;
	  private String modulo;
	  private String plano;
	  private BigDecimal planoValor;
	  private String planoSituacao;
	  private String reciboFormatoPagina;
	  private BigDecimal reciboLarguraPagina;
	  private BigDecimal reciboMargemPagina;
	  private String encerraMovimentoAuto;
	  private String permiteEstoqueNegativo;
	  private String moduloFiscalPrincipal;
	  private String moduloFiscalContingencia;
	  private String acbrMonitorEndereco;
	  private int acbrMonitorPorta;

	public ObjetoPdvConfiguracao() {}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getIdEcfImpressora() {
		return idEcfImpressora;
	}


	public void setIdEcfImpressora(int idEcfImpressora) {
		this.idEcfImpressora = idEcfImpressora;
	}


	public int getIdPdvCaixa() {
		return idPdvCaixa;
	}


	public void setIdPdvCaixa(int idPdvCaixa) {
		this.idPdvCaixa = idPdvCaixa;
	}


	public int getIdTributOperacaoFiscalPadrao() {
		return idTributOperacaoFiscalPadrao;
	}


	public void setIdTributOperacaoFiscalPadrao(int idTributOperacaoFiscalPadrao) {
		this.idTributOperacaoFiscalPadrao = idTributOperacaoFiscalPadrao;
	}


	public String getMensagemCupom() {
		return mensagemCupom;
	}


	public void setMensagemCupom(String mensagemCupom) {
		this.mensagemCupom = mensagemCupom;
	}


	public String getPortaEcf() {
		return portaEcf;
	}


	public void setPortaEcf(String portaEcf) {
		this.portaEcf = portaEcf;
	}


	public String getIpServidor() {
		return ipServidor;
	}


	public void setIpServidor(String ipServidor) {
		this.ipServidor = ipServidor;
	}


	public String getIpSitef() {
		return ipSitef;
	}


	public void setIpSitef(String ipSitef) {
		this.ipSitef = ipSitef;
	}


	public String getTipoTef() {
		return tipoTef;
	}


	public void setTipoTef(String tipoTef) {
		this.tipoTef = tipoTef;
	}


	public String getTituloTelaCaixa() {
		return tituloTelaCaixa;
	}


	public void setTituloTelaCaixa(String tituloTelaCaixa) {
		this.tituloTelaCaixa = tituloTelaCaixa;
	}


	public String getCaminhoImagensProdutos() {
		return caminhoImagensProdutos;
	}


	public void setCaminhoImagensProdutos(String caminhoImagensProdutos) {
		this.caminhoImagensProdutos = caminhoImagensProdutos;
	}


	public String getCaminhoImagensMarketing() {
		return caminhoImagensMarketing;
	}


	public void setCaminhoImagensMarketing(String caminhoImagensMarketing) {
		this.caminhoImagensMarketing = caminhoImagensMarketing;
	}


	public String getCorJanelasInternas() {
		return corJanelasInternas;
	}


	public void setCorJanelasInternas(String corJanelasInternas) {
		this.corJanelasInternas = corJanelasInternas;
	}


	public String getMarketingAtivo() {
		return marketingAtivo;
	}


	public void setMarketingAtivo(String marketingAtivo) {
		this.marketingAtivo = marketingAtivo;
	}


	public int getCfopEcf() {
		return cfopEcf;
	}


	public void setCfopEcf(int cfopEcf) {
		this.cfopEcf = cfopEcf;
	}


	public int getTimeoutEcf() {
		return timeoutEcf;
	}


	public void setTimeoutEcf(int timeoutEcf) {
		this.timeoutEcf = timeoutEcf;
	}


	public int getIntervaloEcf() {
		return intervaloEcf;
	}


	public void setIntervaloEcf(int intervaloEcf) {
		this.intervaloEcf = intervaloEcf;
	}


	public String getDescricaoSuprimento() {
		return descricaoSuprimento;
	}


	public void setDescricaoSuprimento(String descricaoSuprimento) {
		this.descricaoSuprimento = descricaoSuprimento;
	}


	public String getDescricaoSangria() {
		return descricaoSangria;
	}


	public void setDescricaoSangria(String descricaoSangria) {
		this.descricaoSangria = descricaoSangria;
	}


	public int getTefTipoGp() {
		return tefTipoGp;
	}


	public void setTefTipoGp(int tefTipoGp) {
		this.tefTipoGp = tefTipoGp;
	}


	public int getTefTempoEspera() {
		return tefTempoEspera;
	}


	public void setTefTempoEspera(int tefTempoEspera) {
		this.tefTempoEspera = tefTempoEspera;
	}


	public int getTefEsperaSts() {
		return tefEsperaSts;
	}


	public void setTefEsperaSts(int tefEsperaSts) {
		this.tefEsperaSts = tefEsperaSts;
	}


	public int getTefNumeroVias() {
		return tefNumeroVias;
	}


	public void setTefNumeroVias(int tefNumeroVias) {
		this.tefNumeroVias = tefNumeroVias;
	}


	public int getDecimaisQuantidade() {
		return decimaisQuantidade;
	}


	public void setDecimaisQuantidade(int decimaisQuantidade) {
		this.decimaisQuantidade = decimaisQuantidade;
	}


	public int getDecimaisValor() {
		return decimaisValor;
	}


	public void setDecimaisValor(int decimaisValor) {
		this.decimaisValor = decimaisValor;
	}


	public int getBitsPorSegundo() {
		return bitsPorSegundo;
	}


	public void setBitsPorSegundo(int bitsPorSegundo) {
		this.bitsPorSegundo = bitsPorSegundo;
	}


	public int getQuantidadeMaximaCartoes() {
		return quantidadeMaximaCartoes;
	}


	public void setQuantidadeMaximaCartoes(int quantidadeMaximaCartoes) {
		this.quantidadeMaximaCartoes = quantidadeMaximaCartoes;
	}


	public String getPesquisaParte() {
		return pesquisaParte;
	}


	public void setPesquisaParte(String pesquisaParte) {
		this.pesquisaParte = pesquisaParte;
	}


	public String getLaudo() {
		return laudo;
	}


	public void setLaudo(String laudo) {
		this.laudo = laudo;
	}


	public Date getDataAtualizacaoEstoque() {
		return dataAtualizacaoEstoque;
	}


	public void setDataAtualizacaoEstoque(Date dataAtualizacaoEstoque) {
		this.dataAtualizacaoEstoque = dataAtualizacaoEstoque;
	}


	public String getPedeCpfCupom() {
		return pedeCpfCupom;
	}


	public void setPedeCpfCupom(String pedeCpfCupom) {
		this.pedeCpfCupom = pedeCpfCupom;
	}


	public int getTipoIntegracao() {
		return tipoIntegracao;
	}


	public void setTipoIntegracao(int tipoIntegracao) {
		this.tipoIntegracao = tipoIntegracao;
	}


	public int getTimerIntegracao() {
		return timerIntegracao;
	}


	public void setTimerIntegracao(int timerIntegracao) {
		this.timerIntegracao = timerIntegracao;
	}


	public String getGavetaSinalInvertido() {
		return gavetaSinalInvertido;
	}


	public void setGavetaSinalInvertido(String gavetaSinalInvertido) {
		this.gavetaSinalInvertido = gavetaSinalInvertido;
	}


	public int getGavetaUtilizacao() {
		return gavetaUtilizacao;
	}


	public void setGavetaUtilizacao(int gavetaUtilizacao) {
		this.gavetaUtilizacao = gavetaUtilizacao;
	}


	public String getUsaTecladoReduzido() {
		return usaTecladoReduzido;
	}


	public void setUsaTecladoReduzido(String usaTecladoReduzido) {
		this.usaTecladoReduzido = usaTecladoReduzido;
	}


	public String getModulo() {
		return modulo;
	}


	public void setModulo(String modulo) {
		this.modulo = modulo;
	}


	public String getPlano() {
		return plano;
	}


	public void setPlano(String plano) {
		this.plano = plano;
	}


	public BigDecimal getPlanoValor() {
		return planoValor;
	}


	public void setPlanoValor(BigDecimal planoValor) {
		this.planoValor = planoValor;
	}


	public String getPlanoSituacao() {
		return planoSituacao;
	}


	public void setPlanoSituacao(String planoSituacao) {
		this.planoSituacao = planoSituacao;
	}


	public String getReciboFormatoPagina() {
		return reciboFormatoPagina;
	}


	public void setReciboFormatoPagina(String reciboFormatoPagina) {
		this.reciboFormatoPagina = reciboFormatoPagina;
	}


	public BigDecimal getReciboLarguraPagina() {
		return reciboLarguraPagina;
	}


	public void setReciboLarguraPagina(BigDecimal reciboLarguraPagina) {
		this.reciboLarguraPagina = reciboLarguraPagina;
	}


	public BigDecimal getReciboMargemPagina() {
		return reciboMargemPagina;
	}


	public void setReciboMargemPagina(BigDecimal reciboMargemPagina) {
		this.reciboMargemPagina = reciboMargemPagina;
	}


	public String getEncerraMovimentoAuto() {
		return encerraMovimentoAuto;
	}


	public void setEncerraMovimentoAuto(String encerraMovimentoAuto) {
		this.encerraMovimentoAuto = encerraMovimentoAuto;
	}


	public String getPermiteEstoqueNegativo() {
		return permiteEstoqueNegativo;
	}


	public void setPermiteEstoqueNegativo(String permiteEstoqueNegativo) {
		this.permiteEstoqueNegativo = permiteEstoqueNegativo;
	}


	public String getModuloFiscalPrincipal() {
		return moduloFiscalPrincipal;
	}


	public void setModuloFiscalPrincipal(String moduloFiscalPrincipal) {
		this.moduloFiscalPrincipal = moduloFiscalPrincipal;
	}


	public String getModuloFiscalContingencia() {
		return moduloFiscalContingencia;
	}


	public void setModuloFiscalContingencia(String moduloFiscalContingencia) {
		this.moduloFiscalContingencia = moduloFiscalContingencia;
	}


	public String getAcbrMonitorEndereco() {
		return acbrMonitorEndereco;
	}


	public void setAcbrMonitorEndereco(String acbrMonitorEndereco) {
		this.acbrMonitorEndereco = acbrMonitorEndereco;
	}


	public int getAcbrMonitorPorta() {
		return acbrMonitorPorta;
	}


	public void setAcbrMonitorPorta(int acbrMonitorPorta) {
		this.acbrMonitorPorta = acbrMonitorPorta;
	}


}