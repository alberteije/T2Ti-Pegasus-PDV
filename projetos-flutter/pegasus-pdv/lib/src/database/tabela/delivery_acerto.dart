/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [DELIVERY_ACERTO] 
                                                                                
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

@DataClassName("DeliveryAcerto")
@UseRowClass(DeliveryAcerto)
class DeliveryAcertos extends Table {
  @override
  String get tableName => 'DELIVERY_ACERTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  DateTimeColumn get dataAcerto => dateTime().named('DATA_ACERTO').nullable()();
  TextColumn get horaAcerto => text().named('HORA_ACERTO').withLength(min: 0, max: 8).nullable()();
  RealColumn get valorRecebido => real().named('VALOR_RECEBIDO').nullable()();
  RealColumn get valorPagoEntregador => real().named('VALOR_PAGO_ENTREGADOR').nullable()();
  TextColumn get observacao => text().named('OBSERVACAO').withLength(min: 0, max: 250).nullable()();
}

class DeliveryAcerto extends DataClass implements Insertable<DeliveryAcerto> {
  final int? id;
  final DateTime? dataAcerto;
  final String? horaAcerto;
  final double? valorRecebido;
  final double? valorPagoEntregador;
  final String? observacao;

  DeliveryAcerto(
    {
      required this.id,
      this.dataAcerto,
      this.horaAcerto,
      this.valorRecebido,
      this.valorPagoEntregador,
      this.observacao,
    }
  );

