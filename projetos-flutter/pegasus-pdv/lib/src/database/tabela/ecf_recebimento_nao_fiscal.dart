/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_RECEBIMENTO_NAO_FISCAL] 
                                                                                
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

@DataClassName("EcfRecebimentoNaoFiscal")
@UseRowClass(EcfRecebimentoNaoFiscal)
class EcfRecebimentoNaoFiscals extends Table {
  @override
  String get tableName => 'ECF_RECEBIMENTO_NAO_FISCAL';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idPdvMovimento => integer().named('ID_PDV_MOVIMENTO').nullable().customConstraint('NULLABLE REFERENCES PDV_MOVIMENTO(ID)')();
  DateTimeColumn get dataRecebimento => dateTime().named('DATA_RECEBIMENTO').nullable()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 50).nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
}

class EcfRecebimentoNaoFiscal extends DataClass implements Insertable<EcfRecebimentoNaoFiscal> {
  final int? id;
  final int? idPdvMovimento;
  final DateTime? dataRecebimento;
  final String? descricao;
  final double? valor;

  EcfRecebimentoNaoFiscal(
    {
      required this.id,
      this.idPdvMovimento,
      this.dataRecebimento,
      this.descricao,
      this.valor,
    }
  );

  factory EcfRecebimentoNaoFiscal.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EcfRecebimentoNaoFiscal(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idPdvMovimento: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_MOVIMENTO']),
      dataRecebimento: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_RECEBIMENTO']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
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
    if (!nullToAbsent || dataRecebimento != null) {
      map['DATA_RECEBIMENTO'] = Variable<DateTime?>(dataRecebimento);
    }
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    return map;
  }

  EcfRecebimentoNaoFiscalsCompanion toCompanion(bool nullToAbsent) {
    return EcfRecebimentoNaoFiscalsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idPdvMovimento: idPdvMovimento == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvMovimento),
      dataRecebimento: dataRecebimento == null && nullToAbsent
        ? const Value.absent()
        : Value(dataRecebimento),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
    );
  }

  factory EcfRecebimentoNaoFiscal.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EcfRecebimentoNaoFiscal(
      id: serializer.fromJson<int>(json['id']),
      idPdvMovimento: serializer.fromJson<int>(json['idPdvMovimento']),
      dataRecebimento: serializer.fromJson<DateTime>(json['dataRecebimento']),
      descricao: serializer.fromJson<String>(json['descricao']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idPdvMovimento': serializer.toJson<int?>(idPdvMovimento),
      'dataRecebimento': serializer.toJson<DateTime?>(dataRecebimento),
      'descricao': serializer.toJson<String?>(descricao),
      'valor': serializer.toJson<double?>(valor),
    };
  }

  EcfRecebimentoNaoFiscal copyWith(
        {
		  int? id,
          int? idPdvMovimento,
          DateTime? dataRecebimento,
          String? descricao,
          double? valor,
		}) =>
      EcfRecebimentoNaoFiscal(
        id: id ?? this.id,
        idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
        dataRecebimento: dataRecebimento ?? this.dataRecebimento,
        descricao: descricao ?? this.descricao,
        valor: valor ?? this.valor,
      );
  
  @override
  String toString() {
    return (StringBuffer('EcfRecebimentoNaoFiscal(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('dataRecebimento: $dataRecebimento, ')
          ..write('descricao: $descricao, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idPdvMovimento,
      dataRecebimento,
      descricao,
      valor,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcfRecebimentoNaoFiscal &&
          other.id == id &&
          other.idPdvMovimento == idPdvMovimento &&
          other.dataRecebimento == dataRecebimento &&
          other.descricao == descricao &&
          other.valor == valor 
	   );
}

class EcfRecebimentoNaoFiscalsCompanion extends UpdateCompanion<EcfRecebimentoNaoFiscal> {

  final Value<int?> id;
  final Value<int?> idPdvMovimento;
  final Value<DateTime?> dataRecebimento;
  final Value<String?> descricao;
  final Value<double?> valor;

  const EcfRecebimentoNaoFiscalsCompanion({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.dataRecebimento = const Value.absent(),
    this.descricao = const Value.absent(),
    this.valor = const Value.absent(),
  });

  EcfRecebimentoNaoFiscalsCompanion.insert({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.dataRecebimento = const Value.absent(),
    this.descricao = const Value.absent(),
    this.valor = const Value.absent(),
  });

  static Insertable<EcfRecebimentoNaoFiscal> custom({
    Expression<int>? id,
    Expression<int>? idPdvMovimento,
    Expression<DateTime>? dataRecebimento,
    Expression<String>? descricao,
    Expression<double>? valor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idPdvMovimento != null) 'ID_PDV_MOVIMENTO': idPdvMovimento,
      if (dataRecebimento != null) 'DATA_RECEBIMENTO': dataRecebimento,
      if (descricao != null) 'DESCRICAO': descricao,
      if (valor != null) 'VALOR': valor,
    });
  }

  EcfRecebimentoNaoFiscalsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idPdvMovimento,
      Value<DateTime>? dataRecebimento,
      Value<String>? descricao,
      Value<double>? valor,
	  }) {
    return EcfRecebimentoNaoFiscalsCompanion(
      id: id ?? this.id,
      idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
      dataRecebimento: dataRecebimento ?? this.dataRecebimento,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
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
    if (dataRecebimento.present) {
      map['DATA_RECEBIMENTO'] = Variable<DateTime?>(dataRecebimento.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcfRecebimentoNaoFiscalsCompanion(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('dataRecebimento: $dataRecebimento, ')
          ..write('descricao: $descricao, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }
}

class $EcfRecebimentoNaoFiscalsTable extends EcfRecebimentoNaoFiscals
    with TableInfo<$EcfRecebimentoNaoFiscalsTable, EcfRecebimentoNaoFiscal> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EcfRecebimentoNaoFiscalsTable(this._db, [this._alias]);
  
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
  final VerificationMeta _dataRecebimentoMeta =
      const VerificationMeta('dataRecebimento');
  GeneratedColumn<DateTime>? _dataRecebimento;
  @override
  GeneratedColumn<DateTime> get dataRecebimento => _dataRecebimento ??=
      GeneratedColumn<DateTime>('DATA_RECEBIMENTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  GeneratedColumn<String>? _descricao;
  @override
  GeneratedColumn<String> get descricao => _descricao ??=
      GeneratedColumn<String>('DESCRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
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
        idPdvMovimento,
        dataRecebimento,
        descricao,
        valor,
      ];

  @override
  String get aliasedName => _alias ?? 'ECF_RECEBIMENTO_NAO_FISCAL';
  
  @override
  String get actualTableName => 'ECF_RECEBIMENTO_NAO_FISCAL';
  
  @override
  VerificationContext validateIntegrity(Insertable<EcfRecebimentoNaoFiscal> instance,
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
    if (data.containsKey('DATA_RECEBIMENTO')) {
        context.handle(_dataRecebimentoMeta,
            dataRecebimento.isAcceptableOrUnknown(data['DATA_RECEBIMENTO']!, _dataRecebimentoMeta));
    }
    if (data.containsKey('DESCRICAO')) {
        context.handle(_descricaoMeta,
            descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
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
  EcfRecebimentoNaoFiscal map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EcfRecebimentoNaoFiscal.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EcfRecebimentoNaoFiscalsTable createAlias(String alias) {
    return $EcfRecebimentoNaoFiscalsTable(_db, alias);
  }
}