/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_VENDA_DETALHE] 
                                                                                
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
import 'package:pegasus_pdv/src/infra/infra.dart';

import '../database_classes.dart';

@DataClassName("PdvVendaDetalhe")
@UseRowClass(PdvVendaDetalhe)
class PdvVendaDetalhes extends Table {
  @override
  String get tableName => 'PDV_VENDA_DETALHE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idProduto => integer().named('ID_PRODUTO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO(ID)')();
  IntColumn get idPdvVendaCabecalho => integer().named('ID_PDV_VENDA_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES PDV_VENDA_CABECALHO(ID)')();
  IntColumn get cfop => integer().named('CFOP').nullable()();
  TextColumn get gtin => text().named('GTIN').withLength(min: 0, max: 14).nullable()();
  IntColumn get ccf => integer().named('CCF').nullable()();
  IntColumn get coo => integer().named('COO').nullable()();
  TextColumn get serieEcf => text().named('SERIE_ECF').withLength(min: 0, max: 20).nullable()();
  IntColumn get item => integer().named('ITEM').nullable()();
  RealColumn get quantidade => real().named('QUANTIDADE').nullable()();
  RealColumn get valorUnitario => real().named('VALOR_UNITARIO').nullable()();
  RealColumn get valorTotal => real().named('VALOR_TOTAL').nullable()();
  RealColumn get valorTotalItem => real().named('VALOR_TOTAL_ITEM').nullable()();
  RealColumn get valorBaseIcms => real().named('VALOR_BASE_ICMS').nullable()();
  RealColumn get taxaIcms => real().named('TAXA_ICMS').nullable()();
  RealColumn get valorIcms => real().named('VALOR_ICMS').nullable()();
  RealColumn get taxaDesconto => real().named('TAXA_DESCONTO').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get taxaIssqn => real().named('TAXA_ISSQN').nullable()();
  RealColumn get valorIssqn => real().named('VALOR_ISSQN').nullable()();
  RealColumn get taxaPis => real().named('TAXA_PIS').nullable()();
  RealColumn get valorPis => real().named('VALOR_PIS').nullable()();
  RealColumn get taxaCofins => real().named('TAXA_COFINS').nullable()();
  RealColumn get valorCofins => real().named('VALOR_COFINS').nullable()();
  RealColumn get taxaAcrescimo => real().named('TAXA_ACRESCIMO').nullable()();
  RealColumn get valorAcrescimo => real().named('VALOR_ACRESCIMO').nullable()();
  TextColumn get totalizadorParcial => text().named('TOTALIZADOR_PARCIAL').withLength(min: 0, max: 10).nullable()();
  TextColumn get cst => text().named('CST').withLength(min: 0, max: 3).nullable()();
  TextColumn get cancelado => text().named('CANCELADO').withLength(min: 0, max: 1).nullable()();
  TextColumn get movimentaEstoque => text().named('MOVIMENTA_ESTOQUE').withLength(min: 0, max: 1).nullable()();
  TextColumn get ecfIcmsSt => text().named('ECF_ICMS_ST').withLength(min: 0, max: 4).nullable()();
  RealColumn get valorImpostoFederal => real().named('VALOR_IMPOSTO_FEDERAL').nullable()();
  RealColumn get valorImpostoEstadual => real().named('VALOR_IMPOSTO_ESTADUAL').nullable()();
  RealColumn get valorImpostoMunicipal => real().named('VALOR_IMPOSTO_MUNICIPAL').nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()();
}

class VendaDetalhe {
  PdvVendaDetalhe? pdvVendaDetalhe;
  Produto? produto;

  VendaDetalhe({
    this.pdvVendaDetalhe,
    this.produto,
  });

  String? getIndex(int index) {
    switch (index) {
      case 0:
        return produto!.gtin;
      case 1:
        return produto!.nome;
      case 2:
        return Constantes.formatoDecimalValor.format(pdvVendaDetalhe!.valorUnitario ?? 0);
      case 3:
        return Constantes.formatoDecimalQuantidade.format(pdvVendaDetalhe!.quantidade ?? 0);
      case 4:
        return Constantes.formatoDecimalValor.format((pdvVendaDetalhe!.quantidade ?? 0) * (pdvVendaDetalhe!.valorUnitario ?? 0));
      case 5:
        return produto!.id.toString();
    }
    return '';
  }

}

class PdvVendaDetalhe extends DataClass implements Insertable<PdvVendaDetalhe> {
  final int? id;
  final int? idProduto;
  final int? idPdvVendaCabecalho;
  final int? cfop;
  final String? gtin;
  final int? ccf;
  final int? coo;
  final String? serieEcf;
  final int? item;
  final double? quantidade;
  final double? valorUnitario;
  final double? valorTotal;
  final double? valorTotalItem;
  final double? valorBaseIcms;
  final double? taxaIcms;
  final double? valorIcms;
  final double? taxaDesconto;
  final double? valorDesconto;
  final double? taxaIssqn;
  final double? valorIssqn;
  final double? taxaPis;
  final double? valorPis;
  final double? taxaCofins;
  final double? valorCofins;
  final double? taxaAcrescimo;
  final double? valorAcrescimo;
  final String? totalizadorParcial;
  final String? cst;
  final String? cancelado;
  final String? movimentaEstoque;
  final String? ecfIcmsSt;
  final double? valorImpostoFederal;
  final double? valorImpostoEstadual;
  final double? valorImpostoMunicipal;
  final String? hashRegistro;

  PdvVendaDetalhe(
    {
      required this.id,
      this.idProduto,
      this.idPdvVendaCabecalho,
      this.cfop,
      this.gtin,
      this.ccf,
      this.coo,
      this.serieEcf,
      this.item,
      this.quantidade,
      this.valorUnitario,
      this.valorTotal,
      this.valorTotalItem,
      this.valorBaseIcms,
      this.taxaIcms,
      this.valorIcms,
      this.taxaDesconto,
      this.valorDesconto,
      this.taxaIssqn,
      this.valorIssqn,
      this.taxaPis,
      this.valorPis,
      this.taxaCofins,
      this.valorCofins,
      this.taxaAcrescimo,
      this.valorAcrescimo,
      this.totalizadorParcial,
      this.cst,
      this.cancelado,
      this.movimentaEstoque,
      this.ecfIcmsSt,
      this.valorImpostoFederal,
      this.valorImpostoEstadual,
      this.valorImpostoMunicipal,
      this.hashRegistro,
    }
  );

