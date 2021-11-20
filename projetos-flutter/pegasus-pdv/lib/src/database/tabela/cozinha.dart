/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [COZINHA] 
                                                                                
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

@DataClassName("Cozinha")
@UseRowClass(Cozinha)
class Cozinhas extends Table {
  @override
  String get tableName => 'COZINHA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get nome => text().named('NOME').withLength(min: 0, max: 100).nullable()();
  TextColumn get impressoraNome => text().named('IMPRESSORA_NOME').withLength(min: 0, max: 100).nullable()();
  TextColumn get impressoraEndereco => text().named('IMPRESSORA_ENDERECO').withLength(min: 0, max: 250).nullable()();
}

class Cozinha extends DataClass implements Insertable<Cozinha> {
  final int? id;
  final String? nome;
  final String? impressoraNome;
  final String? impressoraEndereco;

  Cozinha(
    {
      required this.id,
      this.nome,
      this.impressoraNome,
      this.impressoraEndereco,
    }
  );

  factory Cozinha.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Cozinha(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      nome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME']),
      impressoraNome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}IMPRESSORA_NOME']),
      impressoraEndereco: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}IMPRESSORA_ENDERECO']),
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
    if (!nullToAbsent || impressoraNome != null) {
      map['IMPRESSORA_NOME'] = Variable<String?>(impressoraNome);
    }
    if (!nullToAbsent || impressoraEndereco != null) {
      map['IMPRESSORA_ENDERECO'] = Variable<String?>(impressoraEndereco);
    }
    return map;
  }

  CozinhasCompanion toCompanion(bool nullToAbsent) {
    return CozinhasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent
        ? const Value.absent()
        : Value(nome),
      impressoraNome: impressoraNome == null && nullToAbsent
        ? const Value.absent()
        : Value(impressoraNome),
      impressoraEndereco: impressoraEndereco == null && nullToAbsent
        ? const Value.absent()
        : Value(impressoraEndereco),
    );
  }

  factory Cozinha.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Cozinha(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      impressoraNome: serializer.fromJson<String>(json['impressoraNome']),
      impressoraEndereco: serializer.fromJson<String>(json['impressoraEndereco']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'nome': serializer.toJson<String?>(nome),
      'impressoraNome': serializer.toJson<String?>(impressoraNome),
      'impressoraEndereco': serializer.toJson<String?>(impressoraEndereco),
    };
  }

  Cozinha copyWith(
        {
		  int? id,
          String? nome,
          String? impressoraNome,
          String? impressoraEndereco,
		}) =>
      Cozinha(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        impressoraNome: impressoraNome ?? this.impressoraNome,
        impressoraEndereco: impressoraEndereco ?? this.impressoraEndereco,
      );
  
  @override
  String toString() {
    return (StringBuffer('Cozinha(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('impressoraNome: $impressoraNome, ')
          ..write('impressoraEndereco: $impressoraEndereco, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      nome,
      impressoraNome,
      impressoraEndereco,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cozinha &&
          other.id == id &&
          other.nome == nome &&
          other.impressoraNome == impressoraNome &&
          other.impressoraEndereco == impressoraEndereco 
	   );
}

class CozinhasCompanion extends UpdateCompanion<Cozinha> {

  final Value<int?> id;
  final Value<String?> nome;
  final Value<String?> impressoraNome;
  final Value<String?> impressoraEndereco;

  const CozinhasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.impressoraNome = const Value.absent(),
    this.impressoraEndereco = const Value.absent(),
  });

  CozinhasCompanion.insert({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.impressoraNome = const Value.absent(),
    this.impressoraEndereco = const Value.absent(),
  });

  static Insertable<Cozinha> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? impressoraNome,
    Expression<String>? impressoraEndereco,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (nome != null) 'NOME': nome,
      if (impressoraNome != null) 'IMPRESSORA_NOME': impressoraNome,
      if (impressoraEndereco != null) 'IMPRESSORA_ENDERECO': impressoraEndereco,
    });
  }

  CozinhasCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? nome,
      Value<String>? impressoraNome,
      Value<String>? impressoraEndereco,
	  }) {
    return CozinhasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      impressoraNome: impressoraNome ?? this.impressoraNome,
      impressoraEndereco: impressoraEndereco ?? this.impressoraEndereco,
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
    if (impressoraNome.present) {
      map['IMPRESSORA_NOME'] = Variable<String?>(impressoraNome.value);
    }
    if (impressoraEndereco.present) {
      map['IMPRESSORA_ENDERECO'] = Variable<String?>(impressoraEndereco.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CozinhasCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('impressoraNome: $impressoraNome, ')
          ..write('impressoraEndereco: $impressoraEndereco, ')
          ..write(')'))
        .toString();
  }
}

class $CozinhasTable extends Cozinhas
    with TableInfo<$CozinhasTable, Cozinha> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CozinhasTable(this._db, [this._alias]);
  
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
  final VerificationMeta _impressoraNomeMeta =
      const VerificationMeta('impressoraNome');
  GeneratedColumn<String>? _impressoraNome;
  @override
  GeneratedColumn<String> get impressoraNome => _impressoraNome ??=
      GeneratedColumn<String>('IMPRESSORA_NOME', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _impressoraEnderecoMeta =
      const VerificationMeta('impressoraEndereco');
  GeneratedColumn<String>? _impressoraEndereco;
  @override
  GeneratedColumn<String> get impressoraEndereco => _impressoraEndereco ??=
      GeneratedColumn<String>('IMPRESSORA_ENDERECO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        impressoraNome,
        impressoraEndereco,
      ];

  @override
  String get aliasedName => _alias ?? 'COZINHA';
  
  @override
  String get actualTableName => 'COZINHA';
  
  @override
  VerificationContext validateIntegrity(Insertable<Cozinha> instance,
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
    if (data.containsKey('IMPRESSORA_NOME')) {
        context.handle(_impressoraNomeMeta,
            impressoraNome.isAcceptableOrUnknown(data['IMPRESSORA_NOME']!, _impressoraNomeMeta));
    }
    if (data.containsKey('IMPRESSORA_ENDERECO')) {
        context.handle(_impressoraEnderecoMeta,
            impressoraEndereco.isAcceptableOrUnknown(data['IMPRESSORA_ENDERECO']!, _impressoraEnderecoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cozinha map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Cozinha.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CozinhasTable createAlias(String alias) {
    return $CozinhasTable(_db, alias);
  }
}