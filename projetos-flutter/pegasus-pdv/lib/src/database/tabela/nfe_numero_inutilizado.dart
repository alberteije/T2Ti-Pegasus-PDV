/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_NUMERO_INUTILIZADO] 
                                                                                
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

@DataClassName("NfeNumeroInutilizado")
@UseRowClass(NfeNumeroInutilizado)
class NfeNumeroInutilizados extends Table {
  @override
  String get tableName => 'NFE_NUMERO_INUTILIZADO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get serie => text().named('SERIE').withLength(min: 0, max: 3).nullable()();
  IntColumn get numero => integer().named('NUMERO').nullable()();
  DateTimeColumn get dataInutilizacao => dateTime().named('DATA_INUTILIZACAO').nullable()();
  TextColumn get observacao => text().named('OBSERVACAO').withLength(min: 0, max: 250).nullable()();
}

class NfeNumeroInutilizado extends DataClass implements Insertable<NfeNumeroInutilizado> {
  final int? id;
  final String? serie;
  final int? numero;
  final DateTime? dataInutilizacao;
  final String? observacao;

  NfeNumeroInutilizado(
    {
      required this.id,
      this.serie,
      this.numero,
      this.dataInutilizacao,
      this.observacao,
    }
  );

  factory NfeNumeroInutilizado.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeNumeroInutilizado(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      serie: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SERIE']),
      numero: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO']),
      dataInutilizacao: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_INUTILIZACAO']),
      observacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}OBSERVACAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || serie != null) {
      map['SERIE'] = Variable<String?>(serie);
    }
    if (!nullToAbsent || numero != null) {
      map['NUMERO'] = Variable<int?>(numero);
    }
    if (!nullToAbsent || dataInutilizacao != null) {
      map['DATA_INUTILIZACAO'] = Variable<DateTime?>(dataInutilizacao);
    }
    if (!nullToAbsent || observacao != null) {
      map['OBSERVACAO'] = Variable<String?>(observacao);
    }
    return map;
  }

  NfeNumeroInutilizadosCompanion toCompanion(bool nullToAbsent) {
    return NfeNumeroInutilizadosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      serie: serie == null && nullToAbsent
        ? const Value.absent()
        : Value(serie),
      numero: numero == null && nullToAbsent
        ? const Value.absent()
        : Value(numero),
      dataInutilizacao: dataInutilizacao == null && nullToAbsent
        ? const Value.absent()
        : Value(dataInutilizacao),
      observacao: observacao == null && nullToAbsent
        ? const Value.absent()
        : Value(observacao),
    );
  }

  factory NfeNumeroInutilizado.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeNumeroInutilizado(
      id: serializer.fromJson<int>(json['id']),
      serie: serializer.fromJson<String>(json['serie']),
      numero: serializer.fromJson<int>(json['numero']),
      dataInutilizacao: serializer.fromJson<DateTime>(json['dataInutilizacao']),
      observacao: serializer.fromJson<String>(json['observacao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'serie': serializer.toJson<String?>(serie),
      'numero': serializer.toJson<int?>(numero),
      'dataInutilizacao': serializer.toJson<DateTime?>(dataInutilizacao),
      'observacao': serializer.toJson<String?>(observacao),
    };
  }

  NfeNumeroInutilizado copyWith(
        {
		  int? id,
          String? serie,
          int? numero,
          DateTime? dataInutilizacao,
          String? observacao,
		}) =>
      NfeNumeroInutilizado(
        id: id ?? this.id,
        serie: serie ?? this.serie,
        numero: numero ?? this.numero,
        dataInutilizacao: dataInutilizacao ?? this.dataInutilizacao,
        observacao: observacao ?? this.observacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeNumeroInutilizado(')
          ..write('id: $id, ')
          ..write('serie: $serie, ')
          ..write('numero: $numero, ')
          ..write('dataInutilizacao: $dataInutilizacao, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      serie,
      numero,
      dataInutilizacao,
      observacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeNumeroInutilizado &&
          other.id == id &&
          other.serie == serie &&
          other.numero == numero &&
          other.dataInutilizacao == dataInutilizacao &&
          other.observacao == observacao 
	   );
}

class NfeNumeroInutilizadosCompanion extends UpdateCompanion<NfeNumeroInutilizado> {

  final Value<int?> id;
  final Value<String?> serie;
  final Value<int?> numero;
  final Value<DateTime?> dataInutilizacao;
  final Value<String?> observacao;

  const NfeNumeroInutilizadosCompanion({
    this.id = const Value.absent(),
    this.serie = const Value.absent(),
    this.numero = const Value.absent(),
    this.dataInutilizacao = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  NfeNumeroInutilizadosCompanion.insert({
    this.id = const Value.absent(),
    this.serie = const Value.absent(),
    this.numero = const Value.absent(),
    this.dataInutilizacao = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  static Insertable<NfeNumeroInutilizado> custom({
    Expression<int>? id,
    Expression<String>? serie,
    Expression<int>? numero,
    Expression<DateTime>? dataInutilizacao,
    Expression<String>? observacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (serie != null) 'SERIE': serie,
      if (numero != null) 'NUMERO': numero,
      if (dataInutilizacao != null) 'DATA_INUTILIZACAO': dataInutilizacao,
      if (observacao != null) 'OBSERVACAO': observacao,
    });
  }

  NfeNumeroInutilizadosCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? serie,
      Value<int>? numero,
      Value<DateTime>? dataInutilizacao,
      Value<String>? observacao,
	  }) {
    return NfeNumeroInutilizadosCompanion(
      id: id ?? this.id,
      serie: serie ?? this.serie,
      numero: numero ?? this.numero,
      dataInutilizacao: dataInutilizacao ?? this.dataInutilizacao,
      observacao: observacao ?? this.observacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (serie.present) {
      map['SERIE'] = Variable<String?>(serie.value);
    }
    if (numero.present) {
      map['NUMERO'] = Variable<int?>(numero.value);
    }
    if (dataInutilizacao.present) {
      map['DATA_INUTILIZACAO'] = Variable<DateTime?>(dataInutilizacao.value);
    }
    if (observacao.present) {
      map['OBSERVACAO'] = Variable<String?>(observacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeNumeroInutilizadosCompanion(')
          ..write('id: $id, ')
          ..write('serie: $serie, ')
          ..write('numero: $numero, ')
          ..write('dataInutilizacao: $dataInutilizacao, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }
}

class $NfeNumeroInutilizadosTable extends NfeNumeroInutilizados
    with TableInfo<$NfeNumeroInutilizadosTable, NfeNumeroInutilizado> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeNumeroInutilizadosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _serieMeta =
      const VerificationMeta('serie');
  GeneratedColumn<String>? _serie;
  @override
  GeneratedColumn<String> get serie => _serie ??=
      GeneratedColumn<String>('SERIE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroMeta =
      const VerificationMeta('numero');
  GeneratedColumn<int>? _numero;
  @override
  GeneratedColumn<int> get numero => _numero ??=
      GeneratedColumn<int>('NUMERO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dataInutilizacaoMeta =
      const VerificationMeta('dataInutilizacao');
  GeneratedColumn<DateTime>? _dataInutilizacao;
  @override
  GeneratedColumn<DateTime> get dataInutilizacao => _dataInutilizacao ??=
      GeneratedColumn<DateTime>('DATA_INUTILIZACAO', aliasedName, true,
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
        serie,
        numero,
        dataInutilizacao,
        observacao,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_NUMERO_INUTILIZADO';
  
  @override
  String get actualTableName => 'NFE_NUMERO_INUTILIZADO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeNumeroInutilizado> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('SERIE')) {
        context.handle(_serieMeta,
            serie.isAcceptableOrUnknown(data['SERIE']!, _serieMeta));
    }
    if (data.containsKey('NUMERO')) {
        context.handle(_numeroMeta,
            numero.isAcceptableOrUnknown(data['NUMERO']!, _numeroMeta));
    }
    if (data.containsKey('DATA_INUTILIZACAO')) {
        context.handle(_dataInutilizacaoMeta,
            dataInutilizacao.isAcceptableOrUnknown(data['DATA_INUTILIZACAO']!, _dataInutilizacaoMeta));
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
  NfeNumeroInutilizado map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeNumeroInutilizado.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeNumeroInutilizadosTable createAlias(String alias) {
    return $NfeNumeroInutilizadosTable(_db, alias);
  }
}