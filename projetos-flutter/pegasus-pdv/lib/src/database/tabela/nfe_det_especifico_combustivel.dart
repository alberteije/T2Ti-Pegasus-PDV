/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DET_ESPECIFICO_COMBUSTIVEL] 
                                                                                
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

@DataClassName("NfeDetEspecificoCombustivel")
@UseRowClass(NfeDetEspecificoCombustivel)
class NfeDetEspecificoCombustivels extends Table {
  @override
  String get tableName => 'NFE_DET_ESPECIFICO_COMBUSTIVEL';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  IntColumn get codigoAnp => integer().named('CODIGO_ANP').nullable()();
  TextColumn get descricaoAnp => text().named('DESCRICAO_ANP').withLength(min: 0, max: 95).nullable()();
  RealColumn get percentualGlp => real().named('PERCENTUAL_GLP').nullable()();
  RealColumn get percentualGasNacional => real().named('PERCENTUAL_GAS_NACIONAL').nullable()();
  RealColumn get percentualGasImportado => real().named('PERCENTUAL_GAS_IMPORTADO').nullable()();
  RealColumn get valorPartida => real().named('VALOR_PARTIDA').nullable()();
  TextColumn get codif => text().named('CODIF').withLength(min: 0, max: 21).nullable()();
  RealColumn get quantidadeTempAmbiente => real().named('QUANTIDADE_TEMP_AMBIENTE').nullable()();
  TextColumn get ufConsumo => text().named('UF_CONSUMO').withLength(min: 0, max: 2).nullable()();
  RealColumn get cideBaseCalculo => real().named('CIDE_BASE_CALCULO').nullable()();
  RealColumn get cideAliquota => real().named('CIDE_ALIQUOTA').nullable()();
  RealColumn get cideValor => real().named('CIDE_VALOR').nullable()();
  IntColumn get encerranteBico => integer().named('ENCERRANTE_BICO').nullable()();
  IntColumn get encerranteBomba => integer().named('ENCERRANTE_BOMBA').nullable()();
  IntColumn get encerranteTanque => integer().named('ENCERRANTE_TANQUE').nullable()();
  RealColumn get encerranteValorInicio => real().named('ENCERRANTE_VALOR_INICIO').nullable()();
  RealColumn get encerranteValorFim => real().named('ENCERRANTE_VALOR_FIM').nullable()();
}

class NfeDetEspecificoCombustivel extends DataClass implements Insertable<NfeDetEspecificoCombustivel> {
  final int? id;
  final int? idNfeDetalhe;
  final int? codigoAnp;
  final String? descricaoAnp;
  final double? percentualGlp;
  final double? percentualGasNacional;
  final double? percentualGasImportado;
  final double? valorPartida;
  final String? codif;
  final double? quantidadeTempAmbiente;
  final String? ufConsumo;
  final double? cideBaseCalculo;
  final double? cideAliquota;
  final double? cideValor;
  final int? encerranteBico;
  final int? encerranteBomba;
  final int? encerranteTanque;
  final double? encerranteValorInicio;
  final double? encerranteValorFim;

  NfeDetEspecificoCombustivel(
    {
      required this.id,
      this.idNfeDetalhe,
      this.codigoAnp,
      this.descricaoAnp,
      this.percentualGlp,
      this.percentualGasNacional,
      this.percentualGasImportado,
      this.valorPartida,
      this.codif,
      this.quantidadeTempAmbiente,
      this.ufConsumo,
      this.cideBaseCalculo,
      this.cideAliquota,
      this.cideValor,
      this.encerranteBico,
      this.encerranteBomba,
      this.encerranteTanque,
      this.encerranteValorInicio,
      this.encerranteValorFim,
    }
  );