  factory DeliveryAcerto.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DeliveryAcerto(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      dataAcerto: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_ACERTO']),
      horaAcerto: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_ACERTO']),
      valorRecebido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_RECEBIDO']),
      valorPagoEntregador: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PAGO_ENTREGADOR']),
      observacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}OBSERVACAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || dataAcerto != null) {
      map['DATA_ACERTO'] = Variable<DateTime?>(dataAcerto);
    }
    if (!nullToAbsent || horaAcerto != null) {
      map['HORA_ACERTO'] = Variable<String?>(horaAcerto);
    }
    if (!nullToAbsent || valorRecebido != null) {
      map['VALOR_RECEBIDO'] = Variable<double?>(valorRecebido);
    }
    if (!nullToAbsent || valorPagoEntregador != null) {
      map['VALOR_PAGO_ENTREGADOR'] = Variable<double?>(valorPagoEntregador);
    }
    if (!nullToAbsent || observacao != null) {
      map['OBSERVACAO'] = Variable<String?>(observacao);
    }
    return map;
  }

  DeliveryAcertosCompanion toCompanion(bool nullToAbsent) {
    return DeliveryAcertosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dataAcerto: dataAcerto == null && nullToAbsent
        ? const Value.absent()
        : Value(dataAcerto),
      horaAcerto: horaAcerto == null && nullToAbsent
        ? const Value.absent()
        : Value(horaAcerto),
      valorRecebido: valorRecebido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorRecebido),
      valorPagoEntregador: valorPagoEntregador == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPagoEntregador),
      observacao: observacao == null && nullToAbsent
        ? const Value.absent()
        : Value(observacao),
    );
  }

  factory DeliveryAcerto.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DeliveryAcerto(
      id: serializer.fromJson<int>(json['id']),
      dataAcerto: serializer.fromJson<DateTime>(json['dataAcerto']),
      horaAcerto: serializer.fromJson<String>(json['horaAcerto']),
      valorRecebido: serializer.fromJson<double>(json['valorRecebido']),
      valorPagoEntregador: serializer.fromJson<double>(json['valorPagoEntregador']),
      observacao: serializer.fromJson<String>(json['observacao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'dataAcerto': serializer.toJson<DateTime?>(dataAcerto),
      'horaAcerto': serializer.toJson<String?>(horaAcerto),
      'valorRecebido': serializer.toJson<double?>(valorRecebido),
      'valorPagoEntregador': serializer.toJson<double?>(valorPagoEntregador),
      'observacao': serializer.toJson<String?>(observacao),
    };
  }

  DeliveryAcerto copyWith(
        {
		  int? id,
          DateTime? dataAcerto,
          String? horaAcerto,
          double? valorRecebido,
          double? valorPagoEntregador,
          String? observacao,
		}) =>
      DeliveryAcerto(
        id: id ?? this.id,
        dataAcerto: dataAcerto ?? this.dataAcerto,
        horaAcerto: horaAcerto ?? this.horaAcerto,
        valorRecebido: valorRecebido ?? this.valorRecebido,
        valorPagoEntregador: valorPagoEntregador ?? this.valorPagoEntregador,
        observacao: observacao ?? this.observacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('DeliveryAcerto(')
          ..write('id: $id, ')
          ..write('dataAcerto: $dataAcerto, ')
          ..write('horaAcerto: $horaAcerto, ')
          ..write('valorRecebido: $valorRecebido, ')
          ..write('valorPagoEntregador: $valorPagoEntregador, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      dataAcerto,
      horaAcerto,
      valorRecebido,
      valorPagoEntregador,
      observacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryAcerto &&
          other.id == id &&
          other.dataAcerto == dataAcerto &&
          other.horaAcerto == horaAcerto &&
          other.valorRecebido == valorRecebido &&
          other.valorPagoEntregador == valorPagoEntregador &&
          other.observacao == observacao 
	   );
}

class DeliveryAcertosCompanion extends UpdateCompanion<DeliveryAcerto> {

  final Value<int?> id;
  final Value<DateTime?> dataAcerto;
  final Value<String?> horaAcerto;
  final Value<double?> valorRecebido;
  final Value<double?> valorPagoEntregador;
  final Value<String?> observacao;

  const DeliveryAcertosCompanion({
    this.id = const Value.absent(),
    this.dataAcerto = const Value.absent(),
    this.horaAcerto = const Value.absent(),
    this.valorRecebido = const Value.absent(),
    this.valorPagoEntregador = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  DeliveryAcertosCompanion.insert({
    this.id = const Value.absent(),
    this.dataAcerto = const Value.absent(),
    this.horaAcerto = const Value.absent(),
    this.valorRecebido = const Value.absent(),
    this.valorPagoEntregador = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  static Insertable<DeliveryAcerto> custom({
    Expression<int>? id,
    Expression<DateTime>? dataAcerto,
    Expression<String>? horaAcerto,
    Expression<double>? valorRecebido,
    Expression<double>? valorPagoEntregador,
    Expression<String>? observacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (dataAcerto != null) 'DATA_ACERTO': dataAcerto,
      if (horaAcerto != null) 'HORA_ACERTO': horaAcerto,
      if (valorRecebido != null) 'VALOR_RECEBIDO': valorRecebido,
      if (valorPagoEntregador != null) 'VALOR_PAGO_ENTREGADOR': valorPagoEntregador,
      if (observacao != null) 'OBSERVACAO': observacao,
    });
  }

  DeliveryAcertosCompanion copyWith(
      {
	  Value<int>? id,
      Value<DateTime>? dataAcerto,
      Value<String>? horaAcerto,
      Value<double>? valorRecebido,
      Value<double>? valorPagoEntregador,
      Value<String>? observacao,
	  }) {
    return DeliveryAcertosCompanion(
      id: id ?? this.id,
      dataAcerto: dataAcerto ?? this.dataAcerto,
      horaAcerto: horaAcerto ?? this.horaAcerto,
      valorRecebido: valorRecebido ?? this.valorRecebido,
      valorPagoEntregador: valorPagoEntregador ?? this.valorPagoEntregador,
      observacao: observacao ?? this.observacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (dataAcerto.present) {
      map['DATA_ACERTO'] = Variable<DateTime?>(dataAcerto.value);
    }
    if (horaAcerto.present) {
      map['HORA_ACERTO'] = Variable<String?>(horaAcerto.value);
    }
    if (valorRecebido.present) {
      map['VALOR_RECEBIDO'] = Variable<double?>(valorRecebido.value);
    }
    if (valorPagoEntregador.present) {
      map['VALOR_PAGO_ENTREGADOR'] = Variable<double?>(valorPagoEntregador.value);
    }
    if (observacao.present) {
      map['OBSERVACAO'] = Variable<String?>(observacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryAcertosCompanion(')
          ..write('id: $id, ')
          ..write('dataAcerto: $dataAcerto, ')
          ..write('horaAcerto: $horaAcerto, ')
          ..write('valorRecebido: $valorRecebido, ')
          ..write('valorPagoEntregador: $valorPagoEntregador, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }
}

class $DeliveryAcertosTable extends DeliveryAcertos
    with TableInfo<$DeliveryAcertosTable, DeliveryAcerto> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DeliveryAcertosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _dataAcertoMeta =
      const VerificationMeta('dataAcerto');
  GeneratedColumn<DateTime>? _dataAcerto;
  @override
  GeneratedColumn<DateTime> get dataAcerto => _dataAcerto ??=
      GeneratedColumn<DateTime>('DATA_ACERTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaAcertoMeta =
      const VerificationMeta('horaAcerto');
  GeneratedColumn<String>? _horaAcerto;
  @override
  GeneratedColumn<String> get horaAcerto => _horaAcerto ??=
      GeneratedColumn<String>('HORA_ACERTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorRecebidoMeta =
      const VerificationMeta('valorRecebido');
  GeneratedColumn<double>? _valorRecebido;
  @override
  GeneratedColumn<double> get valorRecebido => _valorRecebido ??=
      GeneratedColumn<double>('VALOR_RECEBIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPagoEntregadorMeta =
      const VerificationMeta('valorPagoEntregador');
  GeneratedColumn<double>? _valorPagoEntregador;
  @override
  GeneratedColumn<double> get valorPagoEntregador => _valorPagoEntregador ??=
      GeneratedColumn<double>('VALOR_PAGO_ENTREGADOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
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
        dataAcerto,
        horaAcerto,
        valorRecebido,
        valorPagoEntregador,
        observacao,
      ];

  @override
  String get aliasedName => _alias ?? 'DELIVERY_ACERTO';
  
  @override
  String get actualTableName => 'DELIVERY_ACERTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<DeliveryAcerto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('DATA_ACERTO')) {
        context.handle(_dataAcertoMeta,
            dataAcerto.isAcceptableOrUnknown(data['DATA_ACERTO']!, _dataAcertoMeta));
    }
    if (data.containsKey('HORA_ACERTO')) {
        context.handle(_horaAcertoMeta,
            horaAcerto.isAcceptableOrUnknown(data['HORA_ACERTO']!, _horaAcertoMeta));
    }
    if (data.containsKey('VALOR_RECEBIDO')) {
        context.handle(_valorRecebidoMeta,
            valorRecebido.isAcceptableOrUnknown(data['VALOR_RECEBIDO']!, _valorRecebidoMeta));
    }
    if (data.containsKey('VALOR_PAGO_ENTREGADOR')) {
        context.handle(_valorPagoEntregadorMeta,
            valorPagoEntregador.isAcceptableOrUnknown(data['VALOR_PAGO_ENTREGADOR']!, _valorPagoEntregadorMeta));
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
  DeliveryAcerto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DeliveryAcerto.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DeliveryAcertosTable createAlias(String alias) {
    return $DeliveryAcertosTable(_db, alias);
  }
}