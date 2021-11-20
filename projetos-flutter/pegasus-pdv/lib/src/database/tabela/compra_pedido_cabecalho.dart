/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [COMPRA_PEDIDO_CABECALHO] 
                                                                                
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

@DataClassName("CompraPedidoCabecalho")
@UseRowClass(CompraPedidoCabecalho)
class CompraPedidoCabecalhos extends Table {
  @override
  String get tableName => 'COMPRA_PEDIDO_CABECALHO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idColaborador => integer().named('ID_COLABORADOR').nullable().customConstraint('NULLABLE REFERENCES COLABORADOR(ID)')();
  IntColumn get idFornecedor => integer().named('ID_FORNECEDOR').nullable().customConstraint('NULLABLE REFERENCES FORNECEDOR(ID)')();
  DateTimeColumn get dataPedido => dateTime().named('DATA_PEDIDO').nullable()();
  DateTimeColumn get dataPrevisaoEntrega => dateTime().named('DATA_PREVISAO_ENTREGA').nullable()();
  DateTimeColumn get dataPrevisaoPagamento => dateTime().named('DATA_PREVISAO_PAGAMENTO').nullable()();
  TextColumn get localEntrega => text().named('LOCAL_ENTREGA').withLength(min: 0, max: 100).nullable()();
  TextColumn get localCobranca => text().named('LOCAL_COBRANCA').withLength(min: 0, max: 100).nullable()();
  TextColumn get contato => text().named('CONTATO').withLength(min: 0, max: 50).nullable()();
  RealColumn get valorSubtotal => real().named('VALOR_SUBTOTAL').nullable()();
  RealColumn get taxaDesconto => real().named('TAXA_DESCONTO').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get valorTotal => real().named('VALOR_TOTAL').nullable()();
  TextColumn get formaPagamento => text().named('FORMA_PAGAMENTO').withLength(min: 0, max: 1).nullable()();
  TextColumn get geraFinanceiro => text().named('GERA_FINANCEIRO').withLength(min: 0, max: 1).nullable()();
  IntColumn get quantidadeParcelas => integer().named('QUANTIDADE_PARCELAS').nullable()();
  DateTimeColumn get diaPrimeiroVencimento => dateTime().named('DIA_PRIMEIRO_VENCIMENTO').nullable()();
  IntColumn get intervaloEntreParcelas => integer().named('INTERVALO_ENTRE_PARCELAS').nullable()();
  TextColumn get diaFixoParcela => text().named('DIA_FIXO_PARCELA').withLength(min: 0, max: 2).nullable()();
  DateTimeColumn get dataRecebimentoItens => dateTime().named('DATA_RECEBIMENTO_ITENS').nullable()();
  TextColumn get horaRecebimentoItens => text().named('HORA_RECEBIMENTO_ITENS').withLength(min: 0, max: 8).nullable()();
  TextColumn get atualizouEstoque => text().named('ATUALIZOU_ESTOQUE').withLength(min: 0, max: 1).nullable()();
  TextColumn get numeroDocumentoEntrada => text().named('NUMERO_DOCUMENTO_ENTRADA').withLength(min: 0, max: 50).nullable()();
}

class CompraPedidoCabecalhoMontado {
  CompraPedidoCabecalho? compraPedidoCabecalho;
  Colaborador? colaborador;
  Fornecedor? fornecedor;

  CompraPedidoCabecalhoMontado({
    this.compraPedidoCabecalho,
    this.colaborador,
    this.fornecedor,
  });
}

class CompraPedidoCabecalho extends DataClass implements Insertable<CompraPedidoCabecalho> {
  final int? id;
  final int? idColaborador;
  final int? idFornecedor;
  final DateTime? dataPedido;
  final DateTime? dataPrevisaoEntrega;
  final DateTime? dataPrevisaoPagamento;
  final String? localEntrega;
  final String? localCobranca;
  final String? contato;
  final double? valorSubtotal;
  final double? taxaDesconto;
  final double? valorDesconto;
  final double? valorTotal;
  final String? formaPagamento;
  final String? geraFinanceiro;
  final int? quantidadeParcelas;
  final DateTime? diaPrimeiroVencimento;
  final int? intervaloEntreParcelas;
  final String? diaFixoParcela;
  final DateTime? dataRecebimentoItens;
  final String? horaRecebimentoItens;
  final String? atualizouEstoque;
  final String? numeroDocumentoEntrada;

  CompraPedidoCabecalho(
    {
      required this.id,
      this.idColaborador,
      this.idFornecedor,
      this.dataPedido,
      this.dataPrevisaoEntrega,
      this.dataPrevisaoPagamento,
      this.localEntrega,
      this.localCobranca,
      this.contato,
      this.valorSubtotal,
      this.taxaDesconto,
      this.valorDesconto,
      this.valorTotal,
      this.formaPagamento,
      this.geraFinanceiro,
      this.quantidadeParcelas,
      this.diaPrimeiroVencimento,
      this.intervaloEntreParcelas,
      this.diaFixoParcela,
      this.dataRecebimentoItens,
      this.horaRecebimentoItens,
      this.atualizouEstoque,
      this.numeroDocumentoEntrada,
    }
  );

