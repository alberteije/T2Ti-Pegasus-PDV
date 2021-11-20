/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_ITEM_RASTREADO] 
                                                                                
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

@DataClassName("NfeItemRastreado")
@UseRowClass(NfeItemRastreado)
class NfeItemRastreados extends Table {
  @override
  String get tableName => 'NFE_ITEM_RASTREADO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  TextColumn get numeroLote => text().named('NUMERO_LOTE').withLength(min: 0, max: 20).nullable()();
  RealColumn get quantidadeItens => real().named('QUANTIDADE_ITENS').nullable()();
  DateTimeColumn get dataFabricacao => dateTime().named('DATA_FABRICACAO').nullable()();
  DateTimeColumn get dataValidade => dateTime().named('DATA_VALIDADE').nullable()();
  TextColumn get codigoAgregacao => text().named('CODIGO_AGREGACAO').withLength(min: 0, max: 20).nullable()();
}

class NfeItemRastreado extends DataClass implements Insertable<NfeItemRastreado> {
  final int? id;
  final int? idNfeDetalhe;
  final String? numeroLote;
  final double? quantidadeItens;
  final DateTime? dataFabricacao;
  final DateTime? dataValidade;
  final String? codigoAgregacao;

  NfeItemRastreado(
    {
      required this.id,
      this.idNfeDetalhe,
      this.numeroLote,
      this.quantidadeItens,
      this.dataFabricacao,
      this.dataValidade,
      this.codigoAgregacao,
    }
  );

  factory NfeItemRastreado.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeItemRastreado(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      numeroLote: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_LOTE']),
      quantidadeItens: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_ITENS']),
      dataFabricacao: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_FABRICACAO']),
      dataValidade: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_VALIDADE']),
      codigoAgregacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_AGREGACAO']),
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
    if (!nullToAbsent || numeroLote != null) {
      map['NUMERO_LOTE'] = Variable<String?>(numeroLote);
    }
    if (!nullToAbsent || quantidadeItens != null) {
      map['QUANTIDADE_ITENS'] = Variable<double?>(quantidadeItens);
    }
    if (!nullToAbsent || dataFabricacao != null) {
      map['DATA_FABRICACAO'] = Variable<DateTime?>(dataFabricacao);
    }
    if (!nullToAbsent || dataValidade != null) {
      map['DATA_VALIDADE'] = Variable<DateTime?>(dataValidade);
    }
    if (!nullToAbsent || codigoAgregacao != null) {
      map['CODIGO_AGREGACAO'] = Variable<String?>(codigoAgregacao);
    }
    return map;
  }

