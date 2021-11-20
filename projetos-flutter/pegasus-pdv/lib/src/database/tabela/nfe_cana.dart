/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_CANA] 
                                                                                
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

@DataClassName("NfeCana")
@UseRowClass(NfeCana)
class NfeCanas extends Table {
  @override
  String get tableName => 'NFE_CANA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  TextColumn get safra => text().named('SAFRA').withLength(min: 0, max: 9).nullable()();
  TextColumn get mesAnoReferencia => text().named('MES_ANO_REFERENCIA').withLength(min: 0, max: 7).nullable()();
}

class NfeCana extends DataClass implements Insertable<NfeCana> {
  final int? id;
  final int? idNfeCabecalho;
  final String? safra;
  final String? mesAnoReferencia;

  NfeCana(
    {
      required this.id,
      this.idNfeCabecalho,
      this.safra,
      this.mesAnoReferencia,
    }
  );

  factory NfeCana.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeCana(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      safra: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SAFRA']),
      mesAnoReferencia: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MES_ANO_REFERENCIA']),
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
    if (!nullToAbsent || safra != null) {
      map['SAFRA'] = Variable<String?>(safra);
    }
    if (!nullToAbsent || mesAnoReferencia != null) {
      map['MES_ANO_REFERENCIA'] = Variable<String?>(mesAnoReferencia);
    }
    return map;
  }

  NfeCanasCompanion toCompanion(bool nullToAbsent) {
    return NfeCanasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      safra: safra == null && nullToAbsent
        ? const Value.absent()
        : Value(safra),
      mesAnoReferencia: mesAnoReferencia == null && nullToAbsent
        ? const Value.absent()
        : Value(mesAnoReferencia),
    );
  }

  factory NfeCana.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeCana(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      safra: serializer.fromJson<String>(json['safra']),
      mesAnoReferencia: serializer.fromJson<String>(json['mesAnoReferencia']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'safra': serializer.toJson<String?>(safra),
      'mesAnoReferencia': serializer.toJson<String?>(mesAnoReferencia),
    };
  }

  NfeCana copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          String? safra,
          String? mesAnoReferencia,
		}) =>
      NfeCana(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        safra: safra ?? this.safra,
        mesAnoReferencia: mesAnoReferencia ?? this.mesAnoReferencia,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeCana(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('safra: $safra, ')
          ..write('mesAnoReferencia: $mesAnoReferencia, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      safra,
      mesAnoReferencia,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeCana &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.safra == safra &&
          other.mesAnoReferencia == mesAnoReferencia 
	   );
}

class NfeCanasCompanion extends UpdateCompanion<NfeCana> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<String?> safra;
  final Value<String?> mesAnoReferencia;

  const NfeCanasCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.safra = const Value.absent(),
    this.mesAnoReferencia = const Value.absent(),
  });

  NfeCanasCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.safra = const Value.absent(),
    this.mesAnoReferencia = const Value.absent(),
  });

  static Insertable<NfeCana> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<String>? safra,
    Expression<String>? mesAnoReferencia,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (safra != null) 'SAFRA': safra,
      if (mesAnoReferencia != null) 'MES_ANO_REFERENCIA': mesAnoReferencia,
    });
  }

  NfeCanasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<String>? safra,
      Value<String>? mesAnoReferencia,
	  }) {
    return NfeCanasCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      safra: safra ?? this.safra,
      mesAnoReferencia: mesAnoReferencia ?? this.mesAnoReferencia,
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
    if (safra.present) {
      map['SAFRA'] = Variable<String?>(safra.value);
    }
    if (mesAnoReferencia.present) {
      map['MES_ANO_REFERENCIA'] = Variable<String?>(mesAnoReferencia.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeCanasCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('safra: $safra, ')
          ..write('mesAnoReferencia: $mesAnoReferencia, ')
          ..write(')'))
        .toString();
  }
}

class $NfeCanasTable extends NfeCanas
    with TableInfo<$NfeCanasTable, NfeCana> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeCanasTable(this._db, [this._alias]);
  
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
  final VerificationMeta _safraMeta =
      const VerificationMeta('safra');
  GeneratedColumn<String>? _safra;
  @override
  GeneratedColumn<String> get safra => _safra ??=
      GeneratedColumn<String>('SAFRA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _mesAnoReferenciaMeta =
      const VerificationMeta('mesAnoReferencia');
  GeneratedColumn<String>? _mesAnoReferencia;
  @override
  GeneratedColumn<String> get mesAnoReferencia => _mesAnoReferencia ??=
      GeneratedColumn<String>('MES_ANO_REFERENCIA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        safra,
        mesAnoReferencia,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_CANA';
  
  @override
  String get actualTableName => 'NFE_CANA';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeCana> instance,
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
    if (data.containsKey('SAFRA')) {
        context.handle(_safraMeta,
            safra.isAcceptableOrUnknown(data['SAFRA']!, _safraMeta));
    }
    if (data.containsKey('MES_ANO_REFERENCIA')) {
        context.handle(_mesAnoReferenciaMeta,
            mesAnoReferencia.isAcceptableOrUnknown(data['MES_ANO_REFERENCIA']!, _mesAnoReferenciaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeCana map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeCana.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeCanasTable createAlias(String alias) {
    return $NfeCanasTable(_db, alias);
  }
}