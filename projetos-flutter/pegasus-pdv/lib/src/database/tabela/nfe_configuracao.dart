/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_CONFIGURACAO] 
                                                                                
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

@DataClassName("NfeConfiguracao")
@UseRowClass(NfeConfiguracao)
class NfeConfiguracaos extends Table {
  @override
  String get tableName => 'NFE_CONFIGURACAO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get certificadoDigitalSerie => text().named('CERTIFICADO_DIGITAL_SERIE').withLength(min: 0, max: 100).nullable()();
  TextColumn get certificadoDigitalCaminho => text().named('CERTIFICADO_DIGITAL_CAMINHO').withLength(min: 0, max: 250).nullable()();
  TextColumn get certificadoDigitalSenha => text().named('CERTIFICADO_DIGITAL_SENHA').withLength(min: 0, max: 100).nullable()();
  IntColumn get tipoEmissao => integer().named('TIPO_EMISSAO').nullable()();//tpEmis
  IntColumn get formatoImpressaoDanfe => integer().named('FORMATO_IMPRESSAO_DANFE').nullable()();//4=DANFE NFC-e; 5=DANFE NFC-e em mensagem eletrônica
  IntColumn get processoEmissao => integer().named('PROCESSO_EMISSAO').nullable()();
  TextColumn get versaoProcessoEmissao => text().named('VERSAO_PROCESSO_EMISSAO').withLength(min: 0, max: 20).nullable()();
  TextColumn get caminhoLogomarca => text().named('CAMINHO_LOGOMARCA').withLength(min: 0, max: 250).nullable()();
  TextColumn get salvarXml => text().named('SALVAR_XML').withLength(min: 0, max: 1).nullable()();
  TextColumn get caminhoSalvarXml => text().named('CAMINHO_SALVAR_XML').withLength(min: 0, max: 250).nullable()();// caminho onde o XML inicial criado pelo monitor foi salvo no servidor
  TextColumn get caminhoSchemas => text().named('CAMINHO_SCHEMAS').withLength(min: 0, max: 250).nullable()();
  TextColumn get caminhoArquivoDanfe => text().named('CAMINHO_ARQUIVO_DANFE').withLength(min: 0, max: 250).nullable()();
  TextColumn get caminhoSalvarPdf => text().named('CAMINHO_SALVAR_PDF').withLength(min: 0, max: 250).nullable()(); // caminho onde o PDF do DANFE foi salvo no servidor
  TextColumn get webserviceUf => text().named('WEBSERVICE_UF').withLength(min: 0, max: 2).nullable()();
  IntColumn get webserviceAmbiente => integer().named('WEBSERVICE_AMBIENTE').nullable()();//tpAmb - 1-Produção/ 2-Homologação
  TextColumn get webserviceProxyHost => text().named('WEBSERVICE_PROXY_HOST').withLength(min: 0, max: 100).nullable()();
  IntColumn get webserviceProxyPorta => integer().named('WEBSERVICE_PROXY_PORTA').nullable()();
  TextColumn get webserviceProxyUsuario => text().named('WEBSERVICE_PROXY_USUARIO').withLength(min: 0, max: 100).nullable()();
  TextColumn get webserviceProxySenha => text().named('WEBSERVICE_PROXY_SENHA').withLength(min: 0, max: 100).nullable()();
  TextColumn get webserviceVisualizar => text().named('WEBSERVICE_VISUALIZAR').withLength(min: 0, max: 1).nullable()();
  TextColumn get emailServidorSmtp => text().named('EMAIL_SERVIDOR_SMTP').withLength(min: 0, max: 100).nullable()();
  IntColumn get emailPorta => integer().named('EMAIL_PORTA').nullable()();
  TextColumn get emailUsuario => text().named('EMAIL_USUARIO').withLength(min: 0, max: 100).nullable()();
  TextColumn get emailSenha => text().named('EMAIL_SENHA').withLength(min: 0, max: 100).nullable()();
  TextColumn get emailAssunto => text().named('EMAIL_ASSUNTO').withLength(min: 0, max: 100).nullable()();
  TextColumn get emailAutenticaSsl => text().named('EMAIL_AUTENTICA_SSL').withLength(min: 0, max: 1).nullable()();
  TextColumn get emailTexto => text().named('EMAIL_TEXTO').withLength(min: 0, max: 250).nullable()();
  TextColumn get nfceIdCsc => text().named('NFCE_ID_CSC').withLength(min: 0, max: 6).nullable()();
  TextColumn get nfceCsc => text().named('NFCE_CSC').withLength(min: 0, max: 250).nullable()();
  TextColumn get nfceModeloImpressao => text().named('NFCE_MODELO_IMPRESSAO').withLength(min: 0, max: 2).nullable()();// A4 57 80
  TextColumn get nfceImprimirItensUmaLinha => text().named('NFCE_IMPRIMIR_ITENS_UMA_LINHA').withLength(min: 0, max: 1).nullable()();//S N
  TextColumn get nfceImprimirDescontoPorItem => text().named('NFCE_IMPRIMIR_DESCONTO_POR_ITEM').withLength(min: 0, max: 1).nullable()();//S N
  TextColumn get nfceImprimirQrcodeLateral => text().named('NFCE_IMPRIMIR_QRCODE_LATERAL').withLength(min: 0, max: 1).nullable()();//S N
  TextColumn get nfceImprimirGtin => text().named('NFCE_IMPRIMIR_GTIN').withLength(min: 0, max: 1).nullable()();//S N
  TextColumn get nfceImprimirNomeFantasia => text().named('NFCE_IMPRIMIR_NOME_FANTASIA').withLength(min: 0, max: 1).nullable()();//S N
  TextColumn get nfceImpressaoTributos => text().named('NFCE_IMPRESSAO_TRIBUTOS').withLength(min: 0, max: 1).nullable()(); //Normal Separado
  RealColumn get nfceMargemSuperior => real().named('NFCE_MARGEM_SUPERIOR').nullable()();
  RealColumn get nfceMargemInferior => real().named('NFCE_MARGEM_INFERIOR').nullable()();
  RealColumn get nfceMargemDireita => real().named('NFCE_MARGEM_DIREITA').nullable()();
  RealColumn get nfceMargemEsquerda => real().named('NFCE_MARGEM_ESQUERDA').nullable()();
  IntColumn get nfceResolucaoImpressao => integer().named('NFCE_RESOLUCAO_IMPRESSAO').nullable()();//largura da impressão no ACBrMonitor 302=80col 200=57col
  TextColumn get respTecCnpj => text().named('RESP_TEC_CNPJ').withLength(min: 0, max: 14).nullable()();
  TextColumn get respTecContato => text().named('RESP_TEC_CONTATO').withLength(min: 0, max: 60).nullable()();
  TextColumn get respTecEmail => text().named('RESP_TEC_EMAIL').withLength(min: 0, max: 60).nullable()();
  TextColumn get respTecFone => text().named('RESP_TEC_FONE').withLength(min: 0, max: 15).nullable()();
  TextColumn get respTecIdCsrt => text().named('RESP_TEC_ID_CSRT').withLength(min: 0, max: 2).nullable()();
  TextColumn get respTecHashCsrt => text().named('RESP_TEC_HASH_CSRT').withLength(min: 0, max: 28).nullable()();
  IntColumn get nfceTamanhoFonteItem => integer().named('NFCE_TAMANHO_FONTE_ITEM').nullable()();
}

class NfeConfiguracao extends DataClass implements Insertable<NfeConfiguracao> {
  final int? id;
  final String? certificadoDigitalSerie;
  final String? certificadoDigitalCaminho;
  final String? certificadoDigitalSenha;
  final int? tipoEmissao;
  final int? formatoImpressaoDanfe;
  final int? processoEmissao;
  final String? versaoProcessoEmissao;
  final String? caminhoLogomarca;
  final String? salvarXml;
  final String? caminhoSalvarXml;
  final String? caminhoSchemas;
  final String? caminhoArquivoDanfe;
  final String? caminhoSalvarPdf;
  final String? webserviceUf;
  final int? webserviceAmbiente;
  final String? webserviceProxyHost;
  final int? webserviceProxyPorta;
  final String? webserviceProxyUsuario;
  final String? webserviceProxySenha;
  final String? webserviceVisualizar;
  final String? emailServidorSmtp;
  final int? emailPorta;
  final String? emailUsuario;
  final String? emailSenha;
  final String? emailAssunto;
  final String? emailAutenticaSsl;
  final String? emailTexto;
  final String? nfceIdCsc;
  final String? nfceCsc;
  final String? nfceModeloImpressao;
  final String? nfceImprimirItensUmaLinha;
  final String? nfceImprimirDescontoPorItem;
  final String? nfceImprimirQrcodeLateral;
  final String? nfceImprimirGtin;
  final String? nfceImprimirNomeFantasia;
  final String? nfceImpressaoTributos;
  final double? nfceMargemSuperior;
  final double? nfceMargemInferior;
  final double? nfceMargemDireita;
  final double? nfceMargemEsquerda;
  final int? nfceResolucaoImpressao;
  final String? respTecCnpj;
  final String? respTecContato;
  final String? respTecEmail;
  final String? respTecFone;
  final String? respTecIdCsrt;
  final String? respTecHashCsrt;
  final int? nfceTamanhoFonteItem;

  NfeConfiguracao(
    {
      required this.id,
      this.certificadoDigitalSerie,
      this.certificadoDigitalCaminho,
      this.certificadoDigitalSenha,
      this.tipoEmissao,
      this.formatoImpressaoDanfe,
      this.processoEmissao,
      this.versaoProcessoEmissao,
      this.caminhoLogomarca,
      this.salvarXml,
      this.caminhoSalvarXml,
      this.caminhoSchemas,
      this.caminhoArquivoDanfe,
      this.caminhoSalvarPdf,
      this.webserviceUf,
      this.webserviceAmbiente,
      this.webserviceProxyHost,
      this.webserviceProxyPorta,
      this.webserviceProxyUsuario,
      this.webserviceProxySenha,
      this.webserviceVisualizar,
      this.emailServidorSmtp,
      this.emailPorta,
      this.emailUsuario,
      this.emailSenha,
      this.emailAssunto,
      this.emailAutenticaSsl,
      this.emailTexto,
      this.nfceIdCsc,
      this.nfceCsc,
      this.nfceModeloImpressao,
      this.nfceImprimirItensUmaLinha,
      this.nfceImprimirDescontoPorItem,
      this.nfceImprimirQrcodeLateral,
      this.nfceImprimirGtin,
      this.nfceImprimirNomeFantasia,
      this.nfceImpressaoTributos,
      this.nfceMargemSuperior,
      this.nfceMargemInferior,
      this.nfceMargemDireita,
      this.nfceMargemEsquerda,
      this.nfceResolucaoImpressao,
      this.respTecCnpj,
      this.respTecContato,
      this.respTecEmail,
      this.respTecFone,
      this.respTecIdCsrt,
      this.respTecHashCsrt,
      this.nfceTamanhoFonteItem,
    }
  );

