/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [EMPRESA_SEGMENTO] 
                                                                                
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

@DataClassName("EmpresaSegmento")
@UseRowClass(EmpresaSegmento)
class EmpresaSegmentos extends Table {
  @override
  String get tableName => 'EMPRESA_SEGMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get nome => text().named('NOME').withLength(min: 0, max: 100).nullable()();
}

class EmpresaSegmento extends DataClass implements Insertable<EmpresaSegmento> {
  final int? id;
  final String? nome;

  EmpresaSegmento(
    {
      required this.id,
      this.nome,
    }
  );

  factory EmpresaSegmento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EmpresaSegmento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      nome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME']),
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
    return map;
  }

  EmpresaSegmentosCompanion toCompanion(bool nullToAbsent) {
    return EmpresaSegmentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent
        ? const Value.absent()
        : Value(nome),
    );
  }

  factory EmpresaSegmento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EmpresaSegmento(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'nome': serializer.toJson<String?>(nome),
    };
  }

  EmpresaSegmento copyWith(
        {
		  int? id,
          String? nome,
		}) =>
      EmpresaSegmento(
        id: id ?? this.id,
        nome: nome ?? this.nome,
      );
  
  @override
  String toString() {
    return (StringBuffer('EmpresaSegmento(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      nome,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmpresaSegmento &&
          other.id == id &&
          other.nome == nome 
	   );
}

class EmpresaSegmentosCompanion extends UpdateCompanion<EmpresaSegmento> {

  final Value<int?> id;
  final Value<String?> nome;

  const EmpresaSegmentosCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
  });

  EmpresaSegmentosCompanion.insert({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
  });

  static Insertable<EmpresaSegmento> custom({
    Expression<int>? id,
    Expression<String>? nome,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (nome != null) 'NOME': nome,
    });
  }

  EmpresaSegmentosCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? nome,
	  }) {
    return EmpresaSegmentosCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmpresaSegmentosCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write(')'))
        .toString();
  }
}

class $EmpresaSegmentosTable extends EmpresaSegmentos
    with TableInfo<$EmpresaSegmentosTable, EmpresaSegmento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EmpresaSegmentosTable(this._db, [this._alias]);
  
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
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
      ];

  @override
  String get aliasedName => _alias ?? 'EMPRESA_SEGMENTO';
  
  @override
  String get actualTableName => 'EMPRESA_SEGMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<EmpresaSegmento> instance,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmpresaSegmento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EmpresaSegmento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EmpresaSegmentosTable createAlias(String alias) {
    return $EmpresaSegmentosTable(_db, alias);
  }
}