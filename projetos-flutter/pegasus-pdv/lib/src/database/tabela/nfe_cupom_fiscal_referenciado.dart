/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_CUPOM_FISCAL_REFERENCIADO] 
                                                                                
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

@DataClassName("NfeCupomFiscalReferenciado")
@UseRowClass(NfeCupomFiscalReferenciado)
class NfeCupomFiscalReferenciados extends Table {
  @override
  String get tableName => 'NFE_CUPOM_FISCAL_REFERENCIADO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  TextColumn get modeloDocumentoFiscal => text().named('MODELO_DOCUMENTO_FISCAL').withLength(min: 0, max: 2).nullable()();
  IntColumn get numeroOrdemEcf => integer().named('NUMERO_ORDEM_ECF').nullable()();
  IntColumn get coo => integer().named('COO').nullable()();
  DateTimeColumn get dataEmissaoCupom => dateTime().named('DATA_EMISSAO_CUPOM').nullable()();
  IntColumn get numeroCaixa => integer().named('NUMERO_CAIXA').nullable()();
  TextColumn get numeroSerieEcf => text().named('NUMERO_SERIE_ECF').withLength(min: 0, max: 21).nullable()();
}

class NfeCupomFiscalReferenciado extends DataClass implements Insertable<NfeCupomFiscalReferenciado> {
  final int? id;
  final int? idNfeCabecalho;
  final String? modeloDocumentoFiscal;
  final int? numeroOrdemEcf;
  final int? coo;
  final DateTime? dataEmissaoCupom;
  final int? numeroCaixa;
  final String? numeroSerieEcf;

  NfeCupomFiscalReferenciado(
    {
      required this.id,
      this.idNfeCabecalho,
      this.modeloDocumentoFiscal,
      this.numeroOrdemEcf,
      this.coo,
      this.dataEmissaoCupom,
      this.numeroCaixa,
      this.numeroSerieEcf,
    }
  );

