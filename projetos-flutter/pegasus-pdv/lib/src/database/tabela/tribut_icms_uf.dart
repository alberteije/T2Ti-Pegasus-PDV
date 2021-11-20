/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [TRIBUT_ICMS_UF] 
                                                                                
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

@DataClassName("TributIcmsUf")
@UseRowClass(TributIcmsUf)
class TributIcmsUfs extends Table {
  @override
  String get tableName => 'TRIBUT_ICMS_UF';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idTributConfiguraOfGt => integer().named('ID_TRIBUT_CONFIGURA_OF_GT').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_CONFIGURA_OF_GT(ID)')();
  TextColumn get ufDestino => text().named('UF_DESTINO').withLength(min: 0, max: 2).nullable()();
  IntColumn get cfop => integer().named('CFOP').nullable()();
  TextColumn get csosn => text().named('CSOSN').withLength(min: 0, max: 3).nullable()();
  TextColumn get cst => text().named('CST').withLength(min: 0, max: 2).nullable()();
  TextColumn get modalidadeBc => text().named('MODALIDADE_BC').withLength(min: 0, max: 1).nullable()();
  RealColumn get aliquota => real().named('ALIQUOTA').nullable()();
  RealColumn get valorPauta => real().named('VALOR_PAUTA').nullable()();
  RealColumn get valorPrecoMaximo => real().named('VALOR_PRECO_MAXIMO').nullable()();
  RealColumn get mva => real().named('MVA').nullable()();
  RealColumn get porcentoBc => real().named('PORCENTO_BC').nullable()();
  TextColumn get modalidadeBcSt => text().named('MODALIDADE_BC_ST').withLength(min: 0, max: 1).nullable()();
  RealColumn get aliquotaInternaSt => real().named('ALIQUOTA_INTERNA_ST').nullable()();
  RealColumn get aliquotaInterestadualSt => real().named('ALIQUOTA_INTERESTADUAL_ST').nullable()();
  RealColumn get porcentoBcSt => real().named('PORCENTO_BC_ST').nullable()();
  RealColumn get aliquotaIcmsSt => real().named('ALIQUOTA_ICMS_ST').nullable()();
  RealColumn get valorPautaSt => real().named('VALOR_PAUTA_ST').nullable()();
  RealColumn get valorPrecoMaximoSt => real().named('VALOR_PRECO_MAXIMO_ST').nullable()();
}

class TributIcmsUf extends DataClass implements Insertable<TributIcmsUf> {
  final int? id;
  final int? idTributConfiguraOfGt;
  final String? ufDestino;
  final int? cfop;
  final String? csosn;
  final String? cst;
  final String? modalidadeBc;
  final double? aliquota;
  final double? valorPauta;
  final double? valorPrecoMaximo;
  final double? mva;
  final double? porcentoBc;
  final String? modalidadeBcSt;
  final double? aliquotaInternaSt;
  final double? aliquotaInterestadualSt;
  final double? porcentoBcSt;
  final double? aliquotaIcmsSt;
  final double? valorPautaSt;
  final double? valorPrecoMaximoSt;

  TributIcmsUf(
    {
      required this.id,
      this.idTributConfiguraOfGt,
      this.ufDestino,
      this.cfop,
      this.csosn,
      this.cst,
      this.modalidadeBc,
      this.aliquota,
      this.valorPauta,
      this.valorPrecoMaximo,
      this.mva,
      this.porcentoBc,
      this.modalidadeBcSt,
      this.aliquotaInternaSt,
      this.aliquotaInterestadualSt,
      this.porcentoBcSt,
      this.aliquotaIcmsSt,
      this.valorPautaSt,
      this.valorPrecoMaximoSt,
    }
  );

