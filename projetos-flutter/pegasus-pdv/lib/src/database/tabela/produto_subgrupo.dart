/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PRODUTO_SUBGRUPO] 
                                                                                
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
import 'package:pegasus_pdv/src/database/database_classes.dart';

@DataClassName("ProdutoSubgrupo")
@UseRowClass(ProdutoSubgrupo)
class ProdutoSubgrupos extends Table {
  @override
  String get tableName => 'PRODUTO_SUBGRUPO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idProdutoGrupo => integer().named('ID_PRODUTO_GRUPO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO_GRUPO(ID)')();
  TextColumn get nome => text().named('NOME').withLength(min: 0, max: 100).nullable()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 250).nullable()();
}

class ProdutoSubgrupoMontado {
  ProdutoSubgrupo? produtoSubgrupo;
  ProdutoGrupo? produtoGrupo;

  ProdutoSubgrupoMontado({
    this.produtoSubgrupo,
    this.produtoGrupo,
  });
}

class ProdutoSubgrupo extends DataClass implements Insertable<ProdutoSubgrupo> {
  final int? id;
  final int? idProdutoGrupo;
  final String? nome;
  final String? descricao;

  ProdutoSubgrupo(
    {
      required this.id,
      this.idProdutoGrupo,
      this.nome,
      this.descricao,
    }
  );

  factory ProdutoSubgrupo.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProdutoSubgrupo(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idProdutoGrupo: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO_GRUPO']),
      nome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idProdutoGrupo != null) {
      map['ID_PRODUTO_GRUPO'] = Variable<int?>(idProdutoGrupo);
    }
    if (!nullToAbsent || nome != null) {
      map['NOME'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    return map;
  }

  ProdutoSubgruposCompanion toCompanion(bool nullToAbsent) {
    return ProdutoSubgruposCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idProdutoGrupo: idProdutoGrupo == null && nullToAbsent
        ? const Value.absent()
        : Value(idProdutoGrupo),
      nome: nome == null && nullToAbsent
        ? const Value.absent()
        : Value(nome),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
    );
  }

  factory ProdutoSubgrupo.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProdutoSubgrupo(
      id: serializer.fromJson<int>(json['id']),
      idProdutoGrupo: serializer.fromJson<int>(json['idProdutoGrupo']),
      nome: serializer.fromJson<String>(json['nome']),
      descricao: serializer.fromJson<String>(json['descricao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idProdutoGrupo': serializer.toJson<int?>(idProdutoGrupo),
      'nome': serializer.toJson<String?>(nome),
      'descricao': serializer.toJson<String?>(descricao),
    };
  }

  ProdutoSubgrupo copyWith(
        {
		  int? id,
          int? idProdutoGrupo,
          String? nome,
          String? descricao,
		}) =>
      ProdutoSubgrupo(
        id: id ?? this.id,
        idProdutoGrupo: idProdutoGrupo ?? this.idProdutoGrupo,
        nome: nome ?? this.nome,
        descricao: descricao ?? this.descricao,
      );
  
  @override
  String toString() {
    return (StringBuffer('ProdutoSubgrupo(')
          ..write('id: $id, ')
          ..write('idProdutoGrupo: $idProdutoGrupo, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idProdutoGrupo,
      nome,
      descricao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdutoSubgrupo &&
          other.id == id &&
          other.idProdutoGrupo == idProdutoGrupo &&
          other.nome == nome &&
          other.descricao == descricao 
	   );
}

class ProdutoSubgruposCompanion extends UpdateCompanion<ProdutoSubgrupo> {

  final Value<int?> id;
  final Value<int?> idProdutoGrupo;
  final Value<String?> nome;
  final Value<String?> descricao;

  const ProdutoSubgruposCompanion({
    this.id = const Value.absent(),
    this.idProdutoGrupo = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
  });

  ProdutoSubgruposCompanion.insert({
    this.id = const Value.absent(),
    this.idProdutoGrupo = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
  });

  static Insertable<ProdutoSubgrupo> custom({
    Expression<int>? id,
    Expression<int>? idProdutoGrupo,
    Expression<String>? nome,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idProdutoGrupo != null) 'ID_PRODUTO_GRUPO': idProdutoGrupo,
      if (nome != null) 'NOME': nome,
      if (descricao != null) 'DESCRICAO': descricao,
    });
  }

  ProdutoSubgruposCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idProdutoGrupo,
      Value<String>? nome,
      Value<String>? descricao,
	  }) {
    return ProdutoSubgruposCompanion(
      id: id ?? this.id,
      idProdutoGrupo: idProdutoGrupo ?? this.idProdutoGrupo,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idProdutoGrupo.present) {
      map['ID_PRODUTO_GRUPO'] = Variable<int?>(idProdutoGrupo.value);
    }
    if (nome.present) {
      map['NOME'] = Variable<String?>(nome.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutoSubgruposCompanion(')
          ..write('id: $id, ')
          ..write('idProdutoGrupo: $idProdutoGrupo, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write(')'))
        .toString();
  }
}

class $ProdutoSubgruposTable extends ProdutoSubgrupos
    with TableInfo<$ProdutoSubgruposTable, ProdutoSubgrupo> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProdutoSubgruposTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idProdutoGrupoMeta =
      const VerificationMeta('idProdutoGrupo');
  GeneratedColumn<int>? _idProdutoGrupo;
  @override
  GeneratedColumn<int> get idProdutoGrupo =>
      _idProdutoGrupo ??= GeneratedColumn<int>('ID_PRODUTO_GRUPO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PRODUTO_GRUPO(ID)');
  final VerificationMeta _nomeMeta =
      const VerificationMeta('nome');
  GeneratedColumn<String>? _nome;
  @override
  GeneratedColumn<String> get nome => _nome ??=
      GeneratedColumn<String>('NOME', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  GeneratedColumn<String>? _descricao;
  @override
  GeneratedColumn<String> get descricao => _descricao ??=
      GeneratedColumn<String>('DESCRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idProdutoGrupo,
        nome,
        descricao,
      ];

  @override
  String get aliasedName => _alias ?? 'PRODUTO_SUBGRUPO';
  
  @override
  String get actualTableName => 'PRODUTO_SUBGRUPO';
  
  @override
  VerificationContext validateIntegrity(Insertable<ProdutoSubgrupo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_PRODUTO_GRUPO')) {
        context.handle(_idProdutoGrupoMeta,
            idProdutoGrupo.isAcceptableOrUnknown(data['ID_PRODUTO_GRUPO']!, _idProdutoGrupoMeta));
    }
    if (data.containsKey('NOME')) {
        context.handle(_nomeMeta,
            nome.isAcceptableOrUnknown(data['NOME']!, _nomeMeta));
    }
    if (data.containsKey('DESCRICAO')) {
        context.handle(_descricaoMeta,
            descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProdutoSubgrupo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProdutoSubgrupo.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProdutoSubgruposTable createAlias(String alias) {
    return $ProdutoSubgruposTable(_db, alias);
  }
}