  factory PdvVendaDetalhe.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PdvVendaDetalhe(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idProduto: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO']),
      idPdvVendaCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_VENDA_CABECALHO']),
      cfop: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CFOP']),
      gtin: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}GTIN']),
      ccf: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CCF']),
      coo: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}COO']),
      serieEcf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SERIE_ECF']),
      item: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ITEM']),
      quantidade: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE']),
      valorUnitario: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_UNITARIO']),
      valorTotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL']),
      valorTotalItem: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL_ITEM']),
      valorBaseIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BASE_ICMS']),
      taxaIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_ICMS']),
      valorIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS']),
      taxaDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_DESCONTO']),
      valorDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DESCONTO']),
      taxaIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_ISSQN']),
      valorIssqn: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ISSQN']),
      taxaPis: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_PIS']),
      valorPis: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PIS']),
      taxaCofins: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_COFINS']),
      valorCofins: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_COFINS']),
      taxaAcrescimo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_ACRESCIMO']),
      valorAcrescimo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ACRESCIMO']),
      totalizadorParcial: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TOTALIZADOR_PARCIAL']),
      cst: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CST']),
      cancelado: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CANCELADO']),
      movimentaEstoque: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MOVIMENTA_ESTOQUE']),
      ecfIcmsSt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ECF_ICMS_ST']),
      valorImpostoFederal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IMPOSTO_FEDERAL']),
      valorImpostoEstadual: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IMPOSTO_ESTADUAL']),
      valorImpostoMunicipal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IMPOSTO_MUNICIPAL']),
      hashRegistro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HASH_REGISTRO']),
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
    if (!nullToAbsent || idPdvVendaCabecalho != null) {
      map['ID_PDV_VENDA_CABECALHO'] = Variable<int?>(idPdvVendaCabecalho);
    }
    if (!nullToAbsent || cfop != null) {
      map['CFOP'] = Variable<int?>(cfop);
    }
    if (!nullToAbsent || gtin != null) {
      map['GTIN'] = Variable<String?>(gtin);
    }
    if (!nullToAbsent || ccf != null) {
      map['CCF'] = Variable<int?>(ccf);
    }
    if (!nullToAbsent || coo != null) {
      map['COO'] = Variable<int?>(coo);
    }
    if (!nullToAbsent || serieEcf != null) {
      map['SERIE_ECF'] = Variable<String?>(serieEcf);
    }
    if (!nullToAbsent || item != null) {
      map['ITEM'] = Variable<int?>(item);
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
    if (!nullToAbsent || valorTotalItem != null) {
      map['VALOR_TOTAL_ITEM'] = Variable<double?>(valorTotalItem);
    }
    if (!nullToAbsent || valorBaseIcms != null) {
      map['VALOR_BASE_ICMS'] = Variable<double?>(valorBaseIcms);
    }
    if (!nullToAbsent || taxaIcms != null) {
      map['TAXA_ICMS'] = Variable<double?>(taxaIcms);
    }
    if (!nullToAbsent || valorIcms != null) {
      map['VALOR_ICMS'] = Variable<double?>(valorIcms);
    }
    if (!nullToAbsent || taxaDesconto != null) {
      map['TAXA_DESCONTO'] = Variable<double?>(taxaDesconto);
    }
    if (!nullToAbsent || valorDesconto != null) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto);
    }
    if (!nullToAbsent || taxaIssqn != null) {
      map['TAXA_ISSQN'] = Variable<double?>(taxaIssqn);
    }
    if (!nullToAbsent || valorIssqn != null) {
      map['VALOR_ISSQN'] = Variable<double?>(valorIssqn);
    }
    if (!nullToAbsent || taxaPis != null) {
      map['TAXA_PIS'] = Variable<double?>(taxaPis);
    }
    if (!nullToAbsent || valorPis != null) {
      map['VALOR_PIS'] = Variable<double?>(valorPis);
    }
    if (!nullToAbsent || taxaCofins != null) {
      map['TAXA_COFINS'] = Variable<double?>(taxaCofins);
    }
    if (!nullToAbsent || valorCofins != null) {
      map['VALOR_COFINS'] = Variable<double?>(valorCofins);
    }
    if (!nullToAbsent || taxaAcrescimo != null) {
      map['TAXA_ACRESCIMO'] = Variable<double?>(taxaAcrescimo);
    }
    if (!nullToAbsent || valorAcrescimo != null) {
      map['VALOR_ACRESCIMO'] = Variable<double?>(valorAcrescimo);
    }
    if (!nullToAbsent || totalizadorParcial != null) {
      map['TOTALIZADOR_PARCIAL'] = Variable<String?>(totalizadorParcial);
    }
    if (!nullToAbsent || cst != null) {
      map['CST'] = Variable<String?>(cst);
    }
    if (!nullToAbsent || cancelado != null) {
      map['CANCELADO'] = Variable<String?>(cancelado);
    }
    if (!nullToAbsent || movimentaEstoque != null) {
      map['MOVIMENTA_ESTOQUE'] = Variable<String?>(movimentaEstoque);
    }
    if (!nullToAbsent || ecfIcmsSt != null) {
      map['ECF_ICMS_ST'] = Variable<String?>(ecfIcmsSt);
    }
    if (!nullToAbsent || valorImpostoFederal != null) {
      map['VALOR_IMPOSTO_FEDERAL'] = Variable<double?>(valorImpostoFederal);
    }
    if (!nullToAbsent || valorImpostoEstadual != null) {
      map['VALOR_IMPOSTO_ESTADUAL'] = Variable<double?>(valorImpostoEstadual);
    }
    if (!nullToAbsent || valorImpostoMunicipal != null) {
      map['VALOR_IMPOSTO_MUNICIPAL'] = Variable<double?>(valorImpostoMunicipal);
    }
    if (!nullToAbsent || hashRegistro != null) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro);
    }
    return map;
  }

  PdvVendaDetalhesCompanion toCompanion(bool nullToAbsent) {
    return PdvVendaDetalhesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idProduto: idProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(idProduto),
      idPdvVendaCabecalho: idPdvVendaCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvVendaCabecalho),
      cfop: cfop == null && nullToAbsent
        ? const Value.absent()
        : Value(cfop),
      gtin: gtin == null && nullToAbsent
        ? const Value.absent()
        : Value(gtin),
      ccf: ccf == null && nullToAbsent
        ? const Value.absent()
        : Value(ccf),
      coo: coo == null && nullToAbsent
        ? const Value.absent()
        : Value(coo),
      serieEcf: serieEcf == null && nullToAbsent
        ? const Value.absent()
        : Value(serieEcf),
      item: item == null && nullToAbsent
        ? const Value.absent()
        : Value(item),
      quantidade: quantidade == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidade),
      valorUnitario: valorUnitario == null && nullToAbsent
        ? const Value.absent()
        : Value(valorUnitario),
      valorTotal: valorTotal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotal),
      valorTotalItem: valorTotalItem == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotalItem),
      valorBaseIcms: valorBaseIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBaseIcms),
      taxaIcms: taxaIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaIcms),
      valorIcms: valorIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcms),
      taxaDesconto: taxaDesconto == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaDesconto),
      valorDesconto: valorDesconto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDesconto),
      taxaIssqn: taxaIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaIssqn),
      valorIssqn: valorIssqn == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIssqn),
      taxaPis: taxaPis == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaPis),
      valorPis: valorPis == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPis),
      taxaCofins: taxaCofins == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaCofins),
      valorCofins: valorCofins == null && nullToAbsent
        ? const Value.absent()
        : Value(valorCofins),
      taxaAcrescimo: taxaAcrescimo == null && nullToAbsent
        ? const Value.absent()
        : Value(taxaAcrescimo),
      valorAcrescimo: valorAcrescimo == null && nullToAbsent
        ? const Value.absent()
        : Value(valorAcrescimo),
      totalizadorParcial: totalizadorParcial == null && nullToAbsent
        ? const Value.absent()
        : Value(totalizadorParcial),
      cst: cst == null && nullToAbsent
        ? const Value.absent()
        : Value(cst),
      cancelado: cancelado == null && nullToAbsent
        ? const Value.absent()
        : Value(cancelado),
      movimentaEstoque: movimentaEstoque == null && nullToAbsent
        ? const Value.absent()
        : Value(movimentaEstoque),
      ecfIcmsSt: ecfIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(ecfIcmsSt),
      valorImpostoFederal: valorImpostoFederal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorImpostoFederal),
      valorImpostoEstadual: valorImpostoEstadual == null && nullToAbsent
        ? const Value.absent()
        : Value(valorImpostoEstadual),
      valorImpostoMunicipal: valorImpostoMunicipal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorImpostoMunicipal),
      hashRegistro: hashRegistro == null && nullToAbsent
        ? const Value.absent()
        : Value(hashRegistro),
    );
  }

  factory PdvVendaDetalhe.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvVendaDetalhe(
      id: serializer.fromJson<int>(json['id']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idPdvVendaCabecalho: serializer.fromJson<int>(json['idPdvVendaCabecalho']),
      cfop: serializer.fromJson<int>(json['cfop']),
      gtin: serializer.fromJson<String>(json['gtin']),
      ccf: serializer.fromJson<int>(json['ccf']),
      coo: serializer.fromJson<int>(json['coo']),
      serieEcf: serializer.fromJson<String>(json['serieEcf']),
      item: serializer.fromJson<int>(json['item']),
      quantidade: serializer.fromJson<double>(json['quantidade']),
      valorUnitario: serializer.fromJson<double>(json['valorUnitario']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
      valorTotalItem: serializer.fromJson<double>(json['valorTotalItem']),
      valorBaseIcms: serializer.fromJson<double>(json['valorBaseIcms']),
      taxaIcms: serializer.fromJson<double>(json['taxaIcms']),
      valorIcms: serializer.fromJson<double>(json['valorIcms']),
      taxaDesconto: serializer.fromJson<double>(json['taxaDesconto']),
      valorDesconto: serializer.fromJson<double>(json['valorDesconto']),
      taxaIssqn: serializer.fromJson<double>(json['taxaIssqn']),
      valorIssqn: serializer.fromJson<double>(json['valorIssqn']),
      taxaPis: serializer.fromJson<double>(json['taxaPis']),
      valorPis: serializer.fromJson<double>(json['valorPis']),
      taxaCofins: serializer.fromJson<double>(json['taxaCofins']),
      valorCofins: serializer.fromJson<double>(json['valorCofins']),
      taxaAcrescimo: serializer.fromJson<double>(json['taxaAcrescimo']),
      valorAcrescimo: serializer.fromJson<double>(json['valorAcrescimo']),
      totalizadorParcial: serializer.fromJson<String>(json['totalizadorParcial']),
      cst: serializer.fromJson<String>(json['cst']),
      cancelado: serializer.fromJson<String>(json['cancelado']),
      movimentaEstoque: serializer.fromJson<String>(json['movimentaEstoque']),
      ecfIcmsSt: serializer.fromJson<String>(json['ecfIcmsSt']),
      valorImpostoFederal: serializer.fromJson<double>(json['valorImpostoFederal']),
      valorImpostoEstadual: serializer.fromJson<double>(json['valorImpostoEstadual']),
      valorImpostoMunicipal: serializer.fromJson<double>(json['valorImpostoMunicipal']),
      hashRegistro: serializer.fromJson<String>(json['hashRegistro']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idProduto': serializer.toJson<int?>(idProduto),
      'idPdvVendaCabecalho': serializer.toJson<int?>(idPdvVendaCabecalho),
      'cfop': serializer.toJson<int?>(cfop),
      'gtin': serializer.toJson<String?>(gtin),
      'ccf': serializer.toJson<int?>(ccf),
      'coo': serializer.toJson<int?>(coo),
      'serieEcf': serializer.toJson<String?>(serieEcf),
      'item': serializer.toJson<int?>(item),
      'quantidade': serializer.toJson<double?>(quantidade),
      'valorUnitario': serializer.toJson<double?>(valorUnitario),
      'valorTotal': serializer.toJson<double?>(valorTotal),
      'valorTotalItem': serializer.toJson<double?>(valorTotalItem),
      'valorBaseIcms': serializer.toJson<double?>(valorBaseIcms),
      'taxaIcms': serializer.toJson<double?>(taxaIcms),
      'valorIcms': serializer.toJson<double?>(valorIcms),
      'taxaDesconto': serializer.toJson<double?>(taxaDesconto),
      'valorDesconto': serializer.toJson<double?>(valorDesconto),
      'taxaIssqn': serializer.toJson<double?>(taxaIssqn),
      'valorIssqn': serializer.toJson<double?>(valorIssqn),
      'taxaPis': serializer.toJson<double?>(taxaPis),
      'valorPis': serializer.toJson<double?>(valorPis),
      'taxaCofins': serializer.toJson<double?>(taxaCofins),
      'valorCofins': serializer.toJson<double?>(valorCofins),
      'taxaAcrescimo': serializer.toJson<double?>(taxaAcrescimo),
      'valorAcrescimo': serializer.toJson<double?>(valorAcrescimo),
      'totalizadorParcial': serializer.toJson<String?>(totalizadorParcial),
      'cst': serializer.toJson<String?>(cst),
      'cancelado': serializer.toJson<String?>(cancelado),
      'movimentaEstoque': serializer.toJson<String?>(movimentaEstoque),
      'ecfIcmsSt': serializer.toJson<String?>(ecfIcmsSt),
      'valorImpostoFederal': serializer.toJson<double?>(valorImpostoFederal),
      'valorImpostoEstadual': serializer.toJson<double?>(valorImpostoEstadual),
      'valorImpostoMunicipal': serializer.toJson<double?>(valorImpostoMunicipal),
      'hashRegistro': serializer.toJson<String?>(hashRegistro),
    };
  }

  PdvVendaDetalhe copyWith(
        {
		  int? id,
          int? idProduto,
          int? idPdvVendaCabecalho,
          int? cfop,
          String? gtin,
          int? ccf,
          int? coo,
          String? serieEcf,
          int? item,
          double? quantidade,
          double? valorUnitario,
          double? valorTotal,
          double? valorTotalItem,
          double? valorBaseIcms,
          double? taxaIcms,
          double? valorIcms,
          double? taxaDesconto,
          double? valorDesconto,
          double? taxaIssqn,
          double? valorIssqn,
          double? taxaPis,
          double? valorPis,
          double? taxaCofins,
          double? valorCofins,
          double? taxaAcrescimo,
          double? valorAcrescimo,
          String? totalizadorParcial,
          String? cst,
          String? cancelado,
          String? movimentaEstoque,
          String? ecfIcmsSt,
          double? valorImpostoFederal,
          double? valorImpostoEstadual,
          double? valorImpostoMunicipal,
          String? hashRegistro,
		}) =>
      PdvVendaDetalhe(
        id: id ?? this.id,
        idProduto: idProduto ?? this.idProduto,
        idPdvVendaCabecalho: idPdvVendaCabecalho ?? this.idPdvVendaCabecalho,
        cfop: cfop ?? this.cfop,
        gtin: gtin ?? this.gtin,
        ccf: ccf ?? this.ccf,
        coo: coo ?? this.coo,
        serieEcf: serieEcf ?? this.serieEcf,
        item: item ?? this.item,
        quantidade: quantidade ?? this.quantidade,
        valorUnitario: valorUnitario ?? this.valorUnitario,
        valorTotal: valorTotal ?? this.valorTotal,
        valorTotalItem: valorTotalItem ?? this.valorTotalItem,
        valorBaseIcms: valorBaseIcms ?? this.valorBaseIcms,
        taxaIcms: taxaIcms ?? this.taxaIcms,
        valorIcms: valorIcms ?? this.valorIcms,
        taxaDesconto: taxaDesconto ?? this.taxaDesconto,
        valorDesconto: valorDesconto ?? this.valorDesconto,
        taxaIssqn: taxaIssqn ?? this.taxaIssqn,
        valorIssqn: valorIssqn ?? this.valorIssqn,
        taxaPis: taxaPis ?? this.taxaPis,
        valorPis: valorPis ?? this.valorPis,
        taxaCofins: taxaCofins ?? this.taxaCofins,
        valorCofins: valorCofins ?? this.valorCofins,
        taxaAcrescimo: taxaAcrescimo ?? this.taxaAcrescimo,
        valorAcrescimo: valorAcrescimo ?? this.valorAcrescimo,
        totalizadorParcial: totalizadorParcial ?? this.totalizadorParcial,
        cst: cst ?? this.cst,
        cancelado: cancelado ?? this.cancelado,
        movimentaEstoque: movimentaEstoque ?? this.movimentaEstoque,
        ecfIcmsSt: ecfIcmsSt ?? this.ecfIcmsSt,
        valorImpostoFederal: valorImpostoFederal ?? this.valorImpostoFederal,
        valorImpostoEstadual: valorImpostoEstadual ?? this.valorImpostoEstadual,
        valorImpostoMunicipal: valorImpostoMunicipal ?? this.valorImpostoMunicipal,
        hashRegistro: hashRegistro ?? this.hashRegistro,
      );
  
  @override
  String toString() {
    return (StringBuffer('PdvVendaDetalhe(')
          ..write('id: $id, ')
          ..write('idProduto: $idProduto, ')
          ..write('idPdvVendaCabecalho: $idPdvVendaCabecalho, ')
          ..write('cfop: $cfop, ')
          ..write('gtin: $gtin, ')
          ..write('ccf: $ccf, ')
          ..write('coo: $coo, ')
          ..write('serieEcf: $serieEcf, ')
          ..write('item: $item, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('valorTotalItem: $valorTotalItem, ')
          ..write('valorBaseIcms: $valorBaseIcms, ')
          ..write('taxaIcms: $taxaIcms, ')
          ..write('valorIcms: $valorIcms, ')
          ..write('taxaDesconto: $taxaDesconto, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('taxaIssqn: $taxaIssqn, ')
          ..write('valorIssqn: $valorIssqn, ')
          ..write('taxaPis: $taxaPis, ')
          ..write('valorPis: $valorPis, ')
          ..write('taxaCofins: $taxaCofins, ')
          ..write('valorCofins: $valorCofins, ')
          ..write('taxaAcrescimo: $taxaAcrescimo, ')
          ..write('valorAcrescimo: $valorAcrescimo, ')
          ..write('totalizadorParcial: $totalizadorParcial, ')
          ..write('cst: $cst, ')
          ..write('cancelado: $cancelado, ')
          ..write('movimentaEstoque: $movimentaEstoque, ')
          ..write('ecfIcmsSt: $ecfIcmsSt, ')
          ..write('valorImpostoFederal: $valorImpostoFederal, ')
          ..write('valorImpostoEstadual: $valorImpostoEstadual, ')
          ..write('valorImpostoMunicipal: $valorImpostoMunicipal, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idProduto,
      idPdvVendaCabecalho,
      cfop,
      gtin,
      ccf,
      coo,
      serieEcf,
      item,
      quantidade,
      valorUnitario,
      valorTotal,
      valorTotalItem,
      valorBaseIcms,
      taxaIcms,
      valorIcms,
      taxaDesconto,
      valorDesconto,
      taxaIssqn,
      valorIssqn,
      taxaPis,
      valorPis,
      taxaCofins,
      valorCofins,
      taxaAcrescimo,
      valorAcrescimo,
      totalizadorParcial,
      cst,
      cancelado,
      movimentaEstoque,
      ecfIcmsSt,
      valorImpostoFederal,
      valorImpostoEstadual,
      valorImpostoMunicipal,
      hashRegistro,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdvVendaDetalhe &&
          other.id == id &&
          other.idProduto == idProduto &&
          other.idPdvVendaCabecalho == idPdvVendaCabecalho &&
          other.cfop == cfop &&
          other.gtin == gtin &&
          other.ccf == ccf &&
          other.coo == coo &&
          other.serieEcf == serieEcf &&
          other.item == item &&
          other.quantidade == quantidade &&
          other.valorUnitario == valorUnitario &&
          other.valorTotal == valorTotal &&
          other.valorTotalItem == valorTotalItem &&
          other.valorBaseIcms == valorBaseIcms &&
          other.taxaIcms == taxaIcms &&
          other.valorIcms == valorIcms &&
          other.taxaDesconto == taxaDesconto &&
          other.valorDesconto == valorDesconto &&
          other.taxaIssqn == taxaIssqn &&
          other.valorIssqn == valorIssqn &&
          other.taxaPis == taxaPis &&
          other.valorPis == valorPis &&
          other.taxaCofins == taxaCofins &&
          other.valorCofins == valorCofins &&
          other.taxaAcrescimo == taxaAcrescimo &&
          other.valorAcrescimo == valorAcrescimo &&
          other.totalizadorParcial == totalizadorParcial &&
          other.cst == cst &&
          other.cancelado == cancelado &&
          other.movimentaEstoque == movimentaEstoque &&
          other.ecfIcmsSt == ecfIcmsSt &&
          other.valorImpostoFederal == valorImpostoFederal &&
          other.valorImpostoEstadual == valorImpostoEstadual &&
          other.valorImpostoMunicipal == valorImpostoMunicipal &&
          other.hashRegistro == hashRegistro 
	   );
}

class PdvVendaDetalhesCompanion extends UpdateCompanion<PdvVendaDetalhe> {

  final Value<int?> id;
  final Value<int?> idProduto;
  final Value<int?> idPdvVendaCabecalho;
  final Value<int?> cfop;
  final Value<String?> gtin;
  final Value<int?> ccf;
  final Value<int?> coo;
  final Value<String?> serieEcf;
  final Value<int?> item;
  final Value<double?> quantidade;
  final Value<double?> valorUnitario;
  final Value<double?> valorTotal;
  final Value<double?> valorTotalItem;
  final Value<double?> valorBaseIcms;
  final Value<double?> taxaIcms;
  final Value<double?> valorIcms;
  final Value<double?> taxaDesconto;
  final Value<double?> valorDesconto;
  final Value<double?> taxaIssqn;
  final Value<double?> valorIssqn;
  final Value<double?> taxaPis;
  final Value<double?> valorPis;
  final Value<double?> taxaCofins;
  final Value<double?> valorCofins;
  final Value<double?> taxaAcrescimo;
  final Value<double?> valorAcrescimo;
  final Value<String?> totalizadorParcial;
  final Value<String?> cst;
  final Value<String?> cancelado;
  final Value<String?> movimentaEstoque;
  final Value<String?> ecfIcmsSt;
  final Value<double?> valorImpostoFederal;
  final Value<double?> valorImpostoEstadual;
  final Value<double?> valorImpostoMunicipal;
  final Value<String?> hashRegistro;

  const PdvVendaDetalhesCompanion({
    this.id = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.idPdvVendaCabecalho = const Value.absent(),
    this.cfop = const Value.absent(),
    this.gtin = const Value.absent(),
    this.ccf = const Value.absent(),
    this.coo = const Value.absent(),
    this.serieEcf = const Value.absent(),
    this.item = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.valorTotalItem = const Value.absent(),
    this.valorBaseIcms = const Value.absent(),
    this.taxaIcms = const Value.absent(),
    this.valorIcms = const Value.absent(),
    this.taxaDesconto = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.taxaIssqn = const Value.absent(),
    this.valorIssqn = const Value.absent(),
    this.taxaPis = const Value.absent(),
    this.valorPis = const Value.absent(),
    this.taxaCofins = const Value.absent(),
    this.valorCofins = const Value.absent(),
    this.taxaAcrescimo = const Value.absent(),
    this.valorAcrescimo = const Value.absent(),
    this.totalizadorParcial = const Value.absent(),
    this.cst = const Value.absent(),
    this.cancelado = const Value.absent(),
    this.movimentaEstoque = const Value.absent(),
    this.ecfIcmsSt = const Value.absent(),
    this.valorImpostoFederal = const Value.absent(),
    this.valorImpostoEstadual = const Value.absent(),
    this.valorImpostoMunicipal = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  PdvVendaDetalhesCompanion.insert({
    this.id = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.idPdvVendaCabecalho = const Value.absent(),
    this.cfop = const Value.absent(),
    this.gtin = const Value.absent(),
    this.ccf = const Value.absent(),
    this.coo = const Value.absent(),
    this.serieEcf = const Value.absent(),
    this.item = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.valorTotalItem = const Value.absent(),
    this.valorBaseIcms = const Value.absent(),
    this.taxaIcms = const Value.absent(),
    this.valorIcms = const Value.absent(),
    this.taxaDesconto = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.taxaIssqn = const Value.absent(),
    this.valorIssqn = const Value.absent(),
    this.taxaPis = const Value.absent(),
    this.valorPis = const Value.absent(),
    this.taxaCofins = const Value.absent(),
    this.valorCofins = const Value.absent(),
    this.taxaAcrescimo = const Value.absent(),
    this.valorAcrescimo = const Value.absent(),
    this.totalizadorParcial = const Value.absent(),
    this.cst = const Value.absent(),
    this.cancelado = const Value.absent(),
    this.movimentaEstoque = const Value.absent(),
    this.ecfIcmsSt = const Value.absent(),
    this.valorImpostoFederal = const Value.absent(),
    this.valorImpostoEstadual = const Value.absent(),
    this.valorImpostoMunicipal = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  static Insertable<PdvVendaDetalhe> custom({
    Expression<int>? id,
    Expression<int>? idProduto,
    Expression<int>? idPdvVendaCabecalho,
    Expression<int>? cfop,
    Expression<String>? gtin,
    Expression<int>? ccf,
    Expression<int>? coo,
    Expression<String>? serieEcf,
    Expression<int>? item,
    Expression<double>? quantidade,
    Expression<double>? valorUnitario,
    Expression<double>? valorTotal,
    Expression<double>? valorTotalItem,
    Expression<double>? valorBaseIcms,
    Expression<double>? taxaIcms,
    Expression<double>? valorIcms,
    Expression<double>? taxaDesconto,
    Expression<double>? valorDesconto,
    Expression<double>? taxaIssqn,
    Expression<double>? valorIssqn,
    Expression<double>? taxaPis,
    Expression<double>? valorPis,
    Expression<double>? taxaCofins,
    Expression<double>? valorCofins,
    Expression<double>? taxaAcrescimo,
    Expression<double>? valorAcrescimo,
    Expression<String>? totalizadorParcial,
    Expression<String>? cst,
    Expression<String>? cancelado,
    Expression<String>? movimentaEstoque,
    Expression<String>? ecfIcmsSt,
    Expression<double>? valorImpostoFederal,
    Expression<double>? valorImpostoEstadual,
    Expression<double>? valorImpostoMunicipal,
    Expression<String>? hashRegistro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idProduto != null) 'ID_PRODUTO': idProduto,
      if (idPdvVendaCabecalho != null) 'ID_PDV_VENDA_CABECALHO': idPdvVendaCabecalho,
      if (cfop != null) 'CFOP': cfop,
      if (gtin != null) 'GTIN': gtin,
      if (ccf != null) 'CCF': ccf,
      if (coo != null) 'COO': coo,
      if (serieEcf != null) 'SERIE_ECF': serieEcf,
      if (item != null) 'ITEM': item,
      if (quantidade != null) 'QUANTIDADE': quantidade,
      if (valorUnitario != null) 'VALOR_UNITARIO': valorUnitario,
      if (valorTotal != null) 'VALOR_TOTAL': valorTotal,
      if (valorTotalItem != null) 'VALOR_TOTAL_ITEM': valorTotalItem,
      if (valorBaseIcms != null) 'VALOR_BASE_ICMS': valorBaseIcms,
      if (taxaIcms != null) 'TAXA_ICMS': taxaIcms,
      if (valorIcms != null) 'VALOR_ICMS': valorIcms,
      if (taxaDesconto != null) 'TAXA_DESCONTO': taxaDesconto,
      if (valorDesconto != null) 'VALOR_DESCONTO': valorDesconto,
      if (taxaIssqn != null) 'TAXA_ISSQN': taxaIssqn,
      if (valorIssqn != null) 'VALOR_ISSQN': valorIssqn,
      if (taxaPis != null) 'TAXA_PIS': taxaPis,
      if (valorPis != null) 'VALOR_PIS': valorPis,
      if (taxaCofins != null) 'TAXA_COFINS': taxaCofins,
      if (valorCofins != null) 'VALOR_COFINS': valorCofins,
      if (taxaAcrescimo != null) 'TAXA_ACRESCIMO': taxaAcrescimo,
      if (valorAcrescimo != null) 'VALOR_ACRESCIMO': valorAcrescimo,
      if (totalizadorParcial != null) 'TOTALIZADOR_PARCIAL': totalizadorParcial,
      if (cst != null) 'CST': cst,
      if (cancelado != null) 'CANCELADO': cancelado,
      if (movimentaEstoque != null) 'MOVIMENTA_ESTOQUE': movimentaEstoque,
      if (ecfIcmsSt != null) 'ECF_ICMS_ST': ecfIcmsSt,
      if (valorImpostoFederal != null) 'VALOR_IMPOSTO_FEDERAL': valorImpostoFederal,
      if (valorImpostoEstadual != null) 'VALOR_IMPOSTO_ESTADUAL': valorImpostoEstadual,
      if (valorImpostoMunicipal != null) 'VALOR_IMPOSTO_MUNICIPAL': valorImpostoMunicipal,
      if (hashRegistro != null) 'HASH_REGISTRO': hashRegistro,
    });
  }

  PdvVendaDetalhesCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idProduto,
      Value<int>? idPdvVendaCabecalho,
      Value<int>? cfop,
      Value<String>? gtin,
      Value<int>? ccf,
      Value<int>? coo,
      Value<String>? serieEcf,
      Value<int>? item,
      Value<double>? quantidade,
      Value<double>? valorUnitario,
      Value<double>? valorTotal,
      Value<double>? valorTotalItem,
      Value<double>? valorBaseIcms,
      Value<double>? taxaIcms,
      Value<double>? valorIcms,
      Value<double>? taxaDesconto,
      Value<double>? valorDesconto,
      Value<double>? taxaIssqn,
      Value<double>? valorIssqn,
      Value<double>? taxaPis,
      Value<double>? valorPis,
      Value<double>? taxaCofins,
      Value<double>? valorCofins,
      Value<double>? taxaAcrescimo,
      Value<double>? valorAcrescimo,
      Value<String>? totalizadorParcial,
      Value<String>? cst,
      Value<String>? cancelado,
      Value<String>? movimentaEstoque,
      Value<String>? ecfIcmsSt,
      Value<double>? valorImpostoFederal,
      Value<double>? valorImpostoEstadual,
      Value<double>? valorImpostoMunicipal,
      Value<String>? hashRegistro,
	  }) {
    return PdvVendaDetalhesCompanion(
      id: id ?? this.id,
      idProduto: idProduto ?? this.idProduto,
      idPdvVendaCabecalho: idPdvVendaCabecalho ?? this.idPdvVendaCabecalho,
      cfop: cfop ?? this.cfop,
      gtin: gtin ?? this.gtin,
      ccf: ccf ?? this.ccf,
      coo: coo ?? this.coo,
      serieEcf: serieEcf ?? this.serieEcf,
      item: item ?? this.item,
      quantidade: quantidade ?? this.quantidade,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      valorTotal: valorTotal ?? this.valorTotal,
      valorTotalItem: valorTotalItem ?? this.valorTotalItem,
      valorBaseIcms: valorBaseIcms ?? this.valorBaseIcms,
      taxaIcms: taxaIcms ?? this.taxaIcms,
      valorIcms: valorIcms ?? this.valorIcms,
      taxaDesconto: taxaDesconto ?? this.taxaDesconto,
      valorDesconto: valorDesconto ?? this.valorDesconto,
      taxaIssqn: taxaIssqn ?? this.taxaIssqn,
      valorIssqn: valorIssqn ?? this.valorIssqn,
      taxaPis: taxaPis ?? this.taxaPis,
      valorPis: valorPis ?? this.valorPis,
      taxaCofins: taxaCofins ?? this.taxaCofins,
      valorCofins: valorCofins ?? this.valorCofins,
      taxaAcrescimo: taxaAcrescimo ?? this.taxaAcrescimo,
      valorAcrescimo: valorAcrescimo ?? this.valorAcrescimo,
      totalizadorParcial: totalizadorParcial ?? this.totalizadorParcial,
      cst: cst ?? this.cst,
      cancelado: cancelado ?? this.cancelado,
      movimentaEstoque: movimentaEstoque ?? this.movimentaEstoque,
      ecfIcmsSt: ecfIcmsSt ?? this.ecfIcmsSt,
      valorImpostoFederal: valorImpostoFederal ?? this.valorImpostoFederal,
      valorImpostoEstadual: valorImpostoEstadual ?? this.valorImpostoEstadual,
      valorImpostoMunicipal: valorImpostoMunicipal ?? this.valorImpostoMunicipal,
      hashRegistro: hashRegistro ?? this.hashRegistro,
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
    if (idPdvVendaCabecalho.present) {
      map['ID_PDV_VENDA_CABECALHO'] = Variable<int?>(idPdvVendaCabecalho.value);
    }
    if (cfop.present) {
      map['CFOP'] = Variable<int?>(cfop.value);
    }
    if (gtin.present) {
      map['GTIN'] = Variable<String?>(gtin.value);
    }
    if (ccf.present) {
      map['CCF'] = Variable<int?>(ccf.value);
    }
    if (coo.present) {
      map['COO'] = Variable<int?>(coo.value);
    }
    if (serieEcf.present) {
      map['SERIE_ECF'] = Variable<String?>(serieEcf.value);
    }
    if (item.present) {
      map['ITEM'] = Variable<int?>(item.value);
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
    if (valorTotalItem.present) {
      map['VALOR_TOTAL_ITEM'] = Variable<double?>(valorTotalItem.value);
    }
    if (valorBaseIcms.present) {
      map['VALOR_BASE_ICMS'] = Variable<double?>(valorBaseIcms.value);
    }
    if (taxaIcms.present) {
      map['TAXA_ICMS'] = Variable<double?>(taxaIcms.value);
    }
    if (valorIcms.present) {
      map['VALOR_ICMS'] = Variable<double?>(valorIcms.value);
    }
    if (taxaDesconto.present) {
      map['TAXA_DESCONTO'] = Variable<double?>(taxaDesconto.value);
    }
    if (valorDesconto.present) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto.value);
    }
    if (taxaIssqn.present) {
      map['TAXA_ISSQN'] = Variable<double?>(taxaIssqn.value);
    }
    if (valorIssqn.present) {
      map['VALOR_ISSQN'] = Variable<double?>(valorIssqn.value);
    }
    if (taxaPis.present) {
      map['TAXA_PIS'] = Variable<double?>(taxaPis.value);
    }
    if (valorPis.present) {
      map['VALOR_PIS'] = Variable<double?>(valorPis.value);
    }
    if (taxaCofins.present) {
      map['TAXA_COFINS'] = Variable<double?>(taxaCofins.value);
    }
    if (valorCofins.present) {
      map['VALOR_COFINS'] = Variable<double?>(valorCofins.value);
    }
    if (taxaAcrescimo.present) {
      map['TAXA_ACRESCIMO'] = Variable<double?>(taxaAcrescimo.value);
    }
    if (valorAcrescimo.present) {
      map['VALOR_ACRESCIMO'] = Variable<double?>(valorAcrescimo.value);
    }
    if (totalizadorParcial.present) {
      map['TOTALIZADOR_PARCIAL'] = Variable<String?>(totalizadorParcial.value);
    }
    if (cst.present) {
      map['CST'] = Variable<String?>(cst.value);
    }
    if (cancelado.present) {
      map['CANCELADO'] = Variable<String?>(cancelado.value);
    }
    if (movimentaEstoque.present) {
      map['MOVIMENTA_ESTOQUE'] = Variable<String?>(movimentaEstoque.value);
    }
    if (ecfIcmsSt.present) {
      map['ECF_ICMS_ST'] = Variable<String?>(ecfIcmsSt.value);
    }
    if (valorImpostoFederal.present) {
      map['VALOR_IMPOSTO_FEDERAL'] = Variable<double?>(valorImpostoFederal.value);
    }
    if (valorImpostoEstadual.present) {
      map['VALOR_IMPOSTO_ESTADUAL'] = Variable<double?>(valorImpostoEstadual.value);
    }
    if (valorImpostoMunicipal.present) {
      map['VALOR_IMPOSTO_MUNICIPAL'] = Variable<double?>(valorImpostoMunicipal.value);
    }
    if (hashRegistro.present) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdvVendaDetalhesCompanion(')
          ..write('id: $id, ')
          ..write('idProduto: $idProduto, ')
          ..write('idPdvVendaCabecalho: $idPdvVendaCabecalho, ')
          ..write('cfop: $cfop, ')
          ..write('gtin: $gtin, ')
          ..write('ccf: $ccf, ')
          ..write('coo: $coo, ')
          ..write('serieEcf: $serieEcf, ')
          ..write('item: $item, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('valorTotalItem: $valorTotalItem, ')
          ..write('valorBaseIcms: $valorBaseIcms, ')
          ..write('taxaIcms: $taxaIcms, ')
          ..write('valorIcms: $valorIcms, ')
          ..write('taxaDesconto: $taxaDesconto, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('taxaIssqn: $taxaIssqn, ')
          ..write('valorIssqn: $valorIssqn, ')
          ..write('taxaPis: $taxaPis, ')
          ..write('valorPis: $valorPis, ')
          ..write('taxaCofins: $taxaCofins, ')
          ..write('valorCofins: $valorCofins, ')
          ..write('taxaAcrescimo: $taxaAcrescimo, ')
          ..write('valorAcrescimo: $valorAcrescimo, ')
          ..write('totalizadorParcial: $totalizadorParcial, ')
          ..write('cst: $cst, ')
          ..write('cancelado: $cancelado, ')
          ..write('movimentaEstoque: $movimentaEstoque, ')
          ..write('ecfIcmsSt: $ecfIcmsSt, ')
          ..write('valorImpostoFederal: $valorImpostoFederal, ')
          ..write('valorImpostoEstadual: $valorImpostoEstadual, ')
          ..write('valorImpostoMunicipal: $valorImpostoMunicipal, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }
}

class $PdvVendaDetalhesTable extends PdvVendaDetalhes
    with TableInfo<$PdvVendaDetalhesTable, PdvVendaDetalhe> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PdvVendaDetalhesTable(this._db, [this._alias]);
  
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
  final VerificationMeta _idPdvVendaCabecalhoMeta =
      const VerificationMeta('idPdvVendaCabecalho');
  GeneratedColumn<int>? _idPdvVendaCabecalho;
  @override
  GeneratedColumn<int> get idPdvVendaCabecalho =>
      _idPdvVendaCabecalho ??= GeneratedColumn<int>('ID_PDV_VENDA_CABECALHO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PDV_VENDA_CABECALHO(ID)');
  final VerificationMeta _cfopMeta =
      const VerificationMeta('cfop');
  GeneratedColumn<int>? _cfop;
  @override
  GeneratedColumn<int> get cfop => _cfop ??=
      GeneratedColumn<int>('CFOP', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _gtinMeta =
      const VerificationMeta('gtin');
  GeneratedColumn<String>? _gtin;
  @override
  GeneratedColumn<String> get gtin => _gtin ??=
      GeneratedColumn<String>('GTIN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ccfMeta =
      const VerificationMeta('ccf');
  GeneratedColumn<int>? _ccf;
  @override
  GeneratedColumn<int> get ccf => _ccf ??=
      GeneratedColumn<int>('CCF', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _cooMeta =
      const VerificationMeta('coo');
  GeneratedColumn<int>? _coo;
  @override
  GeneratedColumn<int> get coo => _coo ??=
      GeneratedColumn<int>('COO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _serieEcfMeta =
      const VerificationMeta('serieEcf');
  GeneratedColumn<String>? _serieEcf;
  @override
  GeneratedColumn<String> get serieEcf => _serieEcf ??=
      GeneratedColumn<String>('SERIE_ECF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _itemMeta =
      const VerificationMeta('item');
  GeneratedColumn<int>? _item;
  @override
  GeneratedColumn<int> get item => _item ??=
      GeneratedColumn<int>('ITEM', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
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
  final VerificationMeta _valorTotalItemMeta =
      const VerificationMeta('valorTotalItem');
  GeneratedColumn<double>? _valorTotalItem;
  @override
  GeneratedColumn<double> get valorTotalItem => _valorTotalItem ??=
      GeneratedColumn<double>('VALOR_TOTAL_ITEM', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorBaseIcmsMeta =
      const VerificationMeta('valorBaseIcms');
  GeneratedColumn<double>? _valorBaseIcms;
  @override
  GeneratedColumn<double> get valorBaseIcms => _valorBaseIcms ??=
      GeneratedColumn<double>('VALOR_BASE_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _taxaIcmsMeta =
      const VerificationMeta('taxaIcms');
  GeneratedColumn<double>? _taxaIcms;
  @override
  GeneratedColumn<double> get taxaIcms => _taxaIcms ??=
      GeneratedColumn<double>('TAXA_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsMeta =
      const VerificationMeta('valorIcms');
  GeneratedColumn<double>? _valorIcms;
  @override
  GeneratedColumn<double> get valorIcms => _valorIcms ??=
      GeneratedColumn<double>('VALOR_ICMS', aliasedName, true,
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
  final VerificationMeta _taxaIssqnMeta =
      const VerificationMeta('taxaIssqn');
  GeneratedColumn<double>? _taxaIssqn;
  @override
  GeneratedColumn<double> get taxaIssqn => _taxaIssqn ??=
      GeneratedColumn<double>('TAXA_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIssqnMeta =
      const VerificationMeta('valorIssqn');
  GeneratedColumn<double>? _valorIssqn;
  @override
  GeneratedColumn<double> get valorIssqn => _valorIssqn ??=
      GeneratedColumn<double>('VALOR_ISSQN', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _taxaPisMeta =
      const VerificationMeta('taxaPis');
  GeneratedColumn<double>? _taxaPis;
  @override
  GeneratedColumn<double> get taxaPis => _taxaPis ??=
      GeneratedColumn<double>('TAXA_PIS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPisMeta =
      const VerificationMeta('valorPis');
  GeneratedColumn<double>? _valorPis;
  @override
  GeneratedColumn<double> get valorPis => _valorPis ??=
      GeneratedColumn<double>('VALOR_PIS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _taxaCofinsMeta =
      const VerificationMeta('taxaCofins');
  GeneratedColumn<double>? _taxaCofins;
  @override
  GeneratedColumn<double> get taxaCofins => _taxaCofins ??=
      GeneratedColumn<double>('TAXA_COFINS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorCofinsMeta =
      const VerificationMeta('valorCofins');
  GeneratedColumn<double>? _valorCofins;
  @override
  GeneratedColumn<double> get valorCofins => _valorCofins ??=
      GeneratedColumn<double>('VALOR_COFINS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _taxaAcrescimoMeta =
      const VerificationMeta('taxaAcrescimo');
  GeneratedColumn<double>? _taxaAcrescimo;
  @override
  GeneratedColumn<double> get taxaAcrescimo => _taxaAcrescimo ??=
      GeneratedColumn<double>('TAXA_ACRESCIMO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorAcrescimoMeta =
      const VerificationMeta('valorAcrescimo');
  GeneratedColumn<double>? _valorAcrescimo;
  @override
  GeneratedColumn<double> get valorAcrescimo => _valorAcrescimo ??=
      GeneratedColumn<double>('VALOR_ACRESCIMO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _totalizadorParcialMeta =
      const VerificationMeta('totalizadorParcial');
  GeneratedColumn<String>? _totalizadorParcial;
  @override
  GeneratedColumn<String> get totalizadorParcial => _totalizadorParcial ??=
      GeneratedColumn<String>('TOTALIZADOR_PARCIAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cstMeta =
      const VerificationMeta('cst');
  GeneratedColumn<String>? _cst;
  @override
  GeneratedColumn<String> get cst => _cst ??=
      GeneratedColumn<String>('CST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _canceladoMeta =
      const VerificationMeta('cancelado');
  GeneratedColumn<String>? _cancelado;
  @override
  GeneratedColumn<String> get cancelado => _cancelado ??=
      GeneratedColumn<String>('CANCELADO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _movimentaEstoqueMeta =
      const VerificationMeta('movimentaEstoque');
  GeneratedColumn<String>? _movimentaEstoque;
  @override
  GeneratedColumn<String> get movimentaEstoque => _movimentaEstoque ??=
      GeneratedColumn<String>('MOVIMENTA_ESTOQUE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ecfIcmsStMeta =
      const VerificationMeta('ecfIcmsSt');
  GeneratedColumn<String>? _ecfIcmsSt;
  @override
  GeneratedColumn<String> get ecfIcmsSt => _ecfIcmsSt ??=
      GeneratedColumn<String>('ECF_ICMS_ST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorImpostoFederalMeta =
      const VerificationMeta('valorImpostoFederal');
  GeneratedColumn<double>? _valorImpostoFederal;
  @override
  GeneratedColumn<double> get valorImpostoFederal => _valorImpostoFederal ??=
      GeneratedColumn<double>('VALOR_IMPOSTO_FEDERAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorImpostoEstadualMeta =
      const VerificationMeta('valorImpostoEstadual');
  GeneratedColumn<double>? _valorImpostoEstadual;
  @override
  GeneratedColumn<double> get valorImpostoEstadual => _valorImpostoEstadual ??=
      GeneratedColumn<double>('VALOR_IMPOSTO_ESTADUAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorImpostoMunicipalMeta =
      const VerificationMeta('valorImpostoMunicipal');
  GeneratedColumn<double>? _valorImpostoMunicipal;
  @override
  GeneratedColumn<double> get valorImpostoMunicipal => _valorImpostoMunicipal ??=
      GeneratedColumn<double>('VALOR_IMPOSTO_MUNICIPAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _hashRegistroMeta =
      const VerificationMeta('hashRegistro');
  GeneratedColumn<String>? _hashRegistro;
  @override
  GeneratedColumn<String> get hashRegistro => _hashRegistro ??=
      GeneratedColumn<String>('HASH_REGISTRO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idProduto,
        idPdvVendaCabecalho,
        cfop,
        gtin,
        ccf,
        coo,
        serieEcf,
        item,
        quantidade,
        valorUnitario,
        valorTotal,
        valorTotalItem,
        valorBaseIcms,
        taxaIcms,
        valorIcms,
        taxaDesconto,
        valorDesconto,
        taxaIssqn,
        valorIssqn,
        taxaPis,
        valorPis,
        taxaCofins,
        valorCofins,
        taxaAcrescimo,
        valorAcrescimo,
        totalizadorParcial,
        cst,
        cancelado,
        movimentaEstoque,
        ecfIcmsSt,
        valorImpostoFederal,
        valorImpostoEstadual,
        valorImpostoMunicipal,
        hashRegistro,
      ];

  @override
  String get aliasedName => _alias ?? 'PDV_VENDA_DETALHE';
  
  @override
  String get actualTableName => 'PDV_VENDA_DETALHE';
  
  @override
  VerificationContext validateIntegrity(Insertable<PdvVendaDetalhe> instance,
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
    if (data.containsKey('ID_PDV_VENDA_CABECALHO')) {
        context.handle(_idPdvVendaCabecalhoMeta,
            idPdvVendaCabecalho.isAcceptableOrUnknown(data['ID_PDV_VENDA_CABECALHO']!, _idPdvVendaCabecalhoMeta));
    }
    if (data.containsKey('CFOP')) {
        context.handle(_cfopMeta,
            cfop.isAcceptableOrUnknown(data['CFOP']!, _cfopMeta));
    }
    if (data.containsKey('GTIN')) {
        context.handle(_gtinMeta,
            gtin.isAcceptableOrUnknown(data['GTIN']!, _gtinMeta));
    }
    if (data.containsKey('CCF')) {
        context.handle(_ccfMeta,
            ccf.isAcceptableOrUnknown(data['CCF']!, _ccfMeta));
    }
    if (data.containsKey('COO')) {
        context.handle(_cooMeta,
            coo.isAcceptableOrUnknown(data['COO']!, _cooMeta));
    }
    if (data.containsKey('SERIE_ECF')) {
        context.handle(_serieEcfMeta,
            serieEcf.isAcceptableOrUnknown(data['SERIE_ECF']!, _serieEcfMeta));
    }
    if (data.containsKey('ITEM')) {
        context.handle(_itemMeta,
            item.isAcceptableOrUnknown(data['ITEM']!, _itemMeta));
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
    if (data.containsKey('VALOR_TOTAL_ITEM')) {
        context.handle(_valorTotalItemMeta,
            valorTotalItem.isAcceptableOrUnknown(data['VALOR_TOTAL_ITEM']!, _valorTotalItemMeta));
    }
    if (data.containsKey('VALOR_BASE_ICMS')) {
        context.handle(_valorBaseIcmsMeta,
            valorBaseIcms.isAcceptableOrUnknown(data['VALOR_BASE_ICMS']!, _valorBaseIcmsMeta));
    }
    if (data.containsKey('TAXA_ICMS')) {
        context.handle(_taxaIcmsMeta,
            taxaIcms.isAcceptableOrUnknown(data['TAXA_ICMS']!, _taxaIcmsMeta));
    }
    if (data.containsKey('VALOR_ICMS')) {
        context.handle(_valorIcmsMeta,
            valorIcms.isAcceptableOrUnknown(data['VALOR_ICMS']!, _valorIcmsMeta));
    }
    if (data.containsKey('TAXA_DESCONTO')) {
        context.handle(_taxaDescontoMeta,
            taxaDesconto.isAcceptableOrUnknown(data['TAXA_DESCONTO']!, _taxaDescontoMeta));
    }
    if (data.containsKey('VALOR_DESCONTO')) {
        context.handle(_valorDescontoMeta,
            valorDesconto.isAcceptableOrUnknown(data['VALOR_DESCONTO']!, _valorDescontoMeta));
    }
    if (data.containsKey('TAXA_ISSQN')) {
        context.handle(_taxaIssqnMeta,
            taxaIssqn.isAcceptableOrUnknown(data['TAXA_ISSQN']!, _taxaIssqnMeta));
    }
    if (data.containsKey('VALOR_ISSQN')) {
        context.handle(_valorIssqnMeta,
            valorIssqn.isAcceptableOrUnknown(data['VALOR_ISSQN']!, _valorIssqnMeta));
    }
    if (data.containsKey('TAXA_PIS')) {
        context.handle(_taxaPisMeta,
            taxaPis.isAcceptableOrUnknown(data['TAXA_PIS']!, _taxaPisMeta));
    }
    if (data.containsKey('VALOR_PIS')) {
        context.handle(_valorPisMeta,
            valorPis.isAcceptableOrUnknown(data['VALOR_PIS']!, _valorPisMeta));
    }
    if (data.containsKey('TAXA_COFINS')) {
        context.handle(_taxaCofinsMeta,
            taxaCofins.isAcceptableOrUnknown(data['TAXA_COFINS']!, _taxaCofinsMeta));
    }
    if (data.containsKey('VALOR_COFINS')) {
        context.handle(_valorCofinsMeta,
            valorCofins.isAcceptableOrUnknown(data['VALOR_COFINS']!, _valorCofinsMeta));
    }
    if (data.containsKey('TAXA_ACRESCIMO')) {
        context.handle(_taxaAcrescimoMeta,
            taxaAcrescimo.isAcceptableOrUnknown(data['TAXA_ACRESCIMO']!, _taxaAcrescimoMeta));
    }
    if (data.containsKey('VALOR_ACRESCIMO')) {
        context.handle(_valorAcrescimoMeta,
            valorAcrescimo.isAcceptableOrUnknown(data['VALOR_ACRESCIMO']!, _valorAcrescimoMeta));
    }
    if (data.containsKey('TOTALIZADOR_PARCIAL')) {
        context.handle(_totalizadorParcialMeta,
            totalizadorParcial.isAcceptableOrUnknown(data['TOTALIZADOR_PARCIAL']!, _totalizadorParcialMeta));
    }
    if (data.containsKey('CST')) {
        context.handle(_cstMeta,
            cst.isAcceptableOrUnknown(data['CST']!, _cstMeta));
    }
    if (data.containsKey('CANCELADO')) {
        context.handle(_canceladoMeta,
            cancelado.isAcceptableOrUnknown(data['CANCELADO']!, _canceladoMeta));
    }
    if (data.containsKey('MOVIMENTA_ESTOQUE')) {
        context.handle(_movimentaEstoqueMeta,
            movimentaEstoque.isAcceptableOrUnknown(data['MOVIMENTA_ESTOQUE']!, _movimentaEstoqueMeta));
    }
    if (data.containsKey('ECF_ICMS_ST')) {
        context.handle(_ecfIcmsStMeta,
            ecfIcmsSt.isAcceptableOrUnknown(data['ECF_ICMS_ST']!, _ecfIcmsStMeta));
    }
    if (data.containsKey('VALOR_IMPOSTO_FEDERAL')) {
        context.handle(_valorImpostoFederalMeta,
            valorImpostoFederal.isAcceptableOrUnknown(data['VALOR_IMPOSTO_FEDERAL']!, _valorImpostoFederalMeta));
    }
    if (data.containsKey('VALOR_IMPOSTO_ESTADUAL')) {
        context.handle(_valorImpostoEstadualMeta,
            valorImpostoEstadual.isAcceptableOrUnknown(data['VALOR_IMPOSTO_ESTADUAL']!, _valorImpostoEstadualMeta));
    }
    if (data.containsKey('VALOR_IMPOSTO_MUNICIPAL')) {
        context.handle(_valorImpostoMunicipalMeta,
            valorImpostoMunicipal.isAcceptableOrUnknown(data['VALOR_IMPOSTO_MUNICIPAL']!, _valorImpostoMunicipalMeta));
    }
    if (data.containsKey('HASH_REGISTRO')) {
        context.handle(_hashRegistroMeta,
            hashRegistro.isAcceptableOrUnknown(data['HASH_REGISTRO']!, _hashRegistroMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdvVendaDetalhe map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PdvVendaDetalhe.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PdvVendaDetalhesTable createAlias(String alias) {
    return $PdvVendaDetalhesTable(_db, alias);
  }
}