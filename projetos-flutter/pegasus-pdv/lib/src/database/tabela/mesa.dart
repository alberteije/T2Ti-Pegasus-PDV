/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [MESA] 
                                                                                
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

@DataClassName("Mesa")
@UseRowClass(Mesa)
class Mesas extends Table {
  @override
  String get tableName => 'MESA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get numero => text().named('NUMERO').withLength(min: 0, max: 10).nullable()();
  IntColumn get quantidadeCadeiras => integer().named('QUANTIDADE_CADEIRAS').nullable()();
  IntColumn get quantidadeCadeirasCrianca => integer().named('QUANTIDADE_CADEIRAS_CRIANCA').nullable()();
  TextColumn get disponivel => text().named('DISPONIVEL').withLength(min: 0, max: 1).nullable()();
  TextColumn get observacao => text().named('OBSERVACAO').withLength(min: 0, max: 250).nullable()();
}

class Mesa extends DataClass implements Insertable<Mesa> {
  final int? id;
  final String? numero;
  final int? quantidadeCadeiras;
  final int? quantidadeCadeirasCrianca;
  final String? disponivel;
  final String? observacao;

  Mesa(
    {
      required this.id,
      this.numero,
      this.quantidadeCadeiras,
      this.quantidadeCadeirasCrianca,
      this.disponivel,
      this.observacao,
    }
  );

