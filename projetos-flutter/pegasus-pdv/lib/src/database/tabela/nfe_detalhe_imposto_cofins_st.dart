/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE_IMPOSTO_COFINS_ST] 
                                                                                
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

@DataClassName("NfeDetalheImpostoCofinsSt")
@UseRowClass(NfeDetalheImpostoCofinsSt)
class NfeDetalheImpostoCofinsSts extends Table {
  @override
  String get tableName => 'NFE_DETALHE_IMPOSTO_COFINS_ST';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  RealColumn get baseCalculoCofinsSt => real().named('BASE_CALCULO_COFINS_ST').nullable()();
  RealColumn get aliquotaCofinsStPercentual => real().named('ALIQUOTA_COFINS_ST_PERCENTUAL').nullable()();
  RealColumn get quantidadeVendidaCofinsSt => real().named('QUANTIDADE_VENDIDA_COFINS_ST').nullable()();
  RealColumn get aliquotaCofinsStReais => real().named('ALIQUOTA_COFINS_ST_REAIS').nullable()();
  RealColumn get valorCofinsSt => real().named('VALOR_COFINS_ST').nullable()();
}

class NfeDetalheImpostoCofinsSt extends DataClass implements Insertable<NfeDetalheImpostoCofinsSt> {
  final int? id;
  final int? idNfeDetalhe;
  final double? baseCalculoCofinsSt;
  final double? aliquotaCofinsStPercentual;
  final double? quantidadeVendidaCofinsSt;
  final double? aliquotaCofinsStReais;
  final double? valorCofinsSt;

  NfeDetalheImpostoCofinsSt(
    {
      required this.id,
      this.idNfeDetalhe,
      this.baseCalculoCofinsSt,
      this.aliquotaCofinsStPercentual,
      this.quantidadeVendidaCofinsSt,
      this.aliquotaCofinsStReais,
      this.valorCofinsSt,
    }
  );

  factory NfeDetalheImpostoCofinsSt.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetalheImpostoCofinsSt(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      baseCalculoCofinsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_COFINS_ST']),
      aliquotaCofinsStPercentual: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_COFINS_ST_PERCENTUAL']),
      quantidadeVendidaCofinsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_VENDIDA_COFINS_ST']),
      aliquotaCofinsStReais: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_COFINS_ST_REAIS']),
      valorCofinsSt: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_COFINS_ST']),
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
    if (!nullToAbsent || baseCalculoCofinsSt != null) {
      map['BASE_CALCULO_COFINS_ST'] = Variable<double?>(baseCalculoCofinsSt);
    }
    if (!nullToAbsent || aliquotaCofinsStPercentual != null) {
      map['ALIQUOTA_COFINS_ST_PERCENTUAL'] = Variable<double?>(aliquotaCofinsStPercentual);
    }
    if (!nullToAbsent || quantidadeVendidaCofinsSt != null) {
      map['QUANTIDADE_VENDIDA_COFINS_ST'] = Variable<double?>(quantidadeVendidaCofinsSt);
    }
    if (!nullToAbsent || aliquotaCofinsStReais != null) {
      map['ALIQUOTA_COFINS_ST_REAIS'] = Variable<double?>(aliquotaCofinsStReais);
    }
    if (!nullToAbsent || valorCofinsSt != null) {
      map['VALOR_COFINS_ST'] = Variable<double?>(valorCofinsSt);
    }
    return map;
  }

