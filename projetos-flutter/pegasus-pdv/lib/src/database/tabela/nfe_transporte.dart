/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_TRANSPORTE] 
                                                                                
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

@DataClassName("NfeTransporte")
@UseRowClass(NfeTransporte)
class NfeTransportes extends Table {
  @override
  String get tableName => 'NFE_TRANSPORTE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  TextColumn get modalidadeFrete => text().named('MODALIDADE_FRETE').withLength(min: 0, max: 1).nullable()();
  TextColumn get cnpj => text().named('CNPJ').withLength(min: 0, max: 14).nullable()();
  TextColumn get cpf => text().named('CPF').withLength(min: 0, max: 11).nullable()();
  TextColumn get nome => text().named('NOME').withLength(min: 0, max: 60).nullable()();
  TextColumn get inscricaoEstadual => text().named('INSCRICAO_ESTADUAL').withLength(min: 0, max: 14).nullable()();
  TextColumn get endereco => text().named('ENDERECO').withLength(min: 0, max: 60).nullable()();
  TextColumn get nomeMunicipio => text().named('NOME_MUNICIPIO').withLength(min: 0, max: 60).nullable()();
  TextColumn get uf => text().named('UF').withLength(min: 0, max: 2).nullable()();
  RealColumn get valorServico => real().named('VALOR_SERVICO').nullable()();
  RealColumn get valorBcRetencaoIcms => real().named('VALOR_BC_RETENCAO_ICMS').nullable()();
  RealColumn get aliquotaRetencaoIcms => real().named('ALIQUOTA_RETENCAO_ICMS').nullable()();
  RealColumn get valorIcmsRetido => real().named('VALOR_ICMS_RETIDO').nullable()();
  IntColumn get cfop => integer().named('CFOP').nullable()();
  IntColumn get municipio => integer().named('MUNICIPIO').nullable()();
  TextColumn get placaVeiculo => text().named('PLACA_VEICULO').withLength(min: 0, max: 7).nullable()();
  TextColumn get ufVeiculo => text().named('UF_VEICULO').withLength(min: 0, max: 2).nullable()();
  TextColumn get rntcVeiculo => text().named('RNTC_VEICULO').withLength(min: 0, max: 20).nullable()();
}

class NfeTransporte extends DataClass implements Insertable<NfeTransporte> {
  final int? id;
  final int? idNfeCabecalho;
  final String? modalidadeFrete;
  final String? cnpj;
  final String? cpf;
  final String? nome;
  final String? inscricaoEstadual;
  final String? endereco;
  final String? nomeMunicipio;
  final String? uf;
  final double? valorServico;
  final double? valorBcRetencaoIcms;
  final double? aliquotaRetencaoIcms;
  final double? valorIcmsRetido;
  final int? cfop;
  final int? municipio;
  final String? placaVeiculo;
  final String? ufVeiculo;
  final String? rntcVeiculo;

  NfeTransporte(
    {
      required this.id,
      this.idNfeCabecalho,
      this.modalidadeFrete,
      this.cnpj,
      this.cpf,
      this.nome,
      this.inscricaoEstadual,
      this.endereco,
      this.nomeMunicipio,
      this.uf,
      this.valorServico,
      this.valorBcRetencaoIcms,
      this.aliquotaRetencaoIcms,
      this.valorIcmsRetido,
      this.cfop,
      this.municipio,
      this.placaVeiculo,
      this.ufVeiculo,
      this.rntcVeiculo,
    }
  );

