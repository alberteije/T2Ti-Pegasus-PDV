/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [TRIBUT_OPERACAO_FISCAL] 
                                                                                
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

@DataClassName("TributOperacaoFiscal")
@UseRowClass(TributOperacaoFiscal)
class TributOperacaoFiscals extends Table {
  @override
  String get tableName => 'TRIBUT_OPERACAO_FISCAL';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 100).nullable()();
  TextColumn get descricaoNaNf => text().named('DESCRICAO_NA_NF').withLength(min: 0, max: 100).nullable()();
  IntColumn get cfop => integer().named('CFOP').nullable()();
  TextColumn get observacao => text().named('OBSERVACAO').withLength(min: 0, max: 250).nullable()();
}

class TributOperacaoFiscal extends DataClass implements Insertable<TributOperacaoFiscal> {
  final int? id;
  final String? descricao;
  final String? descricaoNaNf;
  final int? cfop;
  final String? observacao;

  TributOperacaoFiscal(
    {
      required this.id,
      this.descricao,
      this.descricaoNaNf,
      this.cfop,
      this.observacao,
    }
  );

  factory TributOperacaoFiscal.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TributOperacaoFiscal(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
      descricaoNaNf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO_NA_NF']),
      cfop: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CFOP']),
      observacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}OBSERVACAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    if (!nullToAbsent || descricaoNaNf != null) {
      map['DESCRICAO_NA_NF'] = Variable<String?>(descricaoNaNf);
    }
    if (!nullToAbsent || cfop != null) {
      map['CFOP'] = Variable<int?>(cfop);
    }
    if (!nullToAbsent || observacao != null) {
      map['OBSERVACAO'] = Variable<String?>(observacao);
    }
    return map;
  }

  TributOperacaoFiscalsCompanion toCompanion(bool nullToAbsent) {
    return TributOperacaoFiscalsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
      descricaoNaNf: descricaoNaNf == null && nullToAbsent
        ? const Value.absent()
        : Value(descricaoNaNf),
      cfop: cfop == null && nullToAbsent
        ? const Value.absent()
        : Value(cfop),
      observacao: observacao == null && nullToAbsent
        ? const Value.absent()
        : Value(observacao),
    );
  }

  factory TributOperacaoFiscal.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TributOperacaoFiscal(
      id: serializer.fromJson<int>(json['id']),
      descricao: serializer.fromJson<String>(json['descricao']),
      descricaoNaNf: serializer.fromJson<String>(json['descricaoNaNf']),
      cfop: serializer.fromJson<int>(json['cfop']),
      observacao: serializer.fromJson<String>(json['observacao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'descricao': serializer.toJson<String?>(descricao),
      'descricaoNaNf': serializer.toJson<String?>(descricaoNaNf),
      'cfop': serializer.toJson<int?>(cfop),
      'observacao': serializer.toJson<String?>(observacao),
    };
  }

  TributOperacaoFiscal copyWith(
        {
		  int? id,
          String? descricao,
          String? descricaoNaNf,
          int? cfop,
          String? observacao,
		}) =>
      TributOperacaoFiscal(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
        descricaoNaNf: descricaoNaNf ?? this.descricaoNaNf,
        cfop: cfop ?? this.cfop,
        observacao: observacao ?? this.observacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('TributOperacaoFiscal(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('descricaoNaNf: $descricaoNaNf, ')
          ..write('cfop: $cfop, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      descricao,
      descricaoNaNf,
      cfop,
      observacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TributOperacaoFiscal &&
          other.id == id &&
          other.descricao == descricao &&
          other.descricaoNaNf == descricaoNaNf &&
          other.cfop == cfop &&
          other.observacao == observacao 
	   );
}

class TributOperacaoFiscalsCompanion extends UpdateCompanion<TributOperacaoFiscal> {

  final Value<int?> id;
  final Value<String?> descricao;
  final Value<String?> descricaoNaNf;
  final Value<int?> cfop;
  final Value<String?> observacao;

  const TributOperacaoFiscalsCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.descricaoNaNf = const Value.absent(),
    this.cfop = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  TributOperacaoFiscalsCompanion.insert({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.descricaoNaNf = const Value.absent(),
    this.cfop = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  static Insertable<TributOperacaoFiscal> custom({
    Expression<int>? id,
    Expression<String>? descricao,
    Expression<String>? descricaoNaNf,
    Expression<int>? cfop,
    Expression<String>? observacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (descricao != null) 'DESCRICAO': descricao,
      if (descricaoNaNf != null) 'DESCRICAO_NA_NF': descricaoNaNf,
      if (cfop != null) 'CFOP': cfop,
      if (observacao != null) 'OBSERVACAO': observacao,
    });
  }

  TributOperacaoFiscalsCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? descricao,
      Value<String>? descricaoNaNf,
      Value<int>? cfop,
      Value<String>? observacao,
	  }) {
    return TributOperacaoFiscalsCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      descricaoNaNf: descricaoNaNf ?? this.descricaoNaNf,
      cfop: cfop ?? this.cfop,
      observacao: observacao ?? this.observacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    if (descricaoNaNf.present) {
      map['DESCRICAO_NA_NF'] = Variable<String?>(descricaoNaNf.value);
    }
    if (cfop.present) {
      map['CFOP'] = Variable<int?>(cfop.value);
    }
    if (observacao.present) {
      map['OBSERVACAO'] = Variable<String?>(observacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TributOperacaoFiscalsCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('descricaoNaNf: $descricaoNaNf, ')
          ..write('cfop: $cfop, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }
}

class $TributOperacaoFiscalsTable extends TributOperacaoFiscals
    with TableInfo<$TributOperacaoFiscalsTable, TributOperacaoFiscal> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TributOperacaoFiscalsTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  GeneratedColumn<String>? _descricao;
  @override
  GeneratedColumn<String> get descricao => _descricao ??=
      GeneratedColumn<String>('DESCRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _descricaoNaNfMeta =
      const VerificationMeta('descricaoNaNf');
  GeneratedColumn<String>? _descricaoNaNf;
  @override
  GeneratedColumn<String> get descricaoNaNf => _descricaoNaNf ??=
      GeneratedColumn<String>('DESCRICAO_NA_NF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cfopMeta =
      const VerificationMeta('cfop');
  GeneratedColumn<int>? _cfop;
  @override
  GeneratedColumn<int> get cfop => _cfop ??=
      GeneratedColumn<int>('CFOP', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
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
        descricao,
        descricaoNaNf,
        cfop,
        observacao,
      ];

  @override
  String get aliasedName => _alias ?? 'TRIBUT_OPERACAO_FISCAL';
  
  @override
  String get actualTableName => 'TRIBUT_OPERACAO_FISCAL';
  
  @override
  VerificationContext validateIntegrity(Insertable<TributOperacaoFiscal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('DESCRICAO')) {
        context.handle(_descricaoMeta,
            descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
    }
    if (data.containsKey('DESCRICAO_NA_NF')) {
        context.handle(_descricaoNaNfMeta,
            descricaoNaNf.isAcceptableOrUnknown(data['DESCRICAO_NA_NF']!, _descricaoNaNfMeta));
    }
    if (data.containsKey('CFOP')) {
        context.handle(_cfopMeta,
            cfop.isAcceptableOrUnknown(data['CFOP']!, _cfopMeta));
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
  TributOperacaoFiscal map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TributOperacaoFiscal.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TributOperacaoFiscalsTable createAlias(String alias) {
    return $TributOperacaoFiscalsTable(_db, alias);
  }
}