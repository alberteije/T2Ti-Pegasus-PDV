/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [LOG_IMPORTACAO] 
                                                                                
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

@DataClassName("LogImportacao")
@UseRowClass(LogImportacao)
class LogImportacaos extends Table {
  @override
  String get tableName => 'LOG_IMPORTACAO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  DateTimeColumn get dataImportacao => dateTime().named('DATA_IMPORTACAO').nullable()();
  TextColumn get horaImportacao => text().named('HORA_IMPORTACAO').withLength(min: 0, max: 8).nullable()();
  TextColumn get erro => text().named('ERRO').withLength(min: 0, max: 250).nullable()();
  TextColumn get registro => text().named('REGISTRO').withLength(min: 0, max: 250).nullable()();
}

class LogImportacao extends DataClass implements Insertable<LogImportacao> {
  final int? id;
  final DateTime? dataImportacao;
  final String? horaImportacao;
  final String? erro;
  final String? registro;

  LogImportacao(
    {
      required this.id,
      this.dataImportacao,
      this.horaImportacao,
      this.erro,
      this.registro,
    }
  );

  factory LogImportacao.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LogImportacao(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      dataImportacao: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_IMPORTACAO']),
      horaImportacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_IMPORTACAO']),
      erro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ERRO']),
      registro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}REGISTRO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || dataImportacao != null) {
      map['DATA_IMPORTACAO'] = Variable<DateTime?>(dataImportacao);
    }
    if (!nullToAbsent || horaImportacao != null) {
      map['HORA_IMPORTACAO'] = Variable<String?>(horaImportacao);
    }
    if (!nullToAbsent || erro != null) {
      map['ERRO'] = Variable<String?>(erro);
    }
    if (!nullToAbsent || registro != null) {
      map['REGISTRO'] = Variable<String?>(registro);
    }
    return map;
  }

  LogImportacaosCompanion toCompanion(bool nullToAbsent) {
    return LogImportacaosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dataImportacao: dataImportacao == null && nullToAbsent
        ? const Value.absent()
        : Value(dataImportacao),
      horaImportacao: horaImportacao == null && nullToAbsent
        ? const Value.absent()
        : Value(horaImportacao),
      erro: erro == null && nullToAbsent
        ? const Value.absent()
        : Value(erro),
      registro: registro == null && nullToAbsent
        ? const Value.absent()
        : Value(registro),
    );
  }

  factory LogImportacao.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LogImportacao(
      id: serializer.fromJson<int>(json['id']),
      dataImportacao: serializer.fromJson<DateTime>(json['dataImportacao']),
      horaImportacao: serializer.fromJson<String>(json['horaImportacao']),
      erro: serializer.fromJson<String>(json['erro']),
      registro: serializer.fromJson<String>(json['registro']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'dataImportacao': serializer.toJson<DateTime?>(dataImportacao),
      'horaImportacao': serializer.toJson<String?>(horaImportacao),
      'erro': serializer.toJson<String?>(erro),
      'registro': serializer.toJson<String?>(registro),
    };
  }

  LogImportacao copyWith(
        {
		  int? id,
          DateTime? dataImportacao,
          String? horaImportacao,
          String? erro,
          String? registro,
		}) =>
      LogImportacao(
        id: id ?? this.id,
        dataImportacao: dataImportacao ?? this.dataImportacao,
        horaImportacao: horaImportacao ?? this.horaImportacao,
        erro: erro ?? this.erro,
        registro: registro ?? this.registro,
      );
  
  @override
  String toString() {
    return (StringBuffer('LogImportacao(')
          ..write('id: $id, ')
          ..write('dataImportacao: $dataImportacao, ')
          ..write('horaImportacao: $horaImportacao, ')
          ..write('erro: $erro, ')
          ..write('registro: $registro, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      dataImportacao,
      horaImportacao,
      erro,
      registro,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogImportacao &&
          other.id == id &&
          other.dataImportacao == dataImportacao &&
          other.horaImportacao == horaImportacao &&
          other.erro == erro &&
          other.registro == registro 
	   );
}

class LogImportacaosCompanion extends UpdateCompanion<LogImportacao> {

  final Value<int?> id;
  final Value<DateTime?> dataImportacao;
  final Value<String?> horaImportacao;
  final Value<String?> erro;
  final Value<String?> registro;

  const LogImportacaosCompanion({
    this.id = const Value.absent(),
    this.dataImportacao = const Value.absent(),
    this.horaImportacao = const Value.absent(),
    this.erro = const Value.absent(),
    this.registro = const Value.absent(),
  });

  LogImportacaosCompanion.insert({
    this.id = const Value.absent(),
    this.dataImportacao = const Value.absent(),
    this.horaImportacao = const Value.absent(),
    this.erro = const Value.absent(),
    this.registro = const Value.absent(),
  });

  static Insertable<LogImportacao> custom({
    Expression<int>? id,
    Expression<DateTime>? dataImportacao,
    Expression<String>? horaImportacao,
    Expression<String>? erro,
    Expression<String>? registro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (dataImportacao != null) 'DATA_IMPORTACAO': dataImportacao,
      if (horaImportacao != null) 'HORA_IMPORTACAO': horaImportacao,
      if (erro != null) 'ERRO': erro,
      if (registro != null) 'REGISTRO': registro,
    });
  }

  LogImportacaosCompanion copyWith(
      {
	  Value<int>? id,
      Value<DateTime>? dataImportacao,
      Value<String>? horaImportacao,
      Value<String>? erro,
      Value<String>? registro,
	  }) {
    return LogImportacaosCompanion(
      id: id ?? this.id,
      dataImportacao: dataImportacao ?? this.dataImportacao,
      horaImportacao: horaImportacao ?? this.horaImportacao,
      erro: erro ?? this.erro,
      registro: registro ?? this.registro,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (dataImportacao.present) {
      map['DATA_IMPORTACAO'] = Variable<DateTime?>(dataImportacao.value);
    }
    if (horaImportacao.present) {
      map['HORA_IMPORTACAO'] = Variable<String?>(horaImportacao.value);
    }
    if (erro.present) {
      map['ERRO'] = Variable<String?>(erro.value);
    }
    if (registro.present) {
      map['REGISTRO'] = Variable<String?>(registro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogImportacaosCompanion(')
          ..write('id: $id, ')
          ..write('dataImportacao: $dataImportacao, ')
          ..write('horaImportacao: $horaImportacao, ')
          ..write('erro: $erro, ')
          ..write('registro: $registro, ')
          ..write(')'))
        .toString();
  }
}

class $LogImportacaosTable extends LogImportacaos
    with TableInfo<$LogImportacaosTable, LogImportacao> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LogImportacaosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _dataImportacaoMeta =
      const VerificationMeta('dataImportacao');
  GeneratedColumn<DateTime>? _dataImportacao;
  @override
  GeneratedColumn<DateTime> get dataImportacao => _dataImportacao ??=
      GeneratedColumn<DateTime>('DATA_IMPORTACAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaImportacaoMeta =
      const VerificationMeta('horaImportacao');
  GeneratedColumn<String>? _horaImportacao;
  @override
  GeneratedColumn<String> get horaImportacao => _horaImportacao ??=
      GeneratedColumn<String>('HORA_IMPORTACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _erroMeta =
      const VerificationMeta('erro');
  GeneratedColumn<String>? _erro;
  @override
  GeneratedColumn<String> get erro => _erro ??=
      GeneratedColumn<String>('ERRO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _registroMeta =
      const VerificationMeta('registro');
  GeneratedColumn<String>? _registro;
  @override
  GeneratedColumn<String> get registro => _registro ??=
      GeneratedColumn<String>('REGISTRO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dataImportacao,
        horaImportacao,
        erro,
        registro,
      ];

  @override
  String get aliasedName => _alias ?? 'LOG_IMPORTACAO';
  
  @override
  String get actualTableName => 'LOG_IMPORTACAO';
  
  @override
  VerificationContext validateIntegrity(Insertable<LogImportacao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('DATA_IMPORTACAO')) {
        context.handle(_dataImportacaoMeta,
            dataImportacao.isAcceptableOrUnknown(data['DATA_IMPORTACAO']!, _dataImportacaoMeta));
    }
    if (data.containsKey('HORA_IMPORTACAO')) {
        context.handle(_horaImportacaoMeta,
            horaImportacao.isAcceptableOrUnknown(data['HORA_IMPORTACAO']!, _horaImportacaoMeta));
    }
    if (data.containsKey('ERRO')) {
        context.handle(_erroMeta,
            erro.isAcceptableOrUnknown(data['ERRO']!, _erroMeta));
    }
    if (data.containsKey('REGISTRO')) {
        context.handle(_registroMeta,
            registro.isAcceptableOrUnknown(data['REGISTRO']!, _registroMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogImportacao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LogImportacao.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LogImportacaosTable createAlias(String alias) {
    return $LogImportacaosTable(_db, alias);
  }
}