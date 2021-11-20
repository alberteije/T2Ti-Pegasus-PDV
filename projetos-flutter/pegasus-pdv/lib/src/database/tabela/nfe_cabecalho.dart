/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_CABECALHO] 
                                                                                
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
import 'package:moor/moor.dart';

import '../database_classes.dart';

@DataClassName("NfeCabecalho")
@UseRowClass(NfeCabecalho)
class NfeCabecalhos extends Table {
  @override
  String get tableName => 'NFE_CABECALHO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idTributOperacaoFiscal => integer().named('ID_TRIBUT_OPERACAO_FISCAL').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_OPERACAO_FISCAL(ID)')();
  IntColumn get ufEmitente => integer().named('UF_EMITENTE').nullable()();
  TextColumn get codigoNumerico => text().named('CODIGO_NUMERICO').withLength(min: 0, max: 8).nullable()();
  TextColumn get naturezaOperacao => text().named('NATUREZA_OPERACAO').withLength(min: 0, max: 60).nullable()();
  TextColumn get codigoModelo => text().named('CODIGO_MODELO').withLength(min: 0, max: 2).nullable()();
  TextColumn get serie => text().named('SERIE').withLength(min: 0, max: 3).nullable()();
  TextColumn get numero => text().named('NUMERO').withLength(min: 0, max: 9).nullable()();
  DateTimeColumn get dataHoraEmissao => dateTime().named('DATA_HORA_EMISSAO').nullable()();
  DateTimeColumn get dataHoraEntradaSaida => dateTime().named('DATA_HORA_ENTRADA_SAIDA').nullable()();
  TextColumn get tipoOperacao => text().named('TIPO_OPERACAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get localDestino => text().named('LOCAL_DESTINO').withLength(min: 0, max: 1).nullable()();
  IntColumn get codigoMunicipio => integer().named('CODIGO_MUNICIPIO').nullable()();
  TextColumn get formatoImpressaoDanfe => text().named('FORMATO_IMPRESSAO_DANFE').withLength(min: 0, max: 1).nullable()();
  TextColumn get tipoEmissao => text().named('TIPO_EMISSAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get chaveAcesso => text().named('CHAVE_ACESSO').withLength(min: 0, max: 44).nullable()();
  TextColumn get digitoChaveAcesso => text().named('DIGITO_CHAVE_ACESSO').withLength(min: 0, max: 1).nullable()();
  TextColumn get ambiente => text().named('AMBIENTE').withLength(min: 0, max: 1).nullable()();
  TextColumn get finalidadeEmissao => text().named('FINALIDADE_EMISSAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get consumidorOperacao => text().named('CONSUMIDOR_OPERACAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get consumidorPresenca => text().named('CONSUMIDOR_PRESENCA').withLength(min: 0, max: 1).nullable()();
  TextColumn get processoEmissao => text().named('PROCESSO_EMISSAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get versaoProcessoEmissao => text().named('VERSAO_PROCESSO_EMISSAO').withLength(min: 0, max: 20).nullable()();
  DateTimeColumn get dataEntradaContingencia => dateTime().named('DATA_ENTRADA_CONTINGENCIA').nullable()();
  TextColumn get justificativaContingencia => text().named('JUSTIFICATIVA_CONTINGENCIA').withLength(min: 0, max: 255).nullable()();
  RealColumn get baseCalculoIcms => real().named('BASE_CALCULO_ICMS').nullable()();
  RealColumn get valorIcms => real().named('VALOR_ICMS').nullable()();
  RealColumn get valorIcmsDesonerado => real().named('VALOR_ICMS_DESONERADO').nullable()();
  RealColumn get totalIcmsFcpUfDestino => real().named('TOTAL_ICMS_FCP_UF_DESTINO').nullable()();
  RealColumn get totalIcmsInterestadualUfDestino => real().named('TOTAL_ICMS_INTERESTADUAL_UF_DESTINO').nullable()();
  RealColumn get totalIcmsInterestadualUfRemetente => real().named('TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE').nullable()();
  RealColumn get valorTotalFcp => real().named('VALOR_TOTAL_FCP').nullable()();
  RealColumn get baseCalculoIcmsSt => real().named('BASE_CALCULO_ICMS_ST').nullable()();
  RealColumn get valorIcmsSt => real().named('VALOR_ICMS_ST').nullable()();
  RealColumn get valorTotalFcpSt => real().named('VALOR_TOTAL_FCP_ST').nullable()();
  RealColumn get valorTotalFcpStRetido => real().named('VALOR_TOTAL_FCP_ST_RETIDO').nullable()();
  RealColumn get valorTotalProdutos => real().named('VALOR_TOTAL_PRODUTOS').nullable()();
  RealColumn get valorFrete => real().named('VALOR_FRETE').nullable()();
  RealColumn get valorSeguro => real().named('VALOR_SEGURO').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get valorImpostoImportacao => real().named('VALOR_IMPOSTO_IMPORTACAO').nullable()();
  RealColumn get valorIpi => real().named('VALOR_IPI').nullable()();
  RealColumn get valorIpiDevolvido => real().named('VALOR_IPI_DEVOLVIDO').nullable()();
  RealColumn get valorPis => real().named('VALOR_PIS').nullable()();
  RealColumn get valorCofins => real().named('VALOR_COFINS').nullable()();
  RealColumn get valorDespesasAcessorias => real().named('VALOR_DESPESAS_ACESSORIAS').nullable()();
  RealColumn get valorTotal => real().named('VALOR_TOTAL').nullable()();
  RealColumn get valorTotalTributos => real().named('VALOR_TOTAL_TRIBUTOS').nullable()();
  RealColumn get valorServicos => real().named('VALOR_SERVICOS').nullable()();
  RealColumn get baseCalculoIssqn => real().named('BASE_CALCULO_ISSQN').nullable()();
  RealColumn get valorIssqn => real().named('VALOR_ISSQN').nullable()();
  RealColumn get valorPisIssqn => real().named('VALOR_PIS_ISSQN').nullable()();
  RealColumn get valorCofinsIssqn => real().named('VALOR_COFINS_ISSQN').nullable()();
  DateTimeColumn get dataPrestacaoServico => dateTime().named('DATA_PRESTACAO_SERVICO').nullable()();
  RealColumn get valorDeducaoIssqn => real().named('VALOR_DEDUCAO_ISSQN').nullable()();
  RealColumn get outrasRetencoesIssqn => real().named('OUTRAS_RETENCOES_ISSQN').nullable()();
  RealColumn get descontoIncondicionadoIssqn => real().named('DESCONTO_INCONDICIONADO_ISSQN').nullable()();
  RealColumn get descontoCondicionadoIssqn => real().named('DESCONTO_CONDICIONADO_ISSQN').nullable()();
  RealColumn get totalRetencaoIssqn => real().named('TOTAL_RETENCAO_ISSQN').nullable()();
  TextColumn get regimeEspecialTributacao => text().named('REGIME_ESPECIAL_TRIBUTACAO').withLength(min: 0, max: 1).nullable()();
  RealColumn get valorRetidoPis => real().named('VALOR_RETIDO_PIS').nullable()();
  RealColumn get valorRetidoCofins => real().named('VALOR_RETIDO_COFINS').nullable()();
  RealColumn get valorRetidoCsll => real().named('VALOR_RETIDO_CSLL').nullable()();
  RealColumn get baseCalculoIrrf => real().named('BASE_CALCULO_IRRF').nullable()();
  RealColumn get valorRetidoIrrf => real().named('VALOR_RETIDO_IRRF').nullable()();
  RealColumn get baseCalculoPrevidencia => real().named('BASE_CALCULO_PREVIDENCIA').nullable()();
  RealColumn get valorRetidoPrevidencia => real().named('VALOR_RETIDO_PREVIDENCIA').nullable()();
  TextColumn get informacoesAddFisco => text().named('INFORMACOES_ADD_FISCO').withLength(min: 0, max: 250).nullable()();
  TextColumn get informacoesAddContribuinte => text().named('INFORMACOES_ADD_CONTRIBUINTE').withLength(min: 0, max: 250).nullable()();
  TextColumn get comexUfEmbarque => text().named('COMEX_UF_EMBARQUE').withLength(min: 0, max: 2).nullable()();
  TextColumn get comexLocalEmbarque => text().named('COMEX_LOCAL_EMBARQUE').withLength(min: 0, max: 60).nullable()();
  TextColumn get comexLocalDespacho => text().named('COMEX_LOCAL_DESPACHO').withLength(min: 0, max: 60).nullable()();
  TextColumn get compraNotaEmpenho => text().named('COMPRA_NOTA_EMPENHO').withLength(min: 0, max: 22).nullable()();
  TextColumn get compraPedido => text().named('COMPRA_PEDIDO').withLength(min: 0, max: 60).nullable()();
  TextColumn get compraContrato => text().named('COMPRA_CONTRATO').withLength(min: 0, max: 60).nullable()();
  TextColumn get qrcode => text().named('QRCODE').withLength(min: 0, max: 250).nullable()();
  TextColumn get urlChave => text().named('URL_CHAVE').withLength(min: 0, max: 85).nullable()();
  TextColumn get statusNota => text().named('STATUS_NOTA').withLength(min: 0, max: 1).nullable()();
  IntColumn get idPdvVendaCabecalho => integer().named('ID_PDV_VENDA_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES PDV_VENDA_CABECALHO(ID)')();
}

class NfeCabecalhoMontado {
  NfeCabecalho? nfeCabecalho;
  NfeDestinatario? nfeDestinatario;
  List<NfeInformacaoPagamento>? listaNfeInformacaoPagamento;
  List<NfeDetalheMontado>? listaNfeDetalheMontado;

  NfeCabecalhoMontado({
    this.nfeCabecalho,
    this.nfeDestinatario,
    this.listaNfeInformacaoPagamento,
    this.listaNfeDetalheMontado,
  });
}

class NfeCabecalho extends DataClass implements Insertable<NfeCabecalho> {
  final int? id;
  final int? idTributOperacaoFiscal;
  final int? ufEmitente;
  final String? codigoNumerico;
  final String? naturezaOperacao;
  final String? codigoModelo;
  final String? serie;
  final String? numero;
  final DateTime? dataHoraEmissao;
  final DateTime? dataHoraEntradaSaida;
  final String? tipoOperacao;
  final String? localDestino;
  final int? codigoMunicipio;
  final String? formatoImpressaoDanfe;
  final String? tipoEmissao;
  final String? chaveAcesso;
  final String? digitoChaveAcesso;
  final String? ambiente;
  final String? finalidadeEmissao;
  final String? consumidorOperacao;
  final String? consumidorPresenca;
  final String? processoEmissao;
  final String? versaoProcessoEmissao;
  final DateTime? dataEntradaContingencia;
  final String? justificativaContingencia;
  final double? baseCalculoIcms;
  final double? valorIcms;
  final double? valorIcmsDesonerado;
  final double? totalIcmsFcpUfDestino;
  final double? totalIcmsInterestadualUfDestino;
  final double? totalIcmsInterestadualUfRemetente;
  final double? valorTotalFcp;
  final double? baseCalculoIcmsSt;
  final double? valorIcmsSt;
  final double? valorTotalFcpSt;
  final double? valorTotalFcpStRetido;
  final double? valorTotalProdutos;
  final double? valorFrete;
  final double? valorSeguro;
  final double? valorDesconto;
  final double? valorImpostoImportacao;
  final double? valorIpi;
  final double? valorIpiDevolvido;
  final double? valorPis;
  final double? valorCofins;
  final double? valorDespesasAcessorias;
  final double? valorTotal;
  final double? valorTotalTributos;
  final double? valorServicos;
  final double? baseCalculoIssqn;
  final double? valorIssqn;
  final double? valorPisIssqn;
  final double? valorCofinsIssqn;
  final DateTime? dataPrestacaoServico;
  final double? valorDeducaoIssqn;
  final double? outrasRetencoesIssqn;
  final double? descontoIncondicionadoIssqn;
  final double? descontoCondicionadoIssqn;
  final double? totalRetencaoIssqn;
  final String? regimeEspecialTributacao;
  final double? valorRetidoPis;
  final double? valorRetidoCofins;
  final double? valorRetidoCsll;
  final double? baseCalculoIrrf;
  final double? valorRetidoIrrf;
  final double? baseCalculoPrevidencia;
  final double? valorRetidoPrevidencia;
  final String? informacoesAddFisco;
  final String? informacoesAddContribuinte;
  final String? comexUfEmbarque;
  final String? comexLocalEmbarque;
  final String? comexLocalDespacho;
  final String? compraNotaEmpenho;
  final String? compraPedido;
  final String? compraContrato;
  final String? qrcode;
  final String? urlChave;
  final String? statusNota;
  final int? idPdvVendaCabecalho;

  NfeCabecalho(
    {
      required this.id,
      this.idTributOperacaoFiscal,
      this.ufEmitente,
      this.codigoNumerico,
      this.naturezaOperacao,
      this.codigoModelo,
      this.serie,
      this.numero,
      this.dataHoraEmissao,
      this.dataHoraEntradaSaida,
      this.tipoOperacao,
      this.localDestino,
      this.codigoMunicipio,
      this.formatoImpressaoDanfe,
      this.tipoEmissao,
      this.chaveAcesso,
      this.digitoChaveAcesso,
      this.ambiente,
      this.finalidadeEmissao,
      this.consumidorOperacao,
      this.consumidorPresenca,
      this.processoEmissao,
      this.versaoProcessoEmissao,
      this.dataEntradaContingencia,
      this.justificativaContingencia,
      this.baseCalculoIcms,
      this.valorIcms,
      this.valorIcmsDesonerado,
      this.totalIcmsFcpUfDestino,
      this.totalIcmsInterestadualUfDestino,
      this.totalIcmsInterestadualUfRemetente,
      this.valorTotalFcp,
      this.baseCalculoIcmsSt,
      this.valorIcmsSt,
      this.valorTotalFcpSt,
      this.valorTotalFcpStRetido,
      this.valorTotalProdutos,
      this.valorFrete,
      this.valorSeguro,
      this.valorDesconto,
      this.valorImpostoImportacao,
      this.valorIpi,
      this.valorIpiDevolvido,
      this.valorPis,
      this.valorCofins,
      this.valorDespesasAcessorias,
      this.valorTotal,
      this.valorTotalTributos,
      this.valorServicos,
      this.baseCalculoIssqn,
      this.valorIssqn,
      this.valorPisIssqn,
      this.valorCofinsIssqn,
      this.dataPrestacaoServico,
      this.valorDeducaoIssqn,
      this.outrasRetencoesIssqn,
      this.descontoIncondicionadoIssqn,
      this.descontoCondicionadoIssqn,
      this.totalRetencaoIssqn,
      this.regimeEspecialTributacao,
      this.valorRetidoPis,
      this.valorRetidoCofins,
      this.valorRetidoCsll,
      this.baseCalculoIrrf,
      this.valorRetidoIrrf,
      this.baseCalculoPrevidencia,
      this.valorRetidoPrevidencia,
      this.informacoesAddFisco,
      this.informacoesAddContribuinte,
      this.comexUfEmbarque,
      this.comexLocalEmbarque,
      this.comexLocalDespacho,
      this.compraNotaEmpenho,
      this.compraPedido,
      this.compraContrato,
      this.qrcode,
      this.urlChave,
      this.statusNota,
      this.idPdvVendaCabecalho,
    }
  );

  factory NfeCabecalho.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeCabecalho(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idTributOperacaoFiscal: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_TRIBUT_OPERACAO_FISCAL']),
      ufEmitente: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}UF_EMITENTE']),
      codigoNumerico: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_NUMERICO']),
      naturezaOperacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NATUREZA_OPERACAO']),
      codigoModelo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_MODELO']),
      serie: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SERIE']),
      numero: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO']),
      dataHoraEmissao: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_HORA_EMISSAO']),
      dataHoraEntradaSaida: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_HORA_ENTRADA_SAIDA']),
      tipoOperacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_OPERACAO']),
      localDestino: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}LOCAL_DESTINO']),
      codigoMunicipio: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_MUNICIPIO']),
      formatoImpressaoDanfe: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}FORMATO_IMPRESSAO_DANFE']),
      tipoEmissao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_EMISSAO']),
      chaveAcesso: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CHAVE_ACESSO']),
      digitoChaveAcesso: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DIGITO_CHAVE_ACESSO']),
      ambiente: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}AMBIENTE']),
      finalidadeEmissao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}FINALIDADE_EMISSAO']),
      consumidorOperacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CONSUMIDOR_OPERACAO']),
      consumidorPresenca: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CONSUMIDOR_PRESENCA']),
      processoEmissao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PROCESSO_EMISSAO']),
      versaoProcessoEmissao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}VERSAO_PROCESSO_EMISSAO']),
      dataEntradaContingencia: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_ENTRADA_CONTINGENCIA']),
      justificativaContingencia: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}JUSTIFICATIVA_CONTINGENCIA']),
      baseCalculoIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_ICMS']),
      valorIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS']),
      valorIcmsDesonerado: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_DESONERADO']),
      totalIcmsFcpUfDestino: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TOTAL_ICMS_FCP_UF_DESTINO']),
      totalIcmsInterestadualUfDestino: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TOTAL_ICMS_INTERESTADUAL_UF_DESTINO']),
      totalIcmsInterestadualUfRemetente: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE']),
      valorTotalFcp: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL_FCP']),
      baseCalculoIcmsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_ICMS_ST']),
      valorIcmsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_ST']),
      valorTotalFcpSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL_FCP_ST']),
      valorTotalFcpStRetido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL_FCP_ST_RETIDO']),
      valorTotalProdutos: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL_PRODUTOS']),
      valorFrete: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_FRETE']),
      valorSeguro: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_SEGURO']),
      valorDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DESCONTO']),
      valorImpostoImportacao: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IMPOSTO_IMPORTACAO']),
      valorIpi: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IPI']),
      valorIpiDevolvido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IPI_DEVOLVIDO']),
      valorPis: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PIS']),
      valorCofins: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_COFINS']),
      valorDespesasAcessorias: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DESPESAS_ACESSORIAS']),
      valorTotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL']),
      valorTotalTributos: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL_TRIBUTOS']),
      valorServicos: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_SERVICOS']),
      baseCalculoIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_ISSQN']),
      valorIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ISSQN']),
      valorPisIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PIS_ISSQN']),
      valorCofinsIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_COFINS_ISSQN']),
      dataPrestacaoServico: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_PRESTACAO_SERVICO']),
      valorDeducaoIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DEDUCAO_ISSQN']),
      outrasRetencoesIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}OUTRAS_RETENCOES_ISSQN']),
      descontoIncondicionadoIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}DESCONTO_INCONDICIONADO_ISSQN']),
      descontoCondicionadoIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}DESCONTO_CONDICIONADO_ISSQN']),
      totalRetencaoIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TOTAL_RETENCAO_ISSQN']),
      regimeEspecialTributacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}REGIME_ESPECIAL_TRIBUTACAO']),
      valorRetidoPis: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_RETIDO_PIS']),
      valorRetidoCofins: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_RETIDO_COFINS']),
      valorRetidoCsll: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_RETIDO_CSLL']),
      baseCalculoIrrf: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_IRRF']),
      valorRetidoIrrf: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_RETIDO_IRRF']),
      baseCalculoPrevidencia: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_PREVIDENCIA']),
      valorRetidoPrevidencia: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_RETIDO_PREVIDENCIA']),
      informacoesAddFisco: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}INFORMACOES_ADD_FISCO']),
      informacoesAddContribuinte: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}INFORMACOES_ADD_CONTRIBUINTE']),
      comexUfEmbarque: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}COMEX_UF_EMBARQUE']),
      comexLocalEmbarque: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}COMEX_LOCAL_EMBARQUE']),
      comexLocalDespacho: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}COMEX_LOCAL_DESPACHO']),
      compraNotaEmpenho: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}COMPRA_NOTA_EMPENHO']),
      compraPedido: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}COMPRA_PEDIDO']),
      compraContrato: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}COMPRA_CONTRATO']),
      qrcode: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}QRCODE']),
      urlChave: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}URL_CHAVE']),
      statusNota: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}STATUS_NOTA']),
      idPdvVendaCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_VENDA_CABECALHO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idTributOperacaoFiscal != null) {
      map['ID_TRIBUT_OPERACAO_FISCAL'] = Variable<int?>(idTributOperacaoFiscal);
    }
    if (!nullToAbsent || ufEmitente != null) {
      map['UF_EMITENTE'] = Variable<int?>(ufEmitente);
    }
    if (!nullToAbsent || codigoNumerico != null) {
      map['CODIGO_NUMERICO'] = Variable<String?>(codigoNumerico);
    }
    if (!nullToAbsent || naturezaOperacao != null) {
      map['NATUREZA_OPERACAO'] = Variable<String?>(naturezaOperacao);
    }
    if (!nullToAbsent || codigoModelo != null) {
      map['CODIGO_MODELO'] = Variable<String?>(codigoModelo);
    }
    if (!nullToAbsent || serie != null) {
      map['SERIE'] = Variable<String?>(serie);
    }
    if (!nullToAbsent || numero != null) {
      map['NUMERO'] = Variable<String?>(numero);
    }
    if (!nullToAbsent || dataHoraEmissao != null) {
      map['DATA_HORA_EMISSAO'] = Variable<DateTime?>(dataHoraEmissao);
    }
    if (!nullToAbsent || dataHoraEntradaSaida != null) {
      map['DATA_HORA_ENTRADA_SAIDA'] = Variable<DateTime?>(dataHoraEntradaSaida);
    }
    if (!nullToAbsent || tipoOperacao != null) {
      map['TIPO_OPERACAO'] = Variable<String?>(tipoOperacao);
    }
    if (!nullToAbsent || localDestino != null) {
      map['LOCAL_DESTINO'] = Variable<String?>(localDestino);
    }
    if (!nullToAbsent || codigoMunicipio != null) {
      map['CODIGO_MUNICIPIO'] = Variable<int?>(codigoMunicipio);
    }
    if (!nullToAbsent || formatoImpressaoDanfe != null) {
      map['FORMATO_IMPRESSAO_DANFE'] = Variable<String?>(formatoImpressaoDanfe);
    }
    if (!nullToAbsent || tipoEmissao != null) {
      map['TIPO_EMISSAO'] = Variable<String?>(tipoEmissao);
    }
    if (!nullToAbsent || chaveAcesso != null) {
      map['CHAVE_ACESSO'] = Variable<String?>(chaveAcesso);
    }
    if (!nullToAbsent || digitoChaveAcesso != null) {
      map['DIGITO_CHAVE_ACESSO'] = Variable<String?>(digitoChaveAcesso);
    }
    if (!nullToAbsent || ambiente != null) {
      map['AMBIENTE'] = Variable<String?>(ambiente);
    }
    if (!nullToAbsent || finalidadeEmissao != null) {
      map['FINALIDADE_EMISSAO'] = Variable<String?>(finalidadeEmissao);
    }
    if (!nullToAbsent || consumidorOperacao != null) {
      map['CONSUMIDOR_OPERACAO'] = Variable<String?>(consumidorOperacao);
    }
    if (!nullToAbsent || consumidorPresenca != null) {
      map['CONSUMIDOR_PRESENCA'] = Variable<String?>(consumidorPresenca);
    }
    if (!nullToAbsent || processoEmissao != null) {
      map['PROCESSO_EMISSAO'] = Variable<String?>(processoEmissao);
    }
    if (!nullToAbsent || versaoProcessoEmissao != null) {
      map['VERSAO_PROCESSO_EMISSAO'] = Variable<String?>(versaoProcessoEmissao);
    }
    if (!nullToAbsent || dataEntradaContingencia != null) {
      map['DATA_ENTRADA_CONTINGENCIA'] = Variable<DateTime?>(dataEntradaContingencia);
    }
    if (!nullToAbsent || justificativaContingencia != null) {
      map['JUSTIFICATIVA_CONTINGENCIA'] = Variable<String?>(justificativaContingencia);
    }
    if (!nullToAbsent || baseCalculoIcms != null) {
      map['BASE_CALCULO_ICMS'] = Variable<double?>(baseCalculoIcms);
    }
    if (!nullToAbsent || valorIcms != null) {
      map['VALOR_ICMS'] = Variable<double?>(valorIcms);
    }
    if (!nullToAbsent || valorIcmsDesonerado != null) {
      map['VALOR_ICMS_DESONERADO'] = Variable<double?>(valorIcmsDesonerado);
    }
    if (!nullToAbsent || totalIcmsFcpUfDestino != null) {
      map['TOTAL_ICMS_FCP_UF_DESTINO'] = Variable<double?>(totalIcmsFcpUfDestino);
    }
    if (!nullToAbsent || totalIcmsInterestadualUfDestino != null) {
      map['TOTAL_ICMS_INTERESTADUAL_UF_DESTINO'] = Variable<double?>(totalIcmsInterestadualUfDestino);
    }
    if (!nullToAbsent || totalIcmsInterestadualUfRemetente != null) {
      map['TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE'] = Variable<double?>(totalIcmsInterestadualUfRemetente);
    }
    if (!nullToAbsent || valorTotalFcp != null) {
      map['VALOR_TOTAL_FCP'] = Variable<double?>(valorTotalFcp);
    }
    if (!nullToAbsent || baseCalculoIcmsSt != null) {
      map['BASE_CALCULO_ICMS_ST'] = Variable<double?>(baseCalculoIcmsSt);
    }
    if (!nullToAbsent || valorIcmsSt != null) {
      map['VALOR_ICMS_ST'] = Variable<double?>(valorIcmsSt);
    }
    if (!nullToAbsent || valorTotalFcpSt != null) {
      map['VALOR_TOTAL_FCP_ST'] = Variable<double?>(valorTotalFcpSt);
    }
    if (!nullToAbsent || valorTotalFcpStRetido != null) {
      map['VALOR_TOTAL_FCP_ST_RETIDO'] = Variable<double?>(valorTotalFcpStRetido);
    }
    if (!nullToAbsent || valorTotalProdutos != null) {
      map['VALOR_TOTAL_PRODUTOS'] = Variable<double?>(valorTotalProdutos);
    }
    if (!nullToAbsent || valorFrete != null) {
      map['VALOR_FRETE'] = Variable<double?>(valorFrete);
    }
    if (!nullToAbsent || valorSeguro != null) {
      map['VALOR_SEGURO'] = Variable<double?>(valorSeguro);
    }
    if (!nullToAbsent || valorDesconto != null) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto);
    }
    if (!nullToAbsent || valorImpostoImportacao != null) {
      map['VALOR_IMPOSTO_IMPORTACAO'] = Variable<double?>(valorImpostoImportacao);
    }
    if (!nullToAbsent || valorIpi != null) {
      map['VALOR_IPI'] = Variable<double?>(valorIpi);
    }
    if (!nullToAbsent || valorIpiDevolvido != null) {
      map['VALOR_IPI_DEVOLVIDO'] = Variable<double?>(valorIpiDevolvido);
    }
    if (!nullToAbsent || valorPis != null) {
      map['VALOR_PIS'] = Variable<double?>(valorPis);
    }
    if (!nullToAbsent || valorCofins != null) {
      map['VALOR_COFINS'] = Variable<double?>(valorCofins);
    }
    if (!nullToAbsent || valorDespesasAcessorias != null) {
      map['VALOR_DESPESAS_ACESSORIAS'] = Variable<double?>(valorDespesasAcessorias);
    }
    if (!nullToAbsent || valorTotal != null) {
      map['VALOR_TOTAL'] = Variable<double?>(valorTotal);
    }
    if (!nullToAbsent || valorTotalTributos != null) {
      map['VALOR_TOTAL_TRIBUTOS'] = Variable<double?>(valorTotalTributos);
    }
    if (!nullToAbsent || valorServicos != null) {
      map['VALOR_SERVICOS'] = Variable<double?>(valorServicos);
    }
    if (!nullToAbsent || baseCalculoIssqn != null) {
      map['BASE_CALCULO_ISSQN'] = Variable<double?>(baseCalculoIssqn);
    }
    if (!nullToAbsent || valorIssqn != null) {
      map['VALOR_ISSQN'] = Variable<double?>(valorIssqn);
    }
    if (!nullToAbsent || valorPisIssqn != null) {
      map['VALOR_PIS_ISSQN'] = Variable<double?>(valorPisIssqn);
    }
    if (!nullToAbsent || valorCofinsIssqn != null) {
      map['VALOR_COFINS_ISSQN'] = Variable<double?>(valorCofinsIssqn);
    }
    if (!nullToAbsent || dataPrestacaoServico != null) {
      map['DATA_PRESTACAO_SERVICO'] = Variable<DateTime?>(dataPrestacaoServico);
    }
    if (!nullToAbsent || valorDeducaoIssqn != null) {
      map['VALOR_DEDUCAO_ISSQN'] = Variable<double?>(valorDeducaoIssqn);
    }
    if (!nullToAbsent || outrasRetencoesIssqn != null) {
      map['OUTRAS_RETENCOES_ISSQN'] = Variable<double?>(outrasRetencoesIssqn);
    }
    if (!nullToAbsent || descontoIncondicionadoIssqn != null) {
      map['DESCONTO_INCONDICIONADO_ISSQN'] = Variable<double?>(descontoIncondicionadoIssqn);
    }
    if (!nullToAbsent || descontoCondicionadoIssqn != null) {
      map['DESCONTO_CONDICIONADO_ISSQN'] = Variable<double?>(descontoCondicionadoIssqn);
    }
    if (!nullToAbsent || totalRetencaoIssqn != null) {
      map['TOTAL_RETENCAO_ISSQN'] = Variable<double?>(totalRetencaoIssqn);
    }
    if (!nullToAbsent || regimeEspecialTributacao != null) {
      map['REGIME_ESPECIAL_TRIBUTACAO'] = Variable<String?>(regimeEspecialTributacao);
    }
    if (!nullToAbsent || valorRetidoPis != null) {
      map['VALOR_RETIDO_PIS'] = Variable<double?>(valorRetidoPis);
    }
    if (!nullToAbsent || valorRetidoCofins != null) {
      map['VALOR_RETIDO_COFINS'] = Variable<double?>(valorRetidoCofins);
    }
    if (!nullToAbsent || valorRetidoCsll != null) {
      map['VALOR_RETIDO_CSLL'] = Variable<double?>(valorRetidoCsll);
    }
    if (!nullToAbsent || baseCalculoIrrf != null) {
      map['BASE_CALCULO_IRRF'] = Variable<double?>(baseCalculoIrrf);
    }
    if (!nullToAbsent || valorRetidoIrrf != null) {
      map['VALOR_RETIDO_IRRF'] = Variable<double?>(valorRetidoIrrf);
    }
    if (!nullToAbsent || baseCalculoPrevidencia != null) {
      map['BASE_CALCULO_PREVIDENCIA'] = Variable<double?>(baseCalculoPrevidencia);
    }
    if (!nullToAbsent || valorRetidoPrevidencia != null) {
      map['VALOR_RETIDO_PREVIDENCIA'] = Variable<double?>(valorRetidoPrevidencia);
    }
    if (!nullToAbsent || informacoesAddFisco != null) {
      map['INFORMACOES_ADD_FISCO'] = Variable<String?>(informacoesAddFisco);
    }
    if (!nullToAbsent || informacoesAddContribuinte != null) {
      map['INFORMACOES_ADD_CONTRIBUINTE'] = Variable<String?>(informacoesAddContribuinte);
    }
    if (!nullToAbsent || comexUfEmbarque != null) {
      map['COMEX_UF_EMBARQUE'] = Variable<String?>(comexUfEmbarque);
    }
    if (!nullToAbsent || comexLocalEmbarque != null) {
      map['COMEX_LOCAL_EMBARQUE'] = Variable<String?>(comexLocalEmbarque);
    }
    if (!nullToAbsent || comexLocalDespacho != null) {
      map['COMEX_LOCAL_DESPACHO'] = Variable<String?>(comexLocalDespacho);
    }
    if (!nullToAbsent || compraNotaEmpenho != null) {
      map['COMPRA_NOTA_EMPENHO'] = Variable<String?>(compraNotaEmpenho);
    }
    if (!nullToAbsent || compraPedido != null) {
      map['COMPRA_PEDIDO'] = Variable<String?>(compraPedido);
    }
    if (!nullToAbsent || compraContrato != null) {
      map['COMPRA_CONTRATO'] = Variable<String?>(compraContrato);
    }
    if (!nullToAbsent || qrcode != null) {
      map['QRCODE'] = Variable<String?>(qrcode);
    }
    if (!nullToAbsent || urlChave != null) {
      map['URL_CHAVE'] = Variable<String?>(urlChave);
    }
    if (!nullToAbsent || statusNota != null) {
      map['STATUS_NOTA'] = Variable<String?>(statusNota);
    }
    if (!nullToAbsent || idPdvVendaCabecalho != null) {
      map['ID_PDV_VENDA_CABECALHO'] = Variable<int?>(idPdvVendaCabecalho);
    }
    return map;
  }

  NfeCabecalhosCompanion toCompanion(bool nullToAbsent) {
    return NfeCabecalhosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idTributOperacaoFiscal: idTributOperacaoFiscal == null && nullToAbsent
        ? const Value.absent()
        : Value(idTributOperacaoFiscal),
      ufEmitente: ufEmitente == null && nullToAbsent
        ? const Value.absent()
        : Value(ufEmitente),
      codigoNumerico: codigoNumerico == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoNumerico),
      naturezaOperacao: naturezaOperacao == null && nullToAbsent
        ? const Value.absent()
        : Value(naturezaOperacao),
      codigoModelo: codigoModelo == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoModelo),
      serie: serie == null && nullToAbsent
        ? const Value.absent()
        : Value(serie),
      numero: numero == null && nullToAbsent
        ? const Value.absent()
        : Value(numero),
      dataHoraEmissao: dataHoraEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(dataHoraEmissao),
      dataHoraEntradaSaida: dataHoraEntradaSaida == null && nullToAbsent
        ? const Value.absent()
        : Value(dataHoraEntradaSaida),
      tipoOperacao: tipoOperacao == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoOperacao),
      localDestino: localDestino == null && nullToAbsent
        ? const Value.absent()
        : Value(localDestino),
      codigoMunicipio: codigoMunicipio == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoMunicipio),
      formatoImpressaoDanfe: formatoImpressaoDanfe == null && nullToAbsent
        ? const Value.absent()
        : Value(formatoImpressaoDanfe),
      tipoEmissao: tipoEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoEmissao),
      chaveAcesso: chaveAcesso == null && nullToAbsent
        ? const Value.absent()
        : Value(chaveAcesso),
      digitoChaveAcesso: digitoChaveAcesso == null && nullToAbsent
        ? const Value.absent()
        : Value(digitoChaveAcesso),
      ambiente: ambiente == null && nullToAbsent
        ? const Value.absent()
        : Value(ambiente),
      finalidadeEmissao: finalidadeEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(finalidadeEmissao),
      consumidorOperacao: consumidorOperacao == null && nullToAbsent
        ? const Value.absent()
        : Value(consumidorOperacao),
      consumidorPresenca: consumidorPresenca == null && nullToAbsent
        ? const Value.absent()
        : Value(consumidorPresenca),
      processoEmissao: processoEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(processoEmissao),
      versaoProcessoEmissao: versaoProcessoEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(versaoProcessoEmissao),
      dataEntradaContingencia: dataEntradaContingencia == null && nullToAbsent
        ? const Value.absent()
        : Value(dataEntradaContingencia),
      justificativaContingencia: justificativaContingencia == null && nullToAbsent
        ? const Value.absent()
        : Value(justificativaContingencia),
      baseCalculoIcms: baseCalculoIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoIcms),
      valorIcms: valorIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcms),
      valorIcmsDesonerado: valorIcmsDesonerado == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsDesonerado),
      totalIcmsFcpUfDestino: totalIcmsFcpUfDestino == null && nullToAbsent
        ? const Value.absent()
        : Value(totalIcmsFcpUfDestino),
      totalIcmsInterestadualUfDestino: totalIcmsInterestadualUfDestino == null && nullToAbsent
        ? const Value.absent()
        : Value(totalIcmsInterestadualUfDestino),
      totalIcmsInterestadualUfRemetente: totalIcmsInterestadualUfRemetente == null && nullToAbsent
        ? const Value.absent()
        : Value(totalIcmsInterestadualUfRemetente),
      valorTotalFcp: valorTotalFcp == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotalFcp),
      baseCalculoIcmsSt: baseCalculoIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoIcmsSt),
      valorIcmsSt: valorIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsSt),
      valorTotalFcpSt: valorTotalFcpSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotalFcpSt),
      valorTotalFcpStRetido: valorTotalFcpStRetido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotalFcpStRetido),
      valorTotalProdutos: valorTotalProdutos == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotalProdutos),
      valorFrete: valorFrete == null && nullToAbsent
        ? const Value.absent()
        : Value(valorFrete),
      valorSeguro: valorSeguro == null && nullToAbsent
        ? const Value.absent()
        : Value(valorSeguro),
      valorDesconto: valorDesconto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDesconto),
      valorImpostoImportacao: valorImpostoImportacao == null && nullToAbsent
        ? const Value.absent()
        : Value(valorImpostoImportacao),
      valorIpi: valorIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIpi),
      valorIpiDevolvido: valorIpiDevolvido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIpiDevolvido),
      valorPis: valorPis == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPis),
      valorCofins: valorCofins == null && nullToAbsent
        ? const Value.absent()
        : Value(valorCofins),
      valorDespesasAcessorias: valorDespesasAcessorias == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDespesasAcessorias),
      valorTotal: valorTotal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotal),
      valorTotalTributos: valorTotalTributos == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotalTributos),
      valorServicos: valorServicos == null && nullToAbsent
        ? const Value.absent()
        : Value(valorServicos),
      baseCalculoIssqn: baseCalculoIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoIssqn),
      valorIssqn: valorIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIssqn),
      valorPisIssqn: valorPisIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPisIssqn),
      valorCofinsIssqn: valorCofinsIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(valorCofinsIssqn),
      dataPrestacaoServico: dataPrestacaoServico == null && nullToAbsent
        ? const Value.absent()
        : Value(dataPrestacaoServico),
      valorDeducaoIssqn: valorDeducaoIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDeducaoIssqn),
      outrasRetencoesIssqn: outrasRetencoesIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(outrasRetencoesIssqn),
      descontoIncondicionadoIssqn: descontoIncondicionadoIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(descontoIncondicionadoIssqn),
      descontoCondicionadoIssqn: descontoCondicionadoIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(descontoCondicionadoIssqn),
      totalRetencaoIssqn: totalRetencaoIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(totalRetencaoIssqn),
      regimeEspecialTributacao: regimeEspecialTributacao == null && nullToAbsent
        ? const Value.absent()
        : Value(regimeEspecialTributacao),
      valorRetidoPis: valorRetidoPis == null && nullToAbsent
        ? const Value.absent()
        : Value(valorRetidoPis),
      valorRetidoCofins: valorRetidoCofins == null && nullToAbsent
        ? const Value.absent()
        : Value(valorRetidoCofins),
      valorRetidoCsll: valorRetidoCsll == null && nullToAbsent
        ? const Value.absent()
        : Value(valorRetidoCsll),
      baseCalculoIrrf: baseCalculoIrrf == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoIrrf),
      valorRetidoIrrf: valorRetidoIrrf == null && nullToAbsent
        ? const Value.absent()
        : Value(valorRetidoIrrf),
      baseCalculoPrevidencia: baseCalculoPrevidencia == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoPrevidencia),
      valorRetidoPrevidencia: valorRetidoPrevidencia == null && nullToAbsent
        ? const Value.absent()
        : Value(valorRetidoPrevidencia),
      informacoesAddFisco: informacoesAddFisco == null && nullToAbsent
        ? const Value.absent()
        : Value(informacoesAddFisco),
      informacoesAddContribuinte: informacoesAddContribuinte == null && nullToAbsent
        ? const Value.absent()
        : Value(informacoesAddContribuinte),
      comexUfEmbarque: comexUfEmbarque == null && nullToAbsent
        ? const Value.absent()
        : Value(comexUfEmbarque),
      comexLocalEmbarque: comexLocalEmbarque == null && nullToAbsent
        ? const Value.absent()
        : Value(comexLocalEmbarque),
      comexLocalDespacho: comexLocalDespacho == null && nullToAbsent
        ? const Value.absent()
        : Value(comexLocalDespacho),
      compraNotaEmpenho: compraNotaEmpenho == null && nullToAbsent
        ? const Value.absent()
        : Value(compraNotaEmpenho),
      compraPedido: compraPedido == null && nullToAbsent
        ? const Value.absent()
        : Value(compraPedido),
      compraContrato: compraContrato == null && nullToAbsent
        ? const Value.absent()
        : Value(compraContrato),
      qrcode: qrcode == null && nullToAbsent
        ? const Value.absent()
        : Value(qrcode),
      urlChave: urlChave == null && nullToAbsent
        ? const Value.absent()
        : Value(urlChave),
      statusNota: statusNota == null && nullToAbsent
        ? const Value.absent()
        : Value(statusNota),
      idPdvVendaCabecalho: idPdvVendaCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvVendaCabecalho),
    );
  }

  factory NfeCabecalho.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeCabecalho(
      id: serializer.fromJson<int>(json['id']),
      idTributOperacaoFiscal: serializer.fromJson<int>(json['idTributOperacaoFiscal']),
      ufEmitente: serializer.fromJson<int>(json['ufEmitente']),
      codigoNumerico: serializer.fromJson<String>(json['codigoNumerico']),
      naturezaOperacao: serializer.fromJson<String>(json['naturezaOperacao']),
      codigoModelo: serializer.fromJson<String>(json['codigoModelo']),
      serie: serializer.fromJson<String>(json['serie']),
      numero: serializer.fromJson<String>(json['numero']),
      dataHoraEmissao: serializer.fromJson<DateTime>(json['dataHoraEmissao']),
      dataHoraEntradaSaida: serializer.fromJson<DateTime>(json['dataHoraEntradaSaida']),
      tipoOperacao: serializer.fromJson<String>(json['tipoOperacao']),
      localDestino: serializer.fromJson<String>(json['localDestino']),
      codigoMunicipio: serializer.fromJson<int>(json['codigoMunicipio']),
      formatoImpressaoDanfe: serializer.fromJson<String>(json['formatoImpressaoDanfe']),
      tipoEmissao: serializer.fromJson<String>(json['tipoEmissao']),
      chaveAcesso: serializer.fromJson<String>(json['chaveAcesso']),
      digitoChaveAcesso: serializer.fromJson<String>(json['digitoChaveAcesso']),
      ambiente: serializer.fromJson<String>(json['ambiente']),
      finalidadeEmissao: serializer.fromJson<String>(json['finalidadeEmissao']),
      consumidorOperacao: serializer.fromJson<String>(json['consumidorOperacao']),
      consumidorPresenca: serializer.fromJson<String>(json['consumidorPresenca']),
      processoEmissao: serializer.fromJson<String>(json['processoEmissao']),
      versaoProcessoEmissao: serializer.fromJson<String>(json['versaoProcessoEmissao']),
      dataEntradaContingencia: serializer.fromJson<DateTime>(json['dataEntradaContingencia']),
      justificativaContingencia: serializer.fromJson<String>(json['justificativaContingencia']),
      baseCalculoIcms: serializer.fromJson<double>(json['baseCalculoIcms']),
      valorIcms: serializer.fromJson<double>(json['valorIcms']),
      valorIcmsDesonerado: serializer.fromJson<double>(json['valorIcmsDesonerado']),
      totalIcmsFcpUfDestino: serializer.fromJson<double>(json['totalIcmsFcpUfDestino']),
      totalIcmsInterestadualUfDestino: serializer.fromJson<double>(json['totalIcmsInterestadualUfDestino']),
      totalIcmsInterestadualUfRemetente: serializer.fromJson<double>(json['totalIcmsInterestadualUfRemetente']),
      valorTotalFcp: serializer.fromJson<double>(json['valorTotalFcp']),
      baseCalculoIcmsSt: serializer.fromJson<double>(json['baseCalculoIcmsSt']),
      valorIcmsSt: serializer.fromJson<double>(json['valorIcmsSt']),
      valorTotalFcpSt: serializer.fromJson<double>(json['valorTotalFcpSt']),
      valorTotalFcpStRetido: serializer.fromJson<double>(json['valorTotalFcpStRetido']),
      valorTotalProdutos: serializer.fromJson<double>(json['valorTotalProdutos']),
      valorFrete: serializer.fromJson<double>(json['valorFrete']),
      valorSeguro: serializer.fromJson<double>(json['valorSeguro']),
      valorDesconto: serializer.fromJson<double>(json['valorDesconto']),
      valorImpostoImportacao: serializer.fromJson<double>(json['valorImpostoImportacao']),
      valorIpi: serializer.fromJson<double>(json['valorIpi']),
      valorIpiDevolvido: serializer.fromJson<double>(json['valorIpiDevolvido']),
      valorPis: serializer.fromJson<double>(json['valorPis']),
      valorCofins: serializer.fromJson<double>(json['valorCofins']),
      valorDespesasAcessorias: serializer.fromJson<double>(json['valorDespesasAcessorias']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
      valorTotalTributos: serializer.fromJson<double>(json['valorTotalTributos']),
      valorServicos: serializer.fromJson<double>(json['valorServicos']),
      baseCalculoIssqn: serializer.fromJson<double>(json['baseCalculoIssqn']),
      valorIssqn: serializer.fromJson<double>(json['valorIssqn']),
      valorPisIssqn: serializer.fromJson<double>(json['valorPisIssqn']),
      valorCofinsIssqn: serializer.fromJson<double>(json['valorCofinsIssqn']),
      dataPrestacaoServico: serializer.fromJson<DateTime>(json['dataPrestacaoServico']),
      valorDeducaoIssqn: serializer.fromJson<double>(json['valorDeducaoIssqn']),
      outrasRetencoesIssqn: serializer.fromJson<double>(json['outrasRetencoesIssqn']),
      descontoIncondicionadoIssqn: serializer.fromJson<double>(json['descontoIncondicionadoIssqn']),
      descontoCondicionadoIssqn: serializer.fromJson<double>(json['descontoCondicionadoIssqn']),
      totalRetencaoIssqn: serializer.fromJson<double>(json['totalRetencaoIssqn']),
      regimeEspecialTributacao: serializer.fromJson<String>(json['regimeEspecialTributacao']),
      valorRetidoPis: serializer.fromJson<double>(json['valorRetidoPis']),
      valorRetidoCofins: serializer.fromJson<double>(json['valorRetidoCofins']),
      valorRetidoCsll: serializer.fromJson<double>(json['valorRetidoCsll']),
      baseCalculoIrrf: serializer.fromJson<double>(json['baseCalculoIrrf']),
      valorRetidoIrrf: serializer.fromJson<double>(json['valorRetidoIrrf']),
      baseCalculoPrevidencia: serializer.fromJson<double>(json['baseCalculoPrevidencia']),
      valorRetidoPrevidencia: serializer.fromJson<double>(json['valorRetidoPrevidencia']),
      informacoesAddFisco: serializer.fromJson<String>(json['informacoesAddFisco']),
      informacoesAddContribuinte: serializer.fromJson<String>(json['informacoesAddContribuinte']),
      comexUfEmbarque: serializer.fromJson<String>(json['comexUfEmbarque']),
      comexLocalEmbarque: serializer.fromJson<String>(json['comexLocalEmbarque']),
      comexLocalDespacho: serializer.fromJson<String>(json['comexLocalDespacho']),
      compraNotaEmpenho: serializer.fromJson<String>(json['compraNotaEmpenho']),
      compraPedido: serializer.fromJson<String>(json['compraPedido']),
      compraContrato: serializer.fromJson<String>(json['compraContrato']),
      qrcode: serializer.fromJson<String>(json['qrcode']),
      urlChave: serializer.fromJson<String>(json['urlChave']),
      statusNota: serializer.fromJson<String>(json['statusNota']),
      idPdvVendaCabecalho: serializer.fromJson<int>(json['idPdvVendaCabecalho']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idTributOperacaoFiscal': serializer.toJson<int?>(idTributOperacaoFiscal),
      'ufEmitente': serializer.toJson<int?>(ufEmitente),
      'codigoNumerico': serializer.toJson<String?>(codigoNumerico),
      'naturezaOperacao': serializer.toJson<String?>(naturezaOperacao),
      'codigoModelo': serializer.toJson<String?>(codigoModelo),
      'serie': serializer.toJson<String?>(serie),
      'numero': serializer.toJson<String?>(numero),
      'dataHoraEmissao': serializer.toJson<DateTime?>(dataHoraEmissao),
      'dataHoraEntradaSaida': serializer.toJson<DateTime?>(dataHoraEntradaSaida),
      'tipoOperacao': serializer.toJson<String?>(tipoOperacao),
      'localDestino': serializer.toJson<String?>(localDestino),
      'codigoMunicipio': serializer.toJson<int?>(codigoMunicipio),
      'formatoImpressaoDanfe': serializer.toJson<String?>(formatoImpressaoDanfe),
      'tipoEmissao': serializer.toJson<String?>(tipoEmissao),
      'chaveAcesso': serializer.toJson<String?>(chaveAcesso),
      'digitoChaveAcesso': serializer.toJson<String?>(digitoChaveAcesso),
      'ambiente': serializer.toJson<String?>(ambiente),
      'finalidadeEmissao': serializer.toJson<String?>(finalidadeEmissao),
      'consumidorOperacao': serializer.toJson<String?>(consumidorOperacao),
      'consumidorPresenca': serializer.toJson<String?>(consumidorPresenca),
      'processoEmissao': serializer.toJson<String?>(processoEmissao),
      'versaoProcessoEmissao': serializer.toJson<String?>(versaoProcessoEmissao),
      'dataEntradaContingencia': serializer.toJson<DateTime?>(dataEntradaContingencia),
      'justificativaContingencia': serializer.toJson<String?>(justificativaContingencia),
      'baseCalculoIcms': serializer.toJson<double?>(baseCalculoIcms),
      'valorIcms': serializer.toJson<double?>(valorIcms),
      'valorIcmsDesonerado': serializer.toJson<double?>(valorIcmsDesonerado),
      'totalIcmsFcpUfDestino': serializer.toJson<double?>(totalIcmsFcpUfDestino),
      'totalIcmsInterestadualUfDestino': serializer.toJson<double?>(totalIcmsInterestadualUfDestino),
      'totalIcmsInterestadualUfRemetente': serializer.toJson<double?>(totalIcmsInterestadualUfRemetente),
      'valorTotalFcp': serializer.toJson<double?>(valorTotalFcp),
      'baseCalculoIcmsSt': serializer.toJson<double?>(baseCalculoIcmsSt),
      'valorIcmsSt': serializer.toJson<double?>(valorIcmsSt),
      'valorTotalFcpSt': serializer.toJson<double?>(valorTotalFcpSt),
      'valorTotalFcpStRetido': serializer.toJson<double?>(valorTotalFcpStRetido),
      'valorTotalProdutos': serializer.toJson<double?>(valorTotalProdutos),
      'valorFrete': serializer.toJson<double?>(valorFrete),
      'valorSeguro': serializer.toJson<double?>(valorSeguro),
      'valorDesconto': serializer.toJson<double?>(valorDesconto),
      'valorImpostoImportacao': serializer.toJson<double?>(valorImpostoImportacao),
      'valorIpi': serializer.toJson<double?>(valorIpi),
      'valorIpiDevolvido': serializer.toJson<double?>(valorIpiDevolvido),
      'valorPis': serializer.toJson<double?>(valorPis),
      'valorCofins': serializer.toJson<double?>(valorCofins),
      'valorDespesasAcessorias': serializer.toJson<double?>(valorDespesasAcessorias),
      'valorTotal': serializer.toJson<double?>(valorTotal),
      'valorTotalTributos': serializer.toJson<double?>(valorTotalTributos),
      'valorServicos': serializer.toJson<double?>(valorServicos),
      'baseCalculoIssqn': serializer.toJson<double?>(baseCalculoIssqn),
      'valorIssqn': serializer.toJson<double?>(valorIssqn),
      'valorPisIssqn': serializer.toJson<double?>(valorPisIssqn),
      'valorCofinsIssqn': serializer.toJson<double?>(valorCofinsIssqn),
      'dataPrestacaoServico': serializer.toJson<DateTime?>(dataPrestacaoServico),
      'valorDeducaoIssqn': serializer.toJson<double?>(valorDeducaoIssqn),
      'outrasRetencoesIssqn': serializer.toJson<double?>(outrasRetencoesIssqn),
      'descontoIncondicionadoIssqn': serializer.toJson<double?>(descontoIncondicionadoIssqn),
      'descontoCondicionadoIssqn': serializer.toJson<double?>(descontoCondicionadoIssqn),
      'totalRetencaoIssqn': serializer.toJson<double?>(totalRetencaoIssqn),
      'regimeEspecialTributacao': serializer.toJson<String?>(regimeEspecialTributacao),
      'valorRetidoPis': serializer.toJson<double?>(valorRetidoPis),
      'valorRetidoCofins': serializer.toJson<double?>(valorRetidoCofins),
      'valorRetidoCsll': serializer.toJson<double?>(valorRetidoCsll),
      'baseCalculoIrrf': serializer.toJson<double?>(baseCalculoIrrf),
      'valorRetidoIrrf': serializer.toJson<double?>(valorRetidoIrrf),
      'baseCalculoPrevidencia': serializer.toJson<double?>(baseCalculoPrevidencia),
      'valorRetidoPrevidencia': serializer.toJson<double?>(valorRetidoPrevidencia),
      'informacoesAddFisco': serializer.toJson<String?>(informacoesAddFisco),
      'informacoesAddContribuinte': serializer.toJson<String?>(informacoesAddContribuinte),
      'comexUfEmbarque': serializer.toJson<String?>(comexUfEmbarque),
      'comexLocalEmbarque': serializer.toJson<String?>(comexLocalEmbarque),
      'comexLocalDespacho': serializer.toJson<String?>(comexLocalDespacho),
      'compraNotaEmpenho': serializer.toJson<String?>(compraNotaEmpenho),
      'compraPedido': serializer.toJson<String?>(compraPedido),
      'compraContrato': serializer.toJson<String?>(compraContrato),
      'qrcode': serializer.toJson<String?>(qrcode),
      'urlChave': serializer.toJson<String?>(urlChave),
      'statusNota': serializer.toJson<String?>(statusNota),
      'idPdvVendaCabecalho': serializer.toJson<int?>(idPdvVendaCabecalho),
    };
  }

  NfeCabecalho copyWith(
        {
		  int? id,
          int? idTributOperacaoFiscal,
          int? ufEmitente,
          String? codigoNumerico,
          String? naturezaOperacao,
          String? codigoModelo,
          String? serie,
          String? numero,
          DateTime? dataHoraEmissao,
          DateTime? dataHoraEntradaSaida,
          String? tipoOperacao,
          String? localDestino,
          int? codigoMunicipio,
          String? formatoImpressaoDanfe,
          String? tipoEmissao,
          String? chaveAcesso,
          String? digitoChaveAcesso,
          String? ambiente,
          String? finalidadeEmissao,
          String? consumidorOperacao,
          String? consumidorPresenca,
          String? processoEmissao,
          String? versaoProcessoEmissao,
          DateTime? dataEntradaContingencia,
          String? justificativaContingencia,
          double? baseCalculoIcms,
          double? valorIcms,
          double? valorIcmsDesonerado,
          double? totalIcmsFcpUfDestino,
          double? totalIcmsInterestadualUfDestino,
          double? totalIcmsInterestadualUfRemetente,
          double? valorTotalFcp,
          double? baseCalculoIcmsSt,
          double? valorIcmsSt,
          double? valorTotalFcpSt,
          double? valorTotalFcpStRetido,
          double? valorTotalProdutos,
          double? valorFrete,
          double? valorSeguro,
          double? valorDesconto,
          double? valorImpostoImportacao,
          double? valorIpi,
          double? valorIpiDevolvido,
          double? valorPis,
          double? valorCofins,
          double? valorDespesasAcessorias,
          double? valorTotal,
          double? valorTotalTributos,
          double? valorServicos,
          double? baseCalculoIssqn,
          double? valorIssqn,
          double? valorPisIssqn,
          double? valorCofinsIssqn,
          DateTime? dataPrestacaoServico,
          double? valorDeducaoIssqn,
          double? outrasRetencoesIssqn,
          double? descontoIncondicionadoIssqn,
          double? descontoCondicionadoIssqn,
          double? totalRetencaoIssqn,
          String? regimeEspecialTributacao,
          double? valorRetidoPis,
          double? valorRetidoCofins,
          double? valorRetidoCsll,
          double? baseCalculoIrrf,
          double? valorRetidoIrrf,
          double? baseCalculoPrevidencia,
          double? valorRetidoPrevidencia,
          String? informacoesAddFisco,
          String? informacoesAddContribuinte,
          String? comexUfEmbarque,
          String? comexLocalEmbarque,
          String? comexLocalDespacho,
          String? compraNotaEmpenho,
          String? compraPedido,
          String? compraContrato,
          String? qrcode,
          String? urlChave,
          String? statusNota,
          int? idPdvVendaCabecalho,
		}) =>
      NfeCabecalho(
        id: id ?? this.id,
        idTributOperacaoFiscal: idTributOperacaoFiscal ?? this.idTributOperacaoFiscal,
        ufEmitente: ufEmitente ?? this.ufEmitente,
        codigoNumerico: codigoNumerico ?? this.codigoNumerico,
        naturezaOperacao: naturezaOperacao ?? this.naturezaOperacao,
        codigoModelo: codigoModelo ?? this.codigoModelo,
        serie: serie ?? this.serie,
        numero: numero ?? this.numero,
        dataHoraEmissao: dataHoraEmissao ?? this.dataHoraEmissao,
        dataHoraEntradaSaida: dataHoraEntradaSaida ?? this.dataHoraEntradaSaida,
        tipoOperacao: tipoOperacao ?? this.tipoOperacao,
        localDestino: localDestino ?? this.localDestino,
        codigoMunicipio: codigoMunicipio ?? this.codigoMunicipio,
        formatoImpressaoDanfe: formatoImpressaoDanfe ?? this.formatoImpressaoDanfe,
        tipoEmissao: tipoEmissao ?? this.tipoEmissao,
        chaveAcesso: chaveAcesso ?? this.chaveAcesso,
        digitoChaveAcesso: digitoChaveAcesso ?? this.digitoChaveAcesso,
        ambiente: ambiente ?? this.ambiente,
        finalidadeEmissao: finalidadeEmissao ?? this.finalidadeEmissao,
        consumidorOperacao: consumidorOperacao ?? this.consumidorOperacao,
        consumidorPresenca: consumidorPresenca ?? this.consumidorPresenca,
        processoEmissao: processoEmissao ?? this.processoEmissao,
        versaoProcessoEmissao: versaoProcessoEmissao ?? this.versaoProcessoEmissao,
        dataEntradaContingencia: dataEntradaContingencia ?? this.dataEntradaContingencia,
        justificativaContingencia: justificativaContingencia ?? this.justificativaContingencia,
        baseCalculoIcms: baseCalculoIcms ?? this.baseCalculoIcms,
        valorIcms: valorIcms ?? this.valorIcms,
        valorIcmsDesonerado: valorIcmsDesonerado ?? this.valorIcmsDesonerado,
        totalIcmsFcpUfDestino: totalIcmsFcpUfDestino ?? this.totalIcmsFcpUfDestino,
        totalIcmsInterestadualUfDestino: totalIcmsInterestadualUfDestino ?? this.totalIcmsInterestadualUfDestino,
        totalIcmsInterestadualUfRemetente: totalIcmsInterestadualUfRemetente ?? this.totalIcmsInterestadualUfRemetente,
        valorTotalFcp: valorTotalFcp ?? this.valorTotalFcp,
        baseCalculoIcmsSt: baseCalculoIcmsSt ?? this.baseCalculoIcmsSt,
        valorIcmsSt: valorIcmsSt ?? this.valorIcmsSt,
        valorTotalFcpSt: valorTotalFcpSt ?? this.valorTotalFcpSt,
        valorTotalFcpStRetido: valorTotalFcpStRetido ?? this.valorTotalFcpStRetido,
        valorTotalProdutos: valorTotalProdutos ?? this.valorTotalProdutos,
        valorFrete: valorFrete ?? this.valorFrete,
        valorSeguro: valorSeguro ?? this.valorSeguro,
        valorDesconto: valorDesconto ?? this.valorDesconto,
        valorImpostoImportacao: valorImpostoImportacao ?? this.valorImpostoImportacao,
        valorIpi: valorIpi ?? this.valorIpi,
        valorIpiDevolvido: valorIpiDevolvido ?? this.valorIpiDevolvido,
        valorPis: valorPis ?? this.valorPis,
        valorCofins: valorCofins ?? this.valorCofins,
        valorDespesasAcessorias: valorDespesasAcessorias ?? this.valorDespesasAcessorias,
        valorTotal: valorTotal ?? this.valorTotal,
        valorTotalTributos: valorTotalTributos ?? this.valorTotalTributos,
        valorServicos: valorServicos ?? this.valorServicos,
        baseCalculoIssqn: baseCalculoIssqn ?? this.baseCalculoIssqn,
        valorIssqn: valorIssqn ?? this.valorIssqn,
        valorPisIssqn: valorPisIssqn ?? this.valorPisIssqn,
        valorCofinsIssqn: valorCofinsIssqn ?? this.valorCofinsIssqn,
        dataPrestacaoServico: dataPrestacaoServico ?? this.dataPrestacaoServico,
        valorDeducaoIssqn: valorDeducaoIssqn ?? this.valorDeducaoIssqn,
        outrasRetencoesIssqn: outrasRetencoesIssqn ?? this.outrasRetencoesIssqn,
        descontoIncondicionadoIssqn: descontoIncondicionadoIssqn ?? this.descontoIncondicionadoIssqn,
        descontoCondicionadoIssqn: descontoCondicionadoIssqn ?? this.descontoCondicionadoIssqn,
        totalRetencaoIssqn: totalRetencaoIssqn ?? this.totalRetencaoIssqn,
        regimeEspecialTributacao: regimeEspecialTributacao ?? this.regimeEspecialTributacao,
        valorRetidoPis: valorRetidoPis ?? this.valorRetidoPis,
        valorRetidoCofins: valorRetidoCofins ?? this.valorRetidoCofins,
        valorRetidoCsll: valorRetidoCsll ?? this.valorRetidoCsll,
        baseCalculoIrrf: baseCalculoIrrf ?? this.baseCalculoIrrf,
        valorRetidoIrrf: valorRetidoIrrf ?? this.valorRetidoIrrf,
        baseCalculoPrevidencia: baseCalculoPrevidencia ?? this.baseCalculoPrevidencia,
        valorRetidoPrevidencia: valorRetidoPrevidencia ?? this.valorRetidoPrevidencia,
        informacoesAddFisco: informacoesAddFisco ?? this.informacoesAddFisco,
        informacoesAddContribuinte: informacoesAddContribuinte ?? this.informacoesAddContribuinte,
        comexUfEmbarque: comexUfEmbarque ?? this.comexUfEmbarque,
        comexLocalEmbarque: comexLocalEmbarque ?? this.comexLocalEmbarque,
        comexLocalDespacho: comexLocalDespacho ?? this.comexLocalDespacho,
        compraNotaEmpenho: compraNotaEmpenho ?? this.compraNotaEmpenho,
        compraPedido: compraPedido ?? this.compraPedido,
        compraContrato: compraContrato ?? this.compraContrato,
        qrcode: qrcode ?? this.qrcode,
        urlChave: urlChave ?? this.urlChave,
        statusNota: statusNota ?? this.statusNota,
        idPdvVendaCabecalho: idPdvVendaCabecalho ?? this.idPdvVendaCabecalho,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeCabecalho(')
          ..write('id: $id, ')
          ..write('idTributOperacaoFiscal: $idTributOperacaoFiscal, ')
          ..write('ufEmitente: $ufEmitente, ')
          ..write('codigoNumerico: $codigoNumerico, ')
          ..write('naturezaOperacao: $naturezaOperacao, ')
          ..write('codigoModelo: $codigoModelo, ')
          ..write('serie: $serie, ')
          ..write('numero: $numero, ')
          ..write('dataHoraEmissao: $dataHoraEmissao, ')
          ..write('dataHoraEntradaSaida: $dataHoraEntradaSaida, ')
          ..write('tipoOperacao: $tipoOperacao, ')
          ..write('localDestino: $localDestino, ')
          ..write('codigoMunicipio: $codigoMunicipio, ')
          ..write('formatoImpressaoDanfe: $formatoImpressaoDanfe, ')
          ..write('tipoEmissao: $tipoEmissao, ')
          ..write('chaveAcesso: $chaveAcesso, ')
          ..write('digitoChaveAcesso: $digitoChaveAcesso, ')
          ..write('ambiente: $ambiente, ')
          ..write('finalidadeEmissao: $finalidadeEmissao, ')
          ..write('consumidorOperacao: $consumidorOperacao, ')
          ..write('consumidorPresenca: $consumidorPresenca, ')
          ..write('processoEmissao: $processoEmissao, ')
          ..write('versaoProcessoEmissao: $versaoProcessoEmissao, ')
          ..write('dataEntradaContingencia: $dataEntradaContingencia, ')
          ..write('justificativaContingencia: $justificativaContingencia, ')
          ..write('baseCalculoIcms: $baseCalculoIcms, ')
          ..write('valorIcms: $valorIcms, ')
          ..write('valorIcmsDesonerado: $valorIcmsDesonerado, ')
          ..write('totalIcmsFcpUfDestino: $totalIcmsFcpUfDestino, ')
          ..write('totalIcmsInterestadualUfDestino: $totalIcmsInterestadualUfDestino, ')
          ..write('totalIcmsInterestadualUfRemetente: $totalIcmsInterestadualUfRemetente, ')
          ..write('valorTotalFcp: $valorTotalFcp, ')
          ..write('baseCalculoIcmsSt: $baseCalculoIcmsSt, ')
          ..write('valorIcmsSt: $valorIcmsSt, ')
          ..write('valorTotalFcpSt: $valorTotalFcpSt, ')
          ..write('valorTotalFcpStRetido: $valorTotalFcpStRetido, ')
          ..write('valorTotalProdutos: $valorTotalProdutos, ')
          ..write('valorFrete: $valorFrete, ')
          ..write('valorSeguro: $valorSeguro, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorImpostoImportacao: $valorImpostoImportacao, ')
          ..write('valorIpi: $valorIpi, ')
          ..write('valorIpiDevolvido: $valorIpiDevolvido, ')
          ..write('valorPis: $valorPis, ')
          ..write('valorCofins: $valorCofins, ')
          ..write('valorDespesasAcessorias: $valorDespesasAcessorias, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('valorTotalTributos: $valorTotalTributos, ')
          ..write('valorServicos: $valorServicos, ')
          ..write('baseCalculoIssqn: $baseCalculoIssqn, ')
          ..write('valorIssqn: $valorIssqn, ')
          ..write('valorPisIssqn: $valorPisIssqn, ')
          ..write('valorCofinsIssqn: $valorCofinsIssqn, ')
          ..write('dataPrestacaoServico: $dataPrestacaoServico, ')
          ..write('valorDeducaoIssqn: $valorDeducaoIssqn, ')
          ..write('outrasRetencoesIssqn: $outrasRetencoesIssqn, ')
          ..write('descontoIncondicionadoIssqn: $descontoIncondicionadoIssqn, ')
          ..write('descontoCondicionadoIssqn: $descontoCondicionadoIssqn, ')
          ..write('totalRetencaoIssqn: $totalRetencaoIssqn, ')
          ..write('regimeEspecialTributacao: $regimeEspecialTributacao, ')
          ..write('valorRetidoPis: $valorRetidoPis, ')
          ..write('valorRetidoCofins: $valorRetidoCofins, ')
          ..write('valorRetidoCsll: $valorRetidoCsll, ')
          ..write('baseCalculoIrrf: $baseCalculoIrrf, ')
          ..write('valorRetidoIrrf: $valorRetidoIrrf, ')
          ..write('baseCalculoPrevidencia: $baseCalculoPrevidencia, ')
          ..write('valorRetidoPrevidencia: $valorRetidoPrevidencia, ')
          ..write('informacoesAddFisco: $informacoesAddFisco, ')
          ..write('informacoesAddContribuinte: $informacoesAddContribuinte, ')
          ..write('comexUfEmbarque: $comexUfEmbarque, ')
          ..write('comexLocalEmbarque: $comexLocalEmbarque, ')
          ..write('comexLocalDespacho: $comexLocalDespacho, ')
          ..write('compraNotaEmpenho: $compraNotaEmpenho, ')
          ..write('compraPedido: $compraPedido, ')
          ..write('compraContrato: $compraContrato, ')
          ..write('qrcode: $qrcode, ')
          ..write('urlChave: $urlChave, ')
          ..write('statusNota: $statusNota, ')
          ..write('idPdvVendaCabecalho: $idPdvVendaCabecalho, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idTributOperacaoFiscal,
      ufEmitente,
      codigoNumerico,
      naturezaOperacao,
      codigoModelo,
      serie,
      numero,
      dataHoraEmissao,
      dataHoraEntradaSaida,
      tipoOperacao,
      localDestino,
      codigoMunicipio,
      formatoImpressaoDanfe,
      tipoEmissao,
      chaveAcesso,
      digitoChaveAcesso,
      ambiente,
      finalidadeEmissao,
      consumidorOperacao,
      consumidorPresenca,
      processoEmissao,
      versaoProcessoEmissao,
      dataEntradaContingencia,
      justificativaContingencia,
      baseCalculoIcms,
      valorIcms,
      valorIcmsDesonerado,
      totalIcmsFcpUfDestino,
      totalIcmsInterestadualUfDestino,
      totalIcmsInterestadualUfRemetente,
      valorTotalFcp,
      baseCalculoIcmsSt,
      valorIcmsSt,
      valorTotalFcpSt,
      valorTotalFcpStRetido,
      valorTotalProdutos,
      valorFrete,
      valorSeguro,
      valorDesconto,
      valorImpostoImportacao,
      valorIpi,
      valorIpiDevolvido,
      valorPis,
      valorCofins,
      valorDespesasAcessorias,
      valorTotal,
      valorTotalTributos,
      valorServicos,
      baseCalculoIssqn,
      valorIssqn,
      valorPisIssqn,
      valorCofinsIssqn,
      dataPrestacaoServico,
      valorDeducaoIssqn,
      outrasRetencoesIssqn,
      descontoIncondicionadoIssqn,
      descontoCondicionadoIssqn,
      totalRetencaoIssqn,
      regimeEspecialTributacao,
      valorRetidoPis,
      valorRetidoCofins,
      valorRetidoCsll,
      baseCalculoIrrf,
      valorRetidoIrrf,
      baseCalculoPrevidencia,
      valorRetidoPrevidencia,
      informacoesAddFisco,
      informacoesAddContribuinte,
      comexUfEmbarque,
      comexLocalEmbarque,
      comexLocalDespacho,
      compraNotaEmpenho,
      compraPedido,
      compraContrato,
      qrcode,
      urlChave,
      statusNota,
      idPdvVendaCabecalho,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeCabecalho &&
          other.id == id &&
          other.idTributOperacaoFiscal == idTributOperacaoFiscal &&
          other.ufEmitente == ufEmitente &&
          other.codigoNumerico == codigoNumerico &&
          other.naturezaOperacao == naturezaOperacao &&
          other.codigoModelo == codigoModelo &&
          other.serie == serie &&
          other.numero == numero &&
          other.dataHoraEmissao == dataHoraEmissao &&
          other.dataHoraEntradaSaida == dataHoraEntradaSaida &&
          other.tipoOperacao == tipoOperacao &&
          other.localDestino == localDestino &&
          other.codigoMunicipio == codigoMunicipio &&
          other.formatoImpressaoDanfe == formatoImpressaoDanfe &&
          other.tipoEmissao == tipoEmissao &&
          other.chaveAcesso == chaveAcesso &&
          other.digitoChaveAcesso == digitoChaveAcesso &&
          other.ambiente == ambiente &&
          other.finalidadeEmissao == finalidadeEmissao &&
          other.consumidorOperacao == consumidorOperacao &&
          other.consumidorPresenca == consumidorPresenca &&
          other.processoEmissao == processoEmissao &&
          other.versaoProcessoEmissao == versaoProcessoEmissao &&
          other.dataEntradaContingencia == dataEntradaContingencia &&
          other.justificativaContingencia == justificativaContingencia &&
          other.baseCalculoIcms == baseCalculoIcms &&
          other.valorIcms == valorIcms &&
          other.valorIcmsDesonerado == valorIcmsDesonerado &&
          other.totalIcmsFcpUfDestino == totalIcmsFcpUfDestino &&
          other.totalIcmsInterestadualUfDestino == totalIcmsInterestadualUfDestino &&
          other.totalIcmsInterestadualUfRemetente == totalIcmsInterestadualUfRemetente &&
          other.valorTotalFcp == valorTotalFcp &&
          other.baseCalculoIcmsSt == baseCalculoIcmsSt &&
          other.valorIcmsSt == valorIcmsSt &&
          other.valorTotalFcpSt == valorTotalFcpSt &&
          other.valorTotalFcpStRetido == valorTotalFcpStRetido &&
          other.valorTotalProdutos == valorTotalProdutos &&
          other.valorFrete == valorFrete &&
          other.valorSeguro == valorSeguro &&
          other.valorDesconto == valorDesconto &&
          other.valorImpostoImportacao == valorImpostoImportacao &&
          other.valorIpi == valorIpi &&
          other.valorIpiDevolvido == valorIpiDevolvido &&
          other.valorPis == valorPis &&
          other.valorCofins == valorCofins &&
          other.valorDespesasAcessorias == valorDespesasAcessorias &&
          other.valorTotal == valorTotal &&
          other.valorTotalTributos == valorTotalTributos &&
          other.valorServicos == valorServicos &&
          other.baseCalculoIssqn == baseCalculoIssqn &&
          other.valorIssqn == valorIssqn &&
          other.valorPisIssqn == valorPisIssqn &&
          other.valorCofinsIssqn == valorCofinsIssqn &&
          other.dataPrestacaoServico == dataPrestacaoServico &&
          other.valorDeducaoIssqn == valorDeducaoIssqn &&
          other.outrasRetencoesIssqn == outrasRetencoesIssqn &&
          other.descontoIncondicionadoIssqn == descontoIncondicionadoIssqn &&
          other.descontoCondicionadoIssqn == descontoCondicionadoIssqn &&
          other.totalRetencaoIssqn == totalRetencaoIssqn &&
          other.regimeEspecialTributacao == regimeEspecialTributacao &&
          other.valorRetidoPis == valorRetidoPis &&
          other.valorRetidoCofins == valorRetidoCofins &&
          other.valorRetidoCsll == valorRetidoCsll &&
          other.baseCalculoIrrf == baseCalculoIrrf &&
          other.valorRetidoIrrf == valorRetidoIrrf &&
          other.baseCalculoPrevidencia == baseCalculoPrevidencia &&
          other.valorRetidoPrevidencia == valorRetidoPrevidencia &&
          other.informacoesAddFisco == informacoesAddFisco &&
          other.informacoesAddContribuinte == informacoesAddContribuinte &&
          other.comexUfEmbarque == comexUfEmbarque &&
          other.comexLocalEmbarque == comexLocalEmbarque &&
          other.comexLocalDespacho == comexLocalDespacho &&
          other.compraNotaEmpenho == compraNotaEmpenho &&
          other.compraPedido == compraPedido &&
          other.compraContrato == compraContrato &&
          other.qrcode == qrcode &&
          other.urlChave == urlChave &&
          other.statusNota == statusNota &&
          other.idPdvVendaCabecalho == idPdvVendaCabecalho 
	   );
}

class NfeCabecalhosCompanion extends UpdateCompanion<NfeCabecalho> {

  final Value<int?> id;
  final Value<int?> idTributOperacaoFiscal;
  final Value<int?> ufEmitente;
  final Value<String?> codigoNumerico;
  final Value<String?> naturezaOperacao;
  final Value<String?> codigoModelo;
  final Value<String?> serie;
  final Value<String?> numero;
  final Value<DateTime?> dataHoraEmissao;
  final Value<DateTime?> dataHoraEntradaSaida;
  final Value<String?> tipoOperacao;
  final Value<String?> localDestino;
  final Value<int?> codigoMunicipio;
  final Value<String?> formatoImpressaoDanfe;
  final Value<String?> tipoEmissao;
  final Value<String?> chaveAcesso;
  final Value<String?> digitoChaveAcesso;
  final Value<String?> ambiente;
  final Value<String?> finalidadeEmissao;
  final Value<String?> consumidorOperacao;
  final Value<String?> consumidorPresenca;
  final Value<String?> processoEmissao;
  final Value<String?> versaoProcessoEmissao;
  final Value<DateTime?> dataEntradaContingencia;
  final Value<String?> justificativaContingencia;
  final Value<double?> baseCalculoIcms;
  final Value<double?> valorIcms;
  final Value<double?> valorIcmsDesonerado;
  final Value<double?> totalIcmsFcpUfDestino;
  final Value<double?> totalIcmsInterestadualUfDestino;
  final Value<double?> totalIcmsInterestadualUfRemetente;
  final Value<double?> valorTotalFcp;
  final Value<double?> baseCalculoIcmsSt;
  final Value<double?> valorIcmsSt;
  final Value<double?> valorTotalFcpSt;
  final Value<double?> valorTotalFcpStRetido;
  final Value<double?> valorTotalProdutos;
  final Value<double?> valorFrete;
  final Value<double?> valorSeguro;
  final Value<double?> valorDesconto;
  final Value<double?> valorImpostoImportacao;
  final Value<double?> valorIpi;
  final Value<double?> valorIpiDevolvido;
  final Value<double?> valorPis;
  final Value<double?> valorCofins;
  final Value<double?> valorDespesasAcessorias;
  final Value<double?> valorTotal;
  final Value<double?> valorTotalTributos;
  final Value<double?> valorServicos;
  final Value<double?> baseCalculoIssqn;
  final Value<double?> valorIssqn;
  final Value<double?> valorPisIssqn;
  final Value<double?> valorCofinsIssqn;
  final Value<DateTime?> dataPrestacaoServico;
  final Value<double?> valorDeducaoIssqn;
  final Value<double?> outrasRetencoesIssqn;
  final Value<double?> descontoIncondicionadoIssqn;
  final Value<double?> descontoCondicionadoIssqn;
  final Value<double?> totalRetencaoIssqn;
  final Value<String?> regimeEspecialTributacao;
  final Value<double?> valorRetidoPis;
  final Value<double?> valorRetidoCofins;
  final Value<double?> valorRetidoCsll;
  final Value<double?> baseCalculoIrrf;
  final Value<double?> valorRetidoIrrf;
  final Value<double?> baseCalculoPrevidencia;
  final Value<double?> valorRetidoPrevidencia;
  final Value<String?> informacoesAddFisco;
  final Value<String?> informacoesAddContribuinte;
  final Value<String?> comexUfEmbarque;
  final Value<String?> comexLocalEmbarque;
  final Value<String?> comexLocalDespacho;
  final Value<String?> compraNotaEmpenho;
  final Value<String?> compraPedido;
  final Value<String?> compraContrato;
  final Value<String?> qrcode;
  final Value<String?> urlChave;
  final Value<String?> statusNota;
  final Value<int?> idPdvVendaCabecalho;

  const NfeCabecalhosCompanion({
    this.id = const Value.absent(),
    this.idTributOperacaoFiscal = const Value.absent(),
    this.ufEmitente = const Value.absent(),
    this.codigoNumerico = const Value.absent(),
    this.naturezaOperacao = const Value.absent(),
    this.codigoModelo = const Value.absent(),
    this.serie = const Value.absent(),
    this.numero = const Value.absent(),
    this.dataHoraEmissao = const Value.absent(),
    this.dataHoraEntradaSaida = const Value.absent(),
    this.tipoOperacao = const Value.absent(),
    this.localDestino = const Value.absent(),
    this.codigoMunicipio = const Value.absent(),
    this.formatoImpressaoDanfe = const Value.absent(),
    this.tipoEmissao = const Value.absent(),
    this.chaveAcesso = const Value.absent(),
    this.digitoChaveAcesso = const Value.absent(),
    this.ambiente = const Value.absent(),
    this.finalidadeEmissao = const Value.absent(),
    this.consumidorOperacao = const Value.absent(),
    this.consumidorPresenca = const Value.absent(),
    this.processoEmissao = const Value.absent(),
    this.versaoProcessoEmissao = const Value.absent(),
    this.dataEntradaContingencia = const Value.absent(),
    this.justificativaContingencia = const Value.absent(),
    this.baseCalculoIcms = const Value.absent(),
    this.valorIcms = const Value.absent(),
    this.valorIcmsDesonerado = const Value.absent(),
    this.totalIcmsFcpUfDestino = const Value.absent(),
    this.totalIcmsInterestadualUfDestino = const Value.absent(),
    this.totalIcmsInterestadualUfRemetente = const Value.absent(),
    this.valorTotalFcp = const Value.absent(),
    this.baseCalculoIcmsSt = const Value.absent(),
    this.valorIcmsSt = const Value.absent(),
    this.valorTotalFcpSt = const Value.absent(),
    this.valorTotalFcpStRetido = const Value.absent(),
    this.valorTotalProdutos = const Value.absent(),
    this.valorFrete = const Value.absent(),
    this.valorSeguro = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorImpostoImportacao = const Value.absent(),
    this.valorIpi = const Value.absent(),
    this.valorIpiDevolvido = const Value.absent(),
    this.valorPis = const Value.absent(),
    this.valorCofins = const Value.absent(),
    this.valorDespesasAcessorias = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.valorTotalTributos = const Value.absent(),
    this.valorServicos = const Value.absent(),
    this.baseCalculoIssqn = const Value.absent(),
    this.valorIssqn = const Value.absent(),
    this.valorPisIssqn = const Value.absent(),
    this.valorCofinsIssqn = const Value.absent(),
    this.dataPrestacaoServico = const Value.absent(),
    this.valorDeducaoIssqn = const Value.absent(),
    this.outrasRetencoesIssqn = const Value.absent(),
    this.descontoIncondicionadoIssqn = const Value.absent(),
    this.descontoCondicionadoIssqn = const Value.absent(),
    this.totalRetencaoIssqn = const Value.absent(),
    this.regimeEspecialTributacao = const Value.absent(),
    this.valorRetidoPis = const Value.absent(),
    this.valorRetidoCofins = const Value.absent(),
    this.valorRetidoCsll = const Value.absent(),
    this.baseCalculoIrrf = const Value.absent(),
    this.valorRetidoIrrf = const Value.absent(),
    this.baseCalculoPrevidencia = const Value.absent(),
    this.valorRetidoPrevidencia = const Value.absent(),
    this.informacoesAddFisco = const Value.absent(),
    this.informacoesAddContribuinte = const Value.absent(),
    this.comexUfEmbarque = const Value.absent(),
    this.comexLocalEmbarque = const Value.absent(),
    this.comexLocalDespacho = const Value.absent(),
    this.compraNotaEmpenho = const Value.absent(),
    this.compraPedido = const Value.absent(),
    this.compraContrato = const Value.absent(),
    this.qrcode = const Value.absent(),
    this.urlChave = const Value.absent(),
    this.statusNota = const Value.absent(),
    this.idPdvVendaCabecalho = const Value.absent(),
  });

  NfeCabecalhosCompanion.insert({
    this.id = const Value.absent(),
    this.idTributOperacaoFiscal = const Value.absent(),
    this.ufEmitente = const Value.absent(),
    this.codigoNumerico = const Value.absent(),
    this.naturezaOperacao = const Value.absent(),
    this.codigoModelo = const Value.absent(),
    this.serie = const Value.absent(),
    this.numero = const Value.absent(),
    this.dataHoraEmissao = const Value.absent(),
    this.dataHoraEntradaSaida = const Value.absent(),
    this.tipoOperacao = const Value.absent(),
    this.localDestino = const Value.absent(),
    this.codigoMunicipio = const Value.absent(),
    this.formatoImpressaoDanfe = const Value.absent(),
    this.tipoEmissao = const Value.absent(),
    this.chaveAcesso = const Value.absent(),
    this.digitoChaveAcesso = const Value.absent(),
    this.ambiente = const Value.absent(),
    this.finalidadeEmissao = const Value.absent(),
    this.consumidorOperacao = const Value.absent(),
    this.consumidorPresenca = const Value.absent(),
    this.processoEmissao = const Value.absent(),
    this.versaoProcessoEmissao = const Value.absent(),
    this.dataEntradaContingencia = const Value.absent(),
    this.justificativaContingencia = const Value.absent(),
    this.baseCalculoIcms = const Value.absent(),
    this.valorIcms = const Value.absent(),
    this.valorIcmsDesonerado = const Value.absent(),
    this.totalIcmsFcpUfDestino = const Value.absent(),
    this.totalIcmsInterestadualUfDestino = const Value.absent(),
    this.totalIcmsInterestadualUfRemetente = const Value.absent(),
    this.valorTotalFcp = const Value.absent(),
    this.baseCalculoIcmsSt = const Value.absent(),
    this.valorIcmsSt = const Value.absent(),
    this.valorTotalFcpSt = const Value.absent(),
    this.valorTotalFcpStRetido = const Value.absent(),
    this.valorTotalProdutos = const Value.absent(),
    this.valorFrete = const Value.absent(),
    this.valorSeguro = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorImpostoImportacao = const Value.absent(),
    this.valorIpi = const Value.absent(),
    this.valorIpiDevolvido = const Value.absent(),
    this.valorPis = const Value.absent(),
    this.valorCofins = const Value.absent(),
    this.valorDespesasAcessorias = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.valorTotalTributos = const Value.absent(),
    this.valorServicos = const Value.absent(),
    this.baseCalculoIssqn = const Value.absent(),
    this.valorIssqn = const Value.absent(),
    this.valorPisIssqn = const Value.absent(),
    this.valorCofinsIssqn = const Value.absent(),
    this.dataPrestacaoServico = const Value.absent(),
    this.valorDeducaoIssqn = const Value.absent(),
    this.outrasRetencoesIssqn = const Value.absent(),
    this.descontoIncondicionadoIssqn = const Value.absent(),
    this.descontoCondicionadoIssqn = const Value.absent(),
    this.totalRetencaoIssqn = const Value.absent(),
    this.regimeEspecialTributacao = const Value.absent(),
    this.valorRetidoPis = const Value.absent(),
    this.valorRetidoCofins = const Value.absent(),
    this.valorRetidoCsll = const Value.absent(),
    this.baseCalculoIrrf = const Value.absent(),
    this.valorRetidoIrrf = const Value.absent(),
    this.baseCalculoPrevidencia = const Value.absent(),
    this.valorRetidoPrevidencia = const Value.absent(),
    this.informacoesAddFisco = const Value.absent(),
    this.informacoesAddContribuinte = const Value.absent(),
    this.comexUfEmbarque = const Value.absent(),
    this.comexLocalEmbarque = const Value.absent(),
    this.comexLocalDespacho = const Value.absent(),
    this.compraNotaEmpenho = const Value.absent(),
    this.compraPedido = const Value.absent(),
    this.compraContrato = const Value.absent(),
    this.qrcode = const Value.absent(),
    this.urlChave = const Value.absent(),
    this.statusNota = const Value.absent(),
    this.idPdvVendaCabecalho = const Value.absent(),
  });

  static Insertable<NfeCabecalho> custom({
    Expression<int>? id,
    Expression<int>? idTributOperacaoFiscal,
    Expression<int>? ufEmitente,
    Expression<String>? codigoNumerico,
    Expression<String>? naturezaOperacao,
    Expression<String>? codigoModelo,
    Expression<String>? serie,
    Expression<String>? numero,
    Expression<DateTime>? dataHoraEmissao,
    Expression<DateTime>? dataHoraEntradaSaida,
    Expression<String>? tipoOperacao,
    Expression<String>? localDestino,
    Expression<int>? codigoMunicipio,
    Expression<String>? formatoImpressaoDanfe,
    Expression<String>? tipoEmissao,
    Expression<String>? chaveAcesso,
    Expression<String>? digitoChaveAcesso,
    Expression<String>? ambiente,
    Expression<String>? finalidadeEmissao,
    Expression<String>? consumidorOperacao,
    Expression<String>? consumidorPresenca,
    Expression<String>? processoEmissao,
    Expression<String>? versaoProcessoEmissao,
    Expression<DateTime>? dataEntradaContingencia,
    Expression<String>? justificativaContingencia,
    Expression<double>? baseCalculoIcms,
    Expression<double>? valorIcms,
    Expression<double>? valorIcmsDesonerado,
    Expression<double>? totalIcmsFcpUfDestino,
    Expression<double>? totalIcmsInterestadualUfDestino,
    Expression<double>? totalIcmsInterestadualUfRemetente,
    Expression<double>? valorTotalFcp,
    Expression<double>? baseCalculoIcmsSt,
    Expression<double>? valorIcmsSt,
    Expression<double>? valorTotalFcpSt,
    Expression<double>? valorTotalFcpStRetido,
    Expression<double>? valorTotalProdutos,
    Expression<double>? valorFrete,
    Expression<double>? valorSeguro,
    Expression<double>? valorDesconto,
    Expression<double>? valorImpostoImportacao,
    Expression<double>? valorIpi,
    Expression<double>? valorIpiDevolvido,
    Expression<double>? valorPis,
    Expression<double>? valorCofins,
    Expression<double>? valorDespesasAcessorias,
    Expression<double>? valorTotal,
    Expression<double>? valorTotalTributos,
    Expression<double>? valorServicos,
    Expression<double>? baseCalculoIssqn,
    Expression<double>? valorIssqn,
    Expression<double>? valorPisIssqn,
    Expression<double>? valorCofinsIssqn,
    Expression<DateTime>? dataPrestacaoServico,
    Expression<double>? valorDeducaoIssqn,
    Expression<double>? outrasRetencoesIssqn,
    Expression<double>? descontoIncondicionadoIssqn,
    Expression<double>? descontoCondicionadoIssqn,
    Expression<double>? totalRetencaoIssqn,
    Expression<String>? regimeEspecialTributacao,
    Expression<double>? valorRetidoPis,
    Expression<double>? valorRetidoCofins,
    Expression<double>? valorRetidoCsll,
    Expression<double>? baseCalculoIrrf,
    Expression<double>? valorRetidoIrrf,
    Expression<double>? baseCalculoPrevidencia,
    Expression<double>? valorRetidoPrevidencia,
    Expression<String>? informacoesAddFisco,
    Expression<String>? informacoesAddContribuinte,
    Expression<String>? comexUfEmbarque,
    Expression<String>? comexLocalEmbarque,
    Expression<String>? comexLocalDespacho,
    Expression<String>? compraNotaEmpenho,
    Expression<String>? compraPedido,
    Expression<String>? compraContrato,
    Expression<String>? qrcode,
    Expression<String>? urlChave,
    Expression<String>? statusNota,
    Expression<int>? idPdvVendaCabecalho,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idTributOperacaoFiscal != null) 'ID_TRIBUT_OPERACAO_FISCAL': idTributOperacaoFiscal,
      if (ufEmitente != null) 'UF_EMITENTE': ufEmitente,
      if (codigoNumerico != null) 'CODIGO_NUMERICO': codigoNumerico,
      if (naturezaOperacao != null) 'NATUREZA_OPERACAO': naturezaOperacao,
      if (codigoModelo != null) 'CODIGO_MODELO': codigoModelo,
      if (serie != null) 'SERIE': serie,
      if (numero != null) 'NUMERO': numero,
      if (dataHoraEmissao != null) 'DATA_HORA_EMISSAO': dataHoraEmissao,
      if (dataHoraEntradaSaida != null) 'DATA_HORA_ENTRADA_SAIDA': dataHoraEntradaSaida,
      if (tipoOperacao != null) 'TIPO_OPERACAO': tipoOperacao,
      if (localDestino != null) 'LOCAL_DESTINO': localDestino,
      if (codigoMunicipio != null) 'CODIGO_MUNICIPIO': codigoMunicipio,
      if (formatoImpressaoDanfe != null) 'FORMATO_IMPRESSAO_DANFE': formatoImpressaoDanfe,
      if (tipoEmissao != null) 'TIPO_EMISSAO': tipoEmissao,
      if (chaveAcesso != null) 'CHAVE_ACESSO': chaveAcesso,
      if (digitoChaveAcesso != null) 'DIGITO_CHAVE_ACESSO': digitoChaveAcesso,
      if (ambiente != null) 'AMBIENTE': ambiente,
      if (finalidadeEmissao != null) 'FINALIDADE_EMISSAO': finalidadeEmissao,
      if (consumidorOperacao != null) 'CONSUMIDOR_OPERACAO': consumidorOperacao,
      if (consumidorPresenca != null) 'CONSUMIDOR_PRESENCA': consumidorPresenca,
      if (processoEmissao != null) 'PROCESSO_EMISSAO': processoEmissao,
      if (versaoProcessoEmissao != null) 'VERSAO_PROCESSO_EMISSAO': versaoProcessoEmissao,
      if (dataEntradaContingencia != null) 'DATA_ENTRADA_CONTINGENCIA': dataEntradaContingencia,
      if (justificativaContingencia != null) 'JUSTIFICATIVA_CONTINGENCIA': justificativaContingencia,
      if (baseCalculoIcms != null) 'BASE_CALCULO_ICMS': baseCalculoIcms,
      if (valorIcms != null) 'VALOR_ICMS': valorIcms,
      if (valorIcmsDesonerado != null) 'VALOR_ICMS_DESONERADO': valorIcmsDesonerado,
      if (totalIcmsFcpUfDestino != null) 'TOTAL_ICMS_FCP_UF_DESTINO': totalIcmsFcpUfDestino,
      if (totalIcmsInterestadualUfDestino != null) 'TOTAL_ICMS_INTERESTADUAL_UF_DESTINO': totalIcmsInterestadualUfDestino,
      if (totalIcmsInterestadualUfRemetente != null) 'TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE': totalIcmsInterestadualUfRemetente,
      if (valorTotalFcp != null) 'VALOR_TOTAL_FCP': valorTotalFcp,
      if (baseCalculoIcmsSt != null) 'BASE_CALCULO_ICMS_ST': baseCalculoIcmsSt,
      if (valorIcmsSt != null) 'VALOR_ICMS_ST': valorIcmsSt,
      if (valorTotalFcpSt != null) 'VALOR_TOTAL_FCP_ST': valorTotalFcpSt,
      if (valorTotalFcpStRetido != null) 'VALOR_TOTAL_FCP_ST_RETIDO': valorTotalFcpStRetido,
      if (valorTotalProdutos != null) 'VALOR_TOTAL_PRODUTOS': valorTotalProdutos,
      if (valorFrete != null) 'VALOR_FRETE': valorFrete,
      if (valorSeguro != null) 'VALOR_SEGURO': valorSeguro,
      if (valorDesconto != null) 'VALOR_DESCONTO': valorDesconto,
      if (valorImpostoImportacao != null) 'VALOR_IMPOSTO_IMPORTACAO': valorImpostoImportacao,
      if (valorIpi != null) 'VALOR_IPI': valorIpi,
      if (valorIpiDevolvido != null) 'VALOR_IPI_DEVOLVIDO': valorIpiDevolvido,
      if (valorPis != null) 'VALOR_PIS': valorPis,
      if (valorCofins != null) 'VALOR_COFINS': valorCofins,
      if (valorDespesasAcessorias != null) 'VALOR_DESPESAS_ACESSORIAS': valorDespesasAcessorias,
      if (valorTotal != null) 'VALOR_TOTAL': valorTotal,
      if (valorTotalTributos != null) 'VALOR_TOTAL_TRIBUTOS': valorTotalTributos,
      if (valorServicos != null) 'VALOR_SERVICOS': valorServicos,
      if (baseCalculoIssqn != null) 'BASE_CALCULO_ISSQN': baseCalculoIssqn,
      if (valorIssqn != null) 'VALOR_ISSQN': valorIssqn,
      if (valorPisIssqn != null) 'VALOR_PIS_ISSQN': valorPisIssqn,
      if (valorCofinsIssqn != null) 'VALOR_COFINS_ISSQN': valorCofinsIssqn,
      if (dataPrestacaoServico != null) 'DATA_PRESTACAO_SERVICO': dataPrestacaoServico,
      if (valorDeducaoIssqn != null) 'VALOR_DEDUCAO_ISSQN': valorDeducaoIssqn,
      if (outrasRetencoesIssqn != null) 'OUTRAS_RETENCOES_ISSQN': outrasRetencoesIssqn,
      if (descontoIncondicionadoIssqn != null) 'DESCONTO_INCONDICIONADO_ISSQN': descontoIncondicionadoIssqn,
      if (descontoCondicionadoIssqn != null) 'DESCONTO_CONDICIONADO_ISSQN': descontoCondicionadoIssqn,
      if (totalRetencaoIssqn != null) 'TOTAL_RETENCAO_ISSQN': totalRetencaoIssqn,
      if (regimeEspecialTributacao != null) 'REGIME_ESPECIAL_TRIBUTACAO': regimeEspecialTributacao,
      if (valorRetidoPis != null) 'VALOR_RETIDO_PIS': valorRetidoPis,
      if (valorRetidoCofins != null) 'VALOR_RETIDO_COFINS': valorRetidoCofins,
      if (valorRetidoCsll != null) 'VALOR_RETIDO_CSLL': valorRetidoCsll,
      if (baseCalculoIrrf != null) 'BASE_CALCULO_IRRF': baseCalculoIrrf,
      if (valorRetidoIrrf != null) 'VALOR_RETIDO_IRRF': valorRetidoIrrf,
      if (baseCalculoPrevidencia != null) 'BASE_CALCULO_PREVIDENCIA': baseCalculoPrevidencia,
      if (valorRetidoPrevidencia != null) 'VALOR_RETIDO_PREVIDENCIA': valorRetidoPrevidencia,
      if (informacoesAddFisco != null) 'INFORMACOES_ADD_FISCO': informacoesAddFisco,
      if (informacoesAddContribuinte != null) 'INFORMACOES_ADD_CONTRIBUINTE': informacoesAddContribuinte,
      if (comexUfEmbarque != null) 'COMEX_UF_EMBARQUE': comexUfEmbarque,
      if (comexLocalEmbarque != null) 'COMEX_LOCAL_EMBARQUE': comexLocalEmbarque,
      if (comexLocalDespacho != null) 'COMEX_LOCAL_DESPACHO': comexLocalDespacho,
      if (compraNotaEmpenho != null) 'COMPRA_NOTA_EMPENHO': compraNotaEmpenho,
      if (compraPedido != null) 'COMPRA_PEDIDO': compraPedido,
      if (compraContrato != null) 'COMPRA_CONTRATO': compraContrato,
      if (qrcode != null) 'QRCODE': qrcode,
      if (urlChave != null) 'URL_CHAVE': urlChave,
      if (statusNota != null) 'STATUS_NOTA': statusNota,
      if (idPdvVendaCabecalho != null) 'ID_PDV_VENDA_CABECALHO': idPdvVendaCabecalho,
    });
  }

  NfeCabecalhosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idTributOperacaoFiscal,
      Value<int>? ufEmitente,
      Value<String>? codigoNumerico,
      Value<String>? naturezaOperacao,
      Value<String>? codigoModelo,
      Value<String>? serie,
      Value<String>? numero,
      Value<DateTime>? dataHoraEmissao,
      Value<DateTime>? dataHoraEntradaSaida,
      Value<String>? tipoOperacao,
      Value<String>? localDestino,
      Value<int>? codigoMunicipio,
      Value<String>? formatoImpressaoDanfe,
      Value<String>? tipoEmissao,
      Value<String>? chaveAcesso,
      Value<String>? digitoChaveAcesso,
      Value<String>? ambiente,
      Value<String>? finalidadeEmissao,
      Value<String>? consumidorOperacao,
      Value<String>? consumidorPresenca,
      Value<String>? processoEmissao,
      Value<String>? versaoProcessoEmissao,
      Value<DateTime>? dataEntradaContingencia,
      Value<String>? justificativaContingencia,
      Value<double>? baseCalculoIcms,
      Value<double>? valorIcms,
      Value<double>? valorIcmsDesonerado,
      Value<double>? totalIcmsFcpUfDestino,
      Value<double>? totalIcmsInterestadualUfDestino,
      Value<double>? totalIcmsInterestadualUfRemetente,
      Value<double>? valorTotalFcp,
      Value<double>? baseCalculoIcmsSt,
      Value<double>? valorIcmsSt,
      Value<double>? valorTotalFcpSt,
      Value<double>? valorTotalFcpStRetido,
      Value<double>? valorTotalProdutos,
      Value<double>? valorFrete,
      Value<double>? valorSeguro,
      Value<double>? valorDesconto,
      Value<double>? valorImpostoImportacao,
      Value<double>? valorIpi,
      Value<double>? valorIpiDevolvido,
      Value<double>? valorPis,
      Value<double>? valorCofins,
      Value<double>? valorDespesasAcessorias,
      Value<double>? valorTotal,
      Value<double>? valorTotalTributos,
      Value<double>? valorServicos,
      Value<double>? baseCalculoIssqn,
      Value<double>? valorIssqn,
      Value<double>? valorPisIssqn,
      Value<double>? valorCofinsIssqn,
      Value<DateTime>? dataPrestacaoServico,
      Value<double>? valorDeducaoIssqn,
      Value<double>? outrasRetencoesIssqn,
      Value<double>? descontoIncondicionadoIssqn,
      Value<double>? descontoCondicionadoIssqn,
      Value<double>? totalRetencaoIssqn,
      Value<String>? regimeEspecialTributacao,
      Value<double>? valorRetidoPis,
      Value<double>? valorRetidoCofins,
      Value<double>? valorRetidoCsll,
      Value<double>? baseCalculoIrrf,
      Value<double>? valorRetidoIrrf,
      Value<double>? baseCalculoPrevidencia,
      Value<double>? valorRetidoPrevidencia,
      Value<String>? informacoesAddFisco,
      Value<String>? informacoesAddContribuinte,
      Value<String>? comexUfEmbarque,
      Value<String>? comexLocalEmbarque,
      Value<String>? comexLocalDespacho,
      Value<String>? compraNotaEmpenho,
      Value<String>? compraPedido,
      Value<String>? compraContrato,
      Value<String>? qrcode,
      Value<String>? urlChave,
      Value<String>? statusNota,
      Value<int>? idPdvVendaCabecalho,
	  }) {
    return NfeCabecalhosCompanion(
      id: id ?? this.id,
      idTributOperacaoFiscal: idTributOperacaoFiscal ?? this.idTributOperacaoFiscal,
      ufEmitente: ufEmitente ?? this.ufEmitente,
      codigoNumerico: codigoNumerico ?? this.codigoNumerico,
      naturezaOperacao: naturezaOperacao ?? this.naturezaOperacao,
      codigoModelo: codigoModelo ?? this.codigoModelo,
      serie: serie ?? this.serie,
      numero: numero ?? this.numero,
      dataHoraEmissao: dataHoraEmissao ?? this.dataHoraEmissao,
      dataHoraEntradaSaida: dataHoraEntradaSaida ?? this.dataHoraEntradaSaida,
      tipoOperacao: tipoOperacao ?? this.tipoOperacao,
      localDestino: localDestino ?? this.localDestino,
      codigoMunicipio: codigoMunicipio ?? this.codigoMunicipio,
      formatoImpressaoDanfe: formatoImpressaoDanfe ?? this.formatoImpressaoDanfe,
      tipoEmissao: tipoEmissao ?? this.tipoEmissao,
      chaveAcesso: chaveAcesso ?? this.chaveAcesso,
      digitoChaveAcesso: digitoChaveAcesso ?? this.digitoChaveAcesso,
      ambiente: ambiente ?? this.ambiente,
      finalidadeEmissao: finalidadeEmissao ?? this.finalidadeEmissao,
      consumidorOperacao: consumidorOperacao ?? this.consumidorOperacao,
      consumidorPresenca: consumidorPresenca ?? this.consumidorPresenca,
      processoEmissao: processoEmissao ?? this.processoEmissao,
      versaoProcessoEmissao: versaoProcessoEmissao ?? this.versaoProcessoEmissao,
      dataEntradaContingencia: dataEntradaContingencia ?? this.dataEntradaContingencia,
      justificativaContingencia: justificativaContingencia ?? this.justificativaContingencia,
      baseCalculoIcms: baseCalculoIcms ?? this.baseCalculoIcms,
      valorIcms: valorIcms ?? this.valorIcms,
      valorIcmsDesonerado: valorIcmsDesonerado ?? this.valorIcmsDesonerado,
      totalIcmsFcpUfDestino: totalIcmsFcpUfDestino ?? this.totalIcmsFcpUfDestino,
      totalIcmsInterestadualUfDestino: totalIcmsInterestadualUfDestino ?? this.totalIcmsInterestadualUfDestino,
      totalIcmsInterestadualUfRemetente: totalIcmsInterestadualUfRemetente ?? this.totalIcmsInterestadualUfRemetente,
      valorTotalFcp: valorTotalFcp ?? this.valorTotalFcp,
      baseCalculoIcmsSt: baseCalculoIcmsSt ?? this.baseCalculoIcmsSt,
      valorIcmsSt: valorIcmsSt ?? this.valorIcmsSt,
      valorTotalFcpSt: valorTotalFcpSt ?? this.valorTotalFcpSt,
      valorTotalFcpStRetido: valorTotalFcpStRetido ?? this.valorTotalFcpStRetido,
      valorTotalProdutos: valorTotalProdutos ?? this.valorTotalProdutos,
      valorFrete: valorFrete ?? this.valorFrete,
      valorSeguro: valorSeguro ?? this.valorSeguro,
      valorDesconto: valorDesconto ?? this.valorDesconto,
      valorImpostoImportacao: valorImpostoImportacao ?? this.valorImpostoImportacao,
      valorIpi: valorIpi ?? this.valorIpi,
      valorIpiDevolvido: valorIpiDevolvido ?? this.valorIpiDevolvido,
      valorPis: valorPis ?? this.valorPis,
      valorCofins: valorCofins ?? this.valorCofins,
      valorDespesasAcessorias: valorDespesasAcessorias ?? this.valorDespesasAcessorias,
      valorTotal: valorTotal ?? this.valorTotal,
      valorTotalTributos: valorTotalTributos ?? this.valorTotalTributos,
      valorServicos: valorServicos ?? this.valorServicos,
      baseCalculoIssqn: baseCalculoIssqn ?? this.baseCalculoIssqn,
      valorIssqn: valorIssqn ?? this.valorIssqn,
      valorPisIssqn: valorPisIssqn ?? this.valorPisIssqn,
      valorCofinsIssqn: valorCofinsIssqn ?? this.valorCofinsIssqn,
      dataPrestacaoServico: dataPrestacaoServico ?? this.dataPrestacaoServico,
      valorDeducaoIssqn: valorDeducaoIssqn ?? this.valorDeducaoIssqn,
      outrasRetencoesIssqn: outrasRetencoesIssqn ?? this.outrasRetencoesIssqn,
      descontoIncondicionadoIssqn: descontoIncondicionadoIssqn ?? this.descontoIncondicionadoIssqn,
      descontoCondicionadoIssqn: descontoCondicionadoIssqn ?? this.descontoCondicionadoIssqn,
      totalRetencaoIssqn: totalRetencaoIssqn ?? this.totalRetencaoIssqn,
      regimeEspecialTributacao: regimeEspecialTributacao ?? this.regimeEspecialTributacao,
      valorRetidoPis: valorRetidoPis ?? this.valorRetidoPis,
      valorRetidoCofins: valorRetidoCofins ?? this.valorRetidoCofins,
      valorRetidoCsll: valorRetidoCsll ?? this.valorRetidoCsll,
      baseCalculoIrrf: baseCalculoIrrf ?? this.baseCalculoIrrf,
      valorRetidoIrrf: valorRetidoIrrf ?? this.valorRetidoIrrf,
      baseCalculoPrevidencia: baseCalculoPrevidencia ?? this.baseCalculoPrevidencia,
      valorRetidoPrevidencia: valorRetidoPrevidencia ?? this.valorRetidoPrevidencia,
      informacoesAddFisco: informacoesAddFisco ?? this.informacoesAddFisco,
      informacoesAddContribuinte: informacoesAddContribuinte ?? this.informacoesAddContribuinte,
      comexUfEmbarque: comexUfEmbarque ?? this.comexUfEmbarque,
      comexLocalEmbarque: comexLocalEmbarque ?? this.comexLocalEmbarque,
      comexLocalDespacho: comexLocalDespacho ?? this.comexLocalDespacho,
      compraNotaEmpenho: compraNotaEmpenho ?? this.compraNotaEmpenho,
      compraPedido: compraPedido ?? this.compraPedido,
      compraContrato: compraContrato ?? this.compraContrato,
      qrcode: qrcode ?? this.qrcode,
      urlChave: urlChave ?? this.urlChave,
      statusNota: statusNota ?? this.statusNota,
      idPdvVendaCabecalho: idPdvVendaCabecalho ?? this.idPdvVendaCabecalho,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idTributOperacaoFiscal.present) {
      map['ID_TRIBUT_OPERACAO_FISCAL'] = Variable<int?>(idTributOperacaoFiscal.value);
    }
    if (ufEmitente.present) {
      map['UF_EMITENTE'] = Variable<int?>(ufEmitente.value);
    }
    if (codigoNumerico.present) {
      map['CODIGO_NUMERICO'] = Variable<String?>(codigoNumerico.value);
    }
    if (naturezaOperacao.present) {
      map['NATUREZA_OPERACAO'] = Variable<String?>(naturezaOperacao.value);
    }
    if (codigoModelo.present) {
      map['CODIGO_MODELO'] = Variable<String?>(codigoModelo.value);
    }
    if (serie.present) {
      map['SERIE'] = Variable<String?>(serie.value);
    }
    if (numero.present) {
      map['NUMERO'] = Variable<String?>(numero.value);
    }
    if (dataHoraEmissao.present) {
      map['DATA_HORA_EMISSAO'] = Variable<DateTime?>(dataHoraEmissao.value);
    }
    if (dataHoraEntradaSaida.present) {
      map['DATA_HORA_ENTRADA_SAIDA'] = Variable<DateTime?>(dataHoraEntradaSaida.value);
    }
    if (tipoOperacao.present) {
      map['TIPO_OPERACAO'] = Variable<String?>(tipoOperacao.value);
    }
    if (localDestino.present) {
      map['LOCAL_DESTINO'] = Variable<String?>(localDestino.value);
    }
    if (codigoMunicipio.present) {
      map['CODIGO_MUNICIPIO'] = Variable<int?>(codigoMunicipio.value);
    }
    if (formatoImpressaoDanfe.present) {
      map['FORMATO_IMPRESSAO_DANFE'] = Variable<String?>(formatoImpressaoDanfe.value);
    }
    if (tipoEmissao.present) {
      map['TIPO_EMISSAO'] = Variable<String?>(tipoEmissao.value);
    }
    if (chaveAcesso.present) {
      map['CHAVE_ACESSO'] = Variable<String?>(chaveAcesso.value);
    }
    if (digitoChaveAcesso.present) {
      map['DIGITO_CHAVE_ACESSO'] = Variable<String?>(digitoChaveAcesso.value);
    }
    if (ambiente.present) {
      map['AMBIENTE'] = Variable<String?>(ambiente.value);
    }
    if (finalidadeEmissao.present) {
      map['FINALIDADE_EMISSAO'] = Variable<String?>(finalidadeEmissao.value);
    }
    if (consumidorOperacao.present) {
      map['CONSUMIDOR_OPERACAO'] = Variable<String?>(consumidorOperacao.value);
    }
    if (consumidorPresenca.present) {
      map['CONSUMIDOR_PRESENCA'] = Variable<String?>(consumidorPresenca.value);
    }
    if (processoEmissao.present) {
      map['PROCESSO_EMISSAO'] = Variable<String?>(processoEmissao.value);
    }
    if (versaoProcessoEmissao.present) {
      map['VERSAO_PROCESSO_EMISSAO'] = Variable<String?>(versaoProcessoEmissao.value);
    }
    if (dataEntradaContingencia.present) {
      map['DATA_ENTRADA_CONTINGENCIA'] = Variable<DateTime?>(dataEntradaContingencia.value);
    }
    if (justificativaContingencia.present) {
      map['JUSTIFICATIVA_CONTINGENCIA'] = Variable<String?>(justificativaContingencia.value);
    }
    if (baseCalculoIcms.present) {
      map['BASE_CALCULO_ICMS'] = Variable<double?>(baseCalculoIcms.value);
    }
    if (valorIcms.present) {
      map['VALOR_ICMS'] = Variable<double?>(valorIcms.value);
    }
    if (valorIcmsDesonerado.present) {
      map['VALOR_ICMS_DESONERADO'] = Variable<double?>(valorIcmsDesonerado.value);
    }
    if (totalIcmsFcpUfDestino.present) {
      map['TOTAL_ICMS_FCP_UF_DESTINO'] = Variable<double?>(totalIcmsFcpUfDestino.value);
    }
    if (totalIcmsInterestadualUfDestino.present) {
      map['TOTAL_ICMS_INTERESTADUAL_UF_DESTINO'] = Variable<double?>(totalIcmsInterestadualUfDestino.value);
    }
    if (totalIcmsInterestadualUfRemetente.present) {
      map['TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE'] = Variable<double?>(totalIcmsInterestadualUfRemetente.value);
    }
    if (valorTotalFcp.present) {
      map['VALOR_TOTAL_FCP'] = Variable<double?>(valorTotalFcp.value);
    }
    if (baseCalculoIcmsSt.present) {
      map['BASE_CALCULO_ICMS_ST'] = Variable<double?>(baseCalculoIcmsSt.value);
    }
    if (valorIcmsSt.present) {
      map['VALOR_ICMS_ST'] = Variable<double?>(valorIcmsSt.value);
    }
    if (valorTotalFcpSt.present) {
      map['VALOR_TOTAL_FCP_ST'] = Variable<double?>(valorTotalFcpSt.value);
    }
    if (valorTotalFcpStRetido.present) {
      map['VALOR_TOTAL_FCP_ST_RETIDO'] = Variable<double?>(valorTotalFcpStRetido.value);
    }
    if (valorTotalProdutos.present) {
      map['VALOR_TOTAL_PRODUTOS'] = Variable<double?>(valorTotalProdutos.value);
    }
    if (valorFrete.present) {
      map['VALOR_FRETE'] = Variable<double?>(valorFrete.value);
    }
    if (valorSeguro.present) {
      map['VALOR_SEGURO'] = Variable<double?>(valorSeguro.value);
    }
    if (valorDesconto.present) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto.value);
    }
    if (valorImpostoImportacao.present) {
      map['VALOR_IMPOSTO_IMPORTACAO'] = Variable<double?>(valorImpostoImportacao.value);
    }
    if (valorIpi.present) {
      map['VALOR_IPI'] = Variable<double?>(valorIpi.value);
    }
    if (valorIpiDevolvido.present) {
      map['VALOR_IPI_DEVOLVIDO'] = Variable<double?>(valorIpiDevolvido.value);
    }
    if (valorPis.present) {
      map['VALOR_PIS'] = Variable<double?>(valorPis.value);
    }
    if (valorCofins.present) {
      map['VALOR_COFINS'] = Variable<double?>(valorCofins.value);
    }
    if (valorDespesasAcessorias.present) {
      map['VALOR_DESPESAS_ACESSORIAS'] = Variable<double?>(valorDespesasAcessorias.value);
    }
    if (valorTotal.present) {
      map['VALOR_TOTAL'] = Variable<double?>(valorTotal.value);
    }
    if (valorTotalTributos.present) {
      map['VALOR_TOTAL_TRIBUTOS'] = Variable<double?>(valorTotalTributos.value);
    }
    if (valorServicos.present) {
      map['VALOR_SERVICOS'] = Variable<double?>(valorServicos.value);
    }
    if (baseCalculoIssqn.present) {
      map['BASE_CALCULO_ISSQN'] = Variable<double?>(baseCalculoIssqn.value);
    }
    if (valorIssqn.present) {
      map['VALOR_ISSQN'] = Variable<double?>(valorIssqn.value);
    }
    if (valorPisIssqn.present) {
      map['VALOR_PIS_ISSQN'] = Variable<double?>(valorPisIssqn.value);
    }
    if (valorCofinsIssqn.present) {
      map['VALOR_COFINS_ISSQN'] = Variable<double?>(valorCofinsIssqn.value);
    }
    if (dataPrestacaoServico.present) {
      map['DATA_PRESTACAO_SERVICO'] = Variable<DateTime?>(dataPrestacaoServico.value);
    }
    if (valorDeducaoIssqn.present) {
      map['VALOR_DEDUCAO_ISSQN'] = Variable<double?>(valorDeducaoIssqn.value);
    }
    if (outrasRetencoesIssqn.present) {
      map['OUTRAS_RETENCOES_ISSQN'] = Variable<double?>(outrasRetencoesIssqn.value);
    }
    if (descontoIncondicionadoIssqn.present) {
      map['DESCONTO_INCONDICIONADO_ISSQN'] = Variable<double?>(descontoIncondicionadoIssqn.value);
    }
    if (descontoCondicionadoIssqn.present) {
      map['DESCONTO_CONDICIONADO_ISSQN'] = Variable<double?>(descontoCondicionadoIssqn.value);
    }
    if (totalRetencaoIssqn.present) {
      map['TOTAL_RETENCAO_ISSQN'] = Variable<double?>(totalRetencaoIssqn.value);
    }
    if (regimeEspecialTributacao.present) {
      map['REGIME_ESPECIAL_TRIBUTACAO'] = Variable<String?>(regimeEspecialTributacao.value);
    }
    if (valorRetidoPis.present) {
      map['VALOR_RETIDO_PIS'] = Variable<double?>(valorRetidoPis.value);
    }
    if (valorRetidoCofins.present) {
      map['VALOR_RETIDO_COFINS'] = Variable<double?>(valorRetidoCofins.value);
    }
    if (valorRetidoCsll.present) {
      map['VALOR_RETIDO_CSLL'] = Variable<double?>(valorRetidoCsll.value);
    }
    if (baseCalculoIrrf.present) {
      map['BASE_CALCULO_IRRF'] = Variable<double?>(baseCalculoIrrf.value);
    }
    if (valorRetidoIrrf.present) {
      map['VALOR_RETIDO_IRRF'] = Variable<double?>(valorRetidoIrrf.value);
    }
    if (baseCalculoPrevidencia.present) {
      map['BASE_CALCULO_PREVIDENCIA'] = Variable<double?>(baseCalculoPrevidencia.value);
    }
    if (valorRetidoPrevidencia.present) {
      map['VALOR_RETIDO_PREVIDENCIA'] = Variable<double?>(valorRetidoPrevidencia.value);
    }
    if (informacoesAddFisco.present) {
      map['INFORMACOES_ADD_FISCO'] = Variable<String?>(informacoesAddFisco.value);
    }
    if (informacoesAddContribuinte.present) {
      map['INFORMACOES_ADD_CONTRIBUINTE'] = Variable<String?>(informacoesAddContribuinte.value);
    }
    if (comexUfEmbarque.present) {
      map['COMEX_UF_EMBARQUE'] = Variable<String?>(comexUfEmbarque.value);
    }
    if (comexLocalEmbarque.present) {
      map['COMEX_LOCAL_EMBARQUE'] = Variable<String?>(comexLocalEmbarque.value);
    }
    if (comexLocalDespacho.present) {
      map['COMEX_LOCAL_DESPACHO'] = Variable<String?>(comexLocalDespacho.value);
    }
    if (compraNotaEmpenho.present) {
      map['COMPRA_NOTA_EMPENHO'] = Variable<String?>(compraNotaEmpenho.value);
    }
    if (compraPedido.present) {
      map['COMPRA_PEDIDO'] = Variable<String?>(compraPedido.value);
    }
    if (compraContrato.present) {
      map['COMPRA_CONTRATO'] = Variable<String?>(compraContrato.value);
    }
    if (qrcode.present) {
      map['QRCODE'] = Variable<String?>(qrcode.value);
    }
    if (urlChave.present) {
      map['URL_CHAVE'] = Variable<String?>(urlChave.value);
    }
    if (statusNota.present) {
      map['STATUS_NOTA'] = Variable<String?>(statusNota.value);
    }
    if (idPdvVendaCabecalho.present) {
      map['ID_PDV_VENDA_CABECALHO'] = Variable<int?>(idPdvVendaCabecalho.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeCabecalhosCompanion(')
          ..write('id: $id, ')
          ..write('idTributOperacaoFiscal: $idTributOperacaoFiscal, ')
          ..write('ufEmitente: $ufEmitente, ')
          ..write('codigoNumerico: $codigoNumerico, ')
          ..write('naturezaOperacao: $naturezaOperacao, ')
          ..write('codigoModelo: $codigoModelo, ')
          ..write('serie: $serie, ')
          ..write('numero: $numero, ')
          ..write('dataHoraEmissao: $dataHoraEmissao, ')
          ..write('dataHoraEntradaSaida: $dataHoraEntradaSaida, ')
          ..write('tipoOperacao: $tipoOperacao, ')
          ..write('localDestino: $localDestino, ')
          ..write('codigoMunicipio: $codigoMunicipio, ')
          ..write('formatoImpressaoDanfe: $formatoImpressaoDanfe, ')
          ..write('tipoEmissao: $tipoEmissao, ')
          ..write('chaveAcesso: $chaveAcesso, ')
          ..write('digitoChaveAcesso: $digitoChaveAcesso, ')
          ..write('ambiente: $ambiente, ')
          ..write('finalidadeEmissao: $finalidadeEmissao, ')
          ..write('consumidorOperacao: $consumidorOperacao, ')
          ..write('consumidorPresenca: $consumidorPresenca, ')
          ..write('processoEmissao: $processoEmissao, ')
          ..write('versaoProcessoEmissao: $versaoProcessoEmissao, ')
          ..write('dataEntradaContingencia: $dataEntradaContingencia, ')
          ..write('justificativaContingencia: $justificativaContingencia, ')
          ..write('baseCalculoIcms: $baseCalculoIcms, ')
          ..write('valorIcms: $valorIcms, ')
          ..write('valorIcmsDesonerado: $valorIcmsDesonerado, ')
          ..write('totalIcmsFcpUfDestino: $totalIcmsFcpUfDestino, ')
          ..write('totalIcmsInterestadualUfDestino: $totalIcmsInterestadualUfDestino, ')
          ..write('totalIcmsInterestadualUfRemetente: $totalIcmsInterestadualUfRemetente, ')
          ..write('valorTotalFcp: $valorTotalFcp, ')
          ..write('baseCalculoIcmsSt: $baseCalculoIcmsSt, ')
          ..write('valorIcmsSt: $valorIcmsSt, ')
          ..write('valorTotalFcpSt: $valorTotalFcpSt, ')
          ..write('valorTotalFcpStRetido: $valorTotalFcpStRetido, ')
          ..write('valorTotalProdutos: $valorTotalProdutos, ')
          ..write('valorFrete: $valorFrete, ')
          ..write('valorSeguro: $valorSeguro, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorImpostoImportacao: $valorImpostoImportacao, ')
          ..write('valorIpi: $valorIpi, ')
          ..write('valorIpiDevolvido: $valorIpiDevolvido, ')
          ..write('valorPis: $valorPis, ')
          ..write('valorCofins: $valorCofins, ')
          ..write('valorDespesasAcessorias: $valorDespesasAcessorias, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('valorTotalTributos: $valorTotalTributos, ')
          ..write('valorServicos: $valorServicos, ')
          ..write('baseCalculoIssqn: $baseCalculoIssqn, ')
          ..write('valorIssqn: $valorIssqn, ')
          ..write('valorPisIssqn: $valorPisIssqn, ')
          ..write('valorCofinsIssqn: $valorCofinsIssqn, ')
          ..write('dataPrestacaoServico: $dataPrestacaoServico, ')
          ..write('valorDeducaoIssqn: $valorDeducaoIssqn, ')
          ..write('outrasRetencoesIssqn: $outrasRetencoesIssqn, ')
          ..write('descontoIncondicionadoIssqn: $descontoIncondicionadoIssqn, ')
          ..write('descontoCondicionadoIssqn: $descontoCondicionadoIssqn, ')
          ..write('totalRetencaoIssqn: $totalRetencaoIssqn, ')
          ..write('regimeEspecialTributacao: $regimeEspecialTributacao, ')
          ..write('valorRetidoPis: $valorRetidoPis, ')
          ..write('valorRetidoCofins: $valorRetidoCofins, ')
          ..write('valorRetidoCsll: $valorRetidoCsll, ')
          ..write('baseCalculoIrrf: $baseCalculoIrrf, ')
          ..write('valorRetidoIrrf: $valorRetidoIrrf, ')
          ..write('baseCalculoPrevidencia: $baseCalculoPrevidencia, ')
          ..write('valorRetidoPrevidencia: $valorRetidoPrevidencia, ')
          ..write('informacoesAddFisco: $informacoesAddFisco, ')
          ..write('informacoesAddContribuinte: $informacoesAddContribuinte, ')
          ..write('comexUfEmbarque: $comexUfEmbarque, ')
          ..write('comexLocalEmbarque: $comexLocalEmbarque, ')
          ..write('comexLocalDespacho: $comexLocalDespacho, ')
          ..write('compraNotaEmpenho: $compraNotaEmpenho, ')
          ..write('compraPedido: $compraPedido, ')
          ..write('compraContrato: $compraContrato, ')
          ..write('qrcode: $qrcode, ')
          ..write('urlChave: $urlChave, ')
          ..write('statusNota: $statusNota, ')
          ..write('idPdvVendaCabecalho: $idPdvVendaCabecalho, ')
          ..write(')'))
        .toString();
  }
}

class $NfeCabecalhosTable extends NfeCabecalhos
    with TableInfo<$NfeCabecalhosTable, NfeCabecalho> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeCabecalhosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idTributOperacaoFiscalMeta =
      const VerificationMeta('idTributOperacaoFiscal');
  GeneratedColumn<int>? _idTributOperacaoFiscal;
  @override
  GeneratedColumn<int> get idTributOperacaoFiscal =>
      _idTributOperacaoFiscal ??= GeneratedColumn<int>('ID_TRIBUT_OPERACAO_FISCAL', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES TRIBUT_OPERACAO_FISCAL(ID)');
  final VerificationMeta _ufEmitenteMeta =
      const VerificationMeta('ufEmitente');
  GeneratedColumn<int>? _ufEmitente;
  @override
  GeneratedColumn<int> get ufEmitente => _ufEmitente ??=
      GeneratedColumn<int>('UF_EMITENTE', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _codigoNumericoMeta =
      const VerificationMeta('codigoNumerico');
  GeneratedColumn<String>? _codigoNumerico;
  @override
  GeneratedColumn<String> get codigoNumerico => _codigoNumerico ??=
      GeneratedColumn<String>('CODIGO_NUMERICO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _naturezaOperacaoMeta =
      const VerificationMeta('naturezaOperacao');
  GeneratedColumn<String>? _naturezaOperacao;
  @override
  GeneratedColumn<String> get naturezaOperacao => _naturezaOperacao ??=
      GeneratedColumn<String>('NATUREZA_OPERACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoModeloMeta =
      const VerificationMeta('codigoModelo');
  GeneratedColumn<String>? _codigoModelo;
  @override
  GeneratedColumn<String> get codigoModelo => _codigoModelo ??=
      GeneratedColumn<String>('CODIGO_MODELO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _serieMeta =
      const VerificationMeta('serie');
  GeneratedColumn<String>? _serie;
  @override
  GeneratedColumn<String> get serie => _serie ??=
      GeneratedColumn<String>('SERIE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroMeta =
      const VerificationMeta('numero');
  GeneratedColumn<String>? _numero;
  @override
  GeneratedColumn<String> get numero => _numero ??=
      GeneratedColumn<String>('NUMERO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dataHoraEmissaoMeta =
      const VerificationMeta('dataHoraEmissao');
  GeneratedColumn<DateTime>? _dataHoraEmissao;
  @override
  GeneratedColumn<DateTime> get dataHoraEmissao => _dataHoraEmissao ??=
      GeneratedColumn<DateTime>('DATA_HORA_EMISSAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dataHoraEntradaSaidaMeta =
      const VerificationMeta('dataHoraEntradaSaida');
  GeneratedColumn<DateTime>? _dataHoraEntradaSaida;
  @override
  GeneratedColumn<DateTime> get dataHoraEntradaSaida => _dataHoraEntradaSaida ??=
      GeneratedColumn<DateTime>('DATA_HORA_ENTRADA_SAIDA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _tipoOperacaoMeta =
      const VerificationMeta('tipoOperacao');
  GeneratedColumn<String>? _tipoOperacao;
  @override
  GeneratedColumn<String> get tipoOperacao => _tipoOperacao ??=
      GeneratedColumn<String>('TIPO_OPERACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _localDestinoMeta =
      const VerificationMeta('localDestino');
  GeneratedColumn<String>? _localDestino;
  @override
  GeneratedColumn<String> get localDestino => _localDestino ??=
      GeneratedColumn<String>('LOCAL_DESTINO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoMunicipioMeta =
      const VerificationMeta('codigoMunicipio');
  GeneratedColumn<int>? _codigoMunicipio;
  @override
  GeneratedColumn<int> get codigoMunicipio => _codigoMunicipio ??=
      GeneratedColumn<int>('CODIGO_MUNICIPIO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _formatoImpressaoDanfeMeta =
      const VerificationMeta('formatoImpressaoDanfe');
  GeneratedColumn<String>? _formatoImpressaoDanfe;
  @override
  GeneratedColumn<String> get formatoImpressaoDanfe => _formatoImpressaoDanfe ??=
      GeneratedColumn<String>('FORMATO_IMPRESSAO_DANFE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _tipoEmissaoMeta =
      const VerificationMeta('tipoEmissao');
  GeneratedColumn<String>? _tipoEmissao;
  @override
  GeneratedColumn<String> get tipoEmissao => _tipoEmissao ??=
      GeneratedColumn<String>('TIPO_EMISSAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _chaveAcessoMeta =
      const VerificationMeta('chaveAcesso');
  GeneratedColumn<String>? _chaveAcesso;
  @override
  GeneratedColumn<String> get chaveAcesso => _chaveAcesso ??=
      GeneratedColumn<String>('CHAVE_ACESSO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _digitoChaveAcessoMeta =
      const VerificationMeta('digitoChaveAcesso');
  GeneratedColumn<String>? _digitoChaveAcesso;
  @override
  GeneratedColumn<String> get digitoChaveAcesso => _digitoChaveAcesso ??=
      GeneratedColumn<String>('DIGITO_CHAVE_ACESSO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ambienteMeta =
      const VerificationMeta('ambiente');
  GeneratedColumn<String>? _ambiente;
  @override
  GeneratedColumn<String> get ambiente => _ambiente ??=
      GeneratedColumn<String>('AMBIENTE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _finalidadeEmissaoMeta =
      const VerificationMeta('finalidadeEmissao');
  GeneratedColumn<String>? _finalidadeEmissao;
  @override
  GeneratedColumn<String> get finalidadeEmissao => _finalidadeEmissao ??=
      GeneratedColumn<String>('FINALIDADE_EMISSAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _consumidorOperacaoMeta =
      const VerificationMeta('consumidorOperacao');
  GeneratedColumn<String>? _consumidorOperacao;
  @override
  GeneratedColumn<String> get consumidorOperacao => _consumidorOperacao ??=
      GeneratedColumn<String>('CONSUMIDOR_OPERACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _consumidorPresencaMeta =
      const VerificationMeta('consumidorPresenca');
  GeneratedColumn<String>? _consumidorPresenca;
  @override
  GeneratedColumn<String> get consumidorPresenca => _consumidorPresenca ??=
      GeneratedColumn<String>('CONSUMIDOR_PRESENCA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _processoEmissaoMeta =
      const VerificationMeta('processoEmissao');
  GeneratedColumn<String>? _processoEmissao;
  @override
  GeneratedColumn<String> get processoEmissao => _processoEmissao ??=
      GeneratedColumn<String>('PROCESSO_EMISSAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _versaoProcessoEmissaoMeta =
      const VerificationMeta('versaoProcessoEmissao');
  GeneratedColumn<String>? _versaoProcessoEmissao;
  @override
  GeneratedColumn<String> get versaoProcessoEmissao => _versaoProcessoEmissao ??=
      GeneratedColumn<String>('VERSAO_PROCESSO_EMISSAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dataEntradaContingenciaMeta =
      const VerificationMeta('dataEntradaContingencia');
  GeneratedColumn<DateTime>? _dataEntradaContingencia;
  @override
  GeneratedColumn<DateTime> get dataEntradaContingencia => _dataEntradaContingencia ??=
      GeneratedColumn<DateTime>('DATA_ENTRADA_CONTINGENCIA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _justificativaContingenciaMeta =
      const VerificationMeta('justificativaContingencia');
  GeneratedColumn<String>? _justificativaContingencia;
  @override
  GeneratedColumn<String> get justificativaContingencia => _justificativaContingencia ??=
      GeneratedColumn<String>('JUSTIFICATIVA_CONTINGENCIA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _baseCalculoIcmsMeta =
      const VerificationMeta('baseCalculoIcms');
  GeneratedColumn<double>? _baseCalculoIcms;
  @override
  GeneratedColumn<double> get baseCalculoIcms => _baseCalculoIcms ??=
      GeneratedColumn<double>('BASE_CALCULO_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsMeta =
      const VerificationMeta('valorIcms');
  GeneratedColumn<double>? _valorIcms;
  @override
  GeneratedColumn<double> get valorIcms => _valorIcms ??=
      GeneratedColumn<double>('VALOR_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsDesoneradoMeta =
      const VerificationMeta('valorIcmsDesonerado');
  GeneratedColumn<double>? _valorIcmsDesonerado;
  @override
  GeneratedColumn<double> get valorIcmsDesonerado => _valorIcmsDesonerado ??=
      GeneratedColumn<double>('VALOR_ICMS_DESONERADO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _totalIcmsFcpUfDestinoMeta =
      const VerificationMeta('totalIcmsFcpUfDestino');
  GeneratedColumn<double>? _totalIcmsFcpUfDestino;
  @override
  GeneratedColumn<double> get totalIcmsFcpUfDestino => _totalIcmsFcpUfDestino ??=
      GeneratedColumn<double>('TOTAL_ICMS_FCP_UF_DESTINO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _totalIcmsInterestadualUfDestinoMeta =
      const VerificationMeta('totalIcmsInterestadualUfDestino');
  GeneratedColumn<double>? _totalIcmsInterestadualUfDestino;
  @override
  GeneratedColumn<double> get totalIcmsInterestadualUfDestino => _totalIcmsInterestadualUfDestino ??=
      GeneratedColumn<double>('TOTAL_ICMS_INTERESTADUAL_UF_DESTINO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _totalIcmsInterestadualUfRemetenteMeta =
      const VerificationMeta('totalIcmsInterestadualUfRemetente');
  GeneratedColumn<double>? _totalIcmsInterestadualUfRemetente;
  @override
  GeneratedColumn<double> get totalIcmsInterestadualUfRemetente => _totalIcmsInterestadualUfRemetente ??=
      GeneratedColumn<double>('TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorTotalFcpMeta =
      const VerificationMeta('valorTotalFcp');
  GeneratedColumn<double>? _valorTotalFcp;
  @override
  GeneratedColumn<double> get valorTotalFcp => _valorTotalFcp ??=
      GeneratedColumn<double>('VALOR_TOTAL_FCP', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _baseCalculoIcmsStMeta =
      const VerificationMeta('baseCalculoIcmsSt');
  GeneratedColumn<double>? _baseCalculoIcmsSt;
  @override
  GeneratedColumn<double> get baseCalculoIcmsSt => _baseCalculoIcmsSt ??=
      GeneratedColumn<double>('BASE_CALCULO_ICMS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsStMeta =
      const VerificationMeta('valorIcmsSt');
  GeneratedColumn<double>? _valorIcmsSt;
  @override
  GeneratedColumn<double> get valorIcmsSt => _valorIcmsSt ??=
      GeneratedColumn<double>('VALOR_ICMS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorTotalFcpStMeta =
      const VerificationMeta('valorTotalFcpSt');
  GeneratedColumn<double>? _valorTotalFcpSt;
  @override
  GeneratedColumn<double> get valorTotalFcpSt => _valorTotalFcpSt ??=
      GeneratedColumn<double>('VALOR_TOTAL_FCP_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorTotalFcpStRetidoMeta =
      const VerificationMeta('valorTotalFcpStRetido');
  GeneratedColumn<double>? _valorTotalFcpStRetido;
  @override
  GeneratedColumn<double> get valorTotalFcpStRetido => _valorTotalFcpStRetido ??=
      GeneratedColumn<double>('VALOR_TOTAL_FCP_ST_RETIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorTotalProdutosMeta =
      const VerificationMeta('valorTotalProdutos');
  GeneratedColumn<double>? _valorTotalProdutos;
  @override
  GeneratedColumn<double> get valorTotalProdutos => _valorTotalProdutos ??=
      GeneratedColumn<double>('VALOR_TOTAL_PRODUTOS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorFreteMeta =
      const VerificationMeta('valorFrete');
  GeneratedColumn<double>? _valorFrete;
  @override
  GeneratedColumn<double> get valorFrete => _valorFrete ??=
      GeneratedColumn<double>('VALOR_FRETE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorSeguroMeta =
      const VerificationMeta('valorSeguro');
  GeneratedColumn<double>? _valorSeguro;
  @override
  GeneratedColumn<double> get valorSeguro => _valorSeguro ??=
      GeneratedColumn<double>('VALOR_SEGURO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorDescontoMeta =
      const VerificationMeta('valorDesconto');
  GeneratedColumn<double>? _valorDesconto;
  @override
  GeneratedColumn<double> get valorDesconto => _valorDesconto ??=
      GeneratedColumn<double>('VALOR_DESCONTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorImpostoImportacaoMeta =
      const VerificationMeta('valorImpostoImportacao');
  GeneratedColumn<double>? _valorImpostoImportacao;
  @override
  GeneratedColumn<double> get valorImpostoImportacao => _valorImpostoImportacao ??=
      GeneratedColumn<double>('VALOR_IMPOSTO_IMPORTACAO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIpiMeta =
      const VerificationMeta('valorIpi');
  GeneratedColumn<double>? _valorIpi;
  @override
  GeneratedColumn<double> get valorIpi => _valorIpi ??=
      GeneratedColumn<double>('VALOR_IPI', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIpiDevolvidoMeta =
      const VerificationMeta('valorIpiDevolvido');
  GeneratedColumn<double>? _valorIpiDevolvido;
  @override
  GeneratedColumn<double> get valorIpiDevolvido => _valorIpiDevolvido ??=
      GeneratedColumn<double>('VALOR_IPI_DEVOLVIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPisMeta =
      const VerificationMeta('valorPis');
  GeneratedColumn<double>? _valorPis;
  @override
  GeneratedColumn<double> get valorPis => _valorPis ??=
      GeneratedColumn<double>('VALOR_PIS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorCofinsMeta =
      const VerificationMeta('valorCofins');
  GeneratedColumn<double>? _valorCofins;
  @override
  GeneratedColumn<double> get valorCofins => _valorCofins ??=
      GeneratedColumn<double>('VALOR_COFINS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorDespesasAcessoriasMeta =
      const VerificationMeta('valorDespesasAcessorias');
  GeneratedColumn<double>? _valorDespesasAcessorias;
  @override
  GeneratedColumn<double> get valorDespesasAcessorias => _valorDespesasAcessorias ??=
      GeneratedColumn<double>('VALOR_DESPESAS_ACESSORIAS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorTotalMeta =
      const VerificationMeta('valorTotal');
  GeneratedColumn<double>? _valorTotal;
  @override
  GeneratedColumn<double> get valorTotal => _valorTotal ??=
      GeneratedColumn<double>('VALOR_TOTAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorTotalTributosMeta =
      const VerificationMeta('valorTotalTributos');
  GeneratedColumn<double>? _valorTotalTributos;
  @override
  GeneratedColumn<double> get valorTotalTributos => _valorTotalTributos ??=
      GeneratedColumn<double>('VALOR_TOTAL_TRIBUTOS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorServicosMeta =
      const VerificationMeta('valorServicos');
  GeneratedColumn<double>? _valorServicos;
  @override
  GeneratedColumn<double> get valorServicos => _valorServicos ??=
      GeneratedColumn<double>('VALOR_SERVICOS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _baseCalculoIssqnMeta =
      const VerificationMeta('baseCalculoIssqn');
  GeneratedColumn<double>? _baseCalculoIssqn;
  @override
  GeneratedColumn<double> get baseCalculoIssqn => _baseCalculoIssqn ??=
      GeneratedColumn<double>('BASE_CALCULO_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIssqnMeta =
      const VerificationMeta('valorIssqn');
  GeneratedColumn<double>? _valorIssqn;
  @override
  GeneratedColumn<double> get valorIssqn => _valorIssqn ??=
      GeneratedColumn<double>('VALOR_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPisIssqnMeta =
      const VerificationMeta('valorPisIssqn');
  GeneratedColumn<double>? _valorPisIssqn;
  @override
  GeneratedColumn<double> get valorPisIssqn => _valorPisIssqn ??=
      GeneratedColumn<double>('VALOR_PIS_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorCofinsIssqnMeta =
      const VerificationMeta('valorCofinsIssqn');
  GeneratedColumn<double>? _valorCofinsIssqn;
  @override
  GeneratedColumn<double> get valorCofinsIssqn => _valorCofinsIssqn ??=
      GeneratedColumn<double>('VALOR_COFINS_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _dataPrestacaoServicoMeta =
      const VerificationMeta('dataPrestacaoServico');
  GeneratedColumn<DateTime>? _dataPrestacaoServico;
  @override
  GeneratedColumn<DateTime> get dataPrestacaoServico => _dataPrestacaoServico ??=
      GeneratedColumn<DateTime>('DATA_PRESTACAO_SERVICO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _valorDeducaoIssqnMeta =
      const VerificationMeta('valorDeducaoIssqn');
  GeneratedColumn<double>? _valorDeducaoIssqn;
  @override
  GeneratedColumn<double> get valorDeducaoIssqn => _valorDeducaoIssqn ??=
      GeneratedColumn<double>('VALOR_DEDUCAO_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _outrasRetencoesIssqnMeta =
      const VerificationMeta('outrasRetencoesIssqn');
  GeneratedColumn<double>? _outrasRetencoesIssqn;
  @override
  GeneratedColumn<double> get outrasRetencoesIssqn => _outrasRetencoesIssqn ??=
      GeneratedColumn<double>('OUTRAS_RETENCOES_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _descontoIncondicionadoIssqnMeta =
      const VerificationMeta('descontoIncondicionadoIssqn');
  GeneratedColumn<double>? _descontoIncondicionadoIssqn;
  @override
  GeneratedColumn<double> get descontoIncondicionadoIssqn => _descontoIncondicionadoIssqn ??=
      GeneratedColumn<double>('DESCONTO_INCONDICIONADO_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _descontoCondicionadoIssqnMeta =
      const VerificationMeta('descontoCondicionadoIssqn');
  GeneratedColumn<double>? _descontoCondicionadoIssqn;
  @override
  GeneratedColumn<double> get descontoCondicionadoIssqn => _descontoCondicionadoIssqn ??=
      GeneratedColumn<double>('DESCONTO_CONDICIONADO_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _totalRetencaoIssqnMeta =
      const VerificationMeta('totalRetencaoIssqn');
  GeneratedColumn<double>? _totalRetencaoIssqn;
  @override
  GeneratedColumn<double> get totalRetencaoIssqn => _totalRetencaoIssqn ??=
      GeneratedColumn<double>('TOTAL_RETENCAO_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _regimeEspecialTributacaoMeta =
      const VerificationMeta('regimeEspecialTributacao');
  GeneratedColumn<String>? _regimeEspecialTributacao;
  @override
  GeneratedColumn<String> get regimeEspecialTributacao => _regimeEspecialTributacao ??=
      GeneratedColumn<String>('REGIME_ESPECIAL_TRIBUTACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorRetidoPisMeta =
      const VerificationMeta('valorRetidoPis');
  GeneratedColumn<double>? _valorRetidoPis;
  @override
  GeneratedColumn<double> get valorRetidoPis => _valorRetidoPis ??=
      GeneratedColumn<double>('VALOR_RETIDO_PIS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorRetidoCofinsMeta =
      const VerificationMeta('valorRetidoCofins');
  GeneratedColumn<double>? _valorRetidoCofins;
  @override
  GeneratedColumn<double> get valorRetidoCofins => _valorRetidoCofins ??=
      GeneratedColumn<double>('VALOR_RETIDO_COFINS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorRetidoCsllMeta =
      const VerificationMeta('valorRetidoCsll');
  GeneratedColumn<double>? _valorRetidoCsll;
  @override
  GeneratedColumn<double> get valorRetidoCsll => _valorRetidoCsll ??=
      GeneratedColumn<double>('VALOR_RETIDO_CSLL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _baseCalculoIrrfMeta =
      const VerificationMeta('baseCalculoIrrf');
  GeneratedColumn<double>? _baseCalculoIrrf;
  @override
  GeneratedColumn<double> get baseCalculoIrrf => _baseCalculoIrrf ??=
      GeneratedColumn<double>('BASE_CALCULO_IRRF', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorRetidoIrrfMeta =
      const VerificationMeta('valorRetidoIrrf');
  GeneratedColumn<double>? _valorRetidoIrrf;
  @override
  GeneratedColumn<double> get valorRetidoIrrf => _valorRetidoIrrf ??=
      GeneratedColumn<double>('VALOR_RETIDO_IRRF', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _baseCalculoPrevidenciaMeta =
      const VerificationMeta('baseCalculoPrevidencia');
  GeneratedColumn<double>? _baseCalculoPrevidencia;
  @override
  GeneratedColumn<double> get baseCalculoPrevidencia => _baseCalculoPrevidencia ??=
      GeneratedColumn<double>('BASE_CALCULO_PREVIDENCIA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorRetidoPrevidenciaMeta =
      const VerificationMeta('valorRetidoPrevidencia');
  GeneratedColumn<double>? _valorRetidoPrevidencia;
  @override
  GeneratedColumn<double> get valorRetidoPrevidencia => _valorRetidoPrevidencia ??=
      GeneratedColumn<double>('VALOR_RETIDO_PREVIDENCIA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _informacoesAddFiscoMeta =
      const VerificationMeta('informacoesAddFisco');
  GeneratedColumn<String>? _informacoesAddFisco;
  @override
  GeneratedColumn<String> get informacoesAddFisco => _informacoesAddFisco ??=
      GeneratedColumn<String>('INFORMACOES_ADD_FISCO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _informacoesAddContribuinteMeta =
      const VerificationMeta('informacoesAddContribuinte');
  GeneratedColumn<String>? _informacoesAddContribuinte;
  @override
  GeneratedColumn<String> get informacoesAddContribuinte => _informacoesAddContribuinte ??=
      GeneratedColumn<String>('INFORMACOES_ADD_CONTRIBUINTE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _comexUfEmbarqueMeta =
      const VerificationMeta('comexUfEmbarque');
  GeneratedColumn<String>? _comexUfEmbarque;
  @override
  GeneratedColumn<String> get comexUfEmbarque => _comexUfEmbarque ??=
      GeneratedColumn<String>('COMEX_UF_EMBARQUE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _comexLocalEmbarqueMeta =
      const VerificationMeta('comexLocalEmbarque');
  GeneratedColumn<String>? _comexLocalEmbarque;
  @override
  GeneratedColumn<String> get comexLocalEmbarque => _comexLocalEmbarque ??=
      GeneratedColumn<String>('COMEX_LOCAL_EMBARQUE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _comexLocalDespachoMeta =
      const VerificationMeta('comexLocalDespacho');
  GeneratedColumn<String>? _comexLocalDespacho;
  @override
  GeneratedColumn<String> get comexLocalDespacho => _comexLocalDespacho ??=
      GeneratedColumn<String>('COMEX_LOCAL_DESPACHO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _compraNotaEmpenhoMeta =
      const VerificationMeta('compraNotaEmpenho');
  GeneratedColumn<String>? _compraNotaEmpenho;
  @override
  GeneratedColumn<String> get compraNotaEmpenho => _compraNotaEmpenho ??=
      GeneratedColumn<String>('COMPRA_NOTA_EMPENHO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _compraPedidoMeta =
      const VerificationMeta('compraPedido');
  GeneratedColumn<String>? _compraPedido;
  @override
  GeneratedColumn<String> get compraPedido => _compraPedido ??=
      GeneratedColumn<String>('COMPRA_PEDIDO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _compraContratoMeta =
      const VerificationMeta('compraContrato');
  GeneratedColumn<String>? _compraContrato;
  @override
  GeneratedColumn<String> get compraContrato => _compraContrato ??=
      GeneratedColumn<String>('COMPRA_CONTRATO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _qrcodeMeta =
      const VerificationMeta('qrcode');
  GeneratedColumn<String>? _qrcode;
  @override
  GeneratedColumn<String> get qrcode => _qrcode ??=
      GeneratedColumn<String>('QRCODE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _urlChaveMeta =
      const VerificationMeta('urlChave');
  GeneratedColumn<String>? _urlChave;
  @override
  GeneratedColumn<String> get urlChave => _urlChave ??=
      GeneratedColumn<String>('URL_CHAVE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _statusNotaMeta =
      const VerificationMeta('statusNota');
  GeneratedColumn<String>? _statusNota;
  @override
  GeneratedColumn<String> get statusNota => _statusNota ??=
      GeneratedColumn<String>('STATUS_NOTA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _idPdvVendaCabecalhoMeta =
      const VerificationMeta('idPdvVendaCabecalho');
  GeneratedColumn<int>? _idPdvVendaCabecalho;
  @override
  GeneratedColumn<int> get idPdvVendaCabecalho =>
      _idPdvVendaCabecalho ??= GeneratedColumn<int>('ID_PDV_VENDA_CABECALHO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PDV_VENDA_CABECALHO(ID)');
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idTributOperacaoFiscal,
        ufEmitente,
        codigoNumerico,
        naturezaOperacao,
        codigoModelo,
        serie,
        numero,
        dataHoraEmissao,
        dataHoraEntradaSaida,
        tipoOperacao,
        localDestino,
        codigoMunicipio,
        formatoImpressaoDanfe,
        tipoEmissao,
        chaveAcesso,
        digitoChaveAcesso,
        ambiente,
        finalidadeEmissao,
        consumidorOperacao,
        consumidorPresenca,
        processoEmissao,
        versaoProcessoEmissao,
        dataEntradaContingencia,
        justificativaContingencia,
        baseCalculoIcms,
        valorIcms,
        valorIcmsDesonerado,
        totalIcmsFcpUfDestino,
        totalIcmsInterestadualUfDestino,
        totalIcmsInterestadualUfRemetente,
        valorTotalFcp,
        baseCalculoIcmsSt,
        valorIcmsSt,
        valorTotalFcpSt,
        valorTotalFcpStRetido,
        valorTotalProdutos,
        valorFrete,
        valorSeguro,
        valorDesconto,
        valorImpostoImportacao,
        valorIpi,
        valorIpiDevolvido,
        valorPis,
        valorCofins,
        valorDespesasAcessorias,
        valorTotal,
        valorTotalTributos,
        valorServicos,
        baseCalculoIssqn,
        valorIssqn,
        valorPisIssqn,
        valorCofinsIssqn,
        dataPrestacaoServico,
        valorDeducaoIssqn,
        outrasRetencoesIssqn,
        descontoIncondicionadoIssqn,
        descontoCondicionadoIssqn,
        totalRetencaoIssqn,
        regimeEspecialTributacao,
        valorRetidoPis,
        valorRetidoCofins,
        valorRetidoCsll,
        baseCalculoIrrf,
        valorRetidoIrrf,
        baseCalculoPrevidencia,
        valorRetidoPrevidencia,
        informacoesAddFisco,
        informacoesAddContribuinte,
        comexUfEmbarque,
        comexLocalEmbarque,
        comexLocalDespacho,
        compraNotaEmpenho,
        compraPedido,
        compraContrato,
        qrcode,
        urlChave,
        statusNota,
        idPdvVendaCabecalho,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_CABECALHO';
  
  @override
  String get actualTableName => 'NFE_CABECALHO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeCabecalho> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_TRIBUT_OPERACAO_FISCAL')) {
        context.handle(_idTributOperacaoFiscalMeta,
            idTributOperacaoFiscal.isAcceptableOrUnknown(data['ID_TRIBUT_OPERACAO_FISCAL']!, _idTributOperacaoFiscalMeta));
    }
    if (data.containsKey('UF_EMITENTE')) {
        context.handle(_ufEmitenteMeta,
            ufEmitente.isAcceptableOrUnknown(data['UF_EMITENTE']!, _ufEmitenteMeta));
    }
    if (data.containsKey('CODIGO_NUMERICO')) {
        context.handle(_codigoNumericoMeta,
            codigoNumerico.isAcceptableOrUnknown(data['CODIGO_NUMERICO']!, _codigoNumericoMeta));
    }
    if (data.containsKey('NATUREZA_OPERACAO')) {
        context.handle(_naturezaOperacaoMeta,
            naturezaOperacao.isAcceptableOrUnknown(data['NATUREZA_OPERACAO']!, _naturezaOperacaoMeta));
    }
    if (data.containsKey('CODIGO_MODELO')) {
        context.handle(_codigoModeloMeta,
            codigoModelo.isAcceptableOrUnknown(data['CODIGO_MODELO']!, _codigoModeloMeta));
    }
    if (data.containsKey('SERIE')) {
        context.handle(_serieMeta,
            serie.isAcceptableOrUnknown(data['SERIE']!, _serieMeta));
    }
    if (data.containsKey('NUMERO')) {
        context.handle(_numeroMeta,
            numero.isAcceptableOrUnknown(data['NUMERO']!, _numeroMeta));
    }
    if (data.containsKey('DATA_HORA_EMISSAO')) {
        context.handle(_dataHoraEmissaoMeta,
            dataHoraEmissao.isAcceptableOrUnknown(data['DATA_HORA_EMISSAO']!, _dataHoraEmissaoMeta));
    }
    if (data.containsKey('DATA_HORA_ENTRADA_SAIDA')) {
        context.handle(_dataHoraEntradaSaidaMeta,
            dataHoraEntradaSaida.isAcceptableOrUnknown(data['DATA_HORA_ENTRADA_SAIDA']!, _dataHoraEntradaSaidaMeta));
    }
    if (data.containsKey('TIPO_OPERACAO')) {
        context.handle(_tipoOperacaoMeta,
            tipoOperacao.isAcceptableOrUnknown(data['TIPO_OPERACAO']!, _tipoOperacaoMeta));
    }
    if (data.containsKey('LOCAL_DESTINO')) {
        context.handle(_localDestinoMeta,
            localDestino.isAcceptableOrUnknown(data['LOCAL_DESTINO']!, _localDestinoMeta));
    }
    if (data.containsKey('CODIGO_MUNICIPIO')) {
        context.handle(_codigoMunicipioMeta,
            codigoMunicipio.isAcceptableOrUnknown(data['CODIGO_MUNICIPIO']!, _codigoMunicipioMeta));
    }
    if (data.containsKey('FORMATO_IMPRESSAO_DANFE')) {
        context.handle(_formatoImpressaoDanfeMeta,
            formatoImpressaoDanfe.isAcceptableOrUnknown(data['FORMATO_IMPRESSAO_DANFE']!, _formatoImpressaoDanfeMeta));
    }
    if (data.containsKey('TIPO_EMISSAO')) {
        context.handle(_tipoEmissaoMeta,
            tipoEmissao.isAcceptableOrUnknown(data['TIPO_EMISSAO']!, _tipoEmissaoMeta));
    }
    if (data.containsKey('CHAVE_ACESSO')) {
        context.handle(_chaveAcessoMeta,
            chaveAcesso.isAcceptableOrUnknown(data['CHAVE_ACESSO']!, _chaveAcessoMeta));
    }
    if (data.containsKey('DIGITO_CHAVE_ACESSO')) {
        context.handle(_digitoChaveAcessoMeta,
            digitoChaveAcesso.isAcceptableOrUnknown(data['DIGITO_CHAVE_ACESSO']!, _digitoChaveAcessoMeta));
    }
    if (data.containsKey('AMBIENTE')) {
        context.handle(_ambienteMeta,
            ambiente.isAcceptableOrUnknown(data['AMBIENTE']!, _ambienteMeta));
    }
    if (data.containsKey('FINALIDADE_EMISSAO')) {
        context.handle(_finalidadeEmissaoMeta,
            finalidadeEmissao.isAcceptableOrUnknown(data['FINALIDADE_EMISSAO']!, _finalidadeEmissaoMeta));
    }
    if (data.containsKey('CONSUMIDOR_OPERACAO')) {
        context.handle(_consumidorOperacaoMeta,
            consumidorOperacao.isAcceptableOrUnknown(data['CONSUMIDOR_OPERACAO']!, _consumidorOperacaoMeta));
    }
    if (data.containsKey('CONSUMIDOR_PRESENCA')) {
        context.handle(_consumidorPresencaMeta,
            consumidorPresenca.isAcceptableOrUnknown(data['CONSUMIDOR_PRESENCA']!, _consumidorPresencaMeta));
    }
    if (data.containsKey('PROCESSO_EMISSAO')) {
        context.handle(_processoEmissaoMeta,
            processoEmissao.isAcceptableOrUnknown(data['PROCESSO_EMISSAO']!, _processoEmissaoMeta));
    }
    if (data.containsKey('VERSAO_PROCESSO_EMISSAO')) {
        context.handle(_versaoProcessoEmissaoMeta,
            versaoProcessoEmissao.isAcceptableOrUnknown(data['VERSAO_PROCESSO_EMISSAO']!, _versaoProcessoEmissaoMeta));
    }
    if (data.containsKey('DATA_ENTRADA_CONTINGENCIA')) {
        context.handle(_dataEntradaContingenciaMeta,
            dataEntradaContingencia.isAcceptableOrUnknown(data['DATA_ENTRADA_CONTINGENCIA']!, _dataEntradaContingenciaMeta));
    }
    if (data.containsKey('JUSTIFICATIVA_CONTINGENCIA')) {
        context.handle(_justificativaContingenciaMeta,
            justificativaContingencia.isAcceptableOrUnknown(data['JUSTIFICATIVA_CONTINGENCIA']!, _justificativaContingenciaMeta));
    }
    if (data.containsKey('BASE_CALCULO_ICMS')) {
        context.handle(_baseCalculoIcmsMeta,
            baseCalculoIcms.isAcceptableOrUnknown(data['BASE_CALCULO_ICMS']!, _baseCalculoIcmsMeta));
    }
    if (data.containsKey('VALOR_ICMS')) {
        context.handle(_valorIcmsMeta,
            valorIcms.isAcceptableOrUnknown(data['VALOR_ICMS']!, _valorIcmsMeta));
    }
    if (data.containsKey('VALOR_ICMS_DESONERADO')) {
        context.handle(_valorIcmsDesoneradoMeta,
            valorIcmsDesonerado.isAcceptableOrUnknown(data['VALOR_ICMS_DESONERADO']!, _valorIcmsDesoneradoMeta));
    }
    if (data.containsKey('TOTAL_ICMS_FCP_UF_DESTINO')) {
        context.handle(_totalIcmsFcpUfDestinoMeta,
            totalIcmsFcpUfDestino.isAcceptableOrUnknown(data['TOTAL_ICMS_FCP_UF_DESTINO']!, _totalIcmsFcpUfDestinoMeta));
    }
    if (data.containsKey('TOTAL_ICMS_INTERESTADUAL_UF_DESTINO')) {
        context.handle(_totalIcmsInterestadualUfDestinoMeta,
            totalIcmsInterestadualUfDestino.isAcceptableOrUnknown(data['TOTAL_ICMS_INTERESTADUAL_UF_DESTINO']!, _totalIcmsInterestadualUfDestinoMeta));
    }
    if (data.containsKey('TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE')) {
        context.handle(_totalIcmsInterestadualUfRemetenteMeta,
            totalIcmsInterestadualUfRemetente.isAcceptableOrUnknown(data['TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE']!, _totalIcmsInterestadualUfRemetenteMeta));
    }
    if (data.containsKey('VALOR_TOTAL_FCP')) {
        context.handle(_valorTotalFcpMeta,
            valorTotalFcp.isAcceptableOrUnknown(data['VALOR_TOTAL_FCP']!, _valorTotalFcpMeta));
    }
    if (data.containsKey('BASE_CALCULO_ICMS_ST')) {
        context.handle(_baseCalculoIcmsStMeta,
            baseCalculoIcmsSt.isAcceptableOrUnknown(data['BASE_CALCULO_ICMS_ST']!, _baseCalculoIcmsStMeta));
    }
    if (data.containsKey('VALOR_ICMS_ST')) {
        context.handle(_valorIcmsStMeta,
            valorIcmsSt.isAcceptableOrUnknown(data['VALOR_ICMS_ST']!, _valorIcmsStMeta));
    }
    if (data.containsKey('VALOR_TOTAL_FCP_ST')) {
        context.handle(_valorTotalFcpStMeta,
            valorTotalFcpSt.isAcceptableOrUnknown(data['VALOR_TOTAL_FCP_ST']!, _valorTotalFcpStMeta));
    }
    if (data.containsKey('VALOR_TOTAL_FCP_ST_RETIDO')) {
        context.handle(_valorTotalFcpStRetidoMeta,
            valorTotalFcpStRetido.isAcceptableOrUnknown(data['VALOR_TOTAL_FCP_ST_RETIDO']!, _valorTotalFcpStRetidoMeta));
    }
    if (data.containsKey('VALOR_TOTAL_PRODUTOS')) {
        context.handle(_valorTotalProdutosMeta,
            valorTotalProdutos.isAcceptableOrUnknown(data['VALOR_TOTAL_PRODUTOS']!, _valorTotalProdutosMeta));
    }
    if (data.containsKey('VALOR_FRETE')) {
        context.handle(_valorFreteMeta,
            valorFrete.isAcceptableOrUnknown(data['VALOR_FRETE']!, _valorFreteMeta));
    }
    if (data.containsKey('VALOR_SEGURO')) {
        context.handle(_valorSeguroMeta,
            valorSeguro.isAcceptableOrUnknown(data['VALOR_SEGURO']!, _valorSeguroMeta));
    }
    if (data.containsKey('VALOR_DESCONTO')) {
        context.handle(_valorDescontoMeta,
            valorDesconto.isAcceptableOrUnknown(data['VALOR_DESCONTO']!, _valorDescontoMeta));
    }
    if (data.containsKey('VALOR_IMPOSTO_IMPORTACAO')) {
        context.handle(_valorImpostoImportacaoMeta,
            valorImpostoImportacao.isAcceptableOrUnknown(data['VALOR_IMPOSTO_IMPORTACAO']!, _valorImpostoImportacaoMeta));
    }
    if (data.containsKey('VALOR_IPI')) {
        context.handle(_valorIpiMeta,
            valorIpi.isAcceptableOrUnknown(data['VALOR_IPI']!, _valorIpiMeta));
    }
    if (data.containsKey('VALOR_IPI_DEVOLVIDO')) {
        context.handle(_valorIpiDevolvidoMeta,
            valorIpiDevolvido.isAcceptableOrUnknown(data['VALOR_IPI_DEVOLVIDO']!, _valorIpiDevolvidoMeta));
    }
    if (data.containsKey('VALOR_PIS')) {
        context.handle(_valorPisMeta,
            valorPis.isAcceptableOrUnknown(data['VALOR_PIS']!, _valorPisMeta));
    }
    if (data.containsKey('VALOR_COFINS')) {
        context.handle(_valorCofinsMeta,
            valorCofins.isAcceptableOrUnknown(data['VALOR_COFINS']!, _valorCofinsMeta));
    }
    if (data.containsKey('VALOR_DESPESAS_ACESSORIAS')) {
        context.handle(_valorDespesasAcessoriasMeta,
            valorDespesasAcessorias.isAcceptableOrUnknown(data['VALOR_DESPESAS_ACESSORIAS']!, _valorDespesasAcessoriasMeta));
    }
    if (data.containsKey('VALOR_TOTAL')) {
        context.handle(_valorTotalMeta,
            valorTotal.isAcceptableOrUnknown(data['VALOR_TOTAL']!, _valorTotalMeta));
    }
    if (data.containsKey('VALOR_TOTAL_TRIBUTOS')) {
        context.handle(_valorTotalTributosMeta,
            valorTotalTributos.isAcceptableOrUnknown(data['VALOR_TOTAL_TRIBUTOS']!, _valorTotalTributosMeta));
    }
    if (data.containsKey('VALOR_SERVICOS')) {
        context.handle(_valorServicosMeta,
            valorServicos.isAcceptableOrUnknown(data['VALOR_SERVICOS']!, _valorServicosMeta));
    }
    if (data.containsKey('BASE_CALCULO_ISSQN')) {
        context.handle(_baseCalculoIssqnMeta,
            baseCalculoIssqn.isAcceptableOrUnknown(data['BASE_CALCULO_ISSQN']!, _baseCalculoIssqnMeta));
    }
    if (data.containsKey('VALOR_ISSQN')) {
        context.handle(_valorIssqnMeta,
            valorIssqn.isAcceptableOrUnknown(data['VALOR_ISSQN']!, _valorIssqnMeta));
    }
    if (data.containsKey('VALOR_PIS_ISSQN')) {
        context.handle(_valorPisIssqnMeta,
            valorPisIssqn.isAcceptableOrUnknown(data['VALOR_PIS_ISSQN']!, _valorPisIssqnMeta));
    }
    if (data.containsKey('VALOR_COFINS_ISSQN')) {
        context.handle(_valorCofinsIssqnMeta,
            valorCofinsIssqn.isAcceptableOrUnknown(data['VALOR_COFINS_ISSQN']!, _valorCofinsIssqnMeta));
    }
    if (data.containsKey('DATA_PRESTACAO_SERVICO')) {
        context.handle(_dataPrestacaoServicoMeta,
            dataPrestacaoServico.isAcceptableOrUnknown(data['DATA_PRESTACAO_SERVICO']!, _dataPrestacaoServicoMeta));
    }
    if (data.containsKey('VALOR_DEDUCAO_ISSQN')) {
        context.handle(_valorDeducaoIssqnMeta,
            valorDeducaoIssqn.isAcceptableOrUnknown(data['VALOR_DEDUCAO_ISSQN']!, _valorDeducaoIssqnMeta));
    }
    if (data.containsKey('OUTRAS_RETENCOES_ISSQN')) {
        context.handle(_outrasRetencoesIssqnMeta,
            outrasRetencoesIssqn.isAcceptableOrUnknown(data['OUTRAS_RETENCOES_ISSQN']!, _outrasRetencoesIssqnMeta));
    }
    if (data.containsKey('DESCONTO_INCONDICIONADO_ISSQN')) {
        context.handle(_descontoIncondicionadoIssqnMeta,
            descontoIncondicionadoIssqn.isAcceptableOrUnknown(data['DESCONTO_INCONDICIONADO_ISSQN']!, _descontoIncondicionadoIssqnMeta));
    }
    if (data.containsKey('DESCONTO_CONDICIONADO_ISSQN')) {
        context.handle(_descontoCondicionadoIssqnMeta,
            descontoCondicionadoIssqn.isAcceptableOrUnknown(data['DESCONTO_CONDICIONADO_ISSQN']!, _descontoCondicionadoIssqnMeta));
    }
    if (data.containsKey('TOTAL_RETENCAO_ISSQN')) {
        context.handle(_totalRetencaoIssqnMeta,
            totalRetencaoIssqn.isAcceptableOrUnknown(data['TOTAL_RETENCAO_ISSQN']!, _totalRetencaoIssqnMeta));
    }
    if (data.containsKey('REGIME_ESPECIAL_TRIBUTACAO')) {
        context.handle(_regimeEspecialTributacaoMeta,
            regimeEspecialTributacao.isAcceptableOrUnknown(data['REGIME_ESPECIAL_TRIBUTACAO']!, _regimeEspecialTributacaoMeta));
    }
    if (data.containsKey('VALOR_RETIDO_PIS')) {
        context.handle(_valorRetidoPisMeta,
            valorRetidoPis.isAcceptableOrUnknown(data['VALOR_RETIDO_PIS']!, _valorRetidoPisMeta));
    }
    if (data.containsKey('VALOR_RETIDO_COFINS')) {
        context.handle(_valorRetidoCofinsMeta,
            valorRetidoCofins.isAcceptableOrUnknown(data['VALOR_RETIDO_COFINS']!, _valorRetidoCofinsMeta));
    }
    if (data.containsKey('VALOR_RETIDO_CSLL')) {
        context.handle(_valorRetidoCsllMeta,
            valorRetidoCsll.isAcceptableOrUnknown(data['VALOR_RETIDO_CSLL']!, _valorRetidoCsllMeta));
    }
    if (data.containsKey('BASE_CALCULO_IRRF')) {
        context.handle(_baseCalculoIrrfMeta,
            baseCalculoIrrf.isAcceptableOrUnknown(data['BASE_CALCULO_IRRF']!, _baseCalculoIrrfMeta));
    }
    if (data.containsKey('VALOR_RETIDO_IRRF')) {
        context.handle(_valorRetidoIrrfMeta,
            valorRetidoIrrf.isAcceptableOrUnknown(data['VALOR_RETIDO_IRRF']!, _valorRetidoIrrfMeta));
    }
    if (data.containsKey('BASE_CALCULO_PREVIDENCIA')) {
        context.handle(_baseCalculoPrevidenciaMeta,
            baseCalculoPrevidencia.isAcceptableOrUnknown(data['BASE_CALCULO_PREVIDENCIA']!, _baseCalculoPrevidenciaMeta));
    }
    if (data.containsKey('VALOR_RETIDO_PREVIDENCIA')) {
        context.handle(_valorRetidoPrevidenciaMeta,
            valorRetidoPrevidencia.isAcceptableOrUnknown(data['VALOR_RETIDO_PREVIDENCIA']!, _valorRetidoPrevidenciaMeta));
    }
    if (data.containsKey('INFORMACOES_ADD_FISCO')) {
        context.handle(_informacoesAddFiscoMeta,
            informacoesAddFisco.isAcceptableOrUnknown(data['INFORMACOES_ADD_FISCO']!, _informacoesAddFiscoMeta));
    }
    if (data.containsKey('INFORMACOES_ADD_CONTRIBUINTE')) {
        context.handle(_informacoesAddContribuinteMeta,
            informacoesAddContribuinte.isAcceptableOrUnknown(data['INFORMACOES_ADD_CONTRIBUINTE']!, _informacoesAddContribuinteMeta));
    }
    if (data.containsKey('COMEX_UF_EMBARQUE')) {
        context.handle(_comexUfEmbarqueMeta,
            comexUfEmbarque.isAcceptableOrUnknown(data['COMEX_UF_EMBARQUE']!, _comexUfEmbarqueMeta));
    }
    if (data.containsKey('COMEX_LOCAL_EMBARQUE')) {
        context.handle(_comexLocalEmbarqueMeta,
            comexLocalEmbarque.isAcceptableOrUnknown(data['COMEX_LOCAL_EMBARQUE']!, _comexLocalEmbarqueMeta));
    }
    if (data.containsKey('COMEX_LOCAL_DESPACHO')) {
        context.handle(_comexLocalDespachoMeta,
            comexLocalDespacho.isAcceptableOrUnknown(data['COMEX_LOCAL_DESPACHO']!, _comexLocalDespachoMeta));
    }
    if (data.containsKey('COMPRA_NOTA_EMPENHO')) {
        context.handle(_compraNotaEmpenhoMeta,
            compraNotaEmpenho.isAcceptableOrUnknown(data['COMPRA_NOTA_EMPENHO']!, _compraNotaEmpenhoMeta));
    }
    if (data.containsKey('COMPRA_PEDIDO')) {
        context.handle(_compraPedidoMeta,
            compraPedido.isAcceptableOrUnknown(data['COMPRA_PEDIDO']!, _compraPedidoMeta));
    }
    if (data.containsKey('COMPRA_CONTRATO')) {
        context.handle(_compraContratoMeta,
            compraContrato.isAcceptableOrUnknown(data['COMPRA_CONTRATO']!, _compraContratoMeta));
    }
    if (data.containsKey('QRCODE')) {
        context.handle(_qrcodeMeta,
            qrcode.isAcceptableOrUnknown(data['QRCODE']!, _qrcodeMeta));
    }
    if (data.containsKey('URL_CHAVE')) {
        context.handle(_urlChaveMeta,
            urlChave.isAcceptableOrUnknown(data['URL_CHAVE']!, _urlChaveMeta));
    }
    if (data.containsKey('STATUS_NOTA')) {
        context.handle(_statusNotaMeta,
            statusNota.isAcceptableOrUnknown(data['STATUS_NOTA']!, _statusNotaMeta));
    }
    if (data.containsKey('ID_PDV_VENDA_CABECALHO')) {
        context.handle(_idPdvVendaCabecalhoMeta,
            idPdvVendaCabecalho.isAcceptableOrUnknown(data['ID_PDV_VENDA_CABECALHO']!, _idPdvVendaCabecalhoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeCabecalho map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeCabecalho.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeCabecalhosTable createAlias(String alias) {
    return $NfeCabecalhosTable(_db, alias);
  }
}