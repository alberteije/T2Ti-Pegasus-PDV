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
@UseRowClass(NfeDetalheImpostoIcms)
class NfeDetalheImpostoIcmss extends Table {
  @override
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

class NfeDetalheImpostoIcms extends DataClass implements Insertable<NfeDetalheImpostoIcms> {
  final int? id;
  final int? idNfeDetalhe;
  final String? origemMercadoria;
  final String? cstIcms;
  final String? csosn;
  final String? modalidadeBcIcms;
  final double? percentualReducaoBcIcms;
  final double? valorBcIcms;
  final double? aliquotaIcms;
  final double? valorIcmsOperacao;
  final double? percentualDiferimento;
  final double? valorIcmsDiferido;
  final double? valorIcms;
  final double? baseCalculoFcp;
  final double? percentualFcp;
  final double? valorFcp;
  final String? modalidadeBcIcmsSt;
  final double? percentualMvaIcmsSt;
  final double? percentualReducaoBcIcmsSt;
  final double? valorBaseCalculoIcmsSt;
  final double? aliquotaIcmsSt;
  final double? valorIcmsSt;
  final double? baseCalculoFcpSt;
  final double? percentualFcpSt;
  final double? valorFcpSt;
  final String? ufSt;
  final double? percentualBcOperacaoPropria;
  final double? valorBcIcmsStRetido;
  final double? aliquotaSuportadaConsumidor;
  final double? valorIcmsSubstituto;
  final double? valorIcmsStRetido;
  final double? baseCalculoFcpStRetido;
  final double? percentualFcpStRetido;
  final double? valorFcpStRetido;
  final String? motivoDesoneracaoIcms;
  final double? valorIcmsDesonerado;
  final double? aliquotaCreditoIcmsSn;
  final double? valorCreditoIcmsSn;
  final double? valorBcIcmsStDestino;
  final double? valorIcmsStDestino;
  final double? percentualReducaoBcEfetivo;
  final double? valorBcEfetivo;
  final double? aliquotaIcmsEfetivo;
  final double? valorIcmsEfetivo;

  NfeDetalheImpostoIcms(
    {
      required this.id,
      this.idNfeDetalhe,
      this.origemMercadoria,
      this.cstIcms,
      this.csosn,
      this.modalidadeBcIcms,
      this.percentualReducaoBcIcms,
      this.valorBcIcms,
      this.aliquotaIcms,
      this.valorIcmsOperacao,
      this.percentualDiferimento,
      this.valorIcmsDiferido,
      this.valorIcms,
      this.baseCalculoFcp,
      this.percentualFcp,
      this.valorFcp,
      this.modalidadeBcIcmsSt,
      this.percentualMvaIcmsSt,
      this.percentualReducaoBcIcmsSt,
      this.valorBaseCalculoIcmsSt,
      this.aliquotaIcmsSt,
      this.valorIcmsSt,
      this.baseCalculoFcpSt,
      this.percentualFcpSt,
      this.valorFcpSt,
      this.ufSt,
      this.percentualBcOperacaoPropria,
      this.valorBcIcmsStRetido,
      this.aliquotaSuportadaConsumidor,
      this.valorIcmsSubstituto,
      this.valorIcmsStRetido,
      this.baseCalculoFcpStRetido,
      this.percentualFcpStRetido,
      this.valorFcpStRetido,
      this.motivoDesoneracaoIcms,
      this.valorIcmsDesonerado,
      this.aliquotaCreditoIcmsSn,
      this.valorCreditoIcmsSn,
      this.valorBcIcmsStDestino,
      this.valorIcmsStDestino,
      this.percentualReducaoBcEfetivo,
      this.valorBcEfetivo,
      this.aliquotaIcmsEfetivo,
      this.valorIcmsEfetivo,
    }
  );

  factory NfeDetalheImpostoIcms.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetalheImpostoIcms(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      origemMercadoria: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ORIGEM_MERCADORIA']),
      cstIcms: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CST_ICMS']),
      csosn: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CSOSN']),
      modalidadeBcIcms: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODALIDADE_BC_ICMS']),
      percentualReducaoBcIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_REDUCAO_BC_ICMS']),
      valorBcIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BC_ICMS']),
      aliquotaIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_ICMS']),
      valorIcmsOperacao: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_OPERACAO']),
      percentualDiferimento: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_DIFERIMENTO']),
      valorIcmsDiferido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_DIFERIDO']),
      valorIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS']),
      baseCalculoFcp: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_FCP']),
      percentualFcp: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_FCP']),
      valorFcp: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_FCP']),
      modalidadeBcIcmsSt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODALIDADE_BC_ICMS_ST']),
      percentualMvaIcmsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_MVA_ICMS_ST']),
      percentualReducaoBcIcmsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_REDUCAO_BC_ICMS_ST']),
      valorBaseCalculoIcmsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BASE_CALCULO_ICMS_ST']),
      aliquotaIcmsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_ICMS_ST']),
      valorIcmsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_ST']),
      baseCalculoFcpSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_FCP_ST']),
      percentualFcpSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_FCP_ST']),
      valorFcpSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_FCP_ST']),
      ufSt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UF_ST']),
      percentualBcOperacaoPropria: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_BC_OPERACAO_PROPRIA']),
      valorBcIcmsStRetido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BC_ICMS_ST_RETIDO']),
      aliquotaSuportadaConsumidor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_SUPORTADA_CONSUMIDOR']),
      valorIcmsSubstituto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_SUBSTITUTO']),
      valorIcmsStRetido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_ST_RETIDO']),
      baseCalculoFcpStRetido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_FCP_ST_RETIDO']),
      percentualFcpStRetido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_FCP_ST_RETIDO']),
      valorFcpStRetido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_FCP_ST_RETIDO']),
      motivoDesoneracaoIcms: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MOTIVO_DESONERACAO_ICMS']),
      valorIcmsDesonerado: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_DESONERADO']),
      aliquotaCreditoIcmsSn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_CREDITO_ICMS_SN']),
      valorCreditoIcmsSn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_CREDITO_ICMS_SN']),
      valorBcIcmsStDestino: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BC_ICMS_ST_DESTINO']),
      valorIcmsStDestino: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_ST_DESTINO']),
      percentualReducaoBcEfetivo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_REDUCAO_BC_EFETIVO']),
      valorBcEfetivo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BC_EFETIVO']),
      aliquotaIcmsEfetivo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_ICMS_EFETIVO']),
      valorIcmsEfetivo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_EFETIVO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeDetalhe != null) {
      map['ID_NFE_DETALHE'] = Variable<int?>(idNfeDetalhe);
    }
    if (!nullToAbsent || origemMercadoria != null) {
      map['ORIGEM_MERCADORIA'] = Variable<String?>(origemMercadoria);
    }
    if (!nullToAbsent || cstIcms != null) {
      map['CST_ICMS'] = Variable<String?>(cstIcms);
    }
    if (!nullToAbsent || csosn != null) {
      map['CSOSN'] = Variable<String?>(csosn);
    }
    if (!nullToAbsent || modalidadeBcIcms != null) {
      map['MODALIDADE_BC_ICMS'] = Variable<String?>(modalidadeBcIcms);
    }
    if (!nullToAbsent || percentualReducaoBcIcms != null) {
      map['PERCENTUAL_REDUCAO_BC_ICMS'] = Variable<double?>(percentualReducaoBcIcms);
    }
    if (!nullToAbsent || valorBcIcms != null) {
      map['VALOR_BC_ICMS'] = Variable<double?>(valorBcIcms);
    }
    if (!nullToAbsent || aliquotaIcms != null) {
      map['ALIQUOTA_ICMS'] = Variable<double?>(aliquotaIcms);
    }
    if (!nullToAbsent || valorIcmsOperacao != null) {
      map['VALOR_ICMS_OPERACAO'] = Variable<double?>(valorIcmsOperacao);
    }
    if (!nullToAbsent || percentualDiferimento != null) {
      map['PERCENTUAL_DIFERIMENTO'] = Variable<double?>(percentualDiferimento);
    }
    if (!nullToAbsent || valorIcmsDiferido != null) {
      map['VALOR_ICMS_DIFERIDO'] = Variable<double?>(valorIcmsDiferido);
    }
    if (!nullToAbsent || valorIcms != null) {
      map['VALOR_ICMS'] = Variable<double?>(valorIcms);
    }
    if (!nullToAbsent || baseCalculoFcp != null) {
      map['BASE_CALCULO_FCP'] = Variable<double?>(baseCalculoFcp);
    }
    if (!nullToAbsent || percentualFcp != null) {
      map['PERCENTUAL_FCP'] = Variable<double?>(percentualFcp);
    }
    if (!nullToAbsent || valorFcp != null) {
      map['VALOR_FCP'] = Variable<double?>(valorFcp);
    }
    if (!nullToAbsent || modalidadeBcIcmsSt != null) {
      map['MODALIDADE_BC_ICMS_ST'] = Variable<String?>(modalidadeBcIcmsSt);
    }
    if (!nullToAbsent || percentualMvaIcmsSt != null) {
      map['PERCENTUAL_MVA_ICMS_ST'] = Variable<double?>(percentualMvaIcmsSt);
    }
    if (!nullToAbsent || percentualReducaoBcIcmsSt != null) {
      map['PERCENTUAL_REDUCAO_BC_ICMS_ST'] = Variable<double?>(percentualReducaoBcIcmsSt);
    }
    if (!nullToAbsent || valorBaseCalculoIcmsSt != null) {
      map['VALOR_BASE_CALCULO_ICMS_ST'] = Variable<double?>(valorBaseCalculoIcmsSt);
    }
    if (!nullToAbsent || aliquotaIcmsSt != null) {
      map['ALIQUOTA_ICMS_ST'] = Variable<double?>(aliquotaIcmsSt);
    }
    if (!nullToAbsent || valorIcmsSt != null) {
      map['VALOR_ICMS_ST'] = Variable<double?>(valorIcmsSt);
    }
    if (!nullToAbsent || baseCalculoFcpSt != null) {
      map['BASE_CALCULO_FCP_ST'] = Variable<double?>(baseCalculoFcpSt);
    }
    if (!nullToAbsent || percentualFcpSt != null) {
      map['PERCENTUAL_FCP_ST'] = Variable<double?>(percentualFcpSt);
    }
    if (!nullToAbsent || valorFcpSt != null) {
      map['VALOR_FCP_ST'] = Variable<double?>(valorFcpSt);
    }
    if (!nullToAbsent || ufSt != null) {
      map['UF_ST'] = Variable<String?>(ufSt);
    }
    if (!nullToAbsent || percentualBcOperacaoPropria != null) {
      map['PERCENTUAL_BC_OPERACAO_PROPRIA'] = Variable<double?>(percentualBcOperacaoPropria);
    }
    if (!nullToAbsent || valorBcIcmsStRetido != null) {
      map['VALOR_BC_ICMS_ST_RETIDO'] = Variable<double?>(valorBcIcmsStRetido);
    }
    if (!nullToAbsent || aliquotaSuportadaConsumidor != null) {
      map['ALIQUOTA_SUPORTADA_CONSUMIDOR'] = Variable<double?>(aliquotaSuportadaConsumidor);
    }
    if (!nullToAbsent || valorIcmsSubstituto != null) {
      map['VALOR_ICMS_SUBSTITUTO'] = Variable<double?>(valorIcmsSubstituto);
    }
    if (!nullToAbsent || valorIcmsStRetido != null) {
      map['VALOR_ICMS_ST_RETIDO'] = Variable<double?>(valorIcmsStRetido);
    }
    if (!nullToAbsent || baseCalculoFcpStRetido != null) {
      map['BASE_CALCULO_FCP_ST_RETIDO'] = Variable<double?>(baseCalculoFcpStRetido);
    }
    if (!nullToAbsent || percentualFcpStRetido != null) {
      map['PERCENTUAL_FCP_ST_RETIDO'] = Variable<double?>(percentualFcpStRetido);
    }
    if (!nullToAbsent || valorFcpStRetido != null) {
      map['VALOR_FCP_ST_RETIDO'] = Variable<double?>(valorFcpStRetido);
    }
    if (!nullToAbsent || motivoDesoneracaoIcms != null) {
      map['MOTIVO_DESONERACAO_ICMS'] = Variable<String?>(motivoDesoneracaoIcms);
    }
    if (!nullToAbsent || valorIcmsDesonerado != null) {
      map['VALOR_ICMS_DESONERADO'] = Variable<double?>(valorIcmsDesonerado);
    }
    if (!nullToAbsent || aliquotaCreditoIcmsSn != null) {
      map['ALIQUOTA_CREDITO_ICMS_SN'] = Variable<double?>(aliquotaCreditoIcmsSn);
    }
    if (!nullToAbsent || valorCreditoIcmsSn != null) {
      map['VALOR_CREDITO_ICMS_SN'] = Variable<double?>(valorCreditoIcmsSn);
    }
    if (!nullToAbsent || valorBcIcmsStDestino != null) {
      map['VALOR_BC_ICMS_ST_DESTINO'] = Variable<double?>(valorBcIcmsStDestino);
    }
    if (!nullToAbsent || valorIcmsStDestino != null) {
      map['VALOR_ICMS_ST_DESTINO'] = Variable<double?>(valorIcmsStDestino);
    }
    if (!nullToAbsent || percentualReducaoBcEfetivo != null) {
      map['PERCENTUAL_REDUCAO_BC_EFETIVO'] = Variable<double?>(percentualReducaoBcEfetivo);
    }
    if (!nullToAbsent || valorBcEfetivo != null) {
      map['VALOR_BC_EFETIVO'] = Variable<double?>(valorBcEfetivo);
    }
    if (!nullToAbsent || aliquotaIcmsEfetivo != null) {
      map['ALIQUOTA_ICMS_EFETIVO'] = Variable<double?>(aliquotaIcmsEfetivo);
    }
    if (!nullToAbsent || valorIcmsEfetivo != null) {
      map['VALOR_ICMS_EFETIVO'] = Variable<double?>(valorIcmsEfetivo);
    }
    return map;
  }

