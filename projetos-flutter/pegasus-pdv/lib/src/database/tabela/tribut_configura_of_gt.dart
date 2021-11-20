/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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

import '../database_classes.dart';

@DataClassName("TributConfiguraOfGt")
@UseRowClass(TributConfiguraOfGt)
class TributConfiguraOfGts extends Table {
  @override
  String get tableName => 'TRIBUT_CONFIGURA_OF_GT';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idTributGrupoTributario => integer().named('ID_TRIBUT_GRUPO_TRIBUTARIO').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_GRUPO_TRIBUTARIO(ID)')();
  IntColumn get idTributOperacaoFiscal => integer().named('ID_TRIBUT_OPERACAO_FISCAL').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_OPERACAO_FISCAL(ID)')();
}

class TributConfiguraOfGtMontado {
  TributConfiguraOfGt? tributConfiguraOfGt;
  TributIcmsUf? tributIcmsUf;
  TributCofins? tributCofins;
  TributPis? tributPis;
  TributGrupoTributario? tributGrupoTributario;
  TributOperacaoFiscal? tributOperacaoFiscal;

  TributConfiguraOfGtMontado({
    this.tributConfiguraOfGt,
    this.tributIcmsUf,
    this.tributCofins,
    this.tributPis,
    this.tributGrupoTributario,
    this.tributOperacaoFiscal,
  });
}

class TributConfiguraOfGt extends DataClass implements Insertable<TributConfiguraOfGt> {
  final int? id;
  final int? idTributGrupoTributario;
  final int? idTributOperacaoFiscal;

  TributConfiguraOfGt(
    {
      required this.id,
      this.idTributGrupoTributario,
      this.idTributOperacaoFiscal,
    }
  );

