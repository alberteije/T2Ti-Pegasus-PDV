/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DET_ESPECIFICO_VEICULO] 
                                                                                
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

@DataClassName("NfeDetEspecificoVeiculo")
@UseRowClass(NfeDetEspecificoVeiculo)
class NfeDetEspecificoVeiculos extends Table {
  @override
  String get tableName => 'NFE_DET_ESPECIFICO_VEICULO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  TextColumn get tipoOperacao => text().named('TIPO_OPERACAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get chassi => text().named('CHASSI').withLength(min: 0, max: 17).nullable()();
  TextColumn get cor => text().named('COR').withLength(min: 0, max: 4).nullable()();
  TextColumn get descricaoCor => text().named('DESCRICAO_COR').withLength(min: 0, max: 40).nullable()();
  TextColumn get potenciaMotor => text().named('POTENCIA_MOTOR').withLength(min: 0, max: 4).nullable()();
  TextColumn get cilindradas => text().named('CILINDRADAS').withLength(min: 0, max: 4).nullable()();
  TextColumn get pesoLiquido => text().named('PESO_LIQUIDO').withLength(min: 0, max: 9).nullable()();
  TextColumn get pesoBruto => text().named('PESO_BRUTO').withLength(min: 0, max: 9).nullable()();
  TextColumn get numeroSerie => text().named('NUMERO_SERIE').withLength(min: 0, max: 9).nullable()();
  TextColumn get tipoCombustivel => text().named('TIPO_COMBUSTIVEL').withLength(min: 0, max: 2).nullable()();
  TextColumn get numeroMotor => text().named('NUMERO_MOTOR').withLength(min: 0, max: 21).nullable()();
  TextColumn get capacidadeMaximaTracao => text().named('CAPACIDADE_MAXIMA_TRACAO').withLength(min: 0, max: 9).nullable()();
  TextColumn get distanciaEixos => text().named('DISTANCIA_EIXOS').withLength(min: 0, max: 4).nullable()();
  TextColumn get anoModelo => text().named('ANO_MODELO').withLength(min: 0, max: 4).nullable()();
  TextColumn get anoFabricacao => text().named('ANO_FABRICACAO').withLength(min: 0, max: 4).nullable()();
  TextColumn get tipoPintura => text().named('TIPO_PINTURA').withLength(min: 0, max: 1).nullable()();
  TextColumn get tipoVeiculo => text().named('TIPO_VEICULO').withLength(min: 0, max: 2).nullable()();
  TextColumn get especieVeiculo => text().named('ESPECIE_VEICULO').withLength(min: 0, max: 1).nullable()();
  TextColumn get condicaoVin => text().named('CONDICAO_VIN').withLength(min: 0, max: 1).nullable()();
  TextColumn get condicaoVeiculo => text().named('CONDICAO_VEICULO').withLength(min: 0, max: 1).nullable()();
  TextColumn get codigoMarcaModelo => text().named('CODIGO_MARCA_MODELO').withLength(min: 0, max: 6).nullable()();
  TextColumn get codigoCorDenatran => text().named('CODIGO_COR_DENATRAN').withLength(min: 0, max: 2).nullable()();
  IntColumn get lotacaoMaxima => integer().named('LOTACAO_MAXIMA').nullable()();
  TextColumn get restricao => text().named('RESTRICAO').withLength(min: 0, max: 1).nullable()();
}

class NfeDetEspecificoVeiculo extends DataClass implements Insertable<NfeDetEspecificoVeiculo> {
  final int? id;
  final int? idNfeDetalhe;
  final String? tipoOperacao;
  final String? chassi;
  final String? cor;
  final String? descricaoCor;
  final String? potenciaMotor;
  final String? cilindradas;
  final String? pesoLiquido;
  final String? pesoBruto;
  final String? numeroSerie;
  final String? tipoCombustivel;
  final String? numeroMotor;
  final String? capacidadeMaximaTracao;
  final String? distanciaEixos;
  final String? anoModelo;
  final String? anoFabricacao;
  final String? tipoPintura;
  final String? tipoVeiculo;
  final String? especieVeiculo;
  final String? condicaoVin;
  final String? condicaoVeiculo;
  final String? codigoMarcaModelo;
  final String? codigoCorDenatran;
  final int? lotacaoMaxima;
  final String? restricao;

  NfeDetEspecificoVeiculo(
    {
      required this.id,
      this.idNfeDetalhe,
      this.tipoOperacao,
      this.chassi,
      this.cor,
      this.descricaoCor,
      this.potenciaMotor,
      this.cilindradas,
      this.pesoLiquido,
      this.pesoBruto,
      this.numeroSerie,
      this.tipoCombustivel,
      this.numeroMotor,
      this.capacidadeMaximaTracao,
      this.distanciaEixos,
      this.anoModelo,
      this.anoFabricacao,
      this.tipoPintura,
      this.tipoVeiculo,
      this.especieVeiculo,
      this.condicaoVin,
      this.condicaoVeiculo,
      this.codigoMarcaModelo,
      this.codigoCorDenatran,
      this.lotacaoMaxima,
      this.restricao,
    }
  );

