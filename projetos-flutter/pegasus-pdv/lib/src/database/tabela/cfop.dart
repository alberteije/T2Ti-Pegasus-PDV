/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [CFOP] 
                                                                                
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

@DataClassName("Cfop")
@UseRowClass(Cfop)
class Cfops extends Table {
  @override
  String get tableName => 'CFOP';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get codigo => integer().named('CODIGO').nullable()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 250).nullable()();
  TextColumn get aplicacao => text().named('APLICACAO').withLength(min: 0, max: 250).nullable()();
}

class Cfop extends DataClass implements Insertable<Cfop> {
  final int? id;
  final int? codigo;
  final String? descricao;
  final String? aplicacao;

  Cfop(
    {
      required this.id,
      this.codigo,
      this.descricao,
      this.aplicacao,
    }
  );

  factory Cfop.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Cfop(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      codigo: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
      aplicacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}APLICACAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || codigo != null) {
      map['CODIGO'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    if (!nullToAbsent || aplicacao != null) {
      map['APLICACAO'] = Variable<String?>(aplicacao);
    }
    return map;
  }

  CfopsCompanion toCompanion(bool nullToAbsent) {
    return CfopsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      codigo: codigo == null && nullToAbsent
        ? const Value.absent()
        : Value(codigo),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
      aplicacao: aplicacao == null && nullToAbsent
        ? const Value.absent()
        : Value(aplicacao),
    );
  }

  factory Cfop.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Cfop(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<int>(json['codigo']),
      descricao: serializer.fromJson<String>(json['descricao']),
      aplicacao: serializer.fromJson<String>(json['aplicacao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'codigo': serializer.toJson<int?>(codigo),
      'descricao': serializer.toJson<String?>(descricao),
      'aplicacao': serializer.toJson<String?>(aplicacao),
    };
  }

  Cfop copyWith(
        {
		  int? id,
          int? codigo,
          String? descricao,
          String? aplicacao,
		}) =>
      Cfop(
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        descricao: descricao ?? this.descricao,
        aplicacao: aplicacao ?? this.aplicacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('Cfop(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao, ')
          ..write('aplicacao: $aplicacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      codigo,
      descricao,
      aplicacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cfop &&
          other.id == id &&
          other.codigo == codigo &&
          other.descricao == descricao &&
          other.aplicacao == aplicacao 
	   );
}

class CfopsCompanion extends UpdateCompanion<Cfop> {

  final Value<int?> id;
  final Value<int?> codigo;
  final Value<String?> descricao;
  final Value<String?> aplicacao;

  const CfopsCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.aplicacao = const Value.absent(),
  });

  CfopsCompanion.insert({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.aplicacao = const Value.absent(),
  });

  static Insertable<Cfop> custom({
    Expression<int>? id,
    Expression<int>? codigo,
    Expression<String>? descricao,
    Expression<String>? aplicacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (codigo != null) 'CODIGO': codigo,
      if (descricao != null) 'DESCRICAO': descricao,
      if (aplicacao != null) 'APLICACAO': aplicacao,
    });
  }

  CfopsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? codigo,
      Value<String>? descricao,
      Value<String>? aplicacao,
	  }) {
    return CfopsCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      aplicacao: aplicacao ?? this.aplicacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (codigo.present) {
      map['CODIGO'] = Variable<int?>(codigo.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    if (aplicacao.present) {
      map['APLICACAO'] = Variable<String?>(aplicacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CfopsCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao, ')
          ..write('aplicacao: $aplicacao, ')
          ..write(')'))
        .toString();
  }
}

class $CfopsTable extends Cfops
    with TableInfo<$CfopsTable, Cfop> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CfopsTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _codigoMeta =
      const VerificationMeta('codigo');
  GeneratedColumn<int>? _codigo;
  @override
  GeneratedColumn<int> get codigo => _codigo ??=
      GeneratedColumn<int>('CODIGO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  GeneratedColumn<String>? _descricao;
  @override
  GeneratedColumn<String> get descricao => _descricao ??=
      GeneratedColumn<String>('DESCRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _aplicacaoMeta =
      const VerificationMeta('aplicacao');
  GeneratedColumn<String>? _aplicacao;
  @override
  GeneratedColumn<String> get aplicacao => _aplicacao ??=
      GeneratedColumn<String>('APLICACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        codigo,
        descricao,
        aplicacao,
      ];

  @override
  String get aliasedName => _alias ?? 'CFOP';
  
  @override
  String get actualTableName => 'CFOP';
  
  @override
  VerificationContext validateIntegrity(Insertable<Cfop> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('CODIGO')) {
        context.handle(_codigoMeta,
            codigo.isAcceptableOrUnknown(data['CODIGO']!, _codigoMeta));
    }
    if (data.containsKey('DESCRICAO')) {
        context.handle(_descricaoMeta,
            descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
    }
    if (data.containsKey('APLICACAO')) {
        context.handle(_aplicacaoMeta,
            aplicacao.isAcceptableOrUnknown(data['APLICACAO']!, _aplicacaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cfop map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Cfop.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CfopsTable createAlias(String alias) {
    return $CfopsTable(_db, alias);
  }
}