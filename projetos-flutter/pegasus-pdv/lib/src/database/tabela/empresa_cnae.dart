/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [EMPRESA_CNAE] 
                                                                                
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

@DataClassName("EmpresaCnae")
@UseRowClass(EmpresaCnae)
class EmpresaCnaes extends Table {
  @override
  String get tableName => 'EMPRESA_CNAE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get codigo => text().named('CODIGO').withLength(min: 0, max: 7).nullable()();
  TextColumn get principal => text().named('PRINCIPAL').withLength(min: 0, max: 1).nullable()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 250).nullable()();
}

class EmpresaCnae extends DataClass implements Insertable<EmpresaCnae> {
  final int? id;
  final String? codigo;
  final String? principal;
  final String? descricao;

  EmpresaCnae(
    {
      required this.id,
      this.codigo,
      this.principal,
      this.descricao,
    }
  );

  factory EmpresaCnae.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EmpresaCnae(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      codigo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO']),
      principal: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PRINCIPAL']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || codigo != null) {
      map['CODIGO'] = Variable<String?>(codigo);
    }
    if (!nullToAbsent || principal != null) {
      map['PRINCIPAL'] = Variable<String?>(principal);
    }
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    return map;
  }

  EmpresaCnaesCompanion toCompanion(bool nullToAbsent) {
    return EmpresaCnaesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      codigo: codigo == null && nullToAbsent
        ? const Value.absent()
        : Value(codigo),
      principal: principal == null && nullToAbsent
        ? const Value.absent()
        : Value(principal),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
    );
  }

  factory EmpresaCnae.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EmpresaCnae(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      principal: serializer.fromJson<String>(json['principal']),
      descricao: serializer.fromJson<String>(json['descricao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'codigo': serializer.toJson<String?>(codigo),
      'principal': serializer.toJson<String?>(principal),
      'descricao': serializer.toJson<String?>(descricao),
    };
  }

  EmpresaCnae copyWith(
        {
		  int? id,
          String? codigo,
          String? principal,
          String? descricao,
		}) =>
      EmpresaCnae(
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        principal: principal ?? this.principal,
        descricao: descricao ?? this.descricao,
      );
  
  @override
  String toString() {
    return (StringBuffer('EmpresaCnae(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('principal: $principal, ')
          ..write('descricao: $descricao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      codigo,
      principal,
      descricao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmpresaCnae &&
          other.id == id &&
          other.codigo == codigo &&
          other.principal == principal &&
          other.descricao == descricao 
	   );
}

class EmpresaCnaesCompanion extends UpdateCompanion<EmpresaCnae> {

  final Value<int?> id;
  final Value<String?> codigo;
  final Value<String?> principal;
  final Value<String?> descricao;

  const EmpresaCnaesCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.principal = const Value.absent(),
    this.descricao = const Value.absent(),
  });

  EmpresaCnaesCompanion.insert({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.principal = const Value.absent(),
    this.descricao = const Value.absent(),
  });

  static Insertable<EmpresaCnae> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? principal,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (codigo != null) 'CODIGO': codigo,
      if (principal != null) 'PRINCIPAL': principal,
      if (descricao != null) 'DESCRICAO': descricao,
    });
  }

  EmpresaCnaesCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? codigo,
      Value<String>? principal,
      Value<String>? descricao,
	  }) {
    return EmpresaCnaesCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      principal: principal ?? this.principal,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (codigo.present) {
      map['CODIGO'] = Variable<String?>(codigo.value);
    }
    if (principal.present) {
      map['PRINCIPAL'] = Variable<String?>(principal.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmpresaCnaesCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('principal: $principal, ')
          ..write('descricao: $descricao, ')
          ..write(')'))
        .toString();
  }
}

class $EmpresaCnaesTable extends EmpresaCnaes
    with TableInfo<$EmpresaCnaesTable, EmpresaCnae> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EmpresaCnaesTable(this._db, [this._alias]);
  
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
  GeneratedColumn<String>? _codigo;
  @override
  GeneratedColumn<String> get codigo => _codigo ??=
      GeneratedColumn<String>('CODIGO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _principalMeta =
      const VerificationMeta('principal');
  GeneratedColumn<String>? _principal;
  @override
  GeneratedColumn<String> get principal => _principal ??=
      GeneratedColumn<String>('PRINCIPAL', aliasedName, true,
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
        codigo,
        principal,
        descricao,
      ];

  @override
  String get aliasedName => _alias ?? 'EMPRESA_CNAE';
  
  @override
  String get actualTableName => 'EMPRESA_CNAE';
  
  @override
  VerificationContext validateIntegrity(Insertable<EmpresaCnae> instance,
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
    if (data.containsKey('PRINCIPAL')) {
        context.handle(_principalMeta,
            principal.isAcceptableOrUnknown(data['PRINCIPAL']!, _principalMeta));
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
  EmpresaCnae map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EmpresaCnae.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EmpresaCnaesTable createAlias(String alias) {
    return $EmpresaCnaesTable(_db, alias);
  }
}