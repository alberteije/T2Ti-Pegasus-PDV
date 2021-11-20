/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DUPLICATA] 
                                                                                
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

@DataClassName("NfeDuplicata")
@UseRowClass(NfeDuplicata)
class NfeDuplicatas extends Table {
  @override
  String get tableName => 'NFE_DUPLICATA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeFatura => integer().named('ID_NFE_FATURA').nullable().customConstraint('NULLABLE REFERENCES NFE_FATURA(ID)')();
  TextColumn get numero => text().named('NUMERO').withLength(min: 0, max: 60).nullable()();
  DateTimeColumn get dataVencimento => dateTime().named('DATA_VENCIMENTO').nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
}

class NfeDuplicata extends DataClass implements Insertable<NfeDuplicata> {
  final int? id;
  final int? idNfeFatura;
  final String? numero;
  final DateTime? dataVencimento;
  final double? valor;

  NfeDuplicata(
    {
      required this.id,
      this.idNfeFatura,
      this.numero,
      this.dataVencimento,
      this.valor,
    }
  );

  factory NfeDuplicata.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDuplicata(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeFatura: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_FATURA']),
      numero: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO']),
      dataVencimento: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_VENCIMENTO']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeFatura != null) {
      map['ID_NFE_FATURA'] = Variable<int?>(idNfeFatura);
    }
    if (!nullToAbsent || numero != null) {
      map['NUMERO'] = Variable<String?>(numero);
    }
    if (!nullToAbsent || dataVencimento != null) {
      map['DATA_VENCIMENTO'] = Variable<DateTime?>(dataVencimento);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    return map;
  }