  factory NfeCupomFiscalReferenciado.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeCupomFiscalReferenciado(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      modeloDocumentoFiscal: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODELO_DOCUMENTO_FISCAL']),
      numeroOrdemEcf: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_ORDEM_ECF']),
      coo: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}COO']),
      dataEmissaoCupom: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_EMISSAO_CUPOM']),
      numeroCaixa: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_CAIXA']),
      numeroSerieEcf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_SERIE_ECF']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeCabecalho != null) {
      map['ID_NFE_CABECALHO'] = Variable<int?>(idNfeCabecalho);
    }
    if (!nullToAbsent || modeloDocumentoFiscal != null) {
      map['MODELO_DOCUMENTO_FISCAL'] = Variable<String?>(modeloDocumentoFiscal);
    }
    if (!nullToAbsent || numeroOrdemEcf != null) {
      map['NUMERO_ORDEM_ECF'] = Variable<int?>(numeroOrdemEcf);
    }
    if (!nullToAbsent || coo != null) {
      map['COO'] = Variable<int?>(coo);
    }
    if (!nullToAbsent || dataEmissaoCupom != null) {
      map['DATA_EMISSAO_CUPOM'] = Variable<DateTime?>(dataEmissaoCupom);
    }
    if (!nullToAbsent || numeroCaixa != null) {
      map['NUMERO_CAIXA'] = Variable<int?>(numeroCaixa);
    }
    if (!nullToAbsent || numeroSerieEcf != null) {
      map['NUMERO_SERIE_ECF'] = Variable<String?>(numeroSerieEcf);
    }
    return map;
  }

  NfeCupomFiscalReferenciadosCompanion toCompanion(bool nullToAbsent) {
    return NfeCupomFiscalReferenciadosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      modeloDocumentoFiscal: modeloDocumentoFiscal == null && nullToAbsent
        ? const Value.absent()
        : Value(modeloDocumentoFiscal),
      numeroOrdemEcf: numeroOrdemEcf == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroOrdemEcf),
      coo: coo == null && nullToAbsent
        ? const Value.absent()
        : Value(coo),
      dataEmissaoCupom: dataEmissaoCupom == null && nullToAbsent
        ? const Value.absent()
        : Value(dataEmissaoCupom),
      numeroCaixa: numeroCaixa == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroCaixa),
      numeroSerieEcf: numeroSerieEcf == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroSerieEcf),
    );
  }

  factory NfeCupomFiscalReferenciado.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeCupomFiscalReferenciado(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      modeloDocumentoFiscal: serializer.fromJson<String>(json['modeloDocumentoFiscal']),
      numeroOrdemEcf: serializer.fromJson<int>(json['numeroOrdemEcf']),
      coo: serializer.fromJson<int>(json['coo']),
      dataEmissaoCupom: serializer.fromJson<DateTime>(json['dataEmissaoCupom']),
      numeroCaixa: serializer.fromJson<int>(json['numeroCaixa']),
      numeroSerieEcf: serializer.fromJson<String>(json['numeroSerieEcf']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'modeloDocumentoFiscal': serializer.toJson<String?>(modeloDocumentoFiscal),
      'numeroOrdemEcf': serializer.toJson<int?>(numeroOrdemEcf),
      'coo': serializer.toJson<int?>(coo),
      'dataEmissaoCupom': serializer.toJson<DateTime?>(dataEmissaoCupom),
      'numeroCaixa': serializer.toJson<int?>(numeroCaixa),
      'numeroSerieEcf': serializer.toJson<String?>(numeroSerieEcf),
    };
  }

  NfeCupomFiscalReferenciado copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          String? modeloDocumentoFiscal,
          int? numeroOrdemEcf,
          int? coo,
          DateTime? dataEmissaoCupom,
          int? numeroCaixa,
          String? numeroSerieEcf,
		}) =>
      NfeCupomFiscalReferenciado(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        modeloDocumentoFiscal: modeloDocumentoFiscal ?? this.modeloDocumentoFiscal,
        numeroOrdemEcf: numeroOrdemEcf ?? this.numeroOrdemEcf,
        coo: coo ?? this.coo,
        dataEmissaoCupom: dataEmissaoCupom ?? this.dataEmissaoCupom,
        numeroCaixa: numeroCaixa ?? this.numeroCaixa,
        numeroSerieEcf: numeroSerieEcf ?? this.numeroSerieEcf,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeCupomFiscalReferenciado(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('modeloDocumentoFiscal: $modeloDocumentoFiscal, ')
          ..write('numeroOrdemEcf: $numeroOrdemEcf, ')
          ..write('coo: $coo, ')
          ..write('dataEmissaoCupom: $dataEmissaoCupom, ')
          ..write('numeroCaixa: $numeroCaixa, ')
          ..write('numeroSerieEcf: $numeroSerieEcf, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      modeloDocumentoFiscal,
      numeroOrdemEcf,
      coo,
      dataEmissaoCupom,
      numeroCaixa,
      numeroSerieEcf,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeCupomFiscalReferenciado &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.modeloDocumentoFiscal == modeloDocumentoFiscal &&
          other.numeroOrdemEcf == numeroOrdemEcf &&
          other.coo == coo &&
          other.dataEmissaoCupom == dataEmissaoCupom &&
          other.numeroCaixa == numeroCaixa &&
          other.numeroSerieEcf == numeroSerieEcf 
	   );
}

class NfeCupomFiscalReferenciadosCompanion extends UpdateCompanion<NfeCupomFiscalReferenciado> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<String?> modeloDocumentoFiscal;
  final Value<int?> numeroOrdemEcf;
  final Value<int?> coo;
  final Value<DateTime?> dataEmissaoCupom;
  final Value<int?> numeroCaixa;
  final Value<String?> numeroSerieEcf;

  const NfeCupomFiscalReferenciadosCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.modeloDocumentoFiscal = const Value.absent(),
    this.numeroOrdemEcf = const Value.absent(),
    this.coo = const Value.absent(),
    this.dataEmissaoCupom = const Value.absent(),
    this.numeroCaixa = const Value.absent(),
    this.numeroSerieEcf = const Value.absent(),
  });

  NfeCupomFiscalReferenciadosCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.modeloDocumentoFiscal = const Value.absent(),
    this.numeroOrdemEcf = const Value.absent(),
    this.coo = const Value.absent(),
    this.dataEmissaoCupom = const Value.absent(),
    this.numeroCaixa = const Value.absent(),
    this.numeroSerieEcf = const Value.absent(),
  });

  static Insertable<NfeCupomFiscalReferenciado> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<String>? modeloDocumentoFiscal,
    Expression<int>? numeroOrdemEcf,
    Expression<int>? coo,
    Expression<DateTime>? dataEmissaoCupom,
    Expression<int>? numeroCaixa,
    Expression<String>? numeroSerieEcf,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (modeloDocumentoFiscal != null) 'MODELO_DOCUMENTO_FISCAL': modeloDocumentoFiscal,
      if (numeroOrdemEcf != null) 'NUMERO_ORDEM_ECF': numeroOrdemEcf,
      if (coo != null) 'COO': coo,
      if (dataEmissaoCupom != null) 'DATA_EMISSAO_CUPOM': dataEmissaoCupom,
      if (numeroCaixa != null) 'NUMERO_CAIXA': numeroCaixa,
      if (numeroSerieEcf != null) 'NUMERO_SERIE_ECF': numeroSerieEcf,
    });
  }

  NfeCupomFiscalReferenciadosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<String>? modeloDocumentoFiscal,
      Value<int>? numeroOrdemEcf,
      Value<int>? coo,
      Value<DateTime>? dataEmissaoCupom,
      Value<int>? numeroCaixa,
      Value<String>? numeroSerieEcf,
	  }) {
    return NfeCupomFiscalReferenciadosCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      modeloDocumentoFiscal: modeloDocumentoFiscal ?? this.modeloDocumentoFiscal,
      numeroOrdemEcf: numeroOrdemEcf ?? this.numeroOrdemEcf,
      coo: coo ?? this.coo,
      dataEmissaoCupom: dataEmissaoCupom ?? this.dataEmissaoCupom,
      numeroCaixa: numeroCaixa ?? this.numeroCaixa,
      numeroSerieEcf: numeroSerieEcf ?? this.numeroSerieEcf,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeCabecalho.present) {
      map['ID_NFE_CABECALHO'] = Variable<int?>(idNfeCabecalho.value);
    }
    if (modeloDocumentoFiscal.present) {
      map['MODELO_DOCUMENTO_FISCAL'] = Variable<String?>(modeloDocumentoFiscal.value);
    }
    if (numeroOrdemEcf.present) {
      map['NUMERO_ORDEM_ECF'] = Variable<int?>(numeroOrdemEcf.value);
    }
    if (coo.present) {
      map['COO'] = Variable<int?>(coo.value);
    }
    if (dataEmissaoCupom.present) {
      map['DATA_EMISSAO_CUPOM'] = Variable<DateTime?>(dataEmissaoCupom.value);
    }
    if (numeroCaixa.present) {
      map['NUMERO_CAIXA'] = Variable<int?>(numeroCaixa.value);
    }
    if (numeroSerieEcf.present) {
      map['NUMERO_SERIE_ECF'] = Variable<String?>(numeroSerieEcf.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeCupomFiscalReferenciadosCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('modeloDocumentoFiscal: $modeloDocumentoFiscal, ')
          ..write('numeroOrdemEcf: $numeroOrdemEcf, ')
          ..write('coo: $coo, ')
          ..write('dataEmissaoCupom: $dataEmissaoCupom, ')
          ..write('numeroCaixa: $numeroCaixa, ')
          ..write('numeroSerieEcf: $numeroSerieEcf, ')
          ..write(')'))
        .toString();
  }
}

