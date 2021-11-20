/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE] 
                                                                                
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

@DataClassName("NfeDetalhe")
@UseRowClass(NfeDetalhe)
class NfeDetalhes extends Table {
  @override
  String get tableName => 'NFE_DETALHE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  IntColumn get numeroItem => integer().named('NUMERO_ITEM').nullable()();
  TextColumn get codigoProduto => text().named('CODIGO_PRODUTO').withLength(min: 0, max: 60).nullable()();
  TextColumn get gtin => text().named('GTIN').withLength(min: 0, max: 14).nullable()();
  TextColumn get nomeProduto => text().named('NOME_PRODUTO').withLength(min: 0, max: 120).nullable()();
  TextColumn get ncm => text().named('NCM').withLength(min: 0, max: 8).nullable()();
  TextColumn get nve => text().named('NVE').withLength(min: 0, max: 6).nullable()();
  TextColumn get cest => text().named('CEST').withLength(min: 0, max: 7).nullable()();
  TextColumn get indicadorEscalaRelevante => text().named('INDICADOR_ESCALA_RELEVANTE').withLength(min: 0, max: 1).nullable()();
  TextColumn get cnpjFabricante => text().named('CNPJ_FABRICANTE').withLength(min: 0, max: 14).nullable()();
  TextColumn get codigoBeneficioFiscal => text().named('CODIGO_BENEFICIO_FISCAL').withLength(min: 0, max: 10).nullable()();
  IntColumn get exTipi => integer().named('EX_TIPI').nullable()();
  IntColumn get cfop => integer().named('CFOP').nullable()();
  TextColumn get unidadeComercial => text().named('UNIDADE_COMERCIAL').withLength(min: 0, max: 6).nullable()();
  RealColumn get quantidadeComercial => real().named('QUANTIDADE_COMERCIAL').nullable()();
  TextColumn get numeroPedidoCompra => text().named('NUMERO_PEDIDO_COMPRA').withLength(min: 0, max: 15).nullable()();
  IntColumn get itemPedidoCompra => integer().named('ITEM_PEDIDO_COMPRA').nullable()();
  TextColumn get numeroFci => text().named('NUMERO_FCI').withLength(min: 0, max: 36).nullable()();
  TextColumn get numeroRecopi => text().named('NUMERO_RECOPI').withLength(min: 0, max: 20).nullable()();
  RealColumn get valorUnitarioComercial => real().named('VALOR_UNITARIO_COMERCIAL').nullable()();
  RealColumn get valorBrutoProduto => real().named('VALOR_BRUTO_PRODUTO').nullable()();
  TextColumn get gtinUnidadeTributavel => text().named('GTIN_UNIDADE_TRIBUTAVEL').withLength(min: 0, max: 14).nullable()();
  TextColumn get unidadeTributavel => text().named('UNIDADE_TRIBUTAVEL').withLength(min: 0, max: 6).nullable()();
  RealColumn get quantidadeTributavel => real().named('QUANTIDADE_TRIBUTAVEL').nullable()();
  RealColumn get valorUnitarioTributavel => real().named('VALOR_UNITARIO_TRIBUTAVEL').nullable()();
  RealColumn get valorFrete => real().named('VALOR_FRETE').nullable()();
  RealColumn get valorSeguro => real().named('VALOR_SEGURO').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get valorOutrasDespesas => real().named('VALOR_OUTRAS_DESPESAS').nullable()();
  TextColumn get entraTotal => text().named('ENTRA_TOTAL').withLength(min: 0, max: 1).nullable()();
  RealColumn get valorTotalTributos => real().named('VALOR_TOTAL_TRIBUTOS').nullable()();
  RealColumn get percentualDevolvido => real().named('PERCENTUAL_DEVOLVIDO').nullable()();
  RealColumn get valorIpiDevolvido => real().named('VALOR_IPI_DEVOLVIDO').nullable()();
  TextColumn get informacoesAdicionais => text().named('INFORMACOES_ADICIONAIS').withLength(min: 0, max: 250).nullable()();
  RealColumn get valorSubtotal => real().named('VALOR_SUBTOTAL').nullable()();
  RealColumn get valorTotal => real().named('VALOR_TOTAL').nullable()();
}

class NfeDetalheMontado {
  NfeDetalhe? nfeDetalhe;
  NfeDetalheImpostoIcms? nfeDetalheImpostoIcms;
  NfeDetalheImpostoPis? nfeDetalheImpostoPis;
  NfeDetalheImpostoCofins? nfeDetalheImpostoCofins;

  NfeDetalheMontado({
    this.nfeDetalhe,
    this.nfeDetalheImpostoIcms,
    this.nfeDetalheImpostoPis,
    this.nfeDetalheImpostoCofins,
  });
}

class NfeDetalhe extends DataClass implements Insertable<NfeDetalhe> {
  final int? id;
  final int? idNfeCabecalho;
  final int? numeroItem;
  final String? codigoProduto;
  final String? gtin;
  final String? nomeProduto;
  final String? ncm;
  final String? nve;
  final String? cest;
  final String? indicadorEscalaRelevante;
  final String? cnpjFabricante;
  final String? codigoBeneficioFiscal;
  final int? exTipi;
  final int? cfop;
  final String? unidadeComercial;
  final double? quantidadeComercial;
  final String? numeroPedidoCompra;
  final int? itemPedidoCompra;
  final String? numeroFci;
  final String? numeroRecopi;
  final double? valorUnitarioComercial;
  final double? valorBrutoProduto;
  final String? gtinUnidadeTributavel;
  final String? unidadeTributavel;
  final double? quantidadeTributavel;
  final double? valorUnitarioTributavel;
  final double? valorFrete;
  final double? valorSeguro;
  final double? valorDesconto;
  final double? valorOutrasDespesas;
  final String? entraTotal;
  final double? valorTotalTributos;
  final double? percentualDevolvido;
  final double? valorIpiDevolvido;
  final String? informacoesAdicionais;
  final double? valorSubtotal;
  final double? valorTotal;

  NfeDetalhe(
    {
      required this.id,
      this.idNfeCabecalho,
      this.numeroItem,
      this.codigoProduto,
      this.gtin,
      this.nomeProduto,
      this.ncm,
      this.nve,
      this.cest,
      this.indicadorEscalaRelevante,
      this.cnpjFabricante,
      this.codigoBeneficioFiscal,
      this.exTipi,
      this.cfop,
      this.unidadeComercial,
      this.quantidadeComercial,
      this.numeroPedidoCompra,
      this.itemPedidoCompra,
      this.numeroFci,
      this.numeroRecopi,
      this.valorUnitarioComercial,
      this.valorBrutoProduto,
      this.gtinUnidadeTributavel,
      this.unidadeTributavel,
      this.quantidadeTributavel,
      this.valorUnitarioTributavel,
      this.valorFrete,
      this.valorSeguro,
      this.valorDesconto,
      this.valorOutrasDespesas,
      this.entraTotal,
      this.valorTotalTributos,
      this.percentualDevolvido,
      this.valorIpiDevolvido,
      this.informacoesAdicionais,
      this.valorSubtotal,
      this.valorTotal,
    }
  );

  factory NfeDetalhe.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetalhe(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      numeroItem: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_ITEM']),
      codigoProduto: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_PRODUTO']),
      gtin: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}GTIN']),
      nomeProduto: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME_PRODUTO']),
      ncm: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NCM']),
      nve: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NVE']),
      cest: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CEST']),
      indicadorEscalaRelevante: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}INDICADOR_ESCALA_RELEVANTE']),
      cnpjFabricante: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CNPJ_FABRICANTE']),
      codigoBeneficioFiscal: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_BENEFICIO_FISCAL']),
      exTipi: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}EX_TIPI']),
      cfop: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CFOP']),
      unidadeComercial: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UNIDADE_COMERCIAL']),
      quantidadeComercial: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_COMERCIAL']),
      numeroPedidoCompra: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_PEDIDO_COMPRA']),
      itemPedidoCompra: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ITEM_PEDIDO_COMPRA']),
      numeroFci: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_FCI']),
      numeroRecopi: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_RECOPI']),
      valorUnitarioComercial: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_UNITARIO_COMERCIAL']),
      valorBrutoProduto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BRUTO_PRODUTO']),
      gtinUnidadeTributavel: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}GTIN_UNIDADE_TRIBUTAVEL']),
      unidadeTributavel: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UNIDADE_TRIBUTAVEL']),
      quantidadeTributavel: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_TRIBUTAVEL']),
      valorUnitarioTributavel: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_UNITARIO_TRIBUTAVEL']),
      valorFrete: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_FRETE']),
      valorSeguro: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_SEGURO']),
      valorDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DESCONTO']),
      valorOutrasDespesas: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_OUTRAS_DESPESAS']),
      entraTotal: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ENTRA_TOTAL']),
      valorTotalTributos: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL_TRIBUTOS']),
      percentualDevolvido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_DEVOLVIDO']),
      valorIpiDevolvido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IPI_DEVOLVIDO']),
      informacoesAdicionais: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}INFORMACOES_ADICIONAIS']),
      valorSubtotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_SUBTOTAL']),
      valorTotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeCabecalho != null) {
      map['ID_NFE_CABECALHO'] = Variable<int?>(idNfeCabecalho);
    }
    if (!nullToAbsent || numeroItem != null) {
      map['NUMERO_ITEM'] = Variable<int?>(numeroItem);
    }
    if (!nullToAbsent || codigoProduto != null) {
      map['CODIGO_PRODUTO'] = Variable<String?>(codigoProduto);
    }
    if (!nullToAbsent || gtin != null) {
      map['GTIN'] = Variable<String?>(gtin);
    }
    if (!nullToAbsent || nomeProduto != null) {
      map['NOME_PRODUTO'] = Variable<String?>(nomeProduto);
    }
    if (!nullToAbsent || ncm != null) {
      map['NCM'] = Variable<String?>(ncm);
    }
    if (!nullToAbsent || nve != null) {
      map['NVE'] = Variable<String?>(nve);
    }
    if (!nullToAbsent || cest != null) {
      map['CEST'] = Variable<String?>(cest);
    }
    if (!nullToAbsent || indicadorEscalaRelevante != null) {
      map['INDICADOR_ESCALA_RELEVANTE'] = Variable<String?>(indicadorEscalaRelevante);
    }
    if (!nullToAbsent || cnpjFabricante != null) {
      map['CNPJ_FABRICANTE'] = Variable<String?>(cnpjFabricante);
    }
    if (!nullToAbsent || codigoBeneficioFiscal != null) {
      map['CODIGO_BENEFICIO_FISCAL'] = Variable<String?>(codigoBeneficioFiscal);
    }
    if (!nullToAbsent || exTipi != null) {
      map['EX_TIPI'] = Variable<int?>(exTipi);
    }
    if (!nullToAbsent || cfop != null) {
      map['CFOP'] = Variable<int?>(cfop);
    }
    if (!nullToAbsent || unidadeComercial != null) {
      map['UNIDADE_COMERCIAL'] = Variable<String?>(unidadeComercial);
    }
    if (!nullToAbsent || quantidadeComercial != null) {
      map['QUANTIDADE_COMERCIAL'] = Variable<double?>(quantidadeComercial);
    }
    if (!nullToAbsent || numeroPedidoCompra != null) {
      map['NUMERO_PEDIDO_COMPRA'] = Variable<String?>(numeroPedidoCompra);
    }
    if (!nullToAbsent || itemPedidoCompra != null) {
      map['ITEM_PEDIDO_COMPRA'] = Variable<int?>(itemPedidoCompra);
    }
    if (!nullToAbsent || numeroFci != null) {
      map['NUMERO_FCI'] = Variable<String?>(numeroFci);
    }
    if (!nullToAbsent || numeroRecopi != null) {
      map['NUMERO_RECOPI'] = Variable<String?>(numeroRecopi);
    }
    if (!nullToAbsent || valorUnitarioComercial != null) {
      map['VALOR_UNITARIO_COMERCIAL'] = Variable<double?>(valorUnitarioComercial);
    }
    if (!nullToAbsent || valorBrutoProduto != null) {
      map['VALOR_BRUTO_PRODUTO'] = Variable<double?>(valorBrutoProduto);
    }
    if (!nullToAbsent || gtinUnidadeTributavel != null) {
      map['GTIN_UNIDADE_TRIBUTAVEL'] = Variable<String?>(gtinUnidadeTributavel);
    }
    if (!nullToAbsent || unidadeTributavel != null) {
      map['UNIDADE_TRIBUTAVEL'] = Variable<String?>(unidadeTributavel);
    }
    if (!nullToAbsent || quantidadeTributavel != null) {
      map['QUANTIDADE_TRIBUTAVEL'] = Variable<double?>(quantidadeTributavel);
    }
    if (!nullToAbsent || valorUnitarioTributavel != null) {
      map['VALOR_UNITARIO_TRIBUTAVEL'] = Variable<double?>(valorUnitarioTributavel);
    }
    if (!nullToAbsent || valorFrete != null) {
      map['VALOR_FRETE'] = Variable<double?>(valorFrete);
    }
    if (!nullToAbsent || valorSeguro != null) {
      map['VALOR_SEGURO'] = Variable<double?>(valorSeguro);
    }
    if (!nullToAbsent || valorDesconto != null) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto);
    }
    if (!nullToAbsent || valorOutrasDespesas != null) {
      map['VALOR_OUTRAS_DESPESAS'] = Variable<double?>(valorOutrasDespesas);
    }
    if (!nullToAbsent || entraTotal != null) {
      map['ENTRA_TOTAL'] = Variable<String?>(entraTotal);
    }
    if (!nullToAbsent || valorTotalTributos != null) {
      map['VALOR_TOTAL_TRIBUTOS'] = Variable<double?>(valorTotalTributos);
    }
    if (!nullToAbsent || percentualDevolvido != null) {
      map['PERCENTUAL_DEVOLVIDO'] = Variable<double?>(percentualDevolvido);
    }
    if (!nullToAbsent || valorIpiDevolvido != null) {
      map['VALOR_IPI_DEVOLVIDO'] = Variable<double?>(valorIpiDevolvido);
    }
    if (!nullToAbsent || informacoesAdicionais != null) {
      map['INFORMACOES_ADICIONAIS'] = Variable<String?>(informacoesAdicionais);
    }
    if (!nullToAbsent || valorSubtotal != null) {
      map['VALOR_SUBTOTAL'] = Variable<double?>(valorSubtotal);
    }
    if (!nullToAbsent || valorTotal != null) {
      map['VALOR_TOTAL'] = Variable<double?>(valorTotal);
    }
    return map;
  }

  NfeDetalhesCompanion toCompanion(bool nullToAbsent) {
    return NfeDetalhesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      numeroItem: numeroItem == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroItem),
      codigoProduto: codigoProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoProduto),
      gtin: gtin == null && nullToAbsent
        ? const Value.absent()
        : Value(gtin),
      nomeProduto: nomeProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(nomeProduto),
      ncm: ncm == null && nullToAbsent
        ? const Value.absent()
        : Value(ncm),
      nve: nve == null && nullToAbsent
        ? const Value.absent()
        : Value(nve),
      cest: cest == null && nullToAbsent
        ? const Value.absent()
        : Value(cest),
      indicadorEscalaRelevante: indicadorEscalaRelevante == null && nullToAbsent
        ? const Value.absent()
        : Value(indicadorEscalaRelevante),
      cnpjFabricante: cnpjFabricante == null && nullToAbsent
        ? const Value.absent()
        : Value(cnpjFabricante),
      codigoBeneficioFiscal: codigoBeneficioFiscal == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoBeneficioFiscal),
      exTipi: exTipi == null && nullToAbsent
        ? const Value.absent()
        : Value(exTipi),
      cfop: cfop == null && nullToAbsent
        ? const Value.absent()
        : Value(cfop),
      unidadeComercial: unidadeComercial == null && nullToAbsent
        ? const Value.absent()
        : Value(unidadeComercial),
      quantidadeComercial: quantidadeComercial == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeComercial),
      numeroPedidoCompra: numeroPedidoCompra == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroPedidoCompra),
      itemPedidoCompra: itemPedidoCompra == null && nullToAbsent
        ? const Value.absent()
        : Value(itemPedidoCompra),
      numeroFci: numeroFci == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroFci),
      numeroRecopi: numeroRecopi == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroRecopi),
      valorUnitarioComercial: valorUnitarioComercial == null && nullToAbsent
        ? const Value.absent()
        : Value(valorUnitarioComercial),
      valorBrutoProduto: valorBrutoProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBrutoProduto),
      gtinUnidadeTributavel: gtinUnidadeTributavel == null && nullToAbsent
        ? const Value.absent()
        : Value(gtinUnidadeTributavel),
      unidadeTributavel: unidadeTributavel == null && nullToAbsent
        ? const Value.absent()
        : Value(unidadeTributavel),
      quantidadeTributavel: quantidadeTributavel == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeTributavel),
      valorUnitarioTributavel: valorUnitarioTributavel == null && nullToAbsent
        ? const Value.absent()
        : Value(valorUnitarioTributavel),
      valorFrete: valorFrete == null && nullToAbsent
        ? const Value.absent()
        : Value(valorFrete),
      valorSeguro: valorSeguro == null && nullToAbsent
        ? const Value.absent()
        : Value(valorSeguro),
      valorDesconto: valorDesconto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDesconto),
      valorOutrasDespesas: valorOutrasDespesas == null && nullToAbsent
        ? const Value.absent()
        : Value(valorOutrasDespesas),
      entraTotal: entraTotal == null && nullToAbsent
        ? const Value.absent()
        : Value(entraTotal),
      valorTotalTributos: valorTotalTributos == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotalTributos),
      percentualDevolvido: percentualDevolvido == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualDevolvido),
      valorIpiDevolvido: valorIpiDevolvido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIpiDevolvido),
      informacoesAdicionais: informacoesAdicionais == null && nullToAbsent
        ? const Value.absent()
        : Value(informacoesAdicionais),
      valorSubtotal: valorSubtotal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorSubtotal),
      valorTotal: valorTotal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotal),
    );
  }

  factory NfeDetalhe.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetalhe(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      numeroItem: serializer.fromJson<int>(json['numeroItem']),
      codigoProduto: serializer.fromJson<String>(json['codigoProduto']),
      gtin: serializer.fromJson<String>(json['gtin']),
      nomeProduto: serializer.fromJson<String>(json['nomeProduto']),
      ncm: serializer.fromJson<String>(json['ncm']),
      nve: serializer.fromJson<String>(json['nve']),
      cest: serializer.fromJson<String>(json['cest']),
      indicadorEscalaRelevante: serializer.fromJson<String>(json['indicadorEscalaRelevante']),
      cnpjFabricante: serializer.fromJson<String>(json['cnpjFabricante']),
      codigoBeneficioFiscal: serializer.fromJson<String>(json['codigoBeneficioFiscal']),
      exTipi: serializer.fromJson<int>(json['exTipi']),
      cfop: serializer.fromJson<int>(json['cfop']),
      unidadeComercial: serializer.fromJson<String>(json['unidadeComercial']),
      quantidadeComercial: serializer.fromJson<double>(json['quantidadeComercial']),
      numeroPedidoCompra: serializer.fromJson<String>(json['numeroPedidoCompra']),
      itemPedidoCompra: serializer.fromJson<int>(json['itemPedidoCompra']),
      numeroFci: serializer.fromJson<String>(json['numeroFci']),
      numeroRecopi: serializer.fromJson<String>(json['numeroRecopi']),
      valorUnitarioComercial: serializer.fromJson<double>(json['valorUnitarioComercial']),
      valorBrutoProduto: serializer.fromJson<double>(json['valorBrutoProduto']),
      gtinUnidadeTributavel: serializer.fromJson<String>(json['gtinUnidadeTributavel']),
      unidadeTributavel: serializer.fromJson<String>(json['unidadeTributavel']),
      quantidadeTributavel: serializer.fromJson<double>(json['quantidadeTributavel']),
      valorUnitarioTributavel: serializer.fromJson<double>(json['valorUnitarioTributavel']),
      valorFrete: serializer.fromJson<double>(json['valorFrete']),
      valorSeguro: serializer.fromJson<double>(json['valorSeguro']),
      valorDesconto: serializer.fromJson<double>(json['valorDesconto']),
      valorOutrasDespesas: serializer.fromJson<double>(json['valorOutrasDespesas']),
      entraTotal: serializer.fromJson<String>(json['entraTotal']),
      valorTotalTributos: serializer.fromJson<double>(json['valorTotalTributos']),
      percentualDevolvido: serializer.fromJson<double>(json['percentualDevolvido']),
      valorIpiDevolvido: serializer.fromJson<double>(json['valorIpiDevolvido']),
      informacoesAdicionais: serializer.fromJson<String>(json['informacoesAdicionais']),
      valorSubtotal: serializer.fromJson<double>(json['valorSubtotal']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'numeroItem': serializer.toJson<int?>(numeroItem),
      'codigoProduto': serializer.toJson<String?>(codigoProduto),
      'gtin': serializer.toJson<String?>(gtin),
      'nomeProduto': serializer.toJson<String?>(nomeProduto),
      'ncm': serializer.toJson<String?>(ncm),
      'nve': serializer.toJson<String?>(nve),
      'cest': serializer.toJson<String?>(cest),
      'indicadorEscalaRelevante': serializer.toJson<String?>(indicadorEscalaRelevante),
      'cnpjFabricante': serializer.toJson<String?>(cnpjFabricante),
      'codigoBeneficioFiscal': serializer.toJson<String?>(codigoBeneficioFiscal),
      'exTipi': serializer.toJson<int?>(exTipi),
      'cfop': serializer.toJson<int?>(cfop),
      'unidadeComercial': serializer.toJson<String?>(unidadeComercial),
      'quantidadeComercial': serializer.toJson<double?>(quantidadeComercial),
      'numeroPedidoCompra': serializer.toJson<String?>(numeroPedidoCompra),
      'itemPedidoCompra': serializer.toJson<int?>(itemPedidoCompra),
      'numeroFci': serializer.toJson<String?>(numeroFci),
      'numeroRecopi': serializer.toJson<String?>(numeroRecopi),
      'valorUnitarioComercial': serializer.toJson<double?>(valorUnitarioComercial),
      'valorBrutoProduto': serializer.toJson<double?>(valorBrutoProduto),
      'gtinUnidadeTributavel': serializer.toJson<String?>(gtinUnidadeTributavel),
      'unidadeTributavel': serializer.toJson<String?>(unidadeTributavel),
      'quantidadeTributavel': serializer.toJson<double?>(quantidadeTributavel),
      'valorUnitarioTributavel': serializer.toJson<double?>(valorUnitarioTributavel),
      'valorFrete': serializer.toJson<double?>(valorFrete),
      'valorSeguro': serializer.toJson<double?>(valorSeguro),
      'valorDesconto': serializer.toJson<double?>(valorDesconto),
      'valorOutrasDespesas': serializer.toJson<double?>(valorOutrasDespesas),
      'entraTotal': serializer.toJson<String?>(entraTotal),
      'valorTotalTributos': serializer.toJson<double?>(valorTotalTributos),
      'percentualDevolvido': serializer.toJson<double?>(percentualDevolvido),
      'valorIpiDevolvido': serializer.toJson<double?>(valorIpiDevolvido),
      'informacoesAdicionais': serializer.toJson<String?>(informacoesAdicionais),
      'valorSubtotal': serializer.toJson<double?>(valorSubtotal),
      'valorTotal': serializer.toJson<double?>(valorTotal),
    };
  }

  NfeDetalhe copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          int? numeroItem,
          String? codigoProduto,
          String? gtin,
          String? nomeProduto,
          String? ncm,
          String? nve,
          String? cest,
          String? indicadorEscalaRelevante,
          String? cnpjFabricante,
          String? codigoBeneficioFiscal,
          int? exTipi,
          int? cfop,
          String? unidadeComercial,
          double? quantidadeComercial,
          String? numeroPedidoCompra,
          int? itemPedidoCompra,
          String? numeroFci,
          String? numeroRecopi,
          double? valorUnitarioComercial,
          double? valorBrutoProduto,
          String? gtinUnidadeTributavel,
          String? unidadeTributavel,
          double? quantidadeTributavel,
          double? valorUnitarioTributavel,
          double? valorFrete,
          double? valorSeguro,
          double? valorDesconto,
          double? valorOutrasDespesas,
          String? entraTotal,
          double? valorTotalTributos,
          double? percentualDevolvido,
          double? valorIpiDevolvido,
          String? informacoesAdicionais,
          double? valorSubtotal,
          double? valorTotal,
		}) =>
      NfeDetalhe(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        numeroItem: numeroItem ?? this.numeroItem,
        codigoProduto: codigoProduto ?? this.codigoProduto,
        gtin: gtin ?? this.gtin,
        nomeProduto: nomeProduto ?? this.nomeProduto,
        ncm: ncm ?? this.ncm,
        nve: nve ?? this.nve,
        cest: cest ?? this.cest,
        indicadorEscalaRelevante: indicadorEscalaRelevante ?? this.indicadorEscalaRelevante,
        cnpjFabricante: cnpjFabricante ?? this.cnpjFabricante,
        codigoBeneficioFiscal: codigoBeneficioFiscal ?? this.codigoBeneficioFiscal,
        exTipi: exTipi ?? this.exTipi,
        cfop: cfop ?? this.cfop,
        unidadeComercial: unidadeComercial ?? this.unidadeComercial,
        quantidadeComercial: quantidadeComercial ?? this.quantidadeComercial,
        numeroPedidoCompra: numeroPedidoCompra ?? this.numeroPedidoCompra,
        itemPedidoCompra: itemPedidoCompra ?? this.itemPedidoCompra,
        numeroFci: numeroFci ?? this.numeroFci,
        numeroRecopi: numeroRecopi ?? this.numeroRecopi,
        valorUnitarioComercial: valorUnitarioComercial ?? this.valorUnitarioComercial,
        valorBrutoProduto: valorBrutoProduto ?? this.valorBrutoProduto,
        gtinUnidadeTributavel: gtinUnidadeTributavel ?? this.gtinUnidadeTributavel,
        unidadeTributavel: unidadeTributavel ?? this.unidadeTributavel,
        quantidadeTributavel: quantidadeTributavel ?? this.quantidadeTributavel,
        valorUnitarioTributavel: valorUnitarioTributavel ?? this.valorUnitarioTributavel,
        valorFrete: valorFrete ?? this.valorFrete,
        valorSeguro: valorSeguro ?? this.valorSeguro,
        valorDesconto: valorDesconto ?? this.valorDesconto,
        valorOutrasDespesas: valorOutrasDespesas ?? this.valorOutrasDespesas,
        entraTotal: entraTotal ?? this.entraTotal,
        valorTotalTributos: valorTotalTributos ?? this.valorTotalTributos,
        percentualDevolvido: percentualDevolvido ?? this.percentualDevolvido,
        valorIpiDevolvido: valorIpiDevolvido ?? this.valorIpiDevolvido,
        informacoesAdicionais: informacoesAdicionais ?? this.informacoesAdicionais,
        valorSubtotal: valorSubtotal ?? this.valorSubtotal,
        valorTotal: valorTotal ?? this.valorTotal,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetalhe(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('numeroItem: $numeroItem, ')
          ..write('codigoProduto: $codigoProduto, ')
          ..write('gtin: $gtin, ')
          ..write('nomeProduto: $nomeProduto, ')
          ..write('ncm: $ncm, ')
          ..write('nve: $nve, ')
          ..write('cest: $cest, ')
          ..write('indicadorEscalaRelevante: $indicadorEscalaRelevante, ')
          ..write('cnpjFabricante: $cnpjFabricante, ')
          ..write('codigoBeneficioFiscal: $codigoBeneficioFiscal, ')
          ..write('exTipi: $exTipi, ')
          ..write('cfop: $cfop, ')
          ..write('unidadeComercial: $unidadeComercial, ')
          ..write('quantidadeComercial: $quantidadeComercial, ')
          ..write('numeroPedidoCompra: $numeroPedidoCompra, ')
          ..write('itemPedidoCompra: $itemPedidoCompra, ')
          ..write('numeroFci: $numeroFci, ')
          ..write('numeroRecopi: $numeroRecopi, ')
          ..write('valorUnitarioComercial: $valorUnitarioComercial, ')
          ..write('valorBrutoProduto: $valorBrutoProduto, ')
          ..write('gtinUnidadeTributavel: $gtinUnidadeTributavel, ')
          ..write('unidadeTributavel: $unidadeTributavel, ')
          ..write('quantidadeTributavel: $quantidadeTributavel, ')
          ..write('valorUnitarioTributavel: $valorUnitarioTributavel, ')
          ..write('valorFrete: $valorFrete, ')
          ..write('valorSeguro: $valorSeguro, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorOutrasDespesas: $valorOutrasDespesas, ')
          ..write('entraTotal: $entraTotal, ')
          ..write('valorTotalTributos: $valorTotalTributos, ')
          ..write('percentualDevolvido: $percentualDevolvido, ')
          ..write('valorIpiDevolvido: $valorIpiDevolvido, ')
          ..write('informacoesAdicionais: $informacoesAdicionais, ')
          ..write('valorSubtotal: $valorSubtotal, ')
          ..write('valorTotal: $valorTotal, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      numeroItem,
      codigoProduto,
      gtin,
      nomeProduto,
      ncm,
      nve,
      cest,
      indicadorEscalaRelevante,
      cnpjFabricante,
      codigoBeneficioFiscal,
      exTipi,
      cfop,
      unidadeComercial,
      quantidadeComercial,
      numeroPedidoCompra,
      itemPedidoCompra,
      numeroFci,
      numeroRecopi,
      valorUnitarioComercial,
      valorBrutoProduto,
      gtinUnidadeTributavel,
      unidadeTributavel,
      quantidadeTributavel,
      valorUnitarioTributavel,
      valorFrete,
      valorSeguro,
      valorDesconto,
      valorOutrasDespesas,
      entraTotal,
      valorTotalTributos,
      percentualDevolvido,
      valorIpiDevolvido,
      informacoesAdicionais,
      valorSubtotal,
      valorTotal,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetalhe &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.numeroItem == numeroItem &&
          other.codigoProduto == codigoProduto &&
          other.gtin == gtin &&
          other.nomeProduto == nomeProduto &&
          other.ncm == ncm &&
          other.nve == nve &&
          other.cest == cest &&
          other.indicadorEscalaRelevante == indicadorEscalaRelevante &&
          other.cnpjFabricante == cnpjFabricante &&
          other.codigoBeneficioFiscal == codigoBeneficioFiscal &&
          other.exTipi == exTipi &&
          other.cfop == cfop &&
          other.unidadeComercial == unidadeComercial &&
          other.quantidadeComercial == quantidadeComercial &&
          other.numeroPedidoCompra == numeroPedidoCompra &&
          other.itemPedidoCompra == itemPedidoCompra &&
          other.numeroFci == numeroFci &&
          other.numeroRecopi == numeroRecopi &&
          other.valorUnitarioComercial == valorUnitarioComercial &&
          other.valorBrutoProduto == valorBrutoProduto &&
          other.gtinUnidadeTributavel == gtinUnidadeTributavel &&
          other.unidadeTributavel == unidadeTributavel &&
          other.quantidadeTributavel == quantidadeTributavel &&
          other.valorUnitarioTributavel == valorUnitarioTributavel &&
          other.valorFrete == valorFrete &&
          other.valorSeguro == valorSeguro &&
          other.valorDesconto == valorDesconto &&
          other.valorOutrasDespesas == valorOutrasDespesas &&
          other.entraTotal == entraTotal &&
          other.valorTotalTributos == valorTotalTributos &&
          other.percentualDevolvido == percentualDevolvido &&
          other.valorIpiDevolvido == valorIpiDevolvido &&
          other.informacoesAdicionais == informacoesAdicionais &&
          other.valorSubtotal == valorSubtotal &&
          other.valorTotal == valorTotal 
	   );
}

class NfeDetalhesCompanion extends UpdateCompanion<NfeDetalhe> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<int?> numeroItem;
  final Value<String?> codigoProduto;
  final Value<String?> gtin;
  final Value<String?> nomeProduto;
  final Value<String?> ncm;
  final Value<String?> nve;
  final Value<String?> cest;
  final Value<String?> indicadorEscalaRelevante;
  final Value<String?> cnpjFabricante;
  final Value<String?> codigoBeneficioFiscal;
  final Value<int?> exTipi;
  final Value<int?> cfop;
  final Value<String?> unidadeComercial;
  final Value<double?> quantidadeComercial;
  final Value<String?> numeroPedidoCompra;
  final Value<int?> itemPedidoCompra;
  final Value<String?> numeroFci;
  final Value<String?> numeroRecopi;
  final Value<double?> valorUnitarioComercial;
  final Value<double?> valorBrutoProduto;
  final Value<String?> gtinUnidadeTributavel;
  final Value<String?> unidadeTributavel;
  final Value<double?> quantidadeTributavel;
  final Value<double?> valorUnitarioTributavel;
  final Value<double?> valorFrete;
  final Value<double?> valorSeguro;
  final Value<double?> valorDesconto;
  final Value<double?> valorOutrasDespesas;
  final Value<String?> entraTotal;
  final Value<double?> valorTotalTributos;
  final Value<double?> percentualDevolvido;
  final Value<double?> valorIpiDevolvido;
  final Value<String?> informacoesAdicionais;
  final Value<double?> valorSubtotal;
  final Value<double?> valorTotal;

  const NfeDetalhesCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.numeroItem = const Value.absent(),
    this.codigoProduto = const Value.absent(),
    this.gtin = const Value.absent(),
    this.nomeProduto = const Value.absent(),
    this.ncm = const Value.absent(),
    this.nve = const Value.absent(),
    this.cest = const Value.absent(),
    this.indicadorEscalaRelevante = const Value.absent(),
    this.cnpjFabricante = const Value.absent(),
    this.codigoBeneficioFiscal = const Value.absent(),
    this.exTipi = const Value.absent(),
    this.cfop = const Value.absent(),
    this.unidadeComercial = const Value.absent(),
    this.quantidadeComercial = const Value.absent(),
    this.numeroPedidoCompra = const Value.absent(),
    this.itemPedidoCompra = const Value.absent(),
    this.numeroFci = const Value.absent(),
    this.numeroRecopi = const Value.absent(),
    this.valorUnitarioComercial = const Value.absent(),
    this.valorBrutoProduto = const Value.absent(),
    this.gtinUnidadeTributavel = const Value.absent(),
    this.unidadeTributavel = const Value.absent(),
    this.quantidadeTributavel = const Value.absent(),
    this.valorUnitarioTributavel = const Value.absent(),
    this.valorFrete = const Value.absent(),
    this.valorSeguro = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorOutrasDespesas = const Value.absent(),
    this.entraTotal = const Value.absent(),
    this.valorTotalTributos = const Value.absent(),
    this.percentualDevolvido = const Value.absent(),
    this.valorIpiDevolvido = const Value.absent(),
    this.informacoesAdicionais = const Value.absent(),
    this.valorSubtotal = const Value.absent(),
    this.valorTotal = const Value.absent(),
  });

  NfeDetalhesCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.numeroItem = const Value.absent(),
    this.codigoProduto = const Value.absent(),
    this.gtin = const Value.absent(),
    this.nomeProduto = const Value.absent(),
    this.ncm = const Value.absent(),
    this.nve = const Value.absent(),
    this.cest = const Value.absent(),
    this.indicadorEscalaRelevante = const Value.absent(),
    this.cnpjFabricante = const Value.absent(),
    this.codigoBeneficioFiscal = const Value.absent(),
    this.exTipi = const Value.absent(),
    this.cfop = const Value.absent(),
    this.unidadeComercial = const Value.absent(),
    this.quantidadeComercial = const Value.absent(),
    this.numeroPedidoCompra = const Value.absent(),
    this.itemPedidoCompra = const Value.absent(),
    this.numeroFci = const Value.absent(),
    this.numeroRecopi = const Value.absent(),
    this.valorUnitarioComercial = const Value.absent(),
    this.valorBrutoProduto = const Value.absent(),
    this.gtinUnidadeTributavel = const Value.absent(),
    this.unidadeTributavel = const Value.absent(),
    this.quantidadeTributavel = const Value.absent(),
    this.valorUnitarioTributavel = const Value.absent(),
    this.valorFrete = const Value.absent(),
    this.valorSeguro = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorOutrasDespesas = const Value.absent(),
    this.entraTotal = const Value.absent(),
    this.valorTotalTributos = const Value.absent(),
    this.percentualDevolvido = const Value.absent(),
    this.valorIpiDevolvido = const Value.absent(),
    this.informacoesAdicionais = const Value.absent(),
    this.valorSubtotal = const Value.absent(),
    this.valorTotal = const Value.absent(),
  });

  static Insertable<NfeDetalhe> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<int>? numeroItem,
    Expression<String>? codigoProduto,
    Expression<String>? gtin,
    Expression<String>? nomeProduto,
    Expression<String>? ncm,
    Expression<String>? nve,
    Expression<String>? cest,
    Expression<String>? indicadorEscalaRelevante,
    Expression<String>? cnpjFabricante,
    Expression<String>? codigoBeneficioFiscal,
    Expression<int>? exTipi,
    Expression<int>? cfop,
    Expression<String>? unidadeComercial,
    Expression<double>? quantidadeComercial,
    Expression<String>? numeroPedidoCompra,
    Expression<int>? itemPedidoCompra,
    Expression<String>? numeroFci,
    Expression<String>? numeroRecopi,
    Expression<double>? valorUnitarioComercial,
    Expression<double>? valorBrutoProduto,
    Expression<String>? gtinUnidadeTributavel,
    Expression<String>? unidadeTributavel,
    Expression<double>? quantidadeTributavel,
    Expression<double>? valorUnitarioTributavel,
    Expression<double>? valorFrete,
    Expression<double>? valorSeguro,
    Expression<double>? valorDesconto,
    Expression<double>? valorOutrasDespesas,
    Expression<String>? entraTotal,
    Expression<double>? valorTotalTributos,
    Expression<double>? percentualDevolvido,
    Expression<double>? valorIpiDevolvido,
    Expression<String>? informacoesAdicionais,
    Expression<double>? valorSubtotal,
    Expression<double>? valorTotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (numeroItem != null) 'NUMERO_ITEM': numeroItem,
      if (codigoProduto != null) 'CODIGO_PRODUTO': codigoProduto,
      if (gtin != null) 'GTIN': gtin,
      if (nomeProduto != null) 'NOME_PRODUTO': nomeProduto,
      if (ncm != null) 'NCM': ncm,
      if (nve != null) 'NVE': nve,
      if (cest != null) 'CEST': cest,
      if (indicadorEscalaRelevante != null) 'INDICADOR_ESCALA_RELEVANTE': indicadorEscalaRelevante,
      if (cnpjFabricante != null) 'CNPJ_FABRICANTE': cnpjFabricante,
      if (codigoBeneficioFiscal != null) 'CODIGO_BENEFICIO_FISCAL': codigoBeneficioFiscal,
      if (exTipi != null) 'EX_TIPI': exTipi,
      if (cfop != null) 'CFOP': cfop,
      if (unidadeComercial != null) 'UNIDADE_COMERCIAL': unidadeComercial,
      if (quantidadeComercial != null) 'QUANTIDADE_COMERCIAL': quantidadeComercial,
      if (numeroPedidoCompra != null) 'NUMERO_PEDIDO_COMPRA': numeroPedidoCompra,
      if (itemPedidoCompra != null) 'ITEM_PEDIDO_COMPRA': itemPedidoCompra,
      if (numeroFci != null) 'NUMERO_FCI': numeroFci,
      if (numeroRecopi != null) 'NUMERO_RECOPI': numeroRecopi,
      if (valorUnitarioComercial != null) 'VALOR_UNITARIO_COMERCIAL': valorUnitarioComercial,
      if (valorBrutoProduto != null) 'VALOR_BRUTO_PRODUTO': valorBrutoProduto,
      if (gtinUnidadeTributavel != null) 'GTIN_UNIDADE_TRIBUTAVEL': gtinUnidadeTributavel,
      if (unidadeTributavel != null) 'UNIDADE_TRIBUTAVEL': unidadeTributavel,
      if (quantidadeTributavel != null) 'QUANTIDADE_TRIBUTAVEL': quantidadeTributavel,
      if (valorUnitarioTributavel != null) 'VALOR_UNITARIO_TRIBUTAVEL': valorUnitarioTributavel,
      if (valorFrete != null) 'VALOR_FRETE': valorFrete,
      if (valorSeguro != null) 'VALOR_SEGURO': valorSeguro,
      if (valorDesconto != null) 'VALOR_DESCONTO': valorDesconto,
      if (valorOutrasDespesas != null) 'VALOR_OUTRAS_DESPESAS': valorOutrasDespesas,
      if (entraTotal != null) 'ENTRA_TOTAL': entraTotal,
      if (valorTotalTributos != null) 'VALOR_TOTAL_TRIBUTOS': valorTotalTributos,
      if (percentualDevolvido != null) 'PERCENTUAL_DEVOLVIDO': percentualDevolvido,
      if (valorIpiDevolvido != null) 'VALOR_IPI_DEVOLVIDO': valorIpiDevolvido,
      if (informacoesAdicionais != null) 'INFORMACOES_ADICIONAIS': informacoesAdicionais,
      if (valorSubtotal != null) 'VALOR_SUBTOTAL': valorSubtotal,
      if (valorTotal != null) 'VALOR_TOTAL': valorTotal,
    });
  }

  NfeDetalhesCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<int>? numeroItem,
      Value<String>? codigoProduto,
      Value<String>? gtin,
      Value<String>? nomeProduto,
      Value<String>? ncm,
      Value<String>? nve,
      Value<String>? cest,
      Value<String>? indicadorEscalaRelevante,
      Value<String>? cnpjFabricante,
      Value<String>? codigoBeneficioFiscal,
      Value<int>? exTipi,
      Value<int>? cfop,
      Value<String>? unidadeComercial,
      Value<double>? quantidadeComercial,
      Value<String>? numeroPedidoCompra,
      Value<int>? itemPedidoCompra,
      Value<String>? numeroFci,
      Value<String>? numeroRecopi,
      Value<double>? valorUnitarioComercial,
      Value<double>? valorBrutoProduto,
      Value<String>? gtinUnidadeTributavel,
      Value<String>? unidadeTributavel,
      Value<double>? quantidadeTributavel,
      Value<double>? valorUnitarioTributavel,
      Value<double>? valorFrete,
      Value<double>? valorSeguro,
      Value<double>? valorDesconto,
      Value<double>? valorOutrasDespesas,
      Value<String>? entraTotal,
      Value<double>? valorTotalTributos,
      Value<double>? percentualDevolvido,
      Value<double>? valorIpiDevolvido,
      Value<String>? informacoesAdicionais,
      Value<double>? valorSubtotal,
      Value<double>? valorTotal,
	  }) {
    return NfeDetalhesCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      numeroItem: numeroItem ?? this.numeroItem,
      codigoProduto: codigoProduto ?? this.codigoProduto,
      gtin: gtin ?? this.gtin,
      nomeProduto: nomeProduto ?? this.nomeProduto,
      ncm: ncm ?? this.ncm,
      nve: nve ?? this.nve,
      cest: cest ?? this.cest,
      indicadorEscalaRelevante: indicadorEscalaRelevante ?? this.indicadorEscalaRelevante,
      cnpjFabricante: cnpjFabricante ?? this.cnpjFabricante,
      codigoBeneficioFiscal: codigoBeneficioFiscal ?? this.codigoBeneficioFiscal,
      exTipi: exTipi ?? this.exTipi,
      cfop: cfop ?? this.cfop,
      unidadeComercial: unidadeComercial ?? this.unidadeComercial,
      quantidadeComercial: quantidadeComercial ?? this.quantidadeComercial,
      numeroPedidoCompra: numeroPedidoCompra ?? this.numeroPedidoCompra,
      itemPedidoCompra: itemPedidoCompra ?? this.itemPedidoCompra,
      numeroFci: numeroFci ?? this.numeroFci,
      numeroRecopi: numeroRecopi ?? this.numeroRecopi,
      valorUnitarioComercial: valorUnitarioComercial ?? this.valorUnitarioComercial,
      valorBrutoProduto: valorBrutoProduto ?? this.valorBrutoProduto,
      gtinUnidadeTributavel: gtinUnidadeTributavel ?? this.gtinUnidadeTributavel,
      unidadeTributavel: unidadeTributavel ?? this.unidadeTributavel,
      quantidadeTributavel: quantidadeTributavel ?? this.quantidadeTributavel,
      valorUnitarioTributavel: valorUnitarioTributavel ?? this.valorUnitarioTributavel,
      valorFrete: valorFrete ?? this.valorFrete,
      valorSeguro: valorSeguro ?? this.valorSeguro,
      valorDesconto: valorDesconto ?? this.valorDesconto,
      valorOutrasDespesas: valorOutrasDespesas ?? this.valorOutrasDespesas,
      entraTotal: entraTotal ?? this.entraTotal,
      valorTotalTributos: valorTotalTributos ?? this.valorTotalTributos,
      percentualDevolvido: percentualDevolvido ?? this.percentualDevolvido,
      valorIpiDevolvido: valorIpiDevolvido ?? this.valorIpiDevolvido,
      informacoesAdicionais: informacoesAdicionais ?? this.informacoesAdicionais,
      valorSubtotal: valorSubtotal ?? this.valorSubtotal,
      valorTotal: valorTotal ?? this.valorTotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeCabecalho.present) {
      map['ID_NFE_CABECALHO'] = Variable<int?>(idNfeCabecalho.value);
    }
    if (numeroItem.present) {
      map['NUMERO_ITEM'] = Variable<int?>(numeroItem.value);
    }
    if (codigoProduto.present) {
      map['CODIGO_PRODUTO'] = Variable<String?>(codigoProduto.value);
    }
    if (gtin.present) {
      map['GTIN'] = Variable<String?>(gtin.value);
    }
    if (nomeProduto.present) {
      map['NOME_PRODUTO'] = Variable<String?>(nomeProduto.value);
    }
    if (ncm.present) {
      map['NCM'] = Variable<String?>(ncm.value);
    }
    if (nve.present) {
      map['NVE'] = Variable<String?>(nve.value);
    }
    if (cest.present) {
      map['CEST'] = Variable<String?>(cest.value);
    }
    if (indicadorEscalaRelevante.present) {
      map['INDICADOR_ESCALA_RELEVANTE'] = Variable<String?>(indicadorEscalaRelevante.value);
    }
    if (cnpjFabricante.present) {
      map['CNPJ_FABRICANTE'] = Variable<String?>(cnpjFabricante.value);
    }
    if (codigoBeneficioFiscal.present) {
      map['CODIGO_BENEFICIO_FISCAL'] = Variable<String?>(codigoBeneficioFiscal.value);
    }
    if (exTipi.present) {
      map['EX_TIPI'] = Variable<int?>(exTipi.value);
    }
    if (cfop.present) {
      map['CFOP'] = Variable<int?>(cfop.value);
    }
    if (unidadeComercial.present) {
      map['UNIDADE_COMERCIAL'] = Variable<String?>(unidadeComercial.value);
    }
    if (quantidadeComercial.present) {
      map['QUANTIDADE_COMERCIAL'] = Variable<double?>(quantidadeComercial.value);
    }
    if (numeroPedidoCompra.present) {
      map['NUMERO_PEDIDO_COMPRA'] = Variable<String?>(numeroPedidoCompra.value);
    }
    if (itemPedidoCompra.present) {
      map['ITEM_PEDIDO_COMPRA'] = Variable<int?>(itemPedidoCompra.value);
    }
    if (numeroFci.present) {
      map['NUMERO_FCI'] = Variable<String?>(numeroFci.value);
    }
    if (numeroRecopi.present) {
      map['NUMERO_RECOPI'] = Variable<String?>(numeroRecopi.value);
    }
    if (valorUnitarioComercial.present) {
      map['VALOR_UNITARIO_COMERCIAL'] = Variable<double?>(valorUnitarioComercial.value);
    }
    if (valorBrutoProduto.present) {
      map['VALOR_BRUTO_PRODUTO'] = Variable<double?>(valorBrutoProduto.value);
    }
    if (gtinUnidadeTributavel.present) {
      map['GTIN_UNIDADE_TRIBUTAVEL'] = Variable<String?>(gtinUnidadeTributavel.value);
    }
    if (unidadeTributavel.present) {
      map['UNIDADE_TRIBUTAVEL'] = Variable<String?>(unidadeTributavel.value);
    }
    if (quantidadeTributavel.present) {
      map['QUANTIDADE_TRIBUTAVEL'] = Variable<double?>(quantidadeTributavel.value);
    }
    if (valorUnitarioTributavel.present) {
      map['VALOR_UNITARIO_TRIBUTAVEL'] = Variable<double?>(valorUnitarioTributavel.value);
    }
    if (valorFrete.present) {
      map['VALOR_FRETE'] = Variable<double?>(valorFrete.value);
    }
    if (valorSeguro.present) {
      map['VALOR_SEGURO'] = Variable<double?>(valorSeguro.value);
    }
    if (valorDesconto.present) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto.value);
    }
    if (valorOutrasDespesas.present) {
      map['VALOR_OUTRAS_DESPESAS'] = Variable<double?>(valorOutrasDespesas.value);
    }
    if (entraTotal.present) {
      map['ENTRA_TOTAL'] = Variable<String?>(entraTotal.value);
    }
    if (valorTotalTributos.present) {
      map['VALOR_TOTAL_TRIBUTOS'] = Variable<double?>(valorTotalTributos.value);
    }
    if (percentualDevolvido.present) {
      map['PERCENTUAL_DEVOLVIDO'] = Variable<double?>(percentualDevolvido.value);
    }
    if (valorIpiDevolvido.present) {
      map['VALOR_IPI_DEVOLVIDO'] = Variable<double?>(valorIpiDevolvido.value);
    }
    if (informacoesAdicionais.present) {
      map['INFORMACOES_ADICIONAIS'] = Variable<String?>(informacoesAdicionais.value);
    }
    if (valorSubtotal.present) {
      map['VALOR_SUBTOTAL'] = Variable<double?>(valorSubtotal.value);
    }
    if (valorTotal.present) {
      map['VALOR_TOTAL'] = Variable<double?>(valorTotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetalhesCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('numeroItem: $numeroItem, ')
          ..write('codigoProduto: $codigoProduto, ')
          ..write('gtin: $gtin, ')
          ..write('nomeProduto: $nomeProduto, ')
          ..write('ncm: $ncm, ')
          ..write('nve: $nve, ')
          ..write('cest: $cest, ')
          ..write('indicadorEscalaRelevante: $indicadorEscalaRelevante, ')
          ..write('cnpjFabricante: $cnpjFabricante, ')
          ..write('codigoBeneficioFiscal: $codigoBeneficioFiscal, ')
          ..write('exTipi: $exTipi, ')
          ..write('cfop: $cfop, ')
          ..write('unidadeComercial: $unidadeComercial, ')
          ..write('quantidadeComercial: $quantidadeComercial, ')
          ..write('numeroPedidoCompra: $numeroPedidoCompra, ')
          ..write('itemPedidoCompra: $itemPedidoCompra, ')
          ..write('numeroFci: $numeroFci, ')
          ..write('numeroRecopi: $numeroRecopi, ')
          ..write('valorUnitarioComercial: $valorUnitarioComercial, ')
          ..write('valorBrutoProduto: $valorBrutoProduto, ')
          ..write('gtinUnidadeTributavel: $gtinUnidadeTributavel, ')
          ..write('unidadeTributavel: $unidadeTributavel, ')
          ..write('quantidadeTributavel: $quantidadeTributavel, ')
          ..write('valorUnitarioTributavel: $valorUnitarioTributavel, ')
          ..write('valorFrete: $valorFrete, ')
          ..write('valorSeguro: $valorSeguro, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorOutrasDespesas: $valorOutrasDespesas, ')
          ..write('entraTotal: $entraTotal, ')
          ..write('valorTotalTributos: $valorTotalTributos, ')
          ..write('percentualDevolvido: $percentualDevolvido, ')
          ..write('valorIpiDevolvido: $valorIpiDevolvido, ')
          ..write('informacoesAdicionais: $informacoesAdicionais, ')
          ..write('valorSubtotal: $valorSubtotal, ')
          ..write('valorTotal: $valorTotal, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetalhesTable extends NfeDetalhes
    with TableInfo<$NfeDetalhesTable, NfeDetalhe> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetalhesTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeCabecalhoMeta =
      const VerificationMeta('idNfeCabecalho');
  GeneratedColumn<int>? _idNfeCabecalho;
  @override
  GeneratedColumn<int> get idNfeCabecalho =>
      _idNfeCabecalho ??= GeneratedColumn<int>('ID_NFE_CABECALHO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_CABECALHO(ID)');
  final VerificationMeta _numeroItemMeta =
      const VerificationMeta('numeroItem');
  GeneratedColumn<int>? _numeroItem;
  @override
  GeneratedColumn<int> get numeroItem => _numeroItem ??=
      GeneratedColumn<int>('NUMERO_ITEM', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _codigoProdutoMeta =
      const VerificationMeta('codigoProduto');
  GeneratedColumn<String>? _codigoProduto;
  @override
  GeneratedColumn<String> get codigoProduto => _codigoProduto ??=
      GeneratedColumn<String>('CODIGO_PRODUTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _gtinMeta =
      const VerificationMeta('gtin');
  GeneratedColumn<String>? _gtin;
  @override
  GeneratedColumn<String> get gtin => _gtin ??=
      GeneratedColumn<String>('GTIN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nomeProdutoMeta =
      const VerificationMeta('nomeProduto');
  GeneratedColumn<String>? _nomeProduto;
  @override
  GeneratedColumn<String> get nomeProduto => _nomeProduto ??=
      GeneratedColumn<String>('NOME_PRODUTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ncmMeta =
      const VerificationMeta('ncm');
  GeneratedColumn<String>? _ncm;
  @override
  GeneratedColumn<String> get ncm => _ncm ??=
      GeneratedColumn<String>('NCM', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nveMeta =
      const VerificationMeta('nve');
  GeneratedColumn<String>? _nve;
  @override
  GeneratedColumn<String> get nve => _nve ??=
      GeneratedColumn<String>('NVE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cestMeta =
      const VerificationMeta('cest');
  GeneratedColumn<String>? _cest;
  @override
  GeneratedColumn<String> get cest => _cest ??=
      GeneratedColumn<String>('CEST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _indicadorEscalaRelevanteMeta =
      const VerificationMeta('indicadorEscalaRelevante');
  GeneratedColumn<String>? _indicadorEscalaRelevante;
  @override
  GeneratedColumn<String> get indicadorEscalaRelevante => _indicadorEscalaRelevante ??=
      GeneratedColumn<String>('INDICADOR_ESCALA_RELEVANTE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cnpjFabricanteMeta =
      const VerificationMeta('cnpjFabricante');
  GeneratedColumn<String>? _cnpjFabricante;
  @override
  GeneratedColumn<String> get cnpjFabricante => _cnpjFabricante ??=
      GeneratedColumn<String>('CNPJ_FABRICANTE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoBeneficioFiscalMeta =
      const VerificationMeta('codigoBeneficioFiscal');
  GeneratedColumn<String>? _codigoBeneficioFiscal;
  @override
  GeneratedColumn<String> get codigoBeneficioFiscal => _codigoBeneficioFiscal ??=
      GeneratedColumn<String>('CODIGO_BENEFICIO_FISCAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _exTipiMeta =
      const VerificationMeta('exTipi');
  GeneratedColumn<int>? _exTipi;
  @override
  GeneratedColumn<int> get exTipi => _exTipi ??=
      GeneratedColumn<int>('EX_TIPI', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _cfopMeta =
      const VerificationMeta('cfop');
  GeneratedColumn<int>? _cfop;
  @override
  GeneratedColumn<int> get cfop => _cfop ??=
      GeneratedColumn<int>('CFOP', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _unidadeComercialMeta =
      const VerificationMeta('unidadeComercial');
  GeneratedColumn<String>? _unidadeComercial;
  @override
  GeneratedColumn<String> get unidadeComercial => _unidadeComercial ??=
      GeneratedColumn<String>('UNIDADE_COMERCIAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _quantidadeComercialMeta =
      const VerificationMeta('quantidadeComercial');
  GeneratedColumn<double>? _quantidadeComercial;
  @override
  GeneratedColumn<double> get quantidadeComercial => _quantidadeComercial ??=
      GeneratedColumn<double>('QUANTIDADE_COMERCIAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _numeroPedidoCompraMeta =
      const VerificationMeta('numeroPedidoCompra');
  GeneratedColumn<String>? _numeroPedidoCompra;
  @override
  GeneratedColumn<String> get numeroPedidoCompra => _numeroPedidoCompra ??=
      GeneratedColumn<String>('NUMERO_PEDIDO_COMPRA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _itemPedidoCompraMeta =
      const VerificationMeta('itemPedidoCompra');
  GeneratedColumn<int>? _itemPedidoCompra;
  @override
  GeneratedColumn<int> get itemPedidoCompra => _itemPedidoCompra ??=
      GeneratedColumn<int>('ITEM_PEDIDO_COMPRA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _numeroFciMeta =
      const VerificationMeta('numeroFci');
  GeneratedColumn<String>? _numeroFci;
  @override
  GeneratedColumn<String> get numeroFci => _numeroFci ??=
      GeneratedColumn<String>('NUMERO_FCI', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroRecopiMeta =
      const VerificationMeta('numeroRecopi');
  GeneratedColumn<String>? _numeroRecopi;
  @override
  GeneratedColumn<String> get numeroRecopi => _numeroRecopi ??=
      GeneratedColumn<String>('NUMERO_RECOPI', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorUnitarioComercialMeta =
      const VerificationMeta('valorUnitarioComercial');
  GeneratedColumn<double>? _valorUnitarioComercial;
  @override
  GeneratedColumn<double> get valorUnitarioComercial => _valorUnitarioComercial ??=
      GeneratedColumn<double>('VALOR_UNITARIO_COMERCIAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorBrutoProdutoMeta =
      const VerificationMeta('valorBrutoProduto');
  GeneratedColumn<double>? _valorBrutoProduto;
  @override
  GeneratedColumn<double> get valorBrutoProduto => _valorBrutoProduto ??=
      GeneratedColumn<double>('VALOR_BRUTO_PRODUTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _gtinUnidadeTributavelMeta =
      const VerificationMeta('gtinUnidadeTributavel');
  GeneratedColumn<String>? _gtinUnidadeTributavel;
  @override
  GeneratedColumn<String> get gtinUnidadeTributavel => _gtinUnidadeTributavel ??=
      GeneratedColumn<String>('GTIN_UNIDADE_TRIBUTAVEL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _unidadeTributavelMeta =
      const VerificationMeta('unidadeTributavel');
  GeneratedColumn<String>? _unidadeTributavel;
  @override
  GeneratedColumn<String> get unidadeTributavel => _unidadeTributavel ??=
      GeneratedColumn<String>('UNIDADE_TRIBUTAVEL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _quantidadeTributavelMeta =
      const VerificationMeta('quantidadeTributavel');
  GeneratedColumn<double>? _quantidadeTributavel;
  @override
  GeneratedColumn<double> get quantidadeTributavel => _quantidadeTributavel ??=
      GeneratedColumn<double>('QUANTIDADE_TRIBUTAVEL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorUnitarioTributavelMeta =
      const VerificationMeta('valorUnitarioTributavel');
  GeneratedColumn<double>? _valorUnitarioTributavel;
  @override
  GeneratedColumn<double> get valorUnitarioTributavel => _valorUnitarioTributavel ??=
      GeneratedColumn<double>('VALOR_UNITARIO_TRIBUTAVEL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorFreteMeta =
      const VerificationMeta('valorFrete');
  GeneratedColumn<double>? _valorFrete;
  @override
  GeneratedColumn<double> get valorFrete => _valorFrete ??=
      GeneratedColumn<double>('VALOR_FRETE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorSeguroMeta =
      const VerificationMeta('valorSeguro');
  GeneratedColumn<double>? _valorSeguro;
  @override
  GeneratedColumn<double> get valorSeguro => _valorSeguro ??=
      GeneratedColumn<double>('VALOR_SEGURO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorDescontoMeta =
      const VerificationMeta('valorDesconto');
  GeneratedColumn<double>? _valorDesconto;
  @override
  GeneratedColumn<double> get valorDesconto => _valorDesconto ??=
      GeneratedColumn<double>('VALOR_DESCONTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorOutrasDespesasMeta =
      const VerificationMeta('valorOutrasDespesas');
  GeneratedColumn<double>? _valorOutrasDespesas;
  @override
  GeneratedColumn<double> get valorOutrasDespesas => _valorOutrasDespesas ??=
      GeneratedColumn<double>('VALOR_OUTRAS_DESPESAS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _entraTotalMeta =
      const VerificationMeta('entraTotal');
  GeneratedColumn<String>? _entraTotal;
  @override
  GeneratedColumn<String> get entraTotal => _entraTotal ??=
      GeneratedColumn<String>('ENTRA_TOTAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorTotalTributosMeta =
      const VerificationMeta('valorTotalTributos');
  GeneratedColumn<double>? _valorTotalTributos;
  @override
  GeneratedColumn<double> get valorTotalTributos => _valorTotalTributos ??=
      GeneratedColumn<double>('VALOR_TOTAL_TRIBUTOS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualDevolvidoMeta =
      const VerificationMeta('percentualDevolvido');
  GeneratedColumn<double>? _percentualDevolvido;
  @override
  GeneratedColumn<double> get percentualDevolvido => _percentualDevolvido ??=
      GeneratedColumn<double>('PERCENTUAL_DEVOLVIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIpiDevolvidoMeta =
      const VerificationMeta('valorIpiDevolvido');
  GeneratedColumn<double>? _valorIpiDevolvido;
  @override
  GeneratedColumn<double> get valorIpiDevolvido => _valorIpiDevolvido ??=
      GeneratedColumn<double>('VALOR_IPI_DEVOLVIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _informacoesAdicionaisMeta =
      const VerificationMeta('informacoesAdicionais');
  GeneratedColumn<String>? _informacoesAdicionais;
  @override
  GeneratedColumn<String> get informacoesAdicionais => _informacoesAdicionais ??=
      GeneratedColumn<String>('INFORMACOES_ADICIONAIS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorSubtotalMeta =
      const VerificationMeta('valorSubtotal');
  GeneratedColumn<double>? _valorSubtotal;
  @override
  GeneratedColumn<double> get valorSubtotal => _valorSubtotal ??=
      GeneratedColumn<double>('VALOR_SUBTOTAL', aliasedName, true,
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
        idNfeCabecalho,
        numeroItem,
        codigoProduto,
        gtin,
        nomeProduto,
        ncm,
        nve,
        cest,
        indicadorEscalaRelevante,
        cnpjFabricante,
        codigoBeneficioFiscal,
        exTipi,
        cfop,
        unidadeComercial,
        quantidadeComercial,
        numeroPedidoCompra,
        itemPedidoCompra,
        numeroFci,
        numeroRecopi,
        valorUnitarioComercial,
        valorBrutoProduto,
        gtinUnidadeTributavel,
        unidadeTributavel,
        quantidadeTributavel,
        valorUnitarioTributavel,
        valorFrete,
        valorSeguro,
        valorDesconto,
        valorOutrasDespesas,
        entraTotal,
        valorTotalTributos,
        percentualDevolvido,
        valorIpiDevolvido,
        informacoesAdicionais,
        valorSubtotal,
        valorTotal,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DETALHE';
  
  @override
  String get actualTableName => 'NFE_DETALHE';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetalhe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_CABECALHO')) {
        context.handle(_idNfeCabecalhoMeta,
            idNfeCabecalho.isAcceptableOrUnknown(data['ID_NFE_CABECALHO']!, _idNfeCabecalhoMeta));
    }
    if (data.containsKey('NUMERO_ITEM')) {
        context.handle(_numeroItemMeta,
            numeroItem.isAcceptableOrUnknown(data['NUMERO_ITEM']!, _numeroItemMeta));
    }
    if (data.containsKey('CODIGO_PRODUTO')) {
        context.handle(_codigoProdutoMeta,
            codigoProduto.isAcceptableOrUnknown(data['CODIGO_PRODUTO']!, _codigoProdutoMeta));
    }
    if (data.containsKey('GTIN')) {
        context.handle(_gtinMeta,
            gtin.isAcceptableOrUnknown(data['GTIN']!, _gtinMeta));
    }
    if (data.containsKey('NOME_PRODUTO')) {
        context.handle(_nomeProdutoMeta,
            nomeProduto.isAcceptableOrUnknown(data['NOME_PRODUTO']!, _nomeProdutoMeta));
    }
    if (data.containsKey('NCM')) {
        context.handle(_ncmMeta,
            ncm.isAcceptableOrUnknown(data['NCM']!, _ncmMeta));
    }
    if (data.containsKey('NVE')) {
        context.handle(_nveMeta,
            nve.isAcceptableOrUnknown(data['NVE']!, _nveMeta));
    }
    if (data.containsKey('CEST')) {
        context.handle(_cestMeta,
            cest.isAcceptableOrUnknown(data['CEST']!, _cestMeta));
    }
    if (data.containsKey('INDICADOR_ESCALA_RELEVANTE')) {
        context.handle(_indicadorEscalaRelevanteMeta,
            indicadorEscalaRelevante.isAcceptableOrUnknown(data['INDICADOR_ESCALA_RELEVANTE']!, _indicadorEscalaRelevanteMeta));
    }
    if (data.containsKey('CNPJ_FABRICANTE')) {
        context.handle(_cnpjFabricanteMeta,
            cnpjFabricante.isAcceptableOrUnknown(data['CNPJ_FABRICANTE']!, _cnpjFabricanteMeta));
    }
    if (data.containsKey('CODIGO_BENEFICIO_FISCAL')) {
        context.handle(_codigoBeneficioFiscalMeta,
            codigoBeneficioFiscal.isAcceptableOrUnknown(data['CODIGO_BENEFICIO_FISCAL']!, _codigoBeneficioFiscalMeta));
    }
    if (data.containsKey('EX_TIPI')) {
        context.handle(_exTipiMeta,
            exTipi.isAcceptableOrUnknown(data['EX_TIPI']!, _exTipiMeta));
    }
    if (data.containsKey('CFOP')) {
        context.handle(_cfopMeta,
            cfop.isAcceptableOrUnknown(data['CFOP']!, _cfopMeta));
    }
    if (data.containsKey('UNIDADE_COMERCIAL')) {
        context.handle(_unidadeComercialMeta,
            unidadeComercial.isAcceptableOrUnknown(data['UNIDADE_COMERCIAL']!, _unidadeComercialMeta));
    }
    if (data.containsKey('QUANTIDADE_COMERCIAL')) {
        context.handle(_quantidadeComercialMeta,
            quantidadeComercial.isAcceptableOrUnknown(data['QUANTIDADE_COMERCIAL']!, _quantidadeComercialMeta));
    }
    if (data.containsKey('NUMERO_PEDIDO_COMPRA')) {
        context.handle(_numeroPedidoCompraMeta,
            numeroPedidoCompra.isAcceptableOrUnknown(data['NUMERO_PEDIDO_COMPRA']!, _numeroPedidoCompraMeta));
    }
    if (data.containsKey('ITEM_PEDIDO_COMPRA')) {
        context.handle(_itemPedidoCompraMeta,
            itemPedidoCompra.isAcceptableOrUnknown(data['ITEM_PEDIDO_COMPRA']!, _itemPedidoCompraMeta));
    }
    if (data.containsKey('NUMERO_FCI')) {
        context.handle(_numeroFciMeta,
            numeroFci.isAcceptableOrUnknown(data['NUMERO_FCI']!, _numeroFciMeta));
    }
    if (data.containsKey('NUMERO_RECOPI')) {
        context.handle(_numeroRecopiMeta,
            numeroRecopi.isAcceptableOrUnknown(data['NUMERO_RECOPI']!, _numeroRecopiMeta));
    }
    if (data.containsKey('VALOR_UNITARIO_COMERCIAL')) {
        context.handle(_valorUnitarioComercialMeta,
            valorUnitarioComercial.isAcceptableOrUnknown(data['VALOR_UNITARIO_COMERCIAL']!, _valorUnitarioComercialMeta));
    }
    if (data.containsKey('VALOR_BRUTO_PRODUTO')) {
        context.handle(_valorBrutoProdutoMeta,
            valorBrutoProduto.isAcceptableOrUnknown(data['VALOR_BRUTO_PRODUTO']!, _valorBrutoProdutoMeta));
    }
    if (data.containsKey('GTIN_UNIDADE_TRIBUTAVEL')) {
        context.handle(_gtinUnidadeTributavelMeta,
            gtinUnidadeTributavel.isAcceptableOrUnknown(data['GTIN_UNIDADE_TRIBUTAVEL']!, _gtinUnidadeTributavelMeta));
    }
    if (data.containsKey('UNIDADE_TRIBUTAVEL')) {
        context.handle(_unidadeTributavelMeta,
            unidadeTributavel.isAcceptableOrUnknown(data['UNIDADE_TRIBUTAVEL']!, _unidadeTributavelMeta));
    }
    if (data.containsKey('QUANTIDADE_TRIBUTAVEL')) {
        context.handle(_quantidadeTributavelMeta,
            quantidadeTributavel.isAcceptableOrUnknown(data['QUANTIDADE_TRIBUTAVEL']!, _quantidadeTributavelMeta));
    }
    if (data.containsKey('VALOR_UNITARIO_TRIBUTAVEL')) {
        context.handle(_valorUnitarioTributavelMeta,
            valorUnitarioTributavel.isAcceptableOrUnknown(data['VALOR_UNITARIO_TRIBUTAVEL']!, _valorUnitarioTributavelMeta));
    }
    if (data.containsKey('VALOR_FRETE')) {
        context.handle(_valorFreteMeta,
            valorFrete.isAcceptableOrUnknown(data['VALOR_FRETE']!, _valorFreteMeta));
    }
    if (data.containsKey('VALOR_SEGURO')) {
        context.handle(_valorSeguroMeta,
            valorSeguro.isAcceptableOrUnknown(data['VALOR_SEGURO']!, _valorSeguroMeta));
    }
    if (data.containsKey('VALOR_DESCONTO')) {
        context.handle(_valorDescontoMeta,
            valorDesconto.isAcceptableOrUnknown(data['VALOR_DESCONTO']!, _valorDescontoMeta));
    }
    if (data.containsKey('VALOR_OUTRAS_DESPESAS')) {
        context.handle(_valorOutrasDespesasMeta,
            valorOutrasDespesas.isAcceptableOrUnknown(data['VALOR_OUTRAS_DESPESAS']!, _valorOutrasDespesasMeta));
    }
    if (data.containsKey('ENTRA_TOTAL')) {
        context.handle(_entraTotalMeta,
            entraTotal.isAcceptableOrUnknown(data['ENTRA_TOTAL']!, _entraTotalMeta));
    }
    if (data.containsKey('VALOR_TOTAL_TRIBUTOS')) {
        context.handle(_valorTotalTributosMeta,
            valorTotalTributos.isAcceptableOrUnknown(data['VALOR_TOTAL_TRIBUTOS']!, _valorTotalTributosMeta));
    }
    if (data.containsKey('PERCENTUAL_DEVOLVIDO')) {
        context.handle(_percentualDevolvidoMeta,
            percentualDevolvido.isAcceptableOrUnknown(data['PERCENTUAL_DEVOLVIDO']!, _percentualDevolvidoMeta));
    }
    if (data.containsKey('VALOR_IPI_DEVOLVIDO')) {
        context.handle(_valorIpiDevolvidoMeta,
            valorIpiDevolvido.isAcceptableOrUnknown(data['VALOR_IPI_DEVOLVIDO']!, _valorIpiDevolvidoMeta));
    }
    if (data.containsKey('INFORMACOES_ADICIONAIS')) {
        context.handle(_informacoesAdicionaisMeta,
            informacoesAdicionais.isAcceptableOrUnknown(data['INFORMACOES_ADICIONAIS']!, _informacoesAdicionaisMeta));
    }
    if (data.containsKey('VALOR_SUBTOTAL')) {
        context.handle(_valorSubtotalMeta,
            valorSubtotal.isAcceptableOrUnknown(data['VALOR_SUBTOTAL']!, _valorSubtotalMeta));
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
  NfeDetalhe map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetalhe.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetalhesTable createAlias(String alias) {
    return $NfeDetalhesTable(_db, alias);
  }
}