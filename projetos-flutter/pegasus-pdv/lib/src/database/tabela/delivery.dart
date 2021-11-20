/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [DELIVERY] 
                                                                                
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

@DataClassName("Delivery")
@UseRowClass(Delivery)
class Deliverys extends Table {
  @override
  String get tableName => 'DELIVERY';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idComanda => integer().named('ID_COMANDA').nullable().customConstraint('NULLABLE REFERENCES COMANDA(ID)')();
  IntColumn get idTaxaEntrega => integer().named('ID_TAXA_ENTREGA').nullable().customConstraint('NULLABLE REFERENCES TAXA_ENTREGA(ID)')();
  IntColumn get idColaborador => integer().named('ID_COLABORADOR').nullable().customConstraint('NULLABLE REFERENCES COLABORADOR(ID)')();
  TextColumn get nomeCliente => text().named('NOME_CLIENTE').withLength(min: 0, max: 100).nullable()();
  TextColumn get telefonePrincipal => text().named('TELEFONE_PRINCIPAL').withLength(min: 0, max: 15).nullable()();
  TextColumn get telefoneRecado => text().named('TELEFONE_RECADO').withLength(min: 0, max: 15).nullable()();
  TextColumn get celular => text().named('CELULAR').withLength(min: 0, max: 15).nullable()();
  TextColumn get logradouro => text().named('LOGRADOURO').withLength(min: 0, max: 250).nullable()();
  TextColumn get numero => text().named('NUMERO').withLength(min: 0, max: 10).nullable()();
  TextColumn get complemento => text().named('COMPLEMENTO').withLength(min: 0, max: 100).nullable()();
  TextColumn get cep => text().named('CEP').withLength(min: 0, max: 8).nullable()();
  TextColumn get bairro => text().named('BAIRRO').withLength(min: 0, max: 100).nullable()();
  TextColumn get cidade => text().named('CIDADE').withLength(min: 0, max: 100).nullable()();
  TextColumn get uf => text().named('UF').withLength(min: 0, max: 2).nullable()();
  RealColumn get valorFrete => real().named('VALOR_FRETE').nullable()();
  RealColumn get valorRecebido => real().named('VALOR_RECEBIDO').nullable()();
  RealColumn get valorAReceber => real().named('VALOR_A_RECEBER').nullable()();
  RealColumn get valorSolicitadoTroco => real().named('VALOR_SOLICITADO_TROCO').nullable()();
  DateTimeColumn get previsaoPreparo => dateTime().named('PREVISAO_PREPARO').nullable()();
  DateTimeColumn get inicioPreparo => dateTime().named('INICIO_PREPARO').nullable()();
  DateTimeColumn get previsaoEntrega => dateTime().named('PREVISAO_ENTREGA').nullable()();
  DateTimeColumn get saiuParaEntrega => dateTime().named('SAIU_PARA_ENTREGA').nullable()();
  DateTimeColumn get entregue => dateTime().named('ENTREGUE').nullable()();
  DateTimeColumn get previsaoRetirada => dateTime().named('PREVISAO_RETIRADA').nullable()();
  DateTimeColumn get prontoParaRetirada => dateTime().named('PRONTO_PARA_RETIRADA').nullable()();
  DateTimeColumn get retirou => dateTime().named('RETIROU').nullable()();
}

class Delivery extends DataClass implements Insertable<Delivery> {
  final int? id;
  final int? idComanda;
  final int? idTaxaEntrega;
  final int? idColaborador;
  final String? nomeCliente;
  final String? telefonePrincipal;
  final String? telefoneRecado;
  final String? celular;
  final String? logradouro;
  final String? numero;
  final String? complemento;
  final String? cep;
  final String? bairro;
  final String? cidade;
  final String? uf;
  final double? valorFrete;
  final double? valorRecebido;
  final double? valorAReceber;
  final double? valorSolicitadoTroco;
  final DateTime? previsaoPreparo;
  final DateTime? inicioPreparo;
  final DateTime? previsaoEntrega;
  final DateTime? saiuParaEntrega;
  final DateTime? entregue;
  final DateTime? previsaoRetirada;
  final DateTime? prontoParaRetirada;
  final DateTime? retirou;

  Delivery(
    {
      required this.id,
      this.idComanda,
      this.idTaxaEntrega,
      this.idColaborador,
      this.nomeCliente,
      this.telefonePrincipal,
      this.telefoneRecado,
      this.celular,
      this.logradouro,
      this.numero,
      this.complemento,
      this.cep,
      this.bairro,
      this.cidade,
      this.uf,
      this.valorFrete,
      this.valorRecebido,
      this.valorAReceber,
      this.valorSolicitadoTroco,
      this.previsaoPreparo,
      this.inicioPreparo,
      this.previsaoEntrega,
      this.saiuParaEntrega,
      this.entregue,
      this.previsaoRetirada,
      this.prontoParaRetirada,
      this.retirou,
    }
  );

