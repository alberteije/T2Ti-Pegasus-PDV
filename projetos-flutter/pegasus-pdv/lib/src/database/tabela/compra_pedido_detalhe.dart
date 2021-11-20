/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [COMPRA_PEDIDO_DETALHE] 
                                                                                
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

import '../database_classes.dart';

@DataClassName("CompraPedidoDetalhe")
@UseRowClass(CompraPedidoDetalhe)
class CompraPedidoDetalhes extends Table {
  @override
  String get tableName => 'COMPRA_PEDIDO_DETALHE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idCompraPedidoCabecalho => integer().named('ID_COMPRA_PEDIDO_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES COMPRA_PEDIDO_CABECALHO(ID)')();
  IntColumn get idProduto => integer().named('ID_PRODUTO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO(ID)')();
  RealColumn get quantidade => real().named('QUANTIDADE').nullable()();
  RealColumn get valorUnitario => real().named('VALOR_UNITARIO').nullable()();
  RealColumn get valorSubtotal => real().named('VALOR_SUBTOTAL').nullable()();
  RealColumn get taxaDesconto => real().named('TAXA_DESCONTO').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get valorTotal => real().named('VALOR_TOTAL').nullable()();
  TextColumn get cst => text().named('CST').withLength(min: 0, max: 2).nullable()();
  TextColumn get csosn => text().named('CSOSN').withLength(min: 0, max: 3).nullable()();
  IntColumn get cfop => integer().named('CFOP').nullable()();
}

class CompraDetalhe {
  CompraPedidoDetalhe? compraPedidoDetalhe;
  Produto? produto;

  CompraDetalhe({
    this.compraPedidoDetalhe,
    this.produto,
  });
}

class CompraPedidoDetalhe extends DataClass implements Insertable<CompraPedidoDetalhe> {
  final int? id;
  final int? idCompraPedidoCabecalho;
  final int? idProduto;
  final double? quantidade;
  final double? valorUnitario;
  final double? valorSubtotal;
  final double? taxaDesconto;
  final double? valorDesconto;
  final double? valorTotal;
  final String? cst;
  final String? csosn;
  final int? cfop;

  CompraPedidoDetalhe(
    {
      required this.id,
      this.idCompraPedidoCabecalho,
      this.idProduto,
      this.quantidade,
      this.valorUnitario,
      this.valorSubtotal,
      this.taxaDesconto,
      this.valorDesconto,
      this.valorTotal,
      this.cst,
      this.csosn,
      this.cfop,
    }
  );

