package com.t2ti.fenix.model.cadastros;

import java.io.Serializable;
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
 * The persistent class for the colaborador database table.
 * 
 */
@Entity
@NamedQuery(name="Colaborador.findAll", query="SELECT c FROM Colaborador c")
public class Colaborador implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private Integer id;

	@Temporal(TemporalType.DATE)
	@Column(name="CTPS_DATA_EXPEDICAO")
	private Date ctpsDataExpedicao;

	@Column(name="CTPS_NUMERO")
	private String ctpsNumero;

	@Column(name="CTPS_SERIE")
	private String ctpsSerie;

	@Column(name="CTPS_UF")
	private String ctpsUf;

	@Temporal(TemporalType.DATE)
	@Column(name="DATA_ADMISSAO")
	private Date dataAdmissao;

	@Temporal(TemporalType.DATE)
	@Column(name="DATA_CADASTRO")
	private Date dataCadastro;

	@Temporal(TemporalType.DATE)
	@Column(name="DATA_DEMISSAO")
	private Date dataDemissao;

	@Lob
	@Column(name="FOTO_34")
	private String foto34;

	private String matricula;

	@Lob
	private String observacao;

	@Column(name="PAGAMENTO_AGENCIA")
	private String pagamentoAgencia;

	@Column(name="PAGAMENTO_AGENCIA_DIGITO")
	private String pagamentoAgenciaDigito;

	@Column(name="PAGAMENTO_BANCO")
	private String pagamentoBanco;

	@Column(name="PAGAMENTO_CONTA")
	private String pagamentoConta;

	@Column(name="PAGAMENTO_CONTA_DIGITO")
	private String pagamentoContaDigito;

	@Column(name="PAGAMENTO_FORMA")
	private String pagamentoForma;

	//bi-directional many-to-one association to Setor
	@ManyToOne
	@JoinColumn(name="ID_SETOR")
	private Setor setor;

	//bi-directional many-to-one association to Cargo
	@ManyToOne
	@JoinColumn(name="ID_CARGO")
	private Cargo cargo;

	//bi-directional many-to-one association to TipoColaborador
	@ManyToOne
	@JoinColumn(name="ID_TIPO_COLABORADOR")
	private TipoColaborador tipoColaborador;

	//bi-directional many-to-one association to Pessoa
	@ManyToOne
	@JoinColumn(name="ID_PESSOA")
	private Pessoa pessoa;


	public Colaborador() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getCtpsDataExpedicao() {
		return this.ctpsDataExpedicao;
	}

	public void setCtpsDataExpedicao(Date ctpsDataExpedicao) {
		this.ctpsDataExpedicao = ctpsDataExpedicao;
	}

	public String getCtpsNumero() {
		return this.ctpsNumero;
	}

	public void setCtpsNumero(String ctpsNumero) {
		this.ctpsNumero = ctpsNumero;
	}

	public String getCtpsSerie() {
		return this.ctpsSerie;
	}

	public void setCtpsSerie(String ctpsSerie) {
		this.ctpsSerie = ctpsSerie;
	}

	public String getCtpsUf() {
		return this.ctpsUf;
	}

	public void setCtpsUf(String ctpsUf) {
		this.ctpsUf = ctpsUf;
	}

	public Date getDataAdmissao() {
		return this.dataAdmissao;
	}

	public void setDataAdmissao(Date dataAdmissao) {
		this.dataAdmissao = dataAdmissao;
	}

	public Date getDataCadastro() {
		return this.dataCadastro;
	}

	public void setDataCadastro(Date dataCadastro) {
		this.dataCadastro = dataCadastro;
	}

	public Date getDataDemissao() {
		return this.dataDemissao;
	}

	public void setDataDemissao(Date dataDemissao) {
		this.dataDemissao = dataDemissao;
	}

	public String getFoto34() {
		return this.foto34;
	}

	public void setFoto34(String foto34) {
		this.foto34 = foto34;
	}

	public String getMatricula() {
		return this.matricula;
	}

	public void setMatricula(String matricula) {
		this.matricula = matricula;
	}

	public String getObservacao() {
		return this.observacao;
	}

	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}

	public String getPagamentoAgencia() {
		return this.pagamentoAgencia;
	}

	public void setPagamentoAgencia(String pagamentoAgencia) {
		this.pagamentoAgencia = pagamentoAgencia;
	}

	public String getPagamentoAgenciaDigito() {
		return this.pagamentoAgenciaDigito;
	}

	public void setPagamentoAgenciaDigito(String pagamentoAgenciaDigito) {
		this.pagamentoAgenciaDigito = pagamentoAgenciaDigito;
	}

	public String getPagamentoBanco() {
		return this.pagamentoBanco;
	}

	public void setPagamentoBanco(String pagamentoBanco) {
		this.pagamentoBanco = pagamentoBanco;
	}

	public String getPagamentoConta() {
		return this.pagamentoConta;
	}

	public void setPagamentoConta(String pagamentoConta) {
		this.pagamentoConta = pagamentoConta;
	}

	public String getPagamentoContaDigito() {
		return this.pagamentoContaDigito;
	}

	public void setPagamentoContaDigito(String pagamentoContaDigito) {
		this.pagamentoContaDigito = pagamentoContaDigito;
	}

	public String getPagamentoForma() {
		return this.pagamentoForma;
	}

	public void setPagamentoForma(String pagamentoForma) {
		this.pagamentoForma = pagamentoForma;
	}

	public Setor getSetor() {
		return this.setor;
	}

	public void setSetor(Setor setor) {
		this.setor = setor;
	}

	public Cargo getCargo() {
		return this.cargo;
	}

	public void setCargo(Cargo cargo) {
		this.cargo = cargo;
	}

	public TipoColaborador getTipoColaborador() {
		return this.tipoColaborador;
	}

	public void setTipoColaborador(TipoColaborador tipoColaborador) {
		this.tipoColaborador = tipoColaborador;
	}

	public Pessoa getPessoa() {
		return this.pessoa;
	}

	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}

}