  factory TributIcmsUf.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TributIcmsUf(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idTributConfiguraOfGt: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_TRIBUT_CONFIGURA_OF_GT']),
      ufDestino: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UF_DESTINO']),
      cfop: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CFOP']),
      csosn: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CSOSN']),
      cst: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CST']),
      modalidadeBc: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODALIDADE_BC']),
      aliquota: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA']),
      valorPauta: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PAUTA']),
      valorPrecoMaximo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PRECO_MAXIMO']),
      mva: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}MVA']),
      porcentoBc: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PORCENTO_BC']),
      modalidadeBcSt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODALIDADE_BC_ST']),
      aliquotaInternaSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_INTERNA_ST']),
      aliquotaInterestadualSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_INTERESTADUAL_ST']),
      porcentoBcSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PORCENTO_BC_ST']),
      aliquotaIcmsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_ICMS_ST']),
      valorPautaSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PAUTA_ST']),
      valorPrecoMaximoSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PRECO_MAXIMO_ST']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idTributConfiguraOfGt != null) {
      map['ID_TRIBUT_CONFIGURA_OF_GT'] = Variable<int?>(idTributConfiguraOfGt);
    }
    if (!nullToAbsent || ufDestino != null) {
      map['UF_DESTINO'] = Variable<String?>(ufDestino);
    }
    if (!nullToAbsent || cfop != null) {
      map['CFOP'] = Variable<int?>(cfop);
    }
    if (!nullToAbsent || csosn != null) {
      map['CSOSN'] = Variable<String?>(csosn);
    }
    if (!nullToAbsent || cst != null) {
      map['CST'] = Variable<String?>(cst);
    }
    if (!nullToAbsent || modalidadeBc != null) {
      map['MODALIDADE_BC'] = Variable<String?>(modalidadeBc);
    }
    if (!nullToAbsent || aliquota != null) {
      map['ALIQUOTA'] = Variable<double?>(aliquota);
    }
    if (!nullToAbsent || valorPauta != null) {
      map['VALOR_PAUTA'] = Variable<double?>(valorPauta);
    }
    if (!nullToAbsent || valorPrecoMaximo != null) {
      map['VALOR_PRECO_MAXIMO'] = Variable<double?>(valorPrecoMaximo);
    }
    if (!nullToAbsent || mva != null) {
      map['MVA'] = Variable<double?>(mva);
    }
    if (!nullToAbsent || porcentoBc != null) {
      map['PORCENTO_BC'] = Variable<double?>(porcentoBc);
    }
    if (!nullToAbsent || modalidadeBcSt != null) {
      map['MODALIDADE_BC_ST'] = Variable<String?>(modalidadeBcSt);
    }
    if (!nullToAbsent || aliquotaInternaSt != null) {
      map['ALIQUOTA_INTERNA_ST'] = Variable<double?>(aliquotaInternaSt);
    }
    if (!nullToAbsent || aliquotaInterestadualSt != null) {
      map['ALIQUOTA_INTERESTADUAL_ST'] = Variable<double?>(aliquotaInterestadualSt);
    }
    if (!nullToAbsent || porcentoBcSt != null) {
      map['PORCENTO_BC_ST'] = Variable<double?>(porcentoBcSt);
    }
    if (!nullToAbsent || aliquotaIcmsSt != null) {
      map['ALIQUOTA_ICMS_ST'] = Variable<double?>(aliquotaIcmsSt);
    }
    if (!nullToAbsent || valorPautaSt != null) {
      map['VALOR_PAUTA_ST'] = Variable<double?>(valorPautaSt);
    }
    if (!nullToAbsent || valorPrecoMaximoSt != null) {
      map['VALOR_PRECO_MAXIMO_ST'] = Variable<double?>(valorPrecoMaximoSt);
    }
    return map;
  }

  TributIcmsUfsCompanion toCompanion(bool nullToAbsent) {
    return TributIcmsUfsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idTributConfiguraOfGt: idTributConfiguraOfGt == null && nullToAbsent
        ? const Value.absent()
        : Value(idTributConfiguraOfGt),
      ufDestino: ufDestino == null && nullToAbsent
        ? const Value.absent()
        : Value(ufDestino),
      cfop: cfop == null && nullToAbsent
        ? const Value.absent()
        : Value(cfop),
      csosn: csosn == null && nullToAbsent
        ? const Value.absent()
        : Value(csosn),
      cst: cst == null && nullToAbsent
        ? const Value.absent()
        : Value(cst),
      modalidadeBc: modalidadeBc == null && nullToAbsent
        ? const Value.absent()
        : Value(modalidadeBc),
      aliquota: aliquota == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquota),
      valorPauta: valorPauta == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPauta),
      valorPrecoMaximo: valorPrecoMaximo == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPrecoMaximo),
      mva: mva == null && nullToAbsent
        ? const Value.absent()
        : Value(mva),
      porcentoBc: porcentoBc == null && nullToAbsent
        ? const Value.absent()
        : Value(porcentoBc),
      modalidadeBcSt: modalidadeBcSt == null && nullToAbsent
        ? const Value.absent()
        : Value(modalidadeBcSt),
      aliquotaInternaSt: aliquotaInternaSt == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaInternaSt),
      aliquotaInterestadualSt: aliquotaInterestadualSt == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaInterestadualSt),
      porcentoBcSt: porcentoBcSt == null && nullToAbsent
        ? const Value.absent()
        : Value(porcentoBcSt),
      aliquotaIcmsSt: aliquotaIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaIcmsSt),
      valorPautaSt: valorPautaSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPautaSt),
      valorPrecoMaximoSt: valorPrecoMaximoSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPrecoMaximoSt),
    );
  }

  factory TributIcmsUf.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TributIcmsUf(
      id: serializer.fromJson<int>(json['id']),
      idTributConfiguraOfGt: serializer.fromJson<int>(json['idTributConfiguraOfGt']),
      ufDestino: serializer.fromJson<String>(json['ufDestino']),
      cfop: serializer.fromJson<int>(json['cfop']),
      csosn: serializer.fromJson<String>(json['csosn']),
      cst: serializer.fromJson<String>(json['cst']),
      modalidadeBc: serializer.fromJson<String>(json['modalidadeBc']),
      aliquota: serializer.fromJson<double>(json['aliquota']),
      valorPauta: serializer.fromJson<double>(json['valorPauta']),
      valorPrecoMaximo: serializer.fromJson<double>(json['valorPrecoMaximo']),
      mva: serializer.fromJson<double>(json['mva']),
      porcentoBc: serializer.fromJson<double>(json['porcentoBc']),
      modalidadeBcSt: serializer.fromJson<String>(json['modalidadeBcSt']),
      aliquotaInternaSt: serializer.fromJson<double>(json['aliquotaInternaSt']),
      aliquotaInterestadualSt: serializer.fromJson<double>(json['aliquotaInterestadualSt']),
      porcentoBcSt: serializer.fromJson<double>(json['porcentoBcSt']),
      aliquotaIcmsSt: serializer.fromJson<double>(json['aliquotaIcmsSt']),
      valorPautaSt: serializer.fromJson<double>(json['valorPautaSt']),
      valorPrecoMaximoSt: serializer.fromJson<double>(json['valorPrecoMaximoSt']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idTributConfiguraOfGt': serializer.toJson<int?>(idTributConfiguraOfGt),
      'ufDestino': serializer.toJson<String?>(ufDestino),
      'cfop': serializer.toJson<int?>(cfop),
      'csosn': serializer.toJson<String?>(csosn),
      'cst': serializer.toJson<String?>(cst),
      'modalidadeBc': serializer.toJson<String?>(modalidadeBc),
      'aliquota': serializer.toJson<double?>(aliquota),
      'valorPauta': serializer.toJson<double?>(valorPauta),
      'valorPrecoMaximo': serializer.toJson<double?>(valorPrecoMaximo),
      'mva': serializer.toJson<double?>(mva),
      'porcentoBc': serializer.toJson<double?>(porcentoBc),
      'modalidadeBcSt': serializer.toJson<String?>(modalidadeBcSt),
      'aliquotaInternaSt': serializer.toJson<double?>(aliquotaInternaSt),
      'aliquotaInterestadualSt': serializer.toJson<double?>(aliquotaInterestadualSt),
      'porcentoBcSt': serializer.toJson<double?>(porcentoBcSt),
      'aliquotaIcmsSt': serializer.toJson<double?>(aliquotaIcmsSt),
      'valorPautaSt': serializer.toJson<double?>(valorPautaSt),
      'valorPrecoMaximoSt': serializer.toJson<double?>(valorPrecoMaximoSt),
    };
  }

  TributIcmsUf copyWith(
        {
		  int? id,
          int? idTributConfiguraOfGt,
          String? ufDestino,
          int? cfop,
          String? csosn,
          String? cst,
          String? modalidadeBc,
          double? aliquota,
          double? valorPauta,
          double? valorPrecoMaximo,
          double? mva,
          double? porcentoBc,
          String? modalidadeBcSt,
          double? aliquotaInternaSt,
          double? aliquotaInterestadualSt,
          double? porcentoBcSt,
          double? aliquotaIcmsSt,
          double? valorPautaSt,
          double? valorPrecoMaximoSt,
		}) =>
      TributIcmsUf(
        id: id ?? this.id,
        idTributConfiguraOfGt: idTributConfiguraOfGt ?? this.idTributConfiguraOfGt,
        ufDestino: ufDestino ?? this.ufDestino,
        cfop: cfop ?? this.cfop,
        csosn: csosn ?? this.csosn,
        cst: cst ?? this.cst,
        modalidadeBc: modalidadeBc ?? this.modalidadeBc,
        aliquota: aliquota ?? this.aliquota,
        valorPauta: valorPauta ?? this.valorPauta,
        valorPrecoMaximo: valorPrecoMaximo ?? this.valorPrecoMaximo,
        mva: mva ?? this.mva,
        porcentoBc: porcentoBc ?? this.porcentoBc,
        modalidadeBcSt: modalidadeBcSt ?? this.modalidadeBcSt,
        aliquotaInternaSt: aliquotaInternaSt ?? this.aliquotaInternaSt,
        aliquotaInterestadualSt: aliquotaInterestadualSt ?? this.aliquotaInterestadualSt,
        porcentoBcSt: porcentoBcSt ?? this.porcentoBcSt,
        aliquotaIcmsSt: aliquotaIcmsSt ?? this.aliquotaIcmsSt,
        valorPautaSt: valorPautaSt ?? this.valorPautaSt,
        valorPrecoMaximoSt: valorPrecoMaximoSt ?? this.valorPrecoMaximoSt,
      );
  
  @override
  String toString() {
    return (StringBuffer('TributIcmsUf(')
          ..write('id: $id, ')
          ..write('idTributConfiguraOfGt: $idTributConfiguraOfGt, ')
          ..write('ufDestino: $ufDestino, ')
          ..write('cfop: $cfop, ')
          ..write('csosn: $csosn, ')
          ..write('cst: $cst, ')
          ..write('modalidadeBc: $modalidadeBc, ')
          ..write('aliquota: $aliquota, ')
          ..write('valorPauta: $valorPauta, ')
          ..write('valorPrecoMaximo: $valorPrecoMaximo, ')
          ..write('mva: $mva, ')
          ..write('porcentoBc: $porcentoBc, ')
          ..write('modalidadeBcSt: $modalidadeBcSt, ')
          ..write('aliquotaInternaSt: $aliquotaInternaSt, ')
          ..write('aliquotaInterestadualSt: $aliquotaInterestadualSt, ')
          ..write('porcentoBcSt: $porcentoBcSt, ')
          ..write('aliquotaIcmsSt: $aliquotaIcmsSt, ')
          ..write('valorPautaSt: $valorPautaSt, ')
          ..write('valorPrecoMaximoSt: $valorPrecoMaximoSt, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idTributConfiguraOfGt,
      ufDestino,
      cfop,
      csosn,
      cst,
      modalidadeBc,
      aliquota,
      valorPauta,
      valorPrecoMaximo,
      mva,
      porcentoBc,
      modalidadeBcSt,
      aliquotaInternaSt,
      aliquotaInterestadualSt,
      porcentoBcSt,
      aliquotaIcmsSt,
      valorPautaSt,
      valorPrecoMaximoSt,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TributIcmsUf &&
          other.id == id &&
          other.idTributConfiguraOfGt == idTributConfiguraOfGt &&
          other.ufDestino == ufDestino &&
          other.cfop == cfop &&
          other.csosn == csosn &&
          other.cst == cst &&
          other.modalidadeBc == modalidadeBc &&
          other.aliquota == aliquota &&
          other.valorPauta == valorPauta &&
          other.valorPrecoMaximo == valorPrecoMaximo &&
          other.mva == mva &&
          other.porcentoBc == porcentoBc &&
          other.modalidadeBcSt == modalidadeBcSt &&
          other.aliquotaInternaSt == aliquotaInternaSt &&
          other.aliquotaInterestadualSt == aliquotaInterestadualSt &&
          other.porcentoBcSt == porcentoBcSt &&
          other.aliquotaIcmsSt == aliquotaIcmsSt &&
          other.valorPautaSt == valorPautaSt &&
          other.valorPrecoMaximoSt == valorPrecoMaximoSt 
	   );
}

class TributIcmsUfsCompanion extends UpdateCompanion<TributIcmsUf> {

  final Value<int?> id;
  final Value<int?> idTributConfiguraOfGt;
  final Value<String?> ufDestino;
  final Value<int?> cfop;
  final Value<String?> csosn;
  final Value<String?> cst;
  final Value<String?> modalidadeBc;
  final Value<double?> aliquota;
  final Value<double?> valorPauta;
  final Value<double?> valorPrecoMaximo;
  final Value<double?> mva;
  final Value<double?> porcentoBc;
  final Value<String?> modalidadeBcSt;
  final Value<double?> aliquotaInternaSt;
  final Value<double?> aliquotaInterestadualSt;
  final Value<double?> porcentoBcSt;
  final Value<double?> aliquotaIcmsSt;
  final Value<double?> valorPautaSt;
  final Value<double?> valorPrecoMaximoSt;

  const TributIcmsUfsCompanion({
    this.id = const Value.absent(),
    this.idTributConfiguraOfGt = const Value.absent(),
    this.ufDestino = const Value.absent(),
    this.cfop = const Value.absent(),
    this.csosn = const Value.absent(),
    this.cst = const Value.absent(),
    this.modalidadeBc = const Value.absent(),
    this.aliquota = const Value.absent(),
    this.valorPauta = const Value.absent(),
    this.valorPrecoMaximo = const Value.absent(),
    this.mva = const Value.absent(),
    this.porcentoBc = const Value.absent(),
    this.modalidadeBcSt = const Value.absent(),
    this.aliquotaInternaSt = const Value.absent(),
    this.aliquotaInterestadualSt = const Value.absent(),
    this.porcentoBcSt = const Value.absent(),
    this.aliquotaIcmsSt = const Value.absent(),
    this.valorPautaSt = const Value.absent(),
    this.valorPrecoMaximoSt = const Value.absent(),
  });

  TributIcmsUfsCompanion.insert({
    this.id = const Value.absent(),
    this.idTributConfiguraOfGt = const Value.absent(),
    this.ufDestino = const Value.absent(),
    this.cfop = const Value.absent(),
    this.csosn = const Value.absent(),
    this.cst = const Value.absent(),
    this.modalidadeBc = const Value.absent(),
    this.aliquota = const Value.absent(),
    this.valorPauta = const Value.absent(),
    this.valorPrecoMaximo = const Value.absent(),
    this.mva = const Value.absent(),
    this.porcentoBc = const Value.absent(),
    this.modalidadeBcSt = const Value.absent(),
    this.aliquotaInternaSt = const Value.absent(),
    this.aliquotaInterestadualSt = const Value.absent(),
    this.porcentoBcSt = const Value.absent(),
    this.aliquotaIcmsSt = const Value.absent(),
    this.valorPautaSt = const Value.absent(),
    this.valorPrecoMaximoSt = const Value.absent(),
  });

  static Insertable<TributIcmsUf> custom({
    Expression<int>? id,
    Expression<int>? idTributConfiguraOfGt,
    Expression<String>? ufDestino,
    Expression<int>? cfop,
    Expression<String>? csosn,
    Expression<String>? cst,
    Expression<String>? modalidadeBc,
    Expression<double>? aliquota,
    Expression<double>? valorPauta,
    Expression<double>? valorPrecoMaximo,
    Expression<double>? mva,
    Expression<double>? porcentoBc,
    Expression<String>? modalidadeBcSt,
    Expression<double>? aliquotaInternaSt,
    Expression<double>? aliquotaInterestadualSt,
    Expression<double>? porcentoBcSt,
    Expression<double>? aliquotaIcmsSt,
    Expression<double>? valorPautaSt,
    Expression<double>? valorPrecoMaximoSt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idTributConfiguraOfGt != null) 'ID_TRIBUT_CONFIGURA_OF_GT': idTributConfiguraOfGt,
      if (ufDestino != null) 'UF_DESTINO': ufDestino,
      if (cfop != null) 'CFOP': cfop,
      if (csosn != null) 'CSOSN': csosn,
      if (cst != null) 'CST': cst,
      if (modalidadeBc != null) 'MODALIDADE_BC': modalidadeBc,
      if (aliquota != null) 'ALIQUOTA': aliquota,
      if (valorPauta != null) 'VALOR_PAUTA': valorPauta,
      if (valorPrecoMaximo != null) 'VALOR_PRECO_MAXIMO': valorPrecoMaximo,
      if (mva != null) 'MVA': mva,
      if (porcentoBc != null) 'PORCENTO_BC': porcentoBc,
      if (modalidadeBcSt != null) 'MODALIDADE_BC_ST': modalidadeBcSt,
      if (aliquotaInternaSt != null) 'ALIQUOTA_INTERNA_ST': aliquotaInternaSt,
      if (aliquotaInterestadualSt != null) 'ALIQUOTA_INTERESTADUAL_ST': aliquotaInterestadualSt,
      if (porcentoBcSt != null) 'PORCENTO_BC_ST': porcentoBcSt,
      if (aliquotaIcmsSt != null) 'ALIQUOTA_ICMS_ST': aliquotaIcmsSt,
      if (valorPautaSt != null) 'VALOR_PAUTA_ST': valorPautaSt,
      if (valorPrecoMaximoSt != null) 'VALOR_PRECO_MAXIMO_ST': valorPrecoMaximoSt,
    });
  }

  TributIcmsUfsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idTributConfiguraOfGt,
      Value<String>? ufDestino,
      Value<int>? cfop,
      Value<String>? csosn,
      Value<String>? cst,
      Value<String>? modalidadeBc,
      Value<double>? aliquota,
      Value<double>? valorPauta,
      Value<double>? valorPrecoMaximo,
      Value<double>? mva,
      Value<double>? porcentoBc,
      Value<String>? modalidadeBcSt,
      Value<double>? aliquotaInternaSt,
      Value<double>? aliquotaInterestadualSt,
      Value<double>? porcentoBcSt,
      Value<double>? aliquotaIcmsSt,
      Value<double>? valorPautaSt,
      Value<double>? valorPrecoMaximoSt,
	  }) {
    return TributIcmsUfsCompanion(
      id: id ?? this.id,
      idTributConfiguraOfGt: idTributConfiguraOfGt ?? this.idTributConfiguraOfGt,
      ufDestino: ufDestino ?? this.ufDestino,
      cfop: cfop ?? this.cfop,
      csosn: csosn ?? this.csosn,
      cst: cst ?? this.cst,
      modalidadeBc: modalidadeBc ?? this.modalidadeBc,
      aliquota: aliquota ?? this.aliquota,
      valorPauta: valorPauta ?? this.valorPauta,
      valorPrecoMaximo: valorPrecoMaximo ?? this.valorPrecoMaximo,
      mva: mva ?? this.mva,
      porcentoBc: porcentoBc ?? this.porcentoBc,
      modalidadeBcSt: modalidadeBcSt ?? this.modalidadeBcSt,
      aliquotaInternaSt: aliquotaInternaSt ?? this.aliquotaInternaSt,
      aliquotaInterestadualSt: aliquotaInterestadualSt ?? this.aliquotaInterestadualSt,
      porcentoBcSt: porcentoBcSt ?? this.porcentoBcSt,
      aliquotaIcmsSt: aliquotaIcmsSt ?? this.aliquotaIcmsSt,
      valorPautaSt: valorPautaSt ?? this.valorPautaSt,
      valorPrecoMaximoSt: valorPrecoMaximoSt ?? this.valorPrecoMaximoSt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idTributConfiguraOfGt.present) {
      map['ID_TRIBUT_CONFIGURA_OF_GT'] = Variable<int?>(idTributConfiguraOfGt.value);
    }
    if (ufDestino.present) {
      map['UF_DESTINO'] = Variable<String?>(ufDestino.value);
    }
    if (cfop.present) {
      map['CFOP'] = Variable<int?>(cfop.value);
    }
    if (csosn.present) {
      map['CSOSN'] = Variable<String?>(csosn.value);
    }
    if (cst.present) {
      map['CST'] = Variable<String?>(cst.value);
    }
    if (modalidadeBc.present) {
      map['MODALIDADE_BC'] = Variable<String?>(modalidadeBc.value);
    }
    if (aliquota.present) {
      map['ALIQUOTA'] = Variable<double?>(aliquota.value);
    }
    if (valorPauta.present) {
      map['VALOR_PAUTA'] = Variable<double?>(valorPauta.value);
    }
    if (valorPrecoMaximo.present) {
      map['VALOR_PRECO_MAXIMO'] = Variable<double?>(valorPrecoMaximo.value);
    }
    if (mva.present) {
      map['MVA'] = Variable<double?>(mva.value);
    }
    if (porcentoBc.present) {
      map['PORCENTO_BC'] = Variable<double?>(porcentoBc.value);
    }
    if (modalidadeBcSt.present) {
      map['MODALIDADE_BC_ST'] = Variable<String?>(modalidadeBcSt.value);
    }
    if (aliquotaInternaSt.present) {
      map['ALIQUOTA_INTERNA_ST'] = Variable<double?>(aliquotaInternaSt.value);
    }
    if (aliquotaInterestadualSt.present) {
      map['ALIQUOTA_INTERESTADUAL_ST'] = Variable<double?>(aliquotaInterestadualSt.value);
    }
    if (porcentoBcSt.present) {
      map['PORCENTO_BC_ST'] = Variable<double?>(porcentoBcSt.value);
    }
    if (aliquotaIcmsSt.present) {
      map['ALIQUOTA_ICMS_ST'] = Variable<double?>(aliquotaIcmsSt.value);
    }
    if (valorPautaSt.present) {
      map['VALOR_PAUTA_ST'] = Variable<double?>(valorPautaSt.value);
    }
    if (valorPrecoMaximoSt.present) {
      map['VALOR_PRECO_MAXIMO_ST'] = Variable<double?>(valorPrecoMaximoSt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TributIcmsUfsCompanion(')
          ..write('id: $id, ')
          ..write('idTributConfiguraOfGt: $idTributConfiguraOfGt, ')
          ..write('ufDestino: $ufDestino, ')
          ..write('cfop: $cfop, ')
          ..write('csosn: $csosn, ')
          ..write('cst: $cst, ')
          ..write('modalidadeBc: $modalidadeBc, ')
          ..write('aliquota: $aliquota, ')
          ..write('valorPauta: $valorPauta, ')
          ..write('valorPrecoMaximo: $valorPrecoMaximo, ')
          ..write('mva: $mva, ')
          ..write('porcentoBc: $porcentoBc, ')
          ..write('modalidadeBcSt: $modalidadeBcSt, ')
          ..write('aliquotaInternaSt: $aliquotaInternaSt, ')
          ..write('aliquotaInterestadualSt: $aliquotaInterestadualSt, ')
          ..write('porcentoBcSt: $porcentoBcSt, ')
          ..write('aliquotaIcmsSt: $aliquotaIcmsSt, ')
          ..write('valorPautaSt: $valorPautaSt, ')
          ..write('valorPrecoMaximoSt: $valorPrecoMaximoSt, ')
          ..write(')'))
        .toString();
  }
}

class $TributIcmsUfsTable extends TributIcmsUfs
    with TableInfo<$TributIcmsUfsTable, TributIcmsUf> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TributIcmsUfsTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idTributConfiguraOfGtMeta =
      const VerificationMeta('idTributConfiguraOfGt');
  GeneratedColumn<int>? _idTributConfiguraOfGt;
  @override
  GeneratedColumn<int> get idTributConfiguraOfGt =>
      _idTributConfiguraOfGt ??= GeneratedColumn<int>('ID_TRIBUT_CONFIGURA_OF_GT', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES TRIBUT_CONFIGURA_OF_GT(ID)');
  final VerificationMeta _ufDestinoMeta =
      const VerificationMeta('ufDestino');
  GeneratedColumn<String>? _ufDestino;
  @override
  GeneratedColumn<String> get ufDestino => _ufDestino ??=
      GeneratedColumn<String>('UF_DESTINO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cfopMeta =
      const VerificationMeta('cfop');
  GeneratedColumn<int>? _cfop;
  @override
  GeneratedColumn<int> get cfop => _cfop ??=
      GeneratedColumn<int>('CFOP', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _csosnMeta =
      const VerificationMeta('csosn');
  GeneratedColumn<String>? _csosn;
  @override
  GeneratedColumn<String> get csosn => _csosn ??=
      GeneratedColumn<String>('CSOSN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cstMeta =
      const VerificationMeta('cst');
  GeneratedColumn<String>? _cst;
  @override
  GeneratedColumn<String> get cst => _cst ??=
      GeneratedColumn<String>('CST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _modalidadeBcMeta =
      const VerificationMeta('modalidadeBc');
  GeneratedColumn<String>? _modalidadeBc;
  @override
  GeneratedColumn<String> get modalidadeBc => _modalidadeBc ??=
      GeneratedColumn<String>('MODALIDADE_BC', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _aliquotaMeta =
      const VerificationMeta('aliquota');
  GeneratedColumn<double>? _aliquota;
  @override
  GeneratedColumn<double> get aliquota => _aliquota ??=
      GeneratedColumn<double>('ALIQUOTA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPautaMeta =
      const VerificationMeta('valorPauta');
  GeneratedColumn<double>? _valorPauta;
  @override
  GeneratedColumn<double> get valorPauta => _valorPauta ??=
      GeneratedColumn<double>('VALOR_PAUTA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPrecoMaximoMeta =
      const VerificationMeta('valorPrecoMaximo');
  GeneratedColumn<double>? _valorPrecoMaximo;
  @override
  GeneratedColumn<double> get valorPrecoMaximo => _valorPrecoMaximo ??=
      GeneratedColumn<double>('VALOR_PRECO_MAXIMO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _mvaMeta =
      const VerificationMeta('mva');
  GeneratedColumn<double>? _mva;
  @override
  GeneratedColumn<double> get mva => _mva ??=
      GeneratedColumn<double>('MVA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _porcentoBcMeta =
      const VerificationMeta('porcentoBc');
  GeneratedColumn<double>? _porcentoBc;
  @override
  GeneratedColumn<double> get porcentoBc => _porcentoBc ??=
      GeneratedColumn<double>('PORCENTO_BC', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _modalidadeBcStMeta =
      const VerificationMeta('modalidadeBcSt');
  GeneratedColumn<String>? _modalidadeBcSt;
  @override
  GeneratedColumn<String> get modalidadeBcSt => _modalidadeBcSt ??=
      GeneratedColumn<String>('MODALIDADE_BC_ST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _aliquotaInternaStMeta =
      const VerificationMeta('aliquotaInternaSt');
  GeneratedColumn<double>? _aliquotaInternaSt;
  @override
  GeneratedColumn<double> get aliquotaInternaSt => _aliquotaInternaSt ??=
      GeneratedColumn<double>('ALIQUOTA_INTERNA_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaInterestadualStMeta =
      const VerificationMeta('aliquotaInterestadualSt');
  GeneratedColumn<double>? _aliquotaInterestadualSt;
  @override
  GeneratedColumn<double> get aliquotaInterestadualSt => _aliquotaInterestadualSt ??=
      GeneratedColumn<double>('ALIQUOTA_INTERESTADUAL_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _porcentoBcStMeta =
      const VerificationMeta('porcentoBcSt');
  GeneratedColumn<double>? _porcentoBcSt;
  @override
  GeneratedColumn<double> get porcentoBcSt => _porcentoBcSt ??=
      GeneratedColumn<double>('PORCENTO_BC_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaIcmsStMeta =
      const VerificationMeta('aliquotaIcmsSt');
  GeneratedColumn<double>? _aliquotaIcmsSt;
  @override
  GeneratedColumn<double> get aliquotaIcmsSt => _aliquotaIcmsSt ??=
      GeneratedColumn<double>('ALIQUOTA_ICMS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPautaStMeta =
      const VerificationMeta('valorPautaSt');
  GeneratedColumn<double>? _valorPautaSt;
  @override
  GeneratedColumn<double> get valorPautaSt => _valorPautaSt ??=
      GeneratedColumn<double>('VALOR_PAUTA_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPrecoMaximoStMeta =
      const VerificationMeta('valorPrecoMaximoSt');
  GeneratedColumn<double>? _valorPrecoMaximoSt;
  @override
  GeneratedColumn<double> get valorPrecoMaximoSt => _valorPrecoMaximoSt ??=
      GeneratedColumn<double>('VALOR_PRECO_MAXIMO_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idTributConfiguraOfGt,
        ufDestino,
        cfop,
        csosn,
        cst,
        modalidadeBc,
        aliquota,
        valorPauta,
        valorPrecoMaximo,
        mva,
        porcentoBc,
        modalidadeBcSt,
        aliquotaInternaSt,
        aliquotaInterestadualSt,
        porcentoBcSt,
        aliquotaIcmsSt,
        valorPautaSt,
        valorPrecoMaximoSt,
      ];

  @override
  String get aliasedName => _alias ?? 'TRIBUT_ICMS_UF';
  
  @override
  String get actualTableName => 'TRIBUT_ICMS_UF';
  
  @override
  VerificationContext validateIntegrity(Insertable<TributIcmsUf> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_TRIBUT_CONFIGURA_OF_GT')) {
        context.handle(_idTributConfiguraOfGtMeta,
            idTributConfiguraOfGt.isAcceptableOrUnknown(data['ID_TRIBUT_CONFIGURA_OF_GT']!, _idTributConfiguraOfGtMeta));
    }
    if (data.containsKey('UF_DESTINO')) {
        context.handle(_ufDestinoMeta,
            ufDestino.isAcceptableOrUnknown(data['UF_DESTINO']!, _ufDestinoMeta));
    }
    if (data.containsKey('CFOP')) {
        context.handle(_cfopMeta,
            cfop.isAcceptableOrUnknown(data['CFOP']!, _cfopMeta));
    }
    if (data.containsKey('CSOSN')) {
        context.handle(_csosnMeta,
            csosn.isAcceptableOrUnknown(data['CSOSN']!, _csosnMeta));
    }
    if (data.containsKey('CST')) {
        context.handle(_cstMeta,
            cst.isAcceptableOrUnknown(data['CST']!, _cstMeta));
    }
    if (data.containsKey('MODALIDADE_BC')) {
        context.handle(_modalidadeBcMeta,
            modalidadeBc.isAcceptableOrUnknown(data['MODALIDADE_BC']!, _modalidadeBcMeta));
    }
    if (data.containsKey('ALIQUOTA')) {
        context.handle(_aliquotaMeta,
            aliquota.isAcceptableOrUnknown(data['ALIQUOTA']!, _aliquotaMeta));
    }
    if (data.containsKey('VALOR_PAUTA')) {
        context.handle(_valorPautaMeta,
            valorPauta.isAcceptableOrUnknown(data['VALOR_PAUTA']!, _valorPautaMeta));
    }
    if (data.containsKey('VALOR_PRECO_MAXIMO')) {
        context.handle(_valorPrecoMaximoMeta,
            valorPrecoMaximo.isAcceptableOrUnknown(data['VALOR_PRECO_MAXIMO']!, _valorPrecoMaximoMeta));
    }
    if (data.containsKey('MVA')) {
        context.handle(_mvaMeta,
            mva.isAcceptableOrUnknown(data['MVA']!, _mvaMeta));
    }
    if (data.containsKey('PORCENTO_BC')) {
        context.handle(_porcentoBcMeta,
            porcentoBc.isAcceptableOrUnknown(data['PORCENTO_BC']!, _porcentoBcMeta));
    }
    if (data.containsKey('MODALIDADE_BC_ST')) {
        context.handle(_modalidadeBcStMeta,
            modalidadeBcSt.isAcceptableOrUnknown(data['MODALIDADE_BC_ST']!, _modalidadeBcStMeta));
    }
    if (data.containsKey('ALIQUOTA_INTERNA_ST')) {
        context.handle(_aliquotaInternaStMeta,
            aliquotaInternaSt.isAcceptableOrUnknown(data['ALIQUOTA_INTERNA_ST']!, _aliquotaInternaStMeta));
    }
    if (data.containsKey('ALIQUOTA_INTERESTADUAL_ST')) {
        context.handle(_aliquotaInterestadualStMeta,
            aliquotaInterestadualSt.isAcceptableOrUnknown(data['ALIQUOTA_INTERESTADUAL_ST']!, _aliquotaInterestadualStMeta));
    }
    if (data.containsKey('PORCENTO_BC_ST')) {
        context.handle(_porcentoBcStMeta,
            porcentoBcSt.isAcceptableOrUnknown(data['PORCENTO_BC_ST']!, _porcentoBcStMeta));
    }
    if (data.containsKey('ALIQUOTA_ICMS_ST')) {
        context.handle(_aliquotaIcmsStMeta,
            aliquotaIcmsSt.isAcceptableOrUnknown(data['ALIQUOTA_ICMS_ST']!, _aliquotaIcmsStMeta));
    }
    if (data.containsKey('VALOR_PAUTA_ST')) {
        context.handle(_valorPautaStMeta,
            valorPautaSt.isAcceptableOrUnknown(data['VALOR_PAUTA_ST']!, _valorPautaStMeta));
    }
    if (data.containsKey('VALOR_PRECO_MAXIMO_ST')) {
        context.handle(_valorPrecoMaximoStMeta,
            valorPrecoMaximoSt.isAcceptableOrUnknown(data['VALOR_PRECO_MAXIMO_ST']!, _valorPrecoMaximoStMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TributIcmsUf map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TributIcmsUf.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TributIcmsUfsTable createAlias(String alias) {
    return $TributIcmsUfsTable(_db, alias);
  }
}