  NfeDetalheImpostoCofinsStsCompanion toCompanion(bool nullToAbsent) {
    return NfeDetalheImpostoCofinsStsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      baseCalculoCofinsSt: baseCalculoCofinsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoCofinsSt),
      aliquotaCofinsStPercentual: aliquotaCofinsStPercentual == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaCofinsStPercentual),
      quantidadeVendidaCofinsSt: quantidadeVendidaCofinsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeVendidaCofinsSt),
      aliquotaCofinsStReais: aliquotaCofinsStReais == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaCofinsStReais),
      valorCofinsSt: valorCofinsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(valorCofinsSt),
    );
  }

  factory NfeDetalheImpostoCofinsSt.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetalheImpostoCofinsSt(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      baseCalculoCofinsSt: serializer.fromJson<double>(json['baseCalculoCofinsSt']),
      aliquotaCofinsStPercentual: serializer.fromJson<double>(json['aliquotaCofinsStPercentual']),
      quantidadeVendidaCofinsSt: serializer.fromJson<double>(json['quantidadeVendidaCofinsSt']),
      aliquotaCofinsStReais: serializer.fromJson<double>(json['aliquotaCofinsStReais']),
      valorCofinsSt: serializer.fromJson<double>(json['valorCofinsSt']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'baseCalculoCofinsSt': serializer.toJson<double?>(baseCalculoCofinsSt),
      'aliquotaCofinsStPercentual': serializer.toJson<double?>(aliquotaCofinsStPercentual),
      'quantidadeVendidaCofinsSt': serializer.toJson<double?>(quantidadeVendidaCofinsSt),
      'aliquotaCofinsStReais': serializer.toJson<double?>(aliquotaCofinsStReais),
      'valorCofinsSt': serializer.toJson<double?>(valorCofinsSt),
    };
  }

  NfeDetalheImpostoCofinsSt copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          double? baseCalculoCofinsSt,
          double? aliquotaCofinsStPercentual,
          double? quantidadeVendidaCofinsSt,
          double? aliquotaCofinsStReais,
          double? valorCofinsSt,
		}) =>
      NfeDetalheImpostoCofinsSt(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        baseCalculoCofinsSt: baseCalculoCofinsSt ?? this.baseCalculoCofinsSt,
        aliquotaCofinsStPercentual: aliquotaCofinsStPercentual ?? this.aliquotaCofinsStPercentual,
        quantidadeVendidaCofinsSt: quantidadeVendidaCofinsSt ?? this.quantidadeVendidaCofinsSt,
        aliquotaCofinsStReais: aliquotaCofinsStReais ?? this.aliquotaCofinsStReais,
        valorCofinsSt: valorCofinsSt ?? this.valorCofinsSt,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoCofinsSt(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('baseCalculoCofinsSt: $baseCalculoCofinsSt, ')
          ..write('aliquotaCofinsStPercentual: $aliquotaCofinsStPercentual, ')
          ..write('quantidadeVendidaCofinsSt: $quantidadeVendidaCofinsSt, ')
          ..write('aliquotaCofinsStReais: $aliquotaCofinsStReais, ')
          ..write('valorCofinsSt: $valorCofinsSt, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      baseCalculoCofinsSt,
      aliquotaCofinsStPercentual,
      quantidadeVendidaCofinsSt,
      aliquotaCofinsStReais,
      valorCofinsSt,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetalheImpostoCofinsSt &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.baseCalculoCofinsSt == baseCalculoCofinsSt &&
          other.aliquotaCofinsStPercentual == aliquotaCofinsStPercentual &&
          other.quantidadeVendidaCofinsSt == quantidadeVendidaCofinsSt &&
          other.aliquotaCofinsStReais == aliquotaCofinsStReais &&
          other.valorCofinsSt == valorCofinsSt 
	   );
}

class NfeDetalheImpostoCofinsStsCompanion extends UpdateCompanion<NfeDetalheImpostoCofinsSt> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<double?> baseCalculoCofinsSt;
  final Value<double?> aliquotaCofinsStPercentual;
  final Value<double?> quantidadeVendidaCofinsSt;
  final Value<double?> aliquotaCofinsStReais;
  final Value<double?> valorCofinsSt;

  const NfeDetalheImpostoCofinsStsCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.baseCalculoCofinsSt = const Value.absent(),
    this.aliquotaCofinsStPercentual = const Value.absent(),
    this.quantidadeVendidaCofinsSt = const Value.absent(),
    this.aliquotaCofinsStReais = const Value.absent(),
    this.valorCofinsSt = const Value.absent(),
  });

  NfeDetalheImpostoCofinsStsCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.baseCalculoCofinsSt = const Value.absent(),
    this.aliquotaCofinsStPercentual = const Value.absent(),
    this.quantidadeVendidaCofinsSt = const Value.absent(),
    this.aliquotaCofinsStReais = const Value.absent(),
    this.valorCofinsSt = const Value.absent(),
  });

  static Insertable<NfeDetalheImpostoCofinsSt> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<double>? baseCalculoCofinsSt,
    Expression<double>? aliquotaCofinsStPercentual,
    Expression<double>? quantidadeVendidaCofinsSt,
    Expression<double>? aliquotaCofinsStReais,
    Expression<double>? valorCofinsSt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (baseCalculoCofinsSt != null) 'BASE_CALCULO_COFINS_ST': baseCalculoCofinsSt,
      if (aliquotaCofinsStPercentual != null) 'ALIQUOTA_COFINS_ST_PERCENTUAL': aliquotaCofinsStPercentual,
      if (quantidadeVendidaCofinsSt != null) 'QUANTIDADE_VENDIDA_COFINS_ST': quantidadeVendidaCofinsSt,
      if (aliquotaCofinsStReais != null) 'ALIQUOTA_COFINS_ST_REAIS': aliquotaCofinsStReais,
      if (valorCofinsSt != null) 'VALOR_COFINS_ST': valorCofinsSt,
    });
  }

  NfeDetalheImpostoCofinsStsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<double>? baseCalculoCofinsSt,
      Value<double>? aliquotaCofinsStPercentual,
      Value<double>? quantidadeVendidaCofinsSt,
      Value<double>? aliquotaCofinsStReais,
      Value<double>? valorCofinsSt,
	  }) {
    return NfeDetalheImpostoCofinsStsCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      baseCalculoCofinsSt: baseCalculoCofinsSt ?? this.baseCalculoCofinsSt,
      aliquotaCofinsStPercentual: aliquotaCofinsStPercentual ?? this.aliquotaCofinsStPercentual,
      quantidadeVendidaCofinsSt: quantidadeVendidaCofinsSt ?? this.quantidadeVendidaCofinsSt,
      aliquotaCofinsStReais: aliquotaCofinsStReais ?? this.aliquotaCofinsStReais,
      valorCofinsSt: valorCofinsSt ?? this.valorCofinsSt,
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
    if (baseCalculoCofinsSt.present) {
      map['BASE_CALCULO_COFINS_ST'] = Variable<double?>(baseCalculoCofinsSt.value);
    }
    if (aliquotaCofinsStPercentual.present) {
      map['ALIQUOTA_COFINS_ST_PERCENTUAL'] = Variable<double?>(aliquotaCofinsStPercentual.value);
    }
    if (quantidadeVendidaCofinsSt.present) {
      map['QUANTIDADE_VENDIDA_COFINS_ST'] = Variable<double?>(quantidadeVendidaCofinsSt.value);
    }
    if (aliquotaCofinsStReais.present) {
      map['ALIQUOTA_COFINS_ST_REAIS'] = Variable<double?>(aliquotaCofinsStReais.value);
    }
    if (valorCofinsSt.present) {
      map['VALOR_COFINS_ST'] = Variable<double?>(valorCofinsSt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoCofinsStsCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('baseCalculoCofinsSt: $baseCalculoCofinsSt, ')
          ..write('aliquotaCofinsStPercentual: $aliquotaCofinsStPercentual, ')
          ..write('quantidadeVendidaCofinsSt: $quantidadeVendidaCofinsSt, ')
          ..write('aliquotaCofinsStReais: $aliquotaCofinsStReais, ')
          ..write('valorCofinsSt: $valorCofinsSt, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetalheImpostoCofinsStsTable extends NfeDetalheImpostoCofinsSts
    with TableInfo<$NfeDetalheImpostoCofinsStsTable, NfeDetalheImpostoCofinsSt> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetalheImpostoCofinsStsTable(this._db, [this._alias]);
  
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
  final VerificationMeta _baseCalculoCofinsStMeta =
      const VerificationMeta('baseCalculoCofinsSt');
  GeneratedColumn<double>? _baseCalculoCofinsSt;
  @override
  GeneratedColumn<double> get baseCalculoCofinsSt => _baseCalculoCofinsSt ??=
      GeneratedColumn<double>('BASE_CALCULO_COFINS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaCofinsStPercentualMeta =
      const VerificationMeta('aliquotaCofinsStPercentual');
  GeneratedColumn<double>? _aliquotaCofinsStPercentual;
  @override
  GeneratedColumn<double> get aliquotaCofinsStPercentual => _aliquotaCofinsStPercentual ??=
      GeneratedColumn<double>('ALIQUOTA_COFINS_ST_PERCENTUAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _quantidadeVendidaCofinsStMeta =
      const VerificationMeta('quantidadeVendidaCofinsSt');
  GeneratedColumn<double>? _quantidadeVendidaCofinsSt;
  @override
  GeneratedColumn<double> get quantidadeVendidaCofinsSt => _quantidadeVendidaCofinsSt ??=
      GeneratedColumn<double>('QUANTIDADE_VENDIDA_COFINS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaCofinsStReaisMeta =
      const VerificationMeta('aliquotaCofinsStReais');
  GeneratedColumn<double>? _aliquotaCofinsStReais;
  @override
  GeneratedColumn<double> get aliquotaCofinsStReais => _aliquotaCofinsStReais ??=
      GeneratedColumn<double>('ALIQUOTA_COFINS_ST_REAIS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorCofinsStMeta =
      const VerificationMeta('valorCofinsSt');
  GeneratedColumn<double>? _valorCofinsSt;
  @override
  GeneratedColumn<double> get valorCofinsSt => _valorCofinsSt ??=
      GeneratedColumn<double>('VALOR_COFINS_ST', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        baseCalculoCofinsSt,
        aliquotaCofinsStPercentual,
        quantidadeVendidaCofinsSt,
        aliquotaCofinsStReais,
        valorCofinsSt,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DETALHE_IMPOSTO_COFINS_ST';
  
  @override
  String get actualTableName => 'NFE_DETALHE_IMPOSTO_COFINS_ST';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetalheImpostoCofinsSt> instance,
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
    if (data.containsKey('BASE_CALCULO_COFINS_ST')) {
        context.handle(_baseCalculoCofinsStMeta,
            baseCalculoCofinsSt.isAcceptableOrUnknown(data['BASE_CALCULO_COFINS_ST']!, _baseCalculoCofinsStMeta));
    }
    if (data.containsKey('ALIQUOTA_COFINS_ST_PERCENTUAL')) {
        context.handle(_aliquotaCofinsStPercentualMeta,
            aliquotaCofinsStPercentual.isAcceptableOrUnknown(data['ALIQUOTA_COFINS_ST_PERCENTUAL']!, _aliquotaCofinsStPercentualMeta));
    }
    if (data.containsKey('QUANTIDADE_VENDIDA_COFINS_ST')) {
        context.handle(_quantidadeVendidaCofinsStMeta,
            quantidadeVendidaCofinsSt.isAcceptableOrUnknown(data['QUANTIDADE_VENDIDA_COFINS_ST']!, _quantidadeVendidaCofinsStMeta));
    }
    if (data.containsKey('ALIQUOTA_COFINS_ST_REAIS')) {
        context.handle(_aliquotaCofinsStReaisMeta,
            aliquotaCofinsStReais.isAcceptableOrUnknown(data['ALIQUOTA_COFINS_ST_REAIS']!, _aliquotaCofinsStReaisMeta));
    }
    if (data.containsKey('VALOR_COFINS_ST')) {
        context.handle(_valorCofinsStMeta,
            valorCofinsSt.isAcceptableOrUnknown(data['VALOR_COFINS_ST']!, _valorCofinsStMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDetalheImpostoCofinsSt map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetalheImpostoCofinsSt.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetalheImpostoCofinsStsTable createAlias(String alias) {
    return $NfeDetalheImpostoCofinsStsTable(_db, alias);
  }
}