  factory CompraPedidoDetalhe.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CompraPedidoDetalhe(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idCompraPedidoCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_COMPRA_PEDIDO_CABECALHO']),
      idProduto: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO']),
      quantidade: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE']),
      valorUnitario: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_UNITARIO']),
      valorSubtotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_SUBTOTAL']),
      taxaDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_DESCONTO']),
      valorDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DESCONTO']),
      valorTotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL']),
      cst: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CST']),
      csosn: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CSOSN']),
      cfop: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CFOP']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idCompraPedidoCabecalho != null) {
      map['ID_COMPRA_PEDIDO_CABECALHO'] = Variable<int?>(idCompraPedidoCabecalho);
    }
    if (!nullToAbsent || idProduto != null) {
      map['ID_PRODUTO'] = Variable<int?>(idProduto);
    }
    if (!nullToAbsent || quantidade != null) {
      map['QUANTIDADE'] = Variable<double?>(quantidade);
    }
    if (!nullToAbsent || valorUnitario != null) {
      map['VALOR_UNITARIO'] = Variable<double?>(valorUnitario);
    }
    if (!nullToAbsent || valorSubtotal != null) {
      map['VALOR_SUBTOTAL'] = Variable<double?>(valorSubtotal);
    }
    if (!nullToAbsent || taxaDesconto != null) {
      map['TAXA_DESCONTO'] = Variable<double?>(taxaDesconto);
    }
    if (!nullToAbsent || valorDesconto != null) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto);
    }
    if (!nullToAbsent || valorTotal != null) {
      map['VALOR_TOTAL'] = Variable<double?>(valorTotal);
    }
    if (!nullToAbsent || cst != null) {
      map['CST'] = Variable<String?>(cst);
    }
    if (!nullToAbsent || csosn != null) {
      map['CSOSN'] = Variable<String?>(csosn);
    }
    if (!nullToAbsent || cfop != null) {
      map['CFOP'] = Variable<int?>(cfop);
    }
    return map;
  }

  CompraPedidoDetalhesCompanion toCompanion(bool nullToAbsent) {
    return CompraPedidoDetalhesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idCompraPedidoCabecalho: idCompraPedidoCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idCompraPedidoCabecalho),
      idProduto: idProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(idProduto),
      quantidade: quantidade == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidade),
      valorUnitario: valorUnitario == null && nullToAbsent
        ? const Value.absent()
        : Value(valorUnitario),
      valorSubtotal: valorSubtotal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorSubtotal),
      taxaDesconto: taxaDesconto == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaDesconto),
      valorDesconto: valorDesconto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDesconto),
      valorTotal: valorTotal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotal),
      cst: cst == null && nullToAbsent
        ? const Value.absent()
        : Value(cst),
      csosn: csosn == null && nullToAbsent
        ? const Value.absent()
        : Value(csosn),
      cfop: cfop == null && nullToAbsent
        ? const Value.absent()
        : Value(cfop),
    );
  }

  factory CompraPedidoDetalhe.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CompraPedidoDetalhe(
      id: serializer.fromJson<int>(json['id']),
      idCompraPedidoCabecalho: serializer.fromJson<int>(json['idCompraPedidoCabecalho']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      quantidade: serializer.fromJson<double>(json['quantidade']),
      valorUnitario: serializer.fromJson<double>(json['valorUnitario']),
      valorSubtotal: serializer.fromJson<double>(json['valorSubtotal']),
      taxaDesconto: serializer.fromJson<double>(json['taxaDesconto']),
      valorDesconto: serializer.fromJson<double>(json['valorDesconto']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
      cst: serializer.fromJson<String>(json['cst']),
      csosn: serializer.fromJson<String>(json['csosn']),
      cfop: serializer.fromJson<int>(json['cfop']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idCompraPedidoCabecalho': serializer.toJson<int?>(idCompraPedidoCabecalho),
      'idProduto': serializer.toJson<int?>(idProduto),
      'quantidade': serializer.toJson<double?>(quantidade),
      'valorUnitario': serializer.toJson<double?>(valorUnitario),
      'valorSubtotal': serializer.toJson<double?>(valorSubtotal),
      'taxaDesconto': serializer.toJson<double?>(taxaDesconto),
      'valorDesconto': serializer.toJson<double?>(valorDesconto),
      'valorTotal': serializer.toJson<double?>(valorTotal),
      'cst': serializer.toJson<String?>(cst),
      'csosn': serializer.toJson<String?>(csosn),
      'cfop': serializer.toJson<int?>(cfop),
    };
  }

  CompraPedidoDetalhe copyWith(
        {
		  int? id,
          int? idCompraPedidoCabecalho,
          int? idProduto,
          double? quantidade,
          double? valorUnitario,
          double? valorSubtotal,
          double? taxaDesconto,
          double? valorDesconto,
          double? valorTotal,
          String? cst,
          String? csosn,
          int? cfop,
		}) =>
      CompraPedidoDetalhe(
        id: id ?? this.id,
        idCompraPedidoCabecalho: idCompraPedidoCabecalho ?? this.idCompraPedidoCabecalho,
        idProduto: idProduto ?? this.idProduto,
        quantidade: quantidade ?? this.quantidade,
        valorUnitario: valorUnitario ?? this.valorUnitario,
        valorSubtotal: valorSubtotal ?? this.valorSubtotal,
        taxaDesconto: taxaDesconto ?? this.taxaDesconto,
        valorDesconto: valorDesconto ?? this.valorDesconto,
        valorTotal: valorTotal ?? this.valorTotal,
        cst: cst ?? this.cst,
        csosn: csosn ?? this.csosn,
        cfop: cfop ?? this.cfop,
      );
  
  @override
  String toString() {
    return (StringBuffer('CompraPedidoDetalhe(')
          ..write('id: $id, ')
          ..write('idCompraPedidoCabecalho: $idCompraPedidoCabecalho, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorSubtotal: $valorSubtotal, ')
          ..write('taxaDesconto: $taxaDesconto, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('cst: $cst, ')
          ..write('csosn: $csosn, ')
          ..write('cfop: $cfop, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idCompraPedidoCabecalho,
      idProduto,
      quantidade,
      valorUnitario,
      valorSubtotal,
      taxaDesconto,
      valorDesconto,
      valorTotal,
      cst,
      csosn,
      cfop,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompraPedidoDetalhe &&
          other.id == id &&
          other.idCompraPedidoCabecalho == idCompraPedidoCabecalho &&
          other.idProduto == idProduto &&
          other.quantidade == quantidade &&
          other.valorUnitario == valorUnitario &&
          other.valorSubtotal == valorSubtotal &&
          other.taxaDesconto == taxaDesconto &&
          other.valorDesconto == valorDesconto &&
          other.valorTotal == valorTotal &&
          other.cst == cst &&
          other.csosn == csosn &&
          other.cfop == cfop 
	   );
}

class CompraPedidoDetalhesCompanion extends UpdateCompanion<CompraPedidoDetalhe> {

  final Value<int?> id;
  final Value<int?> idCompraPedidoCabecalho;
  final Value<int?> idProduto;
  final Value<double?> quantidade;
  final Value<double?> valorUnitario;
  final Value<double?> valorSubtotal;
  final Value<double?> taxaDesconto;
  final Value<double?> valorDesconto;
  final Value<double?> valorTotal;
  final Value<String?> cst;
  final Value<String?> csosn;
  final Value<int?> cfop;

  const CompraPedidoDetalhesCompanion({
    this.id = const Value.absent(),
    this.idCompraPedidoCabecalho = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.valorSubtotal = const Value.absent(),
    this.taxaDesconto = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.cst = const Value.absent(),
    this.csosn = const Value.absent(),
    this.cfop = const Value.absent(),
  });

  CompraPedidoDetalhesCompanion.insert({
    this.id = const Value.absent(),
    this.idCompraPedidoCabecalho = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.valorSubtotal = const Value.absent(),
    this.taxaDesconto = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.cst = const Value.absent(),
    this.csosn = const Value.absent(),
    this.cfop = const Value.absent(),
  });

  static Insertable<CompraPedidoDetalhe> custom({
    Expression<int>? id,
    Expression<int>? idCompraPedidoCabecalho,
    Expression<int>? idProduto,
    Expression<double>? quantidade,
    Expression<double>? valorUnitario,
    Expression<double>? valorSubtotal,
    Expression<double>? taxaDesconto,
    Expression<double>? valorDesconto,
    Expression<double>? valorTotal,
    Expression<String>? cst,
    Expression<String>? csosn,
    Expression<int>? cfop,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idCompraPedidoCabecalho != null) 'ID_COMPRA_PEDIDO_CABECALHO': idCompraPedidoCabecalho,
      if (idProduto != null) 'ID_PRODUTO': idProduto,
      if (quantidade != null) 'QUANTIDADE': quantidade,
      if (valorUnitario != null) 'VALOR_UNITARIO': valorUnitario,
      if (valorSubtotal != null) 'VALOR_SUBTOTAL': valorSubtotal,
      if (taxaDesconto != null) 'TAXA_DESCONTO': taxaDesconto,
      if (valorDesconto != null) 'VALOR_DESCONTO': valorDesconto,
      if (valorTotal != null) 'VALOR_TOTAL': valorTotal,
      if (cst != null) 'CST': cst,
      if (csosn != null) 'CSOSN': csosn,
      if (cfop != null) 'CFOP': cfop,
    });
  }

  CompraPedidoDetalhesCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idCompraPedidoCabecalho,
      Value<int>? idProduto,
      Value<double>? quantidade,
      Value<double>? valorUnitario,
      Value<double>? valorSubtotal,
      Value<double>? taxaDesconto,
      Value<double>? valorDesconto,
      Value<double>? valorTotal,
      Value<String>? cst,
      Value<String>? csosn,
      Value<int>? cfop,
	  }) {
    return CompraPedidoDetalhesCompanion(
      id: id ?? this.id,
      idCompraPedidoCabecalho: idCompraPedidoCabecalho ?? this.idCompraPedidoCabecalho,
      idProduto: idProduto ?? this.idProduto,
      quantidade: quantidade ?? this.quantidade,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      valorSubtotal: valorSubtotal ?? this.valorSubtotal,
      taxaDesconto: taxaDesconto ?? this.taxaDesconto,
      valorDesconto: valorDesconto ?? this.valorDesconto,
      valorTotal: valorTotal ?? this.valorTotal,
      cst: cst ?? this.cst,
      csosn: csosn ?? this.csosn,
      cfop: cfop ?? this.cfop,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idCompraPedidoCabecalho.present) {
      map['ID_COMPRA_PEDIDO_CABECALHO'] = Variable<int?>(idCompraPedidoCabecalho.value);
    }
    if (idProduto.present) {
      map['ID_PRODUTO'] = Variable<int?>(idProduto.value);
    }
    if (quantidade.present) {
      map['QUANTIDADE'] = Variable<double?>(quantidade.value);
    }
    if (valorUnitario.present) {
      map['VALOR_UNITARIO'] = Variable<double?>(valorUnitario.value);
    }
    if (valorSubtotal.present) {
      map['VALOR_SUBTOTAL'] = Variable<double?>(valorSubtotal.value);
    }
    if (taxaDesconto.present) {
      map['TAXA_DESCONTO'] = Variable<double?>(taxaDesconto.value);
    }
    if (valorDesconto.present) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto.value);
    }
    if (valorTotal.present) {
      map['VALOR_TOTAL'] = Variable<double?>(valorTotal.value);
    }
    if (cst.present) {
      map['CST'] = Variable<String?>(cst.value);
    }
    if (csosn.present) {
      map['CSOSN'] = Variable<String?>(csosn.value);
    }
    if (cfop.present) {
      map['CFOP'] = Variable<int?>(cfop.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompraPedidoDetalhesCompanion(')
          ..write('id: $id, ')
          ..write('idCompraPedidoCabecalho: $idCompraPedidoCabecalho, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorSubtotal: $valorSubtotal, ')
          ..write('taxaDesconto: $taxaDesconto, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('cst: $cst, ')
          ..write('csosn: $csosn, ')
          ..write('cfop: $cfop, ')
          ..write(')'))
        .toString();
  }
}

class $CompraPedidoDetalhesTable extends CompraPedidoDetalhes
    with TableInfo<$CompraPedidoDetalhesTable, CompraPedidoDetalhe> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CompraPedidoDetalhesTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idCompraPedidoCabecalhoMeta =
      const VerificationMeta('idCompraPedidoCabecalho');
  GeneratedColumn<int>? _idCompraPedidoCabecalho;
  @override
  GeneratedColumn<int> get idCompraPedidoCabecalho =>
      _idCompraPedidoCabecalho ??= GeneratedColumn<int>('ID_COMPRA_PEDIDO_CABECALHO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES COMPRA_PEDIDO_CABECALHO(ID)');
  final VerificationMeta _idProdutoMeta =
      const VerificationMeta('idProduto');
  GeneratedColumn<int>? _idProduto;
  @override
  GeneratedColumn<int> get idProduto =>
      _idProduto ??= GeneratedColumn<int>('ID_PRODUTO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PRODUTO(ID)');
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
  final VerificationMeta _valorSubtotalMeta =
      const VerificationMeta('valorSubtotal');
  GeneratedColumn<double>? _valorSubtotal;
  @override
  GeneratedColumn<double> get valorSubtotal => _valorSubtotal ??=
      GeneratedColumn<double>('VALOR_SUBTOTAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _taxaDescontoMeta =
      const VerificationMeta('taxaDesconto');
  GeneratedColumn<double>? _taxaDesconto;
  @override
  GeneratedColumn<double> get taxaDesconto => _taxaDesconto ??=
      GeneratedColumn<double>('TAXA_DESCONTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorDescontoMeta =
      const VerificationMeta('valorDesconto');
  GeneratedColumn<double>? _valorDesconto;
  @override
  GeneratedColumn<double> get valorDesconto => _valorDesconto ??=
      GeneratedColumn<double>('VALOR_DESCONTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorTotalMeta =
      const VerificationMeta('valorTotal');
  GeneratedColumn<double>? _valorTotal;
  @override
  GeneratedColumn<double> get valorTotal => _valorTotal ??=
      GeneratedColumn<double>('VALOR_TOTAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _cstMeta =
      const VerificationMeta('cst');
  GeneratedColumn<String>? _cst;
  @override
  GeneratedColumn<String> get cst => _cst ??=
      GeneratedColumn<String>('CST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _csosnMeta =
      const VerificationMeta('csosn');
  GeneratedColumn<String>? _csosn;
  @override
  GeneratedColumn<String> get csosn => _csosn ??=
      GeneratedColumn<String>('CSOSN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cfopMeta =
      const VerificationMeta('cfop');
  GeneratedColumn<int>? _cfop;
  @override
  GeneratedColumn<int> get cfop => _cfop ??=
      GeneratedColumn<int>('CFOP', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idCompraPedidoCabecalho,
        idProduto,
        quantidade,
        valorUnitario,
        valorSubtotal,
        taxaDesconto,
        valorDesconto,
        valorTotal,
        cst,
        csosn,
        cfop,
      ];

  @override
  String get aliasedName => _alias ?? 'COMPRA_PEDIDO_DETALHE';
  
  @override
  String get actualTableName => 'COMPRA_PEDIDO_DETALHE';
  
  @override
  VerificationContext validateIntegrity(Insertable<CompraPedidoDetalhe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_COMPRA_PEDIDO_CABECALHO')) {
        context.handle(_idCompraPedidoCabecalhoMeta,
            idCompraPedidoCabecalho.isAcceptableOrUnknown(data['ID_COMPRA_PEDIDO_CABECALHO']!, _idCompraPedidoCabecalhoMeta));
    }
    if (data.containsKey('ID_PRODUTO')) {
        context.handle(_idProdutoMeta,
            idProduto.isAcceptableOrUnknown(data['ID_PRODUTO']!, _idProdutoMeta));
    }
    if (data.containsKey('QUANTIDADE')) {
        context.handle(_quantidadeMeta,
            quantidade.isAcceptableOrUnknown(data['QUANTIDADE']!, _quantidadeMeta));
    }
    if (data.containsKey('VALOR_UNITARIO')) {
        context.handle(_valorUnitarioMeta,
            valorUnitario.isAcceptableOrUnknown(data['VALOR_UNITARIO']!, _valorUnitarioMeta));
    }
    if (data.containsKey('VALOR_SUBTOTAL')) {
        context.handle(_valorSubtotalMeta,
            valorSubtotal.isAcceptableOrUnknown(data['VALOR_SUBTOTAL']!, _valorSubtotalMeta));
    }
    if (data.containsKey('TAXA_DESCONTO')) {
        context.handle(_taxaDescontoMeta,
            taxaDesconto.isAcceptableOrUnknown(data['TAXA_DESCONTO']!, _taxaDescontoMeta));
    }
    if (data.containsKey('VALOR_DESCONTO')) {
        context.handle(_valorDescontoMeta,
            valorDesconto.isAcceptableOrUnknown(data['VALOR_DESCONTO']!, _valorDescontoMeta));
    }
    if (data.containsKey('VALOR_TOTAL')) {
        context.handle(_valorTotalMeta,
            valorTotal.isAcceptableOrUnknown(data['VALOR_TOTAL']!, _valorTotalMeta));
    }
    if (data.containsKey('CST')) {
        context.handle(_cstMeta,
            cst.isAcceptableOrUnknown(data['CST']!, _cstMeta));
    }
    if (data.containsKey('CSOSN')) {
        context.handle(_csosnMeta,
            csosn.isAcceptableOrUnknown(data['CSOSN']!, _csosnMeta));
    }
    if (data.containsKey('CFOP')) {
        context.handle(_cfopMeta,
            cfop.isAcceptableOrUnknown(data['CFOP']!, _cfopMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompraPedidoDetalhe map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CompraPedidoDetalhe.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CompraPedidoDetalhesTable createAlias(String alias) {
    return $CompraPedidoDetalhesTable(_db, alias);
  }
}