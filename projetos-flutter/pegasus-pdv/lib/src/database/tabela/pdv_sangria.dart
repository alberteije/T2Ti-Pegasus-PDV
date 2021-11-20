/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_SANGRIA] 
                                                                                
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

@DataClassName("PdvSangria")
@UseRowClass(PdvSangria)
class PdvSangrias extends Table {
  @override
  String get tableName => 'PDV_SANGRIA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idPdvMovimento => integer().named('ID_PDV_MOVIMENTO').nullable().customConstraint('NULLABLE REFERENCES PDV_MOVIMENTO(ID)')();
  DateTimeColumn get dataSangria => dateTime().named('DATA_SANGRIA').nullable()();
  TextColumn get horaSangria => text().named('HORA_SANGRIA').withLength(min: 0, max: 8).nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
  TextColumn get observacao => text().named('OBSERVACAO').withLength(min: 0, max: 250).nullable()();
}

class PdvSangria extends DataClass implements Insertable<PdvSangria> {
  final int? id;
  final int? idPdvMovimento;
  final DateTime? dataSangria;
  final String? horaSangria;
  final double? valor;
  final String? observacao;

  PdvSangria(
    {
      required this.id,
      this.idPdvMovimento,
      this.dataSangria,
      this.horaSangria,
      this.valor,
      this.observacao,
    }
  );