  factory TributConfiguraOfGt.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TributConfiguraOfGt(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idTributGrupoTributario: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_TRIBUT_GRUPO_TRIBUTARIO']),
      idTributOperacaoFiscal: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_TRIBUT_OPERACAO_FISCAL']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idTributGrupoTributario != null) {
      map['ID_TRIBUT_GRUPO_TRIBUTARIO'] = Variable<int?>(idTributGrupoTributario);
    }
    if (!nullToAbsent || idTributOperacaoFiscal != null) {
      map['ID_TRIBUT_OPERACAO_FISCAL'] = Variable<int?>(idTributOperacaoFiscal);
    }
    return map;
  }

  TributConfiguraOfGtsCompanion toCompanion(bool nullToAbsent) {
    return TributConfiguraOfGtsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idTributGrupoTributario: idTributGrupoTributario == null && nullToAbsent
        ? const Value.absent()
        : Value(idTributGrupoTributario),
      idTributOperacaoFiscal: idTributOperacaoFiscal == null && nullToAbsent
        ? const Value.absent()
        : Value(idTributOperacaoFiscal),
    );
  }

  factory TributConfiguraOfGt.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TributConfiguraOfGt(
      id: serializer.fromJson<int>(json['id']),
      idTributGrupoTributario: serializer.fromJson<int>(json['idTributGrupoTributario']),
      idTributOperacaoFiscal: serializer.fromJson<int>(json['idTributOperacaoFiscal']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idTributGrupoTributario': serializer.toJson<int?>(idTributGrupoTributario),
      'idTributOperacaoFiscal': serializer.toJson<int?>(idTributOperacaoFiscal),
    };
  }

  TributConfiguraOfGt copyWith(
        {
		  int? id,
          int? idTributGrupoTributario,
          int? idTributOperacaoFiscal,
		}) =>
      TributConfiguraOfGt(
        id: id ?? this.id,
        idTributGrupoTributario: idTributGrupoTributario ?? this.idTributGrupoTributario,
        idTributOperacaoFiscal: idTributOperacaoFiscal ?? this.idTributOperacaoFiscal,
      );
  
  @override
  String toString() {
    return (StringBuffer('TributConfiguraOfGt(')
          ..write('id: $id, ')
          ..write('idTributGrupoTributario: $idTributGrupoTributario, ')
          ..write('idTributOperacaoFiscal: $idTributOperacaoFiscal, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idTributGrupoTributario,
      idTributOperacaoFiscal,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TributConfiguraOfGt &&
          other.id == id &&
          other.idTributGrupoTributario == idTributGrupoTributario &&
          other.idTributOperacaoFiscal == idTributOperacaoFiscal 
	   );
}

class TributConfiguraOfGtsCompanion extends UpdateCompanion<TributConfiguraOfGt> {

  final Value<int?> id;
  final Value<int?> idTributGrupoTributario;
  final Value<int?> idTributOperacaoFiscal;

  const TributConfiguraOfGtsCompanion({
    this.id = const Value.absent(),
    this.idTributGrupoTributario = const Value.absent(),
    this.idTributOperacaoFiscal = const Value.absent(),
  });

  TributConfiguraOfGtsCompanion.insert({
    this.id = const Value.absent(),
    this.idTributGrupoTributario = const Value.absent(),
    this.idTributOperacaoFiscal = const Value.absent(),
  });

  static Insertable<TributConfiguraOfGt> custom({
    Expression<int>? id,
    Expression<int>? idTributGrupoTributario,
    Expression<int>? idTributOperacaoFiscal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idTributGrupoTributario != null) 'ID_TRIBUT_GRUPO_TRIBUTARIO': idTributGrupoTributario,
      if (idTributOperacaoFiscal != null) 'ID_TRIBUT_OPERACAO_FISCAL': idTributOperacaoFiscal,
    });
  }

  TributConfiguraOfGtsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idTributGrupoTributario,
      Value<int>? idTributOperacaoFiscal,
	  }) {
    return TributConfiguraOfGtsCompanion(
      id: id ?? this.id,
      idTributGrupoTributario: idTributGrupoTributario ?? this.idTributGrupoTributario,
      idTributOperacaoFiscal: idTributOperacaoFiscal ?? this.idTributOperacaoFiscal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idTributGrupoTributario.present) {
      map['ID_TRIBUT_GRUPO_TRIBUTARIO'] = Variable<int?>(idTributGrupoTributario.value);
    }
    if (idTributOperacaoFiscal.present) {
      map['ID_TRIBUT_OPERACAO_FISCAL'] = Variable<int?>(idTributOperacaoFiscal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TributConfiguraOfGtsCompanion(')
          ..write('id: $id, ')
          ..write('idTributGrupoTributario: $idTributGrupoTributario, ')
          ..write('idTributOperacaoFiscal: $idTributOperacaoFiscal, ')
          ..write(')'))
        .toString();
  }
}

class $TributConfiguraOfGtsTable extends TributConfiguraOfGts
    with TableInfo<$TributConfiguraOfGtsTable, TributConfiguraOfGt> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TributConfiguraOfGtsTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idTributGrupoTributarioMeta =
      const VerificationMeta('idTributGrupoTributario');
  GeneratedColumn<int>? _idTributGrupoTributario;
  @override
  GeneratedColumn<int> get idTributGrupoTributario =>
      _idTributGrupoTributario ??= GeneratedColumn<int>('ID_TRIBUT_GRUPO_TRIBUTARIO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES TRIBUT_GRUPO_TRIBUTARIO(ID)');
  final VerificationMeta _idTributOperacaoFiscalMeta =
      const VerificationMeta('idTributOperacaoFiscal');
  GeneratedColumn<int>? _idTributOperacaoFiscal;
  @override
  GeneratedColumn<int> get idTributOperacaoFiscal =>
      _idTributOperacaoFiscal ??= GeneratedColumn<int>('ID_TRIBUT_OPERACAO_FISCAL', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES TRIBUT_OPERACAO_FISCAL(ID)');
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idTributGrupoTributario,
        idTributOperacaoFiscal,
      ];

  @override
  String get aliasedName => _alias ?? 'TRIBUT_CONFIGURA_OF_GT';
  
  @override
  String get actualTableName => 'TRIBUT_CONFIGURA_OF_GT';
  
  @override
  VerificationContext validateIntegrity(Insertable<TributConfiguraOfGt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_TRIBUT_GRUPO_TRIBUTARIO')) {
        context.handle(_idTributGrupoTributarioMeta,
            idTributGrupoTributario.isAcceptableOrUnknown(data['ID_TRIBUT_GRUPO_TRIBUTARIO']!, _idTributGrupoTributarioMeta));
    }
    if (data.containsKey('ID_TRIBUT_OPERACAO_FISCAL')) {
        context.handle(_idTributOperacaoFiscalMeta,
            idTributOperacaoFiscal.isAcceptableOrUnknown(data['ID_TRIBUT_OPERACAO_FISCAL']!, _idTributOperacaoFiscalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TributConfiguraOfGt map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TributConfiguraOfGt.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TributConfiguraOfGtsTable createAlias(String alias) {
    return $TributConfiguraOfGtsTable(_db, alias);
  }
}