  NfeItemRastreadosCompanion toCompanion(bool nullToAbsent) {
    return NfeItemRastreadosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      numeroLote: numeroLote == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroLote),
      quantidadeItens: quantidadeItens == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeItens),
      dataFabricacao: dataFabricacao == null && nullToAbsent
        ? const Value.absent()
        : Value(dataFabricacao),
      dataValidade: dataValidade == null && nullToAbsent
        ? const Value.absent()
        : Value(dataValidade),
      codigoAgregacao: codigoAgregacao == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoAgregacao),
    );
  }

  factory NfeItemRastreado.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeItemRastreado(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      numeroLote: serializer.fromJson<String>(json['numeroLote']),
      quantidadeItens: serializer.fromJson<double>(json['quantidadeItens']),
      dataFabricacao: serializer.fromJson<DateTime>(json['dataFabricacao']),
      dataValidade: serializer.fromJson<DateTime>(json['dataValidade']),
      codigoAgregacao: serializer.fromJson<String>(json['codigoAgregacao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'numeroLote': serializer.toJson<String?>(numeroLote),
      'quantidadeItens': serializer.toJson<double?>(quantidadeItens),
      'dataFabricacao': serializer.toJson<DateTime?>(dataFabricacao),
      'dataValidade': serializer.toJson<DateTime?>(dataValidade),
      'codigoAgregacao': serializer.toJson<String?>(codigoAgregacao),
    };
  }

  NfeItemRastreado copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          String? numeroLote,
          double? quantidadeItens,
          DateTime? dataFabricacao,
          DateTime? dataValidade,
          String? codigoAgregacao,
		}) =>
      NfeItemRastreado(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        numeroLote: numeroLote ?? this.numeroLote,
        quantidadeItens: quantidadeItens ?? this.quantidadeItens,
        dataFabricacao: dataFabricacao ?? this.dataFabricacao,
        dataValidade: dataValidade ?? this.dataValidade,
        codigoAgregacao: codigoAgregacao ?? this.codigoAgregacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeItemRastreado(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('numeroLote: $numeroLote, ')
          ..write('quantidadeItens: $quantidadeItens, ')
          ..write('dataFabricacao: $dataFabricacao, ')
          ..write('dataValidade: $dataValidade, ')
          ..write('codigoAgregacao: $codigoAgregacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      numeroLote,
      quantidadeItens,
      dataFabricacao,
      dataValidade,
      codigoAgregacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeItemRastreado &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.numeroLote == numeroLote &&
          other.quantidadeItens == quantidadeItens &&
          other.dataFabricacao == dataFabricacao &&
          other.dataValidade == dataValidade &&
          other.codigoAgregacao == codigoAgregacao 
	   );
}

class NfeItemRastreadosCompanion extends UpdateCompanion<NfeItemRastreado> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<String?> numeroLote;
  final Value<double?> quantidadeItens;
  final Value<DateTime?> dataFabricacao;
  final Value<DateTime?> dataValidade;
  final Value<String?> codigoAgregacao;

  const NfeItemRastreadosCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.numeroLote = const Value.absent(),
    this.quantidadeItens = const Value.absent(),
    this.dataFabricacao = const Value.absent(),
    this.dataValidade = const Value.absent(),
    this.codigoAgregacao = const Value.absent(),
  });

  NfeItemRastreadosCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.numeroLote = const Value.absent(),
    this.quantidadeItens = const Value.absent(),
    this.dataFabricacao = const Value.absent(),
    this.dataValidade = const Value.absent(),
    this.codigoAgregacao = const Value.absent(),
  });

  static Insertable<NfeItemRastreado> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<String>? numeroLote,
    Expression<double>? quantidadeItens,
    Expression<DateTime>? dataFabricacao,
    Expression<DateTime>? dataValidade,
    Expression<String>? codigoAgregacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (numeroLote != null) 'NUMERO_LOTE': numeroLote,
      if (quantidadeItens != null) 'QUANTIDADE_ITENS': quantidadeItens,
      if (dataFabricacao != null) 'DATA_FABRICACAO': dataFabricacao,
      if (dataValidade != null) 'DATA_VALIDADE': dataValidade,
      if (codigoAgregacao != null) 'CODIGO_AGREGACAO': codigoAgregacao,
    });
  }

  NfeItemRastreadosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<String>? numeroLote,
      Value<double>? quantidadeItens,
      Value<DateTime>? dataFabricacao,
      Value<DateTime>? dataValidade,
      Value<String>? codigoAgregacao,
	  }) {
    return NfeItemRastreadosCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      numeroLote: numeroLote ?? this.numeroLote,
      quantidadeItens: quantidadeItens ?? this.quantidadeItens,
      dataFabricacao: dataFabricacao ?? this.dataFabricacao,
      dataValidade: dataValidade ?? this.dataValidade,
      codigoAgregacao: codigoAgregacao ?? this.codigoAgregacao,
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
    if (numeroLote.present) {
      map['NUMERO_LOTE'] = Variable<String?>(numeroLote.value);
    }
    if (quantidadeItens.present) {
      map['QUANTIDADE_ITENS'] = Variable<double?>(quantidadeItens.value);
    }
    if (dataFabricacao.present) {
      map['DATA_FABRICACAO'] = Variable<DateTime?>(dataFabricacao.value);
    }
    if (dataValidade.present) {
      map['DATA_VALIDADE'] = Variable<DateTime?>(dataValidade.value);
    }
    if (codigoAgregacao.present) {
      map['CODIGO_AGREGACAO'] = Variable<String?>(codigoAgregacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeItemRastreadosCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('numeroLote: $numeroLote, ')
          ..write('quantidadeItens: $quantidadeItens, ')
          ..write('dataFabricacao: $dataFabricacao, ')
          ..write('dataValidade: $dataValidade, ')
          ..write('codigoAgregacao: $codigoAgregacao, ')
          ..write(')'))
        .toString();
  }
}

