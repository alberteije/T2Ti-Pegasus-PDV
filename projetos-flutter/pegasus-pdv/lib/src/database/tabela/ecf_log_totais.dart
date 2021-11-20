/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_LOG_TOTAIS] 
                                                                                
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

@DataClassName("EcfLogTotais")
@UseRowClass(EcfLogTotais)
class EcfLogTotaiss extends Table {
  @override
  String get tableName => 'ECF_LOG_TOTAIS';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get tipoPagamento => integer().named('TIPO_PAGAMENTO').nullable()();
  IntColumn get produto => integer().named('PRODUTO').nullable()();
  IntColumn get r01 => integer().named('R01').nullable()();
  IntColumn get r02 => integer().named('R02').nullable()();
  IntColumn get r03 => integer().named('R03').nullable()();
  IntColumn get r04 => integer().named('R04').nullable()();
  IntColumn get r05 => integer().named('R05').nullable()();
  IntColumn get r06 => integer().named('R06').nullable()();
  IntColumn get r07 => integer().named('R07').nullable()();
}

class EcfLogTotais extends DataClass implements Insertable<EcfLogTotais> {
  final int? id;
  final int? tipoPagamento;
  final int? produto;
  final int? r01;
  final int? r02;
  final int? r03;
  final int? r04;
  final int? r05;
  final int? r06;
  final int? r07;

  EcfLogTotais(
    {
      required this.id,
      this.tipoPagamento,
      this.produto,
      this.r01,
      this.r02,
      this.r03,
      this.r04,
      this.r05,
      this.r06,
      this.r07,
    }
  );

