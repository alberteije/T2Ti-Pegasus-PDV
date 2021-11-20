/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DET_ESPECIFICO_ARMAMENTO] 
                                                                                
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

@DataClassName("NfeDetEspecificoArmamento")
@UseRowClass(NfeDetEspecificoArmamento)
class NfeDetEspecificoArmamentos extends Table {
  @override
  String get tableName => 'NFE_DET_ESPECIFICO_ARMAMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  TextColumn get tipoArma => text().named('TIPO_ARMA').withLength(min: 0, max: 1).nullable()();
  TextColumn get numeroSerieArma => text().named('NUMERO_SERIE_ARMA').withLength(min: 0, max: 15).nullable()();
  TextColumn get numeroSerieCano => text().named('NUMERO_SERIE_CANO').withLength(min: 0, max: 15).nullable()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 250).nullable()();
}

class NfeDetEspecificoArmamento extends DataClass implements Insertable<NfeDetEspecificoArmamento> {
  final int? id;
  final int? idNfeDetalhe;
  final String? tipoArma;
  final String? numeroSerieArma;
  final String? numeroSerieCano;
  final String? descricao;

  NfeDetEspecificoArmamento(
    {
      required this.id,
      this.idNfeDetalhe,
      this.tipoArma,
      this.numeroSerieArma,
      this.numeroSerieCano,
      this.descricao,
    }
  );