  factory NfeTransporte.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeTransporte(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      modalidadeFrete: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODALIDADE_FRETE']),
      cnpj: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CNPJ']),
      cpf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CPF']),
      nome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME']),
      inscricaoEstadual: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}INSCRICAO_ESTADUAL']),
      endereco: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ENDERECO']),
      nomeMunicipio: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME_MUNICIPIO']),
      uf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UF']),
      valorServico: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_SERVICO']),
      valorBcRetencaoIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BC_RETENCAO_ICMS']),
      aliquotaRetencaoIcms: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_RETENCAO_ICMS']),
      valorIcmsRetido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ICMS_RETIDO']),
      cfop: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CFOP']),
      municipio: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}MUNICIPIO']),
      placaVeiculo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PLACA_VEICULO']),
      ufVeiculo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UF_VEICULO']),
      rntcVeiculo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RNTC_VEICULO']),
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
    if (!nullToAbsent || modalidadeFrete != null) {
      map['MODALIDADE_FRETE'] = Variable<String?>(modalidadeFrete);
    }
    if (!nullToAbsent || cnpj != null) {
      map['CNPJ'] = Variable<String?>(cnpj);
    }
    if (!nullToAbsent || cpf != null) {
      map['CPF'] = Variable<String?>(cpf);
    }
    if (!nullToAbsent || nome != null) {
      map['NOME'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || inscricaoEstadual != null) {
      map['INSCRICAO_ESTADUAL'] = Variable<String?>(inscricaoEstadual);
    }
    if (!nullToAbsent || endereco != null) {
      map['ENDERECO'] = Variable<String?>(endereco);
    }
    if (!nullToAbsent || nomeMunicipio != null) {
      map['NOME_MUNICIPIO'] = Variable<String?>(nomeMunicipio);
    }
    if (!nullToAbsent || uf != null) {
      map['UF'] = Variable<String?>(uf);
    }
    if (!nullToAbsent || valorServico != null) {
      map['VALOR_SERVICO'] = Variable<double?>(valorServico);
    }
    if (!nullToAbsent || valorBcRetencaoIcms != null) {
      map['VALOR_BC_RETENCAO_ICMS'] = Variable<double?>(valorBcRetencaoIcms);
    }
    if (!nullToAbsent || aliquotaRetencaoIcms != null) {
      map['ALIQUOTA_RETENCAO_ICMS'] = Variable<double?>(aliquotaRetencaoIcms);
    }
    if (!nullToAbsent || valorIcmsRetido != null) {
      map['VALOR_ICMS_RETIDO'] = Variable<double?>(valorIcmsRetido);
    }
    if (!nullToAbsent || cfop != null) {
      map['CFOP'] = Variable<int?>(cfop);
    }
    if (!nullToAbsent || municipio != null) {
      map['MUNICIPIO'] = Variable<int?>(municipio);
    }
    if (!nullToAbsent || placaVeiculo != null) {
      map['PLACA_VEICULO'] = Variable<String?>(placaVeiculo);
    }
    if (!nullToAbsent || ufVeiculo != null) {
      map['UF_VEICULO'] = Variable<String?>(ufVeiculo);
    }
    if (!nullToAbsent || rntcVeiculo != null) {
      map['RNTC_VEICULO'] = Variable<String?>(rntcVeiculo);
    }
    return map;
  }

  NfeTransportesCompanion toCompanion(bool nullToAbsent) {
    return NfeTransportesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      modalidadeFrete: modalidadeFrete == null && nullToAbsent
        ? const Value.absent()
        : Value(modalidadeFrete),
      cnpj: cnpj == null && nullToAbsent
        ? const Value.absent()
        : Value(cnpj),
      cpf: cpf == null && nullToAbsent
        ? const Value.absent()
        : Value(cpf),
      nome: nome == null && nullToAbsent
        ? const Value.absent()
        : Value(nome),
      inscricaoEstadual: inscricaoEstadual == null && nullToAbsent
        ? const Value.absent()
        : Value(inscricaoEstadual),
      endereco: endereco == null && nullToAbsent
        ? const Value.absent()
        : Value(endereco),
      nomeMunicipio: nomeMunicipio == null && nullToAbsent
        ? const Value.absent()
        : Value(nomeMunicipio),
      uf: uf == null && nullToAbsent
        ? const Value.absent()
        : Value(uf),
      valorServico: valorServico == null && nullToAbsent
        ? const Value.absent()
        : Value(valorServico),
      valorBcRetencaoIcms: valorBcRetencaoIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBcRetencaoIcms),
      aliquotaRetencaoIcms: aliquotaRetencaoIcms == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaRetencaoIcms),
      valorIcmsRetido: valorIcmsRetido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIcmsRetido),
      cfop: cfop == null && nullToAbsent
        ? const Value.absent()
        : Value(cfop),
      municipio: municipio == null && nullToAbsent
        ? const Value.absent()
        : Value(municipio),
      placaVeiculo: placaVeiculo == null && nullToAbsent
        ? const Value.absent()
        : Value(placaVeiculo),
      ufVeiculo: ufVeiculo == null && nullToAbsent
        ? const Value.absent()
        : Value(ufVeiculo),
      rntcVeiculo: rntcVeiculo == null && nullToAbsent
        ? const Value.absent()
        : Value(rntcVeiculo),
    );
  }

  factory NfeTransporte.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeTransporte(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      modalidadeFrete: serializer.fromJson<String>(json['modalidadeFrete']),
      cnpj: serializer.fromJson<String>(json['cnpj']),
      cpf: serializer.fromJson<String>(json['cpf']),
      nome: serializer.fromJson<String>(json['nome']),
      inscricaoEstadual: serializer.fromJson<String>(json['inscricaoEstadual']),
      endereco: serializer.fromJson<String>(json['endereco']),
      nomeMunicipio: serializer.fromJson<String>(json['nomeMunicipio']),
      uf: serializer.fromJson<String>(json['uf']),
      valorServico: serializer.fromJson<double>(json['valorServico']),
      valorBcRetencaoIcms: serializer.fromJson<double>(json['valorBcRetencaoIcms']),
      aliquotaRetencaoIcms: serializer.fromJson<double>(json['aliquotaRetencaoIcms']),
      valorIcmsRetido: serializer.fromJson<double>(json['valorIcmsRetido']),
      cfop: serializer.fromJson<int>(json['cfop']),
      municipio: serializer.fromJson<int>(json['municipio']),
      placaVeiculo: serializer.fromJson<String>(json['placaVeiculo']),
      ufVeiculo: serializer.fromJson<String>(json['ufVeiculo']),
      rntcVeiculo: serializer.fromJson<String>(json['rntcVeiculo']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'modalidadeFrete': serializer.toJson<String?>(modalidadeFrete),
      'cnpj': serializer.toJson<String?>(cnpj),
      'cpf': serializer.toJson<String?>(cpf),
      'nome': serializer.toJson<String?>(nome),
      'inscricaoEstadual': serializer.toJson<String?>(inscricaoEstadual),
      'endereco': serializer.toJson<String?>(endereco),
      'nomeMunicipio': serializer.toJson<String?>(nomeMunicipio),
      'uf': serializer.toJson<String?>(uf),
      'valorServico': serializer.toJson<double?>(valorServico),
      'valorBcRetencaoIcms': serializer.toJson<double?>(valorBcRetencaoIcms),
      'aliquotaRetencaoIcms': serializer.toJson<double?>(aliquotaRetencaoIcms),
      'valorIcmsRetido': serializer.toJson<double?>(valorIcmsRetido),
      'cfop': serializer.toJson<int?>(cfop),
      'municipio': serializer.toJson<int?>(municipio),
      'placaVeiculo': serializer.toJson<String?>(placaVeiculo),
      'ufVeiculo': serializer.toJson<String?>(ufVeiculo),
      'rntcVeiculo': serializer.toJson<String?>(rntcVeiculo),
    };
  }

  NfeTransporte copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          String? modalidadeFrete,
          String? cnpj,
          String? cpf,
          String? nome,
          String? inscricaoEstadual,
          String? endereco,
          String? nomeMunicipio,
          String? uf,
          double? valorServico,
          double? valorBcRetencaoIcms,
          double? aliquotaRetencaoIcms,
          double? valorIcmsRetido,
          int? cfop,
          int? municipio,
          String? placaVeiculo,
          String? ufVeiculo,
          String? rntcVeiculo,
		}) =>
      NfeTransporte(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        modalidadeFrete: modalidadeFrete ?? this.modalidadeFrete,
        cnpj: cnpj ?? this.cnpj,
        cpf: cpf ?? this.cpf,
        nome: nome ?? this.nome,
        inscricaoEstadual: inscricaoEstadual ?? this.inscricaoEstadual,
        endereco: endereco ?? this.endereco,
        nomeMunicipio: nomeMunicipio ?? this.nomeMunicipio,
        uf: uf ?? this.uf,
        valorServico: valorServico ?? this.valorServico,
        valorBcRetencaoIcms: valorBcRetencaoIcms ?? this.valorBcRetencaoIcms,
        aliquotaRetencaoIcms: aliquotaRetencaoIcms ?? this.aliquotaRetencaoIcms,
        valorIcmsRetido: valorIcmsRetido ?? this.valorIcmsRetido,
        cfop: cfop ?? this.cfop,
        municipio: municipio ?? this.municipio,
        placaVeiculo: placaVeiculo ?? this.placaVeiculo,
        ufVeiculo: ufVeiculo ?? this.ufVeiculo,
        rntcVeiculo: rntcVeiculo ?? this.rntcVeiculo,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeTransporte(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('modalidadeFrete: $modalidadeFrete, ')
          ..write('cnpj: $cnpj, ')
          ..write('cpf: $cpf, ')
          ..write('nome: $nome, ')
          ..write('inscricaoEstadual: $inscricaoEstadual, ')
          ..write('endereco: $endereco, ')
          ..write('nomeMunicipio: $nomeMunicipio, ')
          ..write('uf: $uf, ')
          ..write('valorServico: $valorServico, ')
          ..write('valorBcRetencaoIcms: $valorBcRetencaoIcms, ')
          ..write('aliquotaRetencaoIcms: $aliquotaRetencaoIcms, ')
          ..write('valorIcmsRetido: $valorIcmsRetido, ')
          ..write('cfop: $cfop, ')
          ..write('municipio: $municipio, ')
          ..write('placaVeiculo: $placaVeiculo, ')
          ..write('ufVeiculo: $ufVeiculo, ')
          ..write('rntcVeiculo: $rntcVeiculo, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      modalidadeFrete,
      cnpj,
      cpf,
      nome,
      inscricaoEstadual,
      endereco,
      nomeMunicipio,
      uf,
      valorServico,
      valorBcRetencaoIcms,
      aliquotaRetencaoIcms,
      valorIcmsRetido,
      cfop,
      municipio,
      placaVeiculo,
      ufVeiculo,
      rntcVeiculo,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeTransporte &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.modalidadeFrete == modalidadeFrete &&
          other.cnpj == cnpj &&
          other.cpf == cpf &&
          other.nome == nome &&
          other.inscricaoEstadual == inscricaoEstadual &&
          other.endereco == endereco &&
          other.nomeMunicipio == nomeMunicipio &&
          other.uf == uf &&
          other.valorServico == valorServico &&
          other.valorBcRetencaoIcms == valorBcRetencaoIcms &&
          other.aliquotaRetencaoIcms == aliquotaRetencaoIcms &&
          other.valorIcmsRetido == valorIcmsRetido &&
          other.cfop == cfop &&
          other.municipio == municipio &&
          other.placaVeiculo == placaVeiculo &&
          other.ufVeiculo == ufVeiculo &&
          other.rntcVeiculo == rntcVeiculo 
	   );
}

class NfeTransportesCompanion extends UpdateCompanion<NfeTransporte> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<String?> modalidadeFrete;
  final Value<String?> cnpj;
  final Value<String?> cpf;
  final Value<String?> nome;
  final Value<String?> inscricaoEstadual;
  final Value<String?> endereco;
  final Value<String?> nomeMunicipio;
  final Value<String?> uf;
  final Value<double?> valorServico;
  final Value<double?> valorBcRetencaoIcms;
  final Value<double?> aliquotaRetencaoIcms;
  final Value<double?> valorIcmsRetido;
  final Value<int?> cfop;
  final Value<int?> municipio;
  final Value<String?> placaVeiculo;
  final Value<String?> ufVeiculo;
  final Value<String?> rntcVeiculo;

  const NfeTransportesCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.modalidadeFrete = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.cpf = const Value.absent(),
    this.nome = const Value.absent(),
    this.inscricaoEstadual = const Value.absent(),
    this.endereco = const Value.absent(),
    this.nomeMunicipio = const Value.absent(),
    this.uf = const Value.absent(),
    this.valorServico = const Value.absent(),
    this.valorBcRetencaoIcms = const Value.absent(),
    this.aliquotaRetencaoIcms = const Value.absent(),
    this.valorIcmsRetido = const Value.absent(),
    this.cfop = const Value.absent(),
    this.municipio = const Value.absent(),
    this.placaVeiculo = const Value.absent(),
    this.ufVeiculo = const Value.absent(),
    this.rntcVeiculo = const Value.absent(),
  });

  NfeTransportesCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.modalidadeFrete = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.cpf = const Value.absent(),
    this.nome = const Value.absent(),
    this.inscricaoEstadual = const Value.absent(),
    this.endereco = const Value.absent(),
    this.nomeMunicipio = const Value.absent(),
    this.uf = const Value.absent(),
    this.valorServico = const Value.absent(),
    this.valorBcRetencaoIcms = const Value.absent(),
    this.aliquotaRetencaoIcms = const Value.absent(),
    this.valorIcmsRetido = const Value.absent(),
    this.cfop = const Value.absent(),
    this.municipio = const Value.absent(),
    this.placaVeiculo = const Value.absent(),
    this.ufVeiculo = const Value.absent(),
    this.rntcVeiculo = const Value.absent(),
  });

  static Insertable<NfeTransporte> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<String>? modalidadeFrete,
    Expression<String>? cnpj,
    Expression<String>? cpf,
    Expression<String>? nome,
    Expression<String>? inscricaoEstadual,
    Expression<String>? endereco,
    Expression<String>? nomeMunicipio,
    Expression<String>? uf,
    Expression<double>? valorServico,
    Expression<double>? valorBcRetencaoIcms,
    Expression<double>? aliquotaRetencaoIcms,
    Expression<double>? valorIcmsRetido,
    Expression<int>? cfop,
    Expression<int>? municipio,
    Expression<String>? placaVeiculo,
    Expression<String>? ufVeiculo,
    Expression<String>? rntcVeiculo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (modalidadeFrete != null) 'MODALIDADE_FRETE': modalidadeFrete,
      if (cnpj != null) 'CNPJ': cnpj,
      if (cpf != null) 'CPF': cpf,
      if (nome != null) 'NOME': nome,
      if (inscricaoEstadual != null) 'INSCRICAO_ESTADUAL': inscricaoEstadual,
      if (endereco != null) 'ENDERECO': endereco,
      if (nomeMunicipio != null) 'NOME_MUNICIPIO': nomeMunicipio,
      if (uf != null) 'UF': uf,
      if (valorServico != null) 'VALOR_SERVICO': valorServico,
      if (valorBcRetencaoIcms != null) 'VALOR_BC_RETENCAO_ICMS': valorBcRetencaoIcms,
      if (aliquotaRetencaoIcms != null) 'ALIQUOTA_RETENCAO_ICMS': aliquotaRetencaoIcms,
      if (valorIcmsRetido != null) 'VALOR_ICMS_RETIDO': valorIcmsRetido,
      if (cfop != null) 'CFOP': cfop,
      if (municipio != null) 'MUNICIPIO': municipio,
      if (placaVeiculo != null) 'PLACA_VEICULO': placaVeiculo,
      if (ufVeiculo != null) 'UF_VEICULO': ufVeiculo,
      if (rntcVeiculo != null) 'RNTC_VEICULO': rntcVeiculo,
    });
  }

  NfeTransportesCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<String>? modalidadeFrete,
      Value<String>? cnpj,
      Value<String>? cpf,
      Value<String>? nome,
      Value<String>? inscricaoEstadual,
      Value<String>? endereco,
      Value<String>? nomeMunicipio,
      Value<String>? uf,
      Value<double>? valorServico,
      Value<double>? valorBcRetencaoIcms,
      Value<double>? aliquotaRetencaoIcms,
      Value<double>? valorIcmsRetido,
      Value<int>? cfop,
      Value<int>? municipio,
      Value<String>? placaVeiculo,
      Value<String>? ufVeiculo,
      Value<String>? rntcVeiculo,
	  }) {
    return NfeTransportesCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      modalidadeFrete: modalidadeFrete ?? this.modalidadeFrete,
      cnpj: cnpj ?? this.cnpj,
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      inscricaoEstadual: inscricaoEstadual ?? this.inscricaoEstadual,
      endereco: endereco ?? this.endereco,
      nomeMunicipio: nomeMunicipio ?? this.nomeMunicipio,
      uf: uf ?? this.uf,
      valorServico: valorServico ?? this.valorServico,
      valorBcRetencaoIcms: valorBcRetencaoIcms ?? this.valorBcRetencaoIcms,
      aliquotaRetencaoIcms: aliquotaRetencaoIcms ?? this.aliquotaRetencaoIcms,
      valorIcmsRetido: valorIcmsRetido ?? this.valorIcmsRetido,
      cfop: cfop ?? this.cfop,
      municipio: municipio ?? this.municipio,
      placaVeiculo: placaVeiculo ?? this.placaVeiculo,
      ufVeiculo: ufVeiculo ?? this.ufVeiculo,
      rntcVeiculo: rntcVeiculo ?? this.rntcVeiculo,
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
    if (modalidadeFrete.present) {
      map['MODALIDADE_FRETE'] = Variable<String?>(modalidadeFrete.value);
    }
    if (cnpj.present) {
      map['CNPJ'] = Variable<String?>(cnpj.value);
    }
    if (cpf.present) {
      map['CPF'] = Variable<String?>(cpf.value);
    }
    if (nome.present) {
      map['NOME'] = Variable<String?>(nome.value);
    }
    if (inscricaoEstadual.present) {
      map['INSCRICAO_ESTADUAL'] = Variable<String?>(inscricaoEstadual.value);
    }
    if (endereco.present) {
      map['ENDERECO'] = Variable<String?>(endereco.value);
    }
    if (nomeMunicipio.present) {
      map['NOME_MUNICIPIO'] = Variable<String?>(nomeMunicipio.value);
    }
    if (uf.present) {
      map['UF'] = Variable<String?>(uf.value);
    }
    if (valorServico.present) {
      map['VALOR_SERVICO'] = Variable<double?>(valorServico.value);
    }
    if (valorBcRetencaoIcms.present) {
      map['VALOR_BC_RETENCAO_ICMS'] = Variable<double?>(valorBcRetencaoIcms.value);
    }
    if (aliquotaRetencaoIcms.present) {
      map['ALIQUOTA_RETENCAO_ICMS'] = Variable<double?>(aliquotaRetencaoIcms.value);
    }
    if (valorIcmsRetido.present) {
      map['VALOR_ICMS_RETIDO'] = Variable<double?>(valorIcmsRetido.value);
    }
    if (cfop.present) {
      map['CFOP'] = Variable<int?>(cfop.value);
    }
    if (municipio.present) {
      map['MUNICIPIO'] = Variable<int?>(municipio.value);
    }
    if (placaVeiculo.present) {
      map['PLACA_VEICULO'] = Variable<String?>(placaVeiculo.value);
    }
    if (ufVeiculo.present) {
      map['UF_VEICULO'] = Variable<String?>(ufVeiculo.value);
    }
    if (rntcVeiculo.present) {
      map['RNTC_VEICULO'] = Variable<String?>(rntcVeiculo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeTransportesCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('modalidadeFrete: $modalidadeFrete, ')
          ..write('cnpj: $cnpj, ')
          ..write('cpf: $cpf, ')
          ..write('nome: $nome, ')
          ..write('inscricaoEstadual: $inscricaoEstadual, ')
          ..write('endereco: $endereco, ')
          ..write('nomeMunicipio: $nomeMunicipio, ')
          ..write('uf: $uf, ')
          ..write('valorServico: $valorServico, ')
          ..write('valorBcRetencaoIcms: $valorBcRetencaoIcms, ')
          ..write('aliquotaRetencaoIcms: $aliquotaRetencaoIcms, ')
          ..write('valorIcmsRetido: $valorIcmsRetido, ')
          ..write('cfop: $cfop, ')
          ..write('municipio: $municipio, ')
          ..write('placaVeiculo: $placaVeiculo, ')
          ..write('ufVeiculo: $ufVeiculo, ')
          ..write('rntcVeiculo: $rntcVeiculo, ')
          ..write(')'))
        .toString();
  }
}

