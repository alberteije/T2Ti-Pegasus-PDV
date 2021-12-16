/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [COMANDA_DETALHE_COMPLEMENTO] 
                                                                                
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

@DataClassName("ComandaDetalheComplemento")
@UseRowClass(ComandaDetalheComplemento)
class ComandaDetalheComplementos extends Table {
  @override
  String get tableName => 'COMANDA_DETALHE_COMPLEMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idComandaDetalhe => integer().named('ID_COMANDA_DETALHE').nullable().customConstraint('NULLABLE REFERENCES COMANDA_DETALHE(ID)')();
  IntColumn get idProduto => integer().named('ID_PRODUTO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO(ID)')();
  TextColumn get nomeProduto => text().named('NOME_PRODUTO').withLength(min: 0, max: 100).nullable()();
  RealColumn get quantidade => real().named('QUANTIDADE').nullable()();
  RealColumn get valorUnitario => real().named('VALOR_UNITARIO').nullable()();
  RealColumn get valorTotal => real().named('VALOR_TOTAL').nullable()();
}

class ComandaDetalheComplemento extends DataClass implements Insertable<ComandaDetalheComplemento> {
  final int? id;
  final int? idComandaDetalhe;
  final int? idProduto;
  final String? nomeProduto;
  final double? quantidade;
  final double? valorUnitario;
  final double? valorTotal;

  ComandaDetalheComplemento(
    {
      required this.id,
      this.idComandaDetalhe,
      this.idProduto,
      this.nomeProduto,
      this.quantidade,
      this.valorUnitario,
      this.valorTotal,
    }
  );