  factory NfeConfiguracao.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeConfiguracao(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      certificadoDigitalSerie: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CERTIFICADO_DIGITAL_SERIE']),
      certificadoDigitalCaminho: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CERTIFICADO_DIGITAL_CAMINHO']),
      certificadoDigitalSenha: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CERTIFICADO_DIGITAL_SENHA']),
      tipoEmissao: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_EMISSAO']),
      formatoImpressaoDanfe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}FORMATO_IMPRESSAO_DANFE']),
      processoEmissao: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}PROCESSO_EMISSAO']),
      versaoProcessoEmissao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}VERSAO_PROCESSO_EMISSAO']),
      caminhoLogomarca: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CAMINHO_LOGOMARCA']),
      salvarXml: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SALVAR_XML']),
      caminhoSalvarXml: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CAMINHO_SALVAR_XML']),
      caminhoSchemas: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CAMINHO_SCHEMAS']),
      caminhoArquivoDanfe: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CAMINHO_ARQUIVO_DANFE']),
      caminhoSalvarPdf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CAMINHO_SALVAR_PDF']),
      webserviceUf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}WEBSERVICE_UF']),
      webserviceAmbiente: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}WEBSERVICE_AMBIENTE']),
      webserviceProxyHost: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}WEBSERVICE_PROXY_HOST']),
      webserviceProxyPorta: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}WEBSERVICE_PROXY_PORTA']),
      webserviceProxyUsuario: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}WEBSERVICE_PROXY_USUARIO']),
      webserviceProxySenha: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}WEBSERVICE_PROXY_SENHA']),
      webserviceVisualizar: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}WEBSERVICE_VISUALIZAR']),
      emailServidorSmtp: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL_SERVIDOR_SMTP']),
      emailPorta: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL_PORTA']),
      emailUsuario: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL_USUARIO']),
      emailSenha: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL_SENHA']),
      emailAssunto: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL_ASSUNTO']),
      emailAutenticaSsl: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL_AUTENTICA_SSL']),
      emailTexto: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL_TEXTO']),
      nfceIdCsc: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_ID_CSC']),
      nfceCsc: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_CSC']),
      nfceModeloImpressao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_MODELO_IMPRESSAO']),
      nfceImprimirItensUmaLinha: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_IMPRIMIR_ITENS_UMA_LINHA']),
      nfceImprimirDescontoPorItem: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_IMPRIMIR_DESCONTO_POR_ITEM']),
      nfceImprimirQrcodeLateral: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_IMPRIMIR_QRCODE_LATERAL']),
      nfceImprimirGtin: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_IMPRIMIR_GTIN']),
      nfceImprimirNomeFantasia: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_IMPRIMIR_NOME_FANTASIA']),
      nfceImpressaoTributos: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_IMPRESSAO_TRIBUTOS']),
      nfceMargemSuperior: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_MARGEM_SUPERIOR']),
      nfceMargemInferior: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_MARGEM_INFERIOR']),
      nfceMargemDireita: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_MARGEM_DIREITA']),
      nfceMargemEsquerda: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_MARGEM_ESQUERDA']),
      nfceResolucaoImpressao: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_RESOLUCAO_IMPRESSAO']),
      respTecCnpj: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RESP_TEC_CNPJ']),
      respTecContato: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RESP_TEC_CONTATO']),
      respTecEmail: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RESP_TEC_EMAIL']),
      respTecFone: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RESP_TEC_FONE']),
      respTecIdCsrt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RESP_TEC_ID_CSRT']),
      respTecHashCsrt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RESP_TEC_HASH_CSRT']),
      nfceTamanhoFonteItem: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NFCE_TAMANHO_FONTE_ITEM']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || certificadoDigitalSerie != null) {
      map['CERTIFICADO_DIGITAL_SERIE'] = Variable<String?>(certificadoDigitalSerie);
    }
    if (!nullToAbsent || certificadoDigitalCaminho != null) {
      map['CERTIFICADO_DIGITAL_CAMINHO'] = Variable<String?>(certificadoDigitalCaminho);
    }
    if (!nullToAbsent || certificadoDigitalSenha != null) {
      map['CERTIFICADO_DIGITAL_SENHA'] = Variable<String?>(certificadoDigitalSenha);
    }
    if (!nullToAbsent || tipoEmissao != null) {
      map['TIPO_EMISSAO'] = Variable<int?>(tipoEmissao);
    }
    if (!nullToAbsent || formatoImpressaoDanfe != null) {
      map['FORMATO_IMPRESSAO_DANFE'] = Variable<int?>(formatoImpressaoDanfe);
    }
    if (!nullToAbsent || processoEmissao != null) {
      map['PROCESSO_EMISSAO'] = Variable<int?>(processoEmissao);
    }
    if (!nullToAbsent || versaoProcessoEmissao != null) {
      map['VERSAO_PROCESSO_EMISSAO'] = Variable<String?>(versaoProcessoEmissao);
    }
    if (!nullToAbsent || caminhoLogomarca != null) {
      map['CAMINHO_LOGOMARCA'] = Variable<String?>(caminhoLogomarca);
    }
    if (!nullToAbsent || salvarXml != null) {
      map['SALVAR_XML'] = Variable<String?>(salvarXml);
    }
    if (!nullToAbsent || caminhoSalvarXml != null) {
      map['CAMINHO_SALVAR_XML'] = Variable<String?>(caminhoSalvarXml);
    }
    if (!nullToAbsent || caminhoSchemas != null) {
      map['CAMINHO_SCHEMAS'] = Variable<String?>(caminhoSchemas);
    }
    if (!nullToAbsent || caminhoArquivoDanfe != null) {
      map['CAMINHO_ARQUIVO_DANFE'] = Variable<String?>(caminhoArquivoDanfe);
    }
    if (!nullToAbsent || caminhoSalvarPdf != null) {
      map['CAMINHO_SALVAR_PDF'] = Variable<String?>(caminhoSalvarPdf);
    }
    if (!nullToAbsent || webserviceUf != null) {
      map['WEBSERVICE_UF'] = Variable<String?>(webserviceUf);
    }
    if (!nullToAbsent || webserviceAmbiente != null) {
      map['WEBSERVICE_AMBIENTE'] = Variable<int?>(webserviceAmbiente);
    }
    if (!nullToAbsent || webserviceProxyHost != null) {
      map['WEBSERVICE_PROXY_HOST'] = Variable<String?>(webserviceProxyHost);
    }
    if (!nullToAbsent || webserviceProxyPorta != null) {
      map['WEBSERVICE_PROXY_PORTA'] = Variable<int?>(webserviceProxyPorta);
    }
    if (!nullToAbsent || webserviceProxyUsuario != null) {
      map['WEBSERVICE_PROXY_USUARIO'] = Variable<String?>(webserviceProxyUsuario);
    }
    if (!nullToAbsent || webserviceProxySenha != null) {
      map['WEBSERVICE_PROXY_SENHA'] = Variable<String?>(webserviceProxySenha);
    }
    if (!nullToAbsent || webserviceVisualizar != null) {
      map['WEBSERVICE_VISUALIZAR'] = Variable<String?>(webserviceVisualizar);
    }
    if (!nullToAbsent || emailServidorSmtp != null) {
      map['EMAIL_SERVIDOR_SMTP'] = Variable<String?>(emailServidorSmtp);
    }
    if (!nullToAbsent || emailPorta != null) {
      map['EMAIL_PORTA'] = Variable<int?>(emailPorta);
    }
    if (!nullToAbsent || emailUsuario != null) {
      map['EMAIL_USUARIO'] = Variable<String?>(emailUsuario);
    }
    if (!nullToAbsent || emailSenha != null) {
      map['EMAIL_SENHA'] = Variable<String?>(emailSenha);
    }
    if (!nullToAbsent || emailAssunto != null) {
      map['EMAIL_ASSUNTO'] = Variable<String?>(emailAssunto);
    }
    if (!nullToAbsent || emailAutenticaSsl != null) {
      map['EMAIL_AUTENTICA_SSL'] = Variable<String?>(emailAutenticaSsl);
    }
    if (!nullToAbsent || emailTexto != null) {
      map['EMAIL_TEXTO'] = Variable<String?>(emailTexto);
    }
    if (!nullToAbsent || nfceIdCsc != null) {
      map['NFCE_ID_CSC'] = Variable<String?>(nfceIdCsc);
    }
    if (!nullToAbsent || nfceCsc != null) {
      map['NFCE_CSC'] = Variable<String?>(nfceCsc);
    }
    if (!nullToAbsent || nfceModeloImpressao != null) {
      map['NFCE_MODELO_IMPRESSAO'] = Variable<String?>(nfceModeloImpressao);
    }
    if (!nullToAbsent || nfceImprimirItensUmaLinha != null) {
      map['NFCE_IMPRIMIR_ITENS_UMA_LINHA'] = Variable<String?>(nfceImprimirItensUmaLinha);
    }
    if (!nullToAbsent || nfceImprimirDescontoPorItem != null) {
      map['NFCE_IMPRIMIR_DESCONTO_POR_ITEM'] = Variable<String?>(nfceImprimirDescontoPorItem);
    }
    if (!nullToAbsent || nfceImprimirQrcodeLateral != null) {
      map['NFCE_IMPRIMIR_QRCODE_LATERAL'] = Variable<String?>(nfceImprimirQrcodeLateral);
    }
    if (!nullToAbsent || nfceImprimirGtin != null) {
      map['NFCE_IMPRIMIR_GTIN'] = Variable<String?>(nfceImprimirGtin);
    }
    if (!nullToAbsent || nfceImprimirNomeFantasia != null) {
      map['NFCE_IMPRIMIR_NOME_FANTASIA'] = Variable<String?>(nfceImprimirNomeFantasia);
    }
    if (!nullToAbsent || nfceImpressaoTributos != null) {
      map['NFCE_IMPRESSAO_TRIBUTOS'] = Variable<String?>(nfceImpressaoTributos);
    }
    if (!nullToAbsent || nfceMargemSuperior != null) {
      map['NFCE_MARGEM_SUPERIOR'] = Variable<double?>(nfceMargemSuperior);
    }
    if (!nullToAbsent || nfceMargemInferior != null) {
      map['NFCE_MARGEM_INFERIOR'] = Variable<double?>(nfceMargemInferior);
    }
    if (!nullToAbsent || nfceMargemDireita != null) {
      map['NFCE_MARGEM_DIREITA'] = Variable<double?>(nfceMargemDireita);
    }
    if (!nullToAbsent || nfceMargemEsquerda != null) {
      map['NFCE_MARGEM_ESQUERDA'] = Variable<double?>(nfceMargemEsquerda);
    }
    if (!nullToAbsent || nfceResolucaoImpressao != null) {
      map['NFCE_RESOLUCAO_IMPRESSAO'] = Variable<int?>(nfceResolucaoImpressao);
    }
    if (!nullToAbsent || respTecCnpj != null) {
      map['RESP_TEC_CNPJ'] = Variable<String?>(respTecCnpj);
    }
    if (!nullToAbsent || respTecContato != null) {
      map['RESP_TEC_CONTATO'] = Variable<String?>(respTecContato);
    }
    if (!nullToAbsent || respTecEmail != null) {
      map['RESP_TEC_EMAIL'] = Variable<String?>(respTecEmail);
    }
    if (!nullToAbsent || respTecFone != null) {
      map['RESP_TEC_FONE'] = Variable<String?>(respTecFone);
    }
    if (!nullToAbsent || respTecIdCsrt != null) {
      map['RESP_TEC_ID_CSRT'] = Variable<String?>(respTecIdCsrt);
    }
    if (!nullToAbsent || respTecHashCsrt != null) {
      map['RESP_TEC_HASH_CSRT'] = Variable<String?>(respTecHashCsrt);
    }
    if (!nullToAbsent || nfceTamanhoFonteItem != null) {
      map['NFCE_TAMANHO_FONTE_ITEM'] = Variable<int?>(nfceTamanhoFonteItem);
    }
    return map;
  }

  NfeConfiguracaosCompanion toCompanion(bool nullToAbsent) {
    return NfeConfiguracaosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      certificadoDigitalSerie: certificadoDigitalSerie == null && nullToAbsent
        ? const Value.absent()
        : Value(certificadoDigitalSerie),
      certificadoDigitalCaminho: certificadoDigitalCaminho == null && nullToAbsent
        ? const Value.absent()
        : Value(certificadoDigitalCaminho),
      certificadoDigitalSenha: certificadoDigitalSenha == null && nullToAbsent
        ? const Value.absent()
        : Value(certificadoDigitalSenha),
      tipoEmissao: tipoEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoEmissao),
      formatoImpressaoDanfe: formatoImpressaoDanfe == null && nullToAbsent
        ? const Value.absent()
        : Value(formatoImpressaoDanfe),
      processoEmissao: processoEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(processoEmissao),
      versaoProcessoEmissao: versaoProcessoEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(versaoProcessoEmissao),
      caminhoLogomarca: caminhoLogomarca == null && nullToAbsent
        ? const Value.absent()
        : Value(caminhoLogomarca),
      salvarXml: salvarXml == null && nullToAbsent
        ? const Value.absent()
        : Value(salvarXml),
      caminhoSalvarXml: caminhoSalvarXml == null && nullToAbsent
        ? const Value.absent()
        : Value(caminhoSalvarXml),
      caminhoSchemas: caminhoSchemas == null && nullToAbsent
        ? const Value.absent()
        : Value(caminhoSchemas),
      caminhoArquivoDanfe: caminhoArquivoDanfe == null && nullToAbsent
        ? const Value.absent()
        : Value(caminhoArquivoDanfe),
      caminhoSalvarPdf: caminhoSalvarPdf == null && nullToAbsent
        ? const Value.absent()
        : Value(caminhoSalvarPdf),
      webserviceUf: webserviceUf == null && nullToAbsent
        ? const Value.absent()
        : Value(webserviceUf),
      webserviceAmbiente: webserviceAmbiente == null && nullToAbsent
        ? const Value.absent()
        : Value(webserviceAmbiente),
      webserviceProxyHost: webserviceProxyHost == null && nullToAbsent
        ? const Value.absent()
        : Value(webserviceProxyHost),
      webserviceProxyPorta: webserviceProxyPorta == null && nullToAbsent
        ? const Value.absent()
        : Value(webserviceProxyPorta),
      webserviceProxyUsuario: webserviceProxyUsuario == null && nullToAbsent
        ? const Value.absent()
        : Value(webserviceProxyUsuario),
      webserviceProxySenha: webserviceProxySenha == null && nullToAbsent
        ? const Value.absent()
        : Value(webserviceProxySenha),
      webserviceVisualizar: webserviceVisualizar == null && nullToAbsent
        ? const Value.absent()
        : Value(webserviceVisualizar),
      emailServidorSmtp: emailServidorSmtp == null && nullToAbsent
        ? const Value.absent()
        : Value(emailServidorSmtp),
      emailPorta: emailPorta == null && nullToAbsent
        ? const Value.absent()
        : Value(emailPorta),
      emailUsuario: emailUsuario == null && nullToAbsent
        ? const Value.absent()
        : Value(emailUsuario),
      emailSenha: emailSenha == null && nullToAbsent
        ? const Value.absent()
        : Value(emailSenha),
      emailAssunto: emailAssunto == null && nullToAbsent
        ? const Value.absent()
        : Value(emailAssunto),
      emailAutenticaSsl: emailAutenticaSsl == null && nullToAbsent
        ? const Value.absent()
        : Value(emailAutenticaSsl),
      emailTexto: emailTexto == null && nullToAbsent
        ? const Value.absent()
        : Value(emailTexto),
      nfceIdCsc: nfceIdCsc == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceIdCsc),
      nfceCsc: nfceCsc == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceCsc),
      nfceModeloImpressao: nfceModeloImpressao == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceModeloImpressao),
      nfceImprimirItensUmaLinha: nfceImprimirItensUmaLinha == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceImprimirItensUmaLinha),
      nfceImprimirDescontoPorItem: nfceImprimirDescontoPorItem == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceImprimirDescontoPorItem),
      nfceImprimirQrcodeLateral: nfceImprimirQrcodeLateral == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceImprimirQrcodeLateral),
      nfceImprimirGtin: nfceImprimirGtin == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceImprimirGtin),
      nfceImprimirNomeFantasia: nfceImprimirNomeFantasia == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceImprimirNomeFantasia),
      nfceImpressaoTributos: nfceImpressaoTributos == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceImpressaoTributos),
      nfceMargemSuperior: nfceMargemSuperior == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceMargemSuperior),
      nfceMargemInferior: nfceMargemInferior == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceMargemInferior),
      nfceMargemDireita: nfceMargemDireita == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceMargemDireita),
      nfceMargemEsquerda: nfceMargemEsquerda == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceMargemEsquerda),
      nfceResolucaoImpressao: nfceResolucaoImpressao == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceResolucaoImpressao),
      respTecCnpj: respTecCnpj == null && nullToAbsent
        ? const Value.absent()
        : Value(respTecCnpj),
      respTecContato: respTecContato == null && nullToAbsent
        ? const Value.absent()
        : Value(respTecContato),
      respTecEmail: respTecEmail == null && nullToAbsent
        ? const Value.absent()
        : Value(respTecEmail),
      respTecFone: respTecFone == null && nullToAbsent
        ? const Value.absent()
        : Value(respTecFone),
      respTecIdCsrt: respTecIdCsrt == null && nullToAbsent
        ? const Value.absent()
        : Value(respTecIdCsrt),
      respTecHashCsrt: respTecHashCsrt == null && nullToAbsent
        ? const Value.absent()
        : Value(respTecHashCsrt),
      nfceTamanhoFonteItem: nfceTamanhoFonteItem == null && nullToAbsent
        ? const Value.absent()
        : Value(nfceTamanhoFonteItem),
    );
  }

  factory NfeConfiguracao.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeConfiguracao(
      id: serializer.fromJson<int>(json['id']),
      certificadoDigitalSerie: serializer.fromJson<String>(json['certificadoDigitalSerie']),
      certificadoDigitalCaminho: serializer.fromJson<String>(json['certificadoDigitalCaminho']),
      certificadoDigitalSenha: serializer.fromJson<String>(json['certificadoDigitalSenha']),
      tipoEmissao: serializer.fromJson<int>(json['tipoEmissao']),
      formatoImpressaoDanfe: serializer.fromJson<int>(json['formatoImpressaoDanfe']),
      processoEmissao: serializer.fromJson<int>(json['processoEmissao']),
      versaoProcessoEmissao: serializer.fromJson<String>(json['versaoProcessoEmissao']),
      caminhoLogomarca: serializer.fromJson<String>(json['caminhoLogomarca']),
      salvarXml: serializer.fromJson<String>(json['salvarXml']),
      caminhoSalvarXml: serializer.fromJson<String>(json['caminhoSalvarXml']),
      caminhoSchemas: serializer.fromJson<String>(json['caminhoSchemas']),
      caminhoArquivoDanfe: serializer.fromJson<String>(json['caminhoArquivoDanfe']),
      caminhoSalvarPdf: serializer.fromJson<String>(json['caminhoSalvarPdf']),
      webserviceUf: serializer.fromJson<String>(json['webserviceUf']),
      webserviceAmbiente: serializer.fromJson<int>(json['webserviceAmbiente']),
      webserviceProxyHost: serializer.fromJson<String>(json['webserviceProxyHost']),
      webserviceProxyPorta: serializer.fromJson<int>(json['webserviceProxyPorta']),
      webserviceProxyUsuario: serializer.fromJson<String>(json['webserviceProxyUsuario']),
      webserviceProxySenha: serializer.fromJson<String>(json['webserviceProxySenha']),
      webserviceVisualizar: serializer.fromJson<String>(json['webserviceVisualizar']),
      emailServidorSmtp: serializer.fromJson<String>(json['emailServidorSmtp']),
      emailPorta: serializer.fromJson<int>(json['emailPorta']),
      emailUsuario: serializer.fromJson<String>(json['emailUsuario']),
      emailSenha: serializer.fromJson<String>(json['emailSenha']),
      emailAssunto: serializer.fromJson<String>(json['emailAssunto']),
      emailAutenticaSsl: serializer.fromJson<String>(json['emailAutenticaSsl']),
      emailTexto: serializer.fromJson<String>(json['emailTexto']),
      nfceIdCsc: serializer.fromJson<String>(json['nfceIdCsc']),
      nfceCsc: serializer.fromJson<String>(json['nfceCsc']),
      nfceModeloImpressao: serializer.fromJson<String>(json['nfceModeloImpressao']),
      nfceImprimirItensUmaLinha: serializer.fromJson<String>(json['nfceImprimirItensUmaLinha']),
      nfceImprimirDescontoPorItem: serializer.fromJson<String>(json['nfceImprimirDescontoPorItem']),
      nfceImprimirQrcodeLateral: serializer.fromJson<String>(json['nfceImprimirQrcodeLateral']),
      nfceImprimirGtin: serializer.fromJson<String>(json['nfceImprimirGtin']),
      nfceImprimirNomeFantasia: serializer.fromJson<String>(json['nfceImprimirNomeFantasia']),
      nfceImpressaoTributos: serializer.fromJson<String>(json['nfceImpressaoTributos']),
      nfceMargemSuperior: serializer.fromJson<double>(json['nfceMargemSuperior']),
      nfceMargemInferior: serializer.fromJson<double>(json['nfceMargemInferior']),
      nfceMargemDireita: serializer.fromJson<double>(json['nfceMargemDireita']),
      nfceMargemEsquerda: serializer.fromJson<double>(json['nfceMargemEsquerda']),
      nfceResolucaoImpressao: serializer.fromJson<int>(json['nfceResolucaoImpressao']),
      respTecCnpj: serializer.fromJson<String>(json['respTecCnpj']),
      respTecContato: serializer.fromJson<String>(json['respTecContato']),
      respTecEmail: serializer.fromJson<String>(json['respTecEmail']),
      respTecFone: serializer.fromJson<String>(json['respTecFone']),
      respTecIdCsrt: serializer.fromJson<String>(json['respTecIdCsrt']),
      respTecHashCsrt: serializer.fromJson<String>(json['respTecHashCsrt']),
      nfceTamanhoFonteItem: serializer.fromJson<int>(json['nfceTamanhoFonteItem']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'certificadoDigitalSerie': serializer.toJson<String?>(certificadoDigitalSerie),
      'certificadoDigitalCaminho': serializer.toJson<String?>(certificadoDigitalCaminho),
      'certificadoDigitalSenha': serializer.toJson<String?>(certificadoDigitalSenha),
      'tipoEmissao': serializer.toJson<int?>(tipoEmissao),
      'formatoImpressaoDanfe': serializer.toJson<int?>(formatoImpressaoDanfe),
      'processoEmissao': serializer.toJson<int?>(processoEmissao),
      'versaoProcessoEmissao': serializer.toJson<String?>(versaoProcessoEmissao),
      'caminhoLogomarca': serializer.toJson<String?>(caminhoLogomarca),
      'salvarXml': serializer.toJson<String?>(salvarXml),
      'caminhoSalvarXml': serializer.toJson<String?>(caminhoSalvarXml),
      'caminhoSchemas': serializer.toJson<String?>(caminhoSchemas),
      'caminhoArquivoDanfe': serializer.toJson<String?>(caminhoArquivoDanfe),
      'caminhoSalvarPdf': serializer.toJson<String?>(caminhoSalvarPdf),
      'webserviceUf': serializer.toJson<String?>(webserviceUf),
      'webserviceAmbiente': serializer.toJson<int?>(webserviceAmbiente),
      'webserviceProxyHost': serializer.toJson<String?>(webserviceProxyHost),
      'webserviceProxyPorta': serializer.toJson<int?>(webserviceProxyPorta),
      'webserviceProxyUsuario': serializer.toJson<String?>(webserviceProxyUsuario),
      'webserviceProxySenha': serializer.toJson<String?>(webserviceProxySenha),
      'webserviceVisualizar': serializer.toJson<String?>(webserviceVisualizar),
      'emailServidorSmtp': serializer.toJson<String?>(emailServidorSmtp),
      'emailPorta': serializer.toJson<int?>(emailPorta),
      'emailUsuario': serializer.toJson<String?>(emailUsuario),
      'emailSenha': serializer.toJson<String?>(emailSenha),
      'emailAssunto': serializer.toJson<String?>(emailAssunto),
      'emailAutenticaSsl': serializer.toJson<String?>(emailAutenticaSsl),
      'emailTexto': serializer.toJson<String?>(emailTexto),
      'nfceIdCsc': serializer.toJson<String?>(nfceIdCsc),
      'nfceCsc': serializer.toJson<String?>(nfceCsc),
      'nfceModeloImpressao': serializer.toJson<String?>(nfceModeloImpressao),
      'nfceImprimirItensUmaLinha': serializer.toJson<String?>(nfceImprimirItensUmaLinha),
      'nfceImprimirDescontoPorItem': serializer.toJson<String?>(nfceImprimirDescontoPorItem),
      'nfceImprimirQrcodeLateral': serializer.toJson<String?>(nfceImprimirQrcodeLateral),
      'nfceImprimirGtin': serializer.toJson<String?>(nfceImprimirGtin),
      'nfceImprimirNomeFantasia': serializer.toJson<String?>(nfceImprimirNomeFantasia),
      'nfceImpressaoTributos': serializer.toJson<String?>(nfceImpressaoTributos),
      'nfceMargemSuperior': serializer.toJson<double?>(nfceMargemSuperior),
      'nfceMargemInferior': serializer.toJson<double?>(nfceMargemInferior),
      'nfceMargemDireita': serializer.toJson<double?>(nfceMargemDireita),
      'nfceMargemEsquerda': serializer.toJson<double?>(nfceMargemEsquerda),
      'nfceResolucaoImpressao': serializer.toJson<int?>(nfceResolucaoImpressao),
      'respTecCnpj': serializer.toJson<String?>(respTecCnpj),
      'respTecContato': serializer.toJson<String?>(respTecContato),
      'respTecEmail': serializer.toJson<String?>(respTecEmail),
      'respTecFone': serializer.toJson<String?>(respTecFone),
      'respTecIdCsrt': serializer.toJson<String?>(respTecIdCsrt),
      'respTecHashCsrt': serializer.toJson<String?>(respTecHashCsrt),
      'nfceTamanhoFonteItem': serializer.toJson<int?>(nfceTamanhoFonteItem),
    };
  }

  NfeConfiguracao copyWith(
        {
		  int? id,
          String? certificadoDigitalSerie,
          String? certificadoDigitalCaminho,
          String? certificadoDigitalSenha,
          int? tipoEmissao,
          int? formatoImpressaoDanfe,
          int? processoEmissao,
          String? versaoProcessoEmissao,
          String? caminhoLogomarca,
          String? salvarXml,
          String? caminhoSalvarXml,
          String? caminhoSchemas,
          String? caminhoArquivoDanfe,
          String? caminhoSalvarPdf,
          String? webserviceUf,
          int? webserviceAmbiente,
          String? webserviceProxyHost,
          int? webserviceProxyPorta,
          String? webserviceProxyUsuario,
          String? webserviceProxySenha,
          String? webserviceVisualizar,
          String? emailServidorSmtp,
          int? emailPorta,
          String? emailUsuario,
          String? emailSenha,
          String? emailAssunto,
          String? emailAutenticaSsl,
          String? emailTexto,
          String? nfceIdCsc,
          String? nfceCsc,
          String? nfceModeloImpressao,
          String? nfceImprimirItensUmaLinha,
          String? nfceImprimirDescontoPorItem,
          String? nfceImprimirQrcodeLateral,
          String? nfceImprimirGtin,
          String? nfceImprimirNomeFantasia,
          String? nfceImpressaoTributos,
          double? nfceMargemSuperior,
          double? nfceMargemInferior,
          double? nfceMargemDireita,
          double? nfceMargemEsquerda,
          int? nfceResolucaoImpressao,
          String? respTecCnpj,
          String? respTecContato,
          String? respTecEmail,
          String? respTecFone,
          String? respTecIdCsrt,
          String? respTecHashCsrt,
          int? nfceTamanhoFonteItem,
		}) =>
      NfeConfiguracao(
        id: id ?? this.id,
        certificadoDigitalSerie: certificadoDigitalSerie ?? this.certificadoDigitalSerie,
        certificadoDigitalCaminho: certificadoDigitalCaminho ?? this.certificadoDigitalCaminho,
        certificadoDigitalSenha: certificadoDigitalSenha ?? this.certificadoDigitalSenha,
        tipoEmissao: tipoEmissao ?? this.tipoEmissao,
        formatoImpressaoDanfe: formatoImpressaoDanfe ?? this.formatoImpressaoDanfe,
        processoEmissao: processoEmissao ?? this.processoEmissao,
        versaoProcessoEmissao: versaoProcessoEmissao ?? this.versaoProcessoEmissao,
        caminhoLogomarca: caminhoLogomarca ?? this.caminhoLogomarca,
        salvarXml: salvarXml ?? this.salvarXml,
        caminhoSalvarXml: caminhoSalvarXml ?? this.caminhoSalvarXml,
        caminhoSchemas: caminhoSchemas ?? this.caminhoSchemas,
        caminhoArquivoDanfe: caminhoArquivoDanfe ?? this.caminhoArquivoDanfe,
        caminhoSalvarPdf: caminhoSalvarPdf ?? this.caminhoSalvarPdf,
        webserviceUf: webserviceUf ?? this.webserviceUf,
        webserviceAmbiente: webserviceAmbiente ?? this.webserviceAmbiente,
        webserviceProxyHost: webserviceProxyHost ?? this.webserviceProxyHost,
        webserviceProxyPorta: webserviceProxyPorta ?? this.webserviceProxyPorta,
        webserviceProxyUsuario: webserviceProxyUsuario ?? this.webserviceProxyUsuario,
        webserviceProxySenha: webserviceProxySenha ?? this.webserviceProxySenha,
        webserviceVisualizar: webserviceVisualizar ?? this.webserviceVisualizar,
        emailServidorSmtp: emailServidorSmtp ?? this.emailServidorSmtp,
        emailPorta: emailPorta ?? this.emailPorta,
        emailUsuario: emailUsuario ?? this.emailUsuario,
        emailSenha: emailSenha ?? this.emailSenha,
        emailAssunto: emailAssunto ?? this.emailAssunto,
        emailAutenticaSsl: emailAutenticaSsl ?? this.emailAutenticaSsl,
        emailTexto: emailTexto ?? this.emailTexto,
        nfceIdCsc: nfceIdCsc ?? this.nfceIdCsc,
        nfceCsc: nfceCsc ?? this.nfceCsc,
        nfceModeloImpressao: nfceModeloImpressao ?? this.nfceModeloImpressao,
        nfceImprimirItensUmaLinha: nfceImprimirItensUmaLinha ?? this.nfceImprimirItensUmaLinha,
        nfceImprimirDescontoPorItem: nfceImprimirDescontoPorItem ?? this.nfceImprimirDescontoPorItem,
        nfceImprimirQrcodeLateral: nfceImprimirQrcodeLateral ?? this.nfceImprimirQrcodeLateral,
        nfceImprimirGtin: nfceImprimirGtin ?? this.nfceImprimirGtin,
        nfceImprimirNomeFantasia: nfceImprimirNomeFantasia ?? this.nfceImprimirNomeFantasia,
        nfceImpressaoTributos: nfceImpressaoTributos ?? this.nfceImpressaoTributos,
        nfceMargemSuperior: nfceMargemSuperior ?? this.nfceMargemSuperior,
        nfceMargemInferior: nfceMargemInferior ?? this.nfceMargemInferior,
        nfceMargemDireita: nfceMargemDireita ?? this.nfceMargemDireita,
        nfceMargemEsquerda: nfceMargemEsquerda ?? this.nfceMargemEsquerda,
        nfceResolucaoImpressao: nfceResolucaoImpressao ?? this.nfceResolucaoImpressao,
        respTecCnpj: respTecCnpj ?? this.respTecCnpj,
        respTecContato: respTecContato ?? this.respTecContato,
        respTecEmail: respTecEmail ?? this.respTecEmail,
        respTecFone: respTecFone ?? this.respTecFone,
        respTecIdCsrt: respTecIdCsrt ?? this.respTecIdCsrt,
        respTecHashCsrt: respTecHashCsrt ?? this.respTecHashCsrt,
        nfceTamanhoFonteItem: nfceTamanhoFonteItem ?? this.nfceTamanhoFonteItem,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeConfiguracao(')
          ..write('id: $id, ')
          ..write('certificadoDigitalSerie: $certificadoDigitalSerie, ')
          ..write('certificadoDigitalCaminho: $certificadoDigitalCaminho, ')
          ..write('certificadoDigitalSenha: $certificadoDigitalSenha, ')
          ..write('tipoEmissao: $tipoEmissao, ')
          ..write('formatoImpressaoDanfe: $formatoImpressaoDanfe, ')
          ..write('processoEmissao: $processoEmissao, ')
          ..write('versaoProcessoEmissao: $versaoProcessoEmissao, ')
          ..write('caminhoLogomarca: $caminhoLogomarca, ')
          ..write('salvarXml: $salvarXml, ')
          ..write('caminhoSalvarXml: $caminhoSalvarXml, ')
          ..write('caminhoSchemas: $caminhoSchemas, ')
          ..write('caminhoArquivoDanfe: $caminhoArquivoDanfe, ')
          ..write('caminhoSalvarPdf: $caminhoSalvarPdf, ')
          ..write('webserviceUf: $webserviceUf, ')
          ..write('webserviceAmbiente: $webserviceAmbiente, ')
          ..write('webserviceProxyHost: $webserviceProxyHost, ')
          ..write('webserviceProxyPorta: $webserviceProxyPorta, ')
          ..write('webserviceProxyUsuario: $webserviceProxyUsuario, ')
          ..write('webserviceProxySenha: $webserviceProxySenha, ')
          ..write('webserviceVisualizar: $webserviceVisualizar, ')
          ..write('emailServidorSmtp: $emailServidorSmtp, ')
          ..write('emailPorta: $emailPorta, ')
          ..write('emailUsuario: $emailUsuario, ')
          ..write('emailSenha: $emailSenha, ')
          ..write('emailAssunto: $emailAssunto, ')
          ..write('emailAutenticaSsl: $emailAutenticaSsl, ')
          ..write('emailTexto: $emailTexto, ')
          ..write('nfceIdCsc: $nfceIdCsc, ')
          ..write('nfceCsc: $nfceCsc, ')
          ..write('nfceModeloImpressao: $nfceModeloImpressao, ')
          ..write('nfceImprimirItensUmaLinha: $nfceImprimirItensUmaLinha, ')
          ..write('nfceImprimirDescontoPorItem: $nfceImprimirDescontoPorItem, ')
          ..write('nfceImprimirQrcodeLateral: $nfceImprimirQrcodeLateral, ')
          ..write('nfceImprimirGtin: $nfceImprimirGtin, ')
          ..write('nfceImprimirNomeFantasia: $nfceImprimirNomeFantasia, ')
          ..write('nfceImpressaoTributos: $nfceImpressaoTributos, ')
          ..write('nfceMargemSuperior: $nfceMargemSuperior, ')
          ..write('nfceMargemInferior: $nfceMargemInferior, ')
          ..write('nfceMargemDireita: $nfceMargemDireita, ')
          ..write('nfceMargemEsquerda: $nfceMargemEsquerda, ')
          ..write('nfceResolucaoImpressao: $nfceResolucaoImpressao, ')
          ..write('respTecCnpj: $respTecCnpj, ')
          ..write('respTecContato: $respTecContato, ')
          ..write('respTecEmail: $respTecEmail, ')
          ..write('respTecFone: $respTecFone, ')
          ..write('respTecIdCsrt: $respTecIdCsrt, ')
          ..write('respTecHashCsrt: $respTecHashCsrt, ')
          ..write('nfceTamanhoFonteItem: $nfceTamanhoFonteItem, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      certificadoDigitalSerie,
      certificadoDigitalCaminho,
      certificadoDigitalSenha,
      tipoEmissao,
      formatoImpressaoDanfe,
      processoEmissao,
      versaoProcessoEmissao,
      caminhoLogomarca,
      salvarXml,
      caminhoSalvarXml,
      caminhoSchemas,
      caminhoArquivoDanfe,
      caminhoSalvarPdf,
      webserviceUf,
      webserviceAmbiente,
      webserviceProxyHost,
      webserviceProxyPorta,
      webserviceProxyUsuario,
      webserviceProxySenha,
      webserviceVisualizar,
      emailServidorSmtp,
      emailPorta,
      emailUsuario,
      emailSenha,
      emailAssunto,
      emailAutenticaSsl,
      emailTexto,
      nfceIdCsc,
      nfceCsc,
      nfceModeloImpressao,
      nfceImprimirItensUmaLinha,
      nfceImprimirDescontoPorItem,
      nfceImprimirQrcodeLateral,
      nfceImprimirGtin,
      nfceImprimirNomeFantasia,
      nfceImpressaoTributos,
      nfceMargemSuperior,
      nfceMargemInferior,
      nfceMargemDireita,
      nfceMargemEsquerda,
      nfceResolucaoImpressao,
      respTecCnpj,
      respTecContato,
      respTecEmail,
      respTecFone,
      respTecIdCsrt,
      respTecHashCsrt,
      nfceTamanhoFonteItem,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeConfiguracao &&
          other.id == id &&
          other.certificadoDigitalSerie == certificadoDigitalSerie &&
          other.certificadoDigitalCaminho == certificadoDigitalCaminho &&
          other.certificadoDigitalSenha == certificadoDigitalSenha &&
          other.tipoEmissao == tipoEmissao &&
          other.formatoImpressaoDanfe == formatoImpressaoDanfe &&
          other.processoEmissao == processoEmissao &&
          other.versaoProcessoEmissao == versaoProcessoEmissao &&
          other.caminhoLogomarca == caminhoLogomarca &&
          other.salvarXml == salvarXml &&
          other.caminhoSalvarXml == caminhoSalvarXml &&
          other.caminhoSchemas == caminhoSchemas &&
          other.caminhoArquivoDanfe == caminhoArquivoDanfe &&
          other.caminhoSalvarPdf == caminhoSalvarPdf &&
          other.webserviceUf == webserviceUf &&
          other.webserviceAmbiente == webserviceAmbiente &&
          other.webserviceProxyHost == webserviceProxyHost &&
          other.webserviceProxyPorta == webserviceProxyPorta &&
          other.webserviceProxyUsuario == webserviceProxyUsuario &&
          other.webserviceProxySenha == webserviceProxySenha &&
          other.webserviceVisualizar == webserviceVisualizar &&
          other.emailServidorSmtp == emailServidorSmtp &&
          other.emailPorta == emailPorta &&
          other.emailUsuario == emailUsuario &&
          other.emailSenha == emailSenha &&
          other.emailAssunto == emailAssunto &&
          other.emailAutenticaSsl == emailAutenticaSsl &&
          other.emailTexto == emailTexto &&
          other.nfceIdCsc == nfceIdCsc &&
          other.nfceCsc == nfceCsc &&
          other.nfceModeloImpressao == nfceModeloImpressao &&
          other.nfceImprimirItensUmaLinha == nfceImprimirItensUmaLinha &&
          other.nfceImprimirDescontoPorItem == nfceImprimirDescontoPorItem &&
          other.nfceImprimirQrcodeLateral == nfceImprimirQrcodeLateral &&
          other.nfceImprimirGtin == nfceImprimirGtin &&
          other.nfceImprimirNomeFantasia == nfceImprimirNomeFantasia &&
          other.nfceImpressaoTributos == nfceImpressaoTributos &&
          other.nfceMargemSuperior == nfceMargemSuperior &&
          other.nfceMargemInferior == nfceMargemInferior &&
          other.nfceMargemDireita == nfceMargemDireita &&
          other.nfceMargemEsquerda == nfceMargemEsquerda &&
          other.nfceResolucaoImpressao == nfceResolucaoImpressao &&
          other.respTecCnpj == respTecCnpj &&
          other.respTecContato == respTecContato &&
          other.respTecEmail == respTecEmail &&
          other.respTecFone == respTecFone &&
          other.respTecIdCsrt == respTecIdCsrt &&
          other.respTecHashCsrt == respTecHashCsrt &&
          other.nfceTamanhoFonteItem == nfceTamanhoFonteItem 
	   );
}

class NfeConfiguracaosCompanion extends UpdateCompanion<NfeConfiguracao> {

  final Value<int?> id;
  final Value<String?> certificadoDigitalSerie;
  final Value<String?> certificadoDigitalCaminho;
  final Value<String?> certificadoDigitalSenha;
  final Value<int?> tipoEmissao;
  final Value<int?> formatoImpressaoDanfe;
  final Value<int?> processoEmissao;
  final Value<String?> versaoProcessoEmissao;
  final Value<String?> caminhoLogomarca;
  final Value<String?> salvarXml;
  final Value<String?> caminhoSalvarXml;
  final Value<String?> caminhoSchemas;
  final Value<String?> caminhoArquivoDanfe;
  final Value<String?> caminhoSalvarPdf;
  final Value<String?> webserviceUf;
  final Value<int?> webserviceAmbiente;
  final Value<String?> webserviceProxyHost;
  final Value<int?> webserviceProxyPorta;
  final Value<String?> webserviceProxyUsuario;
  final Value<String?> webserviceProxySenha;
  final Value<String?> webserviceVisualizar;
  final Value<String?> emailServidorSmtp;
  final Value<int?> emailPorta;
  final Value<String?> emailUsuario;
  final Value<String?> emailSenha;
  final Value<String?> emailAssunto;
  final Value<String?> emailAutenticaSsl;
  final Value<String?> emailTexto;
  final Value<String?> nfceIdCsc;
  final Value<String?> nfceCsc;
  final Value<String?> nfceModeloImpressao;
  final Value<String?> nfceImprimirItensUmaLinha;
  final Value<String?> nfceImprimirDescontoPorItem;
  final Value<String?> nfceImprimirQrcodeLateral;
  final Value<String?> nfceImprimirGtin;
  final Value<String?> nfceImprimirNomeFantasia;
  final Value<String?> nfceImpressaoTributos;
  final Value<double?> nfceMargemSuperior;
  final Value<double?> nfceMargemInferior;
  final Value<double?> nfceMargemDireita;
  final Value<double?> nfceMargemEsquerda;
  final Value<int?> nfceResolucaoImpressao;
  final Value<String?> respTecCnpj;
  final Value<String?> respTecContato;
  final Value<String?> respTecEmail;
  final Value<String?> respTecFone;
  final Value<String?> respTecIdCsrt;
  final Value<String?> respTecHashCsrt;
  final Value<int?> nfceTamanhoFonteItem;

  const NfeConfiguracaosCompanion({
    this.id = const Value.absent(),
    this.certificadoDigitalSerie = const Value.absent(),
    this.certificadoDigitalCaminho = const Value.absent(),
    this.certificadoDigitalSenha = const Value.absent(),
    this.tipoEmissao = const Value.absent(),
    this.formatoImpressaoDanfe = const Value.absent(),
    this.processoEmissao = const Value.absent(),
    this.versaoProcessoEmissao = const Value.absent(),
    this.caminhoLogomarca = const Value.absent(),
    this.salvarXml = const Value.absent(),
    this.caminhoSalvarXml = const Value.absent(),
    this.caminhoSchemas = const Value.absent(),
    this.caminhoArquivoDanfe = const Value.absent(),
    this.caminhoSalvarPdf = const Value.absent(),
    this.webserviceUf = const Value.absent(),
    this.webserviceAmbiente = const Value.absent(),
    this.webserviceProxyHost = const Value.absent(),
    this.webserviceProxyPorta = const Value.absent(),
    this.webserviceProxyUsuario = const Value.absent(),
    this.webserviceProxySenha = const Value.absent(),
    this.webserviceVisualizar = const Value.absent(),
    this.emailServidorSmtp = const Value.absent(),
    this.emailPorta = const Value.absent(),
    this.emailUsuario = const Value.absent(),
    this.emailSenha = const Value.absent(),
    this.emailAssunto = const Value.absent(),
    this.emailAutenticaSsl = const Value.absent(),
    this.emailTexto = const Value.absent(),
    this.nfceIdCsc = const Value.absent(),
    this.nfceCsc = const Value.absent(),
    this.nfceModeloImpressao = const Value.absent(),
    this.nfceImprimirItensUmaLinha = const Value.absent(),
    this.nfceImprimirDescontoPorItem = const Value.absent(),
    this.nfceImprimirQrcodeLateral = const Value.absent(),
    this.nfceImprimirGtin = const Value.absent(),
    this.nfceImprimirNomeFantasia = const Value.absent(),
    this.nfceImpressaoTributos = const Value.absent(),
    this.nfceMargemSuperior = const Value.absent(),
    this.nfceMargemInferior = const Value.absent(),
    this.nfceMargemDireita = const Value.absent(),
    this.nfceMargemEsquerda = const Value.absent(),
    this.nfceResolucaoImpressao = const Value.absent(),
    this.respTecCnpj = const Value.absent(),
    this.respTecContato = const Value.absent(),
    this.respTecEmail = const Value.absent(),
    this.respTecFone = const Value.absent(),
    this.respTecIdCsrt = const Value.absent(),
    this.respTecHashCsrt = const Value.absent(),
    this.nfceTamanhoFonteItem = const Value.absent(),
  });

  NfeConfiguracaosCompanion.insert({
    this.id = const Value.absent(),
    this.certificadoDigitalSerie = const Value.absent(),
    this.certificadoDigitalCaminho = const Value.absent(),
    this.certificadoDigitalSenha = const Value.absent(),
    this.tipoEmissao = const Value.absent(),
    this.formatoImpressaoDanfe = const Value.absent(),
    this.processoEmissao = const Value.absent(),
    this.versaoProcessoEmissao = const Value.absent(),
    this.caminhoLogomarca = const Value.absent(),
    this.salvarXml = const Value.absent(),
    this.caminhoSalvarXml = const Value.absent(),
    this.caminhoSchemas = const Value.absent(),
    this.caminhoArquivoDanfe = const Value.absent(),
    this.caminhoSalvarPdf = const Value.absent(),
    this.webserviceUf = const Value.absent(),
    this.webserviceAmbiente = const Value.absent(),
    this.webserviceProxyHost = const Value.absent(),
    this.webserviceProxyPorta = const Value.absent(),
    this.webserviceProxyUsuario = const Value.absent(),
    this.webserviceProxySenha = const Value.absent(),
    this.webserviceVisualizar = const Value.absent(),
    this.emailServidorSmtp = const Value.absent(),
    this.emailPorta = const Value.absent(),
    this.emailUsuario = const Value.absent(),
    this.emailSenha = const Value.absent(),
    this.emailAssunto = const Value.absent(),
    this.emailAutenticaSsl = const Value.absent(),
    this.emailTexto = const Value.absent(),
    this.nfceIdCsc = const Value.absent(),
    this.nfceCsc = const Value.absent(),
    this.nfceModeloImpressao = const Value.absent(),
    this.nfceImprimirItensUmaLinha = const Value.absent(),
    this.nfceImprimirDescontoPorItem = const Value.absent(),
    this.nfceImprimirQrcodeLateral = const Value.absent(),
    this.nfceImprimirGtin = const Value.absent(),
    this.nfceImprimirNomeFantasia = const Value.absent(),
    this.nfceImpressaoTributos = const Value.absent(),
    this.nfceMargemSuperior = const Value.absent(),
    this.nfceMargemInferior = const Value.absent(),
    this.nfceMargemDireita = const Value.absent(),
    this.nfceMargemEsquerda = const Value.absent(),
    this.nfceResolucaoImpressao = const Value.absent(),
    this.respTecCnpj = const Value.absent(),
    this.respTecContato = const Value.absent(),
    this.respTecEmail = const Value.absent(),
    this.respTecFone = const Value.absent(),
    this.respTecIdCsrt = const Value.absent(),
    this.respTecHashCsrt = const Value.absent(),
    this.nfceTamanhoFonteItem = const Value.absent(),
  });

  static Insertable<NfeConfiguracao> custom({
    Expression<int>? id,
    Expression<String>? certificadoDigitalSerie,
    Expression<String>? certificadoDigitalCaminho,
    Expression<String>? certificadoDigitalSenha,
    Expression<int>? tipoEmissao,
    Expression<int>? formatoImpressaoDanfe,
    Expression<int>? processoEmissao,
    Expression<String>? versaoProcessoEmissao,
    Expression<String>? caminhoLogomarca,
    Expression<String>? salvarXml,
    Expression<String>? caminhoSalvarXml,
    Expression<String>? caminhoSchemas,
    Expression<String>? caminhoArquivoDanfe,
    Expression<String>? caminhoSalvarPdf,
    Expression<String>? webserviceUf,
    Expression<int>? webserviceAmbiente,
    Expression<String>? webserviceProxyHost,
    Expression<int>? webserviceProxyPorta,
    Expression<String>? webserviceProxyUsuario,
    Expression<String>? webserviceProxySenha,
    Expression<String>? webserviceVisualizar,
    Expression<String>? emailServidorSmtp,
    Expression<int>? emailPorta,
    Expression<String>? emailUsuario,
    Expression<String>? emailSenha,
    Expression<String>? emailAssunto,
    Expression<String>? emailAutenticaSsl,
    Expression<String>? emailTexto,
    Expression<String>? nfceIdCsc,
    Expression<String>? nfceCsc,
    Expression<String>? nfceModeloImpressao,
    Expression<String>? nfceImprimirItensUmaLinha,
    Expression<String>? nfceImprimirDescontoPorItem,
    Expression<String>? nfceImprimirQrcodeLateral,
    Expression<String>? nfceImprimirGtin,
    Expression<String>? nfceImprimirNomeFantasia,
    Expression<String>? nfceImpressaoTributos,
    Expression<double>? nfceMargemSuperior,
    Expression<double>? nfceMargemInferior,
    Expression<double>? nfceMargemDireita,
    Expression<double>? nfceMargemEsquerda,
    Expression<int>? nfceResolucaoImpressao,
    Expression<String>? respTecCnpj,
    Expression<String>? respTecContato,
    Expression<String>? respTecEmail,
    Expression<String>? respTecFone,
    Expression<String>? respTecIdCsrt,
    Expression<String>? respTecHashCsrt,
    Expression<int>? nfceTamanhoFonteItem,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (certificadoDigitalSerie != null) 'CERTIFICADO_DIGITAL_SERIE': certificadoDigitalSerie,
      if (certificadoDigitalCaminho != null) 'CERTIFICADO_DIGITAL_CAMINHO': certificadoDigitalCaminho,
      if (certificadoDigitalSenha != null) 'CERTIFICADO_DIGITAL_SENHA': certificadoDigitalSenha,
      if (tipoEmissao != null) 'TIPO_EMISSAO': tipoEmissao,
      if (formatoImpressaoDanfe != null) 'FORMATO_IMPRESSAO_DANFE': formatoImpressaoDanfe,
      if (processoEmissao != null) 'PROCESSO_EMISSAO': processoEmissao,
      if (versaoProcessoEmissao != null) 'VERSAO_PROCESSO_EMISSAO': versaoProcessoEmissao,
      if (caminhoLogomarca != null) 'CAMINHO_LOGOMARCA': caminhoLogomarca,
      if (salvarXml != null) 'SALVAR_XML': salvarXml,
      if (caminhoSalvarXml != null) 'CAMINHO_SALVAR_XML': caminhoSalvarXml,
      if (caminhoSchemas != null) 'CAMINHO_SCHEMAS': caminhoSchemas,
      if (caminhoArquivoDanfe != null) 'CAMINHO_ARQUIVO_DANFE': caminhoArquivoDanfe,
      if (caminhoSalvarPdf != null) 'CAMINHO_SALVAR_PDF': caminhoSalvarPdf,
      if (webserviceUf != null) 'WEBSERVICE_UF': webserviceUf,
      if (webserviceAmbiente != null) 'WEBSERVICE_AMBIENTE': webserviceAmbiente,
      if (webserviceProxyHost != null) 'WEBSERVICE_PROXY_HOST': webserviceProxyHost,
      if (webserviceProxyPorta != null) 'WEBSERVICE_PROXY_PORTA': webserviceProxyPorta,
      if (webserviceProxyUsuario != null) 'WEBSERVICE_PROXY_USUARIO': webserviceProxyUsuario,
      if (webserviceProxySenha != null) 'WEBSERVICE_PROXY_SENHA': webserviceProxySenha,
      if (webserviceVisualizar != null) 'WEBSERVICE_VISUALIZAR': webserviceVisualizar,
      if (emailServidorSmtp != null) 'EMAIL_SERVIDOR_SMTP': emailServidorSmtp,
      if (emailPorta != null) 'EMAIL_PORTA': emailPorta,
      if (emailUsuario != null) 'EMAIL_USUARIO': emailUsuario,
      if (emailSenha != null) 'EMAIL_SENHA': emailSenha,
      if (emailAssunto != null) 'EMAIL_ASSUNTO': emailAssunto,
      if (emailAutenticaSsl != null) 'EMAIL_AUTENTICA_SSL': emailAutenticaSsl,
      if (emailTexto != null) 'EMAIL_TEXTO': emailTexto,
      if (nfceIdCsc != null) 'NFCE_ID_CSC': nfceIdCsc,
      if (nfceCsc != null) 'NFCE_CSC': nfceCsc,
      if (nfceModeloImpressao != null) 'NFCE_MODELO_IMPRESSAO': nfceModeloImpressao,
      if (nfceImprimirItensUmaLinha != null) 'NFCE_IMPRIMIR_ITENS_UMA_LINHA': nfceImprimirItensUmaLinha,
      if (nfceImprimirDescontoPorItem != null) 'NFCE_IMPRIMIR_DESCONTO_POR_ITEM': nfceImprimirDescontoPorItem,
      if (nfceImprimirQrcodeLateral != null) 'NFCE_IMPRIMIR_QRCODE_LATERAL': nfceImprimirQrcodeLateral,
      if (nfceImprimirGtin != null) 'NFCE_IMPRIMIR_GTIN': nfceImprimirGtin,
      if (nfceImprimirNomeFantasia != null) 'NFCE_IMPRIMIR_NOME_FANTASIA': nfceImprimirNomeFantasia,
      if (nfceImpressaoTributos != null) 'NFCE_IMPRESSAO_TRIBUTOS': nfceImpressaoTributos,
      if (nfceMargemSuperior != null) 'NFCE_MARGEM_SUPERIOR': nfceMargemSuperior,
      if (nfceMargemInferior != null) 'NFCE_MARGEM_INFERIOR': nfceMargemInferior,
      if (nfceMargemDireita != null) 'NFCE_MARGEM_DIREITA': nfceMargemDireita,
      if (nfceMargemEsquerda != null) 'NFCE_MARGEM_ESQUERDA': nfceMargemEsquerda,
      if (nfceResolucaoImpressao != null) 'NFCE_RESOLUCAO_IMPRESSAO': nfceResolucaoImpressao,
      if (respTecCnpj != null) 'RESP_TEC_CNPJ': respTecCnpj,
      if (respTecContato != null) 'RESP_TEC_CONTATO': respTecContato,
      if (respTecEmail != null) 'RESP_TEC_EMAIL': respTecEmail,
      if (respTecFone != null) 'RESP_TEC_FONE': respTecFone,
      if (respTecIdCsrt != null) 'RESP_TEC_ID_CSRT': respTecIdCsrt,
      if (respTecHashCsrt != null) 'RESP_TEC_HASH_CSRT': respTecHashCsrt,
      if (nfceTamanhoFonteItem != null) 'NFCE_TAMANHO_FONTE_ITEM': nfceTamanhoFonteItem,
    });
  }

  NfeConfiguracaosCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? certificadoDigitalSerie,
      Value<String>? certificadoDigitalCaminho,
      Value<String>? certificadoDigitalSenha,
      Value<int>? tipoEmissao,
      Value<int>? formatoImpressaoDanfe,
      Value<int>? processoEmissao,
      Value<String>? versaoProcessoEmissao,
      Value<String>? caminhoLogomarca,
      Value<String>? salvarXml,
      Value<String>? caminhoSalvarXml,
      Value<String>? caminhoSchemas,
      Value<String>? caminhoArquivoDanfe,
      Value<String>? caminhoSalvarPdf,
      Value<String>? webserviceUf,
      Value<int>? webserviceAmbiente,
      Value<String>? webserviceProxyHost,
      Value<int>? webserviceProxyPorta,
      Value<String>? webserviceProxyUsuario,
      Value<String>? webserviceProxySenha,
      Value<String>? webserviceVisualizar,
      Value<String>? emailServidorSmtp,
      Value<int>? emailPorta,
      Value<String>? emailUsuario,
      Value<String>? emailSenha,
      Value<String>? emailAssunto,
      Value<String>? emailAutenticaSsl,
      Value<String>? emailTexto,
      Value<String>? nfceIdCsc,
      Value<String>? nfceCsc,
      Value<String>? nfceModeloImpressao,
      Value<String>? nfceImprimirItensUmaLinha,
      Value<String>? nfceImprimirDescontoPorItem,
      Value<String>? nfceImprimirQrcodeLateral,
      Value<String>? nfceImprimirGtin,
      Value<String>? nfceImprimirNomeFantasia,
      Value<String>? nfceImpressaoTributos,
      Value<double>? nfceMargemSuperior,
      Value<double>? nfceMargemInferior,
      Value<double>? nfceMargemDireita,
      Value<double>? nfceMargemEsquerda,
      Value<int>? nfceResolucaoImpressao,
      Value<String>? respTecCnpj,
      Value<String>? respTecContato,
      Value<String>? respTecEmail,
      Value<String>? respTecFone,
      Value<String>? respTecIdCsrt,
      Value<String>? respTecHashCsrt,
      Value<int>? nfceTamanhoFonteItem,
	  }) {
    return NfeConfiguracaosCompanion(
      id: id ?? this.id,
      certificadoDigitalSerie: certificadoDigitalSerie ?? this.certificadoDigitalSerie,
      certificadoDigitalCaminho: certificadoDigitalCaminho ?? this.certificadoDigitalCaminho,
      certificadoDigitalSenha: certificadoDigitalSenha ?? this.certificadoDigitalSenha,
      tipoEmissao: tipoEmissao ?? this.tipoEmissao,
      formatoImpressaoDanfe: formatoImpressaoDanfe ?? this.formatoImpressaoDanfe,
      processoEmissao: processoEmissao ?? this.processoEmissao,
      versaoProcessoEmissao: versaoProcessoEmissao ?? this.versaoProcessoEmissao,
      caminhoLogomarca: caminhoLogomarca ?? this.caminhoLogomarca,
      salvarXml: salvarXml ?? this.salvarXml,
      caminhoSalvarXml: caminhoSalvarXml ?? this.caminhoSalvarXml,
      caminhoSchemas: caminhoSchemas ?? this.caminhoSchemas,
      caminhoArquivoDanfe: caminhoArquivoDanfe ?? this.caminhoArquivoDanfe,
      caminhoSalvarPdf: caminhoSalvarPdf ?? this.caminhoSalvarPdf,
      webserviceUf: webserviceUf ?? this.webserviceUf,
      webserviceAmbiente: webserviceAmbiente ?? this.webserviceAmbiente,
      webserviceProxyHost: webserviceProxyHost ?? this.webserviceProxyHost,
      webserviceProxyPorta: webserviceProxyPorta ?? this.webserviceProxyPorta,
      webserviceProxyUsuario: webserviceProxyUsuario ?? this.webserviceProxyUsuario,
      webserviceProxySenha: webserviceProxySenha ?? this.webserviceProxySenha,
      webserviceVisualizar: webserviceVisualizar ?? this.webserviceVisualizar,
      emailServidorSmtp: emailServidorSmtp ?? this.emailServidorSmtp,
      emailPorta: emailPorta ?? this.emailPorta,
      emailUsuario: emailUsuario ?? this.emailUsuario,
      emailSenha: emailSenha ?? this.emailSenha,
      emailAssunto: emailAssunto ?? this.emailAssunto,
      emailAutenticaSsl: emailAutenticaSsl ?? this.emailAutenticaSsl,
      emailTexto: emailTexto ?? this.emailTexto,
      nfceIdCsc: nfceIdCsc ?? this.nfceIdCsc,
      nfceCsc: nfceCsc ?? this.nfceCsc,
      nfceModeloImpressao: nfceModeloImpressao ?? this.nfceModeloImpressao,
      nfceImprimirItensUmaLinha: nfceImprimirItensUmaLinha ?? this.nfceImprimirItensUmaLinha,
      nfceImprimirDescontoPorItem: nfceImprimirDescontoPorItem ?? this.nfceImprimirDescontoPorItem,
      nfceImprimirQrcodeLateral: nfceImprimirQrcodeLateral ?? this.nfceImprimirQrcodeLateral,
      nfceImprimirGtin: nfceImprimirGtin ?? this.nfceImprimirGtin,
      nfceImprimirNomeFantasia: nfceImprimirNomeFantasia ?? this.nfceImprimirNomeFantasia,
      nfceImpressaoTributos: nfceImpressaoTributos ?? this.nfceImpressaoTributos,
      nfceMargemSuperior: nfceMargemSuperior ?? this.nfceMargemSuperior,
      nfceMargemInferior: nfceMargemInferior ?? this.nfceMargemInferior,
      nfceMargemDireita: nfceMargemDireita ?? this.nfceMargemDireita,
      nfceMargemEsquerda: nfceMargemEsquerda ?? this.nfceMargemEsquerda,
      nfceResolucaoImpressao: nfceResolucaoImpressao ?? this.nfceResolucaoImpressao,
      respTecCnpj: respTecCnpj ?? this.respTecCnpj,
      respTecContato: respTecContato ?? this.respTecContato,
      respTecEmail: respTecEmail ?? this.respTecEmail,
      respTecFone: respTecFone ?? this.respTecFone,
      respTecIdCsrt: respTecIdCsrt ?? this.respTecIdCsrt,
      respTecHashCsrt: respTecHashCsrt ?? this.respTecHashCsrt,
      nfceTamanhoFonteItem: nfceTamanhoFonteItem ?? this.nfceTamanhoFonteItem,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (certificadoDigitalSerie.present) {
      map['CERTIFICADO_DIGITAL_SERIE'] = Variable<String?>(certificadoDigitalSerie.value);
    }
    if (certificadoDigitalCaminho.present) {
      map['CERTIFICADO_DIGITAL_CAMINHO'] = Variable<String?>(certificadoDigitalCaminho.value);
    }
    if (certificadoDigitalSenha.present) {
      map['CERTIFICADO_DIGITAL_SENHA'] = Variable<String?>(certificadoDigitalSenha.value);
    }
    if (tipoEmissao.present) {
      map['TIPO_EMISSAO'] = Variable<int?>(tipoEmissao.value);
    }
    if (formatoImpressaoDanfe.present) {
      map['FORMATO_IMPRESSAO_DANFE'] = Variable<int?>(formatoImpressaoDanfe.value);
    }
    if (processoEmissao.present) {
      map['PROCESSO_EMISSAO'] = Variable<int?>(processoEmissao.value);
    }
    if (versaoProcessoEmissao.present) {
      map['VERSAO_PROCESSO_EMISSAO'] = Variable<String?>(versaoProcessoEmissao.value);
    }
    if (caminhoLogomarca.present) {
      map['CAMINHO_LOGOMARCA'] = Variable<String?>(caminhoLogomarca.value);
    }
    if (salvarXml.present) {
      map['SALVAR_XML'] = Variable<String?>(salvarXml.value);
    }
    if (caminhoSalvarXml.present) {
      map['CAMINHO_SALVAR_XML'] = Variable<String?>(caminhoSalvarXml.value);
    }
    if (caminhoSchemas.present) {
      map['CAMINHO_SCHEMAS'] = Variable<String?>(caminhoSchemas.value);
    }
    if (caminhoArquivoDanfe.present) {
      map['CAMINHO_ARQUIVO_DANFE'] = Variable<String?>(caminhoArquivoDanfe.value);
    }
    if (caminhoSalvarPdf.present) {
      map['CAMINHO_SALVAR_PDF'] = Variable<String?>(caminhoSalvarPdf.value);
    }
    if (webserviceUf.present) {
      map['WEBSERVICE_UF'] = Variable<String?>(webserviceUf.value);
    }
    if (webserviceAmbiente.present) {
      map['WEBSERVICE_AMBIENTE'] = Variable<int?>(webserviceAmbiente.value);
    }
    if (webserviceProxyHost.present) {
      map['WEBSERVICE_PROXY_HOST'] = Variable<String?>(webserviceProxyHost.value);
    }
    if (webserviceProxyPorta.present) {
      map['WEBSERVICE_PROXY_PORTA'] = Variable<int?>(webserviceProxyPorta.value);
    }
    if (webserviceProxyUsuario.present) {
      map['WEBSERVICE_PROXY_USUARIO'] = Variable<String?>(webserviceProxyUsuario.value);
    }
    if (webserviceProxySenha.present) {
      map['WEBSERVICE_PROXY_SENHA'] = Variable<String?>(webserviceProxySenha.value);
    }
    if (webserviceVisualizar.present) {
      map['WEBSERVICE_VISUALIZAR'] = Variable<String?>(webserviceVisualizar.value);
    }
    if (emailServidorSmtp.present) {
      map['EMAIL_SERVIDOR_SMTP'] = Variable<String?>(emailServidorSmtp.value);
    }
    if (emailPorta.present) {
      map['EMAIL_PORTA'] = Variable<int?>(emailPorta.value);
    }
    if (emailUsuario.present) {
      map['EMAIL_USUARIO'] = Variable<String?>(emailUsuario.value);
    }
    if (emailSenha.present) {
      map['EMAIL_SENHA'] = Variable<String?>(emailSenha.value);
    }
    if (emailAssunto.present) {
      map['EMAIL_ASSUNTO'] = Variable<String?>(emailAssunto.value);
    }
    if (emailAutenticaSsl.present) {
      map['EMAIL_AUTENTICA_SSL'] = Variable<String?>(emailAutenticaSsl.value);
    }
    if (emailTexto.present) {
      map['EMAIL_TEXTO'] = Variable<String?>(emailTexto.value);
    }
    if (nfceIdCsc.present) {
      map['NFCE_ID_CSC'] = Variable<String?>(nfceIdCsc.value);
    }
    if (nfceCsc.present) {
      map['NFCE_CSC'] = Variable<String?>(nfceCsc.value);
    }
    if (nfceModeloImpressao.present) {
      map['NFCE_MODELO_IMPRESSAO'] = Variable<String?>(nfceModeloImpressao.value);
    }
    if (nfceImprimirItensUmaLinha.present) {
      map['NFCE_IMPRIMIR_ITENS_UMA_LINHA'] = Variable<String?>(nfceImprimirItensUmaLinha.value);
    }
    if (nfceImprimirDescontoPorItem.present) {
      map['NFCE_IMPRIMIR_DESCONTO_POR_ITEM'] = Variable<String?>(nfceImprimirDescontoPorItem.value);
    }
    if (nfceImprimirQrcodeLateral.present) {
      map['NFCE_IMPRIMIR_QRCODE_LATERAL'] = Variable<String?>(nfceImprimirQrcodeLateral.value);
    }
    if (nfceImprimirGtin.present) {
      map['NFCE_IMPRIMIR_GTIN'] = Variable<String?>(nfceImprimirGtin.value);
    }
    if (nfceImprimirNomeFantasia.present) {
      map['NFCE_IMPRIMIR_NOME_FANTASIA'] = Variable<String?>(nfceImprimirNomeFantasia.value);
    }
    if (nfceImpressaoTributos.present) {
      map['NFCE_IMPRESSAO_TRIBUTOS'] = Variable<String?>(nfceImpressaoTributos.value);
    }
    if (nfceMargemSuperior.present) {
      map['NFCE_MARGEM_SUPERIOR'] = Variable<double?>(nfceMargemSuperior.value);
    }
    if (nfceMargemInferior.present) {
      map['NFCE_MARGEM_INFERIOR'] = Variable<double?>(nfceMargemInferior.value);
    }
    if (nfceMargemDireita.present) {
      map['NFCE_MARGEM_DIREITA'] = Variable<double?>(nfceMargemDireita.value);
    }
    if (nfceMargemEsquerda.present) {
      map['NFCE_MARGEM_ESQUERDA'] = Variable<double?>(nfceMargemEsquerda.value);
    }
    if (nfceResolucaoImpressao.present) {
      map['NFCE_RESOLUCAO_IMPRESSAO'] = Variable<int?>(nfceResolucaoImpressao.value);
    }
    if (respTecCnpj.present) {
      map['RESP_TEC_CNPJ'] = Variable<String?>(respTecCnpj.value);
    }
    if (respTecContato.present) {
      map['RESP_TEC_CONTATO'] = Variable<String?>(respTecContato.value);
    }
    if (respTecEmail.present) {
      map['RESP_TEC_EMAIL'] = Variable<String?>(respTecEmail.value);
    }
    if (respTecFone.present) {
      map['RESP_TEC_FONE'] = Variable<String?>(respTecFone.value);
    }
    if (respTecIdCsrt.present) {
      map['RESP_TEC_ID_CSRT'] = Variable<String?>(respTecIdCsrt.value);
    }
    if (respTecHashCsrt.present) {
      map['RESP_TEC_HASH_CSRT'] = Variable<String?>(respTecHashCsrt.value);
    }
    if (nfceTamanhoFonteItem.present) {
      map['NFCE_TAMANHO_FONTE_ITEM'] = Variable<int?>(nfceTamanhoFonteItem.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeConfiguracaosCompanion(')
          ..write('id: $id, ')
          ..write('certificadoDigitalSerie: $certificadoDigitalSerie, ')
          ..write('certificadoDigitalCaminho: $certificadoDigitalCaminho, ')
          ..write('certificadoDigitalSenha: $certificadoDigitalSenha, ')
          ..write('tipoEmissao: $tipoEmissao, ')
          ..write('formatoImpressaoDanfe: $formatoImpressaoDanfe, ')
          ..write('processoEmissao: $processoEmissao, ')
          ..write('versaoProcessoEmissao: $versaoProcessoEmissao, ')
          ..write('caminhoLogomarca: $caminhoLogomarca, ')
          ..write('salvarXml: $salvarXml, ')
          ..write('caminhoSalvarXml: $caminhoSalvarXml, ')
          ..write('caminhoSchemas: $caminhoSchemas, ')
          ..write('caminhoArquivoDanfe: $caminhoArquivoDanfe, ')
          ..write('caminhoSalvarPdf: $caminhoSalvarPdf, ')
          ..write('webserviceUf: $webserviceUf, ')
          ..write('webserviceAmbiente: $webserviceAmbiente, ')
          ..write('webserviceProxyHost: $webserviceProxyHost, ')
          ..write('webserviceProxyPorta: $webserviceProxyPorta, ')
          ..write('webserviceProxyUsuario: $webserviceProxyUsuario, ')
          ..write('webserviceProxySenha: $webserviceProxySenha, ')
          ..write('webserviceVisualizar: $webserviceVisualizar, ')
          ..write('emailServidorSmtp: $emailServidorSmtp, ')
          ..write('emailPorta: $emailPorta, ')
          ..write('emailUsuario: $emailUsuario, ')
          ..write('emailSenha: $emailSenha, ')
          ..write('emailAssunto: $emailAssunto, ')
          ..write('emailAutenticaSsl: $emailAutenticaSsl, ')
          ..write('emailTexto: $emailTexto, ')
          ..write('nfceIdCsc: $nfceIdCsc, ')
          ..write('nfceCsc: $nfceCsc, ')
          ..write('nfceModeloImpressao: $nfceModeloImpressao, ')
          ..write('nfceImprimirItensUmaLinha: $nfceImprimirItensUmaLinha, ')
          ..write('nfceImprimirDescontoPorItem: $nfceImprimirDescontoPorItem, ')
          ..write('nfceImprimirQrcodeLateral: $nfceImprimirQrcodeLateral, ')
          ..write('nfceImprimirGtin: $nfceImprimirGtin, ')
          ..write('nfceImprimirNomeFantasia: $nfceImprimirNomeFantasia, ')
          ..write('nfceImpressaoTributos: $nfceImpressaoTributos, ')
          ..write('nfceMargemSuperior: $nfceMargemSuperior, ')
          ..write('nfceMargemInferior: $nfceMargemInferior, ')
          ..write('nfceMargemDireita: $nfceMargemDireita, ')
          ..write('nfceMargemEsquerda: $nfceMargemEsquerda, ')
          ..write('nfceResolucaoImpressao: $nfceResolucaoImpressao, ')
          ..write('respTecCnpj: $respTecCnpj, ')
          ..write('respTecContato: $respTecContato, ')
          ..write('respTecEmail: $respTecEmail, ')
          ..write('respTecFone: $respTecFone, ')
          ..write('respTecIdCsrt: $respTecIdCsrt, ')
          ..write('respTecHashCsrt: $respTecHashCsrt, ')
          ..write('nfceTamanhoFonteItem: $nfceTamanhoFonteItem, ')
          ..write(')'))
        .toString();
  }
}

class $NfeConfiguracaosTable extends NfeConfiguracaos
    with TableInfo<$NfeConfiguracaosTable, NfeConfiguracao> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeConfiguracaosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _certificadoDigitalSerieMeta =
      const VerificationMeta('certificadoDigitalSerie');
  GeneratedColumn<String>? _certificadoDigitalSerie;
  @override
  GeneratedColumn<String> get certificadoDigitalSerie => _certificadoDigitalSerie ??=
      GeneratedColumn<String>('CERTIFICADO_DIGITAL_SERIE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _certificadoDigitalCaminhoMeta =
      const VerificationMeta('certificadoDigitalCaminho');
  GeneratedColumn<String>? _certificadoDigitalCaminho;
  @override
  GeneratedColumn<String> get certificadoDigitalCaminho => _certificadoDigitalCaminho ??=
      GeneratedColumn<String>('CERTIFICADO_DIGITAL_CAMINHO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _certificadoDigitalSenhaMeta =
      const VerificationMeta('certificadoDigitalSenha');
  GeneratedColumn<String>? _certificadoDigitalSenha;
  @override
  GeneratedColumn<String> get certificadoDigitalSenha => _certificadoDigitalSenha ??=
      GeneratedColumn<String>('CERTIFICADO_DIGITAL_SENHA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _tipoEmissaoMeta =
      const VerificationMeta('tipoEmissao');
  GeneratedColumn<int>? _tipoEmissao;
  @override
  GeneratedColumn<int> get tipoEmissao => _tipoEmissao ??=
      GeneratedColumn<int>('TIPO_EMISSAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _formatoImpressaoDanfeMeta =
      const VerificationMeta('formatoImpressaoDanfe');
  GeneratedColumn<int>? _formatoImpressaoDanfe;
  @override
  GeneratedColumn<int> get formatoImpressaoDanfe => _formatoImpressaoDanfe ??=
      GeneratedColumn<int>('FORMATO_IMPRESSAO_DANFE', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _processoEmissaoMeta =
      const VerificationMeta('processoEmissao');
  GeneratedColumn<int>? _processoEmissao;
  @override
  GeneratedColumn<int> get processoEmissao => _processoEmissao ??=
      GeneratedColumn<int>('PROCESSO_EMISSAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _versaoProcessoEmissaoMeta =
      const VerificationMeta('versaoProcessoEmissao');
  GeneratedColumn<String>? _versaoProcessoEmissao;
  @override
  GeneratedColumn<String> get versaoProcessoEmissao => _versaoProcessoEmissao ??=
      GeneratedColumn<String>('VERSAO_PROCESSO_EMISSAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _caminhoLogomarcaMeta =
      const VerificationMeta('caminhoLogomarca');
  GeneratedColumn<String>? _caminhoLogomarca;
  @override
  GeneratedColumn<String> get caminhoLogomarca => _caminhoLogomarca ??=
      GeneratedColumn<String>('CAMINHO_LOGOMARCA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _salvarXmlMeta =
      const VerificationMeta('salvarXml');
  GeneratedColumn<String>? _salvarXml;
  @override
  GeneratedColumn<String> get salvarXml => _salvarXml ??=
      GeneratedColumn<String>('SALVAR_XML', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _caminhoSalvarXmlMeta =
      const VerificationMeta('caminhoSalvarXml');
  GeneratedColumn<String>? _caminhoSalvarXml;
  @override
  GeneratedColumn<String> get caminhoSalvarXml => _caminhoSalvarXml ??=
      GeneratedColumn<String>('CAMINHO_SALVAR_XML', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _caminhoSchemasMeta =
      const VerificationMeta('caminhoSchemas');
  GeneratedColumn<String>? _caminhoSchemas;
  @override
  GeneratedColumn<String> get caminhoSchemas => _caminhoSchemas ??=
      GeneratedColumn<String>('CAMINHO_SCHEMAS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _caminhoArquivoDanfeMeta =
      const VerificationMeta('caminhoArquivoDanfe');
  GeneratedColumn<String>? _caminhoArquivoDanfe;
  @override
  GeneratedColumn<String> get caminhoArquivoDanfe => _caminhoArquivoDanfe ??=
      GeneratedColumn<String>('CAMINHO_ARQUIVO_DANFE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _caminhoSalvarPdfMeta =
      const VerificationMeta('caminhoSalvarPdf');
  GeneratedColumn<String>? _caminhoSalvarPdf;
  @override
  GeneratedColumn<String> get caminhoSalvarPdf => _caminhoSalvarPdf ??=
      GeneratedColumn<String>('CAMINHO_SALVAR_PDF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _webserviceUfMeta =
      const VerificationMeta('webserviceUf');
  GeneratedColumn<String>? _webserviceUf;
  @override
  GeneratedColumn<String> get webserviceUf => _webserviceUf ??=
      GeneratedColumn<String>('WEBSERVICE_UF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _webserviceAmbienteMeta =
      const VerificationMeta('webserviceAmbiente');
  GeneratedColumn<int>? _webserviceAmbiente;
  @override
  GeneratedColumn<int> get webserviceAmbiente => _webserviceAmbiente ??=
      GeneratedColumn<int>('WEBSERVICE_AMBIENTE', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _webserviceProxyHostMeta =
      const VerificationMeta('webserviceProxyHost');
  GeneratedColumn<String>? _webserviceProxyHost;
  @override
  GeneratedColumn<String> get webserviceProxyHost => _webserviceProxyHost ??=
      GeneratedColumn<String>('WEBSERVICE_PROXY_HOST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _webserviceProxyPortaMeta =
      const VerificationMeta('webserviceProxyPorta');
  GeneratedColumn<int>? _webserviceProxyPorta;
  @override
  GeneratedColumn<int> get webserviceProxyPorta => _webserviceProxyPorta ??=
      GeneratedColumn<int>('WEBSERVICE_PROXY_PORTA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _webserviceProxyUsuarioMeta =
      const VerificationMeta('webserviceProxyUsuario');
  GeneratedColumn<String>? _webserviceProxyUsuario;
  @override
  GeneratedColumn<String> get webserviceProxyUsuario => _webserviceProxyUsuario ??=
      GeneratedColumn<String>('WEBSERVICE_PROXY_USUARIO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _webserviceProxySenhaMeta =
      const VerificationMeta('webserviceProxySenha');
  GeneratedColumn<String>? _webserviceProxySenha;
  @override
  GeneratedColumn<String> get webserviceProxySenha => _webserviceProxySenha ??=
      GeneratedColumn<String>('WEBSERVICE_PROXY_SENHA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _webserviceVisualizarMeta =
      const VerificationMeta('webserviceVisualizar');
  GeneratedColumn<String>? _webserviceVisualizar;
  @override
  GeneratedColumn<String> get webserviceVisualizar => _webserviceVisualizar ??=
      GeneratedColumn<String>('WEBSERVICE_VISUALIZAR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailServidorSmtpMeta =
      const VerificationMeta('emailServidorSmtp');
  GeneratedColumn<String>? _emailServidorSmtp;
  @override
  GeneratedColumn<String> get emailServidorSmtp => _emailServidorSmtp ??=
      GeneratedColumn<String>('EMAIL_SERVIDOR_SMTP', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailPortaMeta =
      const VerificationMeta('emailPorta');
  GeneratedColumn<int>? _emailPorta;
  @override
  GeneratedColumn<int> get emailPorta => _emailPorta ??=
      GeneratedColumn<int>('EMAIL_PORTA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _emailUsuarioMeta =
      const VerificationMeta('emailUsuario');
  GeneratedColumn<String>? _emailUsuario;
  @override
  GeneratedColumn<String> get emailUsuario => _emailUsuario ??=
      GeneratedColumn<String>('EMAIL_USUARIO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailSenhaMeta =
      const VerificationMeta('emailSenha');
  GeneratedColumn<String>? _emailSenha;
  @override
  GeneratedColumn<String> get emailSenha => _emailSenha ??=
      GeneratedColumn<String>('EMAIL_SENHA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailAssuntoMeta =
      const VerificationMeta('emailAssunto');
  GeneratedColumn<String>? _emailAssunto;
  @override
  GeneratedColumn<String> get emailAssunto => _emailAssunto ??=
      GeneratedColumn<String>('EMAIL_ASSUNTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailAutenticaSslMeta =
      const VerificationMeta('emailAutenticaSsl');
  GeneratedColumn<String>? _emailAutenticaSsl;
  @override
  GeneratedColumn<String> get emailAutenticaSsl => _emailAutenticaSsl ??=
      GeneratedColumn<String>('EMAIL_AUTENTICA_SSL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailTextoMeta =
      const VerificationMeta('emailTexto');
  GeneratedColumn<String>? _emailTexto;
  @override
  GeneratedColumn<String> get emailTexto => _emailTexto ??=
      GeneratedColumn<String>('EMAIL_TEXTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceIdCscMeta =
      const VerificationMeta('nfceIdCsc');
  GeneratedColumn<String>? _nfceIdCsc;
  @override
  GeneratedColumn<String> get nfceIdCsc => _nfceIdCsc ??=
      GeneratedColumn<String>('NFCE_ID_CSC', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceCscMeta =
      const VerificationMeta('nfceCsc');
  GeneratedColumn<String>? _nfceCsc;
  @override
  GeneratedColumn<String> get nfceCsc => _nfceCsc ??=
      GeneratedColumn<String>('NFCE_CSC', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceModeloImpressaoMeta =
      const VerificationMeta('nfceModeloImpressao');
  GeneratedColumn<String>? _nfceModeloImpressao;
  @override
  GeneratedColumn<String> get nfceModeloImpressao => _nfceModeloImpressao ??=
      GeneratedColumn<String>('NFCE_MODELO_IMPRESSAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceImprimirItensUmaLinhaMeta =
      const VerificationMeta('nfceImprimirItensUmaLinha');
  GeneratedColumn<String>? _nfceImprimirItensUmaLinha;
  @override
  GeneratedColumn<String> get nfceImprimirItensUmaLinha => _nfceImprimirItensUmaLinha ??=
      GeneratedColumn<String>('NFCE_IMPRIMIR_ITENS_UMA_LINHA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceImprimirDescontoPorItemMeta =
      const VerificationMeta('nfceImprimirDescontoPorItem');
  GeneratedColumn<String>? _nfceImprimirDescontoPorItem;
  @override
  GeneratedColumn<String> get nfceImprimirDescontoPorItem => _nfceImprimirDescontoPorItem ??=
      GeneratedColumn<String>('NFCE_IMPRIMIR_DESCONTO_POR_ITEM', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceImprimirQrcodeLateralMeta =
      const VerificationMeta('nfceImprimirQrcodeLateral');
  GeneratedColumn<String>? _nfceImprimirQrcodeLateral;
  @override
  GeneratedColumn<String> get nfceImprimirQrcodeLateral => _nfceImprimirQrcodeLateral ??=
      GeneratedColumn<String>('NFCE_IMPRIMIR_QRCODE_LATERAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceImprimirGtinMeta =
      const VerificationMeta('nfceImprimirGtin');
  GeneratedColumn<String>? _nfceImprimirGtin;
  @override
  GeneratedColumn<String> get nfceImprimirGtin => _nfceImprimirGtin ??=
      GeneratedColumn<String>('NFCE_IMPRIMIR_GTIN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceImprimirNomeFantasiaMeta =
      const VerificationMeta('nfceImprimirNomeFantasia');
  GeneratedColumn<String>? _nfceImprimirNomeFantasia;
  @override
  GeneratedColumn<String> get nfceImprimirNomeFantasia => _nfceImprimirNomeFantasia ??=
      GeneratedColumn<String>('NFCE_IMPRIMIR_NOME_FANTASIA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceImpressaoTributosMeta =
      const VerificationMeta('nfceImpressaoTributos');
  GeneratedColumn<String>? _nfceImpressaoTributos;
  @override
  GeneratedColumn<String> get nfceImpressaoTributos => _nfceImpressaoTributos ??=
      GeneratedColumn<String>('NFCE_IMPRESSAO_TRIBUTOS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceMargemSuperiorMeta =
      const VerificationMeta('nfceMargemSuperior');
  GeneratedColumn<double>? _nfceMargemSuperior;
  @override
  GeneratedColumn<double> get nfceMargemSuperior => _nfceMargemSuperior ??=
      GeneratedColumn<double>('NFCE_MARGEM_SUPERIOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _nfceMargemInferiorMeta =
      const VerificationMeta('nfceMargemInferior');
  GeneratedColumn<double>? _nfceMargemInferior;
  @override
  GeneratedColumn<double> get nfceMargemInferior => _nfceMargemInferior ??=
      GeneratedColumn<double>('NFCE_MARGEM_INFERIOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _nfceMargemDireitaMeta =
      const VerificationMeta('nfceMargemDireita');
  GeneratedColumn<double>? _nfceMargemDireita;
  @override
  GeneratedColumn<double> get nfceMargemDireita => _nfceMargemDireita ??=
      GeneratedColumn<double>('NFCE_MARGEM_DIREITA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _nfceMargemEsquerdaMeta =
      const VerificationMeta('nfceMargemEsquerda');
  GeneratedColumn<double>? _nfceMargemEsquerda;
  @override
  GeneratedColumn<double> get nfceMargemEsquerda => _nfceMargemEsquerda ??=
      GeneratedColumn<double>('NFCE_MARGEM_ESQUERDA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _nfceResolucaoImpressaoMeta =
      const VerificationMeta('nfceResolucaoImpressao');
  GeneratedColumn<int>? _nfceResolucaoImpressao;
  @override
  GeneratedColumn<int> get nfceResolucaoImpressao => _nfceResolucaoImpressao ??=
      GeneratedColumn<int>('NFCE_RESOLUCAO_IMPRESSAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _respTecCnpjMeta =
      const VerificationMeta('respTecCnpj');
  GeneratedColumn<String>? _respTecCnpj;
  @override
  GeneratedColumn<String> get respTecCnpj => _respTecCnpj ??=
      GeneratedColumn<String>('RESP_TEC_CNPJ', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _respTecContatoMeta =
      const VerificationMeta('respTecContato');
  GeneratedColumn<String>? _respTecContato;
  @override
  GeneratedColumn<String> get respTecContato => _respTecContato ??=
      GeneratedColumn<String>('RESP_TEC_CONTATO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _respTecEmailMeta =
      const VerificationMeta('respTecEmail');
  GeneratedColumn<String>? _respTecEmail;
  @override
  GeneratedColumn<String> get respTecEmail => _respTecEmail ??=
      GeneratedColumn<String>('RESP_TEC_EMAIL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _respTecFoneMeta =
      const VerificationMeta('respTecFone');
  GeneratedColumn<String>? _respTecFone;
  @override
  GeneratedColumn<String> get respTecFone => _respTecFone ??=
      GeneratedColumn<String>('RESP_TEC_FONE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _respTecIdCsrtMeta =
      const VerificationMeta('respTecIdCsrt');
  GeneratedColumn<String>? _respTecIdCsrt;
  @override
  GeneratedColumn<String> get respTecIdCsrt => _respTecIdCsrt ??=
      GeneratedColumn<String>('RESP_TEC_ID_CSRT', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _respTecHashCsrtMeta =
      const VerificationMeta('respTecHashCsrt');
  GeneratedColumn<String>? _respTecHashCsrt;
  @override
  GeneratedColumn<String> get respTecHashCsrt => _respTecHashCsrt ??=
      GeneratedColumn<String>('RESP_TEC_HASH_CSRT', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nfceTamanhoFonteItemMeta =
      const VerificationMeta('nfceTamanhoFonteItem');
  GeneratedColumn<int>? _nfceTamanhoFonteItem;
  @override
  GeneratedColumn<int> get nfceTamanhoFonteItem => _nfceTamanhoFonteItem ??=
      GeneratedColumn<int>('NFCE_TAMANHO_FONTE_ITEM', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        certificadoDigitalSerie,
        certificadoDigitalCaminho,
        certificadoDigitalSenha,
        tipoEmissao,
        formatoImpressaoDanfe,
        processoEmissao,
        versaoProcessoEmissao,
        caminhoLogomarca,
        salvarXml,
        caminhoSalvarXml,
        caminhoSchemas,
        caminhoArquivoDanfe,
        caminhoSalvarPdf,
        webserviceUf,
        webserviceAmbiente,
        webserviceProxyHost,
        webserviceProxyPorta,
        webserviceProxyUsuario,
        webserviceProxySenha,
        webserviceVisualizar,
        emailServidorSmtp,
        emailPorta,
        emailUsuario,
        emailSenha,
        emailAssunto,
        emailAutenticaSsl,
        emailTexto,
        nfceIdCsc,
        nfceCsc,
        nfceModeloImpressao,
        nfceImprimirItensUmaLinha,
        nfceImprimirDescontoPorItem,
        nfceImprimirQrcodeLateral,
        nfceImprimirGtin,
        nfceImprimirNomeFantasia,
        nfceImpressaoTributos,
        nfceMargemSuperior,
        nfceMargemInferior,
        nfceMargemDireita,
        nfceMargemEsquerda,
        nfceResolucaoImpressao,
        respTecCnpj,
        respTecContato,
        respTecEmail,
        respTecFone,
        respTecIdCsrt,
        respTecHashCsrt,
        nfceTamanhoFonteItem,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_CONFIGURACAO';
  
  @override
  String get actualTableName => 'NFE_CONFIGURACAO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeConfiguracao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('CERTIFICADO_DIGITAL_SERIE')) {
        context.handle(_certificadoDigitalSerieMeta,
            certificadoDigitalSerie.isAcceptableOrUnknown(data['CERTIFICADO_DIGITAL_SERIE']!, _certificadoDigitalSerieMeta));
    }
    if (data.containsKey('CERTIFICADO_DIGITAL_CAMINHO')) {
        context.handle(_certificadoDigitalCaminhoMeta,
            certificadoDigitalCaminho.isAcceptableOrUnknown(data['CERTIFICADO_DIGITAL_CAMINHO']!, _certificadoDigitalCaminhoMeta));
    }
    if (data.containsKey('CERTIFICADO_DIGITAL_SENHA')) {
        context.handle(_certificadoDigitalSenhaMeta,
            certificadoDigitalSenha.isAcceptableOrUnknown(data['CERTIFICADO_DIGITAL_SENHA']!, _certificadoDigitalSenhaMeta));
    }
    if (data.containsKey('TIPO_EMISSAO')) {
        context.handle(_tipoEmissaoMeta,
            tipoEmissao.isAcceptableOrUnknown(data['TIPO_EMISSAO']!, _tipoEmissaoMeta));
    }
    if (data.containsKey('FORMATO_IMPRESSAO_DANFE')) {
        context.handle(_formatoImpressaoDanfeMeta,
            formatoImpressaoDanfe.isAcceptableOrUnknown(data['FORMATO_IMPRESSAO_DANFE']!, _formatoImpressaoDanfeMeta));
    }
    if (data.containsKey('PROCESSO_EMISSAO')) {
        context.handle(_processoEmissaoMeta,
            processoEmissao.isAcceptableOrUnknown(data['PROCESSO_EMISSAO']!, _processoEmissaoMeta));
    }
    if (data.containsKey('VERSAO_PROCESSO_EMISSAO')) {
        context.handle(_versaoProcessoEmissaoMeta,
            versaoProcessoEmissao.isAcceptableOrUnknown(data['VERSAO_PROCESSO_EMISSAO']!, _versaoProcessoEmissaoMeta));
    }
    if (data.containsKey('CAMINHO_LOGOMARCA')) {
        context.handle(_caminhoLogomarcaMeta,
            caminhoLogomarca.isAcceptableOrUnknown(data['CAMINHO_LOGOMARCA']!, _caminhoLogomarcaMeta));
    }
    if (data.containsKey('SALVAR_XML')) {
        context.handle(_salvarXmlMeta,
            salvarXml.isAcceptableOrUnknown(data['SALVAR_XML']!, _salvarXmlMeta));
    }
    if (data.containsKey('CAMINHO_SALVAR_XML')) {
        context.handle(_caminhoSalvarXmlMeta,
            caminhoSalvarXml.isAcceptableOrUnknown(data['CAMINHO_SALVAR_XML']!, _caminhoSalvarXmlMeta));
    }
    if (data.containsKey('CAMINHO_SCHEMAS')) {
        context.handle(_caminhoSchemasMeta,
            caminhoSchemas.isAcceptableOrUnknown(data['CAMINHO_SCHEMAS']!, _caminhoSchemasMeta));
    }
    if (data.containsKey('CAMINHO_ARQUIVO_DANFE')) {
        context.handle(_caminhoArquivoDanfeMeta,
            caminhoArquivoDanfe.isAcceptableOrUnknown(data['CAMINHO_ARQUIVO_DANFE']!, _caminhoArquivoDanfeMeta));
    }
    if (data.containsKey('CAMINHO_SALVAR_PDF')) {
        context.handle(_caminhoSalvarPdfMeta,
            caminhoSalvarPdf.isAcceptableOrUnknown(data['CAMINHO_SALVAR_PDF']!, _caminhoSalvarPdfMeta));
    }
    if (data.containsKey('WEBSERVICE_UF')) {
        context.handle(_webserviceUfMeta,
            webserviceUf.isAcceptableOrUnknown(data['WEBSERVICE_UF']!, _webserviceUfMeta));
    }
    if (data.containsKey('WEBSERVICE_AMBIENTE')) {
        context.handle(_webserviceAmbienteMeta,
            webserviceAmbiente.isAcceptableOrUnknown(data['WEBSERVICE_AMBIENTE']!, _webserviceAmbienteMeta));
    }
    if (data.containsKey('WEBSERVICE_PROXY_HOST')) {
        context.handle(_webserviceProxyHostMeta,
            webserviceProxyHost.isAcceptableOrUnknown(data['WEBSERVICE_PROXY_HOST']!, _webserviceProxyHostMeta));
    }
    if (data.containsKey('WEBSERVICE_PROXY_PORTA')) {
        context.handle(_webserviceProxyPortaMeta,
            webserviceProxyPorta.isAcceptableOrUnknown(data['WEBSERVICE_PROXY_PORTA']!, _webserviceProxyPortaMeta));
    }
    if (data.containsKey('WEBSERVICE_PROXY_USUARIO')) {
        context.handle(_webserviceProxyUsuarioMeta,
            webserviceProxyUsuario.isAcceptableOrUnknown(data['WEBSERVICE_PROXY_USUARIO']!, _webserviceProxyUsuarioMeta));
    }
    if (data.containsKey('WEBSERVICE_PROXY_SENHA')) {
        context.handle(_webserviceProxySenhaMeta,
            webserviceProxySenha.isAcceptableOrUnknown(data['WEBSERVICE_PROXY_SENHA']!, _webserviceProxySenhaMeta));
    }
    if (data.containsKey('WEBSERVICE_VISUALIZAR')) {
        context.handle(_webserviceVisualizarMeta,
            webserviceVisualizar.isAcceptableOrUnknown(data['WEBSERVICE_VISUALIZAR']!, _webserviceVisualizarMeta));
    }
    if (data.containsKey('EMAIL_SERVIDOR_SMTP')) {
        context.handle(_emailServidorSmtpMeta,
            emailServidorSmtp.isAcceptableOrUnknown(data['EMAIL_SERVIDOR_SMTP']!, _emailServidorSmtpMeta));
    }
    if (data.containsKey('EMAIL_PORTA')) {
        context.handle(_emailPortaMeta,
            emailPorta.isAcceptableOrUnknown(data['EMAIL_PORTA']!, _emailPortaMeta));
    }
    if (data.containsKey('EMAIL_USUARIO')) {
        context.handle(_emailUsuarioMeta,
            emailUsuario.isAcceptableOrUnknown(data['EMAIL_USUARIO']!, _emailUsuarioMeta));
    }
    if (data.containsKey('EMAIL_SENHA')) {
        context.handle(_emailSenhaMeta,
            emailSenha.isAcceptableOrUnknown(data['EMAIL_SENHA']!, _emailSenhaMeta));
    }
    if (data.containsKey('EMAIL_ASSUNTO')) {
        context.handle(_emailAssuntoMeta,
            emailAssunto.isAcceptableOrUnknown(data['EMAIL_ASSUNTO']!, _emailAssuntoMeta));
    }
    if (data.containsKey('EMAIL_AUTENTICA_SSL')) {
        context.handle(_emailAutenticaSslMeta,
            emailAutenticaSsl.isAcceptableOrUnknown(data['EMAIL_AUTENTICA_SSL']!, _emailAutenticaSslMeta));
    }
    if (data.containsKey('EMAIL_TEXTO')) {
        context.handle(_emailTextoMeta,
            emailTexto.isAcceptableOrUnknown(data['EMAIL_TEXTO']!, _emailTextoMeta));
    }
    if (data.containsKey('NFCE_ID_CSC')) {
        context.handle(_nfceIdCscMeta,
            nfceIdCsc.isAcceptableOrUnknown(data['NFCE_ID_CSC']!, _nfceIdCscMeta));
    }
    if (data.containsKey('NFCE_CSC')) {
        context.handle(_nfceCscMeta,
            nfceCsc.isAcceptableOrUnknown(data['NFCE_CSC']!, _nfceCscMeta));
    }
    if (data.containsKey('NFCE_MODELO_IMPRESSAO')) {
        context.handle(_nfceModeloImpressaoMeta,
            nfceModeloImpressao.isAcceptableOrUnknown(data['NFCE_MODELO_IMPRESSAO']!, _nfceModeloImpressaoMeta));
    }
    if (data.containsKey('NFCE_IMPRIMIR_ITENS_UMA_LINHA')) {
        context.handle(_nfceImprimirItensUmaLinhaMeta,
            nfceImprimirItensUmaLinha.isAcceptableOrUnknown(data['NFCE_IMPRIMIR_ITENS_UMA_LINHA']!, _nfceImprimirItensUmaLinhaMeta));
    }
    if (data.containsKey('NFCE_IMPRIMIR_DESCONTO_POR_ITEM')) {
        context.handle(_nfceImprimirDescontoPorItemMeta,
            nfceImprimirDescontoPorItem.isAcceptableOrUnknown(data['NFCE_IMPRIMIR_DESCONTO_POR_ITEM']!, _nfceImprimirDescontoPorItemMeta));
    }
    if (data.containsKey('NFCE_IMPRIMIR_QRCODE_LATERAL')) {
        context.handle(_nfceImprimirQrcodeLateralMeta,
            nfceImprimirQrcodeLateral.isAcceptableOrUnknown(data['NFCE_IMPRIMIR_QRCODE_LATERAL']!, _nfceImprimirQrcodeLateralMeta));
    }
    if (data.containsKey('NFCE_IMPRIMIR_GTIN')) {
        context.handle(_nfceImprimirGtinMeta,
            nfceImprimirGtin.isAcceptableOrUnknown(data['NFCE_IMPRIMIR_GTIN']!, _nfceImprimirGtinMeta));
    }
    if (data.containsKey('NFCE_IMPRIMIR_NOME_FANTASIA')) {
        context.handle(_nfceImprimirNomeFantasiaMeta,
            nfceImprimirNomeFantasia.isAcceptableOrUnknown(data['NFCE_IMPRIMIR_NOME_FANTASIA']!, _nfceImprimirNomeFantasiaMeta));
    }
    if (data.containsKey('NFCE_IMPRESSAO_TRIBUTOS')) {
        context.handle(_nfceImpressaoTributosMeta,
            nfceImpressaoTributos.isAcceptableOrUnknown(data['NFCE_IMPRESSAO_TRIBUTOS']!, _nfceImpressaoTributosMeta));
    }
    if (data.containsKey('NFCE_MARGEM_SUPERIOR')) {
        context.handle(_nfceMargemSuperiorMeta,
            nfceMargemSuperior.isAcceptableOrUnknown(data['NFCE_MARGEM_SUPERIOR']!, _nfceMargemSuperiorMeta));
    }
    if (data.containsKey('NFCE_MARGEM_INFERIOR')) {
        context.handle(_nfceMargemInferiorMeta,
            nfceMargemInferior.isAcceptableOrUnknown(data['NFCE_MARGEM_INFERIOR']!, _nfceMargemInferiorMeta));
    }
    if (data.containsKey('NFCE_MARGEM_DIREITA')) {
        context.handle(_nfceMargemDireitaMeta,
            nfceMargemDireita.isAcceptableOrUnknown(data['NFCE_MARGEM_DIREITA']!, _nfceMargemDireitaMeta));
    }
    if (data.containsKey('NFCE_MARGEM_ESQUERDA')) {
        context.handle(_nfceMargemEsquerdaMeta,
            nfceMargemEsquerda.isAcceptableOrUnknown(data['NFCE_MARGEM_ESQUERDA']!, _nfceMargemEsquerdaMeta));
    }
    if (data.containsKey('NFCE_RESOLUCAO_IMPRESSAO')) {
        context.handle(_nfceResolucaoImpressaoMeta,
            nfceResolucaoImpressao.isAcceptableOrUnknown(data['NFCE_RESOLUCAO_IMPRESSAO']!, _nfceResolucaoImpressaoMeta));
    }
    if (data.containsKey('RESP_TEC_CNPJ')) {
        context.handle(_respTecCnpjMeta,
            respTecCnpj.isAcceptableOrUnknown(data['RESP_TEC_CNPJ']!, _respTecCnpjMeta));
    }
    if (data.containsKey('RESP_TEC_CONTATO')) {
        context.handle(_respTecContatoMeta,
            respTecContato.isAcceptableOrUnknown(data['RESP_TEC_CONTATO']!, _respTecContatoMeta));
    }
    if (data.containsKey('RESP_TEC_EMAIL')) {
        context.handle(_respTecEmailMeta,
            respTecEmail.isAcceptableOrUnknown(data['RESP_TEC_EMAIL']!, _respTecEmailMeta));
    }
    if (data.containsKey('RESP_TEC_FONE')) {
        context.handle(_respTecFoneMeta,
            respTecFone.isAcceptableOrUnknown(data['RESP_TEC_FONE']!, _respTecFoneMeta));
    }
    if (data.containsKey('RESP_TEC_ID_CSRT')) {
        context.handle(_respTecIdCsrtMeta,
            respTecIdCsrt.isAcceptableOrUnknown(data['RESP_TEC_ID_CSRT']!, _respTecIdCsrtMeta));
    }
    if (data.containsKey('RESP_TEC_HASH_CSRT')) {
        context.handle(_respTecHashCsrtMeta,
            respTecHashCsrt.isAcceptableOrUnknown(data['RESP_TEC_HASH_CSRT']!, _respTecHashCsrtMeta));
    }
    if (data.containsKey('NFCE_TAMANHO_FONTE_ITEM')) {
        context.handle(_nfceTamanhoFonteItemMeta,
            nfceTamanhoFonteItem.isAcceptableOrUnknown(data['NFCE_TAMANHO_FONTE_ITEM']!, _nfceTamanhoFonteItemMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeConfiguracao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeConfiguracao.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeConfiguracaosTable createAlias(String alias) {
    return $NfeConfiguracaosTable(_db, alias);
  }
}