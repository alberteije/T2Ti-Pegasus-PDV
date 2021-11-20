/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_R06] 
                                                                                
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

@DataClassName("EcfR06")
@UseRowClass(EcfR06)
class EcfR06s extends Table {
  @override
  String get tableName => 'ECF_R06';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idPdvOperador => integer().named('ID_PDV_OPERADOR').nullable().customConstraint('NULLABLE REFERENCES PDV_OPERADOR(ID)')();
  IntColumn get idEcfImpressora => integer().named('ID_ECF_IMPRESSORA').nullable().customConstraint('NULLABLE REFERENCES ECF_IMPRESSORA(ID)')();
  IntColumn get idEcfCaixa => integer().named('ID_ECF_CAIXA').nullable().customConstraint('NULLABLE REFERENCES ECF_CAIXA(ID)')();
  TextColumn get serieEcf => text().named('SERIE_ECF').withLength(min: 0, max: 20).nullable()();
  IntColumn get coo => integer().named('COO').nullable()();
  IntColumn get gnf => integer().named('GNF').nullable()();
  IntColumn get grg => integer().named('GRG').nullable()();
  IntColumn get cdc => integer().named('CDC').nullable()();
  TextColumn get denominacao => text().named('DENOMINACAO').withLength(min: 0, max: 2).nullable()();
  DateTimeColumn get dataEmissao => dateTime().named('DATA_EMISSAO').nullable()();
  TextColumn get horaEmissao => text().named('HORA_EMISSAO').withLength(min: 0, max: 8).nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()();
}

class EcfR06 extends DataClass implements Insertable<EcfR06> {
  final int? id;
  final int? idPdvOperador;
  final int? idEcfImpressora;
  final int? idEcfCaixa;
  final String? serieEcf;
  final int? coo;
  final int? gnf;
  final int? grg;
  final int? cdc;
  final String? denominacao;
  final DateTime? dataEmissao;
  final String? horaEmissao;
  final String? hashRegistro;

  EcfR06(
    {
      required this.id,
      this.idPdvOperador,
      this.idEcfImpressora,
      this.idEcfCaixa,
      this.serieEcf,
      this.coo,
      this.gnf,
      this.grg,
      this.cdc,
      this.denominacao,
      this.dataEmissao,
      this.horaEmissao,
      this.hashRegistro,
    }
  );