  factory NfeDetEspecificoCombustivel.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetEspecificoCombustivel(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      codigoAnp: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_ANP']),
      descricaoAnp: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO_ANP']),
      percentualGlp: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_GLP']),
      percentualGasNacional: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_GAS_NACIONAL']),
      percentualGasImportado: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_GAS_IMPORTADO']),
      valorPartida: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PARTIDA']),
      codif: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIF']),
      quantidadeTempAmbiente: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_TEMP_AMBIENTE']),
      ufConsumo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UF_CONSUMO']),
      cideBaseCalculo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}CIDE_BASE_CALCULO']),
      cideAliquota: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}CIDE_ALIQUOTA']),
      cideValor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}CIDE_VALOR']),
      encerranteBico: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ENCERRANTE_BICO']),
      encerranteBomba: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ENCERRANTE_BOMBA']),
      encerranteTanque: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ENCERRANTE_TANQUE']),
      encerranteValorInicio: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ENCERRANTE_VALOR_INICIO']),
      encerranteValorFim: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ENCERRANTE_VALOR_FIM']),
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
    if (!nullToAbsent || codigoAnp != null) {
      map['CODIGO_ANP'] = Variable<int?>(codigoAnp);
    }
    if (!nullToAbsent || descricaoAnp != null) {
      map['DESCRICAO_ANP'] = Variable<String?>(descricaoAnp);
    }
    if (!nullToAbsent || percentualGlp != null) {
      map['PERCENTUAL_GLP'] = Variable<double?>(percentualGlp);
    }
    if (!nullToAbsent || percentualGasNacional != null) {
      map['PERCENTUAL_GAS_NACIONAL'] = Variable<double?>(percentualGasNacional);
    }
    if (!nullToAbsent || percentualGasImportado != null) {
      map['PERCENTUAL_GAS_IMPORTADO'] = Variable<double?>(percentualGasImportado);
    }
    if (!nullToAbsent || valorPartida != null) {
      map['VALOR_PARTIDA'] = Variable<double?>(valorPartida);
    }
    if (!nullToAbsent || codif != null) {
      map['CODIF'] = Variable<String?>(codif);
    }
    if (!nullToAbsent || quantidadeTempAmbiente != null) {
      map['QUANTIDADE_TEMP_AMBIENTE'] = Variable<double?>(quantidadeTempAmbiente);
    }
    if (!nullToAbsent || ufConsumo != null) {
      map['UF_CONSUMO'] = Variable<String?>(ufConsumo);
    }
    if (!nullToAbsent || cideBaseCalculo != null) {
      map['CIDE_BASE_CALCULO'] = Variable<double?>(cideBaseCalculo);
    }
    if (!nullToAbsent || cideAliquota != null) {
      map['CIDE_ALIQUOTA'] = Variable<double?>(cideAliquota);
    }
    if (!nullToAbsent || cideValor != null) {
      map['CIDE_VALOR'] = Variable<double?>(cideValor);
    }
    if (!nullToAbsent || encerranteBico != null) {
      map['ENCERRANTE_BICO'] = Variable<int?>(encerranteBico);
    }
    if (!nullToAbsent || encerranteBomba != null) {
      map['ENCERRANTE_BOMBA'] = Variable<int?>(encerranteBomba);
    }
    if (!nullToAbsent || encerranteTanque != null) {
      map['ENCERRANTE_TANQUE'] = Variable<int?>(encerranteTanque);
    }
    if (!nullToAbsent || encerranteValorInicio != null) {
      map['ENCERRANTE_VALOR_INICIO'] = Variable<double?>(encerranteValorInicio);
    }
    if (!nullToAbsent || encerranteValorFim != null) {
      map['ENCERRANTE_VALOR_FIM'] = Variable<double?>(encerranteValorFim);
    }
    return map;
  }

  NfeDetEspecificoCombustivelsCompanion toCompanion(bool nullToAbsent) {
    return NfeDetEspecificoCombustivelsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      codigoAnp: codigoAnp == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoAnp),
      descricaoAnp: descricaoAnp == null && nullToAbsent
        ? const Value.absent()
        : Value(descricaoAnp),
      percentualGlp: percentualGlp == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualGlp),
      percentualGasNacional: percentualGasNacional == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualGasNacional),
      percentualGasImportado: percentualGasImportado == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualGasImportado),
      valorPartida: valorPartida == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPartida),
      codif: codif == null && nullToAbsent
        ? const Value.absent()
        : Value(codif),
      quantidadeTempAmbiente: quantidadeTempAmbiente == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeTempAmbiente),
      ufConsumo: ufConsumo == null && nullToAbsent
        ? const Value.absent()
        : Value(ufConsumo),
      cideBaseCalculo: cideBaseCalculo == null && nullToAbsent
        ? const Value.absent()
        : Value(cideBaseCalculo),
      cideAliquota: cideAliquota == null && nullToAbsent
        ? const Value.absent()
        : Value(cideAliquota),
      cideValor: cideValor == null && nullToAbsent
        ? const Value.absent()
        : Value(cideValor),
      encerranteBico: encerranteBico == null && nullToAbsent
        ? const Value.absent()
        : Value(encerranteBico),
      encerranteBomba: encerranteBomba == null && nullToAbsent
        ? const Value.absent()
        : Value(encerranteBomba),
      encerranteTanque: encerranteTanque == null && nullToAbsent
        ? const Value.absent()
        : Value(encerranteTanque),
      encerranteValorInicio: encerranteValorInicio == null && nullToAbsent
        ? const Value.absent()
        : Value(encerranteValorInicio),
      encerranteValorFim: encerranteValorFim == null && nullToAbsent
        ? const Value.absent()
        : Value(encerranteValorFim),
    );
  }

  factory NfeDetEspecificoCombustivel.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetEspecificoCombustivel(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      codigoAnp: serializer.fromJson<int>(json['codigoAnp']),
      descricaoAnp: serializer.fromJson<String>(json['descricaoAnp']),
      percentualGlp: serializer.fromJson<double>(json['percentualGlp']),
      percentualGasNacional: serializer.fromJson<double>(json['percentualGasNacional']),
      percentualGasImportado: serializer.fromJson<double>(json['percentualGasImportado']),
      valorPartida: serializer.fromJson<double>(json['valorPartida']),
      codif: serializer.fromJson<String>(json['codif']),
      quantidadeTempAmbiente: serializer.fromJson<double>(json['quantidadeTempAmbiente']),
      ufConsumo: serializer.fromJson<String>(json['ufConsumo']),
      cideBaseCalculo: serializer.fromJson<double>(json['cideBaseCalculo']),
      cideAliquota: serializer.fromJson<double>(json['cideAliquota']),
      cideValor: serializer.fromJson<double>(json['cideValor']),
      encerranteBico: serializer.fromJson<int>(json['encerranteBico']),
      encerranteBomba: serializer.fromJson<int>(json['encerranteBomba']),
      encerranteTanque: serializer.fromJson<int>(json['encerranteTanque']),
      encerranteValorInicio: serializer.fromJson<double>(json['encerranteValorInicio']),
      encerranteValorFim: serializer.fromJson<double>(json['encerranteValorFim']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'codigoAnp': serializer.toJson<int?>(codigoAnp),
      'descricaoAnp': serializer.toJson<String?>(descricaoAnp),
      'percentualGlp': serializer.toJson<double?>(percentualGlp),
      'percentualGasNacional': serializer.toJson<double?>(percentualGasNacional),
      'percentualGasImportado': serializer.toJson<double?>(percentualGasImportado),
      'valorPartida': serializer.toJson<double?>(valorPartida),
      'codif': serializer.toJson<String?>(codif),
      'quantidadeTempAmbiente': serializer.toJson<double?>(quantidadeTempAmbiente),
      'ufConsumo': serializer.toJson<String?>(ufConsumo),
      'cideBaseCalculo': serializer.toJson<double?>(cideBaseCalculo),
      'cideAliquota': serializer.toJson<double?>(cideAliquota),
      'cideValor': serializer.toJson<double?>(cideValor),
      'encerranteBico': serializer.toJson<int?>(encerranteBico),
      'encerranteBomba': serializer.toJson<int?>(encerranteBomba),
      'encerranteTanque': serializer.toJson<int?>(encerranteTanque),
      'encerranteValorInicio': serializer.toJson<double?>(encerranteValorInicio),
      'encerranteValorFim': serializer.toJson<double?>(encerranteValorFim),
    };
  }

  NfeDetEspecificoCombustivel copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          int? codigoAnp,
          String? descricaoAnp,
          double? percentualGlp,
          double? percentualGasNacional,
          double? percentualGasImportado,
          double? valorPartida,
          String? codif,
          double? quantidadeTempAmbiente,
          String? ufConsumo,
          double? cideBaseCalculo,
          double? cideAliquota,
          double? cideValor,
          int? encerranteBico,
          int? encerranteBomba,
          int? encerranteTanque,
          double? encerranteValorInicio,
          double? encerranteValorFim,
		}) =>
      NfeDetEspecificoCombustivel(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        codigoAnp: codigoAnp ?? this.codigoAnp,
        descricaoAnp: descricaoAnp ?? this.descricaoAnp,
        percentualGlp: percentualGlp ?? this.percentualGlp,
        percentualGasNacional: percentualGasNacional ?? this.percentualGasNacional,
        percentualGasImportado: percentualGasImportado ?? this.percentualGasImportado,
        valorPartida: valorPartida ?? this.valorPartida,
        codif: codif ?? this.codif,
        quantidadeTempAmbiente: quantidadeTempAmbiente ?? this.quantidadeTempAmbiente,
        ufConsumo: ufConsumo ?? this.ufConsumo,
        cideBaseCalculo: cideBaseCalculo ?? this.cideBaseCalculo,
        cideAliquota: cideAliquota ?? this.cideAliquota,
        cideValor: cideValor ?? this.cideValor,
        encerranteBico: encerranteBico ?? this.encerranteBico,
        encerranteBomba: encerranteBomba ?? this.encerranteBomba,
        encerranteTanque: encerranteTanque ?? this.encerranteTanque,
        encerranteValorInicio: encerranteValorInicio ?? this.encerranteValorInicio,
        encerranteValorFim: encerranteValorFim ?? this.encerranteValorFim,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetEspecificoCombustivel(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('codigoAnp: $codigoAnp, ')
          ..write('descricaoAnp: $descricaoAnp, ')
          ..write('percentualGlp: $percentualGlp, ')
          ..write('percentualGasNacional: $percentualGasNacional, ')
          ..write('percentualGasImportado: $percentualGasImportado, ')
          ..write('valorPartida: $valorPartida, ')
          ..write('codif: $codif, ')
          ..write('quantidadeTempAmbiente: $quantidadeTempAmbiente, ')
          ..write('ufConsumo: $ufConsumo, ')
          ..write('cideBaseCalculo: $cideBaseCalculo, ')
          ..write('cideAliquota: $cideAliquota, ')
          ..write('cideValor: $cideValor, ')
          ..write('encerranteBico: $encerranteBico, ')
          ..write('encerranteBomba: $encerranteBomba, ')
          ..write('encerranteTanque: $encerranteTanque, ')
          ..write('encerranteValorInicio: $encerranteValorInicio, ')
          ..write('encerranteValorFim: $encerranteValorFim, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      codigoAnp,
      descricaoAnp,
      percentualGlp,
      percentualGasNacional,
      percentualGasImportado,
      valorPartida,
      codif,
      quantidadeTempAmbiente,
      ufConsumo,
      cideBaseCalculo,
      cideAliquota,
      cideValor,
      encerranteBico,
      encerranteBomba,
      encerranteTanque,
      encerranteValorInicio,
      encerranteValorFim,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetEspecificoCombustivel &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.codigoAnp == codigoAnp &&
          other.descricaoAnp == descricaoAnp &&
          other.percentualGlp == percentualGlp &&
          other.percentualGasNacional == percentualGasNacional &&
          other.percentualGasImportado == percentualGasImportado &&
          other.valorPartida == valorPartida &&
          other.codif == codif &&
          other.quantidadeTempAmbiente == quantidadeTempAmbiente &&
          other.ufConsumo == ufConsumo &&
          other.cideBaseCalculo == cideBaseCalculo &&
          other.cideAliquota == cideAliquota &&
          other.cideValor == cideValor &&
          other.encerranteBico == encerranteBico &&
          other.encerranteBomba == encerranteBomba &&
          other.encerranteTanque == encerranteTanque &&
          other.encerranteValorInicio == encerranteValorInicio &&
          other.encerranteValorFim == encerranteValorFim 
	   );
}

class NfeDetEspecificoCombustivelsCompanion extends UpdateCompanion<NfeDetEspecificoCombustivel> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<int?> codigoAnp;
  final Value<String?> descricaoAnp;
  final Value<double?> percentualGlp;
  final Value<double?> percentualGasNacional;
  final Value<double?> percentualGasImportado;
  final Value<double?> valorPartida;
  final Value<String?> codif;
  final Value<double?> quantidadeTempAmbiente;
  final Value<String?> ufConsumo;
  final Value<double?> cideBaseCalculo;
  final Value<double?> cideAliquota;
  final Value<double?> cideValor;
  final Value<int?> encerranteBico;
  final Value<int?> encerranteBomba;
  final Value<int?> encerranteTanque;
  final Value<double?> encerranteValorInicio;
  final Value<double?> encerranteValorFim;

  const NfeDetEspecificoCombustivelsCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.codigoAnp = const Value.absent(),
    this.descricaoAnp = const Value.absent(),
    this.percentualGlp = const Value.absent(),
    this.percentualGasNacional = const Value.absent(),
    this.percentualGasImportado = const Value.absent(),
    this.valorPartida = const Value.absent(),
    this.codif = const Value.absent(),
    this.quantidadeTempAmbiente = const Value.absent(),
    this.ufConsumo = const Value.absent(),
    this.cideBaseCalculo = const Value.absent(),
    this.cideAliquota = const Value.absent(),
    this.cideValor = const Value.absent(),
    this.encerranteBico = const Value.absent(),
    this.encerranteBomba = const Value.absent(),
    this.encerranteTanque = const Value.absent(),
    this.encerranteValorInicio = const Value.absent(),
    this.encerranteValorFim = const Value.absent(),
  });

  NfeDetEspecificoCombustivelsCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.codigoAnp = const Value.absent(),
    this.descricaoAnp = const Value.absent(),
    this.percentualGlp = const Value.absent(),
    this.percentualGasNacional = const Value.absent(),
    this.percentualGasImportado = const Value.absent(),
    this.valorPartida = const Value.absent(),
    this.codif = const Value.absent(),
    this.quantidadeTempAmbiente = const Value.absent(),
    this.ufConsumo = const Value.absent(),
    this.cideBaseCalculo = const Value.absent(),
    this.cideAliquota = const Value.absent(),
    this.cideValor = const Value.absent(),
    this.encerranteBico = const Value.absent(),
    this.encerranteBomba = const Value.absent(),
    this.encerranteTanque = const Value.absent(),
    this.encerranteValorInicio = const Value.absent(),
    this.encerranteValorFim = const Value.absent(),
  });

  static Insertable<NfeDetEspecificoCombustivel> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<int>? codigoAnp,
    Expression<String>? descricaoAnp,
    Expression<double>? percentualGlp,
    Expression<double>? percentualGasNacional,
    Expression<double>? percentualGasImportado,
    Expression<double>? valorPartida,
    Expression<String>? codif,
    Expression<double>? quantidadeTempAmbiente,
    Expression<String>? ufConsumo,
    Expression<double>? cideBaseCalculo,
    Expression<double>? cideAliquota,
    Expression<double>? cideValor,
    Expression<int>? encerranteBico,
    Expression<int>? encerranteBomba,
    Expression<int>? encerranteTanque,
    Expression<double>? encerranteValorInicio,
    Expression<double>? encerranteValorFim,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (codigoAnp != null) 'CODIGO_ANP': codigoAnp,
      if (descricaoAnp != null) 'DESCRICAO_ANP': descricaoAnp,
      if (percentualGlp != null) 'PERCENTUAL_GLP': percentualGlp,
      if (percentualGasNacional != null) 'PERCENTUAL_GAS_NACIONAL': percentualGasNacional,
      if (percentualGasImportado != null) 'PERCENTUAL_GAS_IMPORTADO': percentualGasImportado,
      if (valorPartida != null) 'VALOR_PARTIDA': valorPartida,
      if (codif != null) 'CODIF': codif,
      if (quantidadeTempAmbiente != null) 'QUANTIDADE_TEMP_AMBIENTE': quantidadeTempAmbiente,
      if (ufConsumo != null) 'UF_CONSUMO': ufConsumo,
      if (cideBaseCalculo != null) 'CIDE_BASE_CALCULO': cideBaseCalculo,
      if (cideAliquota != null) 'CIDE_ALIQUOTA': cideAliquota,
      if (cideValor != null) 'CIDE_VALOR': cideValor,
      if (encerranteBico != null) 'ENCERRANTE_BICO': encerranteBico,
      if (encerranteBomba != null) 'ENCERRANTE_BOMBA': encerranteBomba,
      if (encerranteTanque != null) 'ENCERRANTE_TANQUE': encerranteTanque,
      if (encerranteValorInicio != null) 'ENCERRANTE_VALOR_INICIO': encerranteValorInicio,
      if (encerranteValorFim != null) 'ENCERRANTE_VALOR_FIM': encerranteValorFim,
    });
  }

  NfeDetEspecificoCombustivelsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<int>? codigoAnp,
      Value<String>? descricaoAnp,
      Value<double>? percentualGlp,
      Value<double>? percentualGasNacional,
      Value<double>? percentualGasImportado,
      Value<double>? valorPartida,
      Value<String>? codif,
      Value<double>? quantidadeTempAmbiente,
      Value<String>? ufConsumo,
      Value<double>? cideBaseCalculo,
      Value<double>? cideAliquota,
      Value<double>? cideValor,
      Value<int>? encerranteBico,
      Value<int>? encerranteBomba,
      Value<int>? encerranteTanque,
      Value<double>? encerranteValorInicio,
      Value<double>? encerranteValorFim,
	  }) {
    return NfeDetEspecificoCombustivelsCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      codigoAnp: codigoAnp ?? this.codigoAnp,
      descricaoAnp: descricaoAnp ?? this.descricaoAnp,
      percentualGlp: percentualGlp ?? this.percentualGlp,
      percentualGasNacional: percentualGasNacional ?? this.percentualGasNacional,
      percentualGasImportado: percentualGasImportado ?? this.percentualGasImportado,
      valorPartida: valorPartida ?? this.valorPartida,
      codif: codif ?? this.codif,
      quantidadeTempAmbiente: quantidadeTempAmbiente ?? this.quantidadeTempAmbiente,
      ufConsumo: ufConsumo ?? this.ufConsumo,
      cideBaseCalculo: cideBaseCalculo ?? this.cideBaseCalculo,
      cideAliquota: cideAliquota ?? this.cideAliquota,
      cideValor: cideValor ?? this.cideValor,
      encerranteBico: encerranteBico ?? this.encerranteBico,
      encerranteBomba: encerranteBomba ?? this.encerranteBomba,
      encerranteTanque: encerranteTanque ?? this.encerranteTanque,
      encerranteValorInicio: encerranteValorInicio ?? this.encerranteValorInicio,
      encerranteValorFim: encerranteValorFim ?? this.encerranteValorFim,
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
    if (codigoAnp.present) {
      map['CODIGO_ANP'] = Variable<int?>(codigoAnp.value);
    }
    if (descricaoAnp.present) {
      map['DESCRICAO_ANP'] = Variable<String?>(descricaoAnp.value);
    }
    if (percentualGlp.present) {
      map['PERCENTUAL_GLP'] = Variable<double?>(percentualGlp.value);
    }
    if (percentualGasNacional.present) {
      map['PERCENTUAL_GAS_NACIONAL'] = Variable<double?>(percentualGasNacional.value);
    }
    if (percentualGasImportado.present) {
      map['PERCENTUAL_GAS_IMPORTADO'] = Variable<double?>(percentualGasImportado.value);
    }
    if (valorPartida.present) {
      map['VALOR_PARTIDA'] = Variable<double?>(valorPartida.value);
    }
    if (codif.present) {
      map['CODIF'] = Variable<String?>(codif.value);
    }
    if (quantidadeTempAmbiente.present) {
      map['QUANTIDADE_TEMP_AMBIENTE'] = Variable<double?>(quantidadeTempAmbiente.value);
    }
    if (ufConsumo.present) {
      map['UF_CONSUMO'] = Variable<String?>(ufConsumo.value);
    }
    if (cideBaseCalculo.present) {
      map['CIDE_BASE_CALCULO'] = Variable<double?>(cideBaseCalculo.value);
    }
    if (cideAliquota.present) {
      map['CIDE_ALIQUOTA'] = Variable<double?>(cideAliquota.value);
    }
    if (cideValor.present) {
      map['CIDE_VALOR'] = Variable<double?>(cideValor.value);
    }
    if (encerranteBico.present) {
      map['ENCERRANTE_BICO'] = Variable<int?>(encerranteBico.value);
    }
    if (encerranteBomba.present) {
      map['ENCERRANTE_BOMBA'] = Variable<int?>(encerranteBomba.value);
    }
    if (encerranteTanque.present) {
      map['ENCERRANTE_TANQUE'] = Variable<int?>(encerranteTanque.value);
    }
    if (encerranteValorInicio.present) {
      map['ENCERRANTE_VALOR_INICIO'] = Variable<double?>(encerranteValorInicio.value);
    }
    if (encerranteValorFim.present) {
      map['ENCERRANTE_VALOR_FIM'] = Variable<double?>(encerranteValorFim.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetEspecificoCombustivelsCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('codigoAnp: $codigoAnp, ')
          ..write('descricaoAnp: $descricaoAnp, ')
          ..write('percentualGlp: $percentualGlp, ')
          ..write('percentualGasNacional: $percentualGasNacional, ')
          ..write('percentualGasImportado: $percentualGasImportado, ')
          ..write('valorPartida: $valorPartida, ')
          ..write('codif: $codif, ')
          ..write('quantidadeTempAmbiente: $quantidadeTempAmbiente, ')
          ..write('ufConsumo: $ufConsumo, ')
          ..write('cideBaseCalculo: $cideBaseCalculo, ')
          ..write('cideAliquota: $cideAliquota, ')
          ..write('cideValor: $cideValor, ')
          ..write('encerranteBico: $encerranteBico, ')
          ..write('encerranteBomba: $encerranteBomba, ')
          ..write('encerranteTanque: $encerranteTanque, ')
          ..write('encerranteValorInicio: $encerranteValorInicio, ')
          ..write('encerranteValorFim: $encerranteValorFim, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetEspecificoCombustivelsTable extends NfeDetEspecificoCombustivels
    with TableInfo<$NfeDetEspecificoCombustivelsTable, NfeDetEspecificoCombustivel> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetEspecificoCombustivelsTable(this._db, [this._alias]);
  
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
  final VerificationMeta _codigoAnpMeta =
      const VerificationMeta('codigoAnp');
  GeneratedColumn<int>? _codigoAnp;
  @override
  GeneratedColumn<int> get codigoAnp => _codigoAnp ??=
      GeneratedColumn<int>('CODIGO_ANP', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _descricaoAnpMeta =
      const VerificationMeta('descricaoAnp');
  GeneratedColumn<String>? _descricaoAnp;
  @override
  GeneratedColumn<String> get descricaoAnp => _descricaoAnp ??=
      GeneratedColumn<String>('DESCRICAO_ANP', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _percentualGlpMeta =
      const VerificationMeta('percentualGlp');
  GeneratedColumn<double>? _percentualGlp;
  @override
  GeneratedColumn<double> get percentualGlp => _percentualGlp ??=
      GeneratedColumn<double>('PERCENTUAL_GLP', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualGasNacionalMeta =
      const VerificationMeta('percentualGasNacional');
  GeneratedColumn<double>? _percentualGasNacional;
  @override
  GeneratedColumn<double> get percentualGasNacional => _percentualGasNacional ??=
      GeneratedColumn<double>('PERCENTUAL_GAS_NACIONAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualGasImportadoMeta =
      const VerificationMeta('percentualGasImportado');
  GeneratedColumn<double>? _percentualGasImportado;
  @override
  GeneratedColumn<double> get percentualGasImportado => _percentualGasImportado ??=
      GeneratedColumn<double>('PERCENTUAL_GAS_IMPORTADO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPartidaMeta =
      const VerificationMeta('valorPartida');
  GeneratedColumn<double>? _valorPartida;
  @override
  GeneratedColumn<double> get valorPartida => _valorPartida ??=
      GeneratedColumn<double>('VALOR_PARTIDA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _codifMeta =
      const VerificationMeta('codif');
  GeneratedColumn<String>? _codif;
  @override
  GeneratedColumn<String> get codif => _codif ??=
      GeneratedColumn<String>('CODIF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _quantidadeTempAmbienteMeta =
      const VerificationMeta('quantidadeTempAmbiente');
  GeneratedColumn<double>? _quantidadeTempAmbiente;
  @override
  GeneratedColumn<double> get quantidadeTempAmbiente => _quantidadeTempAmbiente ??=
      GeneratedColumn<double>('QUANTIDADE_TEMP_AMBIENTE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _ufConsumoMeta =
      const VerificationMeta('ufConsumo');
  GeneratedColumn<String>? _ufConsumo;
  @override
  GeneratedColumn<String> get ufConsumo => _ufConsumo ??=
      GeneratedColumn<String>('UF_CONSUMO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cideBaseCalculoMeta =
      const VerificationMeta('cideBaseCalculo');
  GeneratedColumn<double>? _cideBaseCalculo;
  @override
  GeneratedColumn<double> get cideBaseCalculo => _cideBaseCalculo ??=
      GeneratedColumn<double>('CIDE_BASE_CALCULO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _cideAliquotaMeta =
      const VerificationMeta('cideAliquota');
  GeneratedColumn<double>? _cideAliquota;
  @override
  GeneratedColumn<double> get cideAliquota => _cideAliquota ??=
      GeneratedColumn<double>('CIDE_ALIQUOTA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _cideValorMeta =
      const VerificationMeta('cideValor');
  GeneratedColumn<double>? _cideValor;
  @override
  GeneratedColumn<double> get cideValor => _cideValor ??=
      GeneratedColumn<double>('CIDE_VALOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _encerranteBicoMeta =
      const VerificationMeta('encerranteBico');
  GeneratedColumn<int>? _encerranteBico;
  @override
  GeneratedColumn<int> get encerranteBico => _encerranteBico ??=
      GeneratedColumn<int>('ENCERRANTE_BICO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _encerranteBombaMeta =
      const VerificationMeta('encerranteBomba');
  GeneratedColumn<int>? _encerranteBomba;
  @override
  GeneratedColumn<int> get encerranteBomba => _encerranteBomba ??=
      GeneratedColumn<int>('ENCERRANTE_BOMBA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _encerranteTanqueMeta =
      const VerificationMeta('encerranteTanque');
  GeneratedColumn<int>? _encerranteTanque;
  @override
  GeneratedColumn<int> get encerranteTanque => _encerranteTanque ??=
      GeneratedColumn<int>('ENCERRANTE_TANQUE', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _encerranteValorInicioMeta =
      const VerificationMeta('encerranteValorInicio');
  GeneratedColumn<double>? _encerranteValorInicio;
  @override
  GeneratedColumn<double> get encerranteValorInicio => _encerranteValorInicio ??=
      GeneratedColumn<double>('ENCERRANTE_VALOR_INICIO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _encerranteValorFimMeta =
      const VerificationMeta('encerranteValorFim');
  GeneratedColumn<double>? _encerranteValorFim;
  @override
  GeneratedColumn<double> get encerranteValorFim => _encerranteValorFim ??=
      GeneratedColumn<double>('ENCERRANTE_VALOR_FIM', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        codigoAnp,
        descricaoAnp,
        percentualGlp,
        percentualGasNacional,
        percentualGasImportado,
        valorPartida,
        codif,
        quantidadeTempAmbiente,
        ufConsumo,
        cideBaseCalculo,
        cideAliquota,
        cideValor,
        encerranteBico,
        encerranteBomba,
        encerranteTanque,
        encerranteValorInicio,
        encerranteValorFim,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DET_ESPECIFICO_COMBUSTIVEL';
  
  @override
  String get actualTableName => 'NFE_DET_ESPECIFICO_COMBUSTIVEL';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetEspecificoCombustivel> instance,
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
    if (data.containsKey('CODIGO_ANP')) {
        context.handle(_codigoAnpMeta,
            codigoAnp.isAcceptableOrUnknown(data['CODIGO_ANP']!, _codigoAnpMeta));
    }
    if (data.containsKey('DESCRICAO_ANP')) {
        context.handle(_descricaoAnpMeta,
            descricaoAnp.isAcceptableOrUnknown(data['DESCRICAO_ANP']!, _descricaoAnpMeta));
    }
    if (data.containsKey('PERCENTUAL_GLP')) {
        context.handle(_percentualGlpMeta,
            percentualGlp.isAcceptableOrUnknown(data['PERCENTUAL_GLP']!, _percentualGlpMeta));
    }
    if (data.containsKey('PERCENTUAL_GAS_NACIONAL')) {
        context.handle(_percentualGasNacionalMeta,
            percentualGasNacional.isAcceptableOrUnknown(data['PERCENTUAL_GAS_NACIONAL']!, _percentualGasNacionalMeta));
    }
    if (data.containsKey('PERCENTUAL_GAS_IMPORTADO')) {
        context.handle(_percentualGasImportadoMeta,
            percentualGasImportado.isAcceptableOrUnknown(data['PERCENTUAL_GAS_IMPORTADO']!, _percentualGasImportadoMeta));
    }
    if (data.containsKey('VALOR_PARTIDA')) {
        context.handle(_valorPartidaMeta,
            valorPartida.isAcceptableOrUnknown(data['VALOR_PARTIDA']!, _valorPartidaMeta));
    }
    if (data.containsKey('CODIF')) {
        context.handle(_codifMeta,
            codif.isAcceptableOrUnknown(data['CODIF']!, _codifMeta));
    }
    if (data.containsKey('QUANTIDADE_TEMP_AMBIENTE')) {
        context.handle(_quantidadeTempAmbienteMeta,
            quantidadeTempAmbiente.isAcceptableOrUnknown(data['QUANTIDADE_TEMP_AMBIENTE']!, _quantidadeTempAmbienteMeta));
    }
    if (data.containsKey('UF_CONSUMO')) {
        context.handle(_ufConsumoMeta,
            ufConsumo.isAcceptableOrUnknown(data['UF_CONSUMO']!, _ufConsumoMeta));
    }
    if (data.containsKey('CIDE_BASE_CALCULO')) {
        context.handle(_cideBaseCalculoMeta,
            cideBaseCalculo.isAcceptableOrUnknown(data['CIDE_BASE_CALCULO']!, _cideBaseCalculoMeta));
    }
    if (data.containsKey('CIDE_ALIQUOTA')) {
        context.handle(_cideAliquotaMeta,
            cideAliquota.isAcceptableOrUnknown(data['CIDE_ALIQUOTA']!, _cideAliquotaMeta));
    }
    if (data.containsKey('CIDE_VALOR')) {
        context.handle(_cideValorMeta,
            cideValor.isAcceptableOrUnknown(data['CIDE_VALOR']!, _cideValorMeta));
    }
    if (data.containsKey('ENCERRANTE_BICO')) {
        context.handle(_encerranteBicoMeta,
            encerranteBico.isAcceptableOrUnknown(data['ENCERRANTE_BICO']!, _encerranteBicoMeta));
    }
    if (data.containsKey('ENCERRANTE_BOMBA')) {
        context.handle(_encerranteBombaMeta,
            encerranteBomba.isAcceptableOrUnknown(data['ENCERRANTE_BOMBA']!, _encerranteBombaMeta));
    }
    if (data.containsKey('ENCERRANTE_TANQUE')) {
        context.handle(_encerranteTanqueMeta,
            encerranteTanque.isAcceptableOrUnknown(data['ENCERRANTE_TANQUE']!, _encerranteTanqueMeta));
    }
    if (data.containsKey('ENCERRANTE_VALOR_INICIO')) {
        context.handle(_encerranteValorInicioMeta,
            encerranteValorInicio.isAcceptableOrUnknown(data['ENCERRANTE_VALOR_INICIO']!, _encerranteValorInicioMeta));
    }
    if (data.containsKey('ENCERRANTE_VALOR_FIM')) {
        context.handle(_encerranteValorFimMeta,
            encerranteValorFim.isAcceptableOrUnknown(data['ENCERRANTE_VALOR_FIM']!, _encerranteValorFimMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDetEspecificoCombustivel map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetEspecificoCombustivel.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetEspecificoCombustivelsTable createAlias(String alias) {
    return $NfeDetEspecificoCombustivelsTable(_db, alias);
  }
}