/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [EMPRESA_DELIVERY_PEDIDO] 
                                                                                
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

@DataClassName("EmpresaDeliveryPedido")
@UseRowClass(EmpresaDeliveryPedido)
class EmpresaDeliveryPedidos extends Table {
  @override
  String get tableName => 'EMPRESA_DELIVERY_PEDIDO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get codigoPedidoEmpresa => text().named('CODIGO_PEDIDO_EMPRESA').withLength(min: 0, max: 100).nullable()();
  TextColumn get conteudoJson => text().named('CONTEUDO_JSON').withLength(min: 0, max: 250).nullable()();
  TextColumn get observacao => text().named('OBSERVACAO').withLength(min: 0, max: 250).nullable()();
  DateTimeColumn get dataSolicitacao => dateTime().named('DATA_SOLICITACAO').nullable()();
  TextColumn get horaSolicitacao => text().named('HORA_SOLICITACAO').withLength(min: 0, max: 8).nullable()();
}

class EmpresaDeliveryPedido extends DataClass implements Insertable<EmpresaDeliveryPedido> {
  final int? id;
  final String? codigoPedidoEmpresa;
  final String? conteudoJson;
  final String? observacao;
  final DateTime? dataSolicitacao;
  final String? horaSolicitacao;

  EmpresaDeliveryPedido(
    {
      required this.id,
      this.codigoPedidoEmpresa,
      this.conteudoJson,
      this.observacao,
      this.dataSolicitacao,
      this.horaSolicitacao,
    }
  );

