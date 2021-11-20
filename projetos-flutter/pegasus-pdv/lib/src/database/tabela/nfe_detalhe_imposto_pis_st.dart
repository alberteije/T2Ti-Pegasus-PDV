/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE_IMPOSTO_PIS_ST] 
                                                                                
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

@DataClassName("NfeDetalheImpostoPisSt")
@UseRowClass(NfeDetalheImpostoPisSt)
class NfeDetalheImpostoPisSts extends Table {
  @override
  String get tableName => 'NFE_DETALHE_IMPOSTO_PIS_ST';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  RealColumn get valorBaseCalculoPisSt => real().named('VALOR_BASE_CALCULO_PIS_ST').nullable()();
  RealColumn get aliquotaPisStPercentual => real().named('ALIQUOTA_PIS_ST_PERCENTUAL').nullable()();
  RealColumn get quantidadeVendidaPisSt => real().named('QUANTIDADE_VENDIDA_PIS_ST').nullable()();
  RealColumn get aliquotaPisStReais => real().named('ALIQUOTA_PIS_ST_REAIS').nullable()();
  RealColumn get valorPisSt => real().named('VALOR_PIS_ST').nullable()();
}

class NfeDetalheImpostoPisSt extends DataClass implements Insertable<NfeDetalheImpostoPisSt> {
  final int? id;
  final int? idNfeDetalhe;
  final double? valorBaseCalculoPisSt;
  final double? aliquotaPisStPercentual;
  final double? quantidadeVendidaPisSt;
  final double? aliquotaPisStReais;
  final double? valorPisSt;

  NfeDetalheImpostoPisSt(
    {
      required this.id,
      this.idNfeDetalhe,
      this.valorBaseCalculoPisSt,
      this.aliquotaPisStPercentual,
      this.quantidadeVendidaPisSt,
      this.aliquotaPisStReais,
      this.valorPisSt,
    }
  );

  factory NfeDetalheImpostoPisSt.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetalheImpostoPisSt(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      valorBaseCalculoPisSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BASE_CALCULO_PIS_ST']),
      aliquotaPisStPercentual: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_PIS_ST_PERCENTUAL']),
      quantidadeVendidaPisSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_VENDIDA_PIS_ST']),
      aliquotaPisStReais: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_PIS_ST_REAIS']),
      valorPisSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PIS_ST']),
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
    if (!nullToAbsent || valorBaseCalculoPisSt != null) {
      map['VALOR_BASE_CALCULO_PIS_ST'] = Variable<double?>(valorBaseCalculoPisSt);
    }
    if (!nullToAbsent || aliquotaPisStPercentual != null) {
      map['ALIQUOTA_PIS_ST_PERCENTUAL'] = Variable<double?>(aliquotaPisStPercentual);
    }
    if (!nullToAbsent || quantidadeVendidaPisSt != null) {
      map['QUANTIDADE_VENDIDA_PIS_ST'] = Variable<double?>(quantidadeVendidaPisSt);
    }
    if (!nullToAbsent || aliquotaPisStReais != null) {
      map['ALIQUOTA_PIS_ST_REAIS'] = Variable<double?>(aliquotaPisStReais);
    }
    if (!nullToAbsent || valorPisSt != null) {
      map['VALOR_PIS_ST'] = Variable<double?>(valorPisSt);
    }
    return map;
  }

