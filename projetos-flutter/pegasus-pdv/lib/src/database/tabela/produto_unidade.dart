/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PRODUTO_UNIDADE] 
                                                                                
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

@DataClassName("ProdutoUnidade")
@UseRowClass(ProdutoUnidade)
class ProdutoUnidades extends Table {
  @override
  String get tableName => 'PRODUTO_UNIDADE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get sigla => text().named('SIGLA').withLength(min: 0, max: 10).nullable()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 250).nullable()();
  TextColumn get podeFracionar => text().named('PODE_FRACIONAR').withLength(min: 0, max: 1).nullable()();
}

class ProdutoUnidade extends DataClass implements Insertable<ProdutoUnidade> {
  final int? id;
  final String? sigla;
  final String? descricao;
  final String? podeFracionar;

  ProdutoUnidade(
    {
      required this.id,
      this.sigla,
      this.descricao,
      this.podeFracionar,
    }
  );

  factory ProdutoUnidade.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProdutoUnidade(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      sigla: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SIGLA']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
      podeFracionar: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PODE_FRACIONAR']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || sigla != null) {
      map['SIGLA'] = Variable<String?>(sigla);
    }
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    if (!nullToAbsent || podeFracionar != null) {
      map['PODE_FRACIONAR'] = Variable<String?>(podeFracionar);
    }
    return map;
  }

  ProdutoUnidadesCompanion toCompanion(bool nullToAbsent) {
    return ProdutoUnidadesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      sigla: sigla == null && nullToAbsent
        ? const Value.absent()
        : Value(sigla),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
      podeFracionar: podeFracionar == null && nullToAbsent
        ? const Value.absent()
        : Value(podeFracionar),
    );
  }

  factory ProdutoUnidade.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProdutoUnidade(
      id: serializer.fromJson<int>(json['id']),
      sigla: serializer.fromJson<String>(json['sigla']),
      descricao: serializer.fromJson<String>(json['descricao']),
      podeFracionar: serializer.fromJson<String>(json['podeFracionar']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'sigla': serializer.toJson<String?>(sigla),
      'descricao': serializer.toJson<String?>(descricao),
      'podeFracionar': serializer.toJson<String?>(podeFracionar),
    };
  }

  ProdutoUnidade copyWith(
        {
		  int? id,
          String? sigla,
          String? descricao,
          String? podeFracionar,
		}) =>
      ProdutoUnidade(
        id: id ?? this.id,
        sigla: sigla ?? this.sigla,
        descricao: descricao ?? this.descricao,
        podeFracionar: podeFracionar ?? this.podeFracionar,
      );
  
  @override
  String toString() {
    return (StringBuffer('ProdutoUnidade(')
          ..write('id: $id, ')
          ..write('sigla: $sigla, ')
          ..write('descricao: $descricao, ')
          ..write('podeFracionar: $podeFracionar, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      sigla,
      descricao,
      podeFracionar,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdutoUnidade &&
          other.id == id &&
          other.sigla == sigla &&
          other.descricao == descricao &&
          other.podeFracionar == podeFracionar 
	   );
}

class ProdutoUnidadesCompanion extends UpdateCompanion<ProdutoUnidade> {

  final Value<int?> id;
  final Value<String?> sigla;
  final Value<String?> descricao;
  final Value<String?> podeFracionar;

  const ProdutoUnidadesCompanion({
    this.id = const Value.absent(),
    this.sigla = const Value.absent(),
    this.descricao = const Value.absent(),
    this.podeFracionar = const Value.absent(),
  });

  ProdutoUnidadesCompanion.insert({
    this.id = const Value.absent(),
    this.sigla = const Value.absent(),
    this.descricao = const Value.absent(),
    this.podeFracionar = const Value.absent(),
  });

  static Insertable<ProdutoUnidade> custom({
    Expression<int>? id,
    Expression<String>? sigla,
    Expression<String>? descricao,
    Expression<String>? podeFracionar,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (sigla != null) 'SIGLA': sigla,
      if (descricao != null) 'DESCRICAO': descricao,
      if (podeFracionar != null) 'PODE_FRACIONAR': podeFracionar,
    });
  }

  ProdutoUnidadesCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? sigla,
      Value<String>? descricao,
      Value<String>? podeFracionar,
	  }) {
    return ProdutoUnidadesCompanion(
      id: id ?? this.id,
      sigla: sigla ?? this.sigla,
      descricao: descricao ?? this.descricao,
      podeFracionar: podeFracionar ?? this.podeFracionar,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (sigla.present) {
      map['SIGLA'] = Variable<String?>(sigla.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    if (podeFracionar.present) {
      map['PODE_FRACIONAR'] = Variable<String?>(podeFracionar.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutoUnidadesCompanion(')
          ..write('id: $id, ')
          ..write('sigla: $sigla, ')
          ..write('descricao: $descricao, ')
          ..write('podeFracionar: $podeFracionar, ')
          ..write(')'))
        .toString();
  }
}

class $ProdutoUnidadesTable extends ProdutoUnidades
    with TableInfo<$ProdutoUnidadesTable, ProdutoUnidade> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProdutoUnidadesTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _siglaMeta =
      const VerificationMeta('sigla');
  GeneratedColumn<String>? _sigla;
  @override
  GeneratedColumn<String> get sigla => _sigla ??=
      GeneratedColumn<String>('SIGLA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  GeneratedColumn<String>? _descricao;
  @override
  GeneratedColumn<String> get descricao => _descricao ??=
      GeneratedColumn<String>('DESCRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _podeFracionarMeta =
      const VerificationMeta('podeFracionar');
  GeneratedColumn<String>? _podeFracionar;
  @override
  GeneratedColumn<String> get podeFracionar => _podeFracionar ??=
      GeneratedColumn<String>('PODE_FRACIONAR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sigla,
        descricao,
        podeFracionar,
      ];

  @override
  String get aliasedName => _alias ?? 'PRODUTO_UNIDADE';
  
  @override
  String get actualTableName => 'PRODUTO_UNIDADE';
  
  @override
  VerificationContext validateIntegrity(Insertable<ProdutoUnidade> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('SIGLA')) {
        context.handle(_siglaMeta,
            sigla.isAcceptableOrUnknown(data['SIGLA']!, _siglaMeta));
    }
    if (data.containsKey('DESCRICAO')) {
        context.handle(_descricaoMeta,
            descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
    }
    if (data.containsKey('PODE_FRACIONAR')) {
        context.handle(_podeFracionarMeta,
            podeFracionar.isAcceptableOrUnknown(data['PODE_FRACIONAR']!, _podeFracionarMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProdutoUnidade map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProdutoUnidade.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProdutoUnidadesTable createAlias(String alias) {
    return $ProdutoUnidadesTable(_db, alias);
  }
}