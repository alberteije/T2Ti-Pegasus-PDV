/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE_IMPOSTO_COFINS] 
                                                                                
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

@DataClassName("NfeDetalheImpostoCofins")
@UseRowClass(NfeDetalheImpostoCofins)
class NfeDetalheImpostoCofinss extends Table {
  @override
  String get tableName => 'NFE_DETALHE_IMPOSTO_COFINS';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  TextColumn get cstCofins => text().named('CST_COFINS').withLength(min: 0, max: 2).nullable()();
  RealColumn get baseCalculoCofins => real().named('BASE_CALCULO_COFINS').nullable()();
  RealColumn get aliquotaCofinsPercentual => real().named('ALIQUOTA_COFINS_PERCENTUAL').nullable()();
  RealColumn get quantidadeVendida => real().named('QUANTIDADE_VENDIDA').nullable()();
  RealColumn get aliquotaCofinsReais => real().named('ALIQUOTA_COFINS_REAIS').nullable()();
  RealColumn get valorCofins => real().named('VALOR_COFINS').nullable()();
}

class NfeDetalheImpostoCofins extends DataClass implements Insertable<NfeDetalheImpostoCofins> {
  final int? id;
  final int? idNfeDetalhe;
  final String? cstCofins;
  final double? baseCalculoCofins;
  final double? aliquotaCofinsPercentual;
  final double? quantidadeVendida;
  final double? aliquotaCofinsReais;
  final double? valorCofins;

  NfeDetalheImpostoCofins(
    {
      required this.id,
      this.idNfeDetalhe,
      this.cstCofins,
      this.baseCalculoCofins,
      this.aliquotaCofinsPercentual,
      this.quantidadeVendida,
      this.aliquotaCofinsReais,
      this.valorCofins,
    }
  );

