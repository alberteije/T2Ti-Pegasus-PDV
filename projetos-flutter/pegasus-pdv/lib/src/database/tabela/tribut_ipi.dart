/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [TRIBUT_IPI] 
                                                                                
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

@DataClassName("TributIpi")
@UseRowClass(TributIpi)
class TributIpis extends Table {
  @override
  String get tableName => 'TRIBUT_IPI';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idTributConfiguraOfGt => integer().named('ID_TRIBUT_CONFIGURA_OF_GT').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_CONFIGURA_OF_GT(ID)')();
  TextColumn get cstIpi => text().named('CST_IPI').withLength(min: 0, max: 2).nullable()();
  TextColumn get modalidadeBaseCalculo => text().named('MODALIDADE_BASE_CALCULO').withLength(min: 0, max: 1).nullable()();
  RealColumn get porcentoBaseCalculo => real().named('PORCENTO_BASE_CALCULO').nullable()();
  RealColumn get aliquotaPorcento => real().named('ALIQUOTA_PORCENTO').nullable()();
  RealColumn get aliquotaUnidade => real().named('ALIQUOTA_UNIDADE').nullable()();
  RealColumn get valorPrecoMaximo => real().named('VALOR_PRECO_MAXIMO').nullable()();
  RealColumn get valorPautaFiscal => real().named('VALOR_PAUTA_FISCAL').nullable()();
}

class TributIpi extends DataClass implements Insertable<TributIpi> {
  final int? id;
  final int? idTributConfiguraOfGt;
  final String? cstIpi;
  final String? modalidadeBaseCalculo;
  final double? porcentoBaseCalculo;
  final double? aliquotaPorcento;
  final double? aliquotaUnidade;
  final double? valorPrecoMaximo;
  final double? valorPautaFiscal;

  TributIpi(
    {
      required this.id,
      this.idTributConfiguraOfGt,
      this.cstIpi,
      this.modalidadeBaseCalculo,
      this.porcentoBaseCalculo,
      this.aliquotaPorcento,
      this.aliquotaUnidade,
      this.valorPrecoMaximo,
      this.valorPautaFiscal,
    }
  );

  factory TributIpi.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TributIpi(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idTributConfiguraOfGt: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_TRIBUT_CONFIGURA_OF_GT']),
      cstIpi: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CST_IPI']),
      modalidadeBaseCalculo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODALIDADE_BASE_CALCULO']),
      porcentoBaseCalculo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PORCENTO_BASE_CALCULO']),
      aliquotaPorcento: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_PORCENTO']),
      aliquotaUnidade: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_UNIDADE']),
      valorPrecoMaximo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PRECO_MAXIMO']),
      valorPautaFiscal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PAUTA_FISCAL']),
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
    if (!nullToAbsent || cstIpi != null) {
      map['CST_IPI'] = Variable<String?>(cstIpi);
    }
    if (!nullToAbsent || modalidadeBaseCalculo != null) {
      map['MODALIDADE_BASE_CALCULO'] = Variable<String?>(modalidadeBaseCalculo);
    }
    if (!nullToAbsent || porcentoBaseCalculo != null) {
      map['PORCENTO_BASE_CALCULO'] = Variable<double?>(porcentoBaseCalculo);
    }
    if (!nullToAbsent || aliquotaPorcento != null) {
      map['ALIQUOTA_PORCENTO'] = Variable<double?>(aliquotaPorcento);
    }
    if (!nullToAbsent || aliquotaUnidade != null) {
      map['ALIQUOTA_UNIDADE'] = Variable<double?>(aliquotaUnidade);
    }
    if (!nullToAbsent || valorPrecoMaximo != null) {
      map['VALOR_PRECO_MAXIMO'] = Variable<double?>(valorPrecoMaximo);
    }
    if (!nullToAbsent || valorPautaFiscal != null) {
      map['VALOR_PAUTA_FISCAL'] = Variable<double?>(valorPautaFiscal);
    }
    return map;
  }

