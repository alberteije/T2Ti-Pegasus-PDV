/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_REFERENCIADA] 
                                                                                
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

@DataClassName("NfeReferenciada")
@UseRowClass(NfeReferenciada)
class NfeReferenciadas extends Table {
  @override
  String get tableName => 'NFE_REFERENCIADA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  TextColumn get chaveAcesso => text().named('CHAVE_ACESSO').withLength(min: 0, max: 44).nullable()();
}

class NfeReferenciada extends DataClass implements Insertable<NfeReferenciada> {
  final int? id;
  final int? idNfeCabecalho;
  final String? chaveAcesso;

  NfeReferenciada(
    {
      required this.id,
      this.idNfeCabecalho,
      this.chaveAcesso,
    }
  );

  factory NfeReferenciada.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeReferenciada(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      chaveAcesso: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CHAVE_ACESSO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeCabecalho != null) {
      map['ID_NFE_CABECALHO'] = Variable<int?>(idNfeCabecalho);
    }
    if (!nullToAbsent || chaveAcesso != null) {
      map['CHAVE_ACESSO'] = Variable<String?>(chaveAcesso);
    }
    return map;
  }

  NfeReferenciadasCompanion toCompanion(bool nullToAbsent) {
    return NfeReferenciadasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      chaveAcesso: chaveAcesso == null && nullToAbsent
        ? const Value.absent()
        : Value(chaveAcesso),
    );
  }

  factory NfeReferenciada.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeReferenciada(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      chaveAcesso: serializer.fromJson<String>(json['chaveAcesso']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'chaveAcesso': serializer.toJson<String?>(chaveAcesso),
    };
  }

  NfeReferenciada copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          String? chaveAcesso,
		}) =>
      NfeReferenciada(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        chaveAcesso: chaveAcesso ?? this.chaveAcesso,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeReferenciada(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('chaveAcesso: $chaveAcesso, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      chaveAcesso,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeReferenciada &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.chaveAcesso == chaveAcesso 
	   );
}

class NfeReferenciadasCompanion extends UpdateCompanion<NfeReferenciada> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<String?> chaveAcesso;

  const NfeReferenciadasCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.chaveAcesso = const Value.absent(),
  });

  NfeReferenciadasCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.chaveAcesso = const Value.absent(),
  });

  static Insertable<NfeReferenciada> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<String>? chaveAcesso,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (chaveAcesso != null) 'CHAVE_ACESSO': chaveAcesso,
    });
  }

  NfeReferenciadasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<String>? chaveAcesso,
	  }) {
    return NfeReferenciadasCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      chaveAcesso: chaveAcesso ?? this.chaveAcesso,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeCabecalho.present) {
      map['ID_NFE_CABECALHO'] = Variable<int?>(idNfeCabecalho.value);
    }
    if (chaveAcesso.present) {
      map['CHAVE_ACESSO'] = Variable<String?>(chaveAcesso.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeReferenciadasCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('chaveAcesso: $chaveAcesso, ')
          ..write(')'))
        .toString();
  }
}

class $NfeReferenciadasTable extends NfeReferenciadas
    with TableInfo<$NfeReferenciadasTable, NfeReferenciada> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeReferenciadasTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeCabecalhoMeta =
      const VerificationMeta('idNfeCabecalho');
  GeneratedColumn<int>? _idNfeCabecalho;
  @override
  GeneratedColumn<int> get idNfeCabecalho =>
      _idNfeCabecalho ??= GeneratedColumn<int>('ID_NFE_CABECALHO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_CABECALHO(ID)');
  final VerificationMeta _chaveAcessoMeta =
      const VerificationMeta('chaveAcesso');
  GeneratedColumn<String>? _chaveAcesso;
  @override
  GeneratedColumn<String> get chaveAcesso => _chaveAcesso ??=
      GeneratedColumn<String>('CHAVE_ACESSO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        chaveAcesso,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_REFERENCIADA';
  
  @override
  String get actualTableName => 'NFE_REFERENCIADA';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeReferenciada> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_CABECALHO')) {
        context.handle(_idNfeCabecalhoMeta,
            idNfeCabecalho.isAcceptableOrUnknown(data['ID_NFE_CABECALHO']!, _idNfeCabecalhoMeta));
    }
    if (data.containsKey('CHAVE_ACESSO')) {
        context.handle(_chaveAcessoMeta,
            chaveAcesso.isAcceptableOrUnknown(data['CHAVE_ACESSO']!, _chaveAcessoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeReferenciada map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeReferenciada.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeReferenciadasTable createAlias(String alias) {
    return $NfeReferenciadasTable(_db, alias);
  }
}