  factory NfeDetEspecificoArmamento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetEspecificoArmamento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      tipoArma: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_ARMA']),
      numeroSerieArma: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_SERIE_ARMA']),
      numeroSerieCano: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_SERIE_CANO']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeDetalhe != null) {
      map['ID_NFE_DETALHE'] = Variable<int?>(idNfeDetalhe);
    }
    if (!nullToAbsent || tipoArma != null) {
      map['TIPO_ARMA'] = Variable<String?>(tipoArma);
    }
    if (!nullToAbsent || numeroSerieArma != null) {
      map['NUMERO_SERIE_ARMA'] = Variable<String?>(numeroSerieArma);
    }
    if (!nullToAbsent || numeroSerieCano != null) {
      map['NUMERO_SERIE_CANO'] = Variable<String?>(numeroSerieCano);
    }
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    return map;
  }

  NfeDetEspecificoArmamentosCompanion toCompanion(bool nullToAbsent) {
    return NfeDetEspecificoArmamentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      tipoArma: tipoArma == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoArma),
      numeroSerieArma: numeroSerieArma == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroSerieArma),
      numeroSerieCano: numeroSerieCano == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroSerieCano),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
    );
  }

  factory NfeDetEspecificoArmamento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetEspecificoArmamento(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      tipoArma: serializer.fromJson<String>(json['tipoArma']),
      numeroSerieArma: serializer.fromJson<String>(json['numeroSerieArma']),
      numeroSerieCano: serializer.fromJson<String>(json['numeroSerieCano']),
      descricao: serializer.fromJson<String>(json['descricao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'tipoArma': serializer.toJson<String?>(tipoArma),
      'numeroSerieArma': serializer.toJson<String?>(numeroSerieArma),
      'numeroSerieCano': serializer.toJson<String?>(numeroSerieCano),
      'descricao': serializer.toJson<String?>(descricao),
    };
  }

  NfeDetEspecificoArmamento copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          String? tipoArma,
          String? numeroSerieArma,
          String? numeroSerieCano,
          String? descricao,
		}) =>
      NfeDetEspecificoArmamento(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        tipoArma: tipoArma ?? this.tipoArma,
        numeroSerieArma: numeroSerieArma ?? this.numeroSerieArma,
        numeroSerieCano: numeroSerieCano ?? this.numeroSerieCano,
        descricao: descricao ?? this.descricao,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetEspecificoArmamento(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('tipoArma: $tipoArma, ')
          ..write('numeroSerieArma: $numeroSerieArma, ')
          ..write('numeroSerieCano: $numeroSerieCano, ')
          ..write('descricao: $descricao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      tipoArma,
      numeroSerieArma,
      numeroSerieCano,
      descricao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetEspecificoArmamento &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.tipoArma == tipoArma &&
          other.numeroSerieArma == numeroSerieArma &&
          other.numeroSerieCano == numeroSerieCano &&
          other.descricao == descricao 
	   );
}

class NfeDetEspecificoArmamentosCompanion extends UpdateCompanion<NfeDetEspecificoArmamento> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<String?> tipoArma;
  final Value<String?> numeroSerieArma;
  final Value<String?> numeroSerieCano;
  final Value<String?> descricao;

  const NfeDetEspecificoArmamentosCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.tipoArma = const Value.absent(),
    this.numeroSerieArma = const Value.absent(),
    this.numeroSerieCano = const Value.absent(),
    this.descricao = const Value.absent(),
  });

  NfeDetEspecificoArmamentosCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.tipoArma = const Value.absent(),
    this.numeroSerieArma = const Value.absent(),
    this.numeroSerieCano = const Value.absent(),
    this.descricao = const Value.absent(),
  });

  static Insertable<NfeDetEspecificoArmamento> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<String>? tipoArma,
    Expression<String>? numeroSerieArma,
    Expression<String>? numeroSerieCano,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (tipoArma != null) 'TIPO_ARMA': tipoArma,
      if (numeroSerieArma != null) 'NUMERO_SERIE_ARMA': numeroSerieArma,
      if (numeroSerieCano != null) 'NUMERO_SERIE_CANO': numeroSerieCano,
      if (descricao != null) 'DESCRICAO': descricao,
    });
  }

  NfeDetEspecificoArmamentosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<String>? tipoArma,
      Value<String>? numeroSerieArma,
      Value<String>? numeroSerieCano,
      Value<String>? descricao,
	  }) {
    return NfeDetEspecificoArmamentosCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      tipoArma: tipoArma ?? this.tipoArma,
      numeroSerieArma: numeroSerieArma ?? this.numeroSerieArma,
      numeroSerieCano: numeroSerieCano ?? this.numeroSerieCano,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeDetalhe.present) {
      map['ID_NFE_DETALHE'] = Variable<int?>(idNfeDetalhe.value);
    }
    if (tipoArma.present) {
      map['TIPO_ARMA'] = Variable<String?>(tipoArma.value);
    }
    if (numeroSerieArma.present) {
      map['NUMERO_SERIE_ARMA'] = Variable<String?>(numeroSerieArma.value);
    }
    if (numeroSerieCano.present) {
      map['NUMERO_SERIE_CANO'] = Variable<String?>(numeroSerieCano.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetEspecificoArmamentosCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('tipoArma: $tipoArma, ')
          ..write('numeroSerieArma: $numeroSerieArma, ')
          ..write('numeroSerieCano: $numeroSerieCano, ')
          ..write('descricao: $descricao, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetEspecificoArmamentosTable extends NfeDetEspecificoArmamentos
    with TableInfo<$NfeDetEspecificoArmamentosTable, NfeDetEspecificoArmamento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetEspecificoArmamentosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeDetalheMeta =
      const VerificationMeta('idNfeDetalhe');
  GeneratedColumn<int>? _idNfeDetalhe;
  @override
  GeneratedColumn<int> get idNfeDetalhe =>
      _idNfeDetalhe ??= GeneratedColumn<int>('ID_NFE_DETALHE', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_DETALHE(ID)');
  final VerificationMeta _tipoArmaMeta =
      const VerificationMeta('tipoArma');
  GeneratedColumn<String>? _tipoArma;
  @override
  GeneratedColumn<String> get tipoArma => _tipoArma ??=
      GeneratedColumn<String>('TIPO_ARMA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroSerieArmaMeta =
      const VerificationMeta('numeroSerieArma');
  GeneratedColumn<String>? _numeroSerieArma;
  @override
  GeneratedColumn<String> get numeroSerieArma => _numeroSerieArma ??=
      GeneratedColumn<String>('NUMERO_SERIE_ARMA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroSerieCanoMeta =
      const VerificationMeta('numeroSerieCano');
  GeneratedColumn<String>? _numeroSerieCano;
  @override
  GeneratedColumn<String> get numeroSerieCano => _numeroSerieCano ??=
      GeneratedColumn<String>('NUMERO_SERIE_CANO', aliasedName, true,
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
        idNfeDetalhe,
        tipoArma,
        numeroSerieArma,
        numeroSerieCano,
        descricao,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DET_ESPECIFICO_ARMAMENTO';
  
  @override
  String get actualTableName => 'NFE_DET_ESPECIFICO_ARMAMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetEspecificoArmamento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_DETALHE')) {
        context.handle(_idNfeDetalheMeta,
            idNfeDetalhe.isAcceptableOrUnknown(data['ID_NFE_DETALHE']!, _idNfeDetalheMeta));
    }
    if (data.containsKey('TIPO_ARMA')) {
        context.handle(_tipoArmaMeta,
            tipoArma.isAcceptableOrUnknown(data['TIPO_ARMA']!, _tipoArmaMeta));
    }
    if (data.containsKey('NUMERO_SERIE_ARMA')) {
        context.handle(_numeroSerieArmaMeta,
            numeroSerieArma.isAcceptableOrUnknown(data['NUMERO_SERIE_ARMA']!, _numeroSerieArmaMeta));
    }
    if (data.containsKey('NUMERO_SERIE_CANO')) {
        context.handle(_numeroSerieCanoMeta,
            numeroSerieCano.isAcceptableOrUnknown(data['NUMERO_SERIE_CANO']!, _numeroSerieCanoMeta));
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
  NfeDetEspecificoArmamento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetEspecificoArmamento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetEspecificoArmamentosTable createAlias(String alias) {
    return $NfeDetEspecificoArmamentosTable(_db, alias);
  }
}