  NfeDetalheImpostoPisStsCompanion toCompanion(bool nullToAbsent) {
    return NfeDetalheImpostoPisStsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      valorBaseCalculoPisSt: valorBaseCalculoPisSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBaseCalculoPisSt),
      aliquotaPisStPercentual: aliquotaPisStPercentual == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaPisStPercentual),
      quantidadeVendidaPisSt: quantidadeVendidaPisSt == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeVendidaPisSt),
      aliquotaPisStReais: aliquotaPisStReais == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaPisStReais),
      valorPisSt: valorPisSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPisSt),
    );
  }

  factory NfeDetalheImpostoPisSt.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetalheImpostoPisSt(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      valorBaseCalculoPisSt: serializer.fromJson<double>(json['valorBaseCalculoPisSt']),
      aliquotaPisStPercentual: serializer.fromJson<double>(json['aliquotaPisStPercentual']),
      quantidadeVendidaPisSt: serializer.fromJson<double>(json['quantidadeVendidaPisSt']),
      aliquotaPisStReais: serializer.fromJson<double>(json['aliquotaPisStReais']),
      valorPisSt: serializer.fromJson<double>(json['valorPisSt']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'valorBaseCalculoPisSt': serializer.toJson<double?>(valorBaseCalculoPisSt),
      'aliquotaPisStPercentual': serializer.toJson<double?>(aliquotaPisStPercentual),
      'quantidadeVendidaPisSt': serializer.toJson<double?>(quantidadeVendidaPisSt),
      'aliquotaPisStReais': serializer.toJson<double?>(aliquotaPisStReais),
      'valorPisSt': serializer.toJson<double?>(valorPisSt),
    };
  }

  NfeDetalheImpostoPisSt copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          double? valorBaseCalculoPisSt,
          double? aliquotaPisStPercentual,
          double? quantidadeVendidaPisSt,
          double? aliquotaPisStReais,
          double? valorPisSt,
		}) =>
      NfeDetalheImpostoPisSt(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        valorBaseCalculoPisSt: valorBaseCalculoPisSt ?? this.valorBaseCalculoPisSt,
        aliquotaPisStPercentual: aliquotaPisStPercentual ?? this.aliquotaPisStPercentual,
        quantidadeVendidaPisSt: quantidadeVendidaPisSt ?? this.quantidadeVendidaPisSt,
        aliquotaPisStReais: aliquotaPisStReais ?? this.aliquotaPisStReais,
        valorPisSt: valorPisSt ?? this.valorPisSt,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoPisSt(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('valorBaseCalculoPisSt: $valorBaseCalculoPisSt, ')
          ..write('aliquotaPisStPercentual: $aliquotaPisStPercentual, ')
          ..write('quantidadeVendidaPisSt: $quantidadeVendidaPisSt, ')
          ..write('aliquotaPisStReais: $aliquotaPisStReais, ')
          ..write('valorPisSt: $valorPisSt, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      valorBaseCalculoPisSt,
      aliquotaPisStPercentual,
      quantidadeVendidaPisSt,
      aliquotaPisStReais,
      valorPisSt,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetalheImpostoPisSt &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.valorBaseCalculoPisSt == valorBaseCalculoPisSt &&
          other.aliquotaPisStPercentual == aliquotaPisStPercentual &&
          other.quantidadeVendidaPisSt == quantidadeVendidaPisSt &&
          other.aliquotaPisStReais == aliquotaPisStReais &&
          other.valorPisSt == valorPisSt 
	   );
}

class NfeDetalheImpostoPisStsCompanion extends UpdateCompanion<NfeDetalheImpostoPisSt> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<double?> valorBaseCalculoPisSt;
  final Value<double?> aliquotaPisStPercentual;
  final Value<double?> quantidadeVendidaPisSt;
  final Value<double?> aliquotaPisStReais;
  final Value<double?> valorPisSt;

  const NfeDetalheImpostoPisStsCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.valorBaseCalculoPisSt = const Value.absent(),
    this.aliquotaPisStPercentual = const Value.absent(),
    this.quantidadeVendidaPisSt = const Value.absent(),
    this.aliquotaPisStReais = const Value.absent(),
    this.valorPisSt = const Value.absent(),
  });

  NfeDetalheImpostoPisStsCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.valorBaseCalculoPisSt = const Value.absent(),
    this.aliquotaPisStPercentual = const Value.absent(),
    this.quantidadeVendidaPisSt = const Value.absent(),
    this.aliquotaPisStReais = const Value.absent(),
    this.valorPisSt = const Value.absent(),
  });

  static Insertable<NfeDetalheImpostoPisSt> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<double>? valorBaseCalculoPisSt,
    Expression<double>? aliquotaPisStPercentual,
    Expression<double>? quantidadeVendidaPisSt,
    Expression<double>? aliquotaPisStReais,
    Expression<double>? valorPisSt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (valorBaseCalculoPisSt != null) 'VALOR_BASE_CALCULO_PIS_ST': valorBaseCalculoPisSt,
      if (aliquotaPisStPercentual != null) 'ALIQUOTA_PIS_ST_PERCENTUAL': aliquotaPisStPercentual,
      if (quantidadeVendidaPisSt != null) 'QUANTIDADE_VENDIDA_PIS_ST': quantidadeVendidaPisSt,
      if (aliquotaPisStReais != null) 'ALIQUOTA_PIS_ST_REAIS': aliquotaPisStReais,
      if (valorPisSt != null) 'VALOR_PIS_ST': valorPisSt,
    });
  }

  NfeDetalheImpostoPisStsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<double>? valorBaseCalculoPisSt,
      Value<double>? aliquotaPisStPercentual,
      Value<double>? quantidadeVendidaPisSt,
      Value<double>? aliquotaPisStReais,
      Value<double>? valorPisSt,
	  }) {
    return NfeDetalheImpostoPisStsCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      valorBaseCalculoPisSt: valorBaseCalculoPisSt ?? this.valorBaseCalculoPisSt,
      aliquotaPisStPercentual: aliquotaPisStPercentual ?? this.aliquotaPisStPercentual,
      quantidadeVendidaPisSt: quantidadeVendidaPisSt ?? this.quantidadeVendidaPisSt,
      aliquotaPisStReais: aliquotaPisStReais ?? this.aliquotaPisStReais,
      valorPisSt: valorPisSt ?? this.valorPisSt,
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
    if (valorBaseCalculoPisSt.present) {
      map['VALOR_BASE_CALCULO_PIS_ST'] = Variable<double?>(valorBaseCalculoPisSt.value);
    }
    if (aliquotaPisStPercentual.present) {
      map['ALIQUOTA_PIS_ST_PERCENTUAL'] = Variable<double?>(aliquotaPisStPercentual.value);
    }
    if (quantidadeVendidaPisSt.present) {
      map['QUANTIDADE_VENDIDA_PIS_ST'] = Variable<double?>(quantidadeVendidaPisSt.value);
    }
    if (aliquotaPisStReais.present) {
      map['ALIQUOTA_PIS_ST_REAIS'] = Variable<double?>(aliquotaPisStReais.value);
    }
    if (valorPisSt.present) {
      map['VALOR_PIS_ST'] = Variable<double?>(valorPisSt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoPisStsCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('valorBaseCalculoPisSt: $valorBaseCalculoPisSt, ')
          ..write('aliquotaPisStPercentual: $aliquotaPisStPercentual, ')
          ..write('quantidadeVendidaPisSt: $quantidadeVendidaPisSt, ')
          ..write('aliquotaPisStReais: $aliquotaPisStReais, ')
          ..write('valorPisSt: $valorPisSt, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetalheImpostoPisStsTable extends NfeDetalheImpostoPisSts
    with TableInfo<$NfeDetalheImpostoPisStsTable, NfeDetalheImpostoPisSt> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetalheImpostoPisStsTable(this._db, [this._alias]);
  
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
  final VerificationMeta _valorBaseCalculoPisStMeta =
      const VerificationMeta('valorBaseCalculoPisSt');
  GeneratedColumn<double>? _valorBaseCalculoPisSt;
  @override
  GeneratedColumn<double> get valorBaseCalculoPisSt => _valorBaseCalculoPisSt ??=
      GeneratedColumn<double>('VALOR_BASE_CALCULO_PIS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaPisStPercentualMeta =
      const VerificationMeta('aliquotaPisStPercentual');
  GeneratedColumn<double>? _aliquotaPisStPercentual;
  @override
  GeneratedColumn<double> get aliquotaPisStPercentual => _aliquotaPisStPercentual ??=
      GeneratedColumn<double>('ALIQUOTA_PIS_ST_PERCENTUAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _quantidadeVendidaPisStMeta =
      const VerificationMeta('quantidadeVendidaPisSt');
  GeneratedColumn<double>? _quantidadeVendidaPisSt;
  @override
  GeneratedColumn<double> get quantidadeVendidaPisSt => _quantidadeVendidaPisSt ??=
      GeneratedColumn<double>('QUANTIDADE_VENDIDA_PIS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaPisStReaisMeta =
      const VerificationMeta('aliquotaPisStReais');
  GeneratedColumn<double>? _aliquotaPisStReais;
  @override
  GeneratedColumn<double> get aliquotaPisStReais => _aliquotaPisStReais ??=
      GeneratedColumn<double>('ALIQUOTA_PIS_ST_REAIS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPisStMeta =
      const VerificationMeta('valorPisSt');
  GeneratedColumn<double>? _valorPisSt;
  @override
  GeneratedColumn<double> get valorPisSt => _valorPisSt ??=
      GeneratedColumn<double>('VALOR_PIS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        valorBaseCalculoPisSt,
        aliquotaPisStPercentual,
        quantidadeVendidaPisSt,
        aliquotaPisStReais,
        valorPisSt,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DETALHE_IMPOSTO_PIS_ST';
  
  @override
  String get actualTableName => 'NFE_DETALHE_IMPOSTO_PIS_ST';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetalheImpostoPisSt> instance,
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
    if (data.containsKey('VALOR_BASE_CALCULO_PIS_ST')) {
        context.handle(_valorBaseCalculoPisStMeta,
            valorBaseCalculoPisSt.isAcceptableOrUnknown(data['VALOR_BASE_CALCULO_PIS_ST']!, _valorBaseCalculoPisStMeta));
    }
    if (data.containsKey('ALIQUOTA_PIS_ST_PERCENTUAL')) {
        context.handle(_aliquotaPisStPercentualMeta,
            aliquotaPisStPercentual.isAcceptableOrUnknown(data['ALIQUOTA_PIS_ST_PERCENTUAL']!, _aliquotaPisStPercentualMeta));
    }
    if (data.containsKey('QUANTIDADE_VENDIDA_PIS_ST')) {
        context.handle(_quantidadeVendidaPisStMeta,
            quantidadeVendidaPisSt.isAcceptableOrUnknown(data['QUANTIDADE_VENDIDA_PIS_ST']!, _quantidadeVendidaPisStMeta));
    }
    if (data.containsKey('ALIQUOTA_PIS_ST_REAIS')) {
        context.handle(_aliquotaPisStReaisMeta,
            aliquotaPisStReais.isAcceptableOrUnknown(data['ALIQUOTA_PIS_ST_REAIS']!, _aliquotaPisStReaisMeta));
    }
    if (data.containsKey('VALOR_PIS_ST')) {
        context.handle(_valorPisStMeta,
            valorPisSt.isAcceptableOrUnknown(data['VALOR_PIS_ST']!, _valorPisStMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDetalheImpostoPisSt map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetalheImpostoPisSt.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetalheImpostoPisStsTable createAlias(String alias) {
    return $NfeDetalheImpostoPisStsTable(_db, alias);
  }
}