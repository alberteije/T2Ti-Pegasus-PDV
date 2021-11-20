/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_SUPRIMENTO] 
                                                                                
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

@DataClassName("PdvSuprimento")
@UseRowClass(PdvSuprimento)
class PdvSuprimentos extends Table {
  @override
  String get tableName => 'PDV_SUPRIMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idPdvMovimento => integer().named('ID_PDV_MOVIMENTO').nullable().customConstraint('NULLABLE REFERENCES PDV_MOVIMENTO(ID)')();
  DateTimeColumn get dataSuprimento => dateTime().named('DATA_SUPRIMENTO').nullable()();
  TextColumn get horaSuprimento => text().named('HORA_SUPRIMENTO').withLength(min: 0, max: 8).nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
  TextColumn get observacao => text().named('OBSERVACAO').withLength(min: 0, max: 250).nullable()();
}

class PdvSuprimento extends DataClass implements Insertable<PdvSuprimento> {
  final int? id;
  final int? idPdvMovimento;
  final DateTime? dataSuprimento;
  final String? horaSuprimento;
  final double? valor;
  final String? observacao;

  PdvSuprimento(
    {
      required this.id,
      this.idPdvMovimento,
      this.dataSuprimento,
      this.horaSuprimento,
      this.valor,
      this.observacao,
    }
  );

