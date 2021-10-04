package com.t2ti.fenix.model.cadastros;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the produto database table.
 * 
 */
@Entity
@NamedQuery(name="Produto.findAll", query="SELECT p FROM Produto p")
public class Produto implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private Integer id;

	@Column(name="CODIGO_BALANCA")
	private Integer codigoBalanca;

	@Column(name="CODIGO_INTERNO")
	private String codigoInterno;

	@Temporal(TemporalType.DATE)
	@Column(name="DATA_CADASTRO")
	private Date dataCadastro;

	@Lob
	private String descricao;

	@Column(name="DESCRICAO_PDV")
	private String descricaoPdv;

	@Column(name="ESTOQUE_IDEAL")
	private BigDecimal estoqueIdeal;

	@Column(name="ESTOQUE_MAXIMO")
	private BigDecimal estoqueMaximo;

	@Column(name="ESTOQUE_MINIMO")
	private BigDecimal estoqueMinimo;

	private String excluido;

	@Lob
	@Column(name="FOTO_PRODUTO")
	private String fotoProduto;

	private String gtin;

	private String iat;

	private String inativo;

	private String ippt;

	private String ncm;

	private String nome;

	@Column(name="PRECO_LUCRO_MAXIMO")
	private BigDecimal precoLucroMaximo;

	@Column(name="PRECO_LUCRO_MINIMO")
	private BigDecimal precoLucroMinimo;

	@Column(name="PRECO_LUCRO_ZERO")
	private BigDecimal precoLucroZero;

	@Column(name="PRECO_VENDA_MINIMO")
	private BigDecimal precoVendaMinimo;

	@Column(name="QUANTIDADE_ESTOQUE")
	private BigDecimal quantidadeEstoque;

	@Column(name="QUANTIDADE_ESTOQUE_ANTERIOR")
	private BigDecimal quantidadeEstoqueAnterior;

	@Column(name="TIPO_ITEM_SPED")
	private String tipoItemSped;

	@Column(name="TOTALIZADOR_PARCIAL")
	private String totalizadorParcial;

	@Column(name="VALOR_COMPRA")
	private BigDecimal valorCompra;

	@Column(name="VALOR_VENDA")
	private BigDecimal valorVenda;

	//bi-directional many-to-one association to UnidadeProduto
	@ManyToOne
	@JoinColumn(name="ID_UNIDADE_PRODUTO")
	private UnidadeProduto unidadeProduto;

	//bi-directional many-to-one association to ProdutoSubGrupo
	@ManyToOne
	@JoinColumn(name="ID_SUB_GRUPO")
	private ProdutoSubGrupo produtoSubGrupo;

	//bi-directional many-to-one association to ProdutoMarca
	@ManyToOne
	@JoinColumn(name="ID_MARCA_PRODUTO")
	private ProdutoMarca produtoMarca;

	public Produto() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCodigoBalanca() {
		return this.codigoBalanca;
	}

	public void setCodigoBalanca(Integer codigoBalanca) {
		this.codigoBalanca = codigoBalanca;
	}

	public String getCodigoInterno() {
		return this.codigoInterno;
	}

	public void setCodigoInterno(String codigoInterno) {
		this.codigoInterno = codigoInterno;
	}

	public Date getDataCadastro() {
		return this.dataCadastro;
	}

	public void setDataCadastro(Date dataCadastro) {
		this.dataCadastro = dataCadastro;
	}

	public String getDescricao() {
		return this.descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getDescricaoPdv() {
		return this.descricaoPdv;
	}

	public void setDescricaoPdv(String descricaoPdv) {
		this.descricaoPdv = descricaoPdv;
	}

	public BigDecimal getEstoqueIdeal() {
		return this.estoqueIdeal;
	}

	public void setEstoqueIdeal(BigDecimal estoqueIdeal) {
		this.estoqueIdeal = estoqueIdeal;
	}

	public BigDecimal getEstoqueMaximo() {
		return this.estoqueMaximo;
	}

	public void setEstoqueMaximo(BigDecimal estoqueMaximo) {
		this.estoqueMaximo = estoqueMaximo;
	}

	public BigDecimal getEstoqueMinimo() {
		return this.estoqueMinimo;
	}

	public void setEstoqueMinimo(BigDecimal estoqueMinimo) {
		this.estoqueMinimo = estoqueMinimo;
	}

	public String getExcluido() {
		return this.excluido;
	}

	public void setExcluido(String excluido) {
		this.excluido = excluido;
	}

	public String getFotoProduto() {
		return this.fotoProduto;
	}

	public void setFotoProduto(String fotoProduto) {
		this.fotoProduto = fotoProduto;
	}

	public String getGtin() {
		return this.gtin;
	}

	public void setGtin(String gtin) {
		this.gtin = gtin;
	}

	public String getIat() {
		return this.iat;
	}

	public void setIat(String iat) {
		this.iat = iat;
	}

	public String getInativo() {
		return this.inativo;
	}

	public void setInativo(String inativo) {
		this.inativo = inativo;
	}

	public String getIppt() {
		return this.ippt;
	}

	public void setIppt(String ippt) {
		this.ippt = ippt;
	}

	public String getNcm() {
		return this.ncm;
	}

	public void setNcm(String ncm) {
		this.ncm = ncm;
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public BigDecimal getPrecoLucroMaximo() {
		return this.precoLucroMaximo;
	}

	public void setPrecoLucroMaximo(BigDecimal precoLucroMaximo) {
		this.precoLucroMaximo = precoLucroMaximo;
	}

	public BigDecimal getPrecoLucroMinimo() {
		return this.precoLucroMinimo;
	}

	public void setPrecoLucroMinimo(BigDecimal precoLucroMinimo) {
		this.precoLucroMinimo = precoLucroMinimo;
	}

	public BigDecimal getPrecoLucroZero() {
		return this.precoLucroZero;
	}

	public void setPrecoLucroZero(BigDecimal precoLucroZero) {
		this.precoLucroZero = precoLucroZero;
	}

	public BigDecimal getPrecoVendaMinimo() {
		return this.precoVendaMinimo;
	}

	public void setPrecoVendaMinimo(BigDecimal precoVendaMinimo) {
		this.precoVendaMinimo = precoVendaMinimo;
	}

	public BigDecimal getQuantidadeEstoque() {
		return this.quantidadeEstoque;
	}

	public void setQuantidadeEstoque(BigDecimal quantidadeEstoque) {
		this.quantidadeEstoque = quantidadeEstoque;
	}

	public BigDecimal getQuantidadeEstoqueAnterior() {
		return this.quantidadeEstoqueAnterior;
	}

	public void setQuantidadeEstoqueAnterior(BigDecimal quantidadeEstoqueAnterior) {
		this.quantidadeEstoqueAnterior = quantidadeEstoqueAnterior;
	}

	public String getTipoItemSped() {
		return this.tipoItemSped;
	}

	public void setTipoItemSped(String tipoItemSped) {
		this.tipoItemSped = tipoItemSped;
	}

	public String getTotalizadorParcial() {
		return this.totalizadorParcial;
	}

	public void setTotalizadorParcial(String totalizadorParcial) {
		this.totalizadorParcial = totalizadorParcial;
	}

	public BigDecimal getValorCompra() {
		return this.valorCompra;
	}

	public void setValorCompra(BigDecimal valorCompra) {
		this.valorCompra = valorCompra;
	}

	public BigDecimal getValorVenda() {
		return this.valorVenda;
	}

	public void setValorVenda(BigDecimal valorVenda) {
		this.valorVenda = valorVenda;
	}

	public UnidadeProduto getUnidadeProduto() {
		return this.unidadeProduto;
	}

	public void setUnidadeProduto(UnidadeProduto unidadeProduto) {
		this.unidadeProduto = unidadeProduto;
	}

	public ProdutoSubGrupo getProdutoSubGrupo() {
		return this.produtoSubGrupo;
	}

	public void setProdutoSubGrupo(ProdutoSubGrupo produtoSubGrupo) {
		this.produtoSubGrupo = produtoSubGrupo;
	}

	public ProdutoMarca getProdutoMarca() {
		return this.produtoMarca;
	}

	public void setProdutoMarca(ProdutoMarca produtoMarca) {
		this.produtoMarca = produtoMarca;
	}

}