  factory NfeDetEspecificoVeiculo.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetEspecificoVeiculo(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      tipoOperacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_OPERACAO']),
      chassi: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CHASSI']),
      cor: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}COR']),
      descricaoCor: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO_COR']),
      potenciaMotor: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}POTENCIA_MOTOR']),
      cilindradas: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CILINDRADAS']),
      pesoLiquido: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PESO_LIQUIDO']),
      pesoBruto: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PESO_BRUTO']),
      numeroSerie: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_SERIE']),
      tipoCombustivel: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_COMBUSTIVEL']),
      numeroMotor: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_MOTOR']),
      capacidadeMaximaTracao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CAPACIDADE_MAXIMA_TRACAO']),
      distanciaEixos: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DISTANCIA_EIXOS']),
      anoModelo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ANO_MODELO']),
      anoFabricacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ANO_FABRICACAO']),
      tipoPintura: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_PINTURA']),
      tipoVeiculo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_VEICULO']),
      especieVeiculo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ESPECIE_VEICULO']),
      condicaoVin: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CONDICAO_VIN']),
      condicaoVeiculo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CONDICAO_VEICULO']),
      codigoMarcaModelo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_MARCA_MODELO']),
      codigoCorDenatran: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_COR_DENATRAN']),
      lotacaoMaxima: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}LOTACAO_MAXIMA']),
      restricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RESTRICAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeDetalhe != null) {
      map['ID_NFE_DETALHE'] = Variable<int?>(idNfeDetalhe);
    }
    if (!nullToAbsent || tipoOperacao != null) {
      map['TIPO_OPERACAO'] = Variable<String?>(tipoOperacao);
    }
    if (!nullToAbsent || chassi != null) {
      map['CHASSI'] = Variable<String?>(chassi);
    }
    if (!nullToAbsent || cor != null) {
      map['COR'] = Variable<String?>(cor);
    }
    if (!nullToAbsent || descricaoCor != null) {
      map['DESCRICAO_COR'] = Variable<String?>(descricaoCor);
    }
    if (!nullToAbsent || potenciaMotor != null) {
      map['POTENCIA_MOTOR'] = Variable<String?>(potenciaMotor);
    }
    if (!nullToAbsent || cilindradas != null) {
      map['CILINDRADAS'] = Variable<String?>(cilindradas);
    }
    if (!nullToAbsent || pesoLiquido != null) {
      map['PESO_LIQUIDO'] = Variable<String?>(pesoLiquido);
    }
    if (!nullToAbsent || pesoBruto != null) {
      map['PESO_BRUTO'] = Variable<String?>(pesoBruto);
    }
    if (!nullToAbsent || numeroSerie != null) {
      map['NUMERO_SERIE'] = Variable<String?>(numeroSerie);
    }
    if (!nullToAbsent || tipoCombustivel != null) {
      map['TIPO_COMBUSTIVEL'] = Variable<String?>(tipoCombustivel);
    }
    if (!nullToAbsent || numeroMotor != null) {
      map['NUMERO_MOTOR'] = Variable<String?>(numeroMotor);
    }
    if (!nullToAbsent || capacidadeMaximaTracao != null) {
      map['CAPACIDADE_MAXIMA_TRACAO'] = Variable<String?>(capacidadeMaximaTracao);
    }
    if (!nullToAbsent || distanciaEixos != null) {
      map['DISTANCIA_EIXOS'] = Variable<String?>(distanciaEixos);
    }
    if (!nullToAbsent || anoModelo != null) {
      map['ANO_MODELO'] = Variable<String?>(anoModelo);
    }
    if (!nullToAbsent || anoFabricacao != null) {
      map['ANO_FABRICACAO'] = Variable<String?>(anoFabricacao);
    }
    if (!nullToAbsent || tipoPintura != null) {
      map['TIPO_PINTURA'] = Variable<String?>(tipoPintura);
    }
    if (!nullToAbsent || tipoVeiculo != null) {
      map['TIPO_VEICULO'] = Variable<String?>(tipoVeiculo);
    }
    if (!nullToAbsent || especieVeiculo != null) {
      map['ESPECIE_VEICULO'] = Variable<String?>(especieVeiculo);
    }
    if (!nullToAbsent || condicaoVin != null) {
      map['CONDICAO_VIN'] = Variable<String?>(condicaoVin);
    }
    if (!nullToAbsent || condicaoVeiculo != null) {
      map['CONDICAO_VEICULO'] = Variable<String?>(condicaoVeiculo);
    }
    if (!nullToAbsent || codigoMarcaModelo != null) {
      map['CODIGO_MARCA_MODELO'] = Variable<String?>(codigoMarcaModelo);
    }
    if (!nullToAbsent || codigoCorDenatran != null) {
      map['CODIGO_COR_DENATRAN'] = Variable<String?>(codigoCorDenatran);
    }
    if (!nullToAbsent || lotacaoMaxima != null) {
      map['LOTACAO_MAXIMA'] = Variable<int?>(lotacaoMaxima);
    }
    if (!nullToAbsent || restricao != null) {
      map['RESTRICAO'] = Variable<String?>(restricao);
    }
    return map;
  }

  NfeDetEspecificoVeiculosCompanion toCompanion(bool nullToAbsent) {
    return NfeDetEspecificoVeiculosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      tipoOperacao: tipoOperacao == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoOperacao),
      chassi: chassi == null && nullToAbsent
        ? const Value.absent()
        : Value(chassi),
      cor: cor == null && nullToAbsent
        ? const Value.absent()
        : Value(cor),
      descricaoCor: descricaoCor == null && nullToAbsent
        ? const Value.absent()
        : Value(descricaoCor),
      potenciaMotor: potenciaMotor == null && nullToAbsent
        ? const Value.absent()
        : Value(potenciaMotor),
      cilindradas: cilindradas == null && nullToAbsent
        ? const Value.absent()
        : Value(cilindradas),
      pesoLiquido: pesoLiquido == null && nullToAbsent
        ? const Value.absent()
        : Value(pesoLiquido),
      pesoBruto: pesoBruto == null && nullToAbsent
        ? const Value.absent()
        : Value(pesoBruto),
      numeroSerie: numeroSerie == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroSerie),
      tipoCombustivel: tipoCombustivel == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoCombustivel),
      numeroMotor: numeroMotor == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroMotor),
      capacidadeMaximaTracao: capacidadeMaximaTracao == null && nullToAbsent
        ? const Value.absent()
        : Value(capacidadeMaximaTracao),
      distanciaEixos: distanciaEixos == null && nullToAbsent
        ? const Value.absent()
        : Value(distanciaEixos),
      anoModelo: anoModelo == null && nullToAbsent
        ? const Value.absent()
        : Value(anoModelo),
      anoFabricacao: anoFabricacao == null && nullToAbsent
        ? const Value.absent()
        : Value(anoFabricacao),
      tipoPintura: tipoPintura == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoPintura),
      tipoVeiculo: tipoVeiculo == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoVeiculo),
      especieVeiculo: especieVeiculo == null && nullToAbsent
        ? const Value.absent()
        : Value(especieVeiculo),
      condicaoVin: condicaoVin == null && nullToAbsent
        ? const Value.absent()
        : Value(condicaoVin),
      condicaoVeiculo: condicaoVeiculo == null && nullToAbsent
        ? const Value.absent()
        : Value(condicaoVeiculo),
      codigoMarcaModelo: codigoMarcaModelo == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoMarcaModelo),
      codigoCorDenatran: codigoCorDenatran == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoCorDenatran),
      lotacaoMaxima: lotacaoMaxima == null && nullToAbsent
        ? const Value.absent()
        : Value(lotacaoMaxima),
      restricao: restricao == null && nullToAbsent
        ? const Value.absent()
        : Value(restricao),
    );
  }

  factory NfeDetEspecificoVeiculo.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetEspecificoVeiculo(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      tipoOperacao: serializer.fromJson<String>(json['tipoOperacao']),
      chassi: serializer.fromJson<String>(json['chassi']),
      cor: serializer.fromJson<String>(json['cor']),
      descricaoCor: serializer.fromJson<String>(json['descricaoCor']),
      potenciaMotor: serializer.fromJson<String>(json['potenciaMotor']),
      cilindradas: serializer.fromJson<String>(json['cilindradas']),
      pesoLiquido: serializer.fromJson<String>(json['pesoLiquido']),
      pesoBruto: serializer.fromJson<String>(json['pesoBruto']),
      numeroSerie: serializer.fromJson<String>(json['numeroSerie']),
      tipoCombustivel: serializer.fromJson<String>(json['tipoCombustivel']),
      numeroMotor: serializer.fromJson<String>(json['numeroMotor']),
      capacidadeMaximaTracao: serializer.fromJson<String>(json['capacidadeMaximaTracao']),
      distanciaEixos: serializer.fromJson<String>(json['distanciaEixos']),
      anoModelo: serializer.fromJson<String>(json['anoModelo']),
      anoFabricacao: serializer.fromJson<String>(json['anoFabricacao']),
      tipoPintura: serializer.fromJson<String>(json['tipoPintura']),
      tipoVeiculo: serializer.fromJson<String>(json['tipoVeiculo']),
      especieVeiculo: serializer.fromJson<String>(json['especieVeiculo']),
      condicaoVin: serializer.fromJson<String>(json['condicaoVin']),
      condicaoVeiculo: serializer.fromJson<String>(json['condicaoVeiculo']),
      codigoMarcaModelo: serializer.fromJson<String>(json['codigoMarcaModelo']),
      codigoCorDenatran: serializer.fromJson<String>(json['codigoCorDenatran']),
      lotacaoMaxima: serializer.fromJson<int>(json['lotacaoMaxima']),
      restricao: serializer.fromJson<String>(json['restricao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'tipoOperacao': serializer.toJson<String?>(tipoOperacao),
      'chassi': serializer.toJson<String?>(chassi),
      'cor': serializer.toJson<String?>(cor),
      'descricaoCor': serializer.toJson<String?>(descricaoCor),
      'potenciaMotor': serializer.toJson<String?>(potenciaMotor),
      'cilindradas': serializer.toJson<String?>(cilindradas),
      'pesoLiquido': serializer.toJson<String?>(pesoLiquido),
      'pesoBruto': serializer.toJson<String?>(pesoBruto),
      'numeroSerie': serializer.toJson<String?>(numeroSerie),
      'tipoCombustivel': serializer.toJson<String?>(tipoCombustivel),
      'numeroMotor': serializer.toJson<String?>(numeroMotor),
      'capacidadeMaximaTracao': serializer.toJson<String?>(capacidadeMaximaTracao),
      'distanciaEixos': serializer.toJson<String?>(distanciaEixos),
      'anoModelo': serializer.toJson<String?>(anoModelo),
      'anoFabricacao': serializer.toJson<String?>(anoFabricacao),
      'tipoPintura': serializer.toJson<String?>(tipoPintura),
      'tipoVeiculo': serializer.toJson<String?>(tipoVeiculo),
      'especieVeiculo': serializer.toJson<String?>(especieVeiculo),
      'condicaoVin': serializer.toJson<String?>(condicaoVin),
      'condicaoVeiculo': serializer.toJson<String?>(condicaoVeiculo),
      'codigoMarcaModelo': serializer.toJson<String?>(codigoMarcaModelo),
      'codigoCorDenatran': serializer.toJson<String?>(codigoCorDenatran),
      'lotacaoMaxima': serializer.toJson<int?>(lotacaoMaxima),
      'restricao': serializer.toJson<String?>(restricao),
    };
  }

  NfeDetEspecificoVeiculo copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          String? tipoOperacao,
          String? chassi,
          String? cor,
          String? descricaoCor,
          String? potenciaMotor,
          String? cilindradas,
          String? pesoLiquido,
          String? pesoBruto,
          String? numeroSerie,
          String? tipoCombustivel,
          String? numeroMotor,
          String? capacidadeMaximaTracao,
          String? distanciaEixos,
          String? anoModelo,
          String? anoFabricacao,
          String? tipoPintura,
          String? tipoVeiculo,
          String? especieVeiculo,
          String? condicaoVin,
          String? condicaoVeiculo,
          String? codigoMarcaModelo,
          String? codigoCorDenatran,
          int? lotacaoMaxima,
          String? restricao,
		}) =>
      NfeDetEspecificoVeiculo(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        tipoOperacao: tipoOperacao ?? this.tipoOperacao,
        chassi: chassi ?? this.chassi,
        cor: cor ?? this.cor,
        descricaoCor: descricaoCor ?? this.descricaoCor,
        potenciaMotor: potenciaMotor ?? this.potenciaMotor,
        cilindradas: cilindradas ?? this.cilindradas,
        pesoLiquido: pesoLiquido ?? this.pesoLiquido,
        pesoBruto: pesoBruto ?? this.pesoBruto,
        numeroSerie: numeroSerie ?? this.numeroSerie,
        tipoCombustivel: tipoCombustivel ?? this.tipoCombustivel,
        numeroMotor: numeroMotor ?? this.numeroMotor,
        capacidadeMaximaTracao: capacidadeMaximaTracao ?? this.capacidadeMaximaTracao,
        distanciaEixos: distanciaEixos ?? this.distanciaEixos,
        anoModelo: anoModelo ?? this.anoModelo,
        anoFabricacao: anoFabricacao ?? this.anoFabricacao,
        tipoPintura: tipoPintura ?? this.tipoPintura,
        tipoVeiculo: tipoVeiculo ?? this.tipoVeiculo,
        especieVeiculo: especieVeiculo ?? this.especieVeiculo,
        condicaoVin: condicaoVin ?? this.condicaoVin,
        condicaoVeiculo: condicaoVeiculo ?? this.condicaoVeiculo,
        codigoMarcaModelo: codigoMarcaModelo ?? this.codigoMarcaModelo,
        codigoCorDenatran: codigoCorDenatran ?? this.codigoCorDenatran,
        lotacaoMaxima: lotacaoMaxima ?? this.lotacaoMaxima,
        restricao: restricao ?? this.restricao,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetEspecificoVeiculo(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('tipoOperacao: $tipoOperacao, ')
          ..write('chassi: $chassi, ')
          ..write('cor: $cor, ')
          ..write('descricaoCor: $descricaoCor, ')
          ..write('potenciaMotor: $potenciaMotor, ')
          ..write('cilindradas: $cilindradas, ')
          ..write('pesoLiquido: $pesoLiquido, ')
          ..write('pesoBruto: $pesoBruto, ')
          ..write('numeroSerie: $numeroSerie, ')
          ..write('tipoCombustivel: $tipoCombustivel, ')
          ..write('numeroMotor: $numeroMotor, ')
          ..write('capacidadeMaximaTracao: $capacidadeMaximaTracao, ')
          ..write('distanciaEixos: $distanciaEixos, ')
          ..write('anoModelo: $anoModelo, ')
          ..write('anoFabricacao: $anoFabricacao, ')
          ..write('tipoPintura: $tipoPintura, ')
          ..write('tipoVeiculo: $tipoVeiculo, ')
          ..write('especieVeiculo: $especieVeiculo, ')
          ..write('condicaoVin: $condicaoVin, ')
          ..write('condicaoVeiculo: $condicaoVeiculo, ')
          ..write('codigoMarcaModelo: $codigoMarcaModelo, ')
          ..write('codigoCorDenatran: $codigoCorDenatran, ')
          ..write('lotacaoMaxima: $lotacaoMaxima, ')
          ..write('restricao: $restricao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      tipoOperacao,
      chassi,
      cor,
      descricaoCor,
      potenciaMotor,
      cilindradas,
      pesoLiquido,
      pesoBruto,
      numeroSerie,
      tipoCombustivel,
      numeroMotor,
      capacidadeMaximaTracao,
      distanciaEixos,
      anoModelo,
      anoFabricacao,
      tipoPintura,
      tipoVeiculo,
      especieVeiculo,
      condicaoVin,
      condicaoVeiculo,
      codigoMarcaModelo,
      codigoCorDenatran,
      lotacaoMaxima,
      restricao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetEspecificoVeiculo &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.tipoOperacao == tipoOperacao &&
          other.chassi == chassi &&
          other.cor == cor &&
          other.descricaoCor == descricaoCor &&
          other.potenciaMotor == potenciaMotor &&
          other.cilindradas == cilindradas &&
          other.pesoLiquido == pesoLiquido &&
          other.pesoBruto == pesoBruto &&
          other.numeroSerie == numeroSerie &&
          other.tipoCombustivel == tipoCombustivel &&
          other.numeroMotor == numeroMotor &&
          other.capacidadeMaximaTracao == capacidadeMaximaTracao &&
          other.distanciaEixos == distanciaEixos &&
          other.anoModelo == anoModelo &&
          other.anoFabricacao == anoFabricacao &&
          other.tipoPintura == tipoPintura &&
          other.tipoVeiculo == tipoVeiculo &&
          other.especieVeiculo == especieVeiculo &&
          other.condicaoVin == condicaoVin &&
          other.condicaoVeiculo == condicaoVeiculo &&
          other.codigoMarcaModelo == codigoMarcaModelo &&
          other.codigoCorDenatran == codigoCorDenatran &&
          other.lotacaoMaxima == lotacaoMaxima &&
          other.restricao == restricao 
	   );
}

class NfeDetEspecificoVeiculosCompanion extends UpdateCompanion<NfeDetEspecificoVeiculo> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<String?> tipoOperacao;
  final Value<String?> chassi;
  final Value<String?> cor;
  final Value<String?> descricaoCor;
  final Value<String?> potenciaMotor;
  final Value<String?> cilindradas;
  final Value<String?> pesoLiquido;
  final Value<String?> pesoBruto;
  final Value<String?> numeroSerie;
  final Value<String?> tipoCombustivel;
  final Value<String?> numeroMotor;
  final Value<String?> capacidadeMaximaTracao;
  final Value<String?> distanciaEixos;
  final Value<String?> anoModelo;
  final Value<String?> anoFabricacao;
  final Value<String?> tipoPintura;
  final Value<String?> tipoVeiculo;
  final Value<String?> especieVeiculo;
  final Value<String?> condicaoVin;
  final Value<String?> condicaoVeiculo;
  final Value<String?> codigoMarcaModelo;
  final Value<String?> codigoCorDenatran;
  final Value<int?> lotacaoMaxima;
  final Value<String?> restricao;

  const NfeDetEspecificoVeiculosCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.tipoOperacao = const Value.absent(),
    this.chassi = const Value.absent(),
    this.cor = const Value.absent(),
    this.descricaoCor = const Value.absent(),
    this.potenciaMotor = const Value.absent(),
    this.cilindradas = const Value.absent(),
    this.pesoLiquido = const Value.absent(),
    this.pesoBruto = const Value.absent(),
    this.numeroSerie = const Value.absent(),
    this.tipoCombustivel = const Value.absent(),
    this.numeroMotor = const Value.absent(),
    this.capacidadeMaximaTracao = const Value.absent(),
    this.distanciaEixos = const Value.absent(),
    this.anoModelo = const Value.absent(),
    this.anoFabricacao = const Value.absent(),
    this.tipoPintura = const Value.absent(),
    this.tipoVeiculo = const Value.absent(),
    this.especieVeiculo = const Value.absent(),
    this.condicaoVin = const Value.absent(),
    this.condicaoVeiculo = const Value.absent(),
    this.codigoMarcaModelo = const Value.absent(),
    this.codigoCorDenatran = const Value.absent(),
    this.lotacaoMaxima = const Value.absent(),
    this.restricao = const Value.absent(),
  });

  NfeDetEspecificoVeiculosCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.tipoOperacao = const Value.absent(),
    this.chassi = const Value.absent(),
    this.cor = const Value.absent(),
    this.descricaoCor = const Value.absent(),
    this.potenciaMotor = const Value.absent(),
    this.cilindradas = const Value.absent(),
    this.pesoLiquido = const Value.absent(),
    this.pesoBruto = const Value.absent(),
    this.numeroSerie = const Value.absent(),
    this.tipoCombustivel = const Value.absent(),
    this.numeroMotor = const Value.absent(),
    this.capacidadeMaximaTracao = const Value.absent(),
    this.distanciaEixos = const Value.absent(),
    this.anoModelo = const Value.absent(),
    this.anoFabricacao = const Value.absent(),
    this.tipoPintura = const Value.absent(),
    this.tipoVeiculo = const Value.absent(),
    this.especieVeiculo = const Value.absent(),
    this.condicaoVin = const Value.absent(),
    this.condicaoVeiculo = const Value.absent(),
    this.codigoMarcaModelo = const Value.absent(),
    this.codigoCorDenatran = const Value.absent(),
    this.lotacaoMaxima = const Value.absent(),
    this.restricao = const Value.absent(),
  });

  static Insertable<NfeDetEspecificoVeiculo> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<String>? tipoOperacao,
    Expression<String>? chassi,
    Expression<String>? cor,
    Expression<String>? descricaoCor,
    Expression<String>? potenciaMotor,
    Expression<String>? cilindradas,
    Expression<String>? pesoLiquido,
    Expression<String>? pesoBruto,
    Expression<String>? numeroSerie,
    Expression<String>? tipoCombustivel,
    Expression<String>? numeroMotor,
    Expression<String>? capacidadeMaximaTracao,
    Expression<String>? distanciaEixos,
    Expression<String>? anoModelo,
    Expression<String>? anoFabricacao,
    Expression<String>? tipoPintura,
    Expression<String>? tipoVeiculo,
    Expression<String>? especieVeiculo,
    Expression<String>? condicaoVin,
    Expression<String>? condicaoVeiculo,
    Expression<String>? codigoMarcaModelo,
    Expression<String>? codigoCorDenatran,
    Expression<int>? lotacaoMaxima,
    Expression<String>? restricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (tipoOperacao != null) 'TIPO_OPERACAO': tipoOperacao,
      if (chassi != null) 'CHASSI': chassi,
      if (cor != null) 'COR': cor,
      if (descricaoCor != null) 'DESCRICAO_COR': descricaoCor,
      if (potenciaMotor != null) 'POTENCIA_MOTOR': potenciaMotor,
      if (cilindradas != null) 'CILINDRADAS': cilindradas,
      if (pesoLiquido != null) 'PESO_LIQUIDO': pesoLiquido,
      if (pesoBruto != null) 'PESO_BRUTO': pesoBruto,
      if (numeroSerie != null) 'NUMERO_SERIE': numeroSerie,
      if (tipoCombustivel != null) 'TIPO_COMBUSTIVEL': tipoCombustivel,
      if (numeroMotor != null) 'NUMERO_MOTOR': numeroMotor,
      if (capacidadeMaximaTracao != null) 'CAPACIDADE_MAXIMA_TRACAO': capacidadeMaximaTracao,
      if (distanciaEixos != null) 'DISTANCIA_EIXOS': distanciaEixos,
      if (anoModelo != null) 'ANO_MODELO': anoModelo,
      if (anoFabricacao != null) 'ANO_FABRICACAO': anoFabricacao,
      if (tipoPintura != null) 'TIPO_PINTURA': tipoPintura,
      if (tipoVeiculo != null) 'TIPO_VEICULO': tipoVeiculo,
      if (especieVeiculo != null) 'ESPECIE_VEICULO': especieVeiculo,
      if (condicaoVin != null) 'CONDICAO_VIN': condicaoVin,
      if (condicaoVeiculo != null) 'CONDICAO_VEICULO': condicaoVeiculo,
      if (codigoMarcaModelo != null) 'CODIGO_MARCA_MODELO': codigoMarcaModelo,
      if (codigoCorDenatran != null) 'CODIGO_COR_DENATRAN': codigoCorDenatran,
      if (lotacaoMaxima != null) 'LOTACAO_MAXIMA': lotacaoMaxima,
      if (restricao != null) 'RESTRICAO': restricao,
    });
  }

  NfeDetEspecificoVeiculosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<String>? tipoOperacao,
      Value<String>? chassi,
      Value<String>? cor,
      Value<String>? descricaoCor,
      Value<String>? potenciaMotor,
      Value<String>? cilindradas,
      Value<String>? pesoLiquido,
      Value<String>? pesoBruto,
      Value<String>? numeroSerie,
      Value<String>? tipoCombustivel,
      Value<String>? numeroMotor,
      Value<String>? capacidadeMaximaTracao,
      Value<String>? distanciaEixos,
      Value<String>? anoModelo,
      Value<String>? anoFabricacao,
      Value<String>? tipoPintura,
      Value<String>? tipoVeiculo,
      Value<String>? especieVeiculo,
      Value<String>? condicaoVin,
      Value<String>? condicaoVeiculo,
      Value<String>? codigoMarcaModelo,
      Value<String>? codigoCorDenatran,
      Value<int>? lotacaoMaxima,
      Value<String>? restricao,
	  }) {
    return NfeDetEspecificoVeiculosCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      tipoOperacao: tipoOperacao ?? this.tipoOperacao,
      chassi: chassi ?? this.chassi,
      cor: cor ?? this.cor,
      descricaoCor: descricaoCor ?? this.descricaoCor,
      potenciaMotor: potenciaMotor ?? this.potenciaMotor,
      cilindradas: cilindradas ?? this.cilindradas,
      pesoLiquido: pesoLiquido ?? this.pesoLiquido,
      pesoBruto: pesoBruto ?? this.pesoBruto,
      numeroSerie: numeroSerie ?? this.numeroSerie,
      tipoCombustivel: tipoCombustivel ?? this.tipoCombustivel,
      numeroMotor: numeroMotor ?? this.numeroMotor,
      capacidadeMaximaTracao: capacidadeMaximaTracao ?? this.capacidadeMaximaTracao,
      distanciaEixos: distanciaEixos ?? this.distanciaEixos,
      anoModelo: anoModelo ?? this.anoModelo,
      anoFabricacao: anoFabricacao ?? this.anoFabricacao,
      tipoPintura: tipoPintura ?? this.tipoPintura,
      tipoVeiculo: tipoVeiculo ?? this.tipoVeiculo,
      especieVeiculo: especieVeiculo ?? this.especieVeiculo,
      condicaoVin: condicaoVin ?? this.condicaoVin,
      condicaoVeiculo: condicaoVeiculo ?? this.condicaoVeiculo,
      codigoMarcaModelo: codigoMarcaModelo ?? this.codigoMarcaModelo,
      codigoCorDenatran: codigoCorDenatran ?? this.codigoCorDenatran,
      lotacaoMaxima: lotacaoMaxima ?? this.lotacaoMaxima,
      restricao: restricao ?? this.restricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeDetalhe.present) {
      map['ID_NFE_DETALHE'] = Variable<int?>(idNfeDetalhe.value);
    }
    if (tipoOperacao.present) {
      map['TIPO_OPERACAO'] = Variable<String?>(tipoOperacao.value);
    }
    if (chassi.present) {
      map['CHASSI'] = Variable<String?>(chassi.value);
    }
    if (cor.present) {
      map['COR'] = Variable<String?>(cor.value);
    }
    if (descricaoCor.present) {
      map['DESCRICAO_COR'] = Variable<String?>(descricaoCor.value);
    }
    if (potenciaMotor.present) {
      map['POTENCIA_MOTOR'] = Variable<String?>(potenciaMotor.value);
    }
    if (cilindradas.present) {
      map['CILINDRADAS'] = Variable<String?>(cilindradas.value);
    }
    if (pesoLiquido.present) {
      map['PESO_LIQUIDO'] = Variable<String?>(pesoLiquido.value);
    }
    if (pesoBruto.present) {
      map['PESO_BRUTO'] = Variable<String?>(pesoBruto.value);
    }
    if (numeroSerie.present) {
      map['NUMERO_SERIE'] = Variable<String?>(numeroSerie.value);
    }
    if (tipoCombustivel.present) {
      map['TIPO_COMBUSTIVEL'] = Variable<String?>(tipoCombustivel.value);
    }
    if (numeroMotor.present) {
      map['NUMERO_MOTOR'] = Variable<String?>(numeroMotor.value);
    }
    if (capacidadeMaximaTracao.present) {
      map['CAPACIDADE_MAXIMA_TRACAO'] = Variable<String?>(capacidadeMaximaTracao.value);
    }
    if (distanciaEixos.present) {
      map['DISTANCIA_EIXOS'] = Variable<String?>(distanciaEixos.value);
    }
    if (anoModelo.present) {
      map['ANO_MODELO'] = Variable<String?>(anoModelo.value);
    }
    if (anoFabricacao.present) {
      map['ANO_FABRICACAO'] = Variable<String?>(anoFabricacao.value);
    }
    if (tipoPintura.present) {
      map['TIPO_PINTURA'] = Variable<String?>(tipoPintura.value);
    }
    if (tipoVeiculo.present) {
      map['TIPO_VEICULO'] = Variable<String?>(tipoVeiculo.value);
    }
    if (especieVeiculo.present) {
      map['ESPECIE_VEICULO'] = Variable<String?>(especieVeiculo.value);
    }
    if (condicaoVin.present) {
      map['CONDICAO_VIN'] = Variable<String?>(condicaoVin.value);
    }
    if (condicaoVeiculo.present) {
      map['CONDICAO_VEICULO'] = Variable<String?>(condicaoVeiculo.value);
    }
    if (codigoMarcaModelo.present) {
      map['CODIGO_MARCA_MODELO'] = Variable<String?>(codigoMarcaModelo.value);
    }
    if (codigoCorDenatran.present) {
      map['CODIGO_COR_DENATRAN'] = Variable<String?>(codigoCorDenatran.value);
    }
    if (lotacaoMaxima.present) {
      map['LOTACAO_MAXIMA'] = Variable<int?>(lotacaoMaxima.value);
    }
    if (restricao.present) {
      map['RESTRICAO'] = Variable<String?>(restricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetEspecificoVeiculosCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('tipoOperacao: $tipoOperacao, ')
          ..write('chassi: $chassi, ')
          ..write('cor: $cor, ')
          ..write('descricaoCor: $descricaoCor, ')
          ..write('potenciaMotor: $potenciaMotor, ')
          ..write('cilindradas: $cilindradas, ')
          ..write('pesoLiquido: $pesoLiquido, ')
          ..write('pesoBruto: $pesoBruto, ')
          ..write('numeroSerie: $numeroSerie, ')
          ..write('tipoCombustivel: $tipoCombustivel, ')
          ..write('numeroMotor: $numeroMotor, ')
          ..write('capacidadeMaximaTracao: $capacidadeMaximaTracao, ')
          ..write('distanciaEixos: $distanciaEixos, ')
          ..write('anoModelo: $anoModelo, ')
          ..write('anoFabricacao: $anoFabricacao, ')
          ..write('tipoPintura: $tipoPintura, ')
          ..write('tipoVeiculo: $tipoVeiculo, ')
          ..write('especieVeiculo: $especieVeiculo, ')
          ..write('condicaoVin: $condicaoVin, ')
          ..write('condicaoVeiculo: $condicaoVeiculo, ')
          ..write('codigoMarcaModelo: $codigoMarcaModelo, ')
          ..write('codigoCorDenatran: $codigoCorDenatran, ')
          ..write('lotacaoMaxima: $lotacaoMaxima, ')
          ..write('restricao: $restricao, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetEspecificoVeiculosTable extends NfeDetEspecificoVeiculos
    with TableInfo<$NfeDetEspecificoVeiculosTable, NfeDetEspecificoVeiculo> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetEspecificoVeiculosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeDetalheMeta =
      const VerificationMeta('idNfeDetalhe');
  GeneratedColumn<int>? _idNfeDetalhe;
  @override
  GeneratedColumn<int> get idNfeDetalhe =>
      _idNfeDetalhe ??= GeneratedColumn<int>('ID_NFE_DETALHE', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_DETALHE(ID)');
  final VerificationMeta _tipoOperacaoMeta =
      const VerificationMeta('tipoOperacao');
  GeneratedColumn<String>? _tipoOperacao;
  @override
  GeneratedColumn<String> get tipoOperacao => _tipoOperacao ??=
      GeneratedColumn<String>('TIPO_OPERACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _chassiMeta =
      const VerificationMeta('chassi');
  GeneratedColumn<String>? _chassi;
  @override
  GeneratedColumn<String> get chassi => _chassi ??=
      GeneratedColumn<String>('CHASSI', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _corMeta =
      const VerificationMeta('cor');
  GeneratedColumn<String>? _cor;
  @override
  GeneratedColumn<String> get cor => _cor ??=
      GeneratedColumn<String>('COR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _descricaoCorMeta =
      const VerificationMeta('descricaoCor');
  GeneratedColumn<String>? _descricaoCor;
  @override
  GeneratedColumn<String> get descricaoCor => _descricaoCor ??=
      GeneratedColumn<String>('DESCRICAO_COR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _potenciaMotorMeta =
      const VerificationMeta('potenciaMotor');
  GeneratedColumn<String>? _potenciaMotor;
  @override
  GeneratedColumn<String> get potenciaMotor => _potenciaMotor ??=
      GeneratedColumn<String>('POTENCIA_MOTOR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cilindradasMeta =
      const VerificationMeta('cilindradas');
  GeneratedColumn<String>? _cilindradas;
  @override
  GeneratedColumn<String> get cilindradas => _cilindradas ??=
      GeneratedColumn<String>('CILINDRADAS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _pesoLiquidoMeta =
      const VerificationMeta('pesoLiquido');
  GeneratedColumn<String>? _pesoLiquido;
  @override
  GeneratedColumn<String> get pesoLiquido => _pesoLiquido ??=
      GeneratedColumn<String>('PESO_LIQUIDO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _pesoBrutoMeta =
      const VerificationMeta('pesoBruto');
  GeneratedColumn<String>? _pesoBruto;
  @override
  GeneratedColumn<String> get pesoBruto => _pesoBruto ??=
      GeneratedColumn<String>('PESO_BRUTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroSerieMeta =
      const VerificationMeta('numeroSerie');
  GeneratedColumn<String>? _numeroSerie;
  @override
  GeneratedColumn<String> get numeroSerie => _numeroSerie ??=
      GeneratedColumn<String>('NUMERO_SERIE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _tipoCombustivelMeta =
      const VerificationMeta('tipoCombustivel');
  GeneratedColumn<String>? _tipoCombustivel;
  @override
  GeneratedColumn<String> get tipoCombustivel => _tipoCombustivel ??=
      GeneratedColumn<String>('TIPO_COMBUSTIVEL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroMotorMeta =
      const VerificationMeta('numeroMotor');
  GeneratedColumn<String>? _numeroMotor;
  @override
  GeneratedColumn<String> get numeroMotor => _numeroMotor ??=
      GeneratedColumn<String>('NUMERO_MOTOR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _capacidadeMaximaTracaoMeta =
      const VerificationMeta('capacidadeMaximaTracao');
  GeneratedColumn<String>? _capacidadeMaximaTracao;
  @override
  GeneratedColumn<String> get capacidadeMaximaTracao => _capacidadeMaximaTracao ??=
      GeneratedColumn<String>('CAPACIDADE_MAXIMA_TRACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _distanciaEixosMeta =
      const VerificationMeta('distanciaEixos');
  GeneratedColumn<String>? _distanciaEixos;
  @override
  GeneratedColumn<String> get distanciaEixos => _distanciaEixos ??=
      GeneratedColumn<String>('DISTANCIA_EIXOS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _anoModeloMeta =
      const VerificationMeta('anoModelo');
  GeneratedColumn<String>? _anoModelo;
  @override
  GeneratedColumn<String> get anoModelo => _anoModelo ??=
      GeneratedColumn<String>('ANO_MODELO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _anoFabricacaoMeta =
      const VerificationMeta('anoFabricacao');
  GeneratedColumn<String>? _anoFabricacao;
  @override
  GeneratedColumn<String> get anoFabricacao => _anoFabricacao ??=
      GeneratedColumn<String>('ANO_FABRICACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _tipoPinturaMeta =
      const VerificationMeta('tipoPintura');
  GeneratedColumn<String>? _tipoPintura;
  @override
  GeneratedColumn<String> get tipoPintura => _tipoPintura ??=
      GeneratedColumn<String>('TIPO_PINTURA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _tipoVeiculoMeta =
      const VerificationMeta('tipoVeiculo');
  GeneratedColumn<String>? _tipoVeiculo;
  @override
  GeneratedColumn<String> get tipoVeiculo => _tipoVeiculo ??=
      GeneratedColumn<String>('TIPO_VEICULO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _especieVeiculoMeta =
      const VerificationMeta('especieVeiculo');
  GeneratedColumn<String>? _especieVeiculo;
  @override
  GeneratedColumn<String> get especieVeiculo => _especieVeiculo ??=
      GeneratedColumn<String>('ESPECIE_VEICULO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _condicaoVinMeta =
      const VerificationMeta('condicaoVin');
  GeneratedColumn<String>? _condicaoVin;
  @override
  GeneratedColumn<String> get condicaoVin => _condicaoVin ??=
      GeneratedColumn<String>('CONDICAO_VIN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _condicaoVeiculoMeta =
      const VerificationMeta('condicaoVeiculo');
  GeneratedColumn<String>? _condicaoVeiculo;
  @override
  GeneratedColumn<String> get condicaoVeiculo => _condicaoVeiculo ??=
      GeneratedColumn<String>('CONDICAO_VEICULO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoMarcaModeloMeta =
      const VerificationMeta('codigoMarcaModelo');
  GeneratedColumn<String>? _codigoMarcaModelo;
  @override
  GeneratedColumn<String> get codigoMarcaModelo => _codigoMarcaModelo ??=
      GeneratedColumn<String>('CODIGO_MARCA_MODELO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoCorDenatranMeta =
      const VerificationMeta('codigoCorDenatran');
  GeneratedColumn<String>? _codigoCorDenatran;
  @override
  GeneratedColumn<String> get codigoCorDenatran => _codigoCorDenatran ??=
      GeneratedColumn<String>('CODIGO_COR_DENATRAN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _lotacaoMaximaMeta =
      const VerificationMeta('lotacaoMaxima');
  GeneratedColumn<int>? _lotacaoMaxima;
  @override
  GeneratedColumn<int> get lotacaoMaxima => _lotacaoMaxima ??=
      GeneratedColumn<int>('LOTACAO_MAXIMA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _restricaoMeta =
      const VerificationMeta('restricao');
  GeneratedColumn<String>? _restricao;
  @override
  GeneratedColumn<String> get restricao => _restricao ??=
      GeneratedColumn<String>('RESTRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        tipoOperacao,
        chassi,
        cor,
        descricaoCor,
        potenciaMotor,
        cilindradas,
        pesoLiquido,
        pesoBruto,
        numeroSerie,
        tipoCombustivel,
        numeroMotor,
        capacidadeMaximaTracao,
        distanciaEixos,
        anoModelo,
        anoFabricacao,
        tipoPintura,
        tipoVeiculo,
        especieVeiculo,
        condicaoVin,
        condicaoVeiculo,
        codigoMarcaModelo,
        codigoCorDenatran,
        lotacaoMaxima,
        restricao,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DET_ESPECIFICO_VEICULO';
  
  @override
  String get actualTableName => 'NFE_DET_ESPECIFICO_VEICULO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetEspecificoVeiculo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_DETALHE')) {
        context.handle(_idNfeDetalheMeta,
            idNfeDetalhe.isAcceptableOrUnknown(data['ID_NFE_DETALHE']!, _idNfeDetalheMeta));
    }
    if (data.containsKey('TIPO_OPERACAO')) {
        context.handle(_tipoOperacaoMeta,
            tipoOperacao.isAcceptableOrUnknown(data['TIPO_OPERACAO']!, _tipoOperacaoMeta));
    }
    if (data.containsKey('CHASSI')) {
        context.handle(_chassiMeta,
            chassi.isAcceptableOrUnknown(data['CHASSI']!, _chassiMeta));
    }
    if (data.containsKey('COR')) {
        context.handle(_corMeta,
            cor.isAcceptableOrUnknown(data['COR']!, _corMeta));
    }
    if (data.containsKey('DESCRICAO_COR')) {
        context.handle(_descricaoCorMeta,
            descricaoCor.isAcceptableOrUnknown(data['DESCRICAO_COR']!, _descricaoCorMeta));
    }
    if (data.containsKey('POTENCIA_MOTOR')) {
        context.handle(_potenciaMotorMeta,
            potenciaMotor.isAcceptableOrUnknown(data['POTENCIA_MOTOR']!, _potenciaMotorMeta));
    }
    if (data.containsKey('CILINDRADAS')) {
        context.handle(_cilindradasMeta,
            cilindradas.isAcceptableOrUnknown(data['CILINDRADAS']!, _cilindradasMeta));
    }
    if (data.containsKey('PESO_LIQUIDO')) {
        context.handle(_pesoLiquidoMeta,
            pesoLiquido.isAcceptableOrUnknown(data['PESO_LIQUIDO']!, _pesoLiquidoMeta));
    }
    if (data.containsKey('PESO_BRUTO')) {
        context.handle(_pesoBrutoMeta,
            pesoBruto.isAcceptableOrUnknown(data['PESO_BRUTO']!, _pesoBrutoMeta));
    }
    if (data.containsKey('NUMERO_SERIE')) {
        context.handle(_numeroSerieMeta,
            numeroSerie.isAcceptableOrUnknown(data['NUMERO_SERIE']!, _numeroSerieMeta));
    }
    if (data.containsKey('TIPO_COMBUSTIVEL')) {
        context.handle(_tipoCombustivelMeta,
            tipoCombustivel.isAcceptableOrUnknown(data['TIPO_COMBUSTIVEL']!, _tipoCombustivelMeta));
    }
    if (data.containsKey('NUMERO_MOTOR')) {
        context.handle(_numeroMotorMeta,
            numeroMotor.isAcceptableOrUnknown(data['NUMERO_MOTOR']!, _numeroMotorMeta));
    }
    if (data.containsKey('CAPACIDADE_MAXIMA_TRACAO')) {
        context.handle(_capacidadeMaximaTracaoMeta,
            capacidadeMaximaTracao.isAcceptableOrUnknown(data['CAPACIDADE_MAXIMA_TRACAO']!, _capacidadeMaximaTracaoMeta));
    }
    if (data.containsKey('DISTANCIA_EIXOS')) {
        context.handle(_distanciaEixosMeta,
            distanciaEixos.isAcceptableOrUnknown(data['DISTANCIA_EIXOS']!, _distanciaEixosMeta));
    }
    if (data.containsKey('ANO_MODELO')) {
        context.handle(_anoModeloMeta,
            anoModelo.isAcceptableOrUnknown(data['ANO_MODELO']!, _anoModeloMeta));
    }
    if (data.containsKey('ANO_FABRICACAO')) {
        context.handle(_anoFabricacaoMeta,
            anoFabricacao.isAcceptableOrUnknown(data['ANO_FABRICACAO']!, _anoFabricacaoMeta));
    }
    if (data.containsKey('TIPO_PINTURA')) {
        context.handle(_tipoPinturaMeta,
            tipoPintura.isAcceptableOrUnknown(data['TIPO_PINTURA']!, _tipoPinturaMeta));
    }
    if (data.containsKey('TIPO_VEICULO')) {
        context.handle(_tipoVeiculoMeta,
            tipoVeiculo.isAcceptableOrUnknown(data['TIPO_VEICULO']!, _tipoVeiculoMeta));
    }
    if (data.containsKey('ESPECIE_VEICULO')) {
        context.handle(_especieVeiculoMeta,
            especieVeiculo.isAcceptableOrUnknown(data['ESPECIE_VEICULO']!, _especieVeiculoMeta));
    }
    if (data.containsKey('CONDICAO_VIN')) {
        context.handle(_condicaoVinMeta,
            condicaoVin.isAcceptableOrUnknown(data['CONDICAO_VIN']!, _condicaoVinMeta));
    }
    if (data.containsKey('CONDICAO_VEICULO')) {
        context.handle(_condicaoVeiculoMeta,
            condicaoVeiculo.isAcceptableOrUnknown(data['CONDICAO_VEICULO']!, _condicaoVeiculoMeta));
    }
    if (data.containsKey('CODIGO_MARCA_MODELO')) {
        context.handle(_codigoMarcaModeloMeta,
            codigoMarcaModelo.isAcceptableOrUnknown(data['CODIGO_MARCA_MODELO']!, _codigoMarcaModeloMeta));
    }
    if (data.containsKey('CODIGO_COR_DENATRAN')) {
        context.handle(_codigoCorDenatranMeta,
            codigoCorDenatran.isAcceptableOrUnknown(data['CODIGO_COR_DENATRAN']!, _codigoCorDenatranMeta));
    }
    if (data.containsKey('LOTACAO_MAXIMA')) {
        context.handle(_lotacaoMaximaMeta,
            lotacaoMaxima.isAcceptableOrUnknown(data['LOTACAO_MAXIMA']!, _lotacaoMaximaMeta));
    }
    if (data.containsKey('RESTRICAO')) {
        context.handle(_restricaoMeta,
            restricao.isAcceptableOrUnknown(data['RESTRICAO']!, _restricaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDetEspecificoVeiculo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetEspecificoVeiculo.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetEspecificoVeiculosTable createAlias(String alias) {
    return $NfeDetEspecificoVeiculosTable(_db, alias);
  }
}