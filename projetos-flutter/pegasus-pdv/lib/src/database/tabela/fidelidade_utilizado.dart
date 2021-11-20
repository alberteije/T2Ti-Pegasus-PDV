/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [FIDELIDADE_UTILIZADO] 
                                                                                
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

@DataClassName("FidelidadeUtilizado")
@UseRowClass(FidelidadeUtilizado)
class FidelidadeUtilizados extends Table {
  @override
  String get tableName => 'FIDELIDADE_UTILIZADO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  DateTimeColumn get dataUtilizacao => dateTime().named('DATA_UTILIZACAO').nullable()();
  TextColumn get horaUtilizacao => text().named('HORA_UTILIZACAO').withLength(min: 0, max: 8).nullable()();
  RealColumn get valorUtilizado => real().named('VALOR_UTILIZADO').nullable()();
}

class FidelidadeUtilizado extends DataClass implements Insertable<FidelidadeUtilizado> {
  final int? id;
  final DateTime? dataUtilizacao;
  final String? horaUtilizacao;
  final double? valorUtilizado;

  FidelidadeUtilizado(
    {
      required this.id,
      this.dataUtilizacao,
      this.horaUtilizacao,
      this.valorUtilizado,
    }
  );

  factory FidelidadeUtilizado.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FidelidadeUtilizado(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      dataUtilizacao: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_UTILIZACAO']),
      horaUtilizacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_UTILIZACAO']),
      valorUtilizado: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_UTILIZADO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || dataUtilizacao != null) {
      map['DATA_UTILIZACAO'] = Variable<DateTime?>(dataUtilizacao);
    }
    if (!nullToAbsent || horaUtilizacao != null) {
      map['HORA_UTILIZACAO'] = Variable<String?>(horaUtilizacao);
    }
    if (!nullToAbsent || valorUtilizado != null) {
      map['VALOR_UTILIZADO'] = Variable<double?>(valorUtilizado);
    }
    return map;
  }

  FidelidadeUtilizadosCompanion toCompanion(bool nullToAbsent) {
    return FidelidadeUtilizadosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dataUtilizacao: dataUtilizacao == null && nullToAbsent
        ? const Value.absent()
        : Value(dataUtilizacao),
      horaUtilizacao: horaUtilizacao == null && nullToAbsent
        ? const Value.absent()
        : Value(horaUtilizacao),
      valorUtilizado: valorUtilizado == null && nullToAbsent
        ? const Value.absent()
        : Value(valorUtilizado),
    );
  }

  factory FidelidadeUtilizado.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FidelidadeUtilizado(
      id: serializer.fromJson<int>(json['id']),
      dataUtilizacao: serializer.fromJson<DateTime>(json['dataUtilizacao']),
      horaUtilizacao: serializer.fromJson<String>(json['horaUtilizacao']),
      valorUtilizado: serializer.fromJson<double>(json['valorUtilizado']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'dataUtilizacao': serializer.toJson<DateTime?>(dataUtilizacao),
      'horaUtilizacao': serializer.toJson<String?>(horaUtilizacao),
      'valorUtilizado': serializer.toJson<double?>(valorUtilizado),
    };
  }

  FidelidadeUtilizado copyWith(
        {
		  int? id,
          DateTime? dataUtilizacao,
          String? horaUtilizacao,
          double? valorUtilizado,
		}) =>
      FidelidadeUtilizado(
        id: id ?? this.id,
        dataUtilizacao: dataUtilizacao ?? this.dataUtilizacao,
        horaUtilizacao: horaUtilizacao ?? this.horaUtilizacao,
        valorUtilizado: valorUtilizado ?? this.valorUtilizado,
      );
  
  @override
  String toString() {
    return (StringBuffer('FidelidadeUtilizado(')
          ..write('id: $id, ')
          ..write('dataUtilizacao: $dataUtilizacao, ')
          ..write('horaUtilizacao: $horaUtilizacao, ')
          ..write('valorUtilizado: $valorUtilizado, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      dataUtilizacao,
      horaUtilizacao,
      valorUtilizado,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FidelidadeUtilizado &&
          other.id == id &&
          other.dataUtilizacao == dataUtilizacao &&
          other.horaUtilizacao == horaUtilizacao &&
          other.valorUtilizado == valorUtilizado 
	   );
}

class FidelidadeUtilizadosCompanion extends UpdateCompanion<FidelidadeUtilizado> {

  final Value<int?> id;
  final Value<DateTime?> dataUtilizacao;
  final Value<String?> horaUtilizacao;
  final Value<double?> valorUtilizado;

  const FidelidadeUtilizadosCompanion({
    this.id = const Value.absent(),
    this.dataUtilizacao = const Value.absent(),
    this.horaUtilizacao = const Value.absent(),
    this.valorUtilizado = const Value.absent(),
  });

  FidelidadeUtilizadosCompanion.insert({
    this.id = const Value.absent(),
    this.dataUtilizacao = const Value.absent(),
    this.horaUtilizacao = const Value.absent(),
    this.valorUtilizado = const Value.absent(),
  });

  static Insertable<FidelidadeUtilizado> custom({
    Expression<int>? id,
    Expression<DateTime>? dataUtilizacao,
    Expression<String>? horaUtilizacao,
    Expression<double>? valorUtilizado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (dataUtilizacao != null) 'DATA_UTILIZACAO': dataUtilizacao,
      if (horaUtilizacao != null) 'HORA_UTILIZACAO': horaUtilizacao,
      if (valorUtilizado != null) 'VALOR_UTILIZADO': valorUtilizado,
    });
  }

  FidelidadeUtilizadosCompanion copyWith(
      {
	  Value<int>? id,
      Value<DateTime>? dataUtilizacao,
      Value<String>? horaUtilizacao,
      Value<double>? valorUtilizado,
	  }) {
    return FidelidadeUtilizadosCompanion(
      id: id ?? this.id,
      dataUtilizacao: dataUtilizacao ?? this.dataUtilizacao,
      horaUtilizacao: horaUtilizacao ?? this.horaUtilizacao,
      valorUtilizado: valorUtilizado ?? this.valorUtilizado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (dataUtilizacao.present) {
      map['DATA_UTILIZACAO'] = Variable<DateTime?>(dataUtilizacao.value);
    }
    if (horaUtilizacao.present) {
      map['HORA_UTILIZACAO'] = Variable<String?>(horaUtilizacao.value);
    }
    if (valorUtilizado.present) {
      map['VALOR_UTILIZADO'] = Variable<double?>(valorUtilizado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FidelidadeUtilizadosCompanion(')
          ..write('id: $id, ')
          ..write('dataUtilizacao: $dataUtilizacao, ')
          ..write('horaUtilizacao: $horaUtilizacao, ')
          ..write('valorUtilizado: $valorUtilizado, ')
          ..write(')'))
        .toString();
  }
}

class $FidelidadeUtilizadosTable extends FidelidadeUtilizados
    with TableInfo<$FidelidadeUtilizadosTable, FidelidadeUtilizado> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FidelidadeUtilizadosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _dataUtilizacaoMeta =
      const VerificationMeta('dataUtilizacao');
  GeneratedColumn<DateTime>? _dataUtilizacao;
  @override
  GeneratedColumn<DateTime> get dataUtilizacao => _dataUtilizacao ??=
      GeneratedColumn<DateTime>('DATA_UTILIZACAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaUtilizacaoMeta =
      const VerificationMeta('horaUtilizacao');
  GeneratedColumn<String>? _horaUtilizacao;
  @override
  GeneratedColumn<String> get horaUtilizacao => _horaUtilizacao ??=
      GeneratedColumn<String>('HORA_UTILIZACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorUtilizadoMeta =
      const VerificationMeta('valorUtilizado');
  GeneratedColumn<double>? _valorUtilizado;
  @override
  GeneratedColumn<double> get valorUtilizado => _valorUtilizado ??=
      GeneratedColumn<double>('VALOR_UTILIZADO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dataUtilizacao,
        horaUtilizacao,
        valorUtilizado,
      ];

  @override
  String get aliasedName => _alias ?? 'FIDELIDADE_UTILIZADO';
  
  @override
  String get actualTableName => 'FIDELIDADE_UTILIZADO';
  
  @override
  VerificationContext validateIntegrity(Insertable<FidelidadeUtilizado> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('DATA_UTILIZACAO')) {
        context.handle(_dataUtilizacaoMeta,
            dataUtilizacao.isAcceptableOrUnknown(data['DATA_UTILIZACAO']!, _dataUtilizacaoMeta));
    }
    if (data.containsKey('HORA_UTILIZACAO')) {
        context.handle(_horaUtilizacaoMeta,
            horaUtilizacao.isAcceptableOrUnknown(data['HORA_UTILIZACAO']!, _horaUtilizacaoMeta));
    }
    if (data.containsKey('VALOR_UTILIZADO')) {
        context.handle(_valorUtilizadoMeta,
            valorUtilizado.isAcceptableOrUnknown(data['VALOR_UTILIZADO']!, _valorUtilizadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FidelidadeUtilizado map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FidelidadeUtilizado.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FidelidadeUtilizadosTable createAlias(String alias) {
    return $FidelidadeUtilizadosTable(_db, alias);
  }
}