  factory NfeDetalheImpostoCofins.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetalheImpostoCofins(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      cstCofins: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CST_COFINS']),
      baseCalculoCofins: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}BASE_CALCULO_COFINS']),
      aliquotaCofinsPercentual: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_COFINS_PERCENTUAL']),
      quantidadeVendida: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_VENDIDA']),
      aliquotaCofinsReais: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_COFINS_REAIS']),
      valorCofins: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_COFINS']),
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
    if (!nullToAbsent || cstCofins != null) {
      map['CST_COFINS'] = Variable<String?>(cstCofins);
    }
    if (!nullToAbsent || baseCalculoCofins != null) {
      map['BASE_CALCULO_COFINS'] = Variable<double?>(baseCalculoCofins);
    }
    if (!nullToAbsent || aliquotaCofinsPercentual != null) {
      map['ALIQUOTA_COFINS_PERCENTUAL'] = Variable<double?>(aliquotaCofinsPercentual);
    }
    if (!nullToAbsent || quantidadeVendida != null) {
      map['QUANTIDADE_VENDIDA'] = Variable<double?>(quantidadeVendida);
    }
    if (!nullToAbsent || aliquotaCofinsReais != null) {
      map['ALIQUOTA_COFINS_REAIS'] = Variable<double?>(aliquotaCofinsReais);
    }
    if (!nullToAbsent || valorCofins != null) {
      map['VALOR_COFINS'] = Variable<double?>(valorCofins);
    }
    return map;
  }

  NfeDetalheImpostoCofinssCompanion toCompanion(bool nullToAbsent) {
    return NfeDetalheImpostoCofinssCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      cstCofins: cstCofins == null && nullToAbsent
        ? const Value.absent()
        : Value(cstCofins),
      baseCalculoCofins: baseCalculoCofins == null && nullToAbsent
        ? const Value.absent()
        : Value(baseCalculoCofins),
      aliquotaCofinsPercentual: aliquotaCofinsPercentual == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaCofinsPercentual),
      quantidadeVendida: quantidadeVendida == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeVendida),
      aliquotaCofinsReais: aliquotaCofinsReais == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaCofinsReais),
      valorCofins: valorCofins == null && nullToAbsent
        ? const Value.absent()
        : Value(valorCofins),
    );
  }

  factory NfeDetalheImpostoCofins.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetalheImpostoCofins(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      cstCofins: serializer.fromJson<String>(json['cstCofins']),
      baseCalculoCofins: serializer.fromJson<double>(json['baseCalculoCofins']),
      aliquotaCofinsPercentual: serializer.fromJson<double>(json['aliquotaCofinsPercentual']),
      quantidadeVendida: serializer.fromJson<double>(json['quantidadeVendida']),
      aliquotaCofinsReais: serializer.fromJson<double>(json['aliquotaCofinsReais']),
      valorCofins: serializer.fromJson<double>(json['valorCofins']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'cstCofins': serializer.toJson<String?>(cstCofins),
      'baseCalculoCofins': serializer.toJson<double?>(baseCalculoCofins),
      'aliquotaCofinsPercentual': serializer.toJson<double?>(aliquotaCofinsPercentual),
      'quantidadeVendida': serializer.toJson<double?>(quantidadeVendida),
      'aliquotaCofinsReais': serializer.toJson<double?>(aliquotaCofinsReais),
      'valorCofins': serializer.toJson<double?>(valorCofins),
    };
  }

  NfeDetalheImpostoCofins copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          String? cstCofins,
          double? baseCalculoCofins,
          double? aliquotaCofinsPercentual,
          double? quantidadeVendida,
          double? aliquotaCofinsReais,
          double? valorCofins,
		}) =>
      NfeDetalheImpostoCofins(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        cstCofins: cstCofins ?? this.cstCofins,
        baseCalculoCofins: baseCalculoCofins ?? this.baseCalculoCofins,
        aliquotaCofinsPercentual: aliquotaCofinsPercentual ?? this.aliquotaCofinsPercentual,
        quantidadeVendida: quantidadeVendida ?? this.quantidadeVendida,
        aliquotaCofinsReais: aliquotaCofinsReais ?? this.aliquotaCofinsReais,
        valorCofins: valorCofins ?? this.valorCofins,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoCofins(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('cstCofins: $cstCofins, ')
          ..write('baseCalculoCofins: $baseCalculoCofins, ')
          ..write('aliquotaCofinsPercentual: $aliquotaCofinsPercentual, ')
          ..write('quantidadeVendida: $quantidadeVendida, ')
          ..write('aliquotaCofinsReais: $aliquotaCofinsReais, ')
          ..write('valorCofins: $valorCofins, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      cstCofins,
      baseCalculoCofins,
      aliquotaCofinsPercentual,
      quantidadeVendida,
      aliquotaCofinsReais,
      valorCofins,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetalheImpostoCofins &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.cstCofins == cstCofins &&
          other.baseCalculoCofins == baseCalculoCofins &&
          other.aliquotaCofinsPercentual == aliquotaCofinsPercentual &&
          other.quantidadeVendida == quantidadeVendida &&
          other.aliquotaCofinsReais == aliquotaCofinsReais &&
          other.valorCofins == valorCofins 
	   );
}

class NfeDetalheImpostoCofinssCompanion extends UpdateCompanion<NfeDetalheImpostoCofins> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<String?> cstCofins;
  final Value<double?> baseCalculoCofins;
  final Value<double?> aliquotaCofinsPercentual;
  final Value<double?> quantidadeVendida;
  final Value<double?> aliquotaCofinsReais;
  final Value<double?> valorCofins;

  const NfeDetalheImpostoCofinssCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.cstCofins = const Value.absent(),
    this.baseCalculoCofins = const Value.absent(),
    this.aliquotaCofinsPercentual = const Value.absent(),
    this.quantidadeVendida = const Value.absent(),
    this.aliquotaCofinsReais = const Value.absent(),
    this.valorCofins = const Value.absent(),
  });

  NfeDetalheImpostoCofinssCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.cstCofins = const Value.absent(),
    this.baseCalculoCofins = const Value.absent(),
    this.aliquotaCofinsPercentual = const Value.absent(),
    this.quantidadeVendida = const Value.absent(),
    this.aliquotaCofinsReais = const Value.absent(),
    this.valorCofins = const Value.absent(),
  });

  static Insertable<NfeDetalheImpostoCofins> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<String>? cstCofins,
    Expression<double>? baseCalculoCofins,
    Expression<double>? aliquotaCofinsPercentual,
    Expression<double>? quantidadeVendida,
    Expression<double>? aliquotaCofinsReais,
    Expression<double>? valorCofins,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (cstCofins != null) 'CST_COFINS': cstCofins,
      if (baseCalculoCofins != null) 'BASE_CALCULO_COFINS': baseCalculoCofins,
      if (aliquotaCofinsPercentual != null) 'ALIQUOTA_COFINS_PERCENTUAL': aliquotaCofinsPercentual,
      if (quantidadeVendida != null) 'QUANTIDADE_VENDIDA': quantidadeVendida,
      if (aliquotaCofinsReais != null) 'ALIQUOTA_COFINS_REAIS': aliquotaCofinsReais,
      if (valorCofins != null) 'VALOR_COFINS': valorCofins,
    });
  }

  NfeDetalheImpostoCofinssCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<String>? cstCofins,
      Value<double>? baseCalculoCofins,
      Value<double>? aliquotaCofinsPercentual,
      Value<double>? quantidadeVendida,
      Value<double>? aliquotaCofinsReais,
      Value<double>? valorCofins,
	  }) {
    return NfeDetalheImpostoCofinssCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      cstCofins: cstCofins ?? this.cstCofins,
      baseCalculoCofins: baseCalculoCofins ?? this.baseCalculoCofins,
      aliquotaCofinsPercentual: aliquotaCofinsPercentual ?? this.aliquotaCofinsPercentual,
      quantidadeVendida: quantidadeVendida ?? this.quantidadeVendida,
      aliquotaCofinsReais: aliquotaCofinsReais ?? this.aliquotaCofinsReais,
      valorCofins: valorCofins ?? this.valorCofins,
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
    if (cstCofins.present) {
      map['CST_COFINS'] = Variable<String?>(cstCofins.value);
    }
    if (baseCalculoCofins.present) {
      map['BASE_CALCULO_COFINS'] = Variable<double?>(baseCalculoCofins.value);
    }
    if (aliquotaCofinsPercentual.present) {
      map['ALIQUOTA_COFINS_PERCENTUAL'] = Variable<double?>(aliquotaCofinsPercentual.value);
    }
    if (quantidadeVendida.present) {
      map['QUANTIDADE_VENDIDA'] = Variable<double?>(quantidadeVendida.value);
    }
    if (aliquotaCofinsReais.present) {
      map['ALIQUOTA_COFINS_REAIS'] = Variable<double?>(aliquotaCofinsReais.value);
    }
    if (valorCofins.present) {
      map['VALOR_COFINS'] = Variable<double?>(valorCofins.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoCofinssCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('cstCofins: $cstCofins, ')
          ..write('baseCalculoCofins: $baseCalculoCofins, ')
          ..write('aliquotaCofinsPercentual: $aliquotaCofinsPercentual, ')
          ..write('quantidadeVendida: $quantidadeVendida, ')
          ..write('aliquotaCofinsReais: $aliquotaCofinsReais, ')
          ..write('valorCofins: $valorCofins, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetalheImpostoCofinssTable extends NfeDetalheImpostoCofinss
    with TableInfo<$NfeDetalheImpostoCofinssTable, NfeDetalheImpostoCofins> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetalheImpostoCofinssTable(this._db, [this._alias]);
  
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
  final VerificationMeta _cstCofinsMeta =
      const VerificationMeta('cstCofins');
  GeneratedColumn<String>? _cstCofins;
  @override
  GeneratedColumn<String> get cstCofins => _cstCofins ??=
      GeneratedColumn<String>('CST_COFINS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _baseCalculoCofinsMeta =
      const VerificationMeta('baseCalculoCofins');
  GeneratedColumn<double>? _baseCalculoCofins;
  @override
  GeneratedColumn<double> get baseCalculoCofins => _baseCalculoCofins ??=
      GeneratedColumn<double>('BASE_CALCULO_COFINS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaCofinsPercentualMeta =
      const VerificationMeta('aliquotaCofinsPercentual');
  GeneratedColumn<double>? _aliquotaCofinsPercentual;
  @override
  GeneratedColumn<double> get aliquotaCofinsPercentual => _aliquotaCofinsPercentual ??=
      GeneratedColumn<double>('ALIQUOTA_COFINS_PERCENTUAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _quantidadeVendidaMeta =
      const VerificationMeta('quantidadeVendida');
  GeneratedColumn<double>? _quantidadeVendida;
  @override
  GeneratedColumn<double> get quantidadeVendida => _quantidadeVendida ??=
      GeneratedColumn<double>('QUANTIDADE_VENDIDA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaCofinsReaisMeta =
      const VerificationMeta('aliquotaCofinsReais');
  GeneratedColumn<double>? _aliquotaCofinsReais;
  @override
  GeneratedColumn<double> get aliquotaCofinsReais => _aliquotaCofinsReais ??=
      GeneratedColumn<double>('ALIQUOTA_COFINS_REAIS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorCofinsMeta =
      const VerificationMeta('valorCofins');
  GeneratedColumn<double>? _valorCofins;
  @override
  GeneratedColumn<double> get valorCofins => _valorCofins ??=
      GeneratedColumn<double>('VALOR_COFINS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        cstCofins,
        baseCalculoCofins,
        aliquotaCofinsPercentual,
        quantidadeVendida,
        aliquotaCofinsReais,
        valorCofins,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DETALHE_IMPOSTO_COFINS';
  
  @override
  String get actualTableName => 'NFE_DETALHE_IMPOSTO_COFINS';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetalheImpostoCofins> instance,
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
    if (data.containsKey('CST_COFINS')) {
        context.handle(_cstCofinsMeta,
            cstCofins.isAcceptableOrUnknown(data['CST_COFINS']!, _cstCofinsMeta));
    }
    if (data.containsKey('BASE_CALCULO_COFINS')) {
        context.handle(_baseCalculoCofinsMeta,
            baseCalculoCofins.isAcceptableOrUnknown(data['BASE_CALCULO_COFINS']!, _baseCalculoCofinsMeta));
    }
    if (data.containsKey('ALIQUOTA_COFINS_PERCENTUAL')) {
        context.handle(_aliquotaCofinsPercentualMeta,
            aliquotaCofinsPercentual.isAcceptableOrUnknown(data['ALIQUOTA_COFINS_PERCENTUAL']!, _aliquotaCofinsPercentualMeta));
    }
    if (data.containsKey('QUANTIDADE_VENDIDA')) {
        context.handle(_quantidadeVendidaMeta,
            quantidadeVendida.isAcceptableOrUnknown(data['QUANTIDADE_VENDIDA']!, _quantidadeVendidaMeta));
    }
    if (data.containsKey('ALIQUOTA_COFINS_REAIS')) {
        context.handle(_aliquotaCofinsReaisMeta,
            aliquotaCofinsReais.isAcceptableOrUnknown(data['ALIQUOTA_COFINS_REAIS']!, _aliquotaCofinsReaisMeta));
    }
    if (data.containsKey('VALOR_COFINS')) {
        context.handle(_valorCofinsMeta,
            valorCofins.isAcceptableOrUnknown(data['VALOR_COFINS']!, _valorCofinsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDetalheImpostoCofins map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetalheImpostoCofins.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetalheImpostoCofinssTable createAlias(String alias) {
    return $NfeDetalheImpostoCofinssTable(_db, alias);
  }
}