class $NfeItemRastreadosTable extends NfeItemRastreados
    with TableInfo<$NfeItemRastreadosTable, NfeItemRastreado> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeItemRastreadosTable(this._db, [this._alias]);
  
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
  final VerificationMeta _numeroLoteMeta =
      const VerificationMeta('numeroLote');
  GeneratedColumn<String>? _numeroLote;
  @override
  GeneratedColumn<String> get numeroLote => _numeroLote ??=
      GeneratedColumn<String>('NUMERO_LOTE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _quantidadeItensMeta =
      const VerificationMeta('quantidadeItens');
  GeneratedColumn<double>? _quantidadeItens;
  @override
  GeneratedColumn<double> get quantidadeItens => _quantidadeItens ??=
      GeneratedColumn<double>('QUANTIDADE_ITENS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _dataFabricacaoMeta =
      const VerificationMeta('dataFabricacao');
  GeneratedColumn<DateTime>? _dataFabricacao;
  @override
  GeneratedColumn<DateTime> get dataFabricacao => _dataFabricacao ??=
      GeneratedColumn<DateTime>('DATA_FABRICACAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dataValidadeMeta =
      const VerificationMeta('dataValidade');
  GeneratedColumn<DateTime>? _dataValidade;
  @override
  GeneratedColumn<DateTime> get dataValidade => _dataValidade ??=
      GeneratedColumn<DateTime>('DATA_VALIDADE', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _codigoAgregacaoMeta =
      const VerificationMeta('codigoAgregacao');
  GeneratedColumn<String>? _codigoAgregacao;
  @override
  GeneratedColumn<String> get codigoAgregacao => _codigoAgregacao ??=
      GeneratedColumn<String>('CODIGO_AGREGACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        numeroLote,
        quantidadeItens,
        dataFabricacao,
        dataValidade,
        codigoAgregacao,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_ITEM_RASTREADO';
  
  @override
  String get actualTableName => 'NFE_ITEM_RASTREADO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeItemRastreado> instance,
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
    if (data.containsKey('NUMERO_LOTE')) {
        context.handle(_numeroLoteMeta,
            numeroLote.isAcceptableOrUnknown(data['NUMERO_LOTE']!, _numeroLoteMeta));
    }
    if (data.containsKey('QUANTIDADE_ITENS')) {
        context.handle(_quantidadeItensMeta,
            quantidadeItens.isAcceptableOrUnknown(data['QUANTIDADE_ITENS']!, _quantidadeItensMeta));
    }
    if (data.containsKey('DATA_FABRICACAO')) {
        context.handle(_dataFabricacaoMeta,
            dataFabricacao.isAcceptableOrUnknown(data['DATA_FABRICACAO']!, _dataFabricacaoMeta));
    }
    if (data.containsKey('DATA_VALIDADE')) {
        context.handle(_dataValidadeMeta,
            dataValidade.isAcceptableOrUnknown(data['DATA_VALIDADE']!, _dataValidadeMeta));
    }
    if (data.containsKey('CODIGO_AGREGACAO')) {
        context.handle(_codigoAgregacaoMeta,
            codigoAgregacao.isAcceptableOrUnknown(data['CODIGO_AGREGACAO']!, _codigoAgregacaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeItemRastreado map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeItemRastreado.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeItemRastreadosTable createAlias(String alias) {
    return $NfeItemRastreadosTable(_db, alias);
  }
}