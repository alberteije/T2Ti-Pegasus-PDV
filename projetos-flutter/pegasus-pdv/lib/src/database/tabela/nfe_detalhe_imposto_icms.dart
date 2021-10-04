/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE_IMPOSTO_ICMS] 
                                                                                
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

@DataClassName("NfeDetalheImpostoIcms")
class NfeDetalheImpostoIcmss extends Table {
  String get tableName => 'NFE_DETALHE_IMPOSTO_ICMS';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  TextColumn get origemMercadoria => text().named('ORIGEM_MERCADORIA').withLength(min: 0, max: 1).nullable()();
  TextColumn get cstIcms => text().named('CST_ICMS').withLength(min: 0, max: 2).nullable()();
  TextColumn get csosn => text().named('CSOSN').withLength(min: 0, max: 3).nullable()();
  TextColumn get modalidadeBcIcms => text().named('MODALIDADE_BC_ICMS').withLength(min: 0, max: 1).nullable()();
  RealColumn get percentualReducaoBcIcms => real().named('PERCENTUAL_REDUCAO_BC_ICMS').nullable()();
  RealColumn get valorBcIcms => real().named('VALOR_BC_ICMS').nullable()();
  RealColumn get aliquotaIcms => real().named('ALIQUOTA_ICMS').nullable()();
  RealColumn get valorIcmsOperacao => real().named('VALOR_ICMS_OPERACAO').nullable()();
  RealColumn get percentualDiferimento => real().named('PERCENTUAL_DIFERIMENTO').nullable()();
  RealColumn get valorIcmsDiferido => real().named('VALOR_ICMS_DIFERIDO').nullable()();
  RealColumn get valorIcms => real().named('VALOR_ICMS').nullable()();
  RealColumn get baseCalculoFcp => real().named('BASE_CALCULO_FCP').nullable()();
  RealColumn get percentualFcp => real().named('PERCENTUAL_FCP').nullable()();
  RealColumn get valorFcp => real().named('VALOR_FCP').nullable()();
  TextColumn get modalidadeBcIcmsSt => text().named('MODALIDADE_BC_ICMS_ST').withLength(min: 0, max: 1).nullable()();
  RealColumn get percentualMvaIcmsSt => real().named('PERCENTUAL_MVA_ICMS_ST').nullable()();
  RealColumn get percentualReducaoBcIcmsSt => real().named('PERCENTUAL_REDUCAO_BC_ICMS_ST').nullable()();
  RealColumn get valorBaseCalculoIcmsSt => real().named('VALOR_BASE_CALCULO_ICMS_ST').nullable()();
  RealColumn get aliquotaIcmsSt => real().named('ALIQUOTA_ICMS_ST').nullable()();
  RealColumn get valorIcmsSt => real().named('VALOR_ICMS_ST').nullable()();
  RealColumn get baseCalculoFcpSt => real().named('BASE_CALCULO_FCP_ST').nullable()();
  RealColumn get percentualFcpSt => real().named('PERCENTUAL_FCP_ST').nullable()();
  RealColumn get valorFcpSt => real().named('VALOR_FCP_ST').nullable()();
  TextColumn get ufSt => text().named('UF_ST').withLength(min: 0, max: 2).nullable()();
  RealColumn get percentualBcOperacaoPropria => real().named('PERCENTUAL_BC_OPERACAO_PROPRIA').nullable()();
  RealColumn get valorBcIcmsStRetido => real().named('VALOR_BC_ICMS_ST_RETIDO').nullable()();
  RealColumn get aliquotaSuportadaConsumidor => real().named('ALIQUOTA_SUPORTADA_CONSUMIDOR').nullable()();
  RealColumn get valorIcmsSubstituto => real().named('VALOR_ICMS_SUBSTITUTO').nullable()();
  RealColumn get valorIcmsStRetido => real().named('VALOR_ICMS_ST_RETIDO').nullable()();
  RealColumn get baseCalculoFcpStRetido => real().named('BASE_CALCULO_FCP_ST_RETIDO').nullable()();
  RealColumn get percentualFcpStRetido => real().named('PERCENTUAL_FCP_ST_RETIDO').nullable()();
  RealColumn get valorFcpStRetido => real().named('VALOR_FCP_ST_RETIDO').nullable()();
  TextColumn get motivoDesoneracaoIcms => text().named('MOTIVO_DESONERACAO_ICMS').withLength(min: 0, max: 2).nullable()();
  RealColumn get valorIcmsDesonerado => real().named('VALOR_ICMS_DESONERADO').nullable()();
  RealColumn get aliquotaCreditoIcmsSn => real().named('ALIQUOTA_CREDITO_ICMS_SN').nullable()();
  RealColumn get valorCreditoIcmsSn => real().named('VALOR_CREDITO_ICMS_SN').nullable()();
  RealColumn get valorBcIcmsStDestino => real().named('VALOR_BC_ICMS_ST_DESTINO').nullable()();
  RealColumn get valorIcmsStDestino => real().named('VALOR_ICMS_ST_DESTINO').nullable()();
  RealColumn get percentualReducaoBcEfetivo => real().named('PERCENTUAL_REDUCAO_BC_EFETIVO').nullable()();
  RealColumn get valorBcEfetivo => real().named('VALOR_BC_EFETIVO').nullable()();
  RealColumn get aliquotaIcmsEfetivo => real().named('ALIQUOTA_ICMS_EFETIVO').nullable()();
  RealColumn get valorIcmsEfetivo => real().named('VALOR_ICMS_EFETIVO').nullable()();
}