class $NfeCupomFiscalReferenciadosTable extends NfeCupomFiscalReferenciados
    with TableInfo<$NfeCupomFiscalReferenciadosTable, NfeCupomFiscalReferenciado> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeCupomFiscalReferenciadosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeCabecalhoMeta =
      const VerificationMeta('idNfeCabecalho');
  GeneratedColumn<int>? _idNfeCabecalho;
  @override
  GeneratedColumn<int> get idNfeCabecalho =>
      _idNfeCabecalho ??= GeneratedColumn<int>('ID_NFE_CABECALHO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_CABECALHO(ID)');
  final VerificationMeta _modeloDocumentoFiscalMeta =
      const VerificationMeta('modeloDocumentoFiscal');
  GeneratedColumn<String>? _modeloDocumentoFiscal;
  @override
  GeneratedColumn<String> get modeloDocumentoFiscal => _modeloDocumentoFiscal ??=
      GeneratedColumn<String>('MODELO_DOCUMENTO_FISCAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroOrdemEcfMeta =
      const VerificationMeta('numeroOrdemEcf');
  GeneratedColumn<int>? _numeroOrdemEcf;
  @override
  GeneratedColumn<int> get numeroOrdemEcf => _numeroOrdemEcf ??=
      GeneratedColumn<int>('NUMERO_ORDEM_ECF', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _cooMeta =
      const VerificationMeta('coo');
  GeneratedColumn<int>? _coo;
  @override
  GeneratedColumn<int> get coo => _coo ??=
      GeneratedColumn<int>('COO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dataEmissaoCupomMeta =
      const VerificationMeta('dataEmissaoCupom');
  GeneratedColumn<DateTime>? _dataEmissaoCupom;
  @override
  GeneratedColumn<DateTime> get dataEmissaoCupom => _dataEmissaoCupom ??=
      GeneratedColumn<DateTime>('DATA_EMISSAO_CUPOM', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _numeroCaixaMeta =
      const VerificationMeta('numeroCaixa');
  GeneratedColumn<int>? _numeroCaixa;
  @override
  GeneratedColumn<int> get numeroCaixa => _numeroCaixa ??=
      GeneratedColumn<int>('NUMERO_CAIXA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _numeroSerieEcfMeta =
      const VerificationMeta('numeroSerieEcf');
  GeneratedColumn<String>? _numeroSerieEcf;
  @override
  GeneratedColumn<String> get numeroSerieEcf => _numeroSerieEcf ??=
      GeneratedColumn<String>('NUMERO_SERIE_ECF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        modeloDocumentoFiscal,
        numeroOrdemEcf,
        coo,
        dataEmissaoCupom,
        numeroCaixa,
        numeroSerieEcf,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_CUPOM_FISCAL_REFERENCIADO';
  
  @override
  String get actualTableName => 'NFE_CUPOM_FISCAL_REFERENCIADO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeCupomFiscalReferenciado> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_CABECALHO')) {
        context.handle(_idNfeCabecalhoMeta,
            idNfeCabecalho.isAcceptableOrUnknown(data['ID_NFE_CABECALHO']!, _idNfeCabecalhoMeta));
    }
    if (data.containsKey('MODELO_DOCUMENTO_FISCAL')) {
        context.handle(_modeloDocumentoFiscalMeta,
            modeloDocumentoFiscal.isAcceptableOrUnknown(data['MODELO_DOCUMENTO_FISCAL']!, _modeloDocumentoFiscalMeta));
    }
    if (data.containsKey('NUMERO_ORDEM_ECF')) {
        context.handle(_numeroOrdemEcfMeta,
            numeroOrdemEcf.isAcceptableOrUnknown(data['NUMERO_ORDEM_ECF']!, _numeroOrdemEcfMeta));
    }
    if (data.containsKey('COO')) {
        context.handle(_cooMeta,
            coo.isAcceptableOrUnknown(data['COO']!, _cooMeta));
    }
    if (data.containsKey('DATA_EMISSAO_CUPOM')) {
        context.handle(_dataEmissaoCupomMeta,
            dataEmissaoCupom.isAcceptableOrUnknown(data['DATA_EMISSAO_CUPOM']!, _dataEmissaoCupomMeta));
    }
    if (data.containsKey('NUMERO_CAIXA')) {
        context.handle(_numeroCaixaMeta,
            numeroCaixa.isAcceptableOrUnknown(data['NUMERO_CAIXA']!, _numeroCaixaMeta));
    }
    if (data.containsKey('NUMERO_SERIE_ECF')) {
        context.handle(_numeroSerieEcfMeta,
            numeroSerieEcf.isAcceptableOrUnknown(data['NUMERO_SERIE_ECF']!, _numeroSerieEcfMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeCupomFiscalReferenciado map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeCupomFiscalReferenciado.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeCupomFiscalReferenciadosTable createAlias(String alias) {
    return $NfeCupomFiscalReferenciadosTable(_db, alias);
  }
}