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

import '../database.dart';
import '../database_classes.dart';

@DataClassName("NfeCabecalho")
class NfeCabecalhos extends Table {
  @override
  String get tableName => 'NFE_CABECALHO';

  IntColumn? get id => integer().named('ID').autoIncrement()();
  IntColumn? get idTributOperacaoFiscal => integer().named('ID_TRIBUT_OPERACAO_FISCAL').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_OPERACAO_FISCAL(ID)')() as Column<int>?;
  IntColumn? get idPdvVendaCabecalho => integer().named('ID_PDV_VENDA_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES PDV_VENDA_CABECALHO(ID)')() as Column<int>?;
  IntColumn? get ufEmitente => integer().named('UF_EMITENTE').nullable()() as Column<int>?;
  TextColumn? get codigoNumerico => text().named('CODIGO_NUMERICO').withLength(min: 0, max: 8).nullable()() as Column<String>?;
  TextColumn? get naturezaOperacao => text().named('NATUREZA_OPERACAO').withLength(min: 0, max: 60).nullable()() as Column<String>?;
  TextColumn? get codigoModelo => text().named('CODIGO_MODELO').withLength(min: 0, max: 2).nullable()() as Column<String>?;
  TextColumn? get serie => text().named('SERIE').withLength(min: 0, max: 3).nullable()() as Column<String>?;
  TextColumn? get numero => text().named('NUMERO').withLength(min: 0, max: 9).nullable()() as Column<String>?;
  DateTimeColumn? get dataHoraEmissao => dateTime().named('DATA_HORA_EMISSAO').nullable()() as Column<DateTime>?;
  DateTimeColumn? get dataHoraEntradaSaida => dateTime().named('DATA_HORA_ENTRADA_SAIDA').nullable()() as Column<DateTime>?;
  TextColumn? get tipoOperacao => text().named('TIPO_OPERACAO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get localDestino => text().named('LOCAL_DESTINO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  IntColumn? get codigoMunicipio => integer().named('CODIGO_MUNICIPIO').nullable()() as Column<int>?;
  TextColumn? get formatoImpressaoDanfe => text().named('FORMATO_IMPRESSAO_DANFE').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get tipoEmissao => text().named('TIPO_EMISSAO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get chaveAcesso => text().named('CHAVE_ACESSO').withLength(min: 0, max: 44).nullable()() as Column<String>?;
  TextColumn? get digitoChaveAcesso => text().named('DIGITO_CHAVE_ACESSO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get ambiente => text().named('AMBIENTE').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get finalidadeEmissao => text().named('FINALIDADE_EMISSAO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get consumidorOperacao => text().named('CONSUMIDOR_OPERACAO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get consumidorPresenca => text().named('CONSUMIDOR_PRESENCA').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get processoEmissao => text().named('PROCESSO_EMISSAO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  TextColumn? get versaoProcessoEmissao => text().named('VERSAO_PROCESSO_EMISSAO').withLength(min: 0, max: 20).nullable()() as Column<String>?;
  DateTimeColumn? get dataEntradaContingencia => dateTime().named('DATA_ENTRADA_CONTINGENCIA').nullable()() as Column<DateTime>?;
  TextColumn? get justificativaContingencia => text().named('JUSTIFICATIVA_CONTINGENCIA').withLength(min: 0, max: 255).nullable()() as Column<String>?;
  RealColumn? get baseCalculoIcms => real().named('BASE_CALCULO_ICMS').nullable()() as Column<double>?;
  RealColumn? get valorIcms => real().named('VALOR_ICMS').nullable()() as Column<double>?;
  RealColumn? get valorIcmsDesonerado => real().named('VALOR_ICMS_DESONERADO').nullable()() as Column<double>?;
  RealColumn? get totalIcmsFcpUfDestino => real().named('TOTAL_ICMS_FCP_UF_DESTINO').nullable()() as Column<double>?;
  RealColumn? get totalIcmsInterestadualUfDestino => real().named('TOTAL_ICMS_INTERESTADUAL_UF_DESTINO').nullable()() as Column<double>?;
  RealColumn? get totalIcmsInterestadualUfRemetente => real().named('TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE').nullable()() as Column<double>?;
  RealColumn? get valorTotalFcp => real().named('VALOR_TOTAL_FCP').nullable()() as Column<double>?;
  RealColumn? get baseCalculoIcmsSt => real().named('BASE_CALCULO_ICMS_ST').nullable()() as Column<double>?;
  RealColumn? get valorIcmsSt => real().named('VALOR_ICMS_ST').nullable()() as Column<double>?;
  RealColumn? get valorTotalFcpSt => real().named('VALOR_TOTAL_FCP_ST').nullable()() as Column<double>?;
  RealColumn? get valorTotalFcpStRetido => real().named('VALOR_TOTAL_FCP_ST_RETIDO').nullable()() as Column<double>?;
  RealColumn? get valorTotalProdutos => real().named('VALOR_TOTAL_PRODUTOS').nullable()() as Column<double>?; // soma do valor dos itens - VALOR_VENDA da tabela PDV_VENDA_CABECALHO
  RealColumn? get valorFrete => real().named('VALOR_FRETE').nullable()() as Column<double>?;
  RealColumn? get valorSeguro => real().named('VALOR_SEGURO').nullable()() as Column<double>?;
  RealColumn? get valorDesconto => real().named('VALOR_DESCONTO').nullable()() as Column<double>?;
  RealColumn? get valorImpostoImportacao => real().named('VALOR_IMPOSTO_IMPORTACAO').nullable()() as Column<double>?;
  RealColumn? get valorIpi => real().named('VALOR_IPI').nullable()() as Column<double>?;
  RealColumn? get valorIpiDevolvido => real().named('VALOR_IPI_DEVOLVIDO').nullable()() as Column<double>?;
  RealColumn? get valorPis => real().named('VALOR_PIS').nullable()() as Column<double>?;
  RealColumn? get valorCofins => real().named('VALOR_COFINS').nullable()() as Column<double>?;
  RealColumn? get valorDespesasAcessorias => real().named('VALOR_DESPESAS_ACESSORIAS').nullable()() as Column<double>?;
  RealColumn? get valorTotal => real().named('VALOR_TOTAL').nullable()() as Column<double>?; // soma do valor dos itens menos o desconto - VALOR_FINAL da tabela PDV_VENDA_CABECALHO
  RealColumn? get valorTotalTributos => real().named('VALOR_TOTAL_TRIBUTOS').nullable()() as Column<double>?; // IBPT
  RealColumn? get valorServicos => real().named('VALOR_SERVICOS').nullable()() as Column<double>?;
  RealColumn? get baseCalculoIssqn => real().named('BASE_CALCULO_ISSQN').nullable()() as Column<double>?;
  RealColumn? get valorIssqn => real().named('VALOR_ISSQN').nullable()() as Column<double>?;
  RealColumn? get valorPisIssqn => real().named('VALOR_PIS_ISSQN').nullable()() as Column<double>?;
  RealColumn? get valorCofinsIssqn => real().named('VALOR_COFINS_ISSQN').nullable()() as Column<double>?;
  DateTimeColumn? get dataPrestacaoServico => dateTime().named('DATA_PRESTACAO_SERVICO').nullable()() as Column<DateTime>?;
  RealColumn? get valorDeducaoIssqn => real().named('VALOR_DEDUCAO_ISSQN').nullable()() as Column<double>?;
  RealColumn? get outrasRetencoesIssqn => real().named('OUTRAS_RETENCOES_ISSQN').nullable()() as Column<double>?;
  RealColumn? get descontoIncondicionadoIssqn => real().named('DESCONTO_INCONDICIONADO_ISSQN').nullable()() as Column<double>?;
  RealColumn? get descontoCondicionadoIssqn => real().named('DESCONTO_CONDICIONADO_ISSQN').nullable()() as Column<double>?;
  RealColumn? get totalRetencaoIssqn => real().named('TOTAL_RETENCAO_ISSQN').nullable()() as Column<double>?;
  TextColumn? get regimeEspecialTributacao => text().named('REGIME_ESPECIAL_TRIBUTACAO').withLength(min: 0, max: 1).nullable()() as Column<String>?;
  RealColumn? get valorRetidoPis => real().named('VALOR_RETIDO_PIS').nullable()() as Column<double>?;
  RealColumn? get valorRetidoCofins => real().named('VALOR_RETIDO_COFINS').nullable()() as Column<double>?;
  RealColumn? get valorRetidoCsll => real().named('VALOR_RETIDO_CSLL').nullable()() as Column<double>?;
  RealColumn? get baseCalculoIrrf => real().named('BASE_CALCULO_IRRF').nullable()() as Column<double>?;
  RealColumn? get valorRetidoIrrf => real().named('VALOR_RETIDO_IRRF').nullable()() as Column<double>?;
  RealColumn? get baseCalculoPrevidencia => real().named('BASE_CALCULO_PREVIDENCIA').nullable()() as Column<double>?;
  RealColumn? get valorRetidoPrevidencia => real().named('VALOR_RETIDO_PREVIDENCIA').nullable()() as Column<double>?;
  TextColumn? get informacoesAddFisco => text().named('INFORMACOES_ADD_FISCO').withLength(min: 0, max: 250).nullable()() as Column<String>?;
  TextColumn? get informacoesAddContribuinte => text().named('INFORMACOES_ADD_CONTRIBUINTE').withLength(min: 0, max: 250).nullable()() as Column<String>?;
  TextColumn? get comexUfEmbarque => text().named('COMEX_UF_EMBARQUE').withLength(min: 0, max: 2).nullable()() as Column<String>?;
  TextColumn? get comexLocalEmbarque => text().named('COMEX_LOCAL_EMBARQUE').withLength(min: 0, max: 60).nullable()() as Column<String>?;
  TextColumn? get comexLocalDespacho => text().named('COMEX_LOCAL_DESPACHO').withLength(min: 0, max: 60).nullable()() as Column<String>?;
  TextColumn? get compraNotaEmpenho => text().named('COMPRA_NOTA_EMPENHO').withLength(min: 0, max: 22).nullable()() as Column<String>?;
  TextColumn? get compraPedido => text().named('COMPRA_PEDIDO').withLength(min: 0, max: 60).nullable()() as Column<String>?;
  TextColumn? get compraContrato => text().named('COMPRA_CONTRATO').withLength(min: 0, max: 60).nullable()() as Column<String>?;
  TextColumn? get qrcode => text().named('QRCODE').withLength(min: 0, max: 250).nullable()() as Column<String>?;
  TextColumn? get urlChave => text().named('URL_CHAVE').withLength(min: 0, max: 85).nullable()() as Column<String>?;
  TextColumn? get statusNota => text().named('STATUS_NOTA').withLength(min: 0, max: 1).nullable()() as Column<String>?; //"0-Em Edição"-"1-Salva"-"2-Validada"-"3-Assinada"-"4-Autorizada"-"5-Cancelada"-"6-Contingencia"-"8-Inutilizada"-"9-OffLine"
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