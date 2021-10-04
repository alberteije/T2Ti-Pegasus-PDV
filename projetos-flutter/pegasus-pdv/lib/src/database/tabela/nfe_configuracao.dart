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
class NfeConfiguracaos extends Table {
  String get tableName => 'NFE_CONFIGURACAO';
  
  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get certificadoDigitalSerie => text().named('CERTIFICADO_DIGITAL_SERIE').withLength(min: 0, max: 100).nullable()();
  TextColumn get certificadoDigitalCaminho => text().named('CERTIFICADO_DIGITAL_CAMINHO').withLength(min: 0, max: 250).nullable()();
  TextColumn get certificadoDigitalSenha => text().named('CERTIFICADO_DIGITAL_SENHA').withLength(min: 0, max: 100).nullable()();
  IntColumn get tipoEmissao => integer().named('TIPO_EMISSAO').nullable()(); //tpEmis
  IntColumn get formatoImpressaoDanfe => integer().named('FORMATO_IMPRESSAO_DANFE').nullable()(); //4=DANFE NFC-e; 5=DANFE NFC-e em mensagem eletrônica
  IntColumn get processoEmissao => integer().named('PROCESSO_EMISSAO').nullable()(); 
  TextColumn get versaoProcessoEmissao => text().named('VERSAO_PROCESSO_EMISSAO').withLength(min: 0, max: 20).nullable()();
  TextColumn get caminhoLogomarca => text().named('CAMINHO_LOGOMARCA').withLength(min: 0, max: 250).nullable()();
  TextColumn get salvarXml => text().named('SALVAR_XML').withLength(min: 0, max: 1).nullable()();
  TextColumn get caminhoSalvarXml => text().named('CAMINHO_SALVAR_XML').withLength(min: 0, max: 250).nullable()(); // caminho onde o XML inicial criado pelo monitor foi salvo no servidor
  TextColumn get caminhoSchemas => text().named('CAMINHO_SCHEMAS').withLength(min: 0, max: 250).nullable()(); 
  TextColumn get caminhoArquivoDanfe => text().named('CAMINHO_ARQUIVO_DANFE').withLength(min: 0, max: 250).nullable()();
  TextColumn get caminhoSalvarPdf => text().named('CAMINHO_SALVAR_PDF').withLength(min: 0, max: 250).nullable()(); // caminho onde o PDF do DANFE foi salvo no servidor
  TextColumn get webserviceUf => text().named('WEBSERVICE_UF').withLength(min: 0, max: 2).nullable()();
  IntColumn get webserviceAmbiente => integer().named('WEBSERVICE_AMBIENTE').nullable()(); //tpAmb - 1-Produção/ 2-Homologação
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
  TextColumn get nfceModeloImpressao => text().named('NFCE_MODELO_IMPRESSAO').withLength(min: 0, max: 2).nullable()(); // A4 57 80
  TextColumn get nfceImprimirItensUmaLinha => text().named('NFCE_IMPRIMIR_ITENS_UMA_LINHA').withLength(min: 0, max: 1).nullable()(); //S N
  TextColumn get nfceImprimirDescontoPorItem => text().named('NFCE_IMPRIMIR_DESCONTO_POR_ITEM').withLength(min: 0, max: 1).nullable()(); //S N
  TextColumn get nfceImprimirQrcodeLateral => text().named('NFCE_IMPRIMIR_QRCODE_LATERAL').withLength(min: 0, max: 1).nullable()(); //S N
  TextColumn get nfceImprimirGtin => text().named('NFCE_IMPRIMIR_GTIN').withLength(min: 0, max: 1).nullable()(); //S N
  TextColumn get nfceImprimirNomeFantasia => text().named('NFCE_IMPRIMIR_NOME_FANTASIA').withLength(min: 0, max: 1).nullable()(); //S N
  TextColumn get nfceImpressaoTributos => text().named('NFCE_IMPRESSAO_TRIBUTOS').withLength(min: 0, max: 1).nullable()(); //Normal Separado
  RealColumn get nfceMargemSuperior => real().named('NFCE_MARGEM_SUPERIOR').nullable()();
  RealColumn get nfceMargemInferior => real().named('NFCE_MARGEM_INFERIOR').nullable()();
  RealColumn get nfceMargemDireita => real().named('NFCE_MARGEM_DIREITA').nullable()();
  RealColumn get nfceMargemEsquerda => real().named('NFCE_MARGEM_ESQUERDA').nullable()();
  IntColumn get nfceResolucaoImpressao => integer().named('NFCE_RESOLUCAO_IMPRESSAO').nullable()(); //largura da impressão no ACBrMonitor 302=80col 200=57col
  IntColumn get nfceTamanhoFonteItem => integer().named('NFCE_TAMANHO_FONTE_ITEM').nullable()();
  TextColumn get respTecCnpj => text().named('RESP_TEC_CNPJ').withLength(min: 0, max: 14).nullable()(); 
  TextColumn get respTecContato => text().named('RESP_TEC_CONTATO').withLength(min: 0, max: 60).nullable()(); 
  TextColumn get respTecEmail => text().named('RESP_TEC_EMAIL').withLength(min: 0, max: 60).nullable()(); 
  TextColumn get respTecFone => text().named('RESP_TEC_FONE').withLength(min: 0, max: 15).nullable()(); 
  TextColumn get respTecIdCsrt => text().named('RESP_TEC_ID_CSRT').withLength(min: 0, max: 2).nullable()(); 
  TextColumn get respTecHashCsrt => text().named('RESP_TEC_HASH_CSRT').withLength(min: 0, max: 28).nullable()(); 
}