  factory PdvSangria.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PdvSangria(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idPdvMovimento: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_MOVIMENTO']),
      dataSangria: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_SANGRIA']),
      horaSangria: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_SANGRIA']),
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
    if (!nullToAbsent || dataSangria != null) {
      map['DATA_SANGRIA'] = Variable<DateTime?>(dataSangria);
    }
    if (!nullToAbsent || horaSangria != null) {
      map['HORA_SANGRIA'] = Variable<String?>(horaSangria);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    if (!nullToAbsent || observacao != null) {
      map['OBSERVACAO'] = Variable<String?>(observacao);
    }
    return map;
  }

  PdvSangriasCompanion toCompanion(bool nullToAbsent) {
    return PdvSangriasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idPdvMovimento: idPdvMovimento == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvMovimento),
      dataSangria: dataSangria == null && nullToAbsent
        ? const Value.absent()
        : Value(dataSangria),
      horaSangria: horaSangria == null && nullToAbsent
        ? const Value.absent()
        : Value(horaSangria),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
      observacao: observacao == null && nullToAbsent
        ? const Value.absent()
        : Value(observacao),
    );
  }

  factory PdvSangria.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvSangria(
      id: serializer.fromJson<int>(json['id']),
      idPdvMovimento: serializer.fromJson<int>(json['idPdvMovimento']),
      dataSangria: serializer.fromJson<DateTime>(json['dataSangria']),
      horaSangria: serializer.fromJson<String>(json['horaSangria']),
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
      'dataSangria': serializer.toJson<DateTime?>(dataSangria),
      'horaSangria': serializer.toJson<String?>(horaSangria),
      'valor': serializer.toJson<double?>(valor),
      'observacao': serializer.toJson<String?>(observacao),
    };
  }

  PdvSangria copyWith(
        {
		  int? id,
          int? idPdvMovimento,
          DateTime? dataSangria,
          String? horaSangria,
          double? valor,
          String? observacao,
		}) =>
      PdvSangria(
        id: id ?? this.id,
        idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
        dataSangria: dataSangria ?? this.dataSangria,
        horaSangria: horaSangria ?? this.horaSangria,
        valor: valor ?? this.valor,
        observacao: observacao ?? this.observacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('PdvSangria(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('dataSangria: $dataSangria, ')
          ..write('horaSangria: $horaSangria, ')
          ..write('valor: $valor, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idPdvMovimento,
      dataSangria,
      horaSangria,
      valor,
      observacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdvSangria &&
          other.id == id &&
          other.idPdvMovimento == idPdvMovimento &&
          other.dataSangria == dataSangria &&
          other.horaSangria == horaSangria &&
          other.valor == valor &&
          other.observacao == observacao 
	   );
}

class PdvSangriasCompanion extends UpdateCompanion<PdvSangria> {

  final Value<int?> id;
  final Value<int?> idPdvMovimento;
  final Value<DateTime?> dataSangria;
  final Value<String?> horaSangria;
  final Value<double?> valor;
  final Value<String?> observacao;

  const PdvSangriasCompanion({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.dataSangria = const Value.absent(),
    this.horaSangria = const Value.absent(),
    this.valor = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  PdvSangriasCompanion.insert({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.dataSangria = const Value.absent(),
    this.horaSangria = const Value.absent(),
    this.valor = const Value.absent(),
    this.observacao = const Value.absent(),
  });

  static Insertable<PdvSangria> custom({
    Expression<int>? id,
    Expression<int>? idPdvMovimento,
    Expression<DateTime>? dataSangria,
    Expression<String>? horaSangria,
    Expression<double>? valor,
    Expression<String>? observacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idPdvMovimento != null) 'ID_PDV_MOVIMENTO': idPdvMovimento,
      if (dataSangria != null) 'DATA_SANGRIA': dataSangria,
      if (horaSangria != null) 'HORA_SANGRIA': horaSangria,
      if (valor != null) 'VALOR': valor,
      if (observacao != null) 'OBSERVACAO': observacao,
    });
  }

  PdvSangriasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idPdvMovimento,
      Value<DateTime>? dataSangria,
      Value<String>? horaSangria,
      Value<double>? valor,
      Value<String>? observacao,
	  }) {
    return PdvSangriasCompanion(
      id: id ?? this.id,
      idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
      dataSangria: dataSangria ?? this.dataSangria,
      horaSangria: horaSangria ?? this.horaSangria,
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
    if (dataSangria.present) {
      map['DATA_SANGRIA'] = Variable<DateTime?>(dataSangria.value);
    }
    if (horaSangria.present) {
      map['HORA_SANGRIA'] = Variable<String?>(horaSangria.value);
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
    return (StringBuffer('PdvSangriasCompanion(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('dataSangria: $dataSangria, ')
          ..write('horaSangria: $horaSangria, ')
          ..write('valor: $valor, ')
          ..write('observacao: $observacao, ')
          ..write(')'))
        .toString();
  }
}

class $PdvSangriasTable extends PdvSangrias
    with TableInfo<$PdvSangriasTable, PdvSangria> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PdvSangriasTable(this._db, [this._alias]);
  
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
  final VerificationMeta _dataSangriaMeta =
      const VerificationMeta('dataSangria');
  GeneratedColumn<DateTime>? _dataSangria;
  @override
  GeneratedColumn<DateTime> get dataSangria => _dataSangria ??=
      GeneratedColumn<DateTime>('DATA_SANGRIA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaSangriaMeta =
      const VerificationMeta('horaSangria');
  GeneratedColumn<String>? _horaSangria;
  @override
  GeneratedColumn<String> get horaSangria => _horaSangria ??=
      GeneratedColumn<String>('HORA_SANGRIA', aliasedName, true,
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
        dataSangria,
        horaSangria,
        valor,
        observacao,
      ];

  @override
  String get aliasedName => _alias ?? 'PDV_SANGRIA';
  
  @override
  String get actualTableName => 'PDV_SANGRIA';
  
  @override
  VerificationContext validateIntegrity(Insertable<PdvSangria> instance,
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
    if (data.containsKey('DATA_SANGRIA')) {
        context.handle(_dataSangriaMeta,
            dataSangria.isAcceptableOrUnknown(data['DATA_SANGRIA']!, _dataSangriaMeta));
    }
    if (data.containsKey('HORA_SANGRIA')) {
        context.handle(_horaSangriaMeta,
            horaSangria.isAcceptableOrUnknown(data['HORA_SANGRIA']!, _horaSangriaMeta));
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
  PdvSangria map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PdvSangria.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PdvSangriasTable createAlias(String alias) {
    return $PdvSangriasTable(_db, alias);
  }
}