  factory ComandaDetalheComplemento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ComandaDetalheComplemento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idComandaDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_COMANDA_DETALHE']),
      idProduto: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO']),
      nomeProduto: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME_PRODUTO']),
      quantidade: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE']),
      valorUnitario: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_UNITARIO']),
      valorTotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idComandaDetalhe != null) {
      map['ID_COMANDA_DETALHE'] = Variable<int?>(idComandaDetalhe);
    }
    if (!nullToAbsent || idProduto != null) {
      map['ID_PRODUTO'] = Variable<int?>(idProduto);
    }
    if (!nullToAbsent || nomeProduto != null) {
      map['NOME_PRODUTO'] = Variable<String?>(nomeProduto);
    }
    if (!nullToAbsent || quantidade != null) {
      map['QUANTIDADE'] = Variable<double?>(quantidade);
    }
    if (!nullToAbsent || valorUnitario != null) {
      map['VALOR_UNITARIO'] = Variable<double?>(valorUnitario);
    }
    if (!nullToAbsent || valorTotal != null) {
      map['VALOR_TOTAL'] = Variable<double?>(valorTotal);
    }
    return map;
  }

  ComandaDetalheComplementosCompanion toCompanion(bool nullToAbsent) {
    return ComandaDetalheComplementosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idComandaDetalhe: idComandaDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idComandaDetalhe),
      idProduto: idProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(idProduto),
      nomeProduto: nomeProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(nomeProduto),
      quantidade: quantidade == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidade),
      valorUnitario: valorUnitario == null && nullToAbsent
        ? const Value.absent()
        : Value(valorUnitario),
      valorTotal: valorTotal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotal),
    );
  }

  factory ComandaDetalheComplemento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ComandaDetalheComplemento(
      id: serializer.fromJson<int>(json['id']),
      idComandaDetalhe: serializer.fromJson<int>(json['idComandaDetalhe']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      nomeProduto: serializer.fromJson<String>(json['nomeProduto']),
      quantidade: serializer.fromJson<double>(json['quantidade']),
      valorUnitario: serializer.fromJson<double>(json['valorUnitario']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idComandaDetalhe': serializer.toJson<int?>(idComandaDetalhe),
      'idProduto': serializer.toJson<int?>(idProduto),
      'nomeProduto': serializer.toJson<String?>(nomeProduto),
      'quantidade': serializer.toJson<double?>(quantidade),
      'valorUnitario': serializer.toJson<double?>(valorUnitario),
      'valorTotal': serializer.toJson<double?>(valorTotal),
    };
  }

  ComandaDetalheComplemento copyWith(
        {
		  int? id,
          int? idComandaDetalhe,
          int? idProduto,
          String? nomeProduto,
          double? quantidade,
          double? valorUnitario,
          double? valorTotal,
		}) =>
      ComandaDetalheComplemento(
        id: id ?? this.id,
        idComandaDetalhe: idComandaDetalhe ?? this.idComandaDetalhe,
        idProduto: idProduto ?? this.idProduto,
        nomeProduto: nomeProduto ?? this.nomeProduto,
        quantidade: quantidade ?? this.quantidade,
        valorUnitario: valorUnitario ?? this.valorUnitario,
        valorTotal: valorTotal ?? this.valorTotal,
      );
  
  @override
  String toString() {
    return (StringBuffer('ComandaDetalheComplemento(')
          ..write('id: $id, ')
          ..write('idComandaDetalhe: $idComandaDetalhe, ')
          ..write('idProduto: $idProduto, ')
          ..write('nomeProduto: $nomeProduto, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorTotal: $valorTotal, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idComandaDetalhe,
      idProduto,
      nomeProduto,
      quantidade,
      valorUnitario,
      valorTotal,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComandaDetalheComplemento &&
          other.id == id &&
          other.idComandaDetalhe == idComandaDetalhe &&
          other.idProduto == idProduto &&
          other.nomeProduto == nomeProduto &&
          other.quantidade == quantidade &&
          other.valorUnitario == valorUnitario &&
          other.valorTotal == valorTotal 
	   );
}

class ComandaDetalheComplementosCompanion extends UpdateCompanion<ComandaDetalheComplemento> {

  final Value<int?> id;
  final Value<int?> idComandaDetalhe;
  final Value<int?> idProduto;
  final Value<String?> nomeProduto;
  final Value<double?> quantidade;
  final Value<double?> valorUnitario;
  final Value<double?> valorTotal;

  const ComandaDetalheComplementosCompanion({
    this.id = const Value.absent(),
    this.idComandaDetalhe = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.nomeProduto = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.valorTotal = const Value.absent(),
  });

  ComandaDetalheComplementosCompanion.insert({
    this.id = const Value.absent(),
    this.idComandaDetalhe = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.nomeProduto = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.valorTotal = const Value.absent(),
  });

  static Insertable<ComandaDetalheComplemento> custom({
    Expression<int>? id,
    Expression<int>? idComandaDetalhe,
    Expression<int>? idProduto,
    Expression<String>? nomeProduto,
    Expression<double>? quantidade,
    Expression<double>? valorUnitario,
    Expression<double>? valorTotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idComandaDetalhe != null) 'ID_COMANDA_DETALHE': idComandaDetalhe,
      if (idProduto != null) 'ID_PRODUTO': idProduto,
      if (nomeProduto != null) 'NOME_PRODUTO': nomeProduto,
      if (quantidade != null) 'QUANTIDADE': quantidade,
      if (valorUnitario != null) 'VALOR_UNITARIO': valorUnitario,
      if (valorTotal != null) 'VALOR_TOTAL': valorTotal,
    });
  }

  ComandaDetalheComplementosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idComandaDetalhe,
      Value<int>? idProduto,
      Value<String>? nomeProduto,
      Value<double>? quantidade,
      Value<double>? valorUnitario,
      Value<double>? valorTotal,
	  }) {
    return ComandaDetalheComplementosCompanion(
      id: id ?? this.id,
      idComandaDetalhe: idComandaDetalhe ?? this.idComandaDetalhe,
      idProduto: idProduto ?? this.idProduto,
      nomeProduto: nomeProduto ?? this.nomeProduto,
      quantidade: quantidade ?? this.quantidade,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      valorTotal: valorTotal ?? this.valorTotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idComandaDetalhe.present) {
      map['ID_COMANDA_DETALHE'] = Variable<int?>(idComandaDetalhe.value);
    }
    if (idProduto.present) {
      map['ID_PRODUTO'] = Variable<int?>(idProduto.value);
    }
    if (nomeProduto.present) {
      map['NOME_PRODUTO'] = Variable<String?>(nomeProduto.value);
    }
    if (quantidade.present) {
      map['QUANTIDADE'] = Variable<double?>(quantidade.value);
    }
    if (valorUnitario.present) {
      map['VALOR_UNITARIO'] = Variable<double?>(valorUnitario.value);
    }
    if (valorTotal.present) {
      map['VALOR_TOTAL'] = Variable<double?>(valorTotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComandaDetalheComplementosCompanion(')
          ..write('id: $id, ')
          ..write('idComandaDetalhe: $idComandaDetalhe, ')
          ..write('idProduto: $idProduto, ')
          ..write('nomeProduto: $nomeProduto, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorTotal: $valorTotal, ')
          ..write(')'))
        .toString();
  }
}

class $ComandaDetalheComplementosTable extends ComandaDetalheComplementos
    with TableInfo<$ComandaDetalheComplementosTable, ComandaDetalheComplemento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ComandaDetalheComplementosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idComandaDetalheMeta =
      const VerificationMeta('idComandaDetalhe');
  GeneratedColumn<int>? _idComandaDetalhe;
  @override
  GeneratedColumn<int> get idComandaDetalhe =>
      _idComandaDetalhe ??= GeneratedColumn<int>('ID_COMANDA_DETALHE', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES COMANDA_DETALHE(ID)');
  final VerificationMeta _idProdutoMeta =
      const VerificationMeta('idProduto');
  GeneratedColumn<int>? _idProduto;
  @override
  GeneratedColumn<int> get idProduto =>
      _idProduto ??= GeneratedColumn<int>('ID_PRODUTO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PRODUTO(ID)');
  final VerificationMeta _nomeProdutoMeta =
      const VerificationMeta('nomeProduto');
  GeneratedColumn<String>? _nomeProduto;
  @override
  GeneratedColumn<String> get nomeProduto => _nomeProduto ??=
      GeneratedColumn<String>('NOME_PRODUTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  GeneratedColumn<double>? _quantidade;
  @override
  GeneratedColumn<double> get quantidade => _quantidade ??=
      GeneratedColumn<double>('QUANTIDADE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorUnitarioMeta =
      const VerificationMeta('valorUnitario');
  GeneratedColumn<double>? _valorUnitario;
  @override
  GeneratedColumn<double> get valorUnitario => _valorUnitario ??=
      GeneratedColumn<double>('VALOR_UNITARIO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorTotalMeta =
      const VerificationMeta('valorTotal');
  GeneratedColumn<double>? _valorTotal;
  @override
  GeneratedColumn<double> get valorTotal => _valorTotal ??=
      GeneratedColumn<double>('VALOR_TOTAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idComandaDetalhe,
        idProduto,
        nomeProduto,
        quantidade,
        valorUnitario,
        valorTotal,
      ];

  @override
  String get aliasedName => _alias ?? 'COMANDA_DETALHE_COMPLEMENTO';
  
  @override
  String get actualTableName => 'COMANDA_DETALHE_COMPLEMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<ComandaDetalheComplemento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_COMANDA_DETALHE')) {
        context.handle(_idComandaDetalheMeta,
            idComandaDetalhe.isAcceptableOrUnknown(data['ID_COMANDA_DETALHE']!, _idComandaDetalheMeta));
    }
    if (data.containsKey('ID_PRODUTO')) {
        context.handle(_idProdutoMeta,
            idProduto.isAcceptableOrUnknown(data['ID_PRODUTO']!, _idProdutoMeta));
    }
    if (data.containsKey('NOME_PRODUTO')) {
        context.handle(_nomeProdutoMeta,
            nomeProduto.isAcceptableOrUnknown(data['NOME_PRODUTO']!, _nomeProdutoMeta));
    }
    if (data.containsKey('QUANTIDADE')) {
        context.handle(_quantidadeMeta,
            quantidade.isAcceptableOrUnknown(data['QUANTIDADE']!, _quantidadeMeta));
    }
    if (data.containsKey('VALOR_UNITARIO')) {
        context.handle(_valorUnitarioMeta,
            valorUnitario.isAcceptableOrUnknown(data['VALOR_UNITARIO']!, _valorUnitarioMeta));
    }
    if (data.containsKey('VALOR_TOTAL')) {
        context.handle(_valorTotalMeta,
            valorTotal.isAcceptableOrUnknown(data['VALOR_TOTAL']!, _valorTotalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComandaDetalheComplemento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ComandaDetalheComplemento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ComandaDetalheComplementosTable createAlias(String alias) {
    return $ComandaDetalheComplementosTable(_db, alias);
  }
}