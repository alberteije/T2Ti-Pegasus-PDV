/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFCE_PLANO_PAGAMENTO] 
                                                                                
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

@DataClassName("NfcePlanoPagamento")
@UseRowClass(NfcePlanoPagamento)
class NfcePlanoPagamentos extends Table {
  @override
  String get tableName => 'NFCE_PLANO_PAGAMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  DateTimeColumn get dataSolicitacao => dateTime().named('DATA_SOLICITACAO').nullable()();
  DateTimeColumn get dataPagamento => dateTime().named('DATA_PAGAMENTO').nullable()();
  TextColumn get tipoPlano => text().named('TIPO_PLANO').withLength(min: 0, max: 1).nullable()();//M-MENSAL - S-SEMESTRAL - A-ANUAL
  RealColumn get valor => real().named('VALOR').nullable()();
  /*  statusPagamento
  1 	Aguardando pagamento: o comprador iniciou a transação, mas até o momento o PagSeguro não recebeu nenhuma informação sobre o pagamento.
  2 	Em análise: o comprador optou por pagar com um cartão de crédito e o PagSeguro está analisando o risco da transação.
  3 	Paga: a transação foi paga pelo comprador e o PagSeguro já recebeu uma confirmação da instituição financeira responsável pelo processamento.
  4 	Disponível: a transação foi paga e chegou ao final de seu prazo de liberação sem ter sido retornada e sem que haja nenhuma disputa aberta.
  5 	Em disputa: o comprador, dentro do prazo de liberação da transação, abriu uma disputa.
  6 	Devolvida: o valor da transação foi devolvido para o comprador.
  7 	Cancelada: a transação foi cancelada sem ter sido finalizada.
  8 	Debitado: o valor da transação foi devolvido para o comprador.
  9 	Retenção temporária: o comprador contestou o pagamento junto à operadora do cartão de crédito ou abriu uma demanda judicial ou administrativa (Procon). 
  */
  TextColumn get statusPagamento => text().named('STATUS_PAGAMENTO').withLength(min: 0, max: 1).nullable()();
  TextColumn get codigoTransacao => text().named('CODIGO_TRANSACAO').withLength(min: 0, max: 100).nullable()();
  /*  metodoPagamento
  1 	Cartão de crédito: o comprador escolheu pagar a transação com cartão de crédito.
  2 	Boleto: o comprador optou por pagar com um boleto bancário.
  3 	Débito online (TEF): o comprador optou por pagar a transação com débito online de algum dos bancos conveniados.
  4 	Saldo PagSeguro: o comprador optou por pagar a transação utilizando o saldo de sua conta PagSeguro.
  5 	Oi Paggo *: o comprador escolheu pagar sua transação através de seu celular Oi.
  7 	Depósito em conta: o comprador optou por fazer um depósito na conta corrente do PagSeguro. Ele precisará ir até uma agência bancária, fazer o depósito, guardar o comprovante e retornar ao PagSeguro para informar os dados do pagamento. A transação será confirmada somente após a finalização deste processo, que pode levar de 2 a 13 dias úteis. 
  */
  TextColumn get metodoPagamento => text().named('METODO_PAGAMENTO').withLength(min: 0, max: 1).nullable()();
  /*  codigoTipoPagamento
  101 	Cartão de crédito Visa.
  102 	Cartão de crédito MasterCard.
  103 	Cartão de crédito American Express.
  104 	Cartão de crédito Diners.
  105 	Cartão de crédito Hipercard.
  106 	Cartão de crédito Aura.
  107 	Cartão de crédito Elo.
  108 	Cartão de crédito PLENOCard. *
  109 	Cartão de crédito PersonalCard.
  110 	Cartão de crédito JCB.
  111 	Cartão de crédito Discover.
  112 	Cartão de crédito BrasilCard.
  113 	Cartão de crédito FORTBRASIL.
  114 	Cartão de crédito CARDBAN. *
  115 	Cartão de crédito VALECARD.
  116 	Cartão de crédito Cabal.
  117 	Cartão de crédito Mais!.
  118 	Cartão de crédito Avista.
  119 	Cartão de crédito GRANDCARD.
  120 	Cartão de crédito Sorocred.
  201 	Boleto Bradesco. *
  202 	Boleto Santander.
  301 	Débito online Bradesco.
  302 	Débito online Itaú.
  303 	Débito online Unibanco. *
  304 	Débito online Banco do Brasil.
  305 	Débito online Banco Real. *
  306 	Débito online Banrisul.
  307 	Débito online HSBC.
  401 	Saldo PagSeguro.
  501 	Oi Paggo. *
  701 	Depósito em conta - Banco do Brasil
  702 	Depósito em conta - HSBC
  */
  TextColumn get codigoTipoPagamento => text().named('CODIGO_TIPO_PAGAMENTO').withLength(min: 0, max: 3).nullable()();
  DateTimeColumn get dataPlanoExpira => dateTime().named('DATA_PLANO_EXPIRA').nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 250).nullable()();
}

