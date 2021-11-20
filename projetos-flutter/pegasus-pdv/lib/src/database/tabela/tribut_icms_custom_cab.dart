/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [TRIBUT_ICMS_CUSTOM_CAB] 
                                                                                
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

@DataClassName("TributIcmsCustomCab")
@UseRowClass(TributIcmsCustomCab)
class TributIcmsCustomCabs extends Table {
  @override
  String get tableName => 'TRIBUT_ICMS_CUSTOM_CAB';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 100).nullable()();
  TextColumn get origemMercadoria => text().named('ORIGEM_MERCADORIA').withLength(min: 0, max: 1).nullable()();
}

class TributIcmsCustomCab extends DataClass implements Insertable<TributIcmsCustomCab> {
  final int? id;
  final String? descricao;
  final String? origemMercadoria;

  TributIcmsCustomCab(
    {
      required this.id,
      this.descricao,
      this.origemMercadoria,
    }
  );

  factory TributIcmsCustomCab.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TributIcmsCustomCab(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
      origemMercadoria: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ORIGEM_MERCADORIA']),
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
    if (!nullToAbsent || origemMercadoria != null) {
      map['ORIGEM_MERCADORIA'] = Variable<String?>(origemMercadoria);
    }
    return map;
  }

  TributIcmsCustomCabsCompanion toCompanion(bool nullToAbsent) {
    return TributIcmsCustomCabsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
      origemMercadoria: origemMercadoria == null && nullToAbsent
        ? const Value.absent()
        : Value(origemMercadoria),
    );
  }

  factory TributIcmsCustomCab.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TributIcmsCustomCab(
      id: serializer.fromJson<int>(json['id']),
      descricao: serializer.fromJson<String>(json['descricao']),
      origemMercadoria: serializer.fromJson<String>(json['origemMercadoria']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'descricao': serializer.toJson<String?>(descricao),
      'origemMercadoria': serializer.toJson<String?>(origemMercadoria),
    };
  }

  TributIcmsCustomCab copyWith(
        {
		  int? id,
          String? descricao,
          String? origemMercadoria,
		}) =>
      TributIcmsCustomCab(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
        origemMercadoria: origemMercadoria ?? this.origemMercadoria,
      );
  
  @override
  String toString() {
    return (StringBuffer('TributIcmsCustomCab(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('origemMercadoria: $origemMercadoria, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      descricao,
      origemMercadoria,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TributIcmsCustomCab &&
          other.id == id &&
          other.descricao == descricao &&
          other.origemMercadoria == origemMercadoria 
	   );
}

class TributIcmsCustomCabsCompanion extends UpdateCompanion<TributIcmsCustomCab> {

  final Value<int?> id;
  final Value<String?> descricao;
  final Value<String?> origemMercadoria;

  const TributIcmsCustomCabsCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.origemMercadoria = const Value.absent(),
  });

  TributIcmsCustomCabsCompanion.insert({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.origemMercadoria = const Value.absent(),
  });

  static Insertable<TributIcmsCustomCab> custom({
    Expression<int>? id,
    Expression<String>? descricao,
    Expression<String>? origemMercadoria,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (descricao != null) 'DESCRICAO': descricao,
      if (origemMercadoria != null) 'ORIGEM_MERCADORIA': origemMercadoria,
    });
  }

  TributIcmsCustomCabsCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? descricao,
      Value<String>? origemMercadoria,
	  }) {
    return TributIcmsCustomCabsCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      origemMercadoria: origemMercadoria ?? this.origemMercadoria,
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
    if (origemMercadoria.present) {
      map['ORIGEM_MERCADORIA'] = Variable<String?>(origemMercadoria.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TributIcmsCustomCabsCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('origemMercadoria: $origemMercadoria, ')
          ..write(')'))
        .toString();
  }
}

class $TributIcmsCustomCabsTable extends TributIcmsCustomCabs
    with TableInfo<$TributIcmsCustomCabsTable, TributIcmsCustomCab> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TributIcmsCustomCabsTable(this._db, [this._alias]);
  
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
  final VerificationMeta _origemMercadoriaMeta =
      const VerificationMeta('origemMercadoria');
  GeneratedColumn<String>? _origemMercadoria;
  @override
  GeneratedColumn<String> get origemMercadoria => _origemMercadoria ??=
      GeneratedColumn<String>('ORIGEM_MERCADORIA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        descricao,
        origemMercadoria,
      ];

  @override
  String get aliasedName => _alias ?? 'TRIBUT_ICMS_CUSTOM_CAB';
  
  @override
  String get actualTableName => 'TRIBUT_ICMS_CUSTOM_CAB';
  
  @override
  VerificationContext validateIntegrity(Insertable<TributIcmsCustomCab> instance,
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
    if (data.containsKey('ORIGEM_MERCADORIA')) {
        context.handle(_origemMercadoriaMeta,
            origemMercadoria.isAcceptableOrUnknown(data['ORIGEM_MERCADORIA']!, _origemMercadoriaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TributIcmsCustomCab map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TributIcmsCustomCab.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TributIcmsCustomCabsTable createAlias(String alias) {
    return $TributIcmsCustomCabsTable(_db, alias);
  }
}