  factory EcfLogTotais.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EcfLogTotais(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      tipoPagamento: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_PAGAMENTO']),
      produto: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}PRODUTO']),
      r01: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}R01']),
      r02: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}R02']),
      r03: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}R03']),
      r04: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}R04']),
      r05: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}R05']),
      r06: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}R06']),
      r07: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}R07']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || tipoPagamento != null) {
      map['TIPO_PAGAMENTO'] = Variable<int?>(tipoPagamento);
    }
    if (!nullToAbsent || produto != null) {
      map['PRODUTO'] = Variable<int?>(produto);
    }
    if (!nullToAbsent || r01 != null) {
      map['R01'] = Variable<int?>(r01);
    }
    if (!nullToAbsent || r02 != null) {
      map['R02'] = Variable<int?>(r02);
    }
    if (!nullToAbsent || r03 != null) {
      map['R03'] = Variable<int?>(r03);
    }
    if (!nullToAbsent || r04 != null) {
      map['R04'] = Variable<int?>(r04);
    }
    if (!nullToAbsent || r05 != null) {
      map['R05'] = Variable<int?>(r05);
    }
    if (!nullToAbsent || r06 != null) {
      map['R06'] = Variable<int?>(r06);
    }
    if (!nullToAbsent || r07 != null) {
      map['R07'] = Variable<int?>(r07);
    }
    return map;
  }

  EcfLogTotaissCompanion toCompanion(bool nullToAbsent) {
    return EcfLogTotaissCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tipoPagamento: tipoPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoPagamento),
      produto: produto == null && nullToAbsent
        ? const Value.absent()
        : Value(produto),
      r01: r01 == null && nullToAbsent
        ? const Value.absent()
        : Value(r01),
      r02: r02 == null && nullToAbsent
        ? const Value.absent()
        : Value(r02),
      r03: r03 == null && nullToAbsent
        ? const Value.absent()
        : Value(r03),
      r04: r04 == null && nullToAbsent
        ? const Value.absent()
        : Value(r04),
      r05: r05 == null && nullToAbsent
        ? const Value.absent()
        : Value(r05),
      r06: r06 == null && nullToAbsent
        ? const Value.absent()
        : Value(r06),
      r07: r07 == null && nullToAbsent
        ? const Value.absent()
        : Value(r07),
    );
  }

  factory EcfLogTotais.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EcfLogTotais(
      id: serializer.fromJson<int>(json['id']),
      tipoPagamento: serializer.fromJson<int>(json['tipoPagamento']),
      produto: serializer.fromJson<int>(json['produto']),
      r01: serializer.fromJson<int>(json['r01']),
      r02: serializer.fromJson<int>(json['r02']),
      r03: serializer.fromJson<int>(json['r03']),
      r04: serializer.fromJson<int>(json['r04']),
      r05: serializer.fromJson<int>(json['r05']),
      r06: serializer.fromJson<int>(json['r06']),
      r07: serializer.fromJson<int>(json['r07']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'tipoPagamento': serializer.toJson<int?>(tipoPagamento),
      'produto': serializer.toJson<int?>(produto),
      'r01': serializer.toJson<int?>(r01),
      'r02': serializer.toJson<int?>(r02),
      'r03': serializer.toJson<int?>(r03),
      'r04': serializer.toJson<int?>(r04),
      'r05': serializer.toJson<int?>(r05),
      'r06': serializer.toJson<int?>(r06),
      'r07': serializer.toJson<int?>(r07),
    };
  }

  EcfLogTotais copyWith(
        {
		  int? id,
          int? tipoPagamento,
          int? produto,
          int? r01,
          int? r02,
          int? r03,
          int? r04,
          int? r05,
          int? r06,
          int? r07,
		}) =>
      EcfLogTotais(
        id: id ?? this.id,
        tipoPagamento: tipoPagamento ?? this.tipoPagamento,
        produto: produto ?? this.produto,
        r01: r01 ?? this.r01,
        r02: r02 ?? this.r02,
        r03: r03 ?? this.r03,
        r04: r04 ?? this.r04,
        r05: r05 ?? this.r05,
        r06: r06 ?? this.r06,
        r07: r07 ?? this.r07,
      );
  
  @override
  String toString() {
    return (StringBuffer('EcfLogTotais(')
          ..write('id: $id, ')
          ..write('tipoPagamento: $tipoPagamento, ')
          ..write('produto: $produto, ')
          ..write('r01: $r01, ')
          ..write('r02: $r02, ')
          ..write('r03: $r03, ')
          ..write('r04: $r04, ')
          ..write('r05: $r05, ')
          ..write('r06: $r06, ')
          ..write('r07: $r07, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      tipoPagamento,
      produto,
      r01,
      r02,
      r03,
      r04,
      r05,
      r06,
      r07,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcfLogTotais &&
          other.id == id &&
          other.tipoPagamento == tipoPagamento &&
          other.produto == produto &&
          other.r01 == r01 &&
          other.r02 == r02 &&
          other.r03 == r03 &&
          other.r04 == r04 &&
          other.r05 == r05 &&
          other.r06 == r06 &&
          other.r07 == r07 
	   );
}

class EcfLogTotaissCompanion extends UpdateCompanion<EcfLogTotais> {

  final Value<int?> id;
  final Value<int?> tipoPagamento;
  final Value<int?> produto;
  final Value<int?> r01;
  final Value<int?> r02;
  final Value<int?> r03;
  final Value<int?> r04;
  final Value<int?> r05;
  final Value<int?> r06;
  final Value<int?> r07;

  const EcfLogTotaissCompanion({
    this.id = const Value.absent(),
    this.tipoPagamento = const Value.absent(),
    this.produto = const Value.absent(),
    this.r01 = const Value.absent(),
    this.r02 = const Value.absent(),
    this.r03 = const Value.absent(),
    this.r04 = const Value.absent(),
    this.r05 = const Value.absent(),
    this.r06 = const Value.absent(),
    this.r07 = const Value.absent(),
  });

  EcfLogTotaissCompanion.insert({
    this.id = const Value.absent(),
    this.tipoPagamento = const Value.absent(),
    this.produto = const Value.absent(),
    this.r01 = const Value.absent(),
    this.r02 = const Value.absent(),
    this.r03 = const Value.absent(),
    this.r04 = const Value.absent(),
    this.r05 = const Value.absent(),
    this.r06 = const Value.absent(),
    this.r07 = const Value.absent(),
  });

  static Insertable<EcfLogTotais> custom({
    Expression<int>? id,
    Expression<int>? tipoPagamento,
    Expression<int>? produto,
    Expression<int>? r01,
    Expression<int>? r02,
    Expression<int>? r03,
    Expression<int>? r04,
    Expression<int>? r05,
    Expression<int>? r06,
    Expression<int>? r07,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (tipoPagamento != null) 'TIPO_PAGAMENTO': tipoPagamento,
      if (produto != null) 'PRODUTO': produto,
      if (r01 != null) 'R01': r01,
      if (r02 != null) 'R02': r02,
      if (r03 != null) 'R03': r03,
      if (r04 != null) 'R04': r04,
      if (r05 != null) 'R05': r05,
      if (r06 != null) 'R06': r06,
      if (r07 != null) 'R07': r07,
    });
  }

  EcfLogTotaissCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? tipoPagamento,
      Value<int>? produto,
      Value<int>? r01,
      Value<int>? r02,
      Value<int>? r03,
      Value<int>? r04,
      Value<int>? r05,
      Value<int>? r06,
      Value<int>? r07,
	  }) {
    return EcfLogTotaissCompanion(
      id: id ?? this.id,
      tipoPagamento: tipoPagamento ?? this.tipoPagamento,
      produto: produto ?? this.produto,
      r01: r01 ?? this.r01,
      r02: r02 ?? this.r02,
      r03: r03 ?? this.r03,
      r04: r04 ?? this.r04,
      r05: r05 ?? this.r05,
      r06: r06 ?? this.r06,
      r07: r07 ?? this.r07,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (tipoPagamento.present) {
      map['TIPO_PAGAMENTO'] = Variable<int?>(tipoPagamento.value);
    }
    if (produto.present) {
      map['PRODUTO'] = Variable<int?>(produto.value);
    }
    if (r01.present) {
      map['R01'] = Variable<int?>(r01.value);
    }
    if (r02.present) {
      map['R02'] = Variable<int?>(r02.value);
    }
    if (r03.present) {
      map['R03'] = Variable<int?>(r03.value);
    }
    if (r04.present) {
      map['R04'] = Variable<int?>(r04.value);
    }
    if (r05.present) {
      map['R05'] = Variable<int?>(r05.value);
    }
    if (r06.present) {
      map['R06'] = Variable<int?>(r06.value);
    }
    if (r07.present) {
      map['R07'] = Variable<int?>(r07.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcfLogTotaissCompanion(')
          ..write('id: $id, ')
          ..write('tipoPagamento: $tipoPagamento, ')
          ..write('produto: $produto, ')
          ..write('r01: $r01, ')
          ..write('r02: $r02, ')
          ..write('r03: $r03, ')
          ..write('r04: $r04, ')
          ..write('r05: $r05, ')
          ..write('r06: $r06, ')
          ..write('r07: $r07, ')
          ..write(')'))
        .toString();
  }
}

class $EcfLogTotaissTable extends EcfLogTotaiss
    with TableInfo<$EcfLogTotaissTable, EcfLogTotais> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EcfLogTotaissTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _tipoPagamentoMeta =
      const VerificationMeta('tipoPagamento');
  GeneratedColumn<int>? _tipoPagamento;
  @override
  GeneratedColumn<int> get tipoPagamento => _tipoPagamento ??=
      GeneratedColumn<int>('TIPO_PAGAMENTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _produtoMeta =
      const VerificationMeta('produto');
  GeneratedColumn<int>? _produto;
  @override
  GeneratedColumn<int> get produto => _produto ??=
      GeneratedColumn<int>('PRODUTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _r01Meta =
      const VerificationMeta('r01');
  GeneratedColumn<int>? _r01;
  @override
  GeneratedColumn<int> get r01 => _r01 ??=
      GeneratedColumn<int>('R01', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _r02Meta =
      const VerificationMeta('r02');
  GeneratedColumn<int>? _r02;
  @override
  GeneratedColumn<int> get r02 => _r02 ??=
      GeneratedColumn<int>('R02', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _r03Meta =
      const VerificationMeta('r03');
  GeneratedColumn<int>? _r03;
  @override
  GeneratedColumn<int> get r03 => _r03 ??=
      GeneratedColumn<int>('R03', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _r04Meta =
      const VerificationMeta('r04');
  GeneratedColumn<int>? _r04;
  @override
  GeneratedColumn<int> get r04 => _r04 ??=
      GeneratedColumn<int>('R04', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _r05Meta =
      const VerificationMeta('r05');
  GeneratedColumn<int>? _r05;
  @override
  GeneratedColumn<int> get r05 => _r05 ??=
      GeneratedColumn<int>('R05', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _r06Meta =
      const VerificationMeta('r06');
  GeneratedColumn<int>? _r06;
  @override
  GeneratedColumn<int> get r06 => _r06 ??=
      GeneratedColumn<int>('R06', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _r07Meta =
      const VerificationMeta('r07');
  GeneratedColumn<int>? _r07;
  @override
  GeneratedColumn<int> get r07 => _r07 ??=
      GeneratedColumn<int>('R07', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tipoPagamento,
        produto,
        r01,
        r02,
        r03,
        r04,
        r05,
        r06,
        r07,
      ];

  @override
  String get aliasedName => _alias ?? 'ECF_LOG_TOTAIS';
  
  @override
  String get actualTableName => 'ECF_LOG_TOTAIS';
  
  @override
  VerificationContext validateIntegrity(Insertable<EcfLogTotais> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('TIPO_PAGAMENTO')) {
        context.handle(_tipoPagamentoMeta,
            tipoPagamento.isAcceptableOrUnknown(data['TIPO_PAGAMENTO']!, _tipoPagamentoMeta));
    }
    if (data.containsKey('PRODUTO')) {
        context.handle(_produtoMeta,
            produto.isAcceptableOrUnknown(data['PRODUTO']!, _produtoMeta));
    }
    if (data.containsKey('R01')) {
        context.handle(_r01Meta,
            r01.isAcceptableOrUnknown(data['R01']!, _r01Meta));
    }
    if (data.containsKey('R02')) {
        context.handle(_r02Meta,
            r02.isAcceptableOrUnknown(data['R02']!, _r02Meta));
    }
    if (data.containsKey('R03')) {
        context.handle(_r03Meta,
            r03.isAcceptableOrUnknown(data['R03']!, _r03Meta));
    }
    if (data.containsKey('R04')) {
        context.handle(_r04Meta,
            r04.isAcceptableOrUnknown(data['R04']!, _r04Meta));
    }
    if (data.containsKey('R05')) {
        context.handle(_r05Meta,
            r05.isAcceptableOrUnknown(data['R05']!, _r05Meta));
    }
    if (data.containsKey('R06')) {
        context.handle(_r06Meta,
            r06.isAcceptableOrUnknown(data['R06']!, _r06Meta));
    }
    if (data.containsKey('R07')) {
        context.handle(_r07Meta,
            r07.isAcceptableOrUnknown(data['R07']!, _r07Meta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EcfLogTotais map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EcfLogTotais.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EcfLogTotaissTable createAlias(String alias) {
    return $EcfLogTotaissTable(_db, alias);
  }
}