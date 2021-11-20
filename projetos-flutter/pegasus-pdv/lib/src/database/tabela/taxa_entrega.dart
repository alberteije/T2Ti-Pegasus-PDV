/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [TAXA_ENTREGA] 
                                                                                
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

@DataClassName("TaxaEntrega")
@UseRowClass(TaxaEntrega)
class TaxaEntregas extends Table {
  @override
  String get tableName => 'TAXA_ENTREGA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get nome => text().named('NOME').withLength(min: 0, max: 100).nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
  IntColumn get estimativaMinutos => integer().named('ESTIMATIVA_MINUTOS').nullable()();
}

class TaxaEntrega extends DataClass implements Insertable<TaxaEntrega> {
  final int? id;
  final String? nome;
  final double? valor;
  final int? estimativaMinutos;

  TaxaEntrega(
    {
      required this.id,
      this.nome,
      this.valor,
      this.estimativaMinutos,
    }
  );

  factory TaxaEntrega.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TaxaEntrega(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      nome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
      estimativaMinutos: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ESTIMATIVA_MINUTOS']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || nome != null) {
      map['NOME'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    if (!nullToAbsent || estimativaMinutos != null) {
      map['ESTIMATIVA_MINUTOS'] = Variable<int?>(estimativaMinutos);
    }
    return map;
  }

  TaxaEntregasCompanion toCompanion(bool nullToAbsent) {
    return TaxaEntregasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent
        ? const Value.absent()
        : Value(nome),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
      estimativaMinutos: estimativaMinutos == null && nullToAbsent
        ? const Value.absent()
        : Value(estimativaMinutos),
    );
  }

  factory TaxaEntrega.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TaxaEntrega(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      valor: serializer.fromJson<double>(json['valor']),
      estimativaMinutos: serializer.fromJson<int>(json['estimativaMinutos']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'nome': serializer.toJson<String?>(nome),
      'valor': serializer.toJson<double?>(valor),
      'estimativaMinutos': serializer.toJson<int?>(estimativaMinutos),
    };
  }

  TaxaEntrega copyWith(
        {
		  int? id,
          String? nome,
          double? valor,
          int? estimativaMinutos,
		}) =>
      TaxaEntrega(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        valor: valor ?? this.valor,
        estimativaMinutos: estimativaMinutos ?? this.estimativaMinutos,
      );
  
  @override
  String toString() {
    return (StringBuffer('TaxaEntrega(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('valor: $valor, ')
          ..write('estimativaMinutos: $estimativaMinutos, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      nome,
      valor,
      estimativaMinutos,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaxaEntrega &&
          other.id == id &&
          other.nome == nome &&
          other.valor == valor &&
          other.estimativaMinutos == estimativaMinutos 
	   );
}

class TaxaEntregasCompanion extends UpdateCompanion<TaxaEntrega> {

  final Value<int?> id;
  final Value<String?> nome;
  final Value<double?> valor;
  final Value<int?> estimativaMinutos;

  const TaxaEntregasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.valor = const Value.absent(),
    this.estimativaMinutos = const Value.absent(),
  });

  TaxaEntregasCompanion.insert({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.valor = const Value.absent(),
    this.estimativaMinutos = const Value.absent(),
  });

  static Insertable<TaxaEntrega> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<double>? valor,
    Expression<int>? estimativaMinutos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (nome != null) 'NOME': nome,
      if (valor != null) 'VALOR': valor,
      if (estimativaMinutos != null) 'ESTIMATIVA_MINUTOS': estimativaMinutos,
    });
  }

  TaxaEntregasCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? nome,
      Value<double>? valor,
      Value<int>? estimativaMinutos,
	  }) {
    return TaxaEntregasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      valor: valor ?? this.valor,
      estimativaMinutos: estimativaMinutos ?? this.estimativaMinutos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (nome.present) {
      map['NOME'] = Variable<String?>(nome.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    if (estimativaMinutos.present) {
      map['ESTIMATIVA_MINUTOS'] = Variable<int?>(estimativaMinutos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxaEntregasCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('valor: $valor, ')
          ..write('estimativaMinutos: $estimativaMinutos, ')
          ..write(')'))
        .toString();
  }
}

class $TaxaEntregasTable extends TaxaEntregas
    with TableInfo<$TaxaEntregasTable, TaxaEntrega> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TaxaEntregasTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _nomeMeta =
      const VerificationMeta('nome');
  GeneratedColumn<String>? _nome;
  @override
  GeneratedColumn<String> get nome => _nome ??=
      GeneratedColumn<String>('NOME', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorMeta =
      const VerificationMeta('valor');
  GeneratedColumn<double>? _valor;
  @override
  GeneratedColumn<double> get valor => _valor ??=
      GeneratedColumn<double>('VALOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _estimativaMinutosMeta =
      const VerificationMeta('estimativaMinutos');
  GeneratedColumn<int>? _estimativaMinutos;
  @override
  GeneratedColumn<int> get estimativaMinutos => _estimativaMinutos ??=
      GeneratedColumn<int>('ESTIMATIVA_MINUTOS', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        valor,
        estimativaMinutos,
      ];

  @override
  String get aliasedName => _alias ?? 'TAXA_ENTREGA';
  
  @override
  String get actualTableName => 'TAXA_ENTREGA';
  
  @override
  VerificationContext validateIntegrity(Insertable<TaxaEntrega> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('NOME')) {
        context.handle(_nomeMeta,
            nome.isAcceptableOrUnknown(data['NOME']!, _nomeMeta));
    }
    if (data.containsKey('VALOR')) {
        context.handle(_valorMeta,
            valor.isAcceptableOrUnknown(data['VALOR']!, _valorMeta));
    }
    if (data.containsKey('ESTIMATIVA_MINUTOS')) {
        context.handle(_estimativaMinutosMeta,
            estimativaMinutos.isAcceptableOrUnknown(data['ESTIMATIVA_MINUTOS']!, _estimativaMinutosMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaxaEntrega map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TaxaEntrega.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TaxaEntregasTable createAlias(String alias) {
    return $TaxaEntregasTable(_db, alias);
  }
}