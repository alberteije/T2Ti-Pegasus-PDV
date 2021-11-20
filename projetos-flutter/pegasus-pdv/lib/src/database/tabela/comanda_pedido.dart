/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [COMANDA_PEDIDO] 
                                                                                
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

@DataClassName("ComandaPedido")
@UseRowClass(ComandaPedido)
class ComandaPedidos extends Table {
  @override
  String get tableName => 'COMANDA_PEDIDO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idComanda => integer().named('ID_COMANDA').nullable().customConstraint('NULLABLE REFERENCES COMANDA(ID)')();
  IntColumn get idCozinha => integer().named('ID_COZINHA').nullable().customConstraint('NULLABLE REFERENCES COZINHA(ID)')();
  DateTimeColumn get entrouNaFila => dateTime().named('ENTROU_NA_FILA').nullable()();
  DateTimeColumn get saiuDaFila => dateTime().named('SAIU_DA_FILA').nullable()();
  IntColumn get estimativaMinutos => integer().named('ESTIMATIVA_MINUTOS').nullable()();
  IntColumn get posicao => integer().named('POSICAO').nullable()();
  TextColumn get prioridade => text().named('PRIORIDADE').withLength(min: 0, max: 1).nullable()();
  DateTimeColumn get inicioPreparo => dateTime().named('INICIO_PREPARO').nullable()();
  DateTimeColumn get fimPreparo => dateTime().named('FIM_PREPARO').nullable()();
}

class ComandaPedido extends DataClass implements Insertable<ComandaPedido> {
  final int? id;
  final int? idComanda;
  final int? idCozinha;
  final DateTime? entrouNaFila;
  final DateTime? saiuDaFila;
  final int? estimativaMinutos;
  final int? posicao;
  final String? prioridade;
  final DateTime? inicioPreparo;
  final DateTime? fimPreparo;

  ComandaPedido(
    {
      required this.id,
      this.idComanda,
      this.idCozinha,
      this.entrouNaFila,
      this.saiuDaFila,
      this.estimativaMinutos,
      this.posicao,
      this.prioridade,
      this.inicioPreparo,
      this.fimPreparo,
    }
  );

