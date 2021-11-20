/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [COMANDA_DETALHE] 
                                                                                
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

@DataClassName("ComandaDetalhe")
@UseRowClass(ComandaDetalhe)
class ComandaDetalhes extends Table {
  @override
  String get tableName => 'COMANDA_DETALHE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idComanda => integer().named('ID_COMANDA').nullable().customConstraint('NULLABLE REFERENCES COMANDA(ID)')();
  IntColumn get idCardapio => integer().named('ID_CARDAPIO').nullable().customConstraint('NULLABLE REFERENCES CARDAPIO(ID)')();
  RealColumn get quantidade => real().named('QUANTIDADE').nullable()();
  RealColumn get valorUnitario => real().named('VALOR_UNITARIO').nullable()();
  RealColumn get valorTotal => real().named('VALOR_TOTAL').nullable()();
  TextColumn get observacao => text().named('OBSERVACAO').withLength(min: 0, max: 250).nullable()();
  TextColumn get gerouPedidoCozinha => text().named('GEROU_PEDIDO_COZINHA').withLength(min: 0, max: 1).nullable()();
}

class ComandaDetalhe extends DataClass implements Insertable<ComandaDetalhe> {
  final int? id;
  final int? idComanda;
  final int? idCardapio;
  final double? quantidade;
  final double? valorUnitario;
  final double? valorTotal;
  final String? observacao;
  final String? gerouPedidoCozinha;

  ComandaDetalhe(
    {
      required this.id,
      this.idComanda,
      this.idCardapio,
      this.quantidade,
      this.valorUnitario,
      this.valorTotal,
      this.observacao,
      this.gerouPedidoCozinha,
    }
  );