  factory Mesa.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Mesa(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      numero: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO']),
      quantidadeCadeiras: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_CADEIRAS']),
      quantidadeCadeirasCrianca: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_CADEIRAS_CRIANCA']),
      disponivel: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DISPONIVEL']),
      observacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}OBSERVACAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || numero != null) {
      map['NUMERO'] = Variable<String?>(numero);
    }
    if (!nullToAbsent || quantidadeCadeiras != null) {
      map['QUANTIDADE_CADEIRAS'] = Variable<int?>(quantidadeCadeiras);
    }
    if (!nullToAbsent || quantidadeCadeirasCrianca != null) {
      map['QUANTIDADE_CADEIRAS_CRIANCA'] = Variable<int?>(quantidadeCadeirasCrianca);
    }
    if (!nullToAbsent || disponivel != null) {
      map['DISPONIVEL'] = Variable<String?>(disponivel);
    }
    if (!nullToAbsent || observacao != null) {
      map['OBSERVACAO'] = Variable<String?>(observacao);
    }
    return map;
  }

  MesasCompanion toCompanion(bool nullToAbsent) {
    return MesasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      numero: numero == null && nullToAbsent
        ? const Value.absent()
        : Value(numero),
      quantidadeCadeiras: quantidadeCadeiras == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeCadeiras),
      quantidadeCadeirasCrianca: quantidadeCadeirasCrianca == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeCadeirasCrianca),
      disponivel: disponivel == null && nullToAbsent
        ? const Value.absent()
        : Value(disponivel),
      observacao: observacao == null && nullToAbsent
        ? const Value.absent()
        : Value(observacao),
    );
  }

  factory Mesa.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Mesa(
      id: serializer.fromJson<int>(json['id']),
      numero: serializer.fromJson<String>(json['numero']),
      quantidadeCadeiras: serializer.fromJson<int>(json['quantidadeCadeiras']),
      quantidadeCadeirasCrianca: serializer.fromJson<int>(json['quantidadeCadeirasCrianca']),
      disponivel: serializer.fromJson<String>(json['disponivel']),
      observacao: serializer.fromJson<String>(json['observacao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'numero': serializer.toJson<String?>(numero),
      'quantidadeCadeiras': serializer.toJson<int?>(quantidadeCadeiras),
      'quantidadeCadeirasCrianca': serializer.toJson<int?>(quantidadeCadeirasCrianca),
      'disponivel': serializer.toJson<String?>(disponivel),
      'observacao': serializer.toJson<String?>(observacao),
    };
  }

  Mesa copyWith(
        {
		  int? id,
          String? numero,
          int? quantidadeCadeiras,
          int? quantidadeCadeirasCrianca,
          String? disponivel,
          String? observacao,
		}) =>
      Mesa(
        id: id ?? this.id,
        numero: numero ?? this.numero,
        quantidadeCadeiras: quantidadeCadeiras ?? this.quantidadeCadeiras,
        quantidadeCadeirasCrianca: quantidadeCadeirasCrianca ?? this.quantidadeCadeirasCrianca,
        disponivel: disponivel ?? this.disponivel,
        observacao: observacao ?? this.observacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('Mesa(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('quantidadeCadeiras: $quantidadeCadeiras, ')
          ..write('quantidadeCadeirasCrianca: $quantidadeCadeirasCrianca, ')
          ..write('disponivel: $disponivel, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      numero,
      quantidadeCadeiras,
      quantidadeCadeirasCrianca,
      disponivel,
      observacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mesa &&
          other.id == id &&
          other.numero == numero &&
          other.quantidadeCadeiras == quantidadeCadeiras &&
          other.quantidadeCadeirasCrianca == quantidadeCadeirasCrianca &&
          other.disponivel == disponivel &&
          other.observacao == observacao 
	   );
}

class MesasCompanion extends UpdateCompanion<Mesa> {

  final Value<int?> id;
  final Value<String?> numero;
  final Value<int?> quantidadeCadeiras;
  final Value<int?> quantidadeCadeirasCrianca;
  final Value<String?> disponivel;
  final Value<String?> observacao;

  const MesasCompanion({
    this.id = const Value.absent(),
    this.numero = const Value.absent(),
    this.quantidadeCadeiras = const Value.absent(),
    this.quantidadeCadeirasCrianca = const Value.absent(),
    this.disponivel = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  MesasCompanion.insert({
    this.id = const Value.absent(),
    this.numero = const Value.absent(),
    this.quantidadeCadeiras = const Value.absent(),
    this.quantidadeCadeirasCrianca = const Value.absent(),
    this.disponivel = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  static Insertable<Mesa> custom({
    Expression<int>? id,
    Expression<String>? numero,
    Expression<int>? quantidadeCadeiras,
    Expression<int>? quantidadeCadeirasCrianca,
    Expression<String>? disponivel,
    Expression<String>? observacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (numero != null) 'NUMERO': numero,
      if (quantidadeCadeiras != null) 'QUANTIDADE_CADEIRAS': quantidadeCadeiras,
      if (quantidadeCadeirasCrianca != null) 'QUANTIDADE_CADEIRAS_CRIANCA': quantidadeCadeirasCrianca,
      if (disponivel != null) 'DISPONIVEL': disponivel,
      if (observacao != null) 'OBSERVACAO': observacao,
    });
  }

  MesasCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? numero,
      Value<int>? quantidadeCadeiras,
      Value<int>? quantidadeCadeirasCrianca,
      Value<String>? disponivel,
      Value<String>? observacao,
	  }) {
    return MesasCompanion(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      quantidadeCadeiras: quantidadeCadeiras ?? this.quantidadeCadeiras,
      quantidadeCadeirasCrianca: quantidadeCadeirasCrianca ?? this.quantidadeCadeirasCrianca,
      disponivel: disponivel ?? this.disponivel,
      observacao: observacao ?? this.observacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (numero.present) {
      map['NUMERO'] = Variable<String?>(numero.value);
    }
    if (quantidadeCadeiras.present) {
      map['QUANTIDADE_CADEIRAS'] = Variable<int?>(quantidadeCadeiras.value);
    }
    if (quantidadeCadeirasCrianca.present) {
      map['QUANTIDADE_CADEIRAS_CRIANCA'] = Variable<int?>(quantidadeCadeirasCrianca.value);
    }
    if (disponivel.present) {
      map['DISPONIVEL'] = Variable<String?>(disponivel.value);
    }
    if (observacao.present) {
      map['OBSERVACAO'] = Variable<String?>(observacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MesasCompanion(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('quantidadeCadeiras: $quantidadeCadeiras, ')
          ..write('quantidadeCadeirasCrianca: $quantidadeCadeirasCrianca, ')
          ..write('disponivel: $disponivel, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }
}

class $MesasTable extends Mesas
    with TableInfo<$MesasTable, Mesa> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MesasTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _numeroMeta =
      const VerificationMeta('numero');
  GeneratedColumn<String>? _numero;
  @override
  GeneratedColumn<String> get numero => _numero ??=
      GeneratedColumn<String>('NUMERO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _quantidadeCadeirasMeta =
      const VerificationMeta('quantidadeCadeiras');
  GeneratedColumn<int>? _quantidadeCadeiras;
  @override
  GeneratedColumn<int> get quantidadeCadeiras => _quantidadeCadeiras ??=
      GeneratedColumn<int>('QUANTIDADE_CADEIRAS', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _quantidadeCadeirasCriancaMeta =
      const VerificationMeta('quantidadeCadeirasCrianca');
  GeneratedColumn<int>? _quantidadeCadeirasCrianca;
  @override
  GeneratedColumn<int> get quantidadeCadeirasCrianca => _quantidadeCadeirasCrianca ??=
      GeneratedColumn<int>('QUANTIDADE_CADEIRAS_CRIANCA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _disponivelMeta =
      const VerificationMeta('disponivel');
  GeneratedColumn<String>? _disponivel;
  @override
  GeneratedColumn<String> get disponivel => _disponivel ??=
      GeneratedColumn<String>('DISPONIVEL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  GeneratedColumn<String>? _observacao;
  @override
  GeneratedColumn<String> get observacao => _observacao ??=
      GeneratedColumn<String>('OBSERVACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        numero,
        quantidadeCadeiras,
        quantidadeCadeirasCrianca,
        disponivel,
        observacao,
      ];

  @override
  String get aliasedName => _alias ?? 'MESA';
  
  @override
  String get actualTableName => 'MESA';
  
  @override
  VerificationContext validateIntegrity(Insertable<Mesa> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('NUMERO')) {
        context.handle(_numeroMeta,
            numero.isAcceptableOrUnknown(data['NUMERO']!, _numeroMeta));
    }
    if (data.containsKey('QUANTIDADE_CADEIRAS')) {
        context.handle(_quantidadeCadeirasMeta,
            quantidadeCadeiras.isAcceptableOrUnknown(data['QUANTIDADE_CADEIRAS']!, _quantidadeCadeirasMeta));
    }
    if (data.containsKey('QUANTIDADE_CADEIRAS_CRIANCA')) {
        context.handle(_quantidadeCadeirasCriancaMeta,
            quantidadeCadeirasCrianca.isAcceptableOrUnknown(data['QUANTIDADE_CADEIRAS_CRIANCA']!, _quantidadeCadeirasCriancaMeta));
    }
    if (data.containsKey('DISPONIVEL')) {
        context.handle(_disponivelMeta,
            disponivel.isAcceptableOrUnknown(data['DISPONIVEL']!, _disponivelMeta));
    }
    if (data.containsKey('OBSERVACAO')) {
        context.handle(_observacaoMeta,
            observacao.isAcceptableOrUnknown(data['OBSERVACAO']!, _observacaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mesa map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Mesa.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MesasTable createAlias(String alias) {
    return $MesasTable(_db, alias);
  }
}