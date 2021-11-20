/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PRODUTO_PROMOCAO] 
                                                                                
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

@DataClassName("ProdutoPromocao")
@UseRowClass(ProdutoPromocao)
class ProdutoPromocaos extends Table {
  @override
  String get tableName => 'PRODUTO_PROMOCAO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idProduto => integer().named('ID_PRODUTO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO(ID)')();
  DateTimeColumn get dataInicio => dateTime().named('DATA_INICIO').nullable()();
  DateTimeColumn get dataFim => dateTime().named('DATA_FIM').nullable()();
  RealColumn get quantidadeEmPromocao => real().named('QUANTIDADE_EM_PROMOCAO').nullable()();
  RealColumn get quantidadeMaximaCliente => real().named('QUANTIDADE_MAXIMA_CLIENTE').nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
}

class ProdutoPromocao extends DataClass implements Insertable<ProdutoPromocao> {
  final int? id;
  final int? idProduto;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final double? quantidadeEmPromocao;
  final double? quantidadeMaximaCliente;
  final double? valor;

  ProdutoPromocao(
    {
      required this.id,
      this.idProduto,
      this.dataInicio,
      this.dataFim,
      this.quantidadeEmPromocao,
      this.quantidadeMaximaCliente,
      this.valor,
    }
  );

  factory ProdutoPromocao.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProdutoPromocao(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idProduto: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO']),
      dataInicio: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_INICIO']),
      dataFim: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_FIM']),
      quantidadeEmPromocao: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_EM_PROMOCAO']),
      quantidadeMaximaCliente: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_MAXIMA_CLIENTE']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idProduto != null) {
      map['ID_PRODUTO'] = Variable<int?>(idProduto);
    }
    if (!nullToAbsent || dataInicio != null) {
      map['DATA_INICIO'] = Variable<DateTime?>(dataInicio);
    }
    if (!nullToAbsent || dataFim != null) {
      map['DATA_FIM'] = Variable<DateTime?>(dataFim);
    }
    if (!nullToAbsent || quantidadeEmPromocao != null) {
      map['QUANTIDADE_EM_PROMOCAO'] = Variable<double?>(quantidadeEmPromocao);
    }
    if (!nullToAbsent || quantidadeMaximaCliente != null) {
      map['QUANTIDADE_MAXIMA_CLIENTE'] = Variable<double?>(quantidadeMaximaCliente);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    return map;
  }