  factory ComandaDetalhe.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ComandaDetalhe(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idComanda: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_COMANDA']),
      idCardapio: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_CARDAPIO']),
      quantidade: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE']),
      valorUnitario: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_UNITARIO']),
      valorTotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL']),
      observacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}OBSERVACAO']),
      gerouPedidoCozinha: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}GEROU_PEDIDO_COZINHA']),
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
    if (!nullToAbsent || idCardapio != null) {
      map['ID_CARDAPIO'] = Variable<int?>(idCardapio);
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
    if (!nullToAbsent || observacao != null) {
      map['OBSERVACAO'] = Variable<String?>(observacao);
    }
    if (!nullToAbsent || gerouPedidoCozinha != null) {
      map['GEROU_PEDIDO_COZINHA'] = Variable<String?>(gerouPedidoCozinha);
    }
    return map;
  }

  ComandaDetalhesCompanion toCompanion(bool nullToAbsent) {
    return ComandaDetalhesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idComanda: idComanda == null && nullToAbsent
        ? const Value.absent()
        : Value(idComanda),
      idCardapio: idCardapio == null && nullToAbsent
        ? const Value.absent()
        : Value(idCardapio),
      quantidade: quantidade == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidade),
      valorUnitario: valorUnitario == null && nullToAbsent
        ? const Value.absent()
        : Value(valorUnitario),
      valorTotal: valorTotal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotal),
      observacao: observacao == null && nullToAbsent
        ? const Value.absent()
        : Value(observacao),
      gerouPedidoCozinha: gerouPedidoCozinha == null && nullToAbsent
        ? const Value.absent()
        : Value(gerouPedidoCozinha),
    );
  }

  factory ComandaDetalhe.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ComandaDetalhe(
      id: serializer.fromJson<int>(json['id']),
      idComanda: serializer.fromJson<int>(json['idComanda']),
      idCardapio: serializer.fromJson<int>(json['idCardapio']),
      quantidade: serializer.fromJson<double>(json['quantidade']),
      valorUnitario: serializer.fromJson<double>(json['valorUnitario']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
      observacao: serializer.fromJson<String>(json['observacao']),
      gerouPedidoCozinha: serializer.fromJson<String>(json['gerouPedidoCozinha']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idComanda': serializer.toJson<int?>(idComanda),
      'idCardapio': serializer.toJson<int?>(idCardapio),
      'quantidade': serializer.toJson<double?>(quantidade),
      'valorUnitario': serializer.toJson<double?>(valorUnitario),
      'valorTotal': serializer.toJson<double?>(valorTotal),
      'observacao': serializer.toJson<String?>(observacao),
      'gerouPedidoCozinha': serializer.toJson<String?>(gerouPedidoCozinha),
    };
  }

  ComandaDetalhe copyWith(
        {
		  int? id,
          int? idComanda,
          int? idCardapio,
          double? quantidade,
          double? valorUnitario,
          double? valorTotal,
          String? observacao,
          String? gerouPedidoCozinha,
		}) =>
      ComandaDetalhe(
        id: id ?? this.id,
        idComanda: idComanda ?? this.idComanda,
        idCardapio: idCardapio ?? this.idCardapio,
        quantidade: quantidade ?? this.quantidade,
        valorUnitario: valorUnitario ?? this.valorUnitario,
        valorTotal: valorTotal ?? this.valorTotal,
        observacao: observacao ?? this.observacao,
        gerouPedidoCozinha: gerouPedidoCozinha ?? this.gerouPedidoCozinha,
      );
  
  @override
  String toString() {
    return (StringBuffer('ComandaDetalhe(')
          ..write('id: $id, ')
          ..write('idComanda: $idComanda, ')
          ..write('idCardapio: $idCardapio, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('observacao: $observacao, ')
          ..write('gerouPedidoCozinha: $gerouPedidoCozinha, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idComanda,
      idCardapio,
      quantidade,
      valorUnitario,
      valorTotal,
      observacao,
      gerouPedidoCozinha,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComandaDetalhe &&
          other.id == id &&
          other.idComanda == idComanda &&
          other.idCardapio == idCardapio &&
          other.quantidade == quantidade &&
          other.valorUnitario == valorUnitario &&
          other.valorTotal == valorTotal &&
          other.observacao == observacao &&
          other.gerouPedidoCozinha == gerouPedidoCozinha 
	   );
}

class ComandaDetalhesCompanion extends UpdateCompanion<ComandaDetalhe> {

  final Value<int?> id;
  final Value<int?> idComanda;
  final Value<int?> idCardapio;
  final Value<double?> quantidade;
  final Value<double?> valorUnitario;
  final Value<double?> valorTotal;
  final Value<String?> observacao;
  final Value<String?> gerouPedidoCozinha;

  const ComandaDetalhesCompanion({
    this.id = const Value.absent(),
    this.idComanda = const Value.absent(),
    this.idCardapio = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.observacao = const Value.absent(),
    this.gerouPedidoCozinha = const Value.absent(),
  });

  ComandaDetalhesCompanion.insert({
    this.id = const Value.absent(),
    this.idComanda = const Value.absent(),
    this.idCardapio = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.observacao = const Value.absent(),
    this.gerouPedidoCozinha = const Value.absent(),
  });

  static Insertable<ComandaDetalhe> custom({
    Expression<int>? id,
    Expression<int>? idComanda,
    Expression<int>? idCardapio,
    Expression<double>? quantidade,
    Expression<double>? valorUnitario,
    Expression<double>? valorTotal,
    Expression<String>? observacao,
    Expression<String>? gerouPedidoCozinha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idComanda != null) 'ID_COMANDA': idComanda,
      if (idCardapio != null) 'ID_CARDAPIO': idCardapio,
      if (quantidade != null) 'QUANTIDADE': quantidade,
      if (valorUnitario != null) 'VALOR_UNITARIO': valorUnitario,
      if (valorTotal != null) 'VALOR_TOTAL': valorTotal,
      if (observacao != null) 'OBSERVACAO': observacao,
      if (gerouPedidoCozinha != null) 'GEROU_PEDIDO_COZINHA': gerouPedidoCozinha,
    });
  }

  ComandaDetalhesCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idComanda,
      Value<int>? idCardapio,
      Value<double>? quantidade,
      Value<double>? valorUnitario,
      Value<double>? valorTotal,
      Value<String>? observacao,
      Value<String>? gerouPedidoCozinha,
	  }) {
    return ComandaDetalhesCompanion(
      id: id ?? this.id,
      idComanda: idComanda ?? this.idComanda,
      idCardapio: idCardapio ?? this.idCardapio,
      quantidade: quantidade ?? this.quantidade,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      valorTotal: valorTotal ?? this.valorTotal,
      observacao: observacao ?? this.observacao,
      gerouPedidoCozinha: gerouPedidoCozinha ?? this.gerouPedidoCozinha,
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
    if (idCardapio.present) {
      map['ID_CARDAPIO'] = Variable<int?>(idCardapio.value);
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
    if (observacao.present) {
      map['OBSERVACAO'] = Variable<String?>(observacao.value);
    }
    if (gerouPedidoCozinha.present) {
      map['GEROU_PEDIDO_COZINHA'] = Variable<String?>(gerouPedidoCozinha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComandaDetalhesCompanion(')
          ..write('id: $id, ')
          ..write('idComanda: $idComanda, ')
          ..write('idCardapio: $idCardapio, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('observacao: $observacao, ')
          ..write('gerouPedidoCozinha: $gerouPedidoCozinha, ')
          ..write(')'))
        .toString();
  }
}

class $ComandaDetalhesTable extends ComandaDetalhes
    with TableInfo<$ComandaDetalhesTable, ComandaDetalhe> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ComandaDetalhesTable(this._db, [this._alias]);
  
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
  final VerificationMeta _idCardapioMeta =
      const VerificationMeta('idCardapio');
  GeneratedColumn<int>? _idCardapio;
  @override
  GeneratedColumn<int> get idCardapio =>
      _idCardapio ??= GeneratedColumn<int>('ID_CARDAPIO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES CARDAPIO(ID)');
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
  final VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  GeneratedColumn<String>? _observacao;
  @override
  GeneratedColumn<String> get observacao => _observacao ??=
      GeneratedColumn<String>('OBSERVACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _gerouPedidoCozinhaMeta =
      const VerificationMeta('gerouPedidoCozinha');
  GeneratedColumn<String>? _gerouPedidoCozinha;
  @override
  GeneratedColumn<String> get gerouPedidoCozinha => _gerouPedidoCozinha ??=
      GeneratedColumn<String>('GEROU_PEDIDO_COZINHA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idComanda,
        idCardapio,
        quantidade,
        valorUnitario,
        valorTotal,
        observacao,
        gerouPedidoCozinha,
      ];

  @override
  String get aliasedName => _alias ?? 'COMANDA_DETALHE';
  
  @override
  String get actualTableName => 'COMANDA_DETALHE';
  
  @override
  VerificationContext validateIntegrity(Insertable<ComandaDetalhe> instance,
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
    if (data.containsKey('ID_CARDAPIO')) {
        context.handle(_idCardapioMeta,
            idCardapio.isAcceptableOrUnknown(data['ID_CARDAPIO']!, _idCardapioMeta));
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
    if (data.containsKey('OBSERVACAO')) {
        context.handle(_observacaoMeta,
            observacao.isAcceptableOrUnknown(data['OBSERVACAO']!, _observacaoMeta));
    }
    if (data.containsKey('GEROU_PEDIDO_COZINHA')) {
        context.handle(_gerouPedidoCozinhaMeta,
            gerouPedidoCozinha.isAcceptableOrUnknown(data['GEROU_PEDIDO_COZINHA']!, _gerouPedidoCozinhaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComandaDetalhe map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ComandaDetalhe.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ComandaDetalhesTable createAlias(String alias) {
    return $ComandaDetalhesTable(_db, alias);
  }
}