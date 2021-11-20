/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_PROCESSO_REFERENCIADO] 
                                                                                
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

@DataClassName("NfeProcessoReferenciado")
@UseRowClass(NfeProcessoReferenciado)
class NfeProcessoReferenciados extends Table {
  @override
  String get tableName => 'NFE_PROCESSO_REFERENCIADO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  TextColumn get identificador => text().named('IDENTIFICADOR').withLength(min: 0, max: 60).nullable()();
  TextColumn get origem => text().named('ORIGEM').withLength(min: 0, max: 1).nullable()();
}

class NfeProcessoReferenciado extends DataClass implements Insertable<NfeProcessoReferenciado> {
  final int? id;
  final int? idNfeCabecalho;
  final String? identificador;
  final String? origem;

  NfeProcessoReferenciado(
    {
      required this.id,
      this.idNfeCabecalho,
      this.identificador,
      this.origem,
    }
  );

  factory NfeProcessoReferenciado.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeProcessoReferenciado(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      identificador: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}IDENTIFICADOR']),
      origem: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ORIGEM']),
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
    if (!nullToAbsent || identificador != null) {
      map['IDENTIFICADOR'] = Variable<String?>(identificador);
    }
    if (!nullToAbsent || origem != null) {
      map['ORIGEM'] = Variable<String?>(origem);
    }
    return map;
  }

  NfeProcessoReferenciadosCompanion toCompanion(bool nullToAbsent) {
    return NfeProcessoReferenciadosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      identificador: identificador == null && nullToAbsent
        ? const Value.absent()
        : Value(identificador),
      origem: origem == null && nullToAbsent
        ? const Value.absent()
        : Value(origem),
    );
  }

  factory NfeProcessoReferenciado.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeProcessoReferenciado(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      identificador: serializer.fromJson<String>(json['identificador']),
      origem: serializer.fromJson<String>(json['origem']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'identificador': serializer.toJson<String?>(identificador),
      'origem': serializer.toJson<String?>(origem),
    };
  }

  NfeProcessoReferenciado copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          String? identificador,
          String? origem,
		}) =>
      NfeProcessoReferenciado(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        identificador: identificador ?? this.identificador,
        origem: origem ?? this.origem,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeProcessoReferenciado(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('identificador: $identificador, ')
          ..write('origem: $origem, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      identificador,
      origem,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeProcessoReferenciado &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.identificador == identificador &&
          other.origem == origem 
	   );
}

class NfeProcessoReferenciadosCompanion extends UpdateCompanion<NfeProcessoReferenciado> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<String?> identificador;
  final Value<String?> origem;

  const NfeProcessoReferenciadosCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.identificador = const Value.absent(),
    this.origem = const Value.absent(),
  });

  NfeProcessoReferenciadosCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.identificador = const Value.absent(),
    this.origem = const Value.absent(),
  });

  static Insertable<NfeProcessoReferenciado> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<String>? identificador,
    Expression<String>? origem,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (identificador != null) 'IDENTIFICADOR': identificador,
      if (origem != null) 'ORIGEM': origem,
    });
  }

  NfeProcessoReferenciadosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<String>? identificador,
      Value<String>? origem,
	  }) {
    return NfeProcessoReferenciadosCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      identificador: identificador ?? this.identificador,
      origem: origem ?? this.origem,
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
    if (identificador.present) {
      map['IDENTIFICADOR'] = Variable<String?>(identificador.value);
    }
    if (origem.present) {
      map['ORIGEM'] = Variable<String?>(origem.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeProcessoReferenciadosCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('identificador: $identificador, ')
          ..write('origem: $origem, ')
          ..write(')'))
        .toString();
  }
}

class $NfeProcessoReferenciadosTable extends NfeProcessoReferenciados
    with TableInfo<$NfeProcessoReferenciadosTable, NfeProcessoReferenciado> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeProcessoReferenciadosTable(this._db, [this._alias]);
  
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
  final VerificationMeta _identificadorMeta =
      const VerificationMeta('identificador');
  GeneratedColumn<String>? _identificador;
  @override
  GeneratedColumn<String> get identificador => _identificador ??=
      GeneratedColumn<String>('IDENTIFICADOR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _origemMeta =
      const VerificationMeta('origem');
  GeneratedColumn<String>? _origem;
  @override
  GeneratedColumn<String> get origem => _origem ??=
      GeneratedColumn<String>('ORIGEM', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        identificador,
        origem,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_PROCESSO_REFERENCIADO';
  
  @override
  String get actualTableName => 'NFE_PROCESSO_REFERENCIADO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeProcessoReferenciado> instance,
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
    if (data.containsKey('IDENTIFICADOR')) {
        context.handle(_identificadorMeta,
            identificador.isAcceptableOrUnknown(data['IDENTIFICADOR']!, _identificadorMeta));
    }
    if (data.containsKey('ORIGEM')) {
        context.handle(_origemMeta,
            origem.isAcceptableOrUnknown(data['ORIGEM']!, _origemMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeProcessoReferenciado map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeProcessoReferenciado.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeProcessoReferenciadosTable createAlias(String alias) {
    return $NfeProcessoReferenciadosTable(_db, alias);
  }
}