  NfeDetalheImpostoIcmssCompanion toCompanion(bool nullToAbsent) {
    return NfeDetalheImpostoIcmssCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      origemMercadoria: origemMercadoria == null && nullToAbsent
        ? const Value.absent()
        : Value(origemMercadoria),
      cstIcms: cstIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(cstIcms),
      csosn: csosn == null && nullToAbsent
        ? const Value.absent()
        : Value(csosn),
      modalidadeBcIcms: modalidadeBcIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(modalidadeBcIcms),
      percentualReducaoBcIcms: percentualReducaoBcIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualReducaoBcIcms),
      valorBcIcms: valorBcIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBcIcms),
      aliquotaIcms: aliquotaIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaIcms),
      valorIcmsOperacao: valorIcmsOperacao == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsOperacao),
      percentualDiferimento: percentualDiferimento == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualDiferimento),
      valorIcmsDiferido: valorIcmsDiferido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsDiferido),
      valorIcms: valorIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcms),
      baseCalculoFcp: baseCalculoFcp == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoFcp),
      percentualFcp: percentualFcp == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualFcp),
      valorFcp: valorFcp == null && nullToAbsent
        ? const Value.absent()
        : Value(valorFcp),
      modalidadeBcIcmsSt: modalidadeBcIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(modalidadeBcIcmsSt),
      percentualMvaIcmsSt: percentualMvaIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualMvaIcmsSt),
      percentualReducaoBcIcmsSt: percentualReducaoBcIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualReducaoBcIcmsSt),
      valorBaseCalculoIcmsSt: valorBaseCalculoIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBaseCalculoIcmsSt),
      aliquotaIcmsSt: aliquotaIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaIcmsSt),
      valorIcmsSt: valorIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsSt),
      baseCalculoFcpSt: baseCalculoFcpSt == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoFcpSt),
      percentualFcpSt: percentualFcpSt == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualFcpSt),
      valorFcpSt: valorFcpSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorFcpSt),
      ufSt: ufSt == null && nullToAbsent
        ? const Value.absent()
        : Value(ufSt),
      percentualBcOperacaoPropria: percentualBcOperacaoPropria == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualBcOperacaoPropria),
      valorBcIcmsStRetido: valorBcIcmsStRetido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBcIcmsStRetido),
      aliquotaSuportadaConsumidor: aliquotaSuportadaConsumidor == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaSuportadaConsumidor),
      valorIcmsSubstituto: valorIcmsSubstituto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsSubstituto),
      valorIcmsStRetido: valorIcmsStRetido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsStRetido),
      baseCalculoFcpStRetido: baseCalculoFcpStRetido == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoFcpStRetido),
      percentualFcpStRetido: percentualFcpStRetido == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualFcpStRetido),
      valorFcpStRetido: valorFcpStRetido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorFcpStRetido),
      motivoDesoneracaoIcms: motivoDesoneracaoIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(motivoDesoneracaoIcms),
      valorIcmsDesonerado: valorIcmsDesonerado == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsDesonerado),
      aliquotaCreditoIcmsSn: aliquotaCreditoIcmsSn == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaCreditoIcmsSn),
      valorCreditoIcmsSn: valorCreditoIcmsSn == null && nullToAbsent
        ? const Value.absent()
        : Value(valorCreditoIcmsSn),
      valorBcIcmsStDestino: valorBcIcmsStDestino == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBcIcmsStDestino),
      valorIcmsStDestino: valorIcmsStDestino == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsStDestino),
      percentualReducaoBcEfetivo: percentualReducaoBcEfetivo == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualReducaoBcEfetivo),
      valorBcEfetivo: valorBcEfetivo == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBcEfetivo),
      aliquotaIcmsEfetivo: aliquotaIcmsEfetivo == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaIcmsEfetivo),
      valorIcmsEfetivo: valorIcmsEfetivo == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsEfetivo),
    );
  }

  factory NfeDetalheImpostoIcms.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetalheImpostoIcms(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      origemMercadoria: serializer.fromJson<String>(json['origemMercadoria']),
      cstIcms: serializer.fromJson<String>(json['cstIcms']),
      csosn: serializer.fromJson<String>(json['csosn']),
      modalidadeBcIcms: serializer.fromJson<String>(json['modalidadeBcIcms']),
      percentualReducaoBcIcms: serializer.fromJson<double>(json['percentualReducaoBcIcms']),
      valorBcIcms: serializer.fromJson<double>(json['valorBcIcms']),
      aliquotaIcms: serializer.fromJson<double>(json['aliquotaIcms']),
      valorIcmsOperacao: serializer.fromJson<double>(json['valorIcmsOperacao']),
      percentualDiferimento: serializer.fromJson<double>(json['percentualDiferimento']),
      valorIcmsDiferido: serializer.fromJson<double>(json['valorIcmsDiferido']),
      valorIcms: serializer.fromJson<double>(json['valorIcms']),
      baseCalculoFcp: serializer.fromJson<double>(json['baseCalculoFcp']),
      percentualFcp: serializer.fromJson<double>(json['percentualFcp']),
      valorFcp: serializer.fromJson<double>(json['valorFcp']),
      modalidadeBcIcmsSt: serializer.fromJson<String>(json['modalidadeBcIcmsSt']),
      percentualMvaIcmsSt: serializer.fromJson<double>(json['percentualMvaIcmsSt']),
      percentualReducaoBcIcmsSt: serializer.fromJson<double>(json['percentualReducaoBcIcmsSt']),
      valorBaseCalculoIcmsSt: serializer.fromJson<double>(json['valorBaseCalculoIcmsSt']),
      aliquotaIcmsSt: serializer.fromJson<double>(json['aliquotaIcmsSt']),
      valorIcmsSt: serializer.fromJson<double>(json['valorIcmsSt']),
      baseCalculoFcpSt: serializer.fromJson<double>(json['baseCalculoFcpSt']),
      percentualFcpSt: serializer.fromJson<double>(json['percentualFcpSt']),
      valorFcpSt: serializer.fromJson<double>(json['valorFcpSt']),
      ufSt: serializer.fromJson<String>(json['ufSt']),
      percentualBcOperacaoPropria: serializer.fromJson<double>(json['percentualBcOperacaoPropria']),
      valorBcIcmsStRetido: serializer.fromJson<double>(json['valorBcIcmsStRetido']),
      aliquotaSuportadaConsumidor: serializer.fromJson<double>(json['aliquotaSuportadaConsumidor']),
      valorIcmsSubstituto: serializer.fromJson<double>(json['valorIcmsSubstituto']),
      valorIcmsStRetido: serializer.fromJson<double>(json['valorIcmsStRetido']),
      baseCalculoFcpStRetido: serializer.fromJson<double>(json['baseCalculoFcpStRetido']),
      percentualFcpStRetido: serializer.fromJson<double>(json['percentualFcpStRetido']),
      valorFcpStRetido: serializer.fromJson<double>(json['valorFcpStRetido']),
      motivoDesoneracaoIcms: serializer.fromJson<String>(json['motivoDesoneracaoIcms']),
      valorIcmsDesonerado: serializer.fromJson<double>(json['valorIcmsDesonerado']),
      aliquotaCreditoIcmsSn: serializer.fromJson<double>(json['aliquotaCreditoIcmsSn']),
      valorCreditoIcmsSn: serializer.fromJson<double>(json['valorCreditoIcmsSn']),
      valorBcIcmsStDestino: serializer.fromJson<double>(json['valorBcIcmsStDestino']),
      valorIcmsStDestino: serializer.fromJson<double>(json['valorIcmsStDestino']),
      percentualReducaoBcEfetivo: serializer.fromJson<double>(json['percentualReducaoBcEfetivo']),
      valorBcEfetivo: serializer.fromJson<double>(json['valorBcEfetivo']),
      aliquotaIcmsEfetivo: serializer.fromJson<double>(json['aliquotaIcmsEfetivo']),
      valorIcmsEfetivo: serializer.fromJson<double>(json['valorIcmsEfetivo']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'origemMercadoria': serializer.toJson<String?>(origemMercadoria),
      'cstIcms': serializer.toJson<String?>(cstIcms),
      'csosn': serializer.toJson<String?>(csosn),
      'modalidadeBcIcms': serializer.toJson<String?>(modalidadeBcIcms),
      'percentualReducaoBcIcms': serializer.toJson<double?>(percentualReducaoBcIcms),
      'valorBcIcms': serializer.toJson<double?>(valorBcIcms),
      'aliquotaIcms': serializer.toJson<double?>(aliquotaIcms),
      'valorIcmsOperacao': serializer.toJson<double?>(valorIcmsOperacao),
      'percentualDiferimento': serializer.toJson<double?>(percentualDiferimento),
      'valorIcmsDiferido': serializer.toJson<double?>(valorIcmsDiferido),
      'valorIcms': serializer.toJson<double?>(valorIcms),
      'baseCalculoFcp': serializer.toJson<double?>(baseCalculoFcp),
      'percentualFcp': serializer.toJson<double?>(percentualFcp),
      'valorFcp': serializer.toJson<double?>(valorFcp),
      'modalidadeBcIcmsSt': serializer.toJson<String?>(modalidadeBcIcmsSt),
      'percentualMvaIcmsSt': serializer.toJson<double?>(percentualMvaIcmsSt),
      'percentualReducaoBcIcmsSt': serializer.toJson<double?>(percentualReducaoBcIcmsSt),
      'valorBaseCalculoIcmsSt': serializer.toJson<double?>(valorBaseCalculoIcmsSt),
      'aliquotaIcmsSt': serializer.toJson<double?>(aliquotaIcmsSt),
      'valorIcmsSt': serializer.toJson<double?>(valorIcmsSt),
      'baseCalculoFcpSt': serializer.toJson<double?>(baseCalculoFcpSt),
      'percentualFcpSt': serializer.toJson<double?>(percentualFcpSt),
      'valorFcpSt': serializer.toJson<double?>(valorFcpSt),
      'ufSt': serializer.toJson<String?>(ufSt),
      'percentualBcOperacaoPropria': serializer.toJson<double?>(percentualBcOperacaoPropria),
      'valorBcIcmsStRetido': serializer.toJson<double?>(valorBcIcmsStRetido),
      'aliquotaSuportadaConsumidor': serializer.toJson<double?>(aliquotaSuportadaConsumidor),
      'valorIcmsSubstituto': serializer.toJson<double?>(valorIcmsSubstituto),
      'valorIcmsStRetido': serializer.toJson<double?>(valorIcmsStRetido),
      'baseCalculoFcpStRetido': serializer.toJson<double?>(baseCalculoFcpStRetido),
      'percentualFcpStRetido': serializer.toJson<double?>(percentualFcpStRetido),
      'valorFcpStRetido': serializer.toJson<double?>(valorFcpStRetido),
      'motivoDesoneracaoIcms': serializer.toJson<String?>(motivoDesoneracaoIcms),
      'valorIcmsDesonerado': serializer.toJson<double?>(valorIcmsDesonerado),
      'aliquotaCreditoIcmsSn': serializer.toJson<double?>(aliquotaCreditoIcmsSn),
      'valorCreditoIcmsSn': serializer.toJson<double?>(valorCreditoIcmsSn),
      'valorBcIcmsStDestino': serializer.toJson<double?>(valorBcIcmsStDestino),
      'valorIcmsStDestino': serializer.toJson<double?>(valorIcmsStDestino),
      'percentualReducaoBcEfetivo': serializer.toJson<double?>(percentualReducaoBcEfetivo),
      'valorBcEfetivo': serializer.toJson<double?>(valorBcEfetivo),
      'aliquotaIcmsEfetivo': serializer.toJson<double?>(aliquotaIcmsEfetivo),
      'valorIcmsEfetivo': serializer.toJson<double?>(valorIcmsEfetivo),
    };
  }

  NfeDetalheImpostoIcms copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          String? origemMercadoria,
          String? cstIcms,
          String? csosn,
          String? modalidadeBcIcms,
          double? percentualReducaoBcIcms,
          double? valorBcIcms,
          double? aliquotaIcms,
          double? valorIcmsOperacao,
          double? percentualDiferimento,
          double? valorIcmsDiferido,
          double? valorIcms,
          double? baseCalculoFcp,
          double? percentualFcp,
          double? valorFcp,
          String? modalidadeBcIcmsSt,
          double? percentualMvaIcmsSt,
          double? percentualReducaoBcIcmsSt,
          double? valorBaseCalculoIcmsSt,
          double? aliquotaIcmsSt,
          double? valorIcmsSt,
          double? baseCalculoFcpSt,
          double? percentualFcpSt,
          double? valorFcpSt,
          String? ufSt,
          double? percentualBcOperacaoPropria,
          double? valorBcIcmsStRetido,
          double? aliquotaSuportadaConsumidor,
          double? valorIcmsSubstituto,
          double? valorIcmsStRetido,
          double? baseCalculoFcpStRetido,
          double? percentualFcpStRetido,
          double? valorFcpStRetido,
          String? motivoDesoneracaoIcms,
          double? valorIcmsDesonerado,
          double? aliquotaCreditoIcmsSn,
          double? valorCreditoIcmsSn,
          double? valorBcIcmsStDestino,
          double? valorIcmsStDestino,
          double? percentualReducaoBcEfetivo,
          double? valorBcEfetivo,
          double? aliquotaIcmsEfetivo,
          double? valorIcmsEfetivo,
		}) =>
      NfeDetalheImpostoIcms(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        origemMercadoria: origemMercadoria ?? this.origemMercadoria,
        cstIcms: cstIcms ?? this.cstIcms,
        csosn: csosn ?? this.csosn,
        modalidadeBcIcms: modalidadeBcIcms ?? this.modalidadeBcIcms,
        percentualReducaoBcIcms: percentualReducaoBcIcms ?? this.percentualReducaoBcIcms,
        valorBcIcms: valorBcIcms ?? this.valorBcIcms,
        aliquotaIcms: aliquotaIcms ?? this.aliquotaIcms,
        valorIcmsOperacao: valorIcmsOperacao ?? this.valorIcmsOperacao,
        percentualDiferimento: percentualDiferimento ?? this.percentualDiferimento,
        valorIcmsDiferido: valorIcmsDiferido ?? this.valorIcmsDiferido,
        valorIcms: valorIcms ?? this.valorIcms,
        baseCalculoFcp: baseCalculoFcp ?? this.baseCalculoFcp,
        percentualFcp: percentualFcp ?? this.percentualFcp,
        valorFcp: valorFcp ?? this.valorFcp,
        modalidadeBcIcmsSt: modalidadeBcIcmsSt ?? this.modalidadeBcIcmsSt,
        percentualMvaIcmsSt: percentualMvaIcmsSt ?? this.percentualMvaIcmsSt,
        percentualReducaoBcIcmsSt: percentualReducaoBcIcmsSt ?? this.percentualReducaoBcIcmsSt,
        valorBaseCalculoIcmsSt: valorBaseCalculoIcmsSt ?? this.valorBaseCalculoIcmsSt,
        aliquotaIcmsSt: aliquotaIcmsSt ?? this.aliquotaIcmsSt,
        valorIcmsSt: valorIcmsSt ?? this.valorIcmsSt,
        baseCalculoFcpSt: baseCalculoFcpSt ?? this.baseCalculoFcpSt,
        percentualFcpSt: percentualFcpSt ?? this.percentualFcpSt,
        valorFcpSt: valorFcpSt ?? this.valorFcpSt,
        ufSt: ufSt ?? this.ufSt,
        percentualBcOperacaoPropria: percentualBcOperacaoPropria ?? this.percentualBcOperacaoPropria,
        valorBcIcmsStRetido: valorBcIcmsStRetido ?? this.valorBcIcmsStRetido,
        aliquotaSuportadaConsumidor: aliquotaSuportadaConsumidor ?? this.aliquotaSuportadaConsumidor,
        valorIcmsSubstituto: valorIcmsSubstituto ?? this.valorIcmsSubstituto,
        valorIcmsStRetido: valorIcmsStRetido ?? this.valorIcmsStRetido,
        baseCalculoFcpStRetido: baseCalculoFcpStRetido ?? this.baseCalculoFcpStRetido,
        percentualFcpStRetido: percentualFcpStRetido ?? this.percentualFcpStRetido,
        valorFcpStRetido: valorFcpStRetido ?? this.valorFcpStRetido,
        motivoDesoneracaoIcms: motivoDesoneracaoIcms ?? this.motivoDesoneracaoIcms,
        valorIcmsDesonerado: valorIcmsDesonerado ?? this.valorIcmsDesonerado,
        aliquotaCreditoIcmsSn: aliquotaCreditoIcmsSn ?? this.aliquotaCreditoIcmsSn,
        valorCreditoIcmsSn: valorCreditoIcmsSn ?? this.valorCreditoIcmsSn,
        valorBcIcmsStDestino: valorBcIcmsStDestino ?? this.valorBcIcmsStDestino,
        valorIcmsStDestino: valorIcmsStDestino ?? this.valorIcmsStDestino,
        percentualReducaoBcEfetivo: percentualReducaoBcEfetivo ?? this.percentualReducaoBcEfetivo,
        valorBcEfetivo: valorBcEfetivo ?? this.valorBcEfetivo,
        aliquotaIcmsEfetivo: aliquotaIcmsEfetivo ?? this.aliquotaIcmsEfetivo,
        valorIcmsEfetivo: valorIcmsEfetivo ?? this.valorIcmsEfetivo,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoIcms(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('origemMercadoria: $origemMercadoria, ')
          ..write('cstIcms: $cstIcms, ')
          ..write('csosn: $csosn, ')
          ..write('modalidadeBcIcms: $modalidadeBcIcms, ')
          ..write('percentualReducaoBcIcms: $percentualReducaoBcIcms, ')
          ..write('valorBcIcms: $valorBcIcms, ')
          ..write('aliquotaIcms: $aliquotaIcms, ')
          ..write('valorIcmsOperacao: $valorIcmsOperacao, ')
          ..write('percentualDiferimento: $percentualDiferimento, ')
          ..write('valorIcmsDiferido: $valorIcmsDiferido, ')
          ..write('valorIcms: $valorIcms, ')
          ..write('baseCalculoFcp: $baseCalculoFcp, ')
          ..write('percentualFcp: $percentualFcp, ')
          ..write('valorFcp: $valorFcp, ')
          ..write('modalidadeBcIcmsSt: $modalidadeBcIcmsSt, ')
          ..write('percentualMvaIcmsSt: $percentualMvaIcmsSt, ')
          ..write('percentualReducaoBcIcmsSt: $percentualReducaoBcIcmsSt, ')
          ..write('valorBaseCalculoIcmsSt: $valorBaseCalculoIcmsSt, ')
          ..write('aliquotaIcmsSt: $aliquotaIcmsSt, ')
          ..write('valorIcmsSt: $valorIcmsSt, ')
          ..write('baseCalculoFcpSt: $baseCalculoFcpSt, ')
          ..write('percentualFcpSt: $percentualFcpSt, ')
          ..write('valorFcpSt: $valorFcpSt, ')
          ..write('ufSt: $ufSt, ')
          ..write('percentualBcOperacaoPropria: $percentualBcOperacaoPropria, ')
          ..write('valorBcIcmsStRetido: $valorBcIcmsStRetido, ')
          ..write('aliquotaSuportadaConsumidor: $aliquotaSuportadaConsumidor, ')
          ..write('valorIcmsSubstituto: $valorIcmsSubstituto, ')
          ..write('valorIcmsStRetido: $valorIcmsStRetido, ')
          ..write('baseCalculoFcpStRetido: $baseCalculoFcpStRetido, ')
          ..write('percentualFcpStRetido: $percentualFcpStRetido, ')
          ..write('valorFcpStRetido: $valorFcpStRetido, ')
          ..write('motivoDesoneracaoIcms: $motivoDesoneracaoIcms, ')
          ..write('valorIcmsDesonerado: $valorIcmsDesonerado, ')
          ..write('aliquotaCreditoIcmsSn: $aliquotaCreditoIcmsSn, ')
          ..write('valorCreditoIcmsSn: $valorCreditoIcmsSn, ')
          ..write('valorBcIcmsStDestino: $valorBcIcmsStDestino, ')
          ..write('valorIcmsStDestino: $valorIcmsStDestino, ')
          ..write('percentualReducaoBcEfetivo: $percentualReducaoBcEfetivo, ')
          ..write('valorBcEfetivo: $valorBcEfetivo, ')
          ..write('aliquotaIcmsEfetivo: $aliquotaIcmsEfetivo, ')
          ..write('valorIcmsEfetivo: $valorIcmsEfetivo, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      origemMercadoria,
      cstIcms,
      csosn,
      modalidadeBcIcms,
      percentualReducaoBcIcms,
      valorBcIcms,
      aliquotaIcms,
      valorIcmsOperacao,
      percentualDiferimento,
      valorIcmsDiferido,
      valorIcms,
      baseCalculoFcp,
      percentualFcp,
      valorFcp,
      modalidadeBcIcmsSt,
      percentualMvaIcmsSt,
      percentualReducaoBcIcmsSt,
      valorBaseCalculoIcmsSt,
      aliquotaIcmsSt,
      valorIcmsSt,
      baseCalculoFcpSt,
      percentualFcpSt,
      valorFcpSt,
      ufSt,
      percentualBcOperacaoPropria,
      valorBcIcmsStRetido,
      aliquotaSuportadaConsumidor,
      valorIcmsSubstituto,
      valorIcmsStRetido,
      baseCalculoFcpStRetido,
      percentualFcpStRetido,
      valorFcpStRetido,
      motivoDesoneracaoIcms,
      valorIcmsDesonerado,
      aliquotaCreditoIcmsSn,
      valorCreditoIcmsSn,
      valorBcIcmsStDestino,
      valorIcmsStDestino,
      percentualReducaoBcEfetivo,
      valorBcEfetivo,
      aliquotaIcmsEfetivo,
      valorIcmsEfetivo,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetalheImpostoIcms &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.origemMercadoria == origemMercadoria &&
          other.cstIcms == cstIcms &&
          other.csosn == csosn &&
          other.modalidadeBcIcms == modalidadeBcIcms &&
          other.percentualReducaoBcIcms == percentualReducaoBcIcms &&
          other.valorBcIcms == valorBcIcms &&
          other.aliquotaIcms == aliquotaIcms &&
          other.valorIcmsOperacao == valorIcmsOperacao &&
          other.percentualDiferimento == percentualDiferimento &&
          other.valorIcmsDiferido == valorIcmsDiferido &&
          other.valorIcms == valorIcms &&
          other.baseCalculoFcp == baseCalculoFcp &&
          other.percentualFcp == percentualFcp &&
          other.valorFcp == valorFcp &&
          other.modalidadeBcIcmsSt == modalidadeBcIcmsSt &&
          other.percentualMvaIcmsSt == percentualMvaIcmsSt &&
          other.percentualReducaoBcIcmsSt == percentualReducaoBcIcmsSt &&
          other.valorBaseCalculoIcmsSt == valorBaseCalculoIcmsSt &&
          other.aliquotaIcmsSt == aliquotaIcmsSt &&
          other.valorIcmsSt == valorIcmsSt &&
          other.baseCalculoFcpSt == baseCalculoFcpSt &&
          other.percentualFcpSt == percentualFcpSt &&
          other.valorFcpSt == valorFcpSt &&
          other.ufSt == ufSt &&
          other.percentualBcOperacaoPropria == percentualBcOperacaoPropria &&
          other.valorBcIcmsStRetido == valorBcIcmsStRetido &&
          other.aliquotaSuportadaConsumidor == aliquotaSuportadaConsumidor &&
          other.valorIcmsSubstituto == valorIcmsSubstituto &&
          other.valorIcmsStRetido == valorIcmsStRetido &&
          other.baseCalculoFcpStRetido == baseCalculoFcpStRetido &&
          other.percentualFcpStRetido == percentualFcpStRetido &&
          other.valorFcpStRetido == valorFcpStRetido &&
          other.motivoDesoneracaoIcms == motivoDesoneracaoIcms &&
          other.valorIcmsDesonerado == valorIcmsDesonerado &&
          other.aliquotaCreditoIcmsSn == aliquotaCreditoIcmsSn &&
          other.valorCreditoIcmsSn == valorCreditoIcmsSn &&
          other.valorBcIcmsStDestino == valorBcIcmsStDestino &&
          other.valorIcmsStDestino == valorIcmsStDestino &&
          other.percentualReducaoBcEfetivo == percentualReducaoBcEfetivo &&
          other.valorBcEfetivo == valorBcEfetivo &&
          other.aliquotaIcmsEfetivo == aliquotaIcmsEfetivo &&
          other.valorIcmsEfetivo == valorIcmsEfetivo 
	   );
}

class NfeDetalheImpostoIcmssCompanion extends UpdateCompanion<NfeDetalheImpostoIcms> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<String?> origemMercadoria;
  final Value<String?> cstIcms;
  final Value<String?> csosn;
  final Value<String?> modalidadeBcIcms;
  final Value<double?> percentualReducaoBcIcms;
  final Value<double?> valorBcIcms;
  final Value<double?> aliquotaIcms;
  final Value<double?> valorIcmsOperacao;
  final Value<double?> percentualDiferimento;
  final Value<double?> valorIcmsDiferido;
  final Value<double?> valorIcms;
  final Value<double?> baseCalculoFcp;
  final Value<double?> percentualFcp;
  final Value<double?> valorFcp;
  final Value<String?> modalidadeBcIcmsSt;
  final Value<double?> percentualMvaIcmsSt;
  final Value<double?> percentualReducaoBcIcmsSt;
  final Value<double?> valorBaseCalculoIcmsSt;
  final Value<double?> aliquotaIcmsSt;
  final Value<double?> valorIcmsSt;
  final Value<double?> baseCalculoFcpSt;
  final Value<double?> percentualFcpSt;
  final Value<double?> valorFcpSt;
  final Value<String?> ufSt;
  final Value<double?> percentualBcOperacaoPropria;
  final Value<double?> valorBcIcmsStRetido;
  final Value<double?> aliquotaSuportadaConsumidor;
  final Value<double?> valorIcmsSubstituto;
  final Value<double?> valorIcmsStRetido;
  final Value<double?> baseCalculoFcpStRetido;
  final Value<double?> percentualFcpStRetido;
  final Value<double?> valorFcpStRetido;
  final Value<String?> motivoDesoneracaoIcms;
  final Value<double?> valorIcmsDesonerado;
  final Value<double?> aliquotaCreditoIcmsSn;
  final Value<double?> valorCreditoIcmsSn;
  final Value<double?> valorBcIcmsStDestino;
  final Value<double?> valorIcmsStDestino;
  final Value<double?> percentualReducaoBcEfetivo;
  final Value<double?> valorBcEfetivo;
  final Value<double?> aliquotaIcmsEfetivo;
  final Value<double?> valorIcmsEfetivo;

  const NfeDetalheImpostoIcmssCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.origemMercadoria = const Value.absent(),
    this.cstIcms = const Value.absent(),
    this.csosn = const Value.absent(),
    this.modalidadeBcIcms = const Value.absent(),
    this.percentualReducaoBcIcms = const Value.absent(),
    this.valorBcIcms = const Value.absent(),
    this.aliquotaIcms = const Value.absent(),
    this.valorIcmsOperacao = const Value.absent(),
    this.percentualDiferimento = const Value.absent(),
    this.valorIcmsDiferido = const Value.absent(),
    this.valorIcms = const Value.absent(),
    this.baseCalculoFcp = const Value.absent(),
    this.percentualFcp = const Value.absent(),
    this.valorFcp = const Value.absent(),
    this.modalidadeBcIcmsSt = const Value.absent(),
    this.percentualMvaIcmsSt = const Value.absent(),
    this.percentualReducaoBcIcmsSt = const Value.absent(),
    this.valorBaseCalculoIcmsSt = const Value.absent(),
    this.aliquotaIcmsSt = const Value.absent(),
    this.valorIcmsSt = const Value.absent(),
    this.baseCalculoFcpSt = const Value.absent(),
    this.percentualFcpSt = const Value.absent(),
    this.valorFcpSt = const Value.absent(),
    this.ufSt = const Value.absent(),
    this.percentualBcOperacaoPropria = const Value.absent(),
    this.valorBcIcmsStRetido = const Value.absent(),
    this.aliquotaSuportadaConsumidor = const Value.absent(),
    this.valorIcmsSubstituto = const Value.absent(),
    this.valorIcmsStRetido = const Value.absent(),
    this.baseCalculoFcpStRetido = const Value.absent(),
    this.percentualFcpStRetido = const Value.absent(),
    this.valorFcpStRetido = const Value.absent(),
    this.motivoDesoneracaoIcms = const Value.absent(),
    this.valorIcmsDesonerado = const Value.absent(),
    this.aliquotaCreditoIcmsSn = const Value.absent(),
    this.valorCreditoIcmsSn = const Value.absent(),
    this.valorBcIcmsStDestino = const Value.absent(),
    this.valorIcmsStDestino = const Value.absent(),
    this.percentualReducaoBcEfetivo = const Value.absent(),
    this.valorBcEfetivo = const Value.absent(),
    this.aliquotaIcmsEfetivo = const Value.absent(),
    this.valorIcmsEfetivo = const Value.absent(),
  });

  NfeDetalheImpostoIcmssCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.origemMercadoria = const Value.absent(),
    this.cstIcms = const Value.absent(),
    this.csosn = const Value.absent(),
    this.modalidadeBcIcms = const Value.absent(),
    this.percentualReducaoBcIcms = const Value.absent(),
    this.valorBcIcms = const Value.absent(),
    this.aliquotaIcms = const Value.absent(),
    this.valorIcmsOperacao = const Value.absent(),
    this.percentualDiferimento = const Value.absent(),
    this.valorIcmsDiferido = const Value.absent(),
    this.valorIcms = const Value.absent(),
    this.baseCalculoFcp = const Value.absent(),
    this.percentualFcp = const Value.absent(),
    this.valorFcp = const Value.absent(),
    this.modalidadeBcIcmsSt = const Value.absent(),
    this.percentualMvaIcmsSt = const Value.absent(),
    this.percentualReducaoBcIcmsSt = const Value.absent(),
    this.valorBaseCalculoIcmsSt = const Value.absent(),
    this.aliquotaIcmsSt = const Value.absent(),
    this.valorIcmsSt = const Value.absent(),
    this.baseCalculoFcpSt = const Value.absent(),
    this.percentualFcpSt = const Value.absent(),
    this.valorFcpSt = const Value.absent(),
    this.ufSt = const Value.absent(),
    this.percentualBcOperacaoPropria = const Value.absent(),
    this.valorBcIcmsStRetido = const Value.absent(),
    this.aliquotaSuportadaConsumidor = const Value.absent(),
    this.valorIcmsSubstituto = const Value.absent(),
    this.valorIcmsStRetido = const Value.absent(),
    this.baseCalculoFcpStRetido = const Value.absent(),
    this.percentualFcpStRetido = const Value.absent(),
    this.valorFcpStRetido = const Value.absent(),
    this.motivoDesoneracaoIcms = const Value.absent(),
    this.valorIcmsDesonerado = const Value.absent(),
    this.aliquotaCreditoIcmsSn = const Value.absent(),
    this.valorCreditoIcmsSn = const Value.absent(),
    this.valorBcIcmsStDestino = const Value.absent(),
    this.valorIcmsStDestino = const Value.absent(),
    this.percentualReducaoBcEfetivo = const Value.absent(),
    this.valorBcEfetivo = const Value.absent(),
    this.aliquotaIcmsEfetivo = const Value.absent(),
    this.valorIcmsEfetivo = const Value.absent(),
  });

  static Insertable<NfeDetalheImpostoIcms> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<String>? origemMercadoria,
    Expression<String>? cstIcms,
    Expression<String>? csosn,
    Expression<String>? modalidadeBcIcms,
    Expression<double>? percentualReducaoBcIcms,
    Expression<double>? valorBcIcms,
    Expression<double>? aliquotaIcms,
    Expression<double>? valorIcmsOperacao,
    Expression<double>? percentualDiferimento,
    Expression<double>? valorIcmsDiferido,
    Expression<double>? valorIcms,
    Expression<double>? baseCalculoFcp,
    Expression<double>? percentualFcp,
    Expression<double>? valorFcp,
    Expression<String>? modalidadeBcIcmsSt,
    Expression<double>? percentualMvaIcmsSt,
    Expression<double>? percentualReducaoBcIcmsSt,
    Expression<double>? valorBaseCalculoIcmsSt,
    Expression<double>? aliquotaIcmsSt,
    Expression<double>? valorIcmsSt,
    Expression<double>? baseCalculoFcpSt,
    Expression<double>? percentualFcpSt,
    Expression<double>? valorFcpSt,
    Expression<String>? ufSt,
    Expression<double>? percentualBcOperacaoPropria,
    Expression<double>? valorBcIcmsStRetido,
    Expression<double>? aliquotaSuportadaConsumidor,
    Expression<double>? valorIcmsSubstituto,
    Expression<double>? valorIcmsStRetido,
    Expression<double>? baseCalculoFcpStRetido,
    Expression<double>? percentualFcpStRetido,
    Expression<double>? valorFcpStRetido,
    Expression<String>? motivoDesoneracaoIcms,
    Expression<double>? valorIcmsDesonerado,
    Expression<double>? aliquotaCreditoIcmsSn,
    Expression<double>? valorCreditoIcmsSn,
    Expression<double>? valorBcIcmsStDestino,
    Expression<double>? valorIcmsStDestino,
    Expression<double>? percentualReducaoBcEfetivo,
    Expression<double>? valorBcEfetivo,
    Expression<double>? aliquotaIcmsEfetivo,
    Expression<double>? valorIcmsEfetivo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (origemMercadoria != null) 'ORIGEM_MERCADORIA': origemMercadoria,
      if (cstIcms != null) 'CST_ICMS': cstIcms,
      if (csosn != null) 'CSOSN': csosn,
      if (modalidadeBcIcms != null) 'MODALIDADE_BC_ICMS': modalidadeBcIcms,
      if (percentualReducaoBcIcms != null) 'PERCENTUAL_REDUCAO_BC_ICMS': percentualReducaoBcIcms,
      if (valorBcIcms != null) 'VALOR_BC_ICMS': valorBcIcms,
      if (aliquotaIcms != null) 'ALIQUOTA_ICMS': aliquotaIcms,
      if (valorIcmsOperacao != null) 'VALOR_ICMS_OPERACAO': valorIcmsOperacao,
      if (percentualDiferimento != null) 'PERCENTUAL_DIFERIMENTO': percentualDiferimento,
      if (valorIcmsDiferido != null) 'VALOR_ICMS_DIFERIDO': valorIcmsDiferido,
      if (valorIcms != null) 'VALOR_ICMS': valorIcms,
      if (baseCalculoFcp != null) 'BASE_CALCULO_FCP': baseCalculoFcp,
      if (percentualFcp != null) 'PERCENTUAL_FCP': percentualFcp,
      if (valorFcp != null) 'VALOR_FCP': valorFcp,
      if (modalidadeBcIcmsSt != null) 'MODALIDADE_BC_ICMS_ST': modalidadeBcIcmsSt,
      if (percentualMvaIcmsSt != null) 'PERCENTUAL_MVA_ICMS_ST': percentualMvaIcmsSt,
      if (percentualReducaoBcIcmsSt != null) 'PERCENTUAL_REDUCAO_BC_ICMS_ST': percentualReducaoBcIcmsSt,
      if (valorBaseCalculoIcmsSt != null) 'VALOR_BASE_CALCULO_ICMS_ST': valorBaseCalculoIcmsSt,
      if (aliquotaIcmsSt != null) 'ALIQUOTA_ICMS_ST': aliquotaIcmsSt,
      if (valorIcmsSt != null) 'VALOR_ICMS_ST': valorIcmsSt,
      if (baseCalculoFcpSt != null) 'BASE_CALCULO_FCP_ST': baseCalculoFcpSt,
      if (percentualFcpSt != null) 'PERCENTUAL_FCP_ST': percentualFcpSt,
      if (valorFcpSt != null) 'VALOR_FCP_ST': valorFcpSt,
      if (ufSt != null) 'UF_ST': ufSt,
      if (percentualBcOperacaoPropria != null) 'PERCENTUAL_BC_OPERACAO_PROPRIA': percentualBcOperacaoPropria,
      if (valorBcIcmsStRetido != null) 'VALOR_BC_ICMS_ST_RETIDO': valorBcIcmsStRetido,
      if (aliquotaSuportadaConsumidor != null) 'ALIQUOTA_SUPORTADA_CONSUMIDOR': aliquotaSuportadaConsumidor,
      if (valorIcmsSubstituto != null) 'VALOR_ICMS_SUBSTITUTO': valorIcmsSubstituto,
      if (valorIcmsStRetido != null) 'VALOR_ICMS_ST_RETIDO': valorIcmsStRetido,
      if (baseCalculoFcpStRetido != null) 'BASE_CALCULO_FCP_ST_RETIDO': baseCalculoFcpStRetido,
      if (percentualFcpStRetido != null) 'PERCENTUAL_FCP_ST_RETIDO': percentualFcpStRetido,
      if (valorFcpStRetido != null) 'VALOR_FCP_ST_RETIDO': valorFcpStRetido,
      if (motivoDesoneracaoIcms != null) 'MOTIVO_DESONERACAO_ICMS': motivoDesoneracaoIcms,
      if (valorIcmsDesonerado != null) 'VALOR_ICMS_DESONERADO': valorIcmsDesonerado,
      if (aliquotaCreditoIcmsSn != null) 'ALIQUOTA_CREDITO_ICMS_SN': aliquotaCreditoIcmsSn,
      if (valorCreditoIcmsSn != null) 'VALOR_CREDITO_ICMS_SN': valorCreditoIcmsSn,
      if (valorBcIcmsStDestino != null) 'VALOR_BC_ICMS_ST_DESTINO': valorBcIcmsStDestino,
      if (valorIcmsStDestino != null) 'VALOR_ICMS_ST_DESTINO': valorIcmsStDestino,
      if (percentualReducaoBcEfetivo != null) 'PERCENTUAL_REDUCAO_BC_EFETIVO': percentualReducaoBcEfetivo,
      if (valorBcEfetivo != null) 'VALOR_BC_EFETIVO': valorBcEfetivo,
      if (aliquotaIcmsEfetivo != null) 'ALIQUOTA_ICMS_EFETIVO': aliquotaIcmsEfetivo,
      if (valorIcmsEfetivo != null) 'VALOR_ICMS_EFETIVO': valorIcmsEfetivo,
    });
  }

  NfeDetalheImpostoIcmssCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<String>? origemMercadoria,
      Value<String>? cstIcms,
      Value<String>? csosn,
      Value<String>? modalidadeBcIcms,
      Value<double>? percentualReducaoBcIcms,
      Value<double>? valorBcIcms,
      Value<double>? aliquotaIcms,
      Value<double>? valorIcmsOperacao,
      Value<double>? percentualDiferimento,
      Value<double>? valorIcmsDiferido,
      Value<double>? valorIcms,
      Value<double>? baseCalculoFcp,
      Value<double>? percentualFcp,
      Value<double>? valorFcp,
      Value<String>? modalidadeBcIcmsSt,
      Value<double>? percentualMvaIcmsSt,
      Value<double>? percentualReducaoBcIcmsSt,
      Value<double>? valorBaseCalculoIcmsSt,
      Value<double>? aliquotaIcmsSt,
      Value<double>? valorIcmsSt,
      Value<double>? baseCalculoFcpSt,
      Value<double>? percentualFcpSt,
      Value<double>? valorFcpSt,
      Value<String>? ufSt,
      Value<double>? percentualBcOperacaoPropria,
      Value<double>? valorBcIcmsStRetido,
      Value<double>? aliquotaSuportadaConsumidor,
      Value<double>? valorIcmsSubstituto,
      Value<double>? valorIcmsStRetido,
      Value<double>? baseCalculoFcpStRetido,
      Value<double>? percentualFcpStRetido,
      Value<double>? valorFcpStRetido,
      Value<String>? motivoDesoneracaoIcms,
      Value<double>? valorIcmsDesonerado,
      Value<double>? aliquotaCreditoIcmsSn,
      Value<double>? valorCreditoIcmsSn,
      Value<double>? valorBcIcmsStDestino,
      Value<double>? valorIcmsStDestino,
      Value<double>? percentualReducaoBcEfetivo,
      Value<double>? valorBcEfetivo,
      Value<double>? aliquotaIcmsEfetivo,
      Value<double>? valorIcmsEfetivo,
	  }) {
    return NfeDetalheImpostoIcmssCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      origemMercadoria: origemMercadoria ?? this.origemMercadoria,
      cstIcms: cstIcms ?? this.cstIcms,
      csosn: csosn ?? this.csosn,
      modalidadeBcIcms: modalidadeBcIcms ?? this.modalidadeBcIcms,
      percentualReducaoBcIcms: percentualReducaoBcIcms ?? this.percentualReducaoBcIcms,
      valorBcIcms: valorBcIcms ?? this.valorBcIcms,
      aliquotaIcms: aliquotaIcms ?? this.aliquotaIcms,
      valorIcmsOperacao: valorIcmsOperacao ?? this.valorIcmsOperacao,
      percentualDiferimento: percentualDiferimento ?? this.percentualDiferimento,
      valorIcmsDiferido: valorIcmsDiferido ?? this.valorIcmsDiferido,
      valorIcms: valorIcms ?? this.valorIcms,
      baseCalculoFcp: baseCalculoFcp ?? this.baseCalculoFcp,
      percentualFcp: percentualFcp ?? this.percentualFcp,
      valorFcp: valorFcp ?? this.valorFcp,
      modalidadeBcIcmsSt: modalidadeBcIcmsSt ?? this.modalidadeBcIcmsSt,
      percentualMvaIcmsSt: percentualMvaIcmsSt ?? this.percentualMvaIcmsSt,
      percentualReducaoBcIcmsSt: percentualReducaoBcIcmsSt ?? this.percentualReducaoBcIcmsSt,
      valorBaseCalculoIcmsSt: valorBaseCalculoIcmsSt ?? this.valorBaseCalculoIcmsSt,
      aliquotaIcmsSt: aliquotaIcmsSt ?? this.aliquotaIcmsSt,
      valorIcmsSt: valorIcmsSt ?? this.valorIcmsSt,
      baseCalculoFcpSt: baseCalculoFcpSt ?? this.baseCalculoFcpSt,
      percentualFcpSt: percentualFcpSt ?? this.percentualFcpSt,
      valorFcpSt: valorFcpSt ?? this.valorFcpSt,
      ufSt: ufSt ?? this.ufSt,
      percentualBcOperacaoPropria: percentualBcOperacaoPropria ?? this.percentualBcOperacaoPropria,
      valorBcIcmsStRetido: valorBcIcmsStRetido ?? this.valorBcIcmsStRetido,
      aliquotaSuportadaConsumidor: aliquotaSuportadaConsumidor ?? this.aliquotaSuportadaConsumidor,
      valorIcmsSubstituto: valorIcmsSubstituto ?? this.valorIcmsSubstituto,
      valorIcmsStRetido: valorIcmsStRetido ?? this.valorIcmsStRetido,
      baseCalculoFcpStRetido: baseCalculoFcpStRetido ?? this.baseCalculoFcpStRetido,
      percentualFcpStRetido: percentualFcpStRetido ?? this.percentualFcpStRetido,
      valorFcpStRetido: valorFcpStRetido ?? this.valorFcpStRetido,
      motivoDesoneracaoIcms: motivoDesoneracaoIcms ?? this.motivoDesoneracaoIcms,
      valorIcmsDesonerado: valorIcmsDesonerado ?? this.valorIcmsDesonerado,
      aliquotaCreditoIcmsSn: aliquotaCreditoIcmsSn ?? this.aliquotaCreditoIcmsSn,
      valorCreditoIcmsSn: valorCreditoIcmsSn ?? this.valorCreditoIcmsSn,
      valorBcIcmsStDestino: valorBcIcmsStDestino ?? this.valorBcIcmsStDestino,
      valorIcmsStDestino: valorIcmsStDestino ?? this.valorIcmsStDestino,
      percentualReducaoBcEfetivo: percentualReducaoBcEfetivo ?? this.percentualReducaoBcEfetivo,
      valorBcEfetivo: valorBcEfetivo ?? this.valorBcEfetivo,
      aliquotaIcmsEfetivo: aliquotaIcmsEfetivo ?? this.aliquotaIcmsEfetivo,
      valorIcmsEfetivo: valorIcmsEfetivo ?? this.valorIcmsEfetivo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeDetalhe.present) {
      map['ID_NFE_DETALHE'] = Variable<int?>(idNfeDetalhe.value);
    }
    if (origemMercadoria.present) {
      map['ORIGEM_MERCADORIA'] = Variable<String?>(origemMercadoria.value);
    }
    if (cstIcms.present) {
      map['CST_ICMS'] = Variable<String?>(cstIcms.value);
    }
    if (csosn.present) {
      map['CSOSN'] = Variable<String?>(csosn.value);
    }
    if (modalidadeBcIcms.present) {
      map['MODALIDADE_BC_ICMS'] = Variable<String?>(modalidadeBcIcms.value);
    }
    if (percentualReducaoBcIcms.present) {
      map['PERCENTUAL_REDUCAO_BC_ICMS'] = Variable<double?>(percentualReducaoBcIcms.value);
    }
    if (valorBcIcms.present) {
      map['VALOR_BC_ICMS'] = Variable<double?>(valorBcIcms.value);
    }
    if (aliquotaIcms.present) {
      map['ALIQUOTA_ICMS'] = Variable<double?>(aliquotaIcms.value);
    }
    if (valorIcmsOperacao.present) {
      map['VALOR_ICMS_OPERACAO'] = Variable<double?>(valorIcmsOperacao.value);
    }
    if (percentualDiferimento.present) {
      map['PERCENTUAL_DIFERIMENTO'] = Variable<double?>(percentualDiferimento.value);
    }
    if (valorIcmsDiferido.present) {
      map['VALOR_ICMS_DIFERIDO'] = Variable<double?>(valorIcmsDiferido.value);
    }
    if (valorIcms.present) {
      map['VALOR_ICMS'] = Variable<double?>(valorIcms.value);
    }
    if (baseCalculoFcp.present) {
      map['BASE_CALCULO_FCP'] = Variable<double?>(baseCalculoFcp.value);
    }
    if (percentualFcp.present) {
      map['PERCENTUAL_FCP'] = Variable<double?>(percentualFcp.value);
    }
    if (valorFcp.present) {
      map['VALOR_FCP'] = Variable<double?>(valorFcp.value);
    }
    if (modalidadeBcIcmsSt.present) {
      map['MODALIDADE_BC_ICMS_ST'] = Variable<String?>(modalidadeBcIcmsSt.value);
    }
    if (percentualMvaIcmsSt.present) {
      map['PERCENTUAL_MVA_ICMS_ST'] = Variable<double?>(percentualMvaIcmsSt.value);
    }
    if (percentualReducaoBcIcmsSt.present) {
      map['PERCENTUAL_REDUCAO_BC_ICMS_ST'] = Variable<double?>(percentualReducaoBcIcmsSt.value);
    }
    if (valorBaseCalculoIcmsSt.present) {
      map['VALOR_BASE_CALCULO_ICMS_ST'] = Variable<double?>(valorBaseCalculoIcmsSt.value);
    }
    if (aliquotaIcmsSt.present) {
      map['ALIQUOTA_ICMS_ST'] = Variable<double?>(aliquotaIcmsSt.value);
    }
    if (valorIcmsSt.present) {
      map['VALOR_ICMS_ST'] = Variable<double?>(valorIcmsSt.value);
    }
    if (baseCalculoFcpSt.present) {
      map['BASE_CALCULO_FCP_ST'] = Variable<double?>(baseCalculoFcpSt.value);
    }
    if (percentualFcpSt.present) {
      map['PERCENTUAL_FCP_ST'] = Variable<double?>(percentualFcpSt.value);
    }
    if (valorFcpSt.present) {
      map['VALOR_FCP_ST'] = Variable<double?>(valorFcpSt.value);
    }
    if (ufSt.present) {
      map['UF_ST'] = Variable<String?>(ufSt.value);
    }
    if (percentualBcOperacaoPropria.present) {
      map['PERCENTUAL_BC_OPERACAO_PROPRIA'] = Variable<double?>(percentualBcOperacaoPropria.value);
    }
    if (valorBcIcmsStRetido.present) {
      map['VALOR_BC_ICMS_ST_RETIDO'] = Variable<double?>(valorBcIcmsStRetido.value);
    }
    if (aliquotaSuportadaConsumidor.present) {
      map['ALIQUOTA_SUPORTADA_CONSUMIDOR'] = Variable<double?>(aliquotaSuportadaConsumidor.value);
    }
    if (valorIcmsSubstituto.present) {
      map['VALOR_ICMS_SUBSTITUTO'] = Variable<double?>(valorIcmsSubstituto.value);
    }
    if (valorIcmsStRetido.present) {
      map['VALOR_ICMS_ST_RETIDO'] = Variable<double?>(valorIcmsStRetido.value);
    }
    if (baseCalculoFcpStRetido.present) {
      map['BASE_CALCULO_FCP_ST_RETIDO'] = Variable<double?>(baseCalculoFcpStRetido.value);
    }
    if (percentualFcpStRetido.present) {
      map['PERCENTUAL_FCP_ST_RETIDO'] = Variable<double?>(percentualFcpStRetido.value);
    }
    if (valorFcpStRetido.present) {
      map['VALOR_FCP_ST_RETIDO'] = Variable<double?>(valorFcpStRetido.value);
    }
    if (motivoDesoneracaoIcms.present) {
      map['MOTIVO_DESONERACAO_ICMS'] = Variable<String?>(motivoDesoneracaoIcms.value);
    }
    if (valorIcmsDesonerado.present) {
      map['VALOR_ICMS_DESONERADO'] = Variable<double?>(valorIcmsDesonerado.value);
    }
    if (aliquotaCreditoIcmsSn.present) {
      map['ALIQUOTA_CREDITO_ICMS_SN'] = Variable<double?>(aliquotaCreditoIcmsSn.value);
    }
    if (valorCreditoIcmsSn.present) {
      map['VALOR_CREDITO_ICMS_SN'] = Variable<double?>(valorCreditoIcmsSn.value);
    }
    if (valorBcIcmsStDestino.present) {
      map['VALOR_BC_ICMS_ST_DESTINO'] = Variable<double?>(valorBcIcmsStDestino.value);
    }
    if (valorIcmsStDestino.present) {
      map['VALOR_ICMS_ST_DESTINO'] = Variable<double?>(valorIcmsStDestino.value);
    }
    if (percentualReducaoBcEfetivo.present) {
      map['PERCENTUAL_REDUCAO_BC_EFETIVO'] = Variable<double?>(percentualReducaoBcEfetivo.value);
    }
    if (valorBcEfetivo.present) {
      map['VALOR_BC_EFETIVO'] = Variable<double?>(valorBcEfetivo.value);
    }
    if (aliquotaIcmsEfetivo.present) {
      map['ALIQUOTA_ICMS_EFETIVO'] = Variable<double?>(aliquotaIcmsEfetivo.value);
    }
    if (valorIcmsEfetivo.present) {
      map['VALOR_ICMS_EFETIVO'] = Variable<double?>(valorIcmsEfetivo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoIcmssCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('origemMercadoria: $origemMercadoria, ')
          ..write('cstIcms: $cstIcms, ')
          ..write('csosn: $csosn, ')
          ..write('modalidadeBcIcms: $modalidadeBcIcms, ')
          ..write('percentualReducaoBcIcms: $percentualReducaoBcIcms, ')
          ..write('valorBcIcms: $valorBcIcms, ')
          ..write('aliquotaIcms: $aliquotaIcms, ')
          ..write('valorIcmsOperacao: $valorIcmsOperacao, ')
          ..write('percentualDiferimento: $percentualDiferimento, ')
          ..write('valorIcmsDiferido: $valorIcmsDiferido, ')
          ..write('valorIcms: $valorIcms, ')
          ..write('baseCalculoFcp: $baseCalculoFcp, ')
          ..write('percentualFcp: $percentualFcp, ')
          ..write('valorFcp: $valorFcp, ')
          ..write('modalidadeBcIcmsSt: $modalidadeBcIcmsSt, ')
          ..write('percentualMvaIcmsSt: $percentualMvaIcmsSt, ')
          ..write('percentualReducaoBcIcmsSt: $percentualReducaoBcIcmsSt, ')
          ..write('valorBaseCalculoIcmsSt: $valorBaseCalculoIcmsSt, ')
          ..write('aliquotaIcmsSt: $aliquotaIcmsSt, ')
          ..write('valorIcmsSt: $valorIcmsSt, ')
          ..write('baseCalculoFcpSt: $baseCalculoFcpSt, ')
          ..write('percentualFcpSt: $percentualFcpSt, ')
          ..write('valorFcpSt: $valorFcpSt, ')
          ..write('ufSt: $ufSt, ')
          ..write('percentualBcOperacaoPropria: $percentualBcOperacaoPropria, ')
          ..write('valorBcIcmsStRetido: $valorBcIcmsStRetido, ')
          ..write('aliquotaSuportadaConsumidor: $aliquotaSuportadaConsumidor, ')
          ..write('valorIcmsSubstituto: $valorIcmsSubstituto, ')
          ..write('valorIcmsStRetido: $valorIcmsStRetido, ')
          ..write('baseCalculoFcpStRetido: $baseCalculoFcpStRetido, ')
          ..write('percentualFcpStRetido: $percentualFcpStRetido, ')
          ..write('valorFcpStRetido: $valorFcpStRetido, ')
          ..write('motivoDesoneracaoIcms: $motivoDesoneracaoIcms, ')
          ..write('valorIcmsDesonerado: $valorIcmsDesonerado, ')
          ..write('aliquotaCreditoIcmsSn: $aliquotaCreditoIcmsSn, ')
          ..write('valorCreditoIcmsSn: $valorCreditoIcmsSn, ')
          ..write('valorBcIcmsStDestino: $valorBcIcmsStDestino, ')
          ..write('valorIcmsStDestino: $valorIcmsStDestino, ')
          ..write('percentualReducaoBcEfetivo: $percentualReducaoBcEfetivo, ')
          ..write('valorBcEfetivo: $valorBcEfetivo, ')
          ..write('aliquotaIcmsEfetivo: $aliquotaIcmsEfetivo, ')
          ..write('valorIcmsEfetivo: $valorIcmsEfetivo, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetalheImpostoIcmssTable extends NfeDetalheImpostoIcmss
    with TableInfo<$NfeDetalheImpostoIcmssTable, NfeDetalheImpostoIcms> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetalheImpostoIcmssTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeDetalheMeta =
      const VerificationMeta('idNfeDetalhe');
  GeneratedColumn<int>? _idNfeDetalhe;
  @override
  GeneratedColumn<int> get idNfeDetalhe =>
      _idNfeDetalhe ??= GeneratedColumn<int>('ID_NFE_DETALHE', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_DETALHE(ID)');
  final VerificationMeta _origemMercadoriaMeta =
      const VerificationMeta('origemMercadoria');
  GeneratedColumn<String>? _origemMercadoria;
  @override
  GeneratedColumn<String> get origemMercadoria => _origemMercadoria ??=
      GeneratedColumn<String>('ORIGEM_MERCADORIA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cstIcmsMeta =
      const VerificationMeta('cstIcms');
  GeneratedColumn<String>? _cstIcms;
  @override
  GeneratedColumn<String> get cstIcms => _cstIcms ??=
      GeneratedColumn<String>('CST_ICMS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _csosnMeta =
      const VerificationMeta('csosn');
  GeneratedColumn<String>? _csosn;
  @override
  GeneratedColumn<String> get csosn => _csosn ??=
      GeneratedColumn<String>('CSOSN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _modalidadeBcIcmsMeta =
      const VerificationMeta('modalidadeBcIcms');
  GeneratedColumn<String>? _modalidadeBcIcms;
  @override
  GeneratedColumn<String> get modalidadeBcIcms => _modalidadeBcIcms ??=
      GeneratedColumn<String>('MODALIDADE_BC_ICMS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _percentualReducaoBcIcmsMeta =
      const VerificationMeta('percentualReducaoBcIcms');
  GeneratedColumn<double>? _percentualReducaoBcIcms;
  @override
  GeneratedColumn<double> get percentualReducaoBcIcms => _percentualReducaoBcIcms ??=
      GeneratedColumn<double>('PERCENTUAL_REDUCAO_BC_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorBcIcmsMeta =
      const VerificationMeta('valorBcIcms');
  GeneratedColumn<double>? _valorBcIcms;
  @override
  GeneratedColumn<double> get valorBcIcms => _valorBcIcms ??=
      GeneratedColumn<double>('VALOR_BC_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaIcmsMeta =
      const VerificationMeta('aliquotaIcms');
  GeneratedColumn<double>? _aliquotaIcms;
  @override
  GeneratedColumn<double> get aliquotaIcms => _aliquotaIcms ??=
      GeneratedColumn<double>('ALIQUOTA_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsOperacaoMeta =
      const VerificationMeta('valorIcmsOperacao');
  GeneratedColumn<double>? _valorIcmsOperacao;
  @override
  GeneratedColumn<double> get valorIcmsOperacao => _valorIcmsOperacao ??=
      GeneratedColumn<double>('VALOR_ICMS_OPERACAO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualDiferimentoMeta =
      const VerificationMeta('percentualDiferimento');
  GeneratedColumn<double>? _percentualDiferimento;
  @override
  GeneratedColumn<double> get percentualDiferimento => _percentualDiferimento ??=
      GeneratedColumn<double>('PERCENTUAL_DIFERIMENTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsDiferidoMeta =
      const VerificationMeta('valorIcmsDiferido');
  GeneratedColumn<double>? _valorIcmsDiferido;
  @override
  GeneratedColumn<double> get valorIcmsDiferido => _valorIcmsDiferido ??=
      GeneratedColumn<double>('VALOR_ICMS_DIFERIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsMeta =
      const VerificationMeta('valorIcms');
  GeneratedColumn<double>? _valorIcms;
  @override
  GeneratedColumn<double> get valorIcms => _valorIcms ??=
      GeneratedColumn<double>('VALOR_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _baseCalculoFcpMeta =
      const VerificationMeta('baseCalculoFcp');
  GeneratedColumn<double>? _baseCalculoFcp;
  @override
  GeneratedColumn<double> get baseCalculoFcp => _baseCalculoFcp ??=
      GeneratedColumn<double>('BASE_CALCULO_FCP', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualFcpMeta =
      const VerificationMeta('percentualFcp');
  GeneratedColumn<double>? _percentualFcp;
  @override
  GeneratedColumn<double> get percentualFcp => _percentualFcp ??=
      GeneratedColumn<double>('PERCENTUAL_FCP', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorFcpMeta =
      const VerificationMeta('valorFcp');
  GeneratedColumn<double>? _valorFcp;
  @override
  GeneratedColumn<double> get valorFcp => _valorFcp ??=
      GeneratedColumn<double>('VALOR_FCP', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _modalidadeBcIcmsStMeta =
      const VerificationMeta('modalidadeBcIcmsSt');
  GeneratedColumn<String>? _modalidadeBcIcmsSt;
  @override
  GeneratedColumn<String> get modalidadeBcIcmsSt => _modalidadeBcIcmsSt ??=
      GeneratedColumn<String>('MODALIDADE_BC_ICMS_ST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _percentualMvaIcmsStMeta =
      const VerificationMeta('percentualMvaIcmsSt');
  GeneratedColumn<double>? _percentualMvaIcmsSt;
  @override
  GeneratedColumn<double> get percentualMvaIcmsSt => _percentualMvaIcmsSt ??=
      GeneratedColumn<double>('PERCENTUAL_MVA_ICMS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualReducaoBcIcmsStMeta =
      const VerificationMeta('percentualReducaoBcIcmsSt');
  GeneratedColumn<double>? _percentualReducaoBcIcmsSt;
  @override
  GeneratedColumn<double> get percentualReducaoBcIcmsSt => _percentualReducaoBcIcmsSt ??=
      GeneratedColumn<double>('PERCENTUAL_REDUCAO_BC_ICMS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorBaseCalculoIcmsStMeta =
      const VerificationMeta('valorBaseCalculoIcmsSt');
  GeneratedColumn<double>? _valorBaseCalculoIcmsSt;
  @override
  GeneratedColumn<double> get valorBaseCalculoIcmsSt => _valorBaseCalculoIcmsSt ??=
      GeneratedColumn<double>('VALOR_BASE_CALCULO_ICMS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaIcmsStMeta =
      const VerificationMeta('aliquotaIcmsSt');
  GeneratedColumn<double>? _aliquotaIcmsSt;
  @override
  GeneratedColumn<double> get aliquotaIcmsSt => _aliquotaIcmsSt ??=
      GeneratedColumn<double>('ALIQUOTA_ICMS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsStMeta =
      const VerificationMeta('valorIcmsSt');
  GeneratedColumn<double>? _valorIcmsSt;
  @override
  GeneratedColumn<double> get valorIcmsSt => _valorIcmsSt ??=
      GeneratedColumn<double>('VALOR_ICMS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _baseCalculoFcpStMeta =
      const VerificationMeta('baseCalculoFcpSt');
  GeneratedColumn<double>? _baseCalculoFcpSt;
  @override
  GeneratedColumn<double> get baseCalculoFcpSt => _baseCalculoFcpSt ??=
      GeneratedColumn<double>('BASE_CALCULO_FCP_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualFcpStMeta =
      const VerificationMeta('percentualFcpSt');
  GeneratedColumn<double>? _percentualFcpSt;
  @override
  GeneratedColumn<double> get percentualFcpSt => _percentualFcpSt ??=
      GeneratedColumn<double>('PERCENTUAL_FCP_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorFcpStMeta =
      const VerificationMeta('valorFcpSt');
  GeneratedColumn<double>? _valorFcpSt;
  @override
  GeneratedColumn<double> get valorFcpSt => _valorFcpSt ??=
      GeneratedColumn<double>('VALOR_FCP_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _ufStMeta =
      const VerificationMeta('ufSt');
  GeneratedColumn<String>? _ufSt;
  @override
  GeneratedColumn<String> get ufSt => _ufSt ??=
      GeneratedColumn<String>('UF_ST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _percentualBcOperacaoPropriaMeta =
      const VerificationMeta('percentualBcOperacaoPropria');
  GeneratedColumn<double>? _percentualBcOperacaoPropria;
  @override
  GeneratedColumn<double> get percentualBcOperacaoPropria => _percentualBcOperacaoPropria ??=
      GeneratedColumn<double>('PERCENTUAL_BC_OPERACAO_PROPRIA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorBcIcmsStRetidoMeta =
      const VerificationMeta('valorBcIcmsStRetido');
  GeneratedColumn<double>? _valorBcIcmsStRetido;
  @override
  GeneratedColumn<double> get valorBcIcmsStRetido => _valorBcIcmsStRetido ??=
      GeneratedColumn<double>('VALOR_BC_ICMS_ST_RETIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaSuportadaConsumidorMeta =
      const VerificationMeta('aliquotaSuportadaConsumidor');
  GeneratedColumn<double>? _aliquotaSuportadaConsumidor;
  @override
  GeneratedColumn<double> get aliquotaSuportadaConsumidor => _aliquotaSuportadaConsumidor ??=
      GeneratedColumn<double>('ALIQUOTA_SUPORTADA_CONSUMIDOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsSubstitutoMeta =
      const VerificationMeta('valorIcmsSubstituto');
  GeneratedColumn<double>? _valorIcmsSubstituto;
  @override
  GeneratedColumn<double> get valorIcmsSubstituto => _valorIcmsSubstituto ??=
      GeneratedColumn<double>('VALOR_ICMS_SUBSTITUTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsStRetidoMeta =
      const VerificationMeta('valorIcmsStRetido');
  GeneratedColumn<double>? _valorIcmsStRetido;
  @override
  GeneratedColumn<double> get valorIcmsStRetido => _valorIcmsStRetido ??=
      GeneratedColumn<double>('VALOR_ICMS_ST_RETIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _baseCalculoFcpStRetidoMeta =
      const VerificationMeta('baseCalculoFcpStRetido');
  GeneratedColumn<double>? _baseCalculoFcpStRetido;
  @override
  GeneratedColumn<double> get baseCalculoFcpStRetido => _baseCalculoFcpStRetido ??=
      GeneratedColumn<double>('BASE_CALCULO_FCP_ST_RETIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualFcpStRetidoMeta =
      const VerificationMeta('percentualFcpStRetido');
  GeneratedColumn<double>? _percentualFcpStRetido;
  @override
  GeneratedColumn<double> get percentualFcpStRetido => _percentualFcpStRetido ??=
      GeneratedColumn<double>('PERCENTUAL_FCP_ST_RETIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorFcpStRetidoMeta =
      const VerificationMeta('valorFcpStRetido');
  GeneratedColumn<double>? _valorFcpStRetido;
  @override
  GeneratedColumn<double> get valorFcpStRetido => _valorFcpStRetido ??=
      GeneratedColumn<double>('VALOR_FCP_ST_RETIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _motivoDesoneracaoIcmsMeta =
      const VerificationMeta('motivoDesoneracaoIcms');
  GeneratedColumn<String>? _motivoDesoneracaoIcms;
  @override
  GeneratedColumn<String> get motivoDesoneracaoIcms => _motivoDesoneracaoIcms ??=
      GeneratedColumn<String>('MOTIVO_DESONERACAO_ICMS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsDesoneradoMeta =
      const VerificationMeta('valorIcmsDesonerado');
  GeneratedColumn<double>? _valorIcmsDesonerado;
  @override
  GeneratedColumn<double> get valorIcmsDesonerado => _valorIcmsDesonerado ??=
      GeneratedColumn<double>('VALOR_ICMS_DESONERADO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaCreditoIcmsSnMeta =
      const VerificationMeta('aliquotaCreditoIcmsSn');
  GeneratedColumn<double>? _aliquotaCreditoIcmsSn;
  @override
  GeneratedColumn<double> get aliquotaCreditoIcmsSn => _aliquotaCreditoIcmsSn ??=
      GeneratedColumn<double>('ALIQUOTA_CREDITO_ICMS_SN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorCreditoIcmsSnMeta =
      const VerificationMeta('valorCreditoIcmsSn');
  GeneratedColumn<double>? _valorCreditoIcmsSn;
  @override
  GeneratedColumn<double> get valorCreditoIcmsSn => _valorCreditoIcmsSn ??=
      GeneratedColumn<double>('VALOR_CREDITO_ICMS_SN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorBcIcmsStDestinoMeta =
      const VerificationMeta('valorBcIcmsStDestino');
  GeneratedColumn<double>? _valorBcIcmsStDestino;
  @override
  GeneratedColumn<double> get valorBcIcmsStDestino => _valorBcIcmsStDestino ??=
      GeneratedColumn<double>('VALOR_BC_ICMS_ST_DESTINO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsStDestinoMeta =
      const VerificationMeta('valorIcmsStDestino');
  GeneratedColumn<double>? _valorIcmsStDestino;
  @override
  GeneratedColumn<double> get valorIcmsStDestino => _valorIcmsStDestino ??=
      GeneratedColumn<double>('VALOR_ICMS_ST_DESTINO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualReducaoBcEfetivoMeta =
      const VerificationMeta('percentualReducaoBcEfetivo');
  GeneratedColumn<double>? _percentualReducaoBcEfetivo;
  @override
  GeneratedColumn<double> get percentualReducaoBcEfetivo => _percentualReducaoBcEfetivo ??=
      GeneratedColumn<double>('PERCENTUAL_REDUCAO_BC_EFETIVO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorBcEfetivoMeta =
      const VerificationMeta('valorBcEfetivo');
  GeneratedColumn<double>? _valorBcEfetivo;
  @override
  GeneratedColumn<double> get valorBcEfetivo => _valorBcEfetivo ??=
      GeneratedColumn<double>('VALOR_BC_EFETIVO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaIcmsEfetivoMeta =
      const VerificationMeta('aliquotaIcmsEfetivo');
  GeneratedColumn<double>? _aliquotaIcmsEfetivo;
  @override
  GeneratedColumn<double> get aliquotaIcmsEfetivo => _aliquotaIcmsEfetivo ??=
      GeneratedColumn<double>('ALIQUOTA_ICMS_EFETIVO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsEfetivoMeta =
      const VerificationMeta('valorIcmsEfetivo');
  GeneratedColumn<double>? _valorIcmsEfetivo;
  @override
  GeneratedColumn<double> get valorIcmsEfetivo => _valorIcmsEfetivo ??=
      GeneratedColumn<double>('VALOR_ICMS_EFETIVO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        origemMercadoria,
        cstIcms,
        csosn,
        modalidadeBcIcms,
        percentualReducaoBcIcms,
        valorBcIcms,
        aliquotaIcms,
        valorIcmsOperacao,
        percentualDiferimento,
        valorIcmsDiferido,
        valorIcms,
        baseCalculoFcp,
        percentualFcp,
        valorFcp,
        modalidadeBcIcmsSt,
        percentualMvaIcmsSt,
        percentualReducaoBcIcmsSt,
        valorBaseCalculoIcmsSt,
        aliquotaIcmsSt,
        valorIcmsSt,
        baseCalculoFcpSt,
        percentualFcpSt,
        valorFcpSt,
        ufSt,
        percentualBcOperacaoPropria,
        valorBcIcmsStRetido,
        aliquotaSuportadaConsumidor,
        valorIcmsSubstituto,
        valorIcmsStRetido,
        baseCalculoFcpStRetido,
        percentualFcpStRetido,
        valorFcpStRetido,
        motivoDesoneracaoIcms,
        valorIcmsDesonerado,
        aliquotaCreditoIcmsSn,
        valorCreditoIcmsSn,
        valorBcIcmsStDestino,
        valorIcmsStDestino,
        percentualReducaoBcEfetivo,
        valorBcEfetivo,
        aliquotaIcmsEfetivo,
        valorIcmsEfetivo,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DETALHE_IMPOSTO_ICMS';
  
  @override
  String get actualTableName => 'NFE_DETALHE_IMPOSTO_ICMS';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetalheImpostoIcms> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_DETALHE')) {
        context.handle(_idNfeDetalheMeta,
            idNfeDetalhe.isAcceptableOrUnknown(data['ID_NFE_DETALHE']!, _idNfeDetalheMeta));
    }
    if (data.containsKey('ORIGEM_MERCADORIA')) {
        context.handle(_origemMercadoriaMeta,
            origemMercadoria.isAcceptableOrUnknown(data['ORIGEM_MERCADORIA']!, _origemMercadoriaMeta));
    }
    if (data.containsKey('CST_ICMS')) {
        context.handle(_cstIcmsMeta,
            cstIcms.isAcceptableOrUnknown(data['CST_ICMS']!, _cstIcmsMeta));
    }
    if (data.containsKey('CSOSN')) {
        context.handle(_csosnMeta,
            csosn.isAcceptableOrUnknown(data['CSOSN']!, _csosnMeta));
    }
    if (data.containsKey('MODALIDADE_BC_ICMS')) {
        context.handle(_modalidadeBcIcmsMeta,
            modalidadeBcIcms.isAcceptableOrUnknown(data['MODALIDADE_BC_ICMS']!, _modalidadeBcIcmsMeta));
    }
    if (data.containsKey('PERCENTUAL_REDUCAO_BC_ICMS')) {
        context.handle(_percentualReducaoBcIcmsMeta,
            percentualReducaoBcIcms.isAcceptableOrUnknown(data['PERCENTUAL_REDUCAO_BC_ICMS']!, _percentualReducaoBcIcmsMeta));
    }
    if (data.containsKey('VALOR_BC_ICMS')) {
        context.handle(_valorBcIcmsMeta,
            valorBcIcms.isAcceptableOrUnknown(data['VALOR_BC_ICMS']!, _valorBcIcmsMeta));
    }
    if (data.containsKey('ALIQUOTA_ICMS')) {
        context.handle(_aliquotaIcmsMeta,
            aliquotaIcms.isAcceptableOrUnknown(data['ALIQUOTA_ICMS']!, _aliquotaIcmsMeta));
    }
    if (data.containsKey('VALOR_ICMS_OPERACAO')) {
        context.handle(_valorIcmsOperacaoMeta,
            valorIcmsOperacao.isAcceptableOrUnknown(data['VALOR_ICMS_OPERACAO']!, _valorIcmsOperacaoMeta));
    }
    if (data.containsKey('PERCENTUAL_DIFERIMENTO')) {
        context.handle(_percentualDiferimentoMeta,
            percentualDiferimento.isAcceptableOrUnknown(data['PERCENTUAL_DIFERIMENTO']!, _percentualDiferimentoMeta));
    }
    if (data.containsKey('VALOR_ICMS_DIFERIDO')) {
        context.handle(_valorIcmsDiferidoMeta,
            valorIcmsDiferido.isAcceptableOrUnknown(data['VALOR_ICMS_DIFERIDO']!, _valorIcmsDiferidoMeta));
    }
    if (data.containsKey('VALOR_ICMS')) {
        context.handle(_valorIcmsMeta,
            valorIcms.isAcceptableOrUnknown(data['VALOR_ICMS']!, _valorIcmsMeta));
    }
    if (data.containsKey('BASE_CALCULO_FCP')) {
        context.handle(_baseCalculoFcpMeta,
            baseCalculoFcp.isAcceptableOrUnknown(data['BASE_CALCULO_FCP']!, _baseCalculoFcpMeta));
    }
    if (data.containsKey('PERCENTUAL_FCP')) {
        context.handle(_percentualFcpMeta,
            percentualFcp.isAcceptableOrUnknown(data['PERCENTUAL_FCP']!, _percentualFcpMeta));
    }
    if (data.containsKey('VALOR_FCP')) {
        context.handle(_valorFcpMeta,
            valorFcp.isAcceptableOrUnknown(data['VALOR_FCP']!, _valorFcpMeta));
    }
    if (data.containsKey('MODALIDADE_BC_ICMS_ST')) {
        context.handle(_modalidadeBcIcmsStMeta,
            modalidadeBcIcmsSt.isAcceptableOrUnknown(data['MODALIDADE_BC_ICMS_ST']!, _modalidadeBcIcmsStMeta));
    }
    if (data.containsKey('PERCENTUAL_MVA_ICMS_ST')) {
        context.handle(_percentualMvaIcmsStMeta,
            percentualMvaIcmsSt.isAcceptableOrUnknown(data['PERCENTUAL_MVA_ICMS_ST']!, _percentualMvaIcmsStMeta));
    }
    if (data.containsKey('PERCENTUAL_REDUCAO_BC_ICMS_ST')) {
        context.handle(_percentualReducaoBcIcmsStMeta,
            percentualReducaoBcIcmsSt.isAcceptableOrUnknown(data['PERCENTUAL_REDUCAO_BC_ICMS_ST']!, _percentualReducaoBcIcmsStMeta));
    }
    if (data.containsKey('VALOR_BASE_CALCULO_ICMS_ST')) {
        context.handle(_valorBaseCalculoIcmsStMeta,
            valorBaseCalculoIcmsSt.isAcceptableOrUnknown(data['VALOR_BASE_CALCULO_ICMS_ST']!, _valorBaseCalculoIcmsStMeta));
    }
    if (data.containsKey('ALIQUOTA_ICMS_ST')) {
        context.handle(_aliquotaIcmsStMeta,
            aliquotaIcmsSt.isAcceptableOrUnknown(data['ALIQUOTA_ICMS_ST']!, _aliquotaIcmsStMeta));
    }
    if (data.containsKey('VALOR_ICMS_ST')) {
        context.handle(_valorIcmsStMeta,
            valorIcmsSt.isAcceptableOrUnknown(data['VALOR_ICMS_ST']!, _valorIcmsStMeta));
    }
    if (data.containsKey('BASE_CALCULO_FCP_ST')) {
        context.handle(_baseCalculoFcpStMeta,
            baseCalculoFcpSt.isAcceptableOrUnknown(data['BASE_CALCULO_FCP_ST']!, _baseCalculoFcpStMeta));
    }
    if (data.containsKey('PERCENTUAL_FCP_ST')) {
        context.handle(_percentualFcpStMeta,
            percentualFcpSt.isAcceptableOrUnknown(data['PERCENTUAL_FCP_ST']!, _percentualFcpStMeta));
    }
    if (data.containsKey('VALOR_FCP_ST')) {
        context.handle(_valorFcpStMeta,
            valorFcpSt.isAcceptableOrUnknown(data['VALOR_FCP_ST']!, _valorFcpStMeta));
    }
    if (data.containsKey('UF_ST')) {
        context.handle(_ufStMeta,
            ufSt.isAcceptableOrUnknown(data['UF_ST']!, _ufStMeta));
    }
    if (data.containsKey('PERCENTUAL_BC_OPERACAO_PROPRIA')) {
        context.handle(_percentualBcOperacaoPropriaMeta,
            percentualBcOperacaoPropria.isAcceptableOrUnknown(data['PERCENTUAL_BC_OPERACAO_PROPRIA']!, _percentualBcOperacaoPropriaMeta));
    }
    if (data.containsKey('VALOR_BC_ICMS_ST_RETIDO')) {
        context.handle(_valorBcIcmsStRetidoMeta,
            valorBcIcmsStRetido.isAcceptableOrUnknown(data['VALOR_BC_ICMS_ST_RETIDO']!, _valorBcIcmsStRetidoMeta));
    }
    if (data.containsKey('ALIQUOTA_SUPORTADA_CONSUMIDOR')) {
        context.handle(_aliquotaSuportadaConsumidorMeta,
            aliquotaSuportadaConsumidor.isAcceptableOrUnknown(data['ALIQUOTA_SUPORTADA_CONSUMIDOR']!, _aliquotaSuportadaConsumidorMeta));
    }
    if (data.containsKey('VALOR_ICMS_SUBSTITUTO')) {
        context.handle(_valorIcmsSubstitutoMeta,
            valorIcmsSubstituto.isAcceptableOrUnknown(data['VALOR_ICMS_SUBSTITUTO']!, _valorIcmsSubstitutoMeta));
    }
    if (data.containsKey('VALOR_ICMS_ST_RETIDO')) {
        context.handle(_valorIcmsStRetidoMeta,
            valorIcmsStRetido.isAcceptableOrUnknown(data['VALOR_ICMS_ST_RETIDO']!, _valorIcmsStRetidoMeta));
    }
    if (data.containsKey('BASE_CALCULO_FCP_ST_RETIDO')) {
        context.handle(_baseCalculoFcpStRetidoMeta,
            baseCalculoFcpStRetido.isAcceptableOrUnknown(data['BASE_CALCULO_FCP_ST_RETIDO']!, _baseCalculoFcpStRetidoMeta));
    }
    if (data.containsKey('PERCENTUAL_FCP_ST_RETIDO')) {
        context.handle(_percentualFcpStRetidoMeta,
            percentualFcpStRetido.isAcceptableOrUnknown(data['PERCENTUAL_FCP_ST_RETIDO']!, _percentualFcpStRetidoMeta));
    }
    if (data.containsKey('VALOR_FCP_ST_RETIDO')) {
        context.handle(_valorFcpStRetidoMeta,
            valorFcpStRetido.isAcceptableOrUnknown(data['VALOR_FCP_ST_RETIDO']!, _valorFcpStRetidoMeta));
    }
    if (data.containsKey('MOTIVO_DESONERACAO_ICMS')) {
        context.handle(_motivoDesoneracaoIcmsMeta,
            motivoDesoneracaoIcms.isAcceptableOrUnknown(data['MOTIVO_DESONERACAO_ICMS']!, _motivoDesoneracaoIcmsMeta));
    }
    if (data.containsKey('VALOR_ICMS_DESONERADO')) {
        context.handle(_valorIcmsDesoneradoMeta,
            valorIcmsDesonerado.isAcceptableOrUnknown(data['VALOR_ICMS_DESONERADO']!, _valorIcmsDesoneradoMeta));
    }
    if (data.containsKey('ALIQUOTA_CREDITO_ICMS_SN')) {
        context.handle(_aliquotaCreditoIcmsSnMeta,
            aliquotaCreditoIcmsSn.isAcceptableOrUnknown(data['ALIQUOTA_CREDITO_ICMS_SN']!, _aliquotaCreditoIcmsSnMeta));
    }
    if (data.containsKey('VALOR_CREDITO_ICMS_SN')) {
        context.handle(_valorCreditoIcmsSnMeta,
            valorCreditoIcmsSn.isAcceptableOrUnknown(data['VALOR_CREDITO_ICMS_SN']!, _valorCreditoIcmsSnMeta));
    }
    if (data.containsKey('VALOR_BC_ICMS_ST_DESTINO')) {
        context.handle(_valorBcIcmsStDestinoMeta,
            valorBcIcmsStDestino.isAcceptableOrUnknown(data['VALOR_BC_ICMS_ST_DESTINO']!, _valorBcIcmsStDestinoMeta));
    }
    if (data.containsKey('VALOR_ICMS_ST_DESTINO')) {
        context.handle(_valorIcmsStDestinoMeta,
            valorIcmsStDestino.isAcceptableOrUnknown(data['VALOR_ICMS_ST_DESTINO']!, _valorIcmsStDestinoMeta));
    }
    if (data.containsKey('PERCENTUAL_REDUCAO_BC_EFETIVO')) {
        context.handle(_percentualReducaoBcEfetivoMeta,
            percentualReducaoBcEfetivo.isAcceptableOrUnknown(data['PERCENTUAL_REDUCAO_BC_EFETIVO']!, _percentualReducaoBcEfetivoMeta));
    }
    if (data.containsKey('VALOR_BC_EFETIVO')) {
        context.handle(_valorBcEfetivoMeta,
            valorBcEfetivo.isAcceptableOrUnknown(data['VALOR_BC_EFETIVO']!, _valorBcEfetivoMeta));
    }
    if (data.containsKey('ALIQUOTA_ICMS_EFETIVO')) {
        context.handle(_aliquotaIcmsEfetivoMeta,
            aliquotaIcmsEfetivo.isAcceptableOrUnknown(data['ALIQUOTA_ICMS_EFETIVO']!, _aliquotaIcmsEfetivoMeta));
    }
    if (data.containsKey('VALOR_ICMS_EFETIVO')) {
        context.handle(_valorIcmsEfetivoMeta,
            valorIcmsEfetivo.isAcceptableOrUnknown(data['VALOR_ICMS_EFETIVO']!, _valorIcmsEfetivoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDetalheImpostoIcms map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetalheImpostoIcms.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetalheImpostoIcmssTable createAlias(String alias) {
    return $NfeDetalheImpostoIcmssTable(_db, alias);
  }
}