  factory EmpresaDeliveryPedido.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EmpresaDeliveryPedido(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      codigoPedidoEmpresa: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_PEDIDO_EMPRESA']),
      conteudoJson: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CONTEUDO_JSON']),
      observacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}OBSERVACAO']),
      dataSolicitacao: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_SOLICITACAO']),
      horaSolicitacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_SOLICITACAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || codigoPedidoEmpresa != null) {
      map['CODIGO_PEDIDO_EMPRESA'] = Variable<String?>(codigoPedidoEmpresa);
    }
    if (!nullToAbsent || conteudoJson != null) {
      map['CONTEUDO_JSON'] = Variable<String?>(conteudoJson);
    }
    if (!nullToAbsent || observacao != null) {
      map['OBSERVACAO'] = Variable<String?>(observacao);
    }
    if (!nullToAbsent || dataSolicitacao != null) {
      map['DATA_SOLICITACAO'] = Variable<DateTime?>(dataSolicitacao);
    }
    if (!nullToAbsent || horaSolicitacao != null) {
      map['HORA_SOLICITACAO'] = Variable<String?>(horaSolicitacao);
    }
    return map;
  }

  EmpresaDeliveryPedidosCompanion toCompanion(bool nullToAbsent) {
    return EmpresaDeliveryPedidosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      codigoPedidoEmpresa: codigoPedidoEmpresa == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoPedidoEmpresa),
      conteudoJson: conteudoJson == null && nullToAbsent
        ? const Value.absent()
        : Value(conteudoJson),
      observacao: observacao == null && nullToAbsent
        ? const Value.absent()
        : Value(observacao),
      dataSolicitacao: dataSolicitacao == null && nullToAbsent
        ? const Value.absent()
        : Value(dataSolicitacao),
      horaSolicitacao: horaSolicitacao == null && nullToAbsent
        ? const Value.absent()
        : Value(horaSolicitacao),
    );
  }

  factory EmpresaDeliveryPedido.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EmpresaDeliveryPedido(
      id: serializer.fromJson<int>(json['id']),
      codigoPedidoEmpresa: serializer.fromJson<String>(json['codigoPedidoEmpresa']),
      conteudoJson: serializer.fromJson<String>(json['conteudoJson']),
      observacao: serializer.fromJson<String>(json['observacao']),
      dataSolicitacao: serializer.fromJson<DateTime>(json['dataSolicitacao']),
      horaSolicitacao: serializer.fromJson<String>(json['horaSolicitacao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'codigoPedidoEmpresa': serializer.toJson<String?>(codigoPedidoEmpresa),
      'conteudoJson': serializer.toJson<String?>(conteudoJson),
      'observacao': serializer.toJson<String?>(observacao),
      'dataSolicitacao': serializer.toJson<DateTime?>(dataSolicitacao),
      'horaSolicitacao': serializer.toJson<String?>(horaSolicitacao),
    };
  }

  EmpresaDeliveryPedido copyWith(
        {
		  int? id,
          String? codigoPedidoEmpresa,
          String? conteudoJson,
          String? observacao,
          DateTime? dataSolicitacao,
          String? horaSolicitacao,
		}) =>
      EmpresaDeliveryPedido(
        id: id ?? this.id,
        codigoPedidoEmpresa: codigoPedidoEmpresa ?? this.codigoPedidoEmpresa,
        conteudoJson: conteudoJson ?? this.conteudoJson,
        observacao: observacao ?? this.observacao,
        dataSolicitacao: dataSolicitacao ?? this.dataSolicitacao,
        horaSolicitacao: horaSolicitacao ?? this.horaSolicitacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('EmpresaDeliveryPedido(')
          ..write('id: $id, ')
          ..write('codigoPedidoEmpresa: $codigoPedidoEmpresa, ')
          ..write('conteudoJson: $conteudoJson, ')
          ..write('observacao: $observacao, ')
          ..write('dataSolicitacao: $dataSolicitacao, ')
          ..write('horaSolicitacao: $horaSolicitacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      codigoPedidoEmpresa,
      conteudoJson,
      observacao,
      dataSolicitacao,
      horaSolicitacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmpresaDeliveryPedido &&
          other.id == id &&
          other.codigoPedidoEmpresa == codigoPedidoEmpresa &&
          other.conteudoJson == conteudoJson &&
          other.observacao == observacao &&
          other.dataSolicitacao == dataSolicitacao &&
          other.horaSolicitacao == horaSolicitacao 
	   );
}

class EmpresaDeliveryPedidosCompanion extends UpdateCompanion<EmpresaDeliveryPedido> {

  final Value<int?> id;
  final Value<String?> codigoPedidoEmpresa;
  final Value<String?> conteudoJson;
  final Value<String?> observacao;
  final Value<DateTime?> dataSolicitacao;
  final Value<String?> horaSolicitacao;

  const EmpresaDeliveryPedidosCompanion({
    this.id = const Value.absent(),
    this.codigoPedidoEmpresa = const Value.absent(),
    this.conteudoJson = const Value.absent(),
    this.observacao = const Value.absent(),
    this.dataSolicitacao = const Value.absent(),
    this.horaSolicitacao = const Value.absent(),
  });

  EmpresaDeliveryPedidosCompanion.insert({
    this.id = const Value.absent(),
    this.codigoPedidoEmpresa = const Value.absent(),
    this.conteudoJson = const Value.absent(),
    this.observacao = const Value.absent(),
    this.dataSolicitacao = const Value.absent(),
    this.horaSolicitacao = const Value.absent(),
  });

  static Insertable<EmpresaDeliveryPedido> custom({
    Expression<int>? id,
    Expression<String>? codigoPedidoEmpresa,
    Expression<String>? conteudoJson,
    Expression<String>? observacao,
    Expression<DateTime>? dataSolicitacao,
    Expression<String>? horaSolicitacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (codigoPedidoEmpresa != null) 'CODIGO_PEDIDO_EMPRESA': codigoPedidoEmpresa,
      if (conteudoJson != null) 'CONTEUDO_JSON': conteudoJson,
      if (observacao != null) 'OBSERVACAO': observacao,
      if (dataSolicitacao != null) 'DATA_SOLICITACAO': dataSolicitacao,
      if (horaSolicitacao != null) 'HORA_SOLICITACAO': horaSolicitacao,
    });
  }

  EmpresaDeliveryPedidosCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? codigoPedidoEmpresa,
      Value<String>? conteudoJson,
      Value<String>? observacao,
      Value<DateTime>? dataSolicitacao,
      Value<String>? horaSolicitacao,
	  }) {
    return EmpresaDeliveryPedidosCompanion(
      id: id ?? this.id,
      codigoPedidoEmpresa: codigoPedidoEmpresa ?? this.codigoPedidoEmpresa,
      conteudoJson: conteudoJson ?? this.conteudoJson,
      observacao: observacao ?? this.observacao,
      dataSolicitacao: dataSolicitacao ?? this.dataSolicitacao,
      horaSolicitacao: horaSolicitacao ?? this.horaSolicitacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (codigoPedidoEmpresa.present) {
      map['CODIGO_PEDIDO_EMPRESA'] = Variable<String?>(codigoPedidoEmpresa.value);
    }
    if (conteudoJson.present) {
      map['CONTEUDO_JSON'] = Variable<String?>(conteudoJson.value);
    }
    if (observacao.present) {
      map['OBSERVACAO'] = Variable<String?>(observacao.value);
    }
    if (dataSolicitacao.present) {
      map['DATA_SOLICITACAO'] = Variable<DateTime?>(dataSolicitacao.value);
    }
    if (horaSolicitacao.present) {
      map['HORA_SOLICITACAO'] = Variable<String?>(horaSolicitacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmpresaDeliveryPedidosCompanion(')
          ..write('id: $id, ')
          ..write('codigoPedidoEmpresa: $codigoPedidoEmpresa, ')
          ..write('conteudoJson: $conteudoJson, ')
          ..write('observacao: $observacao, ')
          ..write('dataSolicitacao: $dataSolicitacao, ')
          ..write('horaSolicitacao: $horaSolicitacao, ')
          ..write(')'))
        .toString();
  }
}

class $EmpresaDeliveryPedidosTable extends EmpresaDeliveryPedidos
    with TableInfo<$EmpresaDeliveryPedidosTable, EmpresaDeliveryPedido> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EmpresaDeliveryPedidosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _codigoPedidoEmpresaMeta =
      const VerificationMeta('codigoPedidoEmpresa');
  GeneratedColumn<String>? _codigoPedidoEmpresa;
  @override
  GeneratedColumn<String> get codigoPedidoEmpresa => _codigoPedidoEmpresa ??=
      GeneratedColumn<String>('CODIGO_PEDIDO_EMPRESA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _conteudoJsonMeta =
      const VerificationMeta('conteudoJson');
  GeneratedColumn<String>? _conteudoJson;
  @override
  GeneratedColumn<String> get conteudoJson => _conteudoJson ??=
      GeneratedColumn<String>('CONTEUDO_JSON', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  GeneratedColumn<String>? _observacao;
  @override
  GeneratedColumn<String> get observacao => _observacao ??=
      GeneratedColumn<String>('OBSERVACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dataSolicitacaoMeta =
      const VerificationMeta('dataSolicitacao');
  GeneratedColumn<DateTime>? _dataSolicitacao;
  @override
  GeneratedColumn<DateTime> get dataSolicitacao => _dataSolicitacao ??=
      GeneratedColumn<DateTime>('DATA_SOLICITACAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaSolicitacaoMeta =
      const VerificationMeta('horaSolicitacao');
  GeneratedColumn<String>? _horaSolicitacao;
  @override
  GeneratedColumn<String> get horaSolicitacao => _horaSolicitacao ??=
      GeneratedColumn<String>('HORA_SOLICITACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        codigoPedidoEmpresa,
        conteudoJson,
        observacao,
        dataSolicitacao,
        horaSolicitacao,
      ];

  @override
  String get aliasedName => _alias ?? 'EMPRESA_DELIVERY_PEDIDO';
  
  @override
  String get actualTableName => 'EMPRESA_DELIVERY_PEDIDO';
  
  @override
  VerificationContext validateIntegrity(Insertable<EmpresaDeliveryPedido> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('CODIGO_PEDIDO_EMPRESA')) {
        context.handle(_codigoPedidoEmpresaMeta,
            codigoPedidoEmpresa.isAcceptableOrUnknown(data['CODIGO_PEDIDO_EMPRESA']!, _codigoPedidoEmpresaMeta));
    }
    if (data.containsKey('CONTEUDO_JSON')) {
        context.handle(_conteudoJsonMeta,
            conteudoJson.isAcceptableOrUnknown(data['CONTEUDO_JSON']!, _conteudoJsonMeta));
    }
    if (data.containsKey('OBSERVACAO')) {
        context.handle(_observacaoMeta,
            observacao.isAcceptableOrUnknown(data['OBSERVACAO']!, _observacaoMeta));
    }
    if (data.containsKey('DATA_SOLICITACAO')) {
        context.handle(_dataSolicitacaoMeta,
            dataSolicitacao.isAcceptableOrUnknown(data['DATA_SOLICITACAO']!, _dataSolicitacaoMeta));
    }
    if (data.containsKey('HORA_SOLICITACAO')) {
        context.handle(_horaSolicitacaoMeta,
            horaSolicitacao.isAcceptableOrUnknown(data['HORA_SOLICITACAO']!, _horaSolicitacaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmpresaDeliveryPedido map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EmpresaDeliveryPedido.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EmpresaDeliveryPedidosTable createAlias(String alias) {
    return $EmpresaDeliveryPedidosTable(_db, alias);
  }
}