class $NfeTransportesTable extends NfeTransportes
    with TableInfo<$NfeTransportesTable, NfeTransporte> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeTransportesTable(this._db, [this._alias]);
  
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
  final VerificationMeta _modalidadeFreteMeta =
      const VerificationMeta('modalidadeFrete');
  GeneratedColumn<String>? _modalidadeFrete;
  @override
  GeneratedColumn<String> get modalidadeFrete => _modalidadeFrete ??=
      GeneratedColumn<String>('MODALIDADE_FRETE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
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
  final VerificationMeta _nomeMeta =
      const VerificationMeta('nome');
  GeneratedColumn<String>? _nome;
  @override
  GeneratedColumn<String> get nome => _nome ??=
      GeneratedColumn<String>('NOME', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _inscricaoEstadualMeta =
      const VerificationMeta('inscricaoEstadual');
  GeneratedColumn<String>? _inscricaoEstadual;
  @override
  GeneratedColumn<String> get inscricaoEstadual => _inscricaoEstadual ??=
      GeneratedColumn<String>('INSCRICAO_ESTADUAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _enderecoMeta =
      const VerificationMeta('endereco');
  GeneratedColumn<String>? _endereco;
  @override
  GeneratedColumn<String> get endereco => _endereco ??=
      GeneratedColumn<String>('ENDERECO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
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
  final VerificationMeta _valorServicoMeta =
      const VerificationMeta('valorServico');
  GeneratedColumn<double>? _valorServico;
  @override
  GeneratedColumn<double> get valorServico => _valorServico ??=
      GeneratedColumn<double>('VALOR_SERVICO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorBcRetencaoIcmsMeta =
      const VerificationMeta('valorBcRetencaoIcms');
  GeneratedColumn<double>? _valorBcRetencaoIcms;
  @override
  GeneratedColumn<double> get valorBcRetencaoIcms => _valorBcRetencaoIcms ??=
      GeneratedColumn<double>('VALOR_BC_RETENCAO_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaRetencaoIcmsMeta =
      const VerificationMeta('aliquotaRetencaoIcms');
  GeneratedColumn<double>? _aliquotaRetencaoIcms;
  @override
  GeneratedColumn<double> get aliquotaRetencaoIcms => _aliquotaRetencaoIcms ??=
      GeneratedColumn<double>('ALIQUOTA_RETENCAO_ICMS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIcmsRetidoMeta =
      const VerificationMeta('valorIcmsRetido');
  GeneratedColumn<double>? _valorIcmsRetido;
  @override
  GeneratedColumn<double> get valorIcmsRetido => _valorIcmsRetido ??=
      GeneratedColumn<double>('VALOR_ICMS_RETIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _cfopMeta =
      const VerificationMeta('cfop');
  GeneratedColumn<int>? _cfop;
  @override
  GeneratedColumn<int> get cfop => _cfop ??=
      GeneratedColumn<int>('CFOP', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _municipioMeta =
      const VerificationMeta('municipio');
  GeneratedColumn<int>? _municipio;
  @override
  GeneratedColumn<int> get municipio => _municipio ??=
      GeneratedColumn<int>('MUNICIPIO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _placaVeiculoMeta =
      const VerificationMeta('placaVeiculo');
  GeneratedColumn<String>? _placaVeiculo;
  @override
  GeneratedColumn<String> get placaVeiculo => _placaVeiculo ??=
      GeneratedColumn<String>('PLACA_VEICULO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ufVeiculoMeta =
      const VerificationMeta('ufVeiculo');
  GeneratedColumn<String>? _ufVeiculo;
  @override
  GeneratedColumn<String> get ufVeiculo => _ufVeiculo ??=
      GeneratedColumn<String>('UF_VEICULO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _rntcVeiculoMeta =
      const VerificationMeta('rntcVeiculo');
  GeneratedColumn<String>? _rntcVeiculo;
  @override
  GeneratedColumn<String> get rntcVeiculo => _rntcVeiculo ??=
      GeneratedColumn<String>('RNTC_VEICULO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        modalidadeFrete,
        cnpj,
        cpf,
        nome,
        inscricaoEstadual,
        endereco,
        nomeMunicipio,
        uf,
        valorServico,
        valorBcRetencaoIcms,
        aliquotaRetencaoIcms,
        valorIcmsRetido,
        cfop,
        municipio,
        placaVeiculo,
        ufVeiculo,
        rntcVeiculo,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_TRANSPORTE';
  
  @override
  String get actualTableName => 'NFE_TRANSPORTE';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeTransporte> instance,
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
    if (data.containsKey('MODALIDADE_FRETE')) {
        context.handle(_modalidadeFreteMeta,
            modalidadeFrete.isAcceptableOrUnknown(data['MODALIDADE_FRETE']!, _modalidadeFreteMeta));
    }
    if (data.containsKey('CNPJ')) {
        context.handle(_cnpjMeta,
            cnpj.isAcceptableOrUnknown(data['CNPJ']!, _cnpjMeta));
    }
    if (data.containsKey('CPF')) {
        context.handle(_cpfMeta,
            cpf.isAcceptableOrUnknown(data['CPF']!, _cpfMeta));
    }
    if (data.containsKey('NOME')) {
        context.handle(_nomeMeta,
            nome.isAcceptableOrUnknown(data['NOME']!, _nomeMeta));
    }
    if (data.containsKey('INSCRICAO_ESTADUAL')) {
        context.handle(_inscricaoEstadualMeta,
            inscricaoEstadual.isAcceptableOrUnknown(data['INSCRICAO_ESTADUAL']!, _inscricaoEstadualMeta));
    }
    if (data.containsKey('ENDERECO')) {
        context.handle(_enderecoMeta,
            endereco.isAcceptableOrUnknown(data['ENDERECO']!, _enderecoMeta));
    }
    if (data.containsKey('NOME_MUNICIPIO')) {
        context.handle(_nomeMunicipioMeta,
            nomeMunicipio.isAcceptableOrUnknown(data['NOME_MUNICIPIO']!, _nomeMunicipioMeta));
    }
    if (data.containsKey('UF')) {
        context.handle(_ufMeta,
            uf.isAcceptableOrUnknown(data['UF']!, _ufMeta));
    }
    if (data.containsKey('VALOR_SERVICO')) {
        context.handle(_valorServicoMeta,
            valorServico.isAcceptableOrUnknown(data['VALOR_SERVICO']!, _valorServicoMeta));
    }
    if (data.containsKey('VALOR_BC_RETENCAO_ICMS')) {
        context.handle(_valorBcRetencaoIcmsMeta,
            valorBcRetencaoIcms.isAcceptableOrUnknown(data['VALOR_BC_RETENCAO_ICMS']!, _valorBcRetencaoIcmsMeta));
    }
    if (data.containsKey('ALIQUOTA_RETENCAO_ICMS')) {
        context.handle(_aliquotaRetencaoIcmsMeta,
            aliquotaRetencaoIcms.isAcceptableOrUnknown(data['ALIQUOTA_RETENCAO_ICMS']!, _aliquotaRetencaoIcmsMeta));
    }
    if (data.containsKey('VALOR_ICMS_RETIDO')) {
        context.handle(_valorIcmsRetidoMeta,
            valorIcmsRetido.isAcceptableOrUnknown(data['VALOR_ICMS_RETIDO']!, _valorIcmsRetidoMeta));
    }
    if (data.containsKey('CFOP')) {
        context.handle(_cfopMeta,
            cfop.isAcceptableOrUnknown(data['CFOP']!, _cfopMeta));
    }
    if (data.containsKey('MUNICIPIO')) {
        context.handle(_municipioMeta,
            municipio.isAcceptableOrUnknown(data['MUNICIPIO']!, _municipioMeta));
    }
    if (data.containsKey('PLACA_VEICULO')) {
        context.handle(_placaVeiculoMeta,
            placaVeiculo.isAcceptableOrUnknown(data['PLACA_VEICULO']!, _placaVeiculoMeta));
    }
    if (data.containsKey('UF_VEICULO')) {
        context.handle(_ufVeiculoMeta,
            ufVeiculo.isAcceptableOrUnknown(data['UF_VEICULO']!, _ufVeiculoMeta));
    }
    if (data.containsKey('RNTC_VEICULO')) {
        context.handle(_rntcVeiculoMeta,
            rntcVeiculo.isAcceptableOrUnknown(data['RNTC_VEICULO']!, _rntcVeiculoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeTransporte map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeTransporte.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeTransportesTable createAlias(String alias) {
    return $NfeTransportesTable(_db, alias);
  }
}