  factory ComandaPedido.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ComandaPedido(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idComanda: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_COMANDA']),
      idCozinha: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_COZINHA']),
      entrouNaFila: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}ENTROU_NA_FILA']),
      saiuDaFila: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}SAIU_DA_FILA']),
      estimativaMinutos: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ESTIMATIVA_MINUTOS']),
      posicao: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}POSICAO']),
      prioridade: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PRIORIDADE']),
      inicioPreparo: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}INICIO_PREPARO']),
      fimPreparo: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}FIM_PREPARO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idComanda != null) {
      map['ID_COMANDA'] = Variable<int?>(idComanda);
    }
    if (!nullToAbsent || idCozinha != null) {
      map['ID_COZINHA'] = Variable<int?>(idCozinha);
    }
    if (!nullToAbsent || entrouNaFila != null) {
      map['ENTROU_NA_FILA'] = Variable<DateTime?>(entrouNaFila);
    }
    if (!nullToAbsent || saiuDaFila != null) {
      map['SAIU_DA_FILA'] = Variable<DateTime?>(saiuDaFila);
    }
    if (!nullToAbsent || estimativaMinutos != null) {
      map['ESTIMATIVA_MINUTOS'] = Variable<int?>(estimativaMinutos);
    }
    if (!nullToAbsent || posicao != null) {
      map['POSICAO'] = Variable<int?>(posicao);
    }
    if (!nullToAbsent || prioridade != null) {
      map['PRIORIDADE'] = Variable<String?>(prioridade);
    }
    if (!nullToAbsent || inicioPreparo != null) {
      map['INICIO_PREPARO'] = Variable<DateTime?>(inicioPreparo);
    }
    if (!nullToAbsent || fimPreparo != null) {
      map['FIM_PREPARO'] = Variable<DateTime?>(fimPreparo);
    }
    return map;
  }

  ComandaPedidosCompanion toCompanion(bool nullToAbsent) {
    return ComandaPedidosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idComanda: idComanda == null && nullToAbsent
        ? const Value.absent()
        : Value(idComanda),
      idCozinha: idCozinha == null && nullToAbsent
        ? const Value.absent()
        : Value(idCozinha),
      entrouNaFila: entrouNaFila == null && nullToAbsent
        ? const Value.absent()
        : Value(entrouNaFila),
      saiuDaFila: saiuDaFila == null && nullToAbsent
        ? const Value.absent()
        : Value(saiuDaFila),
      estimativaMinutos: estimativaMinutos == null && nullToAbsent
        ? const Value.absent()
        : Value(estimativaMinutos),
      posicao: posicao == null && nullToAbsent
        ? const Value.absent()
        : Value(posicao),
      prioridade: prioridade == null && nullToAbsent
        ? const Value.absent()
        : Value(prioridade),
      inicioPreparo: inicioPreparo == null && nullToAbsent
        ? const Value.absent()
        : Value(inicioPreparo),
      fimPreparo: fimPreparo == null && nullToAbsent
        ? const Value.absent()
        : Value(fimPreparo),
    );
  }

  factory ComandaPedido.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ComandaPedido(
      id: serializer.fromJson<int>(json['id']),
      idComanda: serializer.fromJson<int>(json['idComanda']),
      idCozinha: serializer.fromJson<int>(json['idCozinha']),
      entrouNaFila: serializer.fromJson<DateTime>(json['entrouNaFila']),
      saiuDaFila: serializer.fromJson<DateTime>(json['saiuDaFila']),
      estimativaMinutos: serializer.fromJson<int>(json['estimativaMinutos']),
      posicao: serializer.fromJson<int>(json['posicao']),
      prioridade: serializer.fromJson<String>(json['prioridade']),
      inicioPreparo: serializer.fromJson<DateTime>(json['inicioPreparo']),
      fimPreparo: serializer.fromJson<DateTime>(json['fimPreparo']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idComanda': serializer.toJson<int?>(idComanda),
      'idCozinha': serializer.toJson<int?>(idCozinha),
      'entrouNaFila': serializer.toJson<DateTime?>(entrouNaFila),
      'saiuDaFila': serializer.toJson<DateTime?>(saiuDaFila),
      'estimativaMinutos': serializer.toJson<int?>(estimativaMinutos),
      'posicao': serializer.toJson<int?>(posicao),
      'prioridade': serializer.toJson<String?>(prioridade),
      'inicioPreparo': serializer.toJson<DateTime?>(inicioPreparo),
      'fimPreparo': serializer.toJson<DateTime?>(fimPreparo),
    };
  }

  ComandaPedido copyWith(
        {
		  int? id,
          int? idComanda,
          int? idCozinha,
          DateTime? entrouNaFila,
          DateTime? saiuDaFila,
          int? estimativaMinutos,
          int? posicao,
          String? prioridade,
          DateTime? inicioPreparo,
          DateTime? fimPreparo,
		}) =>
      ComandaPedido(
        id: id ?? this.id,
        idComanda: idComanda ?? this.idComanda,
        idCozinha: idCozinha ?? this.idCozinha,
        entrouNaFila: entrouNaFila ?? this.entrouNaFila,
        saiuDaFila: saiuDaFila ?? this.saiuDaFila,
        estimativaMinutos: estimativaMinutos ?? this.estimativaMinutos,
        posicao: posicao ?? this.posicao,
        prioridade: prioridade ?? this.prioridade,
        inicioPreparo: inicioPreparo ?? this.inicioPreparo,
        fimPreparo: fimPreparo ?? this.fimPreparo,
      );
  
  @override
  String toString() {
    return (StringBuffer('ComandaPedido(')
          ..write('id: $id, ')
          ..write('idComanda: $idComanda, ')
          ..write('idCozinha: $idCozinha, ')
          ..write('entrouNaFila: $entrouNaFila, ')
          ..write('saiuDaFila: $saiuDaFila, ')
          ..write('estimativaMinutos: $estimativaMinutos, ')
          ..write('posicao: $posicao, ')
          ..write('prioridade: $prioridade, ')
          ..write('inicioPreparo: $inicioPreparo, ')
          ..write('fimPreparo: $fimPreparo, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idComanda,
      idCozinha,
      entrouNaFila,
      saiuDaFila,
      estimativaMinutos,
      posicao,
      prioridade,
      inicioPreparo,
      fimPreparo,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComandaPedido &&
          other.id == id &&
          other.idComanda == idComanda &&
          other.idCozinha == idCozinha &&
          other.entrouNaFila == entrouNaFila &&
          other.saiuDaFila == saiuDaFila &&
          other.estimativaMinutos == estimativaMinutos &&
          other.posicao == posicao &&
          other.prioridade == prioridade &&
          other.inicioPreparo == inicioPreparo &&
          other.fimPreparo == fimPreparo 
	   );
}

class ComandaPedidosCompanion extends UpdateCompanion<ComandaPedido> {

  final Value<int?> id;
  final Value<int?> idComanda;
  final Value<int?> idCozinha;
  final Value<DateTime?> entrouNaFila;
  final Value<DateTime?> saiuDaFila;
  final Value<int?> estimativaMinutos;
  final Value<int?> posicao;
  final Value<String?> prioridade;
  final Value<DateTime?> inicioPreparo;
  final Value<DateTime?> fimPreparo;

  const ComandaPedidosCompanion({
    this.id = const Value.absent(),
    this.idComanda = const Value.absent(),
    this.idCozinha = const Value.absent(),
    this.entrouNaFila = const Value.absent(),
    this.saiuDaFila = const Value.absent(),
    this.estimativaMinutos = const Value.absent(),
    this.posicao = const Value.absent(),
    this.prioridade = const Value.absent(),
    this.inicioPreparo = const Value.absent(),
    this.fimPreparo = const Value.absent(),
  });

  ComandaPedidosCompanion.insert({
    this.id = const Value.absent(),
    this.idComanda = const Value.absent(),
    this.idCozinha = const Value.absent(),
    this.entrouNaFila = const Value.absent(),
    this.saiuDaFila = const Value.absent(),
    this.estimativaMinutos = const Value.absent(),
    this.posicao = const Value.absent(),
    this.prioridade = const Value.absent(),
    this.inicioPreparo = const Value.absent(),
    this.fimPreparo = const Value.absent(),
  });

  static Insertable<ComandaPedido> custom({
    Expression<int>? id,
    Expression<int>? idComanda,
    Expression<int>? idCozinha,
    Expression<DateTime>? entrouNaFila,
    Expression<DateTime>? saiuDaFila,
    Expression<int>? estimativaMinutos,
    Expression<int>? posicao,
    Expression<String>? prioridade,
    Expression<DateTime>? inicioPreparo,
    Expression<DateTime>? fimPreparo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idComanda != null) 'ID_COMANDA': idComanda,
      if (idCozinha != null) 'ID_COZINHA': idCozinha,
      if (entrouNaFila != null) 'ENTROU_NA_FILA': entrouNaFila,
      if (saiuDaFila != null) 'SAIU_DA_FILA': saiuDaFila,
      if (estimativaMinutos != null) 'ESTIMATIVA_MINUTOS': estimativaMinutos,
      if (posicao != null) 'POSICAO': posicao,
      if (prioridade != null) 'PRIORIDADE': prioridade,
      if (inicioPreparo != null) 'INICIO_PREPARO': inicioPreparo,
      if (fimPreparo != null) 'FIM_PREPARO': fimPreparo,
    });
  }

  ComandaPedidosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idComanda,
      Value<int>? idCozinha,
      Value<DateTime>? entrouNaFila,
      Value<DateTime>? saiuDaFila,
      Value<int>? estimativaMinutos,
      Value<int>? posicao,
      Value<String>? prioridade,
      Value<DateTime>? inicioPreparo,
      Value<DateTime>? fimPreparo,
	  }) {
    return ComandaPedidosCompanion(
      id: id ?? this.id,
      idComanda: idComanda ?? this.idComanda,
      idCozinha: idCozinha ?? this.idCozinha,
      entrouNaFila: entrouNaFila ?? this.entrouNaFila,
      saiuDaFila: saiuDaFila ?? this.saiuDaFila,
      estimativaMinutos: estimativaMinutos ?? this.estimativaMinutos,
      posicao: posicao ?? this.posicao,
      prioridade: prioridade ?? this.prioridade,
      inicioPreparo: inicioPreparo ?? this.inicioPreparo,
      fimPreparo: fimPreparo ?? this.fimPreparo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idComanda.present) {
      map['ID_COMANDA'] = Variable<int?>(idComanda.value);
    }
    if (idCozinha.present) {
      map['ID_COZINHA'] = Variable<int?>(idCozinha.value);
    }
    if (entrouNaFila.present) {
      map['ENTROU_NA_FILA'] = Variable<DateTime?>(entrouNaFila.value);
    }
    if (saiuDaFila.present) {
      map['SAIU_DA_FILA'] = Variable<DateTime?>(saiuDaFila.value);
    }
    if (estimativaMinutos.present) {
      map['ESTIMATIVA_MINUTOS'] = Variable<int?>(estimativaMinutos.value);
    }
    if (posicao.present) {
      map['POSICAO'] = Variable<int?>(posicao.value);
    }
    if (prioridade.present) {
      map['PRIORIDADE'] = Variable<String?>(prioridade.value);
    }
    if (inicioPreparo.present) {
      map['INICIO_PREPARO'] = Variable<DateTime?>(inicioPreparo.value);
    }
    if (fimPreparo.present) {
      map['FIM_PREPARO'] = Variable<DateTime?>(fimPreparo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComandaPedidosCompanion(')
          ..write('id: $id, ')
          ..write('idComanda: $idComanda, ')
          ..write('idCozinha: $idCozinha, ')
          ..write('entrouNaFila: $entrouNaFila, ')
          ..write('saiuDaFila: $saiuDaFila, ')
          ..write('estimativaMinutos: $estimativaMinutos, ')
          ..write('posicao: $posicao, ')
          ..write('prioridade: $prioridade, ')
          ..write('inicioPreparo: $inicioPreparo, ')
          ..write('fimPreparo: $fimPreparo, ')
          ..write(')'))
        .toString();
  }
}

class $ComandaPedidosTable extends ComandaPedidos
    with TableInfo<$ComandaPedidosTable, ComandaPedido> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ComandaPedidosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idComandaMeta =
      const VerificationMeta('idComanda');
  GeneratedColumn<int>? _idComanda;
  @override
  GeneratedColumn<int> get idComanda =>
      _idComanda ??= GeneratedColumn<int>('ID_COMANDA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES COMANDA(ID)');
  final VerificationMeta _idCozinhaMeta =
      const VerificationMeta('idCozinha');
  GeneratedColumn<int>? _idCozinha;
  @override
  GeneratedColumn<int> get idCozinha =>
      _idCozinha ??= GeneratedColumn<int>('ID_COZINHA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES COZINHA(ID)');
  final VerificationMeta _entrouNaFilaMeta =
      const VerificationMeta('entrouNaFila');
  GeneratedColumn<DateTime>? _entrouNaFila;
  @override
  GeneratedColumn<DateTime> get entrouNaFila => _entrouNaFila ??=
      GeneratedColumn<DateTime>('ENTROU_NA_FILA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _saiuDaFilaMeta =
      const VerificationMeta('saiuDaFila');
  GeneratedColumn<DateTime>? _saiuDaFila;
  @override
  GeneratedColumn<DateTime> get saiuDaFila => _saiuDaFila ??=
      GeneratedColumn<DateTime>('SAIU_DA_FILA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _estimativaMinutosMeta =
      const VerificationMeta('estimativaMinutos');
  GeneratedColumn<int>? _estimativaMinutos;
  @override
  GeneratedColumn<int> get estimativaMinutos => _estimativaMinutos ??=
      GeneratedColumn<int>('ESTIMATIVA_MINUTOS', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _posicaoMeta =
      const VerificationMeta('posicao');
  GeneratedColumn<int>? _posicao;
  @override
  GeneratedColumn<int> get posicao => _posicao ??=
      GeneratedColumn<int>('POSICAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _prioridadeMeta =
      const VerificationMeta('prioridade');
  GeneratedColumn<String>? _prioridade;
  @override
  GeneratedColumn<String> get prioridade => _prioridade ??=
      GeneratedColumn<String>('PRIORIDADE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _inicioPreparoMeta =
      const VerificationMeta('inicioPreparo');
  GeneratedColumn<DateTime>? _inicioPreparo;
  @override
  GeneratedColumn<DateTime> get inicioPreparo => _inicioPreparo ??=
      GeneratedColumn<DateTime>('INICIO_PREPARO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _fimPreparoMeta =
      const VerificationMeta('fimPreparo');
  GeneratedColumn<DateTime>? _fimPreparo;
  @override
  GeneratedColumn<DateTime> get fimPreparo => _fimPreparo ??=
      GeneratedColumn<DateTime>('FIM_PREPARO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idComanda,
        idCozinha,
        entrouNaFila,
        saiuDaFila,
        estimativaMinutos,
        posicao,
        prioridade,
        inicioPreparo,
        fimPreparo,
      ];

  @override
  String get aliasedName => _alias ?? 'COMANDA_PEDIDO';
  
  @override
  String get actualTableName => 'COMANDA_PEDIDO';
  
  @override
  VerificationContext validateIntegrity(Insertable<ComandaPedido> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_COMANDA')) {
        context.handle(_idComandaMeta,
            idComanda.isAcceptableOrUnknown(data['ID_COMANDA']!, _idComandaMeta));
    }
    if (data.containsKey('ID_COZINHA')) {
        context.handle(_idCozinhaMeta,
            idCozinha.isAcceptableOrUnknown(data['ID_COZINHA']!, _idCozinhaMeta));
    }
    if (data.containsKey('ENTROU_NA_FILA')) {
        context.handle(_entrouNaFilaMeta,
            entrouNaFila.isAcceptableOrUnknown(data['ENTROU_NA_FILA']!, _entrouNaFilaMeta));
    }
    if (data.containsKey('SAIU_DA_FILA')) {
        context.handle(_saiuDaFilaMeta,
            saiuDaFila.isAcceptableOrUnknown(data['SAIU_DA_FILA']!, _saiuDaFilaMeta));
    }
    if (data.containsKey('ESTIMATIVA_MINUTOS')) {
        context.handle(_estimativaMinutosMeta,
            estimativaMinutos.isAcceptableOrUnknown(data['ESTIMATIVA_MINUTOS']!, _estimativaMinutosMeta));
    }
    if (data.containsKey('POSICAO')) {
        context.handle(_posicaoMeta,
            posicao.isAcceptableOrUnknown(data['POSICAO']!, _posicaoMeta));
    }
    if (data.containsKey('PRIORIDADE')) {
        context.handle(_prioridadeMeta,
            prioridade.isAcceptableOrUnknown(data['PRIORIDADE']!, _prioridadeMeta));
    }
    if (data.containsKey('INICIO_PREPARO')) {
        context.handle(_inicioPreparoMeta,
            inicioPreparo.isAcceptableOrUnknown(data['INICIO_PREPARO']!, _inicioPreparoMeta));
    }
    if (data.containsKey('FIM_PREPARO')) {
        context.handle(_fimPreparoMeta,
            fimPreparo.isAcceptableOrUnknown(data['FIM_PREPARO']!, _fimPreparoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComandaPedido map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ComandaPedido.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ComandaPedidosTable createAlias(String alias) {
    return $ComandaPedidosTable(_db, alias);
  }
}