  NfeDuplicatasCompanion toCompanion(bool nullToAbsent) {
    return NfeDuplicatasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeFatura: idNfeFatura == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeFatura),
      numero: numero == null && nullToAbsent
        ? const Value.absent()
        : Value(numero),
      dataVencimento: dataVencimento == null && nullToAbsent
        ? const Value.absent()
        : Value(dataVencimento),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
    );
  }

  factory NfeDuplicata.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDuplicata(
      id: serializer.fromJson<int>(json['id']),
      idNfeFatura: serializer.fromJson<int>(json['idNfeFatura']),
      numero: serializer.fromJson<String>(json['numero']),
      dataVencimento: serializer.fromJson<DateTime>(json['dataVencimento']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeFatura': serializer.toJson<int?>(idNfeFatura),
      'numero': serializer.toJson<String?>(numero),
      'dataVencimento': serializer.toJson<DateTime?>(dataVencimento),
      'valor': serializer.toJson<double?>(valor),
    };
  }

  NfeDuplicata copyWith(
        {
		  int? id,
          int? idNfeFatura,
          String? numero,
          DateTime? dataVencimento,
          double? valor,
		}) =>
      NfeDuplicata(
        id: id ?? this.id,
        idNfeFatura: idNfeFatura ?? this.idNfeFatura,
        numero: numero ?? this.numero,
        dataVencimento: dataVencimento ?? this.dataVencimento,
        valor: valor ?? this.valor,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDuplicata(')
          ..write('id: $id, ')
          ..write('idNfeFatura: $idNfeFatura, ')
          ..write('numero: $numero, ')
          ..write('dataVencimento: $dataVencimento, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeFatura,
      numero,
      dataVencimento,
      valor,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDuplicata &&
          other.id == id &&
          other.idNfeFatura == idNfeFatura &&
          other.numero == numero &&
          other.dataVencimento == dataVencimento &&
          other.valor == valor 
	   );
}

class NfeDuplicatasCompanion extends UpdateCompanion<NfeDuplicata> {

  final Value<int?> id;
  final Value<int?> idNfeFatura;
  final Value<String?> numero;
  final Value<DateTime?> dataVencimento;
  final Value<double?> valor;

  const NfeDuplicatasCompanion({
    this.id = const Value.absent(),
    this.idNfeFatura = const Value.absent(),
    this.numero = const Value.absent(),
    this.dataVencimento = const Value.absent(),
    this.valor = const Value.absent(),
  });

  NfeDuplicatasCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeFatura = const Value.absent(),
    this.numero = const Value.absent(),
    this.dataVencimento = const Value.absent(),
    this.valor = const Value.absent(),
  });

  static Insertable<NfeDuplicata> custom({
    Expression<int>? id,
    Expression<int>? idNfeFatura,
    Expression<String>? numero,
    Expression<DateTime>? dataVencimento,
    Expression<double>? valor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeFatura != null) 'ID_NFE_FATURA': idNfeFatura,
      if (numero != null) 'NUMERO': numero,
      if (dataVencimento != null) 'DATA_VENCIMENTO': dataVencimento,
      if (valor != null) 'VALOR': valor,
    });
  }

  NfeDuplicatasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeFatura,
      Value<String>? numero,
      Value<DateTime>? dataVencimento,
      Value<double>? valor,
	  }) {
    return NfeDuplicatasCompanion(
      id: id ?? this.id,
      idNfeFatura: idNfeFatura ?? this.idNfeFatura,
      numero: numero ?? this.numero,
      dataVencimento: dataVencimento ?? this.dataVencimento,
      valor: valor ?? this.valor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeFatura.present) {
      map['ID_NFE_FATURA'] = Variable<int?>(idNfeFatura.value);
    }
    if (numero.present) {
      map['NUMERO'] = Variable<String?>(numero.value);
    }
    if (dataVencimento.present) {
      map['DATA_VENCIMENTO'] = Variable<DateTime?>(dataVencimento.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDuplicatasCompanion(')
          ..write('id: $id, ')
          ..write('idNfeFatura: $idNfeFatura, ')
          ..write('numero: $numero, ')
          ..write('dataVencimento: $dataVencimento, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDuplicatasTable extends NfeDuplicatas
    with TableInfo<$NfeDuplicatasTable, NfeDuplicata> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDuplicatasTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeFaturaMeta =
      const VerificationMeta('idNfeFatura');
  GeneratedColumn<int>? _idNfeFatura;
  @override
  GeneratedColumn<int> get idNfeFatura =>
      _idNfeFatura ??= GeneratedColumn<int>('ID_NFE_FATURA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_FATURA(ID)');
  final VerificationMeta _numeroMeta =
      const VerificationMeta('numero');
  GeneratedColumn<String>? _numero;
  @override
  GeneratedColumn<String> get numero => _numero ??=
      GeneratedColumn<String>('NUMERO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dataVencimentoMeta =
      const VerificationMeta('dataVencimento');
  GeneratedColumn<DateTime>? _dataVencimento;
  @override
  GeneratedColumn<DateTime> get dataVencimento => _dataVencimento ??=
      GeneratedColumn<DateTime>('DATA_VENCIMENTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _valorMeta =
      const VerificationMeta('valor');
  GeneratedColumn<double>? _valor;
  @override
  GeneratedColumn<double> get valor => _valor ??=
      GeneratedColumn<double>('VALOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeFatura,
        numero,
        dataVencimento,
        valor,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DUPLICATA';
  
  @override
  String get actualTableName => 'NFE_DUPLICATA';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDuplicata> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_FATURA')) {
        context.handle(_idNfeFaturaMeta,
            idNfeFatura.isAcceptableOrUnknown(data['ID_NFE_FATURA']!, _idNfeFaturaMeta));
    }
    if (data.containsKey('NUMERO')) {
        context.handle(_numeroMeta,
            numero.isAcceptableOrUnknown(data['NUMERO']!, _numeroMeta));
    }
    if (data.containsKey('DATA_VENCIMENTO')) {
        context.handle(_dataVencimentoMeta,
            dataVencimento.isAcceptableOrUnknown(data['DATA_VENCIMENTO']!, _dataVencimentoMeta));
    }
    if (data.containsKey('VALOR')) {
        context.handle(_valorMeta,
            valor.isAcceptableOrUnknown(data['VALOR']!, _valorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDuplicata map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDuplicata.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDuplicatasTable createAlias(String alias) {
    return $NfeDuplicatasTable(_db, alias);
  }
}