  TributIpisCompanion toCompanion(bool nullToAbsent) {
    return TributIpisCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idTributConfiguraOfGt: idTributConfiguraOfGt == null && nullToAbsent
        ? const Value.absent()
        : Value(idTributConfiguraOfGt),
      cstIpi: cstIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(cstIpi),
      modalidadeBaseCalculo: modalidadeBaseCalculo == null && nullToAbsent
        ? const Value.absent()
        : Value(modalidadeBaseCalculo),
      porcentoBaseCalculo: porcentoBaseCalculo == null && nullToAbsent
        ? const Value.absent()
        : Value(porcentoBaseCalculo),
      aliquotaPorcento: aliquotaPorcento == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaPorcento),
      aliquotaUnidade: aliquotaUnidade == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaUnidade),
      valorPrecoMaximo: valorPrecoMaximo == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPrecoMaximo),
      valorPautaFiscal: valorPautaFiscal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPautaFiscal),
    );
  }

  factory TributIpi.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TributIpi(
      id: serializer.fromJson<int>(json['id']),
      idTributConfiguraOfGt: serializer.fromJson<int>(json['idTributConfiguraOfGt']),
      cstIpi: serializer.fromJson<String>(json['cstIpi']),
      modalidadeBaseCalculo: serializer.fromJson<String>(json['modalidadeBaseCalculo']),
      porcentoBaseCalculo: serializer.fromJson<double>(json['porcentoBaseCalculo']),
      aliquotaPorcento: serializer.fromJson<double>(json['aliquotaPorcento']),
      aliquotaUnidade: serializer.fromJson<double>(json['aliquotaUnidade']),
      valorPrecoMaximo: serializer.fromJson<double>(json['valorPrecoMaximo']),
      valorPautaFiscal: serializer.fromJson<double>(json['valorPautaFiscal']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idTributConfiguraOfGt': serializer.toJson<int?>(idTributConfiguraOfGt),
      'cstIpi': serializer.toJson<String?>(cstIpi),
      'modalidadeBaseCalculo': serializer.toJson<String?>(modalidadeBaseCalculo),
      'porcentoBaseCalculo': serializer.toJson<double?>(porcentoBaseCalculo),
      'aliquotaPorcento': serializer.toJson<double?>(aliquotaPorcento),
      'aliquotaUnidade': serializer.toJson<double?>(aliquotaUnidade),
      'valorPrecoMaximo': serializer.toJson<double?>(valorPrecoMaximo),
      'valorPautaFiscal': serializer.toJson<double?>(valorPautaFiscal),
    };
  }

  TributIpi copyWith(
        {
		  int? id,
          int? idTributConfiguraOfGt,
          String? cstIpi,
          String? modalidadeBaseCalculo,
          double? porcentoBaseCalculo,
          double? aliquotaPorcento,
          double? aliquotaUnidade,
          double? valorPrecoMaximo,
          double? valorPautaFiscal,
		}) =>
      TributIpi(
        id: id ?? this.id,
        idTributConfiguraOfGt: idTributConfiguraOfGt ?? this.idTributConfiguraOfGt,
        cstIpi: cstIpi ?? this.cstIpi,
        modalidadeBaseCalculo: modalidadeBaseCalculo ?? this.modalidadeBaseCalculo,
        porcentoBaseCalculo: porcentoBaseCalculo ?? this.porcentoBaseCalculo,
        aliquotaPorcento: aliquotaPorcento ?? this.aliquotaPorcento,
        aliquotaUnidade: aliquotaUnidade ?? this.aliquotaUnidade,
        valorPrecoMaximo: valorPrecoMaximo ?? this.valorPrecoMaximo,
        valorPautaFiscal: valorPautaFiscal ?? this.valorPautaFiscal,
      );
  
  @override
  String toString() {
    return (StringBuffer('TributIpi(')
          ..write('id: $id, ')
          ..write('idTributConfiguraOfGt: $idTributConfiguraOfGt, ')
          ..write('cstIpi: $cstIpi, ')
          ..write('modalidadeBaseCalculo: $modalidadeBaseCalculo, ')
          ..write('porcentoBaseCalculo: $porcentoBaseCalculo, ')
          ..write('aliquotaPorcento: $aliquotaPorcento, ')
          ..write('aliquotaUnidade: $aliquotaUnidade, ')
          ..write('valorPrecoMaximo: $valorPrecoMaximo, ')
          ..write('valorPautaFiscal: $valorPautaFiscal, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idTributConfiguraOfGt,
      cstIpi,
      modalidadeBaseCalculo,
      porcentoBaseCalculo,
      aliquotaPorcento,
      aliquotaUnidade,
      valorPrecoMaximo,
      valorPautaFiscal,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TributIpi &&
          other.id == id &&
          other.idTributConfiguraOfGt == idTributConfiguraOfGt &&
          other.cstIpi == cstIpi &&
          other.modalidadeBaseCalculo == modalidadeBaseCalculo &&
          other.porcentoBaseCalculo == porcentoBaseCalculo &&
          other.aliquotaPorcento == aliquotaPorcento &&
          other.aliquotaUnidade == aliquotaUnidade &&
          other.valorPrecoMaximo == valorPrecoMaximo &&
          other.valorPautaFiscal == valorPautaFiscal 
	   );
}

class TributIpisCompanion extends UpdateCompanion<TributIpi> {

  final Value<int?> id;
  final Value<int?> idTributConfiguraOfGt;
  final Value<String?> cstIpi;
  final Value<String?> modalidadeBaseCalculo;
  final Value<double?> porcentoBaseCalculo;
  final Value<double?> aliquotaPorcento;
  final Value<double?> aliquotaUnidade;
  final Value<double?> valorPrecoMaximo;
  final Value<double?> valorPautaFiscal;

  const TributIpisCompanion({
    this.id = const Value.absent(),
    this.idTributConfiguraOfGt = const Value.absent(),
    this.cstIpi = const Value.absent(),
    this.modalidadeBaseCalculo = const Value.absent(),
    this.porcentoBaseCalculo = const Value.absent(),
    this.aliquotaPorcento = const Value.absent(),
    this.aliquotaUnidade = const Value.absent(),
    this.valorPrecoMaximo = const Value.absent(),
    this.valorPautaFiscal = const Value.absent(),
  });

  TributIpisCompanion.insert({
    this.id = const Value.absent(),
    this.idTributConfiguraOfGt = const Value.absent(),
    this.cstIpi = const Value.absent(),
    this.modalidadeBaseCalculo = const Value.absent(),
    this.porcentoBaseCalculo = const Value.absent(),
    this.aliquotaPorcento = const Value.absent(),
    this.aliquotaUnidade = const Value.absent(),
    this.valorPrecoMaximo = const Value.absent(),
    this.valorPautaFiscal = const Value.absent(),
  });

  static Insertable<TributIpi> custom({
    Expression<int>? id,
    Expression<int>? idTributConfiguraOfGt,
    Expression<String>? cstIpi,
    Expression<String>? modalidadeBaseCalculo,
    Expression<double>? porcentoBaseCalculo,
    Expression<double>? aliquotaPorcento,
    Expression<double>? aliquotaUnidade,
    Expression<double>? valorPrecoMaximo,
    Expression<double>? valorPautaFiscal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idTributConfiguraOfGt != null) 'ID_TRIBUT_CONFIGURA_OF_GT': idTributConfiguraOfGt,
      if (cstIpi != null) 'CST_IPI': cstIpi,
      if (modalidadeBaseCalculo != null) 'MODALIDADE_BASE_CALCULO': modalidadeBaseCalculo,
      if (porcentoBaseCalculo != null) 'PORCENTO_BASE_CALCULO': porcentoBaseCalculo,
      if (aliquotaPorcento != null) 'ALIQUOTA_PORCENTO': aliquotaPorcento,
      if (aliquotaUnidade != null) 'ALIQUOTA_UNIDADE': aliquotaUnidade,
      if (valorPrecoMaximo != null) 'VALOR_PRECO_MAXIMO': valorPrecoMaximo,
      if (valorPautaFiscal != null) 'VALOR_PAUTA_FISCAL': valorPautaFiscal,
    });
  }

  TributIpisCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idTributConfiguraOfGt,
      Value<String>? cstIpi,
      Value<String>? modalidadeBaseCalculo,
      Value<double>? porcentoBaseCalculo,
      Value<double>? aliquotaPorcento,
      Value<double>? aliquotaUnidade,
      Value<double>? valorPrecoMaximo,
      Value<double>? valorPautaFiscal,
	  }) {
    return TributIpisCompanion(
      id: id ?? this.id,
      idTributConfiguraOfGt: idTributConfiguraOfGt ?? this.idTributConfiguraOfGt,
      cstIpi: cstIpi ?? this.cstIpi,
      modalidadeBaseCalculo: modalidadeBaseCalculo ?? this.modalidadeBaseCalculo,
      porcentoBaseCalculo: porcentoBaseCalculo ?? this.porcentoBaseCalculo,
      aliquotaPorcento: aliquotaPorcento ?? this.aliquotaPorcento,
      aliquotaUnidade: aliquotaUnidade ?? this.aliquotaUnidade,
      valorPrecoMaximo: valorPrecoMaximo ?? this.valorPrecoMaximo,
      valorPautaFiscal: valorPautaFiscal ?? this.valorPautaFiscal,
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
    if (cstIpi.present) {
      map['CST_IPI'] = Variable<String?>(cstIpi.value);
    }
    if (modalidadeBaseCalculo.present) {
      map['MODALIDADE_BASE_CALCULO'] = Variable<String?>(modalidadeBaseCalculo.value);
    }
    if (porcentoBaseCalculo.present) {
      map['PORCENTO_BASE_CALCULO'] = Variable<double?>(porcentoBaseCalculo.value);
    }
    if (aliquotaPorcento.present) {
      map['ALIQUOTA_PORCENTO'] = Variable<double?>(aliquotaPorcento.value);
    }
    if (aliquotaUnidade.present) {
      map['ALIQUOTA_UNIDADE'] = Variable<double?>(aliquotaUnidade.value);
    }
    if (valorPrecoMaximo.present) {
      map['VALOR_PRECO_MAXIMO'] = Variable<double?>(valorPrecoMaximo.value);
    }
    if (valorPautaFiscal.present) {
      map['VALOR_PAUTA_FISCAL'] = Variable<double?>(valorPautaFiscal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TributIpisCompanion(')
          ..write('id: $id, ')
          ..write('idTributConfiguraOfGt: $idTributConfiguraOfGt, ')
          ..write('cstIpi: $cstIpi, ')
          ..write('modalidadeBaseCalculo: $modalidadeBaseCalculo, ')
          ..write('porcentoBaseCalculo: $porcentoBaseCalculo, ')
          ..write('aliquotaPorcento: $aliquotaPorcento, ')
          ..write('aliquotaUnidade: $aliquotaUnidade, ')
          ..write('valorPrecoMaximo: $valorPrecoMaximo, ')
          ..write('valorPautaFiscal: $valorPautaFiscal, ')
          ..write(')'))
        .toString();
  }
}

class $TributIpisTable extends TributIpis
    with TableInfo<$TributIpisTable, TributIpi> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TributIpisTable(this._db, [this._alias]);
  
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
  final VerificationMeta _cstIpiMeta =
      const VerificationMeta('cstIpi');
  GeneratedColumn<String>? _cstIpi;
  @override
  GeneratedColumn<String> get cstIpi => _cstIpi ??=
      GeneratedColumn<String>('CST_IPI', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _modalidadeBaseCalculoMeta =
      const VerificationMeta('modalidadeBaseCalculo');
  GeneratedColumn<String>? _modalidadeBaseCalculo;
  @override
  GeneratedColumn<String> get modalidadeBaseCalculo => _modalidadeBaseCalculo ??=
      GeneratedColumn<String>('MODALIDADE_BASE_CALCULO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _porcentoBaseCalculoMeta =
      const VerificationMeta('porcentoBaseCalculo');
  GeneratedColumn<double>? _porcentoBaseCalculo;
  @override
  GeneratedColumn<double> get porcentoBaseCalculo => _porcentoBaseCalculo ??=
      GeneratedColumn<double>('PORCENTO_BASE_CALCULO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaPorcentoMeta =
      const VerificationMeta('aliquotaPorcento');
  GeneratedColumn<double>? _aliquotaPorcento;
  @override
  GeneratedColumn<double> get aliquotaPorcento => _aliquotaPorcento ??=
      GeneratedColumn<double>('ALIQUOTA_PORCENTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaUnidadeMeta =
      const VerificationMeta('aliquotaUnidade');
  GeneratedColumn<double>? _aliquotaUnidade;
  @override
  GeneratedColumn<double> get aliquotaUnidade => _aliquotaUnidade ??=
      GeneratedColumn<double>('ALIQUOTA_UNIDADE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPrecoMaximoMeta =
      const VerificationMeta('valorPrecoMaximo');
  GeneratedColumn<double>? _valorPrecoMaximo;
  @override
  GeneratedColumn<double> get valorPrecoMaximo => _valorPrecoMaximo ??=
      GeneratedColumn<double>('VALOR_PRECO_MAXIMO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPautaFiscalMeta =
      const VerificationMeta('valorPautaFiscal');
  GeneratedColumn<double>? _valorPautaFiscal;
  @override
  GeneratedColumn<double> get valorPautaFiscal => _valorPautaFiscal ??=
      GeneratedColumn<double>('VALOR_PAUTA_FISCAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idTributConfiguraOfGt,
        cstIpi,
        modalidadeBaseCalculo,
        porcentoBaseCalculo,
        aliquotaPorcento,
        aliquotaUnidade,
        valorPrecoMaximo,
        valorPautaFiscal,
      ];

  @override
  String get aliasedName => _alias ?? 'TRIBUT_IPI';
  
  @override
  String get actualTableName => 'TRIBUT_IPI';
  
  @override
  VerificationContext validateIntegrity(Insertable<TributIpi> instance,
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
    if (data.containsKey('CST_IPI')) {
        context.handle(_cstIpiMeta,
            cstIpi.isAcceptableOrUnknown(data['CST_IPI']!, _cstIpiMeta));
    }
    if (data.containsKey('MODALIDADE_BASE_CALCULO')) {
        context.handle(_modalidadeBaseCalculoMeta,
            modalidadeBaseCalculo.isAcceptableOrUnknown(data['MODALIDADE_BASE_CALCULO']!, _modalidadeBaseCalculoMeta));
    }
    if (data.containsKey('PORCENTO_BASE_CALCULO')) {
        context.handle(_porcentoBaseCalculoMeta,
            porcentoBaseCalculo.isAcceptableOrUnknown(data['PORCENTO_BASE_CALCULO']!, _porcentoBaseCalculoMeta));
    }
    if (data.containsKey('ALIQUOTA_PORCENTO')) {
        context.handle(_aliquotaPorcentoMeta,
            aliquotaPorcento.isAcceptableOrUnknown(data['ALIQUOTA_PORCENTO']!, _aliquotaPorcentoMeta));
    }
    if (data.containsKey('ALIQUOTA_UNIDADE')) {
        context.handle(_aliquotaUnidadeMeta,
            aliquotaUnidade.isAcceptableOrUnknown(data['ALIQUOTA_UNIDADE']!, _aliquotaUnidadeMeta));
    }
    if (data.containsKey('VALOR_PRECO_MAXIMO')) {
        context.handle(_valorPrecoMaximoMeta,
            valorPrecoMaximo.isAcceptableOrUnknown(data['VALOR_PRECO_MAXIMO']!, _valorPrecoMaximoMeta));
    }
    if (data.containsKey('VALOR_PAUTA_FISCAL')) {
        context.handle(_valorPautaFiscalMeta,
            valorPautaFiscal.isAcceptableOrUnknown(data['VALOR_PAUTA_FISCAL']!, _valorPautaFiscalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TributIpi map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TributIpi.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TributIpisTable createAlias(String alias) {
    return $TributIpisTable(_db, alias);
  }
}