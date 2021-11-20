/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_CAIXA] 
                                                                                
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

@DataClassName("PdvCaixa")
@UseRowClass(PdvCaixa)
class PdvCaixas extends Table {
  @override
  String get tableName => 'PDV_CAIXA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get nome => text().named('NOME').withLength(min: 0, max: 30).nullable()();
  DateTimeColumn get dataCadastro => dateTime().named('DATA_CADASTRO').nullable()();
}

class PdvCaixa extends DataClass implements Insertable<PdvCaixa> {
  final int? id;
  final String? nome;
  final DateTime? dataCadastro;

  PdvCaixa(
    {
      required this.id,
      this.nome,
      this.dataCadastro,
    }
  );

  factory PdvCaixa.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PdvCaixa(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      nome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME']),
      dataCadastro: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_CADASTRO']),
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
    if (!nullToAbsent || dataCadastro != null) {
      map['DATA_CADASTRO'] = Variable<DateTime?>(dataCadastro);
    }
    return map;
  }

  PdvCaixasCompanion toCompanion(bool nullToAbsent) {
    return PdvCaixasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent
        ? const Value.absent()
        : Value(nome),
      dataCadastro: dataCadastro == null && nullToAbsent
        ? const Value.absent()
        : Value(dataCadastro),
    );
  }

  factory PdvCaixa.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvCaixa(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      dataCadastro: serializer.fromJson<DateTime>(json['dataCadastro']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'nome': serializer.toJson<String?>(nome),
      'dataCadastro': serializer.toJson<DateTime?>(dataCadastro),
    };
  }

  PdvCaixa copyWith(
        {
		  int? id,
          String? nome,
          DateTime? dataCadastro,
		}) =>
      PdvCaixa(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        dataCadastro: dataCadastro ?? this.dataCadastro,
      );
  
  @override
  String toString() {
    return (StringBuffer('PdvCaixa(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('dataCadastro: $dataCadastro, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      nome,
      dataCadastro,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdvCaixa &&
          other.id == id &&
          other.nome == nome &&
          other.dataCadastro == dataCadastro 
	   );
}

class PdvCaixasCompanion extends UpdateCompanion<PdvCaixa> {

  final Value<int?> id;
  final Value<String?> nome;
  final Value<DateTime?> dataCadastro;

  const PdvCaixasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.dataCadastro = const Value.absent(),
  });

  PdvCaixasCompanion.insert({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.dataCadastro = const Value.absent(),
  });

  static Insertable<PdvCaixa> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<DateTime>? dataCadastro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (nome != null) 'NOME': nome,
      if (dataCadastro != null) 'DATA_CADASTRO': dataCadastro,
    });
  }

  PdvCaixasCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? nome,
      Value<DateTime>? dataCadastro,
	  }) {
    return PdvCaixasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      dataCadastro: dataCadastro ?? this.dataCadastro,
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
    if (dataCadastro.present) {
      map['DATA_CADASTRO'] = Variable<DateTime?>(dataCadastro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdvCaixasCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('dataCadastro: $dataCadastro, ')
          ..write(')'))
        .toString();
  }
}

class $PdvCaixasTable extends PdvCaixas
    with TableInfo<$PdvCaixasTable, PdvCaixa> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PdvCaixasTable(this._db, [this._alias]);
  
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
  final VerificationMeta _dataCadastroMeta =
      const VerificationMeta('dataCadastro');
  GeneratedColumn<DateTime>? _dataCadastro;
  @override
  GeneratedColumn<DateTime> get dataCadastro => _dataCadastro ??=
      GeneratedColumn<DateTime>('DATA_CADASTRO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        dataCadastro,
      ];

  @override
  String get aliasedName => _alias ?? 'PDV_CAIXA';
  
  @override
  String get actualTableName => 'PDV_CAIXA';
  
  @override
  VerificationContext validateIntegrity(Insertable<PdvCaixa> instance,
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
    if (data.containsKey('DATA_CADASTRO')) {
        context.handle(_dataCadastroMeta,
            dataCadastro.isAcceptableOrUnknown(data['DATA_CADASTRO']!, _dataCadastroMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdvCaixa map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PdvCaixa.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PdvCaixasTable createAlias(String alias) {
    return $PdvCaixasTable(_db, alias);
  }
}