  factory PdvSuprimento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PdvSuprimento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idPdvMovimento: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_MOVIMENTO']),
      dataSuprimento: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_SUPRIMENTO']),
      horaSuprimento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_SUPRIMENTO']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
      observacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}OBSERVACAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idPdvMovimento != null) {
      map['ID_PDV_MOVIMENTO'] = Variable<int?>(idPdvMovimento);
    }
    if (!nullToAbsent || dataSuprimento != null) {
      map['DATA_SUPRIMENTO'] = Variable<DateTime?>(dataSuprimento);
    }
    if (!nullToAbsent || horaSuprimento != null) {
      map['HORA_SUPRIMENTO'] = Variable<String?>(horaSuprimento);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    if (!nullToAbsent || observacao != null) {
      map['OBSERVACAO'] = Variable<String?>(observacao);
    }
    return map;
  }

  PdvSuprimentosCompanion toCompanion(bool nullToAbsent) {
    return PdvSuprimentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idPdvMovimento: idPdvMovimento == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvMovimento),
      dataSuprimento: dataSuprimento == null && nullToAbsent
        ? const Value.absent()
        : Value(dataSuprimento),
      horaSuprimento: horaSuprimento == null && nullToAbsent
        ? const Value.absent()
        : Value(horaSuprimento),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
      observacao: observacao == null && nullToAbsent
        ? const Value.absent()
        : Value(observacao),
    );
  }

  factory PdvSuprimento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvSuprimento(
      id: serializer.fromJson<int>(json['id']),
      idPdvMovimento: serializer.fromJson<int>(json['idPdvMovimento']),
      dataSuprimento: serializer.fromJson<DateTime>(json['dataSuprimento']),
      horaSuprimento: serializer.fromJson<String>(json['horaSuprimento']),
      valor: serializer.fromJson<double>(json['valor']),
      observacao: serializer.fromJson<String>(json['observacao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idPdvMovimento': serializer.toJson<int?>(idPdvMovimento),
      'dataSuprimento': serializer.toJson<DateTime?>(dataSuprimento),
      'horaSuprimento': serializer.toJson<String?>(horaSuprimento),
      'valor': serializer.toJson<double?>(valor),
      'observacao': serializer.toJson<String?>(observacao),
    };
  }

  PdvSuprimento copyWith(
        {
		  int? id,
          int? idPdvMovimento,
          DateTime? dataSuprimento,
          String? horaSuprimento,
          double? valor,
          String? observacao,
		}) =>
      PdvSuprimento(
        id: id ?? this.id,
        idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
        dataSuprimento: dataSuprimento ?? this.dataSuprimento,
        horaSuprimento: horaSuprimento ?? this.horaSuprimento,
        valor: valor ?? this.valor,
        observacao: observacao ?? this.observacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('PdvSuprimento(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('dataSuprimento: $dataSuprimento, ')
          ..write('horaSuprimento: $horaSuprimento, ')
          ..write('valor: $valor, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idPdvMovimento,
      dataSuprimento,
      horaSuprimento,
      valor,
      observacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdvSuprimento &&
          other.id == id &&
          other.idPdvMovimento == idPdvMovimento &&
          other.dataSuprimento == dataSuprimento &&
          other.horaSuprimento == horaSuprimento &&
          other.valor == valor &&
          other.observacao == observacao 
	   );
}

class PdvSuprimentosCompanion extends UpdateCompanion<PdvSuprimento> {

  final Value<int?> id;
  final Value<int?> idPdvMovimento;
  final Value<DateTime?> dataSuprimento;
  final Value<String?> horaSuprimento;
  final Value<double?> valor;
  final Value<String?> observacao;

  const PdvSuprimentosCompanion({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.dataSuprimento = const Value.absent(),
    this.horaSuprimento = const Value.absent(),
    this.valor = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  PdvSuprimentosCompanion.insert({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.dataSuprimento = const Value.absent(),
    this.horaSuprimento = const Value.absent(),
    this.valor = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  static Insertable<PdvSuprimento> custom({
    Expression<int>? id,
    Expression<int>? idPdvMovimento,
    Expression<DateTime>? dataSuprimento,
    Expression<String>? horaSuprimento,
    Expression<double>? valor,
    Expression<String>? observacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idPdvMovimento != null) 'ID_PDV_MOVIMENTO': idPdvMovimento,
      if (dataSuprimento != null) 'DATA_SUPRIMENTO': dataSuprimento,
      if (horaSuprimento != null) 'HORA_SUPRIMENTO': horaSuprimento,
      if (valor != null) 'VALOR': valor,
      if (observacao != null) 'OBSERVACAO': observacao,
    });
  }

  PdvSuprimentosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idPdvMovimento,
      Value<DateTime>? dataSuprimento,
      Value<String>? horaSuprimento,
      Value<double>? valor,
      Value<String>? observacao,
	  }) {
    return PdvSuprimentosCompanion(
      id: id ?? this.id,
      idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
      dataSuprimento: dataSuprimento ?? this.dataSuprimento,
      horaSuprimento: horaSuprimento ?? this.horaSuprimento,
      valor: valor ?? this.valor,
      observacao: observacao ?? this.observacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idPdvMovimento.present) {
      map['ID_PDV_MOVIMENTO'] = Variable<int?>(idPdvMovimento.value);
    }
    if (dataSuprimento.present) {
      map['DATA_SUPRIMENTO'] = Variable<DateTime?>(dataSuprimento.value);
    }
    if (horaSuprimento.present) {
      map['HORA_SUPRIMENTO'] = Variable<String?>(horaSuprimento.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    if (observacao.present) {
      map['OBSERVACAO'] = Variable<String?>(observacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdvSuprimentosCompanion(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('dataSuprimento: $dataSuprimento, ')
          ..write('horaSuprimento: $horaSuprimento, ')
          ..write('valor: $valor, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }
}

class $PdvSuprimentosTable extends PdvSuprimentos
    with TableInfo<$PdvSuprimentosTable, PdvSuprimento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PdvSuprimentosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idPdvMovimentoMeta =
      const VerificationMeta('idPdvMovimento');
  GeneratedColumn<int>? _idPdvMovimento;
  @override
  GeneratedColumn<int> get idPdvMovimento =>
      _idPdvMovimento ??= GeneratedColumn<int>('ID_PDV_MOVIMENTO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PDV_MOVIMENTO(ID)');
  final VerificationMeta _dataSuprimentoMeta =
      const VerificationMeta('dataSuprimento');
  GeneratedColumn<DateTime>? _dataSuprimento;
  @override
  GeneratedColumn<DateTime> get dataSuprimento => _dataSuprimento ??=
      GeneratedColumn<DateTime>('DATA_SUPRIMENTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaSuprimentoMeta =
      const VerificationMeta('horaSuprimento');
  GeneratedColumn<String>? _horaSuprimento;
  @override
  GeneratedColumn<String> get horaSuprimento => _horaSuprimento ??=
      GeneratedColumn<String>('HORA_SUPRIMENTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorMeta =
      const VerificationMeta('valor');
  GeneratedColumn<double>? _valor;
  @override
  GeneratedColumn<double> get valor => _valor ??=
      GeneratedColumn<double>('VALOR', aliasedName, true,
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
        idPdvMovimento,
        dataSuprimento,
        horaSuprimento,
        valor,
        observacao,
      ];

  @override
  String get aliasedName => _alias ?? 'PDV_SUPRIMENTO';
  
  @override
  String get actualTableName => 'PDV_SUPRIMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<PdvSuprimento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_PDV_MOVIMENTO')) {
        context.handle(_idPdvMovimentoMeta,
            idPdvMovimento.isAcceptableOrUnknown(data['ID_PDV_MOVIMENTO']!, _idPdvMovimentoMeta));
    }
    if (data.containsKey('DATA_SUPRIMENTO')) {
        context.handle(_dataSuprimentoMeta,
            dataSuprimento.isAcceptableOrUnknown(data['DATA_SUPRIMENTO']!, _dataSuprimentoMeta));
    }
    if (data.containsKey('HORA_SUPRIMENTO')) {
        context.handle(_horaSuprimentoMeta,
            horaSuprimento.isAcceptableOrUnknown(data['HORA_SUPRIMENTO']!, _horaSuprimentoMeta));
    }
    if (data.containsKey('VALOR')) {
        context.handle(_valorMeta,
            valor.isAcceptableOrUnknown(data['VALOR']!, _valorMeta));
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
  PdvSuprimento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PdvSuprimento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PdvSuprimentosTable createAlias(String alias) {
    return $PdvSuprimentosTable(_db, alias);
  }
}