class NfcePlanoPagamento extends DataClass implements Insertable<NfcePlanoPagamento> {
  final int? id;
  final DateTime? dataSolicitacao;
  final DateTime? dataPagamento;
  final String? tipoPlano;
  final double? valor;
  final String? statusPagamento;
  final String? codigoTransacao;
  final String? metodoPagamento;
  final String? codigoTipoPagamento;
  final DateTime? dataPlanoExpira;
  final String? hashRegistro;

  NfcePlanoPagamento(
    {
      required this.id,
      this.dataSolicitacao,
      this.dataPagamento,
      this.tipoPlano,
      this.valor,
      this.statusPagamento,
      this.codigoTransacao,
      this.metodoPagamento,
      this.codigoTipoPagamento,
      this.dataPlanoExpira,
      this.hashRegistro,
    }
  );

  factory NfcePlanoPagamento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfcePlanoPagamento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      dataSolicitacao: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_SOLICITACAO']),
      dataPagamento: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_PAGAMENTO']),
      tipoPlano: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_PLANO']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
      statusPagamento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}STATUS_PAGAMENTO']),
      codigoTransacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_TRANSACAO']),
      metodoPagamento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}METODO_PAGAMENTO']),
      codigoTipoPagamento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_TIPO_PAGAMENTO']),
      dataPlanoExpira: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_PLANO_EXPIRA']),
      hashRegistro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HASH_REGISTRO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || dataSolicitacao != null) {
      map['DATA_SOLICITACAO'] = Variable<DateTime?>(dataSolicitacao);
    }
    if (!nullToAbsent || dataPagamento != null) {
      map['DATA_PAGAMENTO'] = Variable<DateTime?>(dataPagamento);
    }
    if (!nullToAbsent || tipoPlano != null) {
      map['TIPO_PLANO'] = Variable<String?>(tipoPlano);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    if (!nullToAbsent || statusPagamento != null) {
      map['STATUS_PAGAMENTO'] = Variable<String?>(statusPagamento);
    }
    if (!nullToAbsent || codigoTransacao != null) {
      map['CODIGO_TRANSACAO'] = Variable<String?>(codigoTransacao);
    }
    if (!nullToAbsent || metodoPagamento != null) {
      map['METODO_PAGAMENTO'] = Variable<String?>(metodoPagamento);
    }
    if (!nullToAbsent || codigoTipoPagamento != null) {
      map['CODIGO_TIPO_PAGAMENTO'] = Variable<String?>(codigoTipoPagamento);
    }
    if (!nullToAbsent || dataPlanoExpira != null) {
      map['DATA_PLANO_EXPIRA'] = Variable<DateTime?>(dataPlanoExpira);
    }
    if (!nullToAbsent || hashRegistro != null) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro);
    }
    return map;
  }

  NfcePlanoPagamentosCompanion toCompanion(bool nullToAbsent) {
    return NfcePlanoPagamentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dataSolicitacao: dataSolicitacao == null && nullToAbsent
        ? const Value.absent()
        : Value(dataSolicitacao),
      dataPagamento: dataPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(dataPagamento),
      tipoPlano: tipoPlano == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoPlano),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
      statusPagamento: statusPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(statusPagamento),
      codigoTransacao: codigoTransacao == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoTransacao),
      metodoPagamento: metodoPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(metodoPagamento),
      codigoTipoPagamento: codigoTipoPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoTipoPagamento),
      dataPlanoExpira: dataPlanoExpira == null && nullToAbsent
        ? const Value.absent()
        : Value(dataPlanoExpira),
      hashRegistro: hashRegistro == null && nullToAbsent
        ? const Value.absent()
        : Value(hashRegistro),
    );
  }

  factory NfcePlanoPagamento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfcePlanoPagamento(
      id: serializer.fromJson<int>(json['id']),
      dataSolicitacao: serializer.fromJson<DateTime>(json['dataSolicitacao']),
      dataPagamento: serializer.fromJson<DateTime>(json['dataPagamento']),
      tipoPlano: serializer.fromJson<String>(json['tipoPlano']),
      valor: serializer.fromJson<double>(json['valor']),
      statusPagamento: serializer.fromJson<String>(json['statusPagamento']),
      codigoTransacao: serializer.fromJson<String>(json['codigoTransacao']),
      metodoPagamento: serializer.fromJson<String>(json['metodoPagamento']),
      codigoTipoPagamento: serializer.fromJson<String>(json['codigoTipoPagamento']),
      dataPlanoExpira: serializer.fromJson<DateTime>(json['dataPlanoExpira']),
      hashRegistro: serializer.fromJson<String>(json['hashRegistro']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'dataSolicitacao': serializer.toJson<DateTime?>(dataSolicitacao),
      'dataPagamento': serializer.toJson<DateTime?>(dataPagamento),
      'tipoPlano': serializer.toJson<String?>(tipoPlano),
      'valor': serializer.toJson<double?>(valor),
      'statusPagamento': serializer.toJson<String?>(statusPagamento),
      'codigoTransacao': serializer.toJson<String?>(codigoTransacao),
      'metodoPagamento': serializer.toJson<String?>(metodoPagamento),
      'codigoTipoPagamento': serializer.toJson<String?>(codigoTipoPagamento),
      'dataPlanoExpira': serializer.toJson<DateTime?>(dataPlanoExpira),
      'hashRegistro': serializer.toJson<String?>(hashRegistro),
    };
  }

  NfcePlanoPagamento copyWith(
        {
		  int? id,
          DateTime? dataSolicitacao,
          DateTime? dataPagamento,
          String? tipoPlano,
          double? valor,
          String? statusPagamento,
          String? codigoTransacao,
          String? metodoPagamento,
          String? codigoTipoPagamento,
          DateTime? dataPlanoExpira,
          String? hashRegistro,
		}) =>
      NfcePlanoPagamento(
        id: id ?? this.id,
        dataSolicitacao: dataSolicitacao ?? this.dataSolicitacao,
        dataPagamento: dataPagamento ?? this.dataPagamento,
        tipoPlano: tipoPlano ?? this.tipoPlano,
        valor: valor ?? this.valor,
        statusPagamento: statusPagamento ?? this.statusPagamento,
        codigoTransacao: codigoTransacao ?? this.codigoTransacao,
        metodoPagamento: metodoPagamento ?? this.metodoPagamento,
        codigoTipoPagamento: codigoTipoPagamento ?? this.codigoTipoPagamento,
        dataPlanoExpira: dataPlanoExpira ?? this.dataPlanoExpira,
        hashRegistro: hashRegistro ?? this.hashRegistro,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfcePlanoPagamento(')
          ..write('id: $id, ')
          ..write('dataSolicitacao: $dataSolicitacao, ')
          ..write('dataPagamento: $dataPagamento, ')
          ..write('tipoPlano: $tipoPlano, ')
          ..write('valor: $valor, ')
          ..write('statusPagamento: $statusPagamento, ')
          ..write('codigoTransacao: $codigoTransacao, ')
          ..write('metodoPagamento: $metodoPagamento, ')
          ..write('codigoTipoPagamento: $codigoTipoPagamento, ')
          ..write('dataPlanoExpira: $dataPlanoExpira, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      dataSolicitacao,
      dataPagamento,
      tipoPlano,
      valor,
      statusPagamento,
      codigoTransacao,
      metodoPagamento,
      codigoTipoPagamento,
      dataPlanoExpira,
      hashRegistro,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfcePlanoPagamento &&
          other.id == id &&
          other.dataSolicitacao == dataSolicitacao &&
          other.dataPagamento == dataPagamento &&
          other.tipoPlano == tipoPlano &&
          other.valor == valor &&
          other.statusPagamento == statusPagamento &&
          other.codigoTransacao == codigoTransacao &&
          other.metodoPagamento == metodoPagamento &&
          other.codigoTipoPagamento == codigoTipoPagamento &&
          other.dataPlanoExpira == dataPlanoExpira &&
          other.hashRegistro == hashRegistro 
	   );
}

class NfcePlanoPagamentosCompanion extends UpdateCompanion<NfcePlanoPagamento> {

  final Value<int?> id;
  final Value<DateTime?> dataSolicitacao;
  final Value<DateTime?> dataPagamento;
  final Value<String?> tipoPlano;
  final Value<double?> valor;
  final Value<String?> statusPagamento;
  final Value<String?> codigoTransacao;
  final Value<String?> metodoPagamento;
  final Value<String?> codigoTipoPagamento;
  final Value<DateTime?> dataPlanoExpira;
  final Value<String?> hashRegistro;

  const NfcePlanoPagamentosCompanion({
    this.id = const Value.absent(),
    this.dataSolicitacao = const Value.absent(),
    this.dataPagamento = const Value.absent(),
    this.tipoPlano = const Value.absent(),
    this.valor = const Value.absent(),
    this.statusPagamento = const Value.absent(),
    this.codigoTransacao = const Value.absent(),
    this.metodoPagamento = const Value.absent(),
    this.codigoTipoPagamento = const Value.absent(),
    this.dataPlanoExpira = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  NfcePlanoPagamentosCompanion.insert({
    this.id = const Value.absent(),
    this.dataSolicitacao = const Value.absent(),
    this.dataPagamento = const Value.absent(),
    this.tipoPlano = const Value.absent(),
    this.valor = const Value.absent(),
    this.statusPagamento = const Value.absent(),
    this.codigoTransacao = const Value.absent(),
    this.metodoPagamento = const Value.absent(),
    this.codigoTipoPagamento = const Value.absent(),
    this.dataPlanoExpira = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  static Insertable<NfcePlanoPagamento> custom({
    Expression<int>? id,
    Expression<DateTime>? dataSolicitacao,
    Expression<DateTime>? dataPagamento,
    Expression<String>? tipoPlano,
    Expression<double>? valor,
    Expression<String>? statusPagamento,
    Expression<String>? codigoTransacao,
    Expression<String>? metodoPagamento,
    Expression<String>? codigoTipoPagamento,
    Expression<DateTime>? dataPlanoExpira,
    Expression<String>? hashRegistro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (dataSolicitacao != null) 'DATA_SOLICITACAO': dataSolicitacao,
      if (dataPagamento != null) 'DATA_PAGAMENTO': dataPagamento,
      if (tipoPlano != null) 'TIPO_PLANO': tipoPlano,
      if (valor != null) 'VALOR': valor,
      if (statusPagamento != null) 'STATUS_PAGAMENTO': statusPagamento,
      if (codigoTransacao != null) 'CODIGO_TRANSACAO': codigoTransacao,
      if (metodoPagamento != null) 'METODO_PAGAMENTO': metodoPagamento,
      if (codigoTipoPagamento != null) 'CODIGO_TIPO_PAGAMENTO': codigoTipoPagamento,
      if (dataPlanoExpira != null) 'DATA_PLANO_EXPIRA': dataPlanoExpira,
      if (hashRegistro != null) 'HASH_REGISTRO': hashRegistro,
    });
  }

  NfcePlanoPagamentosCompanion copyWith(
      {
	  Value<int>? id,
      Value<DateTime>? dataSolicitacao,
      Value<DateTime>? dataPagamento,
      Value<String>? tipoPlano,
      Value<double>? valor,
      Value<String>? statusPagamento,
      Value<String>? codigoTransacao,
      Value<String>? metodoPagamento,
      Value<String>? codigoTipoPagamento,
      Value<DateTime>? dataPlanoExpira,
      Value<String>? hashRegistro,
	  }) {
    return NfcePlanoPagamentosCompanion(
      id: id ?? this.id,
      dataSolicitacao: dataSolicitacao ?? this.dataSolicitacao,
      dataPagamento: dataPagamento ?? this.dataPagamento,
      tipoPlano: tipoPlano ?? this.tipoPlano,
      valor: valor ?? this.valor,
      statusPagamento: statusPagamento ?? this.statusPagamento,
      codigoTransacao: codigoTransacao ?? this.codigoTransacao,
      metodoPagamento: metodoPagamento ?? this.metodoPagamento,
      codigoTipoPagamento: codigoTipoPagamento ?? this.codigoTipoPagamento,
      dataPlanoExpira: dataPlanoExpira ?? this.dataPlanoExpira,
      hashRegistro: hashRegistro ?? this.hashRegistro,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (dataSolicitacao.present) {
      map['DATA_SOLICITACAO'] = Variable<DateTime?>(dataSolicitacao.value);
    }
    if (dataPagamento.present) {
      map['DATA_PAGAMENTO'] = Variable<DateTime?>(dataPagamento.value);
    }
    if (tipoPlano.present) {
      map['TIPO_PLANO'] = Variable<String?>(tipoPlano.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    if (statusPagamento.present) {
      map['STATUS_PAGAMENTO'] = Variable<String?>(statusPagamento.value);
    }
    if (codigoTransacao.present) {
      map['CODIGO_TRANSACAO'] = Variable<String?>(codigoTransacao.value);
    }
    if (metodoPagamento.present) {
      map['METODO_PAGAMENTO'] = Variable<String?>(metodoPagamento.value);
    }
    if (codigoTipoPagamento.present) {
      map['CODIGO_TIPO_PAGAMENTO'] = Variable<String?>(codigoTipoPagamento.value);
    }
    if (dataPlanoExpira.present) {
      map['DATA_PLANO_EXPIRA'] = Variable<DateTime?>(dataPlanoExpira.value);
    }
    if (hashRegistro.present) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfcePlanoPagamentosCompanion(')
          ..write('id: $id, ')
          ..write('dataSolicitacao: $dataSolicitacao, ')
          ..write('dataPagamento: $dataPagamento, ')
          ..write('tipoPlano: $tipoPlano, ')
          ..write('valor: $valor, ')
          ..write('statusPagamento: $statusPagamento, ')
          ..write('codigoTransacao: $codigoTransacao, ')
          ..write('metodoPagamento: $metodoPagamento, ')
          ..write('codigoTipoPagamento: $codigoTipoPagamento, ')
          ..write('dataPlanoExpira: $dataPlanoExpira, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }
}

class $NfcePlanoPagamentosTable extends NfcePlanoPagamentos
    with TableInfo<$NfcePlanoPagamentosTable, NfcePlanoPagamento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfcePlanoPagamentosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _dataSolicitacaoMeta =
      const VerificationMeta('dataSolicitacao');
  GeneratedColumn<DateTime>? _dataSolicitacao;
  @override
  GeneratedColumn<DateTime> get dataSolicitacao => _dataSolicitacao ??=
      GeneratedColumn<DateTime>('DATA_SOLICITACAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _dataPagamentoMeta =
      const VerificationMeta('dataPagamento');
  GeneratedColumn<DateTime>? _dataPagamento;
  @override
  GeneratedColumn<DateTime> get dataPagamento => _dataPagamento ??=
      GeneratedColumn<DateTime>('DATA_PAGAMENTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _tipoPlanoMeta =
      const VerificationMeta('tipoPlano');
  GeneratedColumn<String>? _tipoPlano;
  @override
  GeneratedColumn<String> get tipoPlano => _tipoPlano ??=
      GeneratedColumn<String>('TIPO_PLANO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorMeta =
      const VerificationMeta('valor');
  GeneratedColumn<double>? _valor;
  @override
  GeneratedColumn<double> get valor => _valor ??=
      GeneratedColumn<double>('VALOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _statusPagamentoMeta =
      const VerificationMeta('statusPagamento');
  GeneratedColumn<String>? _statusPagamento;
  @override
  GeneratedColumn<String> get statusPagamento => _statusPagamento ??=
      GeneratedColumn<String>('STATUS_PAGAMENTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoTransacaoMeta =
      const VerificationMeta('codigoTransacao');
  GeneratedColumn<String>? _codigoTransacao;
  @override
  GeneratedColumn<String> get codigoTransacao => _codigoTransacao ??=
      GeneratedColumn<String>('CODIGO_TRANSACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _metodoPagamentoMeta =
      const VerificationMeta('metodoPagamento');
  GeneratedColumn<String>? _metodoPagamento;
  @override
  GeneratedColumn<String> get metodoPagamento => _metodoPagamento ??=
      GeneratedColumn<String>('METODO_PAGAMENTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoTipoPagamentoMeta =
      const VerificationMeta('codigoTipoPagamento');
  GeneratedColumn<String>? _codigoTipoPagamento;
  @override
  GeneratedColumn<String> get codigoTipoPagamento => _codigoTipoPagamento ??=
      GeneratedColumn<String>('CODIGO_TIPO_PAGAMENTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dataPlanoExpiraMeta =
      const VerificationMeta('dataPlanoExpira');
  GeneratedColumn<DateTime>? _dataPlanoExpira;
  @override
  GeneratedColumn<DateTime> get dataPlanoExpira => _dataPlanoExpira ??=
      GeneratedColumn<DateTime>('DATA_PLANO_EXPIRA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
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
        dataSolicitacao,
        dataPagamento,
        tipoPlano,
        valor,
        statusPagamento,
        codigoTransacao,
        metodoPagamento,
        codigoTipoPagamento,
        dataPlanoExpira,
        hashRegistro,
      ];

  @override
  String get aliasedName => _alias ?? 'NFCE_PLANO_PAGAMENTO';
  
  @override
  String get actualTableName => 'NFCE_PLANO_PAGAMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfcePlanoPagamento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('DATA_SOLICITACAO')) {
        context.handle(_dataSolicitacaoMeta,
            dataSolicitacao.isAcceptableOrUnknown(data['DATA_SOLICITACAO']!, _dataSolicitacaoMeta));
    }
    if (data.containsKey('DATA_PAGAMENTO')) {
        context.handle(_dataPagamentoMeta,
            dataPagamento.isAcceptableOrUnknown(data['DATA_PAGAMENTO']!, _dataPagamentoMeta));
    }
    if (data.containsKey('TIPO_PLANO')) {
        context.handle(_tipoPlanoMeta,
            tipoPlano.isAcceptableOrUnknown(data['TIPO_PLANO']!, _tipoPlanoMeta));
    }
    if (data.containsKey('VALOR')) {
        context.handle(_valorMeta,
            valor.isAcceptableOrUnknown(data['VALOR']!, _valorMeta));
    }
    if (data.containsKey('STATUS_PAGAMENTO')) {
        context.handle(_statusPagamentoMeta,
            statusPagamento.isAcceptableOrUnknown(data['STATUS_PAGAMENTO']!, _statusPagamentoMeta));
    }
    if (data.containsKey('CODIGO_TRANSACAO')) {
        context.handle(_codigoTransacaoMeta,
            codigoTransacao.isAcceptableOrUnknown(data['CODIGO_TRANSACAO']!, _codigoTransacaoMeta));
    }
    if (data.containsKey('METODO_PAGAMENTO')) {
        context.handle(_metodoPagamentoMeta,
            metodoPagamento.isAcceptableOrUnknown(data['METODO_PAGAMENTO']!, _metodoPagamentoMeta));
    }
    if (data.containsKey('CODIGO_TIPO_PAGAMENTO')) {
        context.handle(_codigoTipoPagamentoMeta,
            codigoTipoPagamento.isAcceptableOrUnknown(data['CODIGO_TIPO_PAGAMENTO']!, _codigoTipoPagamentoMeta));
    }
    if (data.containsKey('DATA_PLANO_EXPIRA')) {
        context.handle(_dataPlanoExpiraMeta,
            dataPlanoExpira.isAcceptableOrUnknown(data['DATA_PLANO_EXPIRA']!, _dataPlanoExpiraMeta));
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
  NfcePlanoPagamento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfcePlanoPagamento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfcePlanoPagamentosTable createAlias(String alias) {
    return $NfcePlanoPagamentosTable(_db, alias);
  }
}