  ProdutoPromocaosCompanion toCompanion(bool nullToAbsent) {
    return ProdutoPromocaosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idProduto: idProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(idProduto),
      dataInicio: dataInicio == null && nullToAbsent
        ? const Value.absent()
        : Value(dataInicio),
      dataFim: dataFim == null && nullToAbsent
        ? const Value.absent()
        : Value(dataFim),
      quantidadeEmPromocao: quantidadeEmPromocao == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeEmPromocao),
      quantidadeMaximaCliente: quantidadeMaximaCliente == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeMaximaCliente),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
    );
  }

  factory ProdutoPromocao.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProdutoPromocao(
      id: serializer.fromJson<int>(json['id']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      dataInicio: serializer.fromJson<DateTime>(json['dataInicio']),
      dataFim: serializer.fromJson<DateTime>(json['dataFim']),
      quantidadeEmPromocao: serializer.fromJson<double>(json['quantidadeEmPromocao']),
      quantidadeMaximaCliente: serializer.fromJson<double>(json['quantidadeMaximaCliente']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idProduto': serializer.toJson<int?>(idProduto),
      'dataInicio': serializer.toJson<DateTime?>(dataInicio),
      'dataFim': serializer.toJson<DateTime?>(dataFim),
      'quantidadeEmPromocao': serializer.toJson<double?>(quantidadeEmPromocao),
      'quantidadeMaximaCliente': serializer.toJson<double?>(quantidadeMaximaCliente),
      'valor': serializer.toJson<double?>(valor),
    };
  }

  ProdutoPromocao copyWith(
        {
		  int? id,
          int? idProduto,
          DateTime? dataInicio,
          DateTime? dataFim,
          double? quantidadeEmPromocao,
          double? quantidadeMaximaCliente,
          double? valor,
		}) =>
      ProdutoPromocao(
        id: id ?? this.id,
        idProduto: idProduto ?? this.idProduto,
        dataInicio: dataInicio ?? this.dataInicio,
        dataFim: dataFim ?? this.dataFim,
        quantidadeEmPromocao: quantidadeEmPromocao ?? this.quantidadeEmPromocao,
        quantidadeMaximaCliente: quantidadeMaximaCliente ?? this.quantidadeMaximaCliente,
        valor: valor ?? this.valor,
      );
  
  @override
  String toString() {
    return (StringBuffer('ProdutoPromocao(')
          ..write('id: $id, ')
          ..write('idProduto: $idProduto, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('quantidadeEmPromocao: $quantidadeEmPromocao, ')
          ..write('quantidadeMaximaCliente: $quantidadeMaximaCliente, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idProduto,
      dataInicio,
      dataFim,
      quantidadeEmPromocao,
      quantidadeMaximaCliente,
      valor,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdutoPromocao &&
          other.id == id &&
          other.idProduto == idProduto &&
          other.dataInicio == dataInicio &&
          other.dataFim == dataFim &&
          other.quantidadeEmPromocao == quantidadeEmPromocao &&
          other.quantidadeMaximaCliente == quantidadeMaximaCliente &&
          other.valor == valor 
	   );
}

class ProdutoPromocaosCompanion extends UpdateCompanion<ProdutoPromocao> {

  final Value<int?> id;
  final Value<int?> idProduto;
  final Value<DateTime?> dataInicio;
  final Value<DateTime?> dataFim;
  final Value<double?> quantidadeEmPromocao;
  final Value<double?> quantidadeMaximaCliente;
  final Value<double?> valor;

  const ProdutoPromocaosCompanion({
    this.id = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    this.quantidadeEmPromocao = const Value.absent(),
    this.quantidadeMaximaCliente = const Value.absent(),
    this.valor = const Value.absent(),
  });

  ProdutoPromocaosCompanion.insert({
    this.id = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    this.quantidadeEmPromocao = const Value.absent(),
    this.quantidadeMaximaCliente = const Value.absent(),
    this.valor = const Value.absent(),
  });

  static Insertable<ProdutoPromocao> custom({
    Expression<int>? id,
    Expression<int>? idProduto,
    Expression<DateTime>? dataInicio,
    Expression<DateTime>? dataFim,
    Expression<double>? quantidadeEmPromocao,
    Expression<double>? quantidadeMaximaCliente,
    Expression<double>? valor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idProduto != null) 'ID_PRODUTO': idProduto,
      if (dataInicio != null) 'DATA_INICIO': dataInicio,
      if (dataFim != null) 'DATA_FIM': dataFim,
      if (quantidadeEmPromocao != null) 'QUANTIDADE_EM_PROMOCAO': quantidadeEmPromocao,
      if (quantidadeMaximaCliente != null) 'QUANTIDADE_MAXIMA_CLIENTE': quantidadeMaximaCliente,
      if (valor != null) 'VALOR': valor,
    });
  }

  ProdutoPromocaosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idProduto,
      Value<DateTime>? dataInicio,
      Value<DateTime>? dataFim,
      Value<double>? quantidadeEmPromocao,
      Value<double>? quantidadeMaximaCliente,
      Value<double>? valor,
	  }) {
    return ProdutoPromocaosCompanion(
      id: id ?? this.id,
      idProduto: idProduto ?? this.idProduto,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      quantidadeEmPromocao: quantidadeEmPromocao ?? this.quantidadeEmPromocao,
      quantidadeMaximaCliente: quantidadeMaximaCliente ?? this.quantidadeMaximaCliente,
      valor: valor ?? this.valor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idProduto.present) {
      map['ID_PRODUTO'] = Variable<int?>(idProduto.value);
    }
    if (dataInicio.present) {
      map['DATA_INICIO'] = Variable<DateTime?>(dataInicio.value);
    }
    if (dataFim.present) {
      map['DATA_FIM'] = Variable<DateTime?>(dataFim.value);
    }
    if (quantidadeEmPromocao.present) {
      map['QUANTIDADE_EM_PROMOCAO'] = Variable<double?>(quantidadeEmPromocao.value);
    }
    if (quantidadeMaximaCliente.present) {
      map['QUANTIDADE_MAXIMA_CLIENTE'] = Variable<double?>(quantidadeMaximaCliente.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutoPromocaosCompanion(')
          ..write('id: $id, ')
          ..write('idProduto: $idProduto, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('quantidadeEmPromocao: $quantidadeEmPromocao, ')
          ..write('quantidadeMaximaCliente: $quantidadeMaximaCliente, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }
}

class $ProdutoPromocaosTable extends ProdutoPromocaos
    with TableInfo<$ProdutoPromocaosTable, ProdutoPromocao> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProdutoPromocaosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idProdutoMeta =
      const VerificationMeta('idProduto');
  GeneratedColumn<int>? _idProduto;
  @override
  GeneratedColumn<int> get idProduto =>
      _idProduto ??= GeneratedColumn<int>('ID_PRODUTO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PRODUTO(ID)');
  final VerificationMeta _dataInicioMeta =
      const VerificationMeta('dataInicio');
  GeneratedColumn<DateTime>? _dataInicio;
  @override
  GeneratedColumn<DateTime> get dataInicio => _dataInicio ??=
      GeneratedColumn<DateTime>('DATA_INICIO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dataFimMeta =
      const VerificationMeta('dataFim');
  GeneratedColumn<DateTime>? _dataFim;
  @override
  GeneratedColumn<DateTime> get dataFim => _dataFim ??=
      GeneratedColumn<DateTime>('DATA_FIM', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _quantidadeEmPromocaoMeta =
      const VerificationMeta('quantidadeEmPromocao');
  GeneratedColumn<double>? _quantidadeEmPromocao;
  @override
  GeneratedColumn<double> get quantidadeEmPromocao => _quantidadeEmPromocao ??=
      GeneratedColumn<double>('QUANTIDADE_EM_PROMOCAO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _quantidadeMaximaClienteMeta =
      const VerificationMeta('quantidadeMaximaCliente');
  GeneratedColumn<double>? _quantidadeMaximaCliente;
  @override
  GeneratedColumn<double> get quantidadeMaximaCliente => _quantidadeMaximaCliente ??=
      GeneratedColumn<double>('QUANTIDADE_MAXIMA_CLIENTE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
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
        idProduto,
        dataInicio,
        dataFim,
        quantidadeEmPromocao,
        quantidadeMaximaCliente,
        valor,
      ];

  @override
  String get aliasedName => _alias ?? 'PRODUTO_PROMOCAO';
  
  @override
  String get actualTableName => 'PRODUTO_PROMOCAO';
  
  @override
  VerificationContext validateIntegrity(Insertable<ProdutoPromocao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_PRODUTO')) {
        context.handle(_idProdutoMeta,
            idProduto.isAcceptableOrUnknown(data['ID_PRODUTO']!, _idProdutoMeta));
    }
    if (data.containsKey('DATA_INICIO')) {
        context.handle(_dataInicioMeta,
            dataInicio.isAcceptableOrUnknown(data['DATA_INICIO']!, _dataInicioMeta));
    }
    if (data.containsKey('DATA_FIM')) {
        context.handle(_dataFimMeta,
            dataFim.isAcceptableOrUnknown(data['DATA_FIM']!, _dataFimMeta));
    }
    if (data.containsKey('QUANTIDADE_EM_PROMOCAO')) {
        context.handle(_quantidadeEmPromocaoMeta,
            quantidadeEmPromocao.isAcceptableOrUnknown(data['QUANTIDADE_EM_PROMOCAO']!, _quantidadeEmPromocaoMeta));
    }
    if (data.containsKey('QUANTIDADE_MAXIMA_CLIENTE')) {
        context.handle(_quantidadeMaximaClienteMeta,
            quantidadeMaximaCliente.isAcceptableOrUnknown(data['QUANTIDADE_MAXIMA_CLIENTE']!, _quantidadeMaximaClienteMeta));
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
  ProdutoPromocao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProdutoPromocao.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProdutoPromocaosTable createAlias(String alias) {
    return $ProdutoPromocaosTable(_db, alias);
  }
}