  factory EcfR06.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EcfR06(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idPdvOperador: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_OPERADOR']),
      idEcfImpressora: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_ECF_IMPRESSORA']),
      idEcfCaixa: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_ECF_CAIXA']),
      serieEcf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SERIE_ECF']),
      coo: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}COO']),
      gnf: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}GNF']),
      grg: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}GRG']),
      cdc: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CDC']),
      denominacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DENOMINACAO']),
      dataEmissao: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_EMISSAO']),
      horaEmissao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_EMISSAO']),
      hashRegistro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HASH_REGISTRO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idPdvOperador != null) {
      map['ID_PDV_OPERADOR'] = Variable<int?>(idPdvOperador);
    }
    if (!nullToAbsent || idEcfImpressora != null) {
      map['ID_ECF_IMPRESSORA'] = Variable<int?>(idEcfImpressora);
    }
    if (!nullToAbsent || idEcfCaixa != null) {
      map['ID_ECF_CAIXA'] = Variable<int?>(idEcfCaixa);
    }
    if (!nullToAbsent || serieEcf != null) {
      map['SERIE_ECF'] = Variable<String?>(serieEcf);
    }
    if (!nullToAbsent || coo != null) {
      map['COO'] = Variable<int?>(coo);
    }
    if (!nullToAbsent || gnf != null) {
      map['GNF'] = Variable<int?>(gnf);
    }
    if (!nullToAbsent || grg != null) {
      map['GRG'] = Variable<int?>(grg);
    }
    if (!nullToAbsent || cdc != null) {
      map['CDC'] = Variable<int?>(cdc);
    }
    if (!nullToAbsent || denominacao != null) {
      map['DENOMINACAO'] = Variable<String?>(denominacao);
    }
    if (!nullToAbsent || dataEmissao != null) {
      map['DATA_EMISSAO'] = Variable<DateTime?>(dataEmissao);
    }
    if (!nullToAbsent || horaEmissao != null) {
      map['HORA_EMISSAO'] = Variable<String?>(horaEmissao);
    }
    if (!nullToAbsent || hashRegistro != null) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro);
    }
    return map;
  }

  EcfR06sCompanion toCompanion(bool nullToAbsent) {
    return EcfR06sCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idPdvOperador: idPdvOperador == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvOperador),
      idEcfImpressora: idEcfImpressora == null && nullToAbsent
        ? const Value.absent()
        : Value(idEcfImpressora),
      idEcfCaixa: idEcfCaixa == null && nullToAbsent
        ? const Value.absent()
        : Value(idEcfCaixa),
      serieEcf: serieEcf == null && nullToAbsent
        ? const Value.absent()
        : Value(serieEcf),
      coo: coo == null && nullToAbsent
        ? const Value.absent()
        : Value(coo),
      gnf: gnf == null && nullToAbsent
        ? const Value.absent()
        : Value(gnf),
      grg: grg == null && nullToAbsent
        ? const Value.absent()
        : Value(grg),
      cdc: cdc == null && nullToAbsent
        ? const Value.absent()
        : Value(cdc),
      denominacao: denominacao == null && nullToAbsent
        ? const Value.absent()
        : Value(denominacao),
      dataEmissao: dataEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(dataEmissao),
      horaEmissao: horaEmissao == null && nullToAbsent
        ? const Value.absent()
        : Value(horaEmissao),
      hashRegistro: hashRegistro == null && nullToAbsent
        ? const Value.absent()
        : Value(hashRegistro),
    );
  }

  factory EcfR06.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EcfR06(
      id: serializer.fromJson<int>(json['id']),
      idPdvOperador: serializer.fromJson<int>(json['idPdvOperador']),
      idEcfImpressora: serializer.fromJson<int>(json['idEcfImpressora']),
      idEcfCaixa: serializer.fromJson<int>(json['idEcfCaixa']),
      serieEcf: serializer.fromJson<String>(json['serieEcf']),
      coo: serializer.fromJson<int>(json['coo']),
      gnf: serializer.fromJson<int>(json['gnf']),
      grg: serializer.fromJson<int>(json['grg']),
      cdc: serializer.fromJson<int>(json['cdc']),
      denominacao: serializer.fromJson<String>(json['denominacao']),
      dataEmissao: serializer.fromJson<DateTime>(json['dataEmissao']),
      horaEmissao: serializer.fromJson<String>(json['horaEmissao']),
      hashRegistro: serializer.fromJson<String>(json['hashRegistro']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idPdvOperador': serializer.toJson<int?>(idPdvOperador),
      'idEcfImpressora': serializer.toJson<int?>(idEcfImpressora),
      'idEcfCaixa': serializer.toJson<int?>(idEcfCaixa),
      'serieEcf': serializer.toJson<String?>(serieEcf),
      'coo': serializer.toJson<int?>(coo),
      'gnf': serializer.toJson<int?>(gnf),
      'grg': serializer.toJson<int?>(grg),
      'cdc': serializer.toJson<int?>(cdc),
      'denominacao': serializer.toJson<String?>(denominacao),
      'dataEmissao': serializer.toJson<DateTime?>(dataEmissao),
      'horaEmissao': serializer.toJson<String?>(horaEmissao),
      'hashRegistro': serializer.toJson<String?>(hashRegistro),
    };
  }

  EcfR06 copyWith(
        {
		  int? id,
          int? idPdvOperador,
          int? idEcfImpressora,
          int? idEcfCaixa,
          String? serieEcf,
          int? coo,
          int? gnf,
          int? grg,
          int? cdc,
          String? denominacao,
          DateTime? dataEmissao,
          String? horaEmissao,
          String? hashRegistro,
		}) =>
      EcfR06(
        id: id ?? this.id,
        idPdvOperador: idPdvOperador ?? this.idPdvOperador,
        idEcfImpressora: idEcfImpressora ?? this.idEcfImpressora,
        idEcfCaixa: idEcfCaixa ?? this.idEcfCaixa,
        serieEcf: serieEcf ?? this.serieEcf,
        coo: coo ?? this.coo,
        gnf: gnf ?? this.gnf,
        grg: grg ?? this.grg,
        cdc: cdc ?? this.cdc,
        denominacao: denominacao ?? this.denominacao,
        dataEmissao: dataEmissao ?? this.dataEmissao,
        horaEmissao: horaEmissao ?? this.horaEmissao,
        hashRegistro: hashRegistro ?? this.hashRegistro,
      );
  
  @override
  String toString() {
    return (StringBuffer('EcfR06(')
          ..write('id: $id, ')
          ..write('idPdvOperador: $idPdvOperador, ')
          ..write('idEcfImpressora: $idEcfImpressora, ')
          ..write('idEcfCaixa: $idEcfCaixa, ')
          ..write('serieEcf: $serieEcf, ')
          ..write('coo: $coo, ')
          ..write('gnf: $gnf, ')
          ..write('grg: $grg, ')
          ..write('cdc: $cdc, ')
          ..write('denominacao: $denominacao, ')
          ..write('dataEmissao: $dataEmissao, ')
          ..write('horaEmissao: $horaEmissao, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idPdvOperador,
      idEcfImpressora,
      idEcfCaixa,
      serieEcf,
      coo,
      gnf,
      grg,
      cdc,
      denominacao,
      dataEmissao,
      horaEmissao,
      hashRegistro,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcfR06 &&
          other.id == id &&
          other.idPdvOperador == idPdvOperador &&
          other.idEcfImpressora == idEcfImpressora &&
          other.idEcfCaixa == idEcfCaixa &&
          other.serieEcf == serieEcf &&
          other.coo == coo &&
          other.gnf == gnf &&
          other.grg == grg &&
          other.cdc == cdc &&
          other.denominacao == denominacao &&
          other.dataEmissao == dataEmissao &&
          other.horaEmissao == horaEmissao &&
          other.hashRegistro == hashRegistro 
	   );
}

class EcfR06sCompanion extends UpdateCompanion<EcfR06> {

  final Value<int?> id;
  final Value<int?> idPdvOperador;
  final Value<int?> idEcfImpressora;
  final Value<int?> idEcfCaixa;
  final Value<String?> serieEcf;
  final Value<int?> coo;
  final Value<int?> gnf;
  final Value<int?> grg;
  final Value<int?> cdc;
  final Value<String?> denominacao;
  final Value<DateTime?> dataEmissao;
  final Value<String?> horaEmissao;
  final Value<String?> hashRegistro;

  const EcfR06sCompanion({
    this.id = const Value.absent(),
    this.idPdvOperador = const Value.absent(),
    this.idEcfImpressora = const Value.absent(),
    this.idEcfCaixa = const Value.absent(),
    this.serieEcf = const Value.absent(),
    this.coo = const Value.absent(),
    this.gnf = const Value.absent(),
    this.grg = const Value.absent(),
    this.cdc = const Value.absent(),
    this.denominacao = const Value.absent(),
    this.dataEmissao = const Value.absent(),
    this.horaEmissao = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  EcfR06sCompanion.insert({
    this.id = const Value.absent(),
    this.idPdvOperador = const Value.absent(),
    this.idEcfImpressora = const Value.absent(),
    this.idEcfCaixa = const Value.absent(),
    this.serieEcf = const Value.absent(),
    this.coo = const Value.absent(),
    this.gnf = const Value.absent(),
    this.grg = const Value.absent(),
    this.cdc = const Value.absent(),
    this.denominacao = const Value.absent(),
    this.dataEmissao = const Value.absent(),
    this.horaEmissao = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  static Insertable<EcfR06> custom({
    Expression<int>? id,
    Expression<int>? idPdvOperador,
    Expression<int>? idEcfImpressora,
    Expression<int>? idEcfCaixa,
    Expression<String>? serieEcf,
    Expression<int>? coo,
    Expression<int>? gnf,
    Expression<int>? grg,
    Expression<int>? cdc,
    Expression<String>? denominacao,
    Expression<DateTime>? dataEmissao,
    Expression<String>? horaEmissao,
    Expression<String>? hashRegistro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idPdvOperador != null) 'ID_PDV_OPERADOR': idPdvOperador,
      if (idEcfImpressora != null) 'ID_ECF_IMPRESSORA': idEcfImpressora,
      if (idEcfCaixa != null) 'ID_ECF_CAIXA': idEcfCaixa,
      if (serieEcf != null) 'SERIE_ECF': serieEcf,
      if (coo != null) 'COO': coo,
      if (gnf != null) 'GNF': gnf,
      if (grg != null) 'GRG': grg,
      if (cdc != null) 'CDC': cdc,
      if (denominacao != null) 'DENOMINACAO': denominacao,
      if (dataEmissao != null) 'DATA_EMISSAO': dataEmissao,
      if (horaEmissao != null) 'HORA_EMISSAO': horaEmissao,
      if (hashRegistro != null) 'HASH_REGISTRO': hashRegistro,
    });
  }

  EcfR06sCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idPdvOperador,
      Value<int>? idEcfImpressora,
      Value<int>? idEcfCaixa,
      Value<String>? serieEcf,
      Value<int>? coo,
      Value<int>? gnf,
      Value<int>? grg,
      Value<int>? cdc,
      Value<String>? denominacao,
      Value<DateTime>? dataEmissao,
      Value<String>? horaEmissao,
      Value<String>? hashRegistro,
	  }) {
    return EcfR06sCompanion(
      id: id ?? this.id,
      idPdvOperador: idPdvOperador ?? this.idPdvOperador,
      idEcfImpressora: idEcfImpressora ?? this.idEcfImpressora,
      idEcfCaixa: idEcfCaixa ?? this.idEcfCaixa,
      serieEcf: serieEcf ?? this.serieEcf,
      coo: coo ?? this.coo,
      gnf: gnf ?? this.gnf,
      grg: grg ?? this.grg,
      cdc: cdc ?? this.cdc,
      denominacao: denominacao ?? this.denominacao,
      dataEmissao: dataEmissao ?? this.dataEmissao,
      horaEmissao: horaEmissao ?? this.horaEmissao,
      hashRegistro: hashRegistro ?? this.hashRegistro,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idPdvOperador.present) {
      map['ID_PDV_OPERADOR'] = Variable<int?>(idPdvOperador.value);
    }
    if (idEcfImpressora.present) {
      map['ID_ECF_IMPRESSORA'] = Variable<int?>(idEcfImpressora.value);
    }
    if (idEcfCaixa.present) {
      map['ID_ECF_CAIXA'] = Variable<int?>(idEcfCaixa.value);
    }
    if (serieEcf.present) {
      map['SERIE_ECF'] = Variable<String?>(serieEcf.value);
    }
    if (coo.present) {
      map['COO'] = Variable<int?>(coo.value);
    }
    if (gnf.present) {
      map['GNF'] = Variable<int?>(gnf.value);
    }
    if (grg.present) {
      map['GRG'] = Variable<int?>(grg.value);
    }
    if (cdc.present) {
      map['CDC'] = Variable<int?>(cdc.value);
    }
    if (denominacao.present) {
      map['DENOMINACAO'] = Variable<String?>(denominacao.value);
    }
    if (dataEmissao.present) {
      map['DATA_EMISSAO'] = Variable<DateTime?>(dataEmissao.value);
    }
    if (horaEmissao.present) {
      map['HORA_EMISSAO'] = Variable<String?>(horaEmissao.value);
    }
    if (hashRegistro.present) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcfR06sCompanion(')
          ..write('id: $id, ')
          ..write('idPdvOperador: $idPdvOperador, ')
          ..write('idEcfImpressora: $idEcfImpressora, ')
          ..write('idEcfCaixa: $idEcfCaixa, ')
          ..write('serieEcf: $serieEcf, ')
          ..write('coo: $coo, ')
          ..write('gnf: $gnf, ')
          ..write('grg: $grg, ')
          ..write('cdc: $cdc, ')
          ..write('denominacao: $denominacao, ')
          ..write('dataEmissao: $dataEmissao, ')
          ..write('horaEmissao: $horaEmissao, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }
}

class $EcfR06sTable extends EcfR06s
    with TableInfo<$EcfR06sTable, EcfR06> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EcfR06sTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idPdvOperadorMeta =
      const VerificationMeta('idPdvOperador');
  GeneratedColumn<int>? _idPdvOperador;
  @override
  GeneratedColumn<int> get idPdvOperador =>
      _idPdvOperador ??= GeneratedColumn<int>('ID_PDV_OPERADOR', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PDV_OPERADOR(ID)');
  final VerificationMeta _idEcfImpressoraMeta =
      const VerificationMeta('idEcfImpressora');
  GeneratedColumn<int>? _idEcfImpressora;
  @override
  GeneratedColumn<int> get idEcfImpressora =>
      _idEcfImpressora ??= GeneratedColumn<int>('ID_ECF_IMPRESSORA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES ECF_IMPRESSORA(ID)');
  final VerificationMeta _idEcfCaixaMeta =
      const VerificationMeta('idEcfCaixa');
  GeneratedColumn<int>? _idEcfCaixa;
  @override
  GeneratedColumn<int> get idEcfCaixa =>
      _idEcfCaixa ??= GeneratedColumn<int>('ID_ECF_CAIXA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES ECF_CAIXA(ID)');
  final VerificationMeta _serieEcfMeta =
      const VerificationMeta('serieEcf');
  GeneratedColumn<String>? _serieEcf;
  @override
  GeneratedColumn<String> get serieEcf => _serieEcf ??=
      GeneratedColumn<String>('SERIE_ECF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cooMeta =
      const VerificationMeta('coo');
  GeneratedColumn<int>? _coo;
  @override
  GeneratedColumn<int> get coo => _coo ??=
      GeneratedColumn<int>('COO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _gnfMeta =
      const VerificationMeta('gnf');
  GeneratedColumn<int>? _gnf;
  @override
  GeneratedColumn<int> get gnf => _gnf ??=
      GeneratedColumn<int>('GNF', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _grgMeta =
      const VerificationMeta('grg');
  GeneratedColumn<int>? _grg;
  @override
  GeneratedColumn<int> get grg => _grg ??=
      GeneratedColumn<int>('GRG', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _cdcMeta =
      const VerificationMeta('cdc');
  GeneratedColumn<int>? _cdc;
  @override
  GeneratedColumn<int> get cdc => _cdc ??=
      GeneratedColumn<int>('CDC', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _denominacaoMeta =
      const VerificationMeta('denominacao');
  GeneratedColumn<String>? _denominacao;
  @override
  GeneratedColumn<String> get denominacao => _denominacao ??=
      GeneratedColumn<String>('DENOMINACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dataEmissaoMeta =
      const VerificationMeta('dataEmissao');
  GeneratedColumn<DateTime>? _dataEmissao;
  @override
  GeneratedColumn<DateTime> get dataEmissao => _dataEmissao ??=
      GeneratedColumn<DateTime>('DATA_EMISSAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaEmissaoMeta =
      const VerificationMeta('horaEmissao');
  GeneratedColumn<String>? _horaEmissao;
  @override
  GeneratedColumn<String> get horaEmissao => _horaEmissao ??=
      GeneratedColumn<String>('HORA_EMISSAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
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
        idPdvOperador,
        idEcfImpressora,
        idEcfCaixa,
        serieEcf,
        coo,
        gnf,
        grg,
        cdc,
        denominacao,
        dataEmissao,
        horaEmissao,
        hashRegistro,
      ];

  @override
  String get aliasedName => _alias ?? 'ECF_R06';
  
  @override
  String get actualTableName => 'ECF_R06';
  
  @override
  VerificationContext validateIntegrity(Insertable<EcfR06> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_PDV_OPERADOR')) {
        context.handle(_idPdvOperadorMeta,
            idPdvOperador.isAcceptableOrUnknown(data['ID_PDV_OPERADOR']!, _idPdvOperadorMeta));
    }
    if (data.containsKey('ID_ECF_IMPRESSORA')) {
        context.handle(_idEcfImpressoraMeta,
            idEcfImpressora.isAcceptableOrUnknown(data['ID_ECF_IMPRESSORA']!, _idEcfImpressoraMeta));
    }
    if (data.containsKey('ID_ECF_CAIXA')) {
        context.handle(_idEcfCaixaMeta,
            idEcfCaixa.isAcceptableOrUnknown(data['ID_ECF_CAIXA']!, _idEcfCaixaMeta));
    }
    if (data.containsKey('SERIE_ECF')) {
        context.handle(_serieEcfMeta,
            serieEcf.isAcceptableOrUnknown(data['SERIE_ECF']!, _serieEcfMeta));
    }
    if (data.containsKey('COO')) {
        context.handle(_cooMeta,
            coo.isAcceptableOrUnknown(data['COO']!, _cooMeta));
    }
    if (data.containsKey('GNF')) {
        context.handle(_gnfMeta,
            gnf.isAcceptableOrUnknown(data['GNF']!, _gnfMeta));
    }
    if (data.containsKey('GRG')) {
        context.handle(_grgMeta,
            grg.isAcceptableOrUnknown(data['GRG']!, _grgMeta));
    }
    if (data.containsKey('CDC')) {
        context.handle(_cdcMeta,
            cdc.isAcceptableOrUnknown(data['CDC']!, _cdcMeta));
    }
    if (data.containsKey('DENOMINACAO')) {
        context.handle(_denominacaoMeta,
            denominacao.isAcceptableOrUnknown(data['DENOMINACAO']!, _denominacaoMeta));
    }
    if (data.containsKey('DATA_EMISSAO')) {
        context.handle(_dataEmissaoMeta,
            dataEmissao.isAcceptableOrUnknown(data['DATA_EMISSAO']!, _dataEmissaoMeta));
    }
    if (data.containsKey('HORA_EMISSAO')) {
        context.handle(_horaEmissaoMeta,
            horaEmissao.isAcceptableOrUnknown(data['HORA_EMISSAO']!, _horaEmissaoMeta));
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
  EcfR06 map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EcfR06.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EcfR06sTable createAlias(String alias) {
    return $EcfR06sTable(_db, alias);
  }
}