  factory CompraPedidoCabecalho.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CompraPedidoCabecalho(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idColaborador: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_COLABORADOR']),
      idFornecedor: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_FORNECEDOR']),
      dataPedido: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_PEDIDO']),
      dataPrevisaoEntrega: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_PREVISAO_ENTREGA']),
      dataPrevisaoPagamento: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_PREVISAO_PAGAMENTO']),
      localEntrega: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}LOCAL_ENTREGA']),
      localCobranca: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}LOCAL_COBRANCA']),
      contato: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CONTATO']),
      valorSubtotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_SUBTOTAL']),
      taxaDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TAXA_DESCONTO']),
      valorDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DESCONTO']),
      valorTotal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL']),
      formaPagamento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}FORMA_PAGAMENTO']),
      geraFinanceiro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}GERA_FINANCEIRO']),
      quantidadeParcelas: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_PARCELAS']),
      diaPrimeiroVencimento: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DIA_PRIMEIRO_VENCIMENTO']),
      intervaloEntreParcelas: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}INTERVALO_ENTRE_PARCELAS']),
      diaFixoParcela: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DIA_FIXO_PARCELA']),
      dataRecebimentoItens: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_RECEBIMENTO_ITENS']),
      horaRecebimentoItens: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_RECEBIMENTO_ITENS']),
      atualizouEstoque: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ATUALIZOU_ESTOQUE']),
      numeroDocumentoEntrada: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_DOCUMENTO_ENTRADA']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idColaborador != null) {
      map['ID_COLABORADOR'] = Variable<int?>(idColaborador);
    }
    if (!nullToAbsent || idFornecedor != null) {
      map['ID_FORNECEDOR'] = Variable<int?>(idFornecedor);
    }
    if (!nullToAbsent || dataPedido != null) {
      map['DATA_PEDIDO'] = Variable<DateTime?>(dataPedido);
    }
    if (!nullToAbsent || dataPrevisaoEntrega != null) {
      map['DATA_PREVISAO_ENTREGA'] = Variable<DateTime?>(dataPrevisaoEntrega);
    }
    if (!nullToAbsent || dataPrevisaoPagamento != null) {
      map['DATA_PREVISAO_PAGAMENTO'] = Variable<DateTime?>(dataPrevisaoPagamento);
    }
    if (!nullToAbsent || localEntrega != null) {
      map['LOCAL_ENTREGA'] = Variable<String?>(localEntrega);
    }
    if (!nullToAbsent || localCobranca != null) {
      map['LOCAL_COBRANCA'] = Variable<String?>(localCobranca);
    }
    if (!nullToAbsent || contato != null) {
      map['CONTATO'] = Variable<String?>(contato);
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
    if (!nullToAbsent || formaPagamento != null) {
      map['FORMA_PAGAMENTO'] = Variable<String?>(formaPagamento);
    }
    if (!nullToAbsent || geraFinanceiro != null) {
      map['GERA_FINANCEIRO'] = Variable<String?>(geraFinanceiro);
    }
    if (!nullToAbsent || quantidadeParcelas != null) {
      map['QUANTIDADE_PARCELAS'] = Variable<int?>(quantidadeParcelas);
    }
    if (!nullToAbsent || diaPrimeiroVencimento != null) {
      map['DIA_PRIMEIRO_VENCIMENTO'] = Variable<DateTime?>(diaPrimeiroVencimento);
    }
    if (!nullToAbsent || intervaloEntreParcelas != null) {
      map['INTERVALO_ENTRE_PARCELAS'] = Variable<int?>(intervaloEntreParcelas);
    }
    if (!nullToAbsent || diaFixoParcela != null) {
      map['DIA_FIXO_PARCELA'] = Variable<String?>(diaFixoParcela);
    }
    if (!nullToAbsent || dataRecebimentoItens != null) {
      map['DATA_RECEBIMENTO_ITENS'] = Variable<DateTime?>(dataRecebimentoItens);
    }
    if (!nullToAbsent || horaRecebimentoItens != null) {
      map['HORA_RECEBIMENTO_ITENS'] = Variable<String?>(horaRecebimentoItens);
    }
    if (!nullToAbsent || atualizouEstoque != null) {
      map['ATUALIZOU_ESTOQUE'] = Variable<String?>(atualizouEstoque);
    }
    if (!nullToAbsent || numeroDocumentoEntrada != null) {
      map['NUMERO_DOCUMENTO_ENTRADA'] = Variable<String?>(numeroDocumentoEntrada);
    }
    return map;
  }

  CompraPedidoCabecalhosCompanion toCompanion(bool nullToAbsent) {
    return CompraPedidoCabecalhosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idColaborador: idColaborador == null && nullToAbsent
        ? const Value.absent()
        : Value(idColaborador),
      idFornecedor: idFornecedor == null && nullToAbsent
        ? const Value.absent()
        : Value(idFornecedor),
      dataPedido: dataPedido == null && nullToAbsent
        ? const Value.absent()
        : Value(dataPedido),
      dataPrevisaoEntrega: dataPrevisaoEntrega == null && nullToAbsent
        ? const Value.absent()
        : Value(dataPrevisaoEntrega),
      dataPrevisaoPagamento: dataPrevisaoPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(dataPrevisaoPagamento),
      localEntrega: localEntrega == null && nullToAbsent
        ? const Value.absent()
        : Value(localEntrega),
      localCobranca: localCobranca == null && nullToAbsent
        ? const Value.absent()
        : Value(localCobranca),
      contato: contato == null && nullToAbsent
        ? const Value.absent()
        : Value(contato),
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
      formaPagamento: formaPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(formaPagamento),
      geraFinanceiro: geraFinanceiro == null && nullToAbsent
        ? const Value.absent()
        : Value(geraFinanceiro),
      quantidadeParcelas: quantidadeParcelas == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeParcelas),
      diaPrimeiroVencimento: diaPrimeiroVencimento == null && nullToAbsent
        ? const Value.absent()
        : Value(diaPrimeiroVencimento),
      intervaloEntreParcelas: intervaloEntreParcelas == null && nullToAbsent
        ? const Value.absent()
        : Value(intervaloEntreParcelas),
      diaFixoParcela: diaFixoParcela == null && nullToAbsent
        ? const Value.absent()
        : Value(diaFixoParcela),
      dataRecebimentoItens: dataRecebimentoItens == null && nullToAbsent
        ? const Value.absent()
        : Value(dataRecebimentoItens),
      horaRecebimentoItens: horaRecebimentoItens == null && nullToAbsent
        ? const Value.absent()
        : Value(horaRecebimentoItens),
      atualizouEstoque: atualizouEstoque == null && nullToAbsent
        ? const Value.absent()
        : Value(atualizouEstoque),
      numeroDocumentoEntrada: numeroDocumentoEntrada == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroDocumentoEntrada),
    );
  }

  factory CompraPedidoCabecalho.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CompraPedidoCabecalho(
      id: serializer.fromJson<int>(json['id']),
      idColaborador: serializer.fromJson<int>(json['idColaborador']),
      idFornecedor: serializer.fromJson<int>(json['idFornecedor']),
      dataPedido: serializer.fromJson<DateTime>(json['dataPedido']),
      dataPrevisaoEntrega: serializer.fromJson<DateTime>(json['dataPrevisaoEntrega']),
      dataPrevisaoPagamento: serializer.fromJson<DateTime>(json['dataPrevisaoPagamento']),
      localEntrega: serializer.fromJson<String>(json['localEntrega']),
      localCobranca: serializer.fromJson<String>(json['localCobranca']),
      contato: serializer.fromJson<String>(json['contato']),
      valorSubtotal: serializer.fromJson<double>(json['valorSubtotal']),
      taxaDesconto: serializer.fromJson<double>(json['taxaDesconto']),
      valorDesconto: serializer.fromJson<double>(json['valorDesconto']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
      formaPagamento: serializer.fromJson<String>(json['formaPagamento']),
      geraFinanceiro: serializer.fromJson<String>(json['geraFinanceiro']),
      quantidadeParcelas: serializer.fromJson<int>(json['quantidadeParcelas']),
      diaPrimeiroVencimento: serializer.fromJson<DateTime>(json['diaPrimeiroVencimento']),
      intervaloEntreParcelas: serializer.fromJson<int>(json['intervaloEntreParcelas']),
      diaFixoParcela: serializer.fromJson<String>(json['diaFixoParcela']),
      dataRecebimentoItens: serializer.fromJson<DateTime>(json['dataRecebimentoItens']),
      horaRecebimentoItens: serializer.fromJson<String>(json['horaRecebimentoItens']),
      atualizouEstoque: serializer.fromJson<String>(json['atualizouEstoque']),
      numeroDocumentoEntrada: serializer.fromJson<String>(json['numeroDocumentoEntrada']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idColaborador': serializer.toJson<int?>(idColaborador),
      'idFornecedor': serializer.toJson<int?>(idFornecedor),
      'dataPedido': serializer.toJson<DateTime?>(dataPedido),
      'dataPrevisaoEntrega': serializer.toJson<DateTime?>(dataPrevisaoEntrega),
      'dataPrevisaoPagamento': serializer.toJson<DateTime?>(dataPrevisaoPagamento),
      'localEntrega': serializer.toJson<String?>(localEntrega),
      'localCobranca': serializer.toJson<String?>(localCobranca),
      'contato': serializer.toJson<String?>(contato),
      'valorSubtotal': serializer.toJson<double?>(valorSubtotal),
      'taxaDesconto': serializer.toJson<double?>(taxaDesconto),
      'valorDesconto': serializer.toJson<double?>(valorDesconto),
      'valorTotal': serializer.toJson<double?>(valorTotal),
      'formaPagamento': serializer.toJson<String?>(formaPagamento),
      'geraFinanceiro': serializer.toJson<String?>(geraFinanceiro),
      'quantidadeParcelas': serializer.toJson<int?>(quantidadeParcelas),
      'diaPrimeiroVencimento': serializer.toJson<DateTime?>(diaPrimeiroVencimento),
      'intervaloEntreParcelas': serializer.toJson<int?>(intervaloEntreParcelas),
      'diaFixoParcela': serializer.toJson<String?>(diaFixoParcela),
      'dataRecebimentoItens': serializer.toJson<DateTime?>(dataRecebimentoItens),
      'horaRecebimentoItens': serializer.toJson<String?>(horaRecebimentoItens),
      'atualizouEstoque': serializer.toJson<String?>(atualizouEstoque),
      'numeroDocumentoEntrada': serializer.toJson<String?>(numeroDocumentoEntrada),
    };
  }

  CompraPedidoCabecalho copyWith(
        {
		  int? id,
          int? idColaborador,
          int? idFornecedor,
          DateTime? dataPedido,
          DateTime? dataPrevisaoEntrega,
          DateTime? dataPrevisaoPagamento,
          String? localEntrega,
          String? localCobranca,
          String? contato,
          double? valorSubtotal,
          double? taxaDesconto,
          double? valorDesconto,
          double? valorTotal,
          String? formaPagamento,
          String? geraFinanceiro,
          int? quantidadeParcelas,
          DateTime? diaPrimeiroVencimento,
          int? intervaloEntreParcelas,
          String? diaFixoParcela,
          DateTime? dataRecebimentoItens,
          String? horaRecebimentoItens,
          String? atualizouEstoque,
          String? numeroDocumentoEntrada,
		}) =>
      CompraPedidoCabecalho(
        id: id ?? this.id,
        idColaborador: idColaborador ?? this.idColaborador,
        idFornecedor: idFornecedor ?? this.idFornecedor,
        dataPedido: dataPedido ?? this.dataPedido,
        dataPrevisaoEntrega: dataPrevisaoEntrega ?? this.dataPrevisaoEntrega,
        dataPrevisaoPagamento: dataPrevisaoPagamento ?? this.dataPrevisaoPagamento,
        localEntrega: localEntrega ?? this.localEntrega,
        localCobranca: localCobranca ?? this.localCobranca,
        contato: contato ?? this.contato,
        valorSubtotal: valorSubtotal ?? this.valorSubtotal,
        taxaDesconto: taxaDesconto ?? this.taxaDesconto,
        valorDesconto: valorDesconto ?? this.valorDesconto,
        valorTotal: valorTotal ?? this.valorTotal,
        formaPagamento: formaPagamento ?? this.formaPagamento,
        geraFinanceiro: geraFinanceiro ?? this.geraFinanceiro,
        quantidadeParcelas: quantidadeParcelas ?? this.quantidadeParcelas,
        diaPrimeiroVencimento: diaPrimeiroVencimento ?? this.diaPrimeiroVencimento,
        intervaloEntreParcelas: intervaloEntreParcelas ?? this.intervaloEntreParcelas,
        diaFixoParcela: diaFixoParcela ?? this.diaFixoParcela,
        dataRecebimentoItens: dataRecebimentoItens ?? this.dataRecebimentoItens,
        horaRecebimentoItens: horaRecebimentoItens ?? this.horaRecebimentoItens,
        atualizouEstoque: atualizouEstoque ?? this.atualizouEstoque,
        numeroDocumentoEntrada: numeroDocumentoEntrada ?? this.numeroDocumentoEntrada,
      );
  
  @override
  String toString() {
    return (StringBuffer('CompraPedidoCabecalho(')
          ..write('id: $id, ')
          ..write('idColaborador: $idColaborador, ')
          ..write('idFornecedor: $idFornecedor, ')
          ..write('dataPedido: $dataPedido, ')
          ..write('dataPrevisaoEntrega: $dataPrevisaoEntrega, ')
          ..write('dataPrevisaoPagamento: $dataPrevisaoPagamento, ')
          ..write('localEntrega: $localEntrega, ')
          ..write('localCobranca: $localCobranca, ')
          ..write('contato: $contato, ')
          ..write('valorSubtotal: $valorSubtotal, ')
          ..write('taxaDesconto: $taxaDesconto, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('formaPagamento: $formaPagamento, ')
          ..write('geraFinanceiro: $geraFinanceiro, ')
          ..write('quantidadeParcelas: $quantidadeParcelas, ')
          ..write('diaPrimeiroVencimento: $diaPrimeiroVencimento, ')
          ..write('intervaloEntreParcelas: $intervaloEntreParcelas, ')
          ..write('diaFixoParcela: $diaFixoParcela, ')
          ..write('dataRecebimentoItens: $dataRecebimentoItens, ')
          ..write('horaRecebimentoItens: $horaRecebimentoItens, ')
          ..write('atualizouEstoque: $atualizouEstoque, ')
          ..write('numeroDocumentoEntrada: $numeroDocumentoEntrada, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idColaborador,
      idFornecedor,
      dataPedido,
      dataPrevisaoEntrega,
      dataPrevisaoPagamento,
      localEntrega,
      localCobranca,
      contato,
      valorSubtotal,
      taxaDesconto,
      valorDesconto,
      valorTotal,
      formaPagamento,
      geraFinanceiro,
      quantidadeParcelas,
      diaPrimeiroVencimento,
      intervaloEntreParcelas,
      diaFixoParcela,
      dataRecebimentoItens,
      horaRecebimentoItens,
      atualizouEstoque,
      numeroDocumentoEntrada,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompraPedidoCabecalho &&
          other.id == id &&
          other.idColaborador == idColaborador &&
          other.idFornecedor == idFornecedor &&
          other.dataPedido == dataPedido &&
          other.dataPrevisaoEntrega == dataPrevisaoEntrega &&
          other.dataPrevisaoPagamento == dataPrevisaoPagamento &&
          other.localEntrega == localEntrega &&
          other.localCobranca == localCobranca &&
          other.contato == contato &&
          other.valorSubtotal == valorSubtotal &&
          other.taxaDesconto == taxaDesconto &&
          other.valorDesconto == valorDesconto &&
          other.valorTotal == valorTotal &&
          other.formaPagamento == formaPagamento &&
          other.geraFinanceiro == geraFinanceiro &&
          other.quantidadeParcelas == quantidadeParcelas &&
          other.diaPrimeiroVencimento == diaPrimeiroVencimento &&
          other.intervaloEntreParcelas == intervaloEntreParcelas &&
          other.diaFixoParcela == diaFixoParcela &&
          other.dataRecebimentoItens == dataRecebimentoItens &&
          other.horaRecebimentoItens == horaRecebimentoItens &&
          other.atualizouEstoque == atualizouEstoque &&
          other.numeroDocumentoEntrada == numeroDocumentoEntrada 
	   );
}

class CompraPedidoCabecalhosCompanion extends UpdateCompanion<CompraPedidoCabecalho> {

  final Value<int?> id;
  final Value<int?> idColaborador;
  final Value<int?> idFornecedor;
  final Value<DateTime?> dataPedido;
  final Value<DateTime?> dataPrevisaoEntrega;
  final Value<DateTime?> dataPrevisaoPagamento;
  final Value<String?> localEntrega;
  final Value<String?> localCobranca;
  final Value<String?> contato;
  final Value<double?> valorSubtotal;
  final Value<double?> taxaDesconto;
  final Value<double?> valorDesconto;
  final Value<double?> valorTotal;
  final Value<String?> formaPagamento;
  final Value<String?> geraFinanceiro;
  final Value<int?> quantidadeParcelas;
  final Value<DateTime?> diaPrimeiroVencimento;
  final Value<int?> intervaloEntreParcelas;
  final Value<String?> diaFixoParcela;
  final Value<DateTime?> dataRecebimentoItens;
  final Value<String?> horaRecebimentoItens;
  final Value<String?> atualizouEstoque;
  final Value<String?> numeroDocumentoEntrada;

  const CompraPedidoCabecalhosCompanion({
    this.id = const Value.absent(),
    this.idColaborador = const Value.absent(),
    this.idFornecedor = const Value.absent(),
    this.dataPedido = const Value.absent(),
    this.dataPrevisaoEntrega = const Value.absent(),
    this.dataPrevisaoPagamento = const Value.absent(),
    this.localEntrega = const Value.absent(),
    this.localCobranca = const Value.absent(),
    this.contato = const Value.absent(),
    this.valorSubtotal = const Value.absent(),
    this.taxaDesconto = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.formaPagamento = const Value.absent(),
    this.geraFinanceiro = const Value.absent(),
    this.quantidadeParcelas = const Value.absent(),
    this.diaPrimeiroVencimento = const Value.absent(),
    this.intervaloEntreParcelas = const Value.absent(),
    this.diaFixoParcela = const Value.absent(),
    this.dataRecebimentoItens = const Value.absent(),
    this.horaRecebimentoItens = const Value.absent(),
    this.atualizouEstoque = const Value.absent(),
    this.numeroDocumentoEntrada = const Value.absent(),
  });

  CompraPedidoCabecalhosCompanion.insert({
    this.id = const Value.absent(),
    this.idColaborador = const Value.absent(),
    this.idFornecedor = const Value.absent(),
    this.dataPedido = const Value.absent(),
    this.dataPrevisaoEntrega = const Value.absent(),
    this.dataPrevisaoPagamento = const Value.absent(),
    this.localEntrega = const Value.absent(),
    this.localCobranca = const Value.absent(),
    this.contato = const Value.absent(),
    this.valorSubtotal = const Value.absent(),
    this.taxaDesconto = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.formaPagamento = const Value.absent(),
    this.geraFinanceiro = const Value.absent(),
    this.quantidadeParcelas = const Value.absent(),
    this.diaPrimeiroVencimento = const Value.absent(),
    this.intervaloEntreParcelas = const Value.absent(),
    this.diaFixoParcela = const Value.absent(),
    this.dataRecebimentoItens = const Value.absent(),
    this.horaRecebimentoItens = const Value.absent(),
    this.atualizouEstoque = const Value.absent(),
    this.numeroDocumentoEntrada = const Value.absent(),
  });

  static Insertable<CompraPedidoCabecalho> custom({
    Expression<int>? id,
    Expression<int>? idColaborador,
    Expression<int>? idFornecedor,
    Expression<DateTime>? dataPedido,
    Expression<DateTime>? dataPrevisaoEntrega,
    Expression<DateTime>? dataPrevisaoPagamento,
    Expression<String>? localEntrega,
    Expression<String>? localCobranca,
    Expression<String>? contato,
    Expression<double>? valorSubtotal,
    Expression<double>? taxaDesconto,
    Expression<double>? valorDesconto,
    Expression<double>? valorTotal,
    Expression<String>? formaPagamento,
    Expression<String>? geraFinanceiro,
    Expression<int>? quantidadeParcelas,
    Expression<DateTime>? diaPrimeiroVencimento,
    Expression<int>? intervaloEntreParcelas,
    Expression<String>? diaFixoParcela,
    Expression<DateTime>? dataRecebimentoItens,
    Expression<String>? horaRecebimentoItens,
    Expression<String>? atualizouEstoque,
    Expression<String>? numeroDocumentoEntrada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idColaborador != null) 'ID_COLABORADOR': idColaborador,
      if (idFornecedor != null) 'ID_FORNECEDOR': idFornecedor,
      if (dataPedido != null) 'DATA_PEDIDO': dataPedido,
      if (dataPrevisaoEntrega != null) 'DATA_PREVISAO_ENTREGA': dataPrevisaoEntrega,
      if (dataPrevisaoPagamento != null) 'DATA_PREVISAO_PAGAMENTO': dataPrevisaoPagamento,
      if (localEntrega != null) 'LOCAL_ENTREGA': localEntrega,
      if (localCobranca != null) 'LOCAL_COBRANCA': localCobranca,
      if (contato != null) 'CONTATO': contato,
      if (valorSubtotal != null) 'VALOR_SUBTOTAL': valorSubtotal,
      if (taxaDesconto != null) 'TAXA_DESCONTO': taxaDesconto,
      if (valorDesconto != null) 'VALOR_DESCONTO': valorDesconto,
      if (valorTotal != null) 'VALOR_TOTAL': valorTotal,
      if (formaPagamento != null) 'FORMA_PAGAMENTO': formaPagamento,
      if (geraFinanceiro != null) 'GERA_FINANCEIRO': geraFinanceiro,
      if (quantidadeParcelas != null) 'QUANTIDADE_PARCELAS': quantidadeParcelas,
      if (diaPrimeiroVencimento != null) 'DIA_PRIMEIRO_VENCIMENTO': diaPrimeiroVencimento,
      if (intervaloEntreParcelas != null) 'INTERVALO_ENTRE_PARCELAS': intervaloEntreParcelas,
      if (diaFixoParcela != null) 'DIA_FIXO_PARCELA': diaFixoParcela,
      if (dataRecebimentoItens != null) 'DATA_RECEBIMENTO_ITENS': dataRecebimentoItens,
      if (horaRecebimentoItens != null) 'HORA_RECEBIMENTO_ITENS': horaRecebimentoItens,
      if (atualizouEstoque != null) 'ATUALIZOU_ESTOQUE': atualizouEstoque,
      if (numeroDocumentoEntrada != null) 'NUMERO_DOCUMENTO_ENTRADA': numeroDocumentoEntrada,
    });
  }

  CompraPedidoCabecalhosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idColaborador,
      Value<int>? idFornecedor,
      Value<DateTime>? dataPedido,
      Value<DateTime>? dataPrevisaoEntrega,
      Value<DateTime>? dataPrevisaoPagamento,
      Value<String>? localEntrega,
      Value<String>? localCobranca,
      Value<String>? contato,
      Value<double>? valorSubtotal,
      Value<double>? taxaDesconto,
      Value<double>? valorDesconto,
      Value<double>? valorTotal,
      Value<String>? formaPagamento,
      Value<String>? geraFinanceiro,
      Value<int>? quantidadeParcelas,
      Value<DateTime>? diaPrimeiroVencimento,
      Value<int>? intervaloEntreParcelas,
      Value<String>? diaFixoParcela,
      Value<DateTime>? dataRecebimentoItens,
      Value<String>? horaRecebimentoItens,
      Value<String>? atualizouEstoque,
      Value<String>? numeroDocumentoEntrada,
	  }) {
    return CompraPedidoCabecalhosCompanion(
      id: id ?? this.id,
      idColaborador: idColaborador ?? this.idColaborador,
      idFornecedor: idFornecedor ?? this.idFornecedor,
      dataPedido: dataPedido ?? this.dataPedido,
      dataPrevisaoEntrega: dataPrevisaoEntrega ?? this.dataPrevisaoEntrega,
      dataPrevisaoPagamento: dataPrevisaoPagamento ?? this.dataPrevisaoPagamento,
      localEntrega: localEntrega ?? this.localEntrega,
      localCobranca: localCobranca ?? this.localCobranca,
      contato: contato ?? this.contato,
      valorSubtotal: valorSubtotal ?? this.valorSubtotal,
      taxaDesconto: taxaDesconto ?? this.taxaDesconto,
      valorDesconto: valorDesconto ?? this.valorDesconto,
      valorTotal: valorTotal ?? this.valorTotal,
      formaPagamento: formaPagamento ?? this.formaPagamento,
      geraFinanceiro: geraFinanceiro ?? this.geraFinanceiro,
      quantidadeParcelas: quantidadeParcelas ?? this.quantidadeParcelas,
      diaPrimeiroVencimento: diaPrimeiroVencimento ?? this.diaPrimeiroVencimento,
      intervaloEntreParcelas: intervaloEntreParcelas ?? this.intervaloEntreParcelas,
      diaFixoParcela: diaFixoParcela ?? this.diaFixoParcela,
      dataRecebimentoItens: dataRecebimentoItens ?? this.dataRecebimentoItens,
      horaRecebimentoItens: horaRecebimentoItens ?? this.horaRecebimentoItens,
      atualizouEstoque: atualizouEstoque ?? this.atualizouEstoque,
      numeroDocumentoEntrada: numeroDocumentoEntrada ?? this.numeroDocumentoEntrada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idColaborador.present) {
      map['ID_COLABORADOR'] = Variable<int?>(idColaborador.value);
    }
    if (idFornecedor.present) {
      map['ID_FORNECEDOR'] = Variable<int?>(idFornecedor.value);
    }
    if (dataPedido.present) {
      map['DATA_PEDIDO'] = Variable<DateTime?>(dataPedido.value);
    }
    if (dataPrevisaoEntrega.present) {
      map['DATA_PREVISAO_ENTREGA'] = Variable<DateTime?>(dataPrevisaoEntrega.value);
    }
    if (dataPrevisaoPagamento.present) {
      map['DATA_PREVISAO_PAGAMENTO'] = Variable<DateTime?>(dataPrevisaoPagamento.value);
    }
    if (localEntrega.present) {
      map['LOCAL_ENTREGA'] = Variable<String?>(localEntrega.value);
    }
    if (localCobranca.present) {
      map['LOCAL_COBRANCA'] = Variable<String?>(localCobranca.value);
    }
    if (contato.present) {
      map['CONTATO'] = Variable<String?>(contato.value);
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
    if (formaPagamento.present) {
      map['FORMA_PAGAMENTO'] = Variable<String?>(formaPagamento.value);
    }
    if (geraFinanceiro.present) {
      map['GERA_FINANCEIRO'] = Variable<String?>(geraFinanceiro.value);
    }
    if (quantidadeParcelas.present) {
      map['QUANTIDADE_PARCELAS'] = Variable<int?>(quantidadeParcelas.value);
    }
    if (diaPrimeiroVencimento.present) {
      map['DIA_PRIMEIRO_VENCIMENTO'] = Variable<DateTime?>(diaPrimeiroVencimento.value);
    }
    if (intervaloEntreParcelas.present) {
      map['INTERVALO_ENTRE_PARCELAS'] = Variable<int?>(intervaloEntreParcelas.value);
    }
    if (diaFixoParcela.present) {
      map['DIA_FIXO_PARCELA'] = Variable<String?>(diaFixoParcela.value);
    }
    if (dataRecebimentoItens.present) {
      map['DATA_RECEBIMENTO_ITENS'] = Variable<DateTime?>(dataRecebimentoItens.value);
    }
    if (horaRecebimentoItens.present) {
      map['HORA_RECEBIMENTO_ITENS'] = Variable<String?>(horaRecebimentoItens.value);
    }
    if (atualizouEstoque.present) {
      map['ATUALIZOU_ESTOQUE'] = Variable<String?>(atualizouEstoque.value);
    }
    if (numeroDocumentoEntrada.present) {
      map['NUMERO_DOCUMENTO_ENTRADA'] = Variable<String?>(numeroDocumentoEntrada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompraPedidoCabecalhosCompanion(')
          ..write('id: $id, ')
          ..write('idColaborador: $idColaborador, ')
          ..write('idFornecedor: $idFornecedor, ')
          ..write('dataPedido: $dataPedido, ')
          ..write('dataPrevisaoEntrega: $dataPrevisaoEntrega, ')
          ..write('dataPrevisaoPagamento: $dataPrevisaoPagamento, ')
          ..write('localEntrega: $localEntrega, ')
          ..write('localCobranca: $localCobranca, ')
          ..write('contato: $contato, ')
          ..write('valorSubtotal: $valorSubtotal, ')
          ..write('taxaDesconto: $taxaDesconto, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('formaPagamento: $formaPagamento, ')
          ..write('geraFinanceiro: $geraFinanceiro, ')
          ..write('quantidadeParcelas: $quantidadeParcelas, ')
          ..write('diaPrimeiroVencimento: $diaPrimeiroVencimento, ')
          ..write('intervaloEntreParcelas: $intervaloEntreParcelas, ')
          ..write('diaFixoParcela: $diaFixoParcela, ')
          ..write('dataRecebimentoItens: $dataRecebimentoItens, ')
          ..write('horaRecebimentoItens: $horaRecebimentoItens, ')
          ..write('atualizouEstoque: $atualizouEstoque, ')
          ..write('numeroDocumentoEntrada: $numeroDocumentoEntrada, ')
          ..write(')'))
        .toString();
  }
}

class $CompraPedidoCabecalhosTable extends CompraPedidoCabecalhos
    with TableInfo<$CompraPedidoCabecalhosTable, CompraPedidoCabecalho> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CompraPedidoCabecalhosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idColaboradorMeta =
      const VerificationMeta('idColaborador');
  GeneratedColumn<int>? _idColaborador;
  @override
  GeneratedColumn<int> get idColaborador =>
      _idColaborador ??= GeneratedColumn<int>('ID_COLABORADOR', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES COLABORADOR(ID)');
  final VerificationMeta _idFornecedorMeta =
      const VerificationMeta('idFornecedor');
  GeneratedColumn<int>? _idFornecedor;
  @override
  GeneratedColumn<int> get idFornecedor =>
      _idFornecedor ??= GeneratedColumn<int>('ID_FORNECEDOR', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES FORNECEDOR(ID)');
  final VerificationMeta _dataPedidoMeta =
      const VerificationMeta('dataPedido');
  GeneratedColumn<DateTime>? _dataPedido;
  @override
  GeneratedColumn<DateTime> get dataPedido => _dataPedido ??=
      GeneratedColumn<DateTime>('DATA_PEDIDO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dataPrevisaoEntregaMeta =
      const VerificationMeta('dataPrevisaoEntrega');
  GeneratedColumn<DateTime>? _dataPrevisaoEntrega;
  @override
  GeneratedColumn<DateTime> get dataPrevisaoEntrega => _dataPrevisaoEntrega ??=
      GeneratedColumn<DateTime>('DATA_PREVISAO_ENTREGA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dataPrevisaoPagamentoMeta =
      const VerificationMeta('dataPrevisaoPagamento');
  GeneratedColumn<DateTime>? _dataPrevisaoPagamento;
  @override
  GeneratedColumn<DateTime> get dataPrevisaoPagamento => _dataPrevisaoPagamento ??=
      GeneratedColumn<DateTime>('DATA_PREVISAO_PAGAMENTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _localEntregaMeta =
      const VerificationMeta('localEntrega');
  GeneratedColumn<String>? _localEntrega;
  @override
  GeneratedColumn<String> get localEntrega => _localEntrega ??=
      GeneratedColumn<String>('LOCAL_ENTREGA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _localCobrancaMeta =
      const VerificationMeta('localCobranca');
  GeneratedColumn<String>? _localCobranca;
  @override
  GeneratedColumn<String> get localCobranca => _localCobranca ??=
      GeneratedColumn<String>('LOCAL_COBRANCA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _contatoMeta =
      const VerificationMeta('contato');
  GeneratedColumn<String>? _contato;
  @override
  GeneratedColumn<String> get contato => _contato ??=
      GeneratedColumn<String>('CONTATO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
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
  final VerificationMeta _formaPagamentoMeta =
      const VerificationMeta('formaPagamento');
  GeneratedColumn<String>? _formaPagamento;
  @override
  GeneratedColumn<String> get formaPagamento => _formaPagamento ??=
      GeneratedColumn<String>('FORMA_PAGAMENTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _geraFinanceiroMeta =
      const VerificationMeta('geraFinanceiro');
  GeneratedColumn<String>? _geraFinanceiro;
  @override
  GeneratedColumn<String> get geraFinanceiro => _geraFinanceiro ??=
      GeneratedColumn<String>('GERA_FINANCEIRO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _quantidadeParcelasMeta =
      const VerificationMeta('quantidadeParcelas');
  GeneratedColumn<int>? _quantidadeParcelas;
  @override
  GeneratedColumn<int> get quantidadeParcelas => _quantidadeParcelas ??=
      GeneratedColumn<int>('QUANTIDADE_PARCELAS', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _diaPrimeiroVencimentoMeta =
      const VerificationMeta('diaPrimeiroVencimento');
  GeneratedColumn<DateTime>? _diaPrimeiroVencimento;
  @override
  GeneratedColumn<DateTime> get diaPrimeiroVencimento => _diaPrimeiroVencimento ??=
      GeneratedColumn<DateTime>('DIA_PRIMEIRO_VENCIMENTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _intervaloEntreParcelasMeta =
      const VerificationMeta('intervaloEntreParcelas');
  GeneratedColumn<int>? _intervaloEntreParcelas;
  @override
  GeneratedColumn<int> get intervaloEntreParcelas => _intervaloEntreParcelas ??=
      GeneratedColumn<int>('INTERVALO_ENTRE_PARCELAS', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _diaFixoParcelaMeta =
      const VerificationMeta('diaFixoParcela');
  GeneratedColumn<String>? _diaFixoParcela;
  @override
  GeneratedColumn<String> get diaFixoParcela => _diaFixoParcela ??=
      GeneratedColumn<String>('DIA_FIXO_PARCELA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dataRecebimentoItensMeta =
      const VerificationMeta('dataRecebimentoItens');
  GeneratedColumn<DateTime>? _dataRecebimentoItens;
  @override
  GeneratedColumn<DateTime> get dataRecebimentoItens => _dataRecebimentoItens ??=
      GeneratedColumn<DateTime>('DATA_RECEBIMENTO_ITENS', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaRecebimentoItensMeta =
      const VerificationMeta('horaRecebimentoItens');
  GeneratedColumn<String>? _horaRecebimentoItens;
  @override
  GeneratedColumn<String> get horaRecebimentoItens => _horaRecebimentoItens ??=
      GeneratedColumn<String>('HORA_RECEBIMENTO_ITENS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _atualizouEstoqueMeta =
      const VerificationMeta('atualizouEstoque');
  GeneratedColumn<String>? _atualizouEstoque;
  @override
  GeneratedColumn<String> get atualizouEstoque => _atualizouEstoque ??=
      GeneratedColumn<String>('ATUALIZOU_ESTOQUE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroDocumentoEntradaMeta =
      const VerificationMeta('numeroDocumentoEntrada');
  GeneratedColumn<String>? _numeroDocumentoEntrada;
  @override
  GeneratedColumn<String> get numeroDocumentoEntrada => _numeroDocumentoEntrada ??=
      GeneratedColumn<String>('NUMERO_DOCUMENTO_ENTRADA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idColaborador,
        idFornecedor,
        dataPedido,
        dataPrevisaoEntrega,
        dataPrevisaoPagamento,
        localEntrega,
        localCobranca,
        contato,
        valorSubtotal,
        taxaDesconto,
        valorDesconto,
        valorTotal,
        formaPagamento,
        geraFinanceiro,
        quantidadeParcelas,
        diaPrimeiroVencimento,
        intervaloEntreParcelas,
        diaFixoParcela,
        dataRecebimentoItens,
        horaRecebimentoItens,
        atualizouEstoque,
        numeroDocumentoEntrada,
      ];

  @override
  String get aliasedName => _alias ?? 'COMPRA_PEDIDO_CABECALHO';
  
  @override
  String get actualTableName => 'COMPRA_PEDIDO_CABECALHO';
  
  @override
  VerificationContext validateIntegrity(Insertable<CompraPedidoCabecalho> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_COLABORADOR')) {
        context.handle(_idColaboradorMeta,
            idColaborador.isAcceptableOrUnknown(data['ID_COLABORADOR']!, _idColaboradorMeta));
    }
    if (data.containsKey('ID_FORNECEDOR')) {
        context.handle(_idFornecedorMeta,
            idFornecedor.isAcceptableOrUnknown(data['ID_FORNECEDOR']!, _idFornecedorMeta));
    }
    if (data.containsKey('DATA_PEDIDO')) {
        context.handle(_dataPedidoMeta,
            dataPedido.isAcceptableOrUnknown(data['DATA_PEDIDO']!, _dataPedidoMeta));
    }
    if (data.containsKey('DATA_PREVISAO_ENTREGA')) {
        context.handle(_dataPrevisaoEntregaMeta,
            dataPrevisaoEntrega.isAcceptableOrUnknown(data['DATA_PREVISAO_ENTREGA']!, _dataPrevisaoEntregaMeta));
    }
    if (data.containsKey('DATA_PREVISAO_PAGAMENTO')) {
        context.handle(_dataPrevisaoPagamentoMeta,
            dataPrevisaoPagamento.isAcceptableOrUnknown(data['DATA_PREVISAO_PAGAMENTO']!, _dataPrevisaoPagamentoMeta));
    }
    if (data.containsKey('LOCAL_ENTREGA')) {
        context.handle(_localEntregaMeta,
            localEntrega.isAcceptableOrUnknown(data['LOCAL_ENTREGA']!, _localEntregaMeta));
    }
    if (data.containsKey('LOCAL_COBRANCA')) {
        context.handle(_localCobrancaMeta,
            localCobranca.isAcceptableOrUnknown(data['LOCAL_COBRANCA']!, _localCobrancaMeta));
    }
    if (data.containsKey('CONTATO')) {
        context.handle(_contatoMeta,
            contato.isAcceptableOrUnknown(data['CONTATO']!, _contatoMeta));
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
    if (data.containsKey('FORMA_PAGAMENTO')) {
        context.handle(_formaPagamentoMeta,
            formaPagamento.isAcceptableOrUnknown(data['FORMA_PAGAMENTO']!, _formaPagamentoMeta));
    }
    if (data.containsKey('GERA_FINANCEIRO')) {
        context.handle(_geraFinanceiroMeta,
            geraFinanceiro.isAcceptableOrUnknown(data['GERA_FINANCEIRO']!, _geraFinanceiroMeta));
    }
    if (data.containsKey('QUANTIDADE_PARCELAS')) {
        context.handle(_quantidadeParcelasMeta,
            quantidadeParcelas.isAcceptableOrUnknown(data['QUANTIDADE_PARCELAS']!, _quantidadeParcelasMeta));
    }
    if (data.containsKey('DIA_PRIMEIRO_VENCIMENTO')) {
        context.handle(_diaPrimeiroVencimentoMeta,
            diaPrimeiroVencimento.isAcceptableOrUnknown(data['DIA_PRIMEIRO_VENCIMENTO']!, _diaPrimeiroVencimentoMeta));
    }
    if (data.containsKey('INTERVALO_ENTRE_PARCELAS')) {
        context.handle(_intervaloEntreParcelasMeta,
            intervaloEntreParcelas.isAcceptableOrUnknown(data['INTERVALO_ENTRE_PARCELAS']!, _intervaloEntreParcelasMeta));
    }
    if (data.containsKey('DIA_FIXO_PARCELA')) {
        context.handle(_diaFixoParcelaMeta,
            diaFixoParcela.isAcceptableOrUnknown(data['DIA_FIXO_PARCELA']!, _diaFixoParcelaMeta));
    }
    if (data.containsKey('DATA_RECEBIMENTO_ITENS')) {
        context.handle(_dataRecebimentoItensMeta,
            dataRecebimentoItens.isAcceptableOrUnknown(data['DATA_RECEBIMENTO_ITENS']!, _dataRecebimentoItensMeta));
    }
    if (data.containsKey('HORA_RECEBIMENTO_ITENS')) {
        context.handle(_horaRecebimentoItensMeta,
            horaRecebimentoItens.isAcceptableOrUnknown(data['HORA_RECEBIMENTO_ITENS']!, _horaRecebimentoItensMeta));
    }
    if (data.containsKey('ATUALIZOU_ESTOQUE')) {
        context.handle(_atualizouEstoqueMeta,
            atualizouEstoque.isAcceptableOrUnknown(data['ATUALIZOU_ESTOQUE']!, _atualizouEstoqueMeta));
    }
    if (data.containsKey('NUMERO_DOCUMENTO_ENTRADA')) {
        context.handle(_numeroDocumentoEntradaMeta,
            numeroDocumentoEntrada.isAcceptableOrUnknown(data['NUMERO_DOCUMENTO_ENTRADA']!, _numeroDocumentoEntradaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompraPedidoCabecalho map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CompraPedidoCabecalho.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CompraPedidoCabecalhosTable createAlias(String alias) {
    return $CompraPedidoCabecalhosTable(_db, alias);
  }
}