  factory Delivery.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Delivery(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idComanda: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_COMANDA']),
      idTaxaEntrega: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_TAXA_ENTREGA']),
      idColaborador: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_COLABORADOR']),
      nomeCliente: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME_CLIENTE']),
      telefonePrincipal: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TELEFONE_PRINCIPAL']),
      telefoneRecado: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TELEFONE_RECADO']),
      celular: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CELULAR']),
      logradouro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}LOGRADOURO']),
      numero: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO']),
      complemento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}COMPLEMENTO']),
      cep: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CEP']),
      bairro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}BAIRRO']),
      cidade: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CIDADE']),
      uf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UF']),
      valorFrete: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_FRETE']),
      valorRecebido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_RECEBIDO']),
      valorAReceber: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_A_RECEBER']),
      valorSolicitadoTroco: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_SOLICITADO_TROCO']),
      previsaoPreparo: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}PREVISAO_PREPARO']),
      inicioPreparo: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}INICIO_PREPARO']),
      previsaoEntrega: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}PREVISAO_ENTREGA']),
      saiuParaEntrega: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}SAIU_PARA_ENTREGA']),
      entregue: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}ENTREGUE']),
      previsaoRetirada: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}PREVISAO_RETIRADA']),
      prontoParaRetirada: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}PRONTO_PARA_RETIRADA']),
      retirou: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}RETIROU']),
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
    if (!nullToAbsent || idTaxaEntrega != null) {
      map['ID_TAXA_ENTREGA'] = Variable<int?>(idTaxaEntrega);
    }
    if (!nullToAbsent || idColaborador != null) {
      map['ID_COLABORADOR'] = Variable<int?>(idColaborador);
    }
    if (!nullToAbsent || nomeCliente != null) {
      map['NOME_CLIENTE'] = Variable<String?>(nomeCliente);
    }
    if (!nullToAbsent || telefonePrincipal != null) {
      map['TELEFONE_PRINCIPAL'] = Variable<String?>(telefonePrincipal);
    }
    if (!nullToAbsent || telefoneRecado != null) {
      map['TELEFONE_RECADO'] = Variable<String?>(telefoneRecado);
    }
    if (!nullToAbsent || celular != null) {
      map['CELULAR'] = Variable<String?>(celular);
    }
    if (!nullToAbsent || logradouro != null) {
      map['LOGRADOURO'] = Variable<String?>(logradouro);
    }
    if (!nullToAbsent || numero != null) {
      map['NUMERO'] = Variable<String?>(numero);
    }
    if (!nullToAbsent || complemento != null) {
      map['COMPLEMENTO'] = Variable<String?>(complemento);
    }
    if (!nullToAbsent || cep != null) {
      map['CEP'] = Variable<String?>(cep);
    }
    if (!nullToAbsent || bairro != null) {
      map['BAIRRO'] = Variable<String?>(bairro);
    }
    if (!nullToAbsent || cidade != null) {
      map['CIDADE'] = Variable<String?>(cidade);
    }
    if (!nullToAbsent || uf != null) {
      map['UF'] = Variable<String?>(uf);
    }
    if (!nullToAbsent || valorFrete != null) {
      map['VALOR_FRETE'] = Variable<double?>(valorFrete);
    }
    if (!nullToAbsent || valorRecebido != null) {
      map['VALOR_RECEBIDO'] = Variable<double?>(valorRecebido);
    }
    if (!nullToAbsent || valorAReceber != null) {
      map['VALOR_A_RECEBER'] = Variable<double?>(valorAReceber);
    }
    if (!nullToAbsent || valorSolicitadoTroco != null) {
      map['VALOR_SOLICITADO_TROCO'] = Variable<double?>(valorSolicitadoTroco);
    }
    if (!nullToAbsent || previsaoPreparo != null) {
      map['PREVISAO_PREPARO'] = Variable<DateTime?>(previsaoPreparo);
    }
    if (!nullToAbsent || inicioPreparo != null) {
      map['INICIO_PREPARO'] = Variable<DateTime?>(inicioPreparo);
    }
    if (!nullToAbsent || previsaoEntrega != null) {
      map['PREVISAO_ENTREGA'] = Variable<DateTime?>(previsaoEntrega);
    }
    if (!nullToAbsent || saiuParaEntrega != null) {
      map['SAIU_PARA_ENTREGA'] = Variable<DateTime?>(saiuParaEntrega);
    }
    if (!nullToAbsent || entregue != null) {
      map['ENTREGUE'] = Variable<DateTime?>(entregue);
    }
    if (!nullToAbsent || previsaoRetirada != null) {
      map['PREVISAO_RETIRADA'] = Variable<DateTime?>(previsaoRetirada);
    }
    if (!nullToAbsent || prontoParaRetirada != null) {
      map['PRONTO_PARA_RETIRADA'] = Variable<DateTime?>(prontoParaRetirada);
    }
    if (!nullToAbsent || retirou != null) {
      map['RETIROU'] = Variable<DateTime?>(retirou);
    }
    return map;
  }

  DeliverysCompanion toCompanion(bool nullToAbsent) {
    return DeliverysCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idComanda: idComanda == null && nullToAbsent
        ? const Value.absent()
        : Value(idComanda),
      idTaxaEntrega: idTaxaEntrega == null && nullToAbsent
        ? const Value.absent()
        : Value(idTaxaEntrega),
      idColaborador: idColaborador == null && nullToAbsent
        ? const Value.absent()
        : Value(idColaborador),
      nomeCliente: nomeCliente == null && nullToAbsent
        ? const Value.absent()
        : Value(nomeCliente),
      telefonePrincipal: telefonePrincipal == null && nullToAbsent
        ? const Value.absent()
        : Value(telefonePrincipal),
      telefoneRecado: telefoneRecado == null && nullToAbsent
        ? const Value.absent()
        : Value(telefoneRecado),
      celular: celular == null && nullToAbsent
        ? const Value.absent()
        : Value(celular),
      logradouro: logradouro == null && nullToAbsent
        ? const Value.absent()
        : Value(logradouro),
      numero: numero == null && nullToAbsent
        ? const Value.absent()
        : Value(numero),
      complemento: complemento == null && nullToAbsent
        ? const Value.absent()
        : Value(complemento),
      cep: cep == null && nullToAbsent
        ? const Value.absent()
        : Value(cep),
      bairro: bairro == null && nullToAbsent
        ? const Value.absent()
        : Value(bairro),
      cidade: cidade == null && nullToAbsent
        ? const Value.absent()
        : Value(cidade),
      uf: uf == null && nullToAbsent
        ? const Value.absent()
        : Value(uf),
      valorFrete: valorFrete == null && nullToAbsent
        ? const Value.absent()
        : Value(valorFrete),
      valorRecebido: valorRecebido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorRecebido),
      valorAReceber: valorAReceber == null && nullToAbsent
        ? const Value.absent()
        : Value(valorAReceber),
      valorSolicitadoTroco: valorSolicitadoTroco == null && nullToAbsent
        ? const Value.absent()
        : Value(valorSolicitadoTroco),
      previsaoPreparo: previsaoPreparo == null && nullToAbsent
        ? const Value.absent()
        : Value(previsaoPreparo),
      inicioPreparo: inicioPreparo == null && nullToAbsent
        ? const Value.absent()
        : Value(inicioPreparo),
      previsaoEntrega: previsaoEntrega == null && nullToAbsent
        ? const Value.absent()
        : Value(previsaoEntrega),
      saiuParaEntrega: saiuParaEntrega == null && nullToAbsent
        ? const Value.absent()
        : Value(saiuParaEntrega),
      entregue: entregue == null && nullToAbsent
        ? const Value.absent()
        : Value(entregue),
      previsaoRetirada: previsaoRetirada == null && nullToAbsent
        ? const Value.absent()
        : Value(previsaoRetirada),
      prontoParaRetirada: prontoParaRetirada == null && nullToAbsent
        ? const Value.absent()
        : Value(prontoParaRetirada),
      retirou: retirou == null && nullToAbsent
        ? const Value.absent()
        : Value(retirou),
    );
  }

  factory Delivery.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Delivery(
      id: serializer.fromJson<int>(json['id']),
      idComanda: serializer.fromJson<int>(json['idComanda']),
      idTaxaEntrega: serializer.fromJson<int>(json['idTaxaEntrega']),
      idColaborador: serializer.fromJson<int>(json['idColaborador']),
      nomeCliente: serializer.fromJson<String>(json['nomeCliente']),
      telefonePrincipal: serializer.fromJson<String>(json['telefonePrincipal']),
      telefoneRecado: serializer.fromJson<String>(json['telefoneRecado']),
      celular: serializer.fromJson<String>(json['celular']),
      logradouro: serializer.fromJson<String>(json['logradouro']),
      numero: serializer.fromJson<String>(json['numero']),
      complemento: serializer.fromJson<String>(json['complemento']),
      cep: serializer.fromJson<String>(json['cep']),
      bairro: serializer.fromJson<String>(json['bairro']),
      cidade: serializer.fromJson<String>(json['cidade']),
      uf: serializer.fromJson<String>(json['uf']),
      valorFrete: serializer.fromJson<double>(json['valorFrete']),
      valorRecebido: serializer.fromJson<double>(json['valorRecebido']),
      valorAReceber: serializer.fromJson<double>(json['valorAReceber']),
      valorSolicitadoTroco: serializer.fromJson<double>(json['valorSolicitadoTroco']),
      previsaoPreparo: serializer.fromJson<DateTime>(json['previsaoPreparo']),
      inicioPreparo: serializer.fromJson<DateTime>(json['inicioPreparo']),
      previsaoEntrega: serializer.fromJson<DateTime>(json['previsaoEntrega']),
      saiuParaEntrega: serializer.fromJson<DateTime>(json['saiuParaEntrega']),
      entregue: serializer.fromJson<DateTime>(json['entregue']),
      previsaoRetirada: serializer.fromJson<DateTime>(json['previsaoRetirada']),
      prontoParaRetirada: serializer.fromJson<DateTime>(json['prontoParaRetirada']),
      retirou: serializer.fromJson<DateTime>(json['retirou']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idComanda': serializer.toJson<int?>(idComanda),
      'idTaxaEntrega': serializer.toJson<int?>(idTaxaEntrega),
      'idColaborador': serializer.toJson<int?>(idColaborador),
      'nomeCliente': serializer.toJson<String?>(nomeCliente),
      'telefonePrincipal': serializer.toJson<String?>(telefonePrincipal),
      'telefoneRecado': serializer.toJson<String?>(telefoneRecado),
      'celular': serializer.toJson<String?>(celular),
      'logradouro': serializer.toJson<String?>(logradouro),
      'numero': serializer.toJson<String?>(numero),
      'complemento': serializer.toJson<String?>(complemento),
      'cep': serializer.toJson<String?>(cep),
      'bairro': serializer.toJson<String?>(bairro),
      'cidade': serializer.toJson<String?>(cidade),
      'uf': serializer.toJson<String?>(uf),
      'valorFrete': serializer.toJson<double?>(valorFrete),
      'valorRecebido': serializer.toJson<double?>(valorRecebido),
      'valorAReceber': serializer.toJson<double?>(valorAReceber),
      'valorSolicitadoTroco': serializer.toJson<double?>(valorSolicitadoTroco),
      'previsaoPreparo': serializer.toJson<DateTime?>(previsaoPreparo),
      'inicioPreparo': serializer.toJson<DateTime?>(inicioPreparo),
      'previsaoEntrega': serializer.toJson<DateTime?>(previsaoEntrega),
      'saiuParaEntrega': serializer.toJson<DateTime?>(saiuParaEntrega),
      'entregue': serializer.toJson<DateTime?>(entregue),
      'previsaoRetirada': serializer.toJson<DateTime?>(previsaoRetirada),
      'prontoParaRetirada': serializer.toJson<DateTime?>(prontoParaRetirada),
      'retirou': serializer.toJson<DateTime?>(retirou),
    };
  }

  Delivery copyWith(
        {
		  int? id,
          int? idComanda,
          int? idTaxaEntrega,
          int? idColaborador,
          String? nomeCliente,
          String? telefonePrincipal,
          String? telefoneRecado,
          String? celular,
          String? logradouro,
          String? numero,
          String? complemento,
          String? cep,
          String? bairro,
          String? cidade,
          String? uf,
          double? valorFrete,
          double? valorRecebido,
          double? valorAReceber,
          double? valorSolicitadoTroco,
          DateTime? previsaoPreparo,
          DateTime? inicioPreparo,
          DateTime? previsaoEntrega,
          DateTime? saiuParaEntrega,
          DateTime? entregue,
          DateTime? previsaoRetirada,
          DateTime? prontoParaRetirada,
          DateTime? retirou,
		}) =>
      Delivery(
        id: id ?? this.id,
        idComanda: idComanda ?? this.idComanda,
        idTaxaEntrega: idTaxaEntrega ?? this.idTaxaEntrega,
        idColaborador: idColaborador ?? this.idColaborador,
        nomeCliente: nomeCliente ?? this.nomeCliente,
        telefonePrincipal: telefonePrincipal ?? this.telefonePrincipal,
        telefoneRecado: telefoneRecado ?? this.telefoneRecado,
        celular: celular ?? this.celular,
        logradouro: logradouro ?? this.logradouro,
        numero: numero ?? this.numero,
        complemento: complemento ?? this.complemento,
        cep: cep ?? this.cep,
        bairro: bairro ?? this.bairro,
        cidade: cidade ?? this.cidade,
        uf: uf ?? this.uf,
        valorFrete: valorFrete ?? this.valorFrete,
        valorRecebido: valorRecebido ?? this.valorRecebido,
        valorAReceber: valorAReceber ?? this.valorAReceber,
        valorSolicitadoTroco: valorSolicitadoTroco ?? this.valorSolicitadoTroco,
        previsaoPreparo: previsaoPreparo ?? this.previsaoPreparo,
        inicioPreparo: inicioPreparo ?? this.inicioPreparo,
        previsaoEntrega: previsaoEntrega ?? this.previsaoEntrega,
        saiuParaEntrega: saiuParaEntrega ?? this.saiuParaEntrega,
        entregue: entregue ?? this.entregue,
        previsaoRetirada: previsaoRetirada ?? this.previsaoRetirada,
        prontoParaRetirada: prontoParaRetirada ?? this.prontoParaRetirada,
        retirou: retirou ?? this.retirou,
      );
  
  @override
  String toString() {
    return (StringBuffer('Delivery(')
          ..write('id: $id, ')
          ..write('idComanda: $idComanda, ')
          ..write('idTaxaEntrega: $idTaxaEntrega, ')
          ..write('idColaborador: $idColaborador, ')
          ..write('nomeCliente: $nomeCliente, ')
          ..write('telefonePrincipal: $telefonePrincipal, ')
          ..write('telefoneRecado: $telefoneRecado, ')
          ..write('celular: $celular, ')
          ..write('logradouro: $logradouro, ')
          ..write('numero: $numero, ')
          ..write('complemento: $complemento, ')
          ..write('cep: $cep, ')
          ..write('bairro: $bairro, ')
          ..write('cidade: $cidade, ')
          ..write('uf: $uf, ')
          ..write('valorFrete: $valorFrete, ')
          ..write('valorRecebido: $valorRecebido, ')
          ..write('valorAReceber: $valorAReceber, ')
          ..write('valorSolicitadoTroco: $valorSolicitadoTroco, ')
          ..write('previsaoPreparo: $previsaoPreparo, ')
          ..write('inicioPreparo: $inicioPreparo, ')
          ..write('previsaoEntrega: $previsaoEntrega, ')
          ..write('saiuParaEntrega: $saiuParaEntrega, ')
          ..write('entregue: $entregue, ')
          ..write('previsaoRetirada: $previsaoRetirada, ')
          ..write('prontoParaRetirada: $prontoParaRetirada, ')
          ..write('retirou: $retirou, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idComanda,
      idTaxaEntrega,
      idColaborador,
      nomeCliente,
      telefonePrincipal,
      telefoneRecado,
      celular,
      logradouro,
      numero,
      complemento,
      cep,
      bairro,
      cidade,
      uf,
      valorFrete,
      valorRecebido,
      valorAReceber,
      valorSolicitadoTroco,
      previsaoPreparo,
      inicioPreparo,
      previsaoEntrega,
      saiuParaEntrega,
      entregue,
      previsaoRetirada,
      prontoParaRetirada,
      retirou,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Delivery &&
          other.id == id &&
          other.idComanda == idComanda &&
          other.idTaxaEntrega == idTaxaEntrega &&
          other.idColaborador == idColaborador &&
          other.nomeCliente == nomeCliente &&
          other.telefonePrincipal == telefonePrincipal &&
          other.telefoneRecado == telefoneRecado &&
          other.celular == celular &&
          other.logradouro == logradouro &&
          other.numero == numero &&
          other.complemento == complemento &&
          other.cep == cep &&
          other.bairro == bairro &&
          other.cidade == cidade &&
          other.uf == uf &&
          other.valorFrete == valorFrete &&
          other.valorRecebido == valorRecebido &&
          other.valorAReceber == valorAReceber &&
          other.valorSolicitadoTroco == valorSolicitadoTroco &&
          other.previsaoPreparo == previsaoPreparo &&
          other.inicioPreparo == inicioPreparo &&
          other.previsaoEntrega == previsaoEntrega &&
          other.saiuParaEntrega == saiuParaEntrega &&
          other.entregue == entregue &&
          other.previsaoRetirada == previsaoRetirada &&
          other.prontoParaRetirada == prontoParaRetirada &&
          other.retirou == retirou 
	   );
}

class DeliverysCompanion extends UpdateCompanion<Delivery> {

  final Value<int?> id;
  final Value<int?> idComanda;
  final Value<int?> idTaxaEntrega;
  final Value<int?> idColaborador;
  final Value<String?> nomeCliente;
  final Value<String?> telefonePrincipal;
  final Value<String?> telefoneRecado;
  final Value<String?> celular;
  final Value<String?> logradouro;
  final Value<String?> numero;
  final Value<String?> complemento;
  final Value<String?> cep;
  final Value<String?> bairro;
  final Value<String?> cidade;
  final Value<String?> uf;
  final Value<double?> valorFrete;
  final Value<double?> valorRecebido;
  final Value<double?> valorAReceber;
  final Value<double?> valorSolicitadoTroco;
  final Value<DateTime?> previsaoPreparo;
  final Value<DateTime?> inicioPreparo;
  final Value<DateTime?> previsaoEntrega;
  final Value<DateTime?> saiuParaEntrega;
  final Value<DateTime?> entregue;
  final Value<DateTime?> previsaoRetirada;
  final Value<DateTime?> prontoParaRetirada;
  final Value<DateTime?> retirou;

  const DeliverysCompanion({
    this.id = const Value.absent(),
    this.idComanda = const Value.absent(),
    this.idTaxaEntrega = const Value.absent(),
    this.idColaborador = const Value.absent(),
    this.nomeCliente = const Value.absent(),
    this.telefonePrincipal = const Value.absent(),
    this.telefoneRecado = const Value.absent(),
    this.celular = const Value.absent(),
    this.logradouro = const Value.absent(),
    this.numero = const Value.absent(),
    this.complemento = const Value.absent(),
    this.cep = const Value.absent(),
    this.bairro = const Value.absent(),
    this.cidade = const Value.absent(),
    this.uf = const Value.absent(),
    this.valorFrete = const Value.absent(),
    this.valorRecebido = const Value.absent(),
    this.valorAReceber = const Value.absent(),
    this.valorSolicitadoTroco = const Value.absent(),
    this.previsaoPreparo = const Value.absent(),
    this.inicioPreparo = const Value.absent(),
    this.previsaoEntrega = const Value.absent(),
    this.saiuParaEntrega = const Value.absent(),
    this.entregue = const Value.absent(),
    this.previsaoRetirada = const Value.absent(),
    this.prontoParaRetirada = const Value.absent(),
    this.retirou = const Value.absent(),
  });

  DeliverysCompanion.insert({
    this.id = const Value.absent(),
    this.idComanda = const Value.absent(),
    this.idTaxaEntrega = const Value.absent(),
    this.idColaborador = const Value.absent(),
    this.nomeCliente = const Value.absent(),
    this.telefonePrincipal = const Value.absent(),
    this.telefoneRecado = const Value.absent(),
    this.celular = const Value.absent(),
    this.logradouro = const Value.absent(),
    this.numero = const Value.absent(),
    this.complemento = const Value.absent(),
    this.cep = const Value.absent(),
    this.bairro = const Value.absent(),
    this.cidade = const Value.absent(),
    this.uf = const Value.absent(),
    this.valorFrete = const Value.absent(),
    this.valorRecebido = const Value.absent(),
    this.valorAReceber = const Value.absent(),
    this.valorSolicitadoTroco = const Value.absent(),
    this.previsaoPreparo = const Value.absent(),
    this.inicioPreparo = const Value.absent(),
    this.previsaoEntrega = const Value.absent(),
    this.saiuParaEntrega = const Value.absent(),
    this.entregue = const Value.absent(),
    this.previsaoRetirada = const Value.absent(),
    this.prontoParaRetirada = const Value.absent(),
    this.retirou = const Value.absent(),
  });

  static Insertable<Delivery> custom({
    Expression<int>? id,
    Expression<int>? idComanda,
    Expression<int>? idTaxaEntrega,
    Expression<int>? idColaborador,
    Expression<String>? nomeCliente,
    Expression<String>? telefonePrincipal,
    Expression<String>? telefoneRecado,
    Expression<String>? celular,
    Expression<String>? logradouro,
    Expression<String>? numero,
    Expression<String>? complemento,
    Expression<String>? cep,
    Expression<String>? bairro,
    Expression<String>? cidade,
    Expression<String>? uf,
    Expression<double>? valorFrete,
    Expression<double>? valorRecebido,
    Expression<double>? valorAReceber,
    Expression<double>? valorSolicitadoTroco,
    Expression<DateTime>? previsaoPreparo,
    Expression<DateTime>? inicioPreparo,
    Expression<DateTime>? previsaoEntrega,
    Expression<DateTime>? saiuParaEntrega,
    Expression<DateTime>? entregue,
    Expression<DateTime>? previsaoRetirada,
    Expression<DateTime>? prontoParaRetirada,
    Expression<DateTime>? retirou,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idComanda != null) 'ID_COMANDA': idComanda,
      if (idTaxaEntrega != null) 'ID_TAXA_ENTREGA': idTaxaEntrega,
      if (idColaborador != null) 'ID_COLABORADOR': idColaborador,
      if (nomeCliente != null) 'NOME_CLIENTE': nomeCliente,
      if (telefonePrincipal != null) 'TELEFONE_PRINCIPAL': telefonePrincipal,
      if (telefoneRecado != null) 'TELEFONE_RECADO': telefoneRecado,
      if (celular != null) 'CELULAR': celular,
      if (logradouro != null) 'LOGRADOURO': logradouro,
      if (numero != null) 'NUMERO': numero,
      if (complemento != null) 'COMPLEMENTO': complemento,
      if (cep != null) 'CEP': cep,
      if (bairro != null) 'BAIRRO': bairro,
      if (cidade != null) 'CIDADE': cidade,
      if (uf != null) 'UF': uf,
      if (valorFrete != null) 'VALOR_FRETE': valorFrete,
      if (valorRecebido != null) 'VALOR_RECEBIDO': valorRecebido,
      if (valorAReceber != null) 'VALOR_A_RECEBER': valorAReceber,
      if (valorSolicitadoTroco != null) 'VALOR_SOLICITADO_TROCO': valorSolicitadoTroco,
      if (previsaoPreparo != null) 'PREVISAO_PREPARO': previsaoPreparo,
      if (inicioPreparo != null) 'INICIO_PREPARO': inicioPreparo,
      if (previsaoEntrega != null) 'PREVISAO_ENTREGA': previsaoEntrega,
      if (saiuParaEntrega != null) 'SAIU_PARA_ENTREGA': saiuParaEntrega,
      if (entregue != null) 'ENTREGUE': entregue,
      if (previsaoRetirada != null) 'PREVISAO_RETIRADA': previsaoRetirada,
      if (prontoParaRetirada != null) 'PRONTO_PARA_RETIRADA': prontoParaRetirada,
      if (retirou != null) 'RETIROU': retirou,
    });
  }

  DeliverysCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idComanda,
      Value<int>? idTaxaEntrega,
      Value<int>? idColaborador,
      Value<String>? nomeCliente,
      Value<String>? telefonePrincipal,
      Value<String>? telefoneRecado,
      Value<String>? celular,
      Value<String>? logradouro,
      Value<String>? numero,
      Value<String>? complemento,
      Value<String>? cep,
      Value<String>? bairro,
      Value<String>? cidade,
      Value<String>? uf,
      Value<double>? valorFrete,
      Value<double>? valorRecebido,
      Value<double>? valorAReceber,
      Value<double>? valorSolicitadoTroco,
      Value<DateTime>? previsaoPreparo,
      Value<DateTime>? inicioPreparo,
      Value<DateTime>? previsaoEntrega,
      Value<DateTime>? saiuParaEntrega,
      Value<DateTime>? entregue,
      Value<DateTime>? previsaoRetirada,
      Value<DateTime>? prontoParaRetirada,
      Value<DateTime>? retirou,
	  }) {
    return DeliverysCompanion(
      id: id ?? this.id,
      idComanda: idComanda ?? this.idComanda,
      idTaxaEntrega: idTaxaEntrega ?? this.idTaxaEntrega,
      idColaborador: idColaborador ?? this.idColaborador,
      nomeCliente: nomeCliente ?? this.nomeCliente,
      telefonePrincipal: telefonePrincipal ?? this.telefonePrincipal,
      telefoneRecado: telefoneRecado ?? this.telefoneRecado,
      celular: celular ?? this.celular,
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      cep: cep ?? this.cep,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      uf: uf ?? this.uf,
      valorFrete: valorFrete ?? this.valorFrete,
      valorRecebido: valorRecebido ?? this.valorRecebido,
      valorAReceber: valorAReceber ?? this.valorAReceber,
      valorSolicitadoTroco: valorSolicitadoTroco ?? this.valorSolicitadoTroco,
      previsaoPreparo: previsaoPreparo ?? this.previsaoPreparo,
      inicioPreparo: inicioPreparo ?? this.inicioPreparo,
      previsaoEntrega: previsaoEntrega ?? this.previsaoEntrega,
      saiuParaEntrega: saiuParaEntrega ?? this.saiuParaEntrega,
      entregue: entregue ?? this.entregue,
      previsaoRetirada: previsaoRetirada ?? this.previsaoRetirada,
      prontoParaRetirada: prontoParaRetirada ?? this.prontoParaRetirada,
      retirou: retirou ?? this.retirou,
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
    if (idTaxaEntrega.present) {
      map['ID_TAXA_ENTREGA'] = Variable<int?>(idTaxaEntrega.value);
    }
    if (idColaborador.present) {
      map['ID_COLABORADOR'] = Variable<int?>(idColaborador.value);
    }
    if (nomeCliente.present) {
      map['NOME_CLIENTE'] = Variable<String?>(nomeCliente.value);
    }
    if (telefonePrincipal.present) {
      map['TELEFONE_PRINCIPAL'] = Variable<String?>(telefonePrincipal.value);
    }
    if (telefoneRecado.present) {
      map['TELEFONE_RECADO'] = Variable<String?>(telefoneRecado.value);
    }
    if (celular.present) {
      map['CELULAR'] = Variable<String?>(celular.value);
    }
    if (logradouro.present) {
      map['LOGRADOURO'] = Variable<String?>(logradouro.value);
    }
    if (numero.present) {
      map['NUMERO'] = Variable<String?>(numero.value);
    }
    if (complemento.present) {
      map['COMPLEMENTO'] = Variable<String?>(complemento.value);
    }
    if (cep.present) {
      map['CEP'] = Variable<String?>(cep.value);
    }
    if (bairro.present) {
      map['BAIRRO'] = Variable<String?>(bairro.value);
    }
    if (cidade.present) {
      map['CIDADE'] = Variable<String?>(cidade.value);
    }
    if (uf.present) {
      map['UF'] = Variable<String?>(uf.value);
    }
    if (valorFrete.present) {
      map['VALOR_FRETE'] = Variable<double?>(valorFrete.value);
    }
    if (valorRecebido.present) {
      map['VALOR_RECEBIDO'] = Variable<double?>(valorRecebido.value);
    }
    if (valorAReceber.present) {
      map['VALOR_A_RECEBER'] = Variable<double?>(valorAReceber.value);
    }
    if (valorSolicitadoTroco.present) {
      map['VALOR_SOLICITADO_TROCO'] = Variable<double?>(valorSolicitadoTroco.value);
    }
    if (previsaoPreparo.present) {
      map['PREVISAO_PREPARO'] = Variable<DateTime?>(previsaoPreparo.value);
    }
    if (inicioPreparo.present) {
      map['INICIO_PREPARO'] = Variable<DateTime?>(inicioPreparo.value);
    }
    if (previsaoEntrega.present) {
      map['PREVISAO_ENTREGA'] = Variable<DateTime?>(previsaoEntrega.value);
    }
    if (saiuParaEntrega.present) {
      map['SAIU_PARA_ENTREGA'] = Variable<DateTime?>(saiuParaEntrega.value);
    }
    if (entregue.present) {
      map['ENTREGUE'] = Variable<DateTime?>(entregue.value);
    }
    if (previsaoRetirada.present) {
      map['PREVISAO_RETIRADA'] = Variable<DateTime?>(previsaoRetirada.value);
    }
    if (prontoParaRetirada.present) {
      map['PRONTO_PARA_RETIRADA'] = Variable<DateTime?>(prontoParaRetirada.value);
    }
    if (retirou.present) {
      map['RETIROU'] = Variable<DateTime?>(retirou.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliverysCompanion(')
          ..write('id: $id, ')
          ..write('idComanda: $idComanda, ')
          ..write('idTaxaEntrega: $idTaxaEntrega, ')
          ..write('idColaborador: $idColaborador, ')
          ..write('nomeCliente: $nomeCliente, ')
          ..write('telefonePrincipal: $telefonePrincipal, ')
          ..write('telefoneRecado: $telefoneRecado, ')
          ..write('celular: $celular, ')
          ..write('logradouro: $logradouro, ')
          ..write('numero: $numero, ')
          ..write('complemento: $complemento, ')
          ..write('cep: $cep, ')
          ..write('bairro: $bairro, ')
          ..write('cidade: $cidade, ')
          ..write('uf: $uf, ')
          ..write('valorFrete: $valorFrete, ')
          ..write('valorRecebido: $valorRecebido, ')
          ..write('valorAReceber: $valorAReceber, ')
          ..write('valorSolicitadoTroco: $valorSolicitadoTroco, ')
          ..write('previsaoPreparo: $previsaoPreparo, ')
          ..write('inicioPreparo: $inicioPreparo, ')
          ..write('previsaoEntrega: $previsaoEntrega, ')
          ..write('saiuParaEntrega: $saiuParaEntrega, ')
          ..write('entregue: $entregue, ')
          ..write('previsaoRetirada: $previsaoRetirada, ')
          ..write('prontoParaRetirada: $prontoParaRetirada, ')
          ..write('retirou: $retirou, ')
          ..write(')'))
        .toString();
  }
}

class $DeliverysTable extends Deliverys
    with TableInfo<$DeliverysTable, Delivery> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DeliverysTable(this._db, [this._alias]);
  
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
  final VerificationMeta _idTaxaEntregaMeta =
      const VerificationMeta('idTaxaEntrega');
  GeneratedColumn<int>? _idTaxaEntrega;
  @override
  GeneratedColumn<int> get idTaxaEntrega =>
      _idTaxaEntrega ??= GeneratedColumn<int>('ID_TAXA_ENTREGA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES TAXA_ENTREGA(ID)');
  final VerificationMeta _idColaboradorMeta =
      const VerificationMeta('idColaborador');
  GeneratedColumn<int>? _idColaborador;
  @override
  GeneratedColumn<int> get idColaborador =>
      _idColaborador ??= GeneratedColumn<int>('ID_COLABORADOR', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES COLABORADOR(ID)');
  final VerificationMeta _nomeClienteMeta =
      const VerificationMeta('nomeCliente');
  GeneratedColumn<String>? _nomeCliente;
  @override
  GeneratedColumn<String> get nomeCliente => _nomeCliente ??=
      GeneratedColumn<String>('NOME_CLIENTE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _telefonePrincipalMeta =
      const VerificationMeta('telefonePrincipal');
  GeneratedColumn<String>? _telefonePrincipal;
  @override
  GeneratedColumn<String> get telefonePrincipal => _telefonePrincipal ??=
      GeneratedColumn<String>('TELEFONE_PRINCIPAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _telefoneRecadoMeta =
      const VerificationMeta('telefoneRecado');
  GeneratedColumn<String>? _telefoneRecado;
  @override
  GeneratedColumn<String> get telefoneRecado => _telefoneRecado ??=
      GeneratedColumn<String>('TELEFONE_RECADO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _celularMeta =
      const VerificationMeta('celular');
  GeneratedColumn<String>? _celular;
  @override
  GeneratedColumn<String> get celular => _celular ??=
      GeneratedColumn<String>('CELULAR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _logradouroMeta =
      const VerificationMeta('logradouro');
  GeneratedColumn<String>? _logradouro;
  @override
  GeneratedColumn<String> get logradouro => _logradouro ??=
      GeneratedColumn<String>('LOGRADOURO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroMeta =
      const VerificationMeta('numero');
  GeneratedColumn<String>? _numero;
  @override
  GeneratedColumn<String> get numero => _numero ??=
      GeneratedColumn<String>('NUMERO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _complementoMeta =
      const VerificationMeta('complemento');
  GeneratedColumn<String>? _complemento;
  @override
  GeneratedColumn<String> get complemento => _complemento ??=
      GeneratedColumn<String>('COMPLEMENTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cepMeta =
      const VerificationMeta('cep');
  GeneratedColumn<String>? _cep;
  @override
  GeneratedColumn<String> get cep => _cep ??=
      GeneratedColumn<String>('CEP', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _bairroMeta =
      const VerificationMeta('bairro');
  GeneratedColumn<String>? _bairro;
  @override
  GeneratedColumn<String> get bairro => _bairro ??=
      GeneratedColumn<String>('BAIRRO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cidadeMeta =
      const VerificationMeta('cidade');
  GeneratedColumn<String>? _cidade;
  @override
  GeneratedColumn<String> get cidade => _cidade ??=
      GeneratedColumn<String>('CIDADE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ufMeta =
      const VerificationMeta('uf');
  GeneratedColumn<String>? _uf;
  @override
  GeneratedColumn<String> get uf => _uf ??=
      GeneratedColumn<String>('UF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorFreteMeta =
      const VerificationMeta('valorFrete');
  GeneratedColumn<double>? _valorFrete;
  @override
  GeneratedColumn<double> get valorFrete => _valorFrete ??=
      GeneratedColumn<double>('VALOR_FRETE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorRecebidoMeta =
      const VerificationMeta('valorRecebido');
  GeneratedColumn<double>? _valorRecebido;
  @override
  GeneratedColumn<double> get valorRecebido => _valorRecebido ??=
      GeneratedColumn<double>('VALOR_RECEBIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorAReceberMeta =
      const VerificationMeta('valorAReceber');
  GeneratedColumn<double>? _valorAReceber;
  @override
  GeneratedColumn<double> get valorAReceber => _valorAReceber ??=
      GeneratedColumn<double>('VALOR_A_RECEBER', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorSolicitadoTrocoMeta =
      const VerificationMeta('valorSolicitadoTroco');
  GeneratedColumn<double>? _valorSolicitadoTroco;
  @override
  GeneratedColumn<double> get valorSolicitadoTroco => _valorSolicitadoTroco ??=
      GeneratedColumn<double>('VALOR_SOLICITADO_TROCO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _previsaoPreparoMeta =
      const VerificationMeta('previsaoPreparo');
  GeneratedColumn<DateTime>? _previsaoPreparo;
  @override
  GeneratedColumn<DateTime> get previsaoPreparo => _previsaoPreparo ??=
      GeneratedColumn<DateTime>('PREVISAO_PREPARO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _inicioPreparoMeta =
      const VerificationMeta('inicioPreparo');
  GeneratedColumn<DateTime>? _inicioPreparo;
  @override
  GeneratedColumn<DateTime> get inicioPreparo => _inicioPreparo ??=
      GeneratedColumn<DateTime>('INICIO_PREPARO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _previsaoEntregaMeta =
      const VerificationMeta('previsaoEntrega');
  GeneratedColumn<DateTime>? _previsaoEntrega;
  @override
  GeneratedColumn<DateTime> get previsaoEntrega => _previsaoEntrega ??=
      GeneratedColumn<DateTime>('PREVISAO_ENTREGA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _saiuParaEntregaMeta =
      const VerificationMeta('saiuParaEntrega');
  GeneratedColumn<DateTime>? _saiuParaEntrega;
  @override
  GeneratedColumn<DateTime> get saiuParaEntrega => _saiuParaEntrega ??=
      GeneratedColumn<DateTime>('SAIU_PARA_ENTREGA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _entregueMeta =
      const VerificationMeta('entregue');
  GeneratedColumn<DateTime>? _entregue;
  @override
  GeneratedColumn<DateTime> get entregue => _entregue ??=
      GeneratedColumn<DateTime>('ENTREGUE', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _previsaoRetiradaMeta =
      const VerificationMeta('previsaoRetirada');
  GeneratedColumn<DateTime>? _previsaoRetirada;
  @override
  GeneratedColumn<DateTime> get previsaoRetirada => _previsaoRetirada ??=
      GeneratedColumn<DateTime>('PREVISAO_RETIRADA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _prontoParaRetiradaMeta =
      const VerificationMeta('prontoParaRetirada');
  GeneratedColumn<DateTime>? _prontoParaRetirada;
  @override
  GeneratedColumn<DateTime> get prontoParaRetirada => _prontoParaRetirada ??=
      GeneratedColumn<DateTime>('PRONTO_PARA_RETIRADA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _retirouMeta =
      const VerificationMeta('retirou');
  GeneratedColumn<DateTime>? _retirou;
  @override
  GeneratedColumn<DateTime> get retirou => _retirou ??=
      GeneratedColumn<DateTime>('RETIROU', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idComanda,
        idTaxaEntrega,
        idColaborador,
        nomeCliente,
        telefonePrincipal,
        telefoneRecado,
        celular,
        logradouro,
        numero,
        complemento,
        cep,
        bairro,
        cidade,
        uf,
        valorFrete,
        valorRecebido,
        valorAReceber,
        valorSolicitadoTroco,
        previsaoPreparo,
        inicioPreparo,
        previsaoEntrega,
        saiuParaEntrega,
        entregue,
        previsaoRetirada,
        prontoParaRetirada,
        retirou,
      ];

  @override
  String get aliasedName => _alias ?? 'DELIVERY';
  
  @override
  String get actualTableName => 'DELIVERY';
  
  @override
  VerificationContext validateIntegrity(Insertable<Delivery> instance,
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
    if (data.containsKey('ID_TAXA_ENTREGA')) {
        context.handle(_idTaxaEntregaMeta,
            idTaxaEntrega.isAcceptableOrUnknown(data['ID_TAXA_ENTREGA']!, _idTaxaEntregaMeta));
    }
    if (data.containsKey('ID_COLABORADOR')) {
        context.handle(_idColaboradorMeta,
            idColaborador.isAcceptableOrUnknown(data['ID_COLABORADOR']!, _idColaboradorMeta));
    }
    if (data.containsKey('NOME_CLIENTE')) {
        context.handle(_nomeClienteMeta,
            nomeCliente.isAcceptableOrUnknown(data['NOME_CLIENTE']!, _nomeClienteMeta));
    }
    if (data.containsKey('TELEFONE_PRINCIPAL')) {
        context.handle(_telefonePrincipalMeta,
            telefonePrincipal.isAcceptableOrUnknown(data['TELEFONE_PRINCIPAL']!, _telefonePrincipalMeta));
    }
    if (data.containsKey('TELEFONE_RECADO')) {
        context.handle(_telefoneRecadoMeta,
            telefoneRecado.isAcceptableOrUnknown(data['TELEFONE_RECADO']!, _telefoneRecadoMeta));
    }
    if (data.containsKey('CELULAR')) {
        context.handle(_celularMeta,
            celular.isAcceptableOrUnknown(data['CELULAR']!, _celularMeta));
    }
    if (data.containsKey('LOGRADOURO')) {
        context.handle(_logradouroMeta,
            logradouro.isAcceptableOrUnknown(data['LOGRADOURO']!, _logradouroMeta));
    }
    if (data.containsKey('NUMERO')) {
        context.handle(_numeroMeta,
            numero.isAcceptableOrUnknown(data['NUMERO']!, _numeroMeta));
    }
    if (data.containsKey('COMPLEMENTO')) {
        context.handle(_complementoMeta,
            complemento.isAcceptableOrUnknown(data['COMPLEMENTO']!, _complementoMeta));
    }
    if (data.containsKey('CEP')) {
        context.handle(_cepMeta,
            cep.isAcceptableOrUnknown(data['CEP']!, _cepMeta));
    }
    if (data.containsKey('BAIRRO')) {
        context.handle(_bairroMeta,
            bairro.isAcceptableOrUnknown(data['BAIRRO']!, _bairroMeta));
    }
    if (data.containsKey('CIDADE')) {
        context.handle(_cidadeMeta,
            cidade.isAcceptableOrUnknown(data['CIDADE']!, _cidadeMeta));
    }
    if (data.containsKey('UF')) {
        context.handle(_ufMeta,
            uf.isAcceptableOrUnknown(data['UF']!, _ufMeta));
    }
    if (data.containsKey('VALOR_FRETE')) {
        context.handle(_valorFreteMeta,
            valorFrete.isAcceptableOrUnknown(data['VALOR_FRETE']!, _valorFreteMeta));
    }
    if (data.containsKey('VALOR_RECEBIDO')) {
        context.handle(_valorRecebidoMeta,
            valorRecebido.isAcceptableOrUnknown(data['VALOR_RECEBIDO']!, _valorRecebidoMeta));
    }
    if (data.containsKey('VALOR_A_RECEBER')) {
        context.handle(_valorAReceberMeta,
            valorAReceber.isAcceptableOrUnknown(data['VALOR_A_RECEBER']!, _valorAReceberMeta));
    }
    if (data.containsKey('VALOR_SOLICITADO_TROCO')) {
        context.handle(_valorSolicitadoTrocoMeta,
            valorSolicitadoTroco.isAcceptableOrUnknown(data['VALOR_SOLICITADO_TROCO']!, _valorSolicitadoTrocoMeta));
    }
    if (data.containsKey('PREVISAO_PREPARO')) {
        context.handle(_previsaoPreparoMeta,
            previsaoPreparo.isAcceptableOrUnknown(data['PREVISAO_PREPARO']!, _previsaoPreparoMeta));
    }
    if (data.containsKey('INICIO_PREPARO')) {
        context.handle(_inicioPreparoMeta,
            inicioPreparo.isAcceptableOrUnknown(data['INICIO_PREPARO']!, _inicioPreparoMeta));
    }
    if (data.containsKey('PREVISAO_ENTREGA')) {
        context.handle(_previsaoEntregaMeta,
            previsaoEntrega.isAcceptableOrUnknown(data['PREVISAO_ENTREGA']!, _previsaoEntregaMeta));
    }
    if (data.containsKey('SAIU_PARA_ENTREGA')) {
        context.handle(_saiuParaEntregaMeta,
            saiuParaEntrega.isAcceptableOrUnknown(data['SAIU_PARA_ENTREGA']!, _saiuParaEntregaMeta));
    }
    if (data.containsKey('ENTREGUE')) {
        context.handle(_entregueMeta,
            entregue.isAcceptableOrUnknown(data['ENTREGUE']!, _entregueMeta));
    }
    if (data.containsKey('PREVISAO_RETIRADA')) {
        context.handle(_previsaoRetiradaMeta,
            previsaoRetirada.isAcceptableOrUnknown(data['PREVISAO_RETIRADA']!, _previsaoRetiradaMeta));
    }
    if (data.containsKey('PRONTO_PARA_RETIRADA')) {
        context.handle(_prontoParaRetiradaMeta,
            prontoParaRetirada.isAcceptableOrUnknown(data['PRONTO_PARA_RETIRADA']!, _prontoParaRetiradaMeta));
    }
    if (data.containsKey('RETIROU')) {
        context.handle(_retirouMeta,
            retirou.isAcceptableOrUnknown(data['RETIROU']!, _retirouMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Delivery map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Delivery.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DeliverysTable createAlias(String alias) {
    return $DeliverysTable(_db, alias);
  }
}