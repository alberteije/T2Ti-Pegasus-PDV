/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DESTINATARIO] 
                                                                                
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

@DataClassName("NfeDestinatario")
@UseRowClass(NfeDestinatario)
class NfeDestinatarios extends Table {
  @override
  String get tableName => 'NFE_DESTINATARIO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  TextColumn get cnpj => text().named('CNPJ').withLength(min: 0, max: 14).nullable()();
  TextColumn get cpf => text().named('CPF').withLength(min: 0, max: 11).nullable()();
  TextColumn get estrangeiroIdentificacao => text().named('ESTRANGEIRO_IDENTIFICACAO').withLength(min: 0, max: 20).nullable()();
  TextColumn get nome => text().named('NOME').withLength(min: 0, max: 60).nullable()();
  TextColumn get logradouro => text().named('LOGRADOURO').withLength(min: 0, max: 60).nullable()();
  TextColumn get numero => text().named('NUMERO').withLength(min: 0, max: 60).nullable()();
  TextColumn get complemento => text().named('COMPLEMENTO').withLength(min: 0, max: 60).nullable()();
  TextColumn get bairro => text().named('BAIRRO').withLength(min: 0, max: 60).nullable()();
  IntColumn get codigoMunicipio => integer().named('CODIGO_MUNICIPIO').nullable()();
  TextColumn get nomeMunicipio => text().named('NOME_MUNICIPIO').withLength(min: 0, max: 60).nullable()();
  TextColumn get uf => text().named('UF').withLength(min: 0, max: 2).nullable()();
  TextColumn get cep => text().named('CEP').withLength(min: 0, max: 8).nullable()();
  IntColumn get codigoPais => integer().named('CODIGO_PAIS').nullable()();
  TextColumn get nomePais => text().named('NOME_PAIS').withLength(min: 0, max: 60).nullable()();
  TextColumn get telefone => text().named('TELEFONE').withLength(min: 0, max: 14).nullable()();
  TextColumn get indicadorIe => text().named('INDICADOR_IE').withLength(min: 0, max: 1).nullable()();
  TextColumn get inscricaoEstadual => text().named('INSCRICAO_ESTADUAL').withLength(min: 0, max: 14).nullable()();
  IntColumn get suframa => integer().named('SUFRAMA').nullable()();
  TextColumn get inscricaoMunicipal => text().named('INSCRICAO_MUNICIPAL').withLength(min: 0, max: 15).nullable()();
  TextColumn get email => text().named('EMAIL').withLength(min: 0, max: 60).nullable()();
}

class NfeDestinatario extends DataClass implements Insertable<NfeDestinatario> {
  final int? id;
  final int? idNfeCabecalho;
  final String? cnpj;
  final String? cpf;
  final String? estrangeiroIdentificacao;
  final String? nome;
  final String? logradouro;
  final String? numero;
  final String? complemento;
  final String? bairro;
  final int? codigoMunicipio;
  final String? nomeMunicipio;
  final String? uf;
  final String? cep;
  final int? codigoPais;
  final String? nomePais;
  final String? telefone;
  final String? indicadorIe;
  final String? inscricaoEstadual;
  final int? suframa;
  final String? inscricaoMunicipal;
  final String? email;

  NfeDestinatario(
    {
      required this.id,
      this.idNfeCabecalho,
      this.cnpj,
      this.cpf,
      this.estrangeiroIdentificacao,
      this.nome,
      this.logradouro,
      this.numero,
      this.complemento,
      this.bairro,
      this.codigoMunicipio,
      this.nomeMunicipio,
      this.uf,
      this.cep,
      this.codigoPais,
      this.nomePais,
      this.telefone,
      this.indicadorIe,
      this.inscricaoEstadual,
      this.suframa,
      this.inscricaoMunicipal,
      this.email,
    }
  );

  factory NfeDestinatario.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDestinatario(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      cnpj: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CNPJ']),
      cpf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CPF']),
      estrangeiroIdentificacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ESTRANGEIRO_IDENTIFICACAO']),
      nome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME']),
      logradouro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}LOGRADOURO']),
      numero: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO']),
      complemento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}COMPLEMENTO']),
      bairro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}BAIRRO']),
      codigoMunicipio: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_MUNICIPIO']),
      nomeMunicipio: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME_MUNICIPIO']),
      uf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UF']),
      cep: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CEP']),
      codigoPais: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_PAIS']),
      nomePais: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME_PAIS']),
      telefone: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TELEFONE']),
      indicadorIe: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}INDICADOR_IE']),
      inscricaoEstadual: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}INSCRICAO_ESTADUAL']),
      suframa: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}SUFRAMA']),
      inscricaoMunicipal: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}INSCRICAO_MUNICIPAL']),
      email: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL']),
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
    if (!nullToAbsent || cnpj != null) {
      map['CNPJ'] = Variable<String?>(cnpj);
    }
    if (!nullToAbsent || cpf != null) {
      map['CPF'] = Variable<String?>(cpf);
    }
    if (!nullToAbsent || estrangeiroIdentificacao != null) {
      map['ESTRANGEIRO_IDENTIFICACAO'] = Variable<String?>(estrangeiroIdentificacao);
    }
    if (!nullToAbsent || nome != null) {
      map['NOME'] = Variable<String?>(nome);
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
    if (!nullToAbsent || bairro != null) {
      map['BAIRRO'] = Variable<String?>(bairro);
    }
    if (!nullToAbsent || codigoMunicipio != null) {
      map['CODIGO_MUNICIPIO'] = Variable<int?>(codigoMunicipio);
    }
    if (!nullToAbsent || nomeMunicipio != null) {
      map['NOME_MUNICIPIO'] = Variable<String?>(nomeMunicipio);
    }
    if (!nullToAbsent || uf != null) {
      map['UF'] = Variable<String?>(uf);
    }
    if (!nullToAbsent || cep != null) {
      map['CEP'] = Variable<String?>(cep);
    }
    if (!nullToAbsent || codigoPais != null) {
      map['CODIGO_PAIS'] = Variable<int?>(codigoPais);
    }
    if (!nullToAbsent || nomePais != null) {
      map['NOME_PAIS'] = Variable<String?>(nomePais);
    }
    if (!nullToAbsent || telefone != null) {
      map['TELEFONE'] = Variable<String?>(telefone);
    }
    if (!nullToAbsent || indicadorIe != null) {
      map['INDICADOR_IE'] = Variable<String?>(indicadorIe);
    }
    if (!nullToAbsent || inscricaoEstadual != null) {
      map['INSCRICAO_ESTADUAL'] = Variable<String?>(inscricaoEstadual);
    }
    if (!nullToAbsent || suframa != null) {
      map['SUFRAMA'] = Variable<int?>(suframa);
    }
    if (!nullToAbsent || inscricaoMunicipal != null) {
      map['INSCRICAO_MUNICIPAL'] = Variable<String?>(inscricaoMunicipal);
    }
    if (!nullToAbsent || email != null) {
      map['EMAIL'] = Variable<String?>(email);
    }
    return map;
  }

  NfeDestinatariosCompanion toCompanion(bool nullToAbsent) {
    return NfeDestinatariosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      cnpj: cnpj == null && nullToAbsent
        ? const Value.absent()
        : Value(cnpj),
      cpf: cpf == null && nullToAbsent
        ? const Value.absent()
        : Value(cpf),
      estrangeiroIdentificacao: estrangeiroIdentificacao == null && nullToAbsent
        ? const Value.absent()
        : Value(estrangeiroIdentificacao),
      nome: nome == null && nullToAbsent
        ? const Value.absent()
        : Value(nome),
      logradouro: logradouro == null && nullToAbsent
        ? const Value.absent()
        : Value(logradouro),
      numero: numero == null && nullToAbsent
        ? const Value.absent()
        : Value(numero),
      complemento: complemento == null && nullToAbsent
        ? const Value.absent()
        : Value(complemento),
      bairro: bairro == null && nullToAbsent
        ? const Value.absent()
        : Value(bairro),
      codigoMunicipio: codigoMunicipio == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoMunicipio),
      nomeMunicipio: nomeMunicipio == null && nullToAbsent
        ? const Value.absent()
        : Value(nomeMunicipio),
      uf: uf == null && nullToAbsent
        ? const Value.absent()
        : Value(uf),
      cep: cep == null && nullToAbsent
        ? const Value.absent()
        : Value(cep),
      codigoPais: codigoPais == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoPais),
      nomePais: nomePais == null && nullToAbsent
        ? const Value.absent()
        : Value(nomePais),
      telefone: telefone == null && nullToAbsent
        ? const Value.absent()
        : Value(telefone),
      indicadorIe: indicadorIe == null && nullToAbsent
        ? const Value.absent()
        : Value(indicadorIe),
      inscricaoEstadual: inscricaoEstadual == null && nullToAbsent
        ? const Value.absent()
        : Value(inscricaoEstadual),
      suframa: suframa == null && nullToAbsent
        ? const Value.absent()
        : Value(suframa),
      inscricaoMunicipal: inscricaoMunicipal == null && nullToAbsent
        ? const Value.absent()
        : Value(inscricaoMunicipal),
      email: email == null && nullToAbsent
        ? const Value.absent()
        : Value(email),
    );
  }

  factory NfeDestinatario.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDestinatario(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      cnpj: serializer.fromJson<String>(json['cnpj']),
      cpf: serializer.fromJson<String>(json['cpf']),
      estrangeiroIdentificacao: serializer.fromJson<String>(json['estrangeiroIdentificacao']),
      nome: serializer.fromJson<String>(json['nome']),
      logradouro: serializer.fromJson<String>(json['logradouro']),
      numero: serializer.fromJson<String>(json['numero']),
      complemento: serializer.fromJson<String>(json['complemento']),
      bairro: serializer.fromJson<String>(json['bairro']),
      codigoMunicipio: serializer.fromJson<int>(json['codigoMunicipio']),
      nomeMunicipio: serializer.fromJson<String>(json['nomeMunicipio']),
      uf: serializer.fromJson<String>(json['uf']),
      cep: serializer.fromJson<String>(json['cep']),
      codigoPais: serializer.fromJson<int>(json['codigoPais']),
      nomePais: serializer.fromJson<String>(json['nomePais']),
      telefone: serializer.fromJson<String>(json['telefone']),
      indicadorIe: serializer.fromJson<String>(json['indicadorIe']),
      inscricaoEstadual: serializer.fromJson<String>(json['inscricaoEstadual']),
      suframa: serializer.fromJson<int>(json['suframa']),
      inscricaoMunicipal: serializer.fromJson<String>(json['inscricaoMunicipal']),
      email: serializer.fromJson<String>(json['email']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'cnpj': serializer.toJson<String?>(cnpj),
      'cpf': serializer.toJson<String?>(cpf),
      'estrangeiroIdentificacao': serializer.toJson<String?>(estrangeiroIdentificacao),
      'nome': serializer.toJson<String?>(nome),
      'logradouro': serializer.toJson<String?>(logradouro),
      'numero': serializer.toJson<String?>(numero),
      'complemento': serializer.toJson<String?>(complemento),
      'bairro': serializer.toJson<String?>(bairro),
      'codigoMunicipio': serializer.toJson<int?>(codigoMunicipio),
      'nomeMunicipio': serializer.toJson<String?>(nomeMunicipio),
      'uf': serializer.toJson<String?>(uf),
      'cep': serializer.toJson<String?>(cep),
      'codigoPais': serializer.toJson<int?>(codigoPais),
      'nomePais': serializer.toJson<String?>(nomePais),
      'telefone': serializer.toJson<String?>(telefone),
      'indicadorIe': serializer.toJson<String?>(indicadorIe),
      'inscricaoEstadual': serializer.toJson<String?>(inscricaoEstadual),
      'suframa': serializer.toJson<int?>(suframa),
      'inscricaoMunicipal': serializer.toJson<String?>(inscricaoMunicipal),
      'email': serializer.toJson<String?>(email),
    };
  }

  NfeDestinatario copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          String? cnpj,
          String? cpf,
          String? estrangeiroIdentificacao,
          String? nome,
          String? logradouro,
          String? numero,
          String? complemento,
          String? bairro,
          int? codigoMunicipio,
          String? nomeMunicipio,
          String? uf,
          String? cep,
          int? codigoPais,
          String? nomePais,
          String? telefone,
          String? indicadorIe,
          String? inscricaoEstadual,
          int? suframa,
          String? inscricaoMunicipal,
          String? email,
		}) =>
      NfeDestinatario(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        cnpj: cnpj ?? this.cnpj,
        cpf: cpf ?? this.cpf,
        estrangeiroIdentificacao: estrangeiroIdentificacao ?? this.estrangeiroIdentificacao,
        nome: nome ?? this.nome,
        logradouro: logradouro ?? this.logradouro,
        numero: numero ?? this.numero,
        complemento: complemento ?? this.complemento,
        bairro: bairro ?? this.bairro,
        codigoMunicipio: codigoMunicipio ?? this.codigoMunicipio,
        nomeMunicipio: nomeMunicipio ?? this.nomeMunicipio,
        uf: uf ?? this.uf,
        cep: cep ?? this.cep,
        codigoPais: codigoPais ?? this.codigoPais,
        nomePais: nomePais ?? this.nomePais,
        telefone: telefone ?? this.telefone,
        indicadorIe: indicadorIe ?? this.indicadorIe,
        inscricaoEstadual: inscricaoEstadual ?? this.inscricaoEstadual,
        suframa: suframa ?? this.suframa,
        inscricaoMunicipal: inscricaoMunicipal ?? this.inscricaoMunicipal,
        email: email ?? this.email,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDestinatario(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('cnpj: $cnpj, ')
          ..write('cpf: $cpf, ')
          ..write('estrangeiroIdentificacao: $estrangeiroIdentificacao, ')
          ..write('nome: $nome, ')
          ..write('logradouro: $logradouro, ')
          ..write('numero: $numero, ')
          ..write('complemento: $complemento, ')
          ..write('bairro: $bairro, ')
          ..write('codigoMunicipio: $codigoMunicipio, ')
          ..write('nomeMunicipio: $nomeMunicipio, ')
          ..write('uf: $uf, ')
          ..write('cep: $cep, ')
          ..write('codigoPais: $codigoPais, ')
          ..write('nomePais: $nomePais, ')
          ..write('telefone: $telefone, ')
          ..write('indicadorIe: $indicadorIe, ')
          ..write('inscricaoEstadual: $inscricaoEstadual, ')
          ..write('suframa: $suframa, ')
          ..write('inscricaoMunicipal: $inscricaoMunicipal, ')
          ..write('email: $email, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      cnpj,
      cpf,
      estrangeiroIdentificacao,
      nome,
      logradouro,
      numero,
      complemento,
      bairro,
      codigoMunicipio,
      nomeMunicipio,
      uf,
      cep,
      codigoPais,
      nomePais,
      telefone,
      indicadorIe,
      inscricaoEstadual,
      suframa,
      inscricaoMunicipal,
      email,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDestinatario &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.cnpj == cnpj &&
          other.cpf == cpf &&
          other.estrangeiroIdentificacao == estrangeiroIdentificacao &&
          other.nome == nome &&
          other.logradouro == logradouro &&
          other.numero == numero &&
          other.complemento == complemento &&
          other.bairro == bairro &&
          other.codigoMunicipio == codigoMunicipio &&
          other.nomeMunicipio == nomeMunicipio &&
          other.uf == uf &&
          other.cep == cep &&
          other.codigoPais == codigoPais &&
          other.nomePais == nomePais &&
          other.telefone == telefone &&
          other.indicadorIe == indicadorIe &&
          other.inscricaoEstadual == inscricaoEstadual &&
          other.suframa == suframa &&
          other.inscricaoMunicipal == inscricaoMunicipal &&
          other.email == email 
	   );
}

class NfeDestinatariosCompanion extends UpdateCompanion<NfeDestinatario> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<String?> cnpj;
  final Value<String?> cpf;
  final Value<String?> estrangeiroIdentificacao;
  final Value<String?> nome;
  final Value<String?> logradouro;
  final Value<String?> numero;
  final Value<String?> complemento;
  final Value<String?> bairro;
  final Value<int?> codigoMunicipio;
  final Value<String?> nomeMunicipio;
  final Value<String?> uf;
  final Value<String?> cep;
  final Value<int?> codigoPais;
  final Value<String?> nomePais;
  final Value<String?> telefone;
  final Value<String?> indicadorIe;
  final Value<String?> inscricaoEstadual;
  final Value<int?> suframa;
  final Value<String?> inscricaoMunicipal;
  final Value<String?> email;

  const NfeDestinatariosCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.cpf = const Value.absent(),
    this.estrangeiroIdentificacao = const Value.absent(),
    this.nome = const Value.absent(),
    this.logradouro = const Value.absent(),
    this.numero = const Value.absent(),
    this.complemento = const Value.absent(),
    this.bairro = const Value.absent(),
    this.codigoMunicipio = const Value.absent(),
    this.nomeMunicipio = const Value.absent(),
    this.uf = const Value.absent(),
    this.cep = const Value.absent(),
    this.codigoPais = const Value.absent(),
    this.nomePais = const Value.absent(),
    this.telefone = const Value.absent(),
    this.indicadorIe = const Value.absent(),
    this.inscricaoEstadual = const Value.absent(),
    this.suframa = const Value.absent(),
    this.inscricaoMunicipal = const Value.absent(),
    this.email = const Value.absent(),
  });

  NfeDestinatariosCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.cpf = const Value.absent(),
    this.estrangeiroIdentificacao = const Value.absent(),
    this.nome = const Value.absent(),
    this.logradouro = const Value.absent(),
    this.numero = const Value.absent(),
    this.complemento = const Value.absent(),
    this.bairro = const Value.absent(),
    this.codigoMunicipio = const Value.absent(),
    this.nomeMunicipio = const Value.absent(),
    this.uf = const Value.absent(),
    this.cep = const Value.absent(),
    this.codigoPais = const Value.absent(),
    this.nomePais = const Value.absent(),
    this.telefone = const Value.absent(),
    this.indicadorIe = const Value.absent(),
    this.inscricaoEstadual = const Value.absent(),
    this.suframa = const Value.absent(),
    this.inscricaoMunicipal = const Value.absent(),
    this.email = const Value.absent(),
  });

  static Insertable<NfeDestinatario> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<String>? cnpj,
    Expression<String>? cpf,
    Expression<String>? estrangeiroIdentificacao,
    Expression<String>? nome,
    Expression<String>? logradouro,
    Expression<String>? numero,
    Expression<String>? complemento,
    Expression<String>? bairro,
    Expression<int>? codigoMunicipio,
    Expression<String>? nomeMunicipio,
    Expression<String>? uf,
    Expression<String>? cep,
    Expression<int>? codigoPais,
    Expression<String>? nomePais,
    Expression<String>? telefone,
    Expression<String>? indicadorIe,
    Expression<String>? inscricaoEstadual,
    Expression<int>? suframa,
    Expression<String>? inscricaoMunicipal,
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (cnpj != null) 'CNPJ': cnpj,
      if (cpf != null) 'CPF': cpf,
      if (estrangeiroIdentificacao != null) 'ESTRANGEIRO_IDENTIFICACAO': estrangeiroIdentificacao,
      if (nome != null) 'NOME': nome,
      if (logradouro != null) 'LOGRADOURO': logradouro,
      if (numero != null) 'NUMERO': numero,
      if (complemento != null) 'COMPLEMENTO': complemento,
      if (bairro != null) 'BAIRRO': bairro,
      if (codigoMunicipio != null) 'CODIGO_MUNICIPIO': codigoMunicipio,
      if (nomeMunicipio != null) 'NOME_MUNICIPIO': nomeMunicipio,
      if (uf != null) 'UF': uf,
      if (cep != null) 'CEP': cep,
      if (codigoPais != null) 'CODIGO_PAIS': codigoPais,
      if (nomePais != null) 'NOME_PAIS': nomePais,
      if (telefone != null) 'TELEFONE': telefone,
      if (indicadorIe != null) 'INDICADOR_IE': indicadorIe,
      if (inscricaoEstadual != null) 'INSCRICAO_ESTADUAL': inscricaoEstadual,
      if (suframa != null) 'SUFRAMA': suframa,
      if (inscricaoMunicipal != null) 'INSCRICAO_MUNICIPAL': inscricaoMunicipal,
      if (email != null) 'EMAIL': email,
    });
  }

  NfeDestinatariosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<String>? cnpj,
      Value<String>? cpf,
      Value<String>? estrangeiroIdentificacao,
      Value<String>? nome,
      Value<String>? logradouro,
      Value<String>? numero,
      Value<String>? complemento,
      Value<String>? bairro,
      Value<int>? codigoMunicipio,
      Value<String>? nomeMunicipio,
      Value<String>? uf,
      Value<String>? cep,
      Value<int>? codigoPais,
      Value<String>? nomePais,
      Value<String>? telefone,
      Value<String>? indicadorIe,
      Value<String>? inscricaoEstadual,
      Value<int>? suframa,
      Value<String>? inscricaoMunicipal,
      Value<String>? email,
	  }) {
    return NfeDestinatariosCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      cnpj: cnpj ?? this.cnpj,
      cpf: cpf ?? this.cpf,
      estrangeiroIdentificacao: estrangeiroIdentificacao ?? this.estrangeiroIdentificacao,
      nome: nome ?? this.nome,
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      codigoMunicipio: codigoMunicipio ?? this.codigoMunicipio,
      nomeMunicipio: nomeMunicipio ?? this.nomeMunicipio,
      uf: uf ?? this.uf,
      cep: cep ?? this.cep,
      codigoPais: codigoPais ?? this.codigoPais,
      nomePais: nomePais ?? this.nomePais,
      telefone: telefone ?? this.telefone,
      indicadorIe: indicadorIe ?? this.indicadorIe,
      inscricaoEstadual: inscricaoEstadual ?? this.inscricaoEstadual,
      suframa: suframa ?? this.suframa,
      inscricaoMunicipal: inscricaoMunicipal ?? this.inscricaoMunicipal,
      email: email ?? this.email,
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
    if (cnpj.present) {
      map['CNPJ'] = Variable<String?>(cnpj.value);
    }
    if (cpf.present) {
      map['CPF'] = Variable<String?>(cpf.value);
    }
    if (estrangeiroIdentificacao.present) {
      map['ESTRANGEIRO_IDENTIFICACAO'] = Variable<String?>(estrangeiroIdentificacao.value);
    }
    if (nome.present) {
      map['NOME'] = Variable<String?>(nome.value);
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
    if (bairro.present) {
      map['BAIRRO'] = Variable<String?>(bairro.value);
    }
    if (codigoMunicipio.present) {
      map['CODIGO_MUNICIPIO'] = Variable<int?>(codigoMunicipio.value);
    }
    if (nomeMunicipio.present) {
      map['NOME_MUNICIPIO'] = Variable<String?>(nomeMunicipio.value);
    }
    if (uf.present) {
      map['UF'] = Variable<String?>(uf.value);
    }
    if (cep.present) {
      map['CEP'] = Variable<String?>(cep.value);
    }
    if (codigoPais.present) {
      map['CODIGO_PAIS'] = Variable<int?>(codigoPais.value);
    }
    if (nomePais.present) {
      map['NOME_PAIS'] = Variable<String?>(nomePais.value);
    }
    if (telefone.present) {
      map['TELEFONE'] = Variable<String?>(telefone.value);
    }
    if (indicadorIe.present) {
      map['INDICADOR_IE'] = Variable<String?>(indicadorIe.value);
    }
    if (inscricaoEstadual.present) {
      map['INSCRICAO_ESTADUAL'] = Variable<String?>(inscricaoEstadual.value);
    }
    if (suframa.present) {
      map['SUFRAMA'] = Variable<int?>(suframa.value);
    }
    if (inscricaoMunicipal.present) {
      map['INSCRICAO_MUNICIPAL'] = Variable<String?>(inscricaoMunicipal.value);
    }
    if (email.present) {
      map['EMAIL'] = Variable<String?>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDestinatariosCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('cnpj: $cnpj, ')
          ..write('cpf: $cpf, ')
          ..write('estrangeiroIdentificacao: $estrangeiroIdentificacao, ')
          ..write('nome: $nome, ')
          ..write('logradouro: $logradouro, ')
          ..write('numero: $numero, ')
          ..write('complemento: $complemento, ')
          ..write('bairro: $bairro, ')
          ..write('codigoMunicipio: $codigoMunicipio, ')
          ..write('nomeMunicipio: $nomeMunicipio, ')
          ..write('uf: $uf, ')
          ..write('cep: $cep, ')
          ..write('codigoPais: $codigoPais, ')
          ..write('nomePais: $nomePais, ')
          ..write('telefone: $telefone, ')
          ..write('indicadorIe: $indicadorIe, ')
          ..write('inscricaoEstadual: $inscricaoEstadual, ')
          ..write('suframa: $suframa, ')
          ..write('inscricaoMunicipal: $inscricaoMunicipal, ')
          ..write('email: $email, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDestinatariosTable extends NfeDestinatarios
    with TableInfo<$NfeDestinatariosTable, NfeDestinatario> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDestinatariosTable(this._db, [this._alias]);
  
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
  final VerificationMeta _cnpjMeta =
      const VerificationMeta('cnpj');
  GeneratedColumn<String>? _cnpj;
  @override
  GeneratedColumn<String> get cnpj => _cnpj ??=
      GeneratedColumn<String>('CNPJ', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cpfMeta =
      const VerificationMeta('cpf');
  GeneratedColumn<String>? _cpf;
  @override
  GeneratedColumn<String> get cpf => _cpf ??=
      GeneratedColumn<String>('CPF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _estrangeiroIdentificacaoMeta =
      const VerificationMeta('estrangeiroIdentificacao');
  GeneratedColumn<String>? _estrangeiroIdentificacao;
  @override
  GeneratedColumn<String> get estrangeiroIdentificacao => _estrangeiroIdentificacao ??=
      GeneratedColumn<String>('ESTRANGEIRO_IDENTIFICACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nomeMeta =
      const VerificationMeta('nome');
  GeneratedColumn<String>? _nome;
  @override
  GeneratedColumn<String> get nome => _nome ??=
      GeneratedColumn<String>('NOME', aliasedName, true,
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
  final VerificationMeta _bairroMeta =
      const VerificationMeta('bairro');
  GeneratedColumn<String>? _bairro;
  @override
  GeneratedColumn<String> get bairro => _bairro ??=
      GeneratedColumn<String>('BAIRRO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoMunicipioMeta =
      const VerificationMeta('codigoMunicipio');
  GeneratedColumn<int>? _codigoMunicipio;
  @override
  GeneratedColumn<int> get codigoMunicipio => _codigoMunicipio ??=
      GeneratedColumn<int>('CODIGO_MUNICIPIO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _nomeMunicipioMeta =
      const VerificationMeta('nomeMunicipio');
  GeneratedColumn<String>? _nomeMunicipio;
  @override
  GeneratedColumn<String> get nomeMunicipio => _nomeMunicipio ??=
      GeneratedColumn<String>('NOME_MUNICIPIO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ufMeta =
      const VerificationMeta('uf');
  GeneratedColumn<String>? _uf;
  @override
  GeneratedColumn<String> get uf => _uf ??=
      GeneratedColumn<String>('UF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cepMeta =
      const VerificationMeta('cep');
  GeneratedColumn<String>? _cep;
  @override
  GeneratedColumn<String> get cep => _cep ??=
      GeneratedColumn<String>('CEP', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoPaisMeta =
      const VerificationMeta('codigoPais');
  GeneratedColumn<int>? _codigoPais;
  @override
  GeneratedColumn<int> get codigoPais => _codigoPais ??=
      GeneratedColumn<int>('CODIGO_PAIS', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _nomePaisMeta =
      const VerificationMeta('nomePais');
  GeneratedColumn<String>? _nomePais;
  @override
  GeneratedColumn<String> get nomePais => _nomePais ??=
      GeneratedColumn<String>('NOME_PAIS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  GeneratedColumn<String>? _telefone;
  @override
  GeneratedColumn<String> get telefone => _telefone ??=
      GeneratedColumn<String>('TELEFONE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _indicadorIeMeta =
      const VerificationMeta('indicadorIe');
  GeneratedColumn<String>? _indicadorIe;
  @override
  GeneratedColumn<String> get indicadorIe => _indicadorIe ??=
      GeneratedColumn<String>('INDICADOR_IE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _inscricaoEstadualMeta =
      const VerificationMeta('inscricaoEstadual');
  GeneratedColumn<String>? _inscricaoEstadual;
  @override
  GeneratedColumn<String> get inscricaoEstadual => _inscricaoEstadual ??=
      GeneratedColumn<String>('INSCRICAO_ESTADUAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _suframaMeta =
      const VerificationMeta('suframa');
  GeneratedColumn<int>? _suframa;
  @override
  GeneratedColumn<int> get suframa => _suframa ??=
      GeneratedColumn<int>('SUFRAMA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _inscricaoMunicipalMeta =
      const VerificationMeta('inscricaoMunicipal');
  GeneratedColumn<String>? _inscricaoMunicipal;
  @override
  GeneratedColumn<String> get inscricaoMunicipal => _inscricaoMunicipal ??=
      GeneratedColumn<String>('INSCRICAO_MUNICIPAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailMeta =
      const VerificationMeta('email');
  GeneratedColumn<String>? _email;
  @override
  GeneratedColumn<String> get email => _email ??=
      GeneratedColumn<String>('EMAIL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        cnpj,
        cpf,
        estrangeiroIdentificacao,
        nome,
        logradouro,
        numero,
        complemento,
        bairro,
        codigoMunicipio,
        nomeMunicipio,
        uf,
        cep,
        codigoPais,
        nomePais,
        telefone,
        indicadorIe,
        inscricaoEstadual,
        suframa,
        inscricaoMunicipal,
        email,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DESTINATARIO';
  
  @override
  String get actualTableName => 'NFE_DESTINATARIO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDestinatario> instance,
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
    if (data.containsKey('CNPJ')) {
        context.handle(_cnpjMeta,
            cnpj.isAcceptableOrUnknown(data['CNPJ']!, _cnpjMeta));
    }
    if (data.containsKey('CPF')) {
        context.handle(_cpfMeta,
            cpf.isAcceptableOrUnknown(data['CPF']!, _cpfMeta));
    }
    if (data.containsKey('ESTRANGEIRO_IDENTIFICACAO')) {
        context.handle(_estrangeiroIdentificacaoMeta,
            estrangeiroIdentificacao.isAcceptableOrUnknown(data['ESTRANGEIRO_IDENTIFICACAO']!, _estrangeiroIdentificacaoMeta));
    }
    if (data.containsKey('NOME')) {
        context.handle(_nomeMeta,
            nome.isAcceptableOrUnknown(data['NOME']!, _nomeMeta));
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
    if (data.containsKey('BAIRRO')) {
        context.handle(_bairroMeta,
            bairro.isAcceptableOrUnknown(data['BAIRRO']!, _bairroMeta));
    }
    if (data.containsKey('CODIGO_MUNICIPIO')) {
        context.handle(_codigoMunicipioMeta,
            codigoMunicipio.isAcceptableOrUnknown(data['CODIGO_MUNICIPIO']!, _codigoMunicipioMeta));
    }
    if (data.containsKey('NOME_MUNICIPIO')) {
        context.handle(_nomeMunicipioMeta,
            nomeMunicipio.isAcceptableOrUnknown(data['NOME_MUNICIPIO']!, _nomeMunicipioMeta));
    }
    if (data.containsKey('UF')) {
        context.handle(_ufMeta,
            uf.isAcceptableOrUnknown(data['UF']!, _ufMeta));
    }
    if (data.containsKey('CEP')) {
        context.handle(_cepMeta,
            cep.isAcceptableOrUnknown(data['CEP']!, _cepMeta));
    }
    if (data.containsKey('CODIGO_PAIS')) {
        context.handle(_codigoPaisMeta,
            codigoPais.isAcceptableOrUnknown(data['CODIGO_PAIS']!, _codigoPaisMeta));
    }
    if (data.containsKey('NOME_PAIS')) {
        context.handle(_nomePaisMeta,
            nomePais.isAcceptableOrUnknown(data['NOME_PAIS']!, _nomePaisMeta));
    }
    if (data.containsKey('TELEFONE')) {
        context.handle(_telefoneMeta,
            telefone.isAcceptableOrUnknown(data['TELEFONE']!, _telefoneMeta));
    }
    if (data.containsKey('INDICADOR_IE')) {
        context.handle(_indicadorIeMeta,
            indicadorIe.isAcceptableOrUnknown(data['INDICADOR_IE']!, _indicadorIeMeta));
    }
    if (data.containsKey('INSCRICAO_ESTADUAL')) {
        context.handle(_inscricaoEstadualMeta,
            inscricaoEstadual.isAcceptableOrUnknown(data['INSCRICAO_ESTADUAL']!, _inscricaoEstadualMeta));
    }
    if (data.containsKey('SUFRAMA')) {
        context.handle(_suframaMeta,
            suframa.isAcceptableOrUnknown(data['SUFRAMA']!, _suframaMeta));
    }
    if (data.containsKey('INSCRICAO_MUNICIPAL')) {
        context.handle(_inscricaoMunicipalMeta,
            inscricaoMunicipal.isAcceptableOrUnknown(data['INSCRICAO_MUNICIPAL']!, _inscricaoMunicipalMeta));
    }
    if (data.containsKey('EMAIL')) {
        context.handle(_emailMeta,
            email.isAcceptableOrUnknown(data['EMAIL']!, _emailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDestinatario map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDestinatario.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDestinatariosTable createAlias(String alias) {
    return $NfeDestinatariosTable(_db, alias);
  }
}