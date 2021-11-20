/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE_IMPOSTO_IPI] 
                                                                                
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

@DataClassName("NfeDetalheImpostoIpi")
@UseRowClass(NfeDetalheImpostoIpi)
class NfeDetalheImpostoIpis extends Table {
  @override
  String get tableName => 'NFE_DETALHE_IMPOSTO_IPI';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  TextColumn get cnpjProdutor => text().named('CNPJ_PRODUTOR').withLength(min: 0, max: 14).nullable()();
  TextColumn get codigoSeloIpi => text().named('CODIGO_SELO_IPI').withLength(min: 0, max: 60).nullable()();
  IntColumn get quantidadeSeloIpi => integer().named('QUANTIDADE_SELO_IPI').nullable()();
  TextColumn get enquadramentoLegalIpi => text().named('ENQUADRAMENTO_LEGAL_IPI').withLength(min: 0, max: 3).nullable()();
  TextColumn get cstIpi => text().named('CST_IPI').withLength(min: 0, max: 2).nullable()();
  RealColumn get valorBaseCalculoIpi => real().named('VALOR_BASE_CALCULO_IPI').nullable()();
  RealColumn get quantidadeUnidadeTributavel => real().named('QUANTIDADE_UNIDADE_TRIBUTAVEL').nullable()();
  RealColumn get valorUnidadeTributavel => real().named('VALOR_UNIDADE_TRIBUTAVEL').nullable()();
  RealColumn get aliquotaIpi => real().named('ALIQUOTA_IPI').nullable()();
  RealColumn get valorIpi => real().named('VALOR_IPI').nullable()();
}

class NfeDetalheImpostoIpi extends DataClass implements Insertable<NfeDetalheImpostoIpi> {
  final int? id;
  final int? idNfeDetalhe;
  final String? cnpjProdutor;
  final String? codigoSeloIpi;
  final int? quantidadeSeloIpi;
  final String? enquadramentoLegalIpi;
  final String? cstIpi;
  final double? valorBaseCalculoIpi;
  final double? quantidadeUnidadeTributavel;
  final double? valorUnidadeTributavel;
  final double? aliquotaIpi;
  final double? valorIpi;

  NfeDetalheImpostoIpi(
    {
      required this.id,
      this.idNfeDetalhe,
      this.cnpjProdutor,
      this.codigoSeloIpi,
      this.quantidadeSeloIpi,
      this.enquadramentoLegalIpi,
      this.cstIpi,
      this.valorBaseCalculoIpi,
      this.quantidadeUnidadeTributavel,
      this.valorUnidadeTributavel,
      this.aliquotaIpi,
      this.valorIpi,
    }
  );

  factory NfeDetalheImpostoIpi.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetalheImpostoIpi(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      cnpjProdutor: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CNPJ_PRODUTOR']),
      codigoSeloIpi: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_SELO_IPI']),
      quantidadeSeloIpi: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_SELO_IPI']),
      enquadramentoLegalIpi: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ENQUADRAMENTO_LEGAL_IPI']),
      cstIpi: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CST_IPI']),
      valorBaseCalculoIpi: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BASE_CALCULO_IPI']),
      quantidadeUnidadeTributavel: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE_UNIDADE_TRIBUTAVEL']),
      valorUnidadeTributavel: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_UNIDADE_TRIBUTAVEL']),
      aliquotaIpi: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_IPI']),
      valorIpi: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IPI']),
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
    if (!nullToAbsent || cnpjProdutor != null) {
      map['CNPJ_PRODUTOR'] = Variable<String?>(cnpjProdutor);
    }
    if (!nullToAbsent || codigoSeloIpi != null) {
      map['CODIGO_SELO_IPI'] = Variable<String?>(codigoSeloIpi);
    }
    if (!nullToAbsent || quantidadeSeloIpi != null) {
      map['QUANTIDADE_SELO_IPI'] = Variable<int?>(quantidadeSeloIpi);
    }
    if (!nullToAbsent || enquadramentoLegalIpi != null) {
      map['ENQUADRAMENTO_LEGAL_IPI'] = Variable<String?>(enquadramentoLegalIpi);
    }
    if (!nullToAbsent || cstIpi != null) {
      map['CST_IPI'] = Variable<String?>(cstIpi);
    }
    if (!nullToAbsent || valorBaseCalculoIpi != null) {
      map['VALOR_BASE_CALCULO_IPI'] = Variable<double?>(valorBaseCalculoIpi);
    }
    if (!nullToAbsent || quantidadeUnidadeTributavel != null) {
      map['QUANTIDADE_UNIDADE_TRIBUTAVEL'] = Variable<double?>(quantidadeUnidadeTributavel);
    }
    if (!nullToAbsent || valorUnidadeTributavel != null) {
      map['VALOR_UNIDADE_TRIBUTAVEL'] = Variable<double?>(valorUnidadeTributavel);
    }
    if (!nullToAbsent || aliquotaIpi != null) {
      map['ALIQUOTA_IPI'] = Variable<double?>(aliquotaIpi);
    }
    if (!nullToAbsent || valorIpi != null) {
      map['VALOR_IPI'] = Variable<double?>(valorIpi);
    }
    return map;
  }

  NfeDetalheImpostoIpisCompanion toCompanion(bool nullToAbsent) {
    return NfeDetalheImpostoIpisCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      cnpjProdutor: cnpjProdutor == null && nullToAbsent
        ? const Value.absent()
        : Value(cnpjProdutor),
      codigoSeloIpi: codigoSeloIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoSeloIpi),
      quantidadeSeloIpi: quantidadeSeloIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeSeloIpi),
      enquadramentoLegalIpi: enquadramentoLegalIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(enquadramentoLegalIpi),
      cstIpi: cstIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(cstIpi),
      valorBaseCalculoIpi: valorBaseCalculoIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBaseCalculoIpi),
      quantidadeUnidadeTributavel: quantidadeUnidadeTributavel == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidadeUnidadeTributavel),
      valorUnidadeTributavel: valorUnidadeTributavel == null && nullToAbsent
        ? const Value.absent()
        : Value(valorUnidadeTributavel),
      aliquotaIpi: aliquotaIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaIpi),
      valorIpi: valorIpi == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIpi),
    );
  }

  factory NfeDetalheImpostoIpi.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetalheImpostoIpi(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      cnpjProdutor: serializer.fromJson<String>(json['cnpjProdutor']),
      codigoSeloIpi: serializer.fromJson<String>(json['codigoSeloIpi']),
      quantidadeSeloIpi: serializer.fromJson<int>(json['quantidadeSeloIpi']),
      enquadramentoLegalIpi: serializer.fromJson<String>(json['enquadramentoLegalIpi']),
      cstIpi: serializer.fromJson<String>(json['cstIpi']),
      valorBaseCalculoIpi: serializer.fromJson<double>(json['valorBaseCalculoIpi']),
      quantidadeUnidadeTributavel: serializer.fromJson<double>(json['quantidadeUnidadeTributavel']),
      valorUnidadeTributavel: serializer.fromJson<double>(json['valorUnidadeTributavel']),
      aliquotaIpi: serializer.fromJson<double>(json['aliquotaIpi']),
      valorIpi: serializer.fromJson<double>(json['valorIpi']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'cnpjProdutor': serializer.toJson<String?>(cnpjProdutor),
      'codigoSeloIpi': serializer.toJson<String?>(codigoSeloIpi),
      'quantidadeSeloIpi': serializer.toJson<int?>(quantidadeSeloIpi),
      'enquadramentoLegalIpi': serializer.toJson<String?>(enquadramentoLegalIpi),
      'cstIpi': serializer.toJson<String?>(cstIpi),
      'valorBaseCalculoIpi': serializer.toJson<double?>(valorBaseCalculoIpi),
      'quantidadeUnidadeTributavel': serializer.toJson<double?>(quantidadeUnidadeTributavel),
      'valorUnidadeTributavel': serializer.toJson<double?>(valorUnidadeTributavel),
      'aliquotaIpi': serializer.toJson<double?>(aliquotaIpi),
      'valorIpi': serializer.toJson<double?>(valorIpi),
    };
  }

  NfeDetalheImpostoIpi copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          String? cnpjProdutor,
          String? codigoSeloIpi,
          int? quantidadeSeloIpi,
          String? enquadramentoLegalIpi,
          String? cstIpi,
          double? valorBaseCalculoIpi,
          double? quantidadeUnidadeTributavel,
          double? valorUnidadeTributavel,
          double? aliquotaIpi,
          double? valorIpi,
		}) =>
      NfeDetalheImpostoIpi(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        cnpjProdutor: cnpjProdutor ?? this.cnpjProdutor,
        codigoSeloIpi: codigoSeloIpi ?? this.codigoSeloIpi,
        quantidadeSeloIpi: quantidadeSeloIpi ?? this.quantidadeSeloIpi,
        enquadramentoLegalIpi: enquadramentoLegalIpi ?? this.enquadramentoLegalIpi,
        cstIpi: cstIpi ?? this.cstIpi,
        valorBaseCalculoIpi: valorBaseCalculoIpi ?? this.valorBaseCalculoIpi,
        quantidadeUnidadeTributavel: quantidadeUnidadeTributavel ?? this.quantidadeUnidadeTributavel,
        valorUnidadeTributavel: valorUnidadeTributavel ?? this.valorUnidadeTributavel,
        aliquotaIpi: aliquotaIpi ?? this.aliquotaIpi,
        valorIpi: valorIpi ?? this.valorIpi,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoIpi(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('cnpjProdutor: $cnpjProdutor, ')
          ..write('codigoSeloIpi: $codigoSeloIpi, ')
          ..write('quantidadeSeloIpi: $quantidadeSeloIpi, ')
          ..write('enquadramentoLegalIpi: $enquadramentoLegalIpi, ')
          ..write('cstIpi: $cstIpi, ')
          ..write('valorBaseCalculoIpi: $valorBaseCalculoIpi, ')
          ..write('quantidadeUnidadeTributavel: $quantidadeUnidadeTributavel, ')
          ..write('valorUnidadeTributavel: $valorUnidadeTributavel, ')
          ..write('aliquotaIpi: $aliquotaIpi, ')
          ..write('valorIpi: $valorIpi, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      cnpjProdutor,
      codigoSeloIpi,
      quantidadeSeloIpi,
      enquadramentoLegalIpi,
      cstIpi,
      valorBaseCalculoIpi,
      quantidadeUnidadeTributavel,
      valorUnidadeTributavel,
      aliquotaIpi,
      valorIpi,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetalheImpostoIpi &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.cnpjProdutor == cnpjProdutor &&
          other.codigoSeloIpi == codigoSeloIpi &&
          other.quantidadeSeloIpi == quantidadeSeloIpi &&
          other.enquadramentoLegalIpi == enquadramentoLegalIpi &&
          other.cstIpi == cstIpi &&
          other.valorBaseCalculoIpi == valorBaseCalculoIpi &&
          other.quantidadeUnidadeTributavel == quantidadeUnidadeTributavel &&
          other.valorUnidadeTributavel == valorUnidadeTributavel &&
          other.aliquotaIpi == aliquotaIpi &&
          other.valorIpi == valorIpi 
	   );
}

class NfeDetalheImpostoIpisCompanion extends UpdateCompanion<NfeDetalheImpostoIpi> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<String?> cnpjProdutor;
  final Value<String?> codigoSeloIpi;
  final Value<int?> quantidadeSeloIpi;
  final Value<String?> enquadramentoLegalIpi;
  final Value<String?> cstIpi;
  final Value<double?> valorBaseCalculoIpi;
  final Value<double?> quantidadeUnidadeTributavel;
  final Value<double?> valorUnidadeTributavel;
  final Value<double?> aliquotaIpi;
  final Value<double?> valorIpi;

  const NfeDetalheImpostoIpisCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.cnpjProdutor = const Value.absent(),
    this.codigoSeloIpi = const Value.absent(),
    this.quantidadeSeloIpi = const Value.absent(),
    this.enquadramentoLegalIpi = const Value.absent(),
    this.cstIpi = const Value.absent(),
    this.valorBaseCalculoIpi = const Value.absent(),
    this.quantidadeUnidadeTributavel = const Value.absent(),
    this.valorUnidadeTributavel = const Value.absent(),
    this.aliquotaIpi = const Value.absent(),
    this.valorIpi = const Value.absent(),
  });

  NfeDetalheImpostoIpisCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.cnpjProdutor = const Value.absent(),
    this.codigoSeloIpi = const Value.absent(),
    this.quantidadeSeloIpi = const Value.absent(),
    this.enquadramentoLegalIpi = const Value.absent(),
    this.cstIpi = const Value.absent(),
    this.valorBaseCalculoIpi = const Value.absent(),
    this.quantidadeUnidadeTributavel = const Value.absent(),
    this.valorUnidadeTributavel = const Value.absent(),
    this.aliquotaIpi = const Value.absent(),
    this.valorIpi = const Value.absent(),
  });

  static Insertable<NfeDetalheImpostoIpi> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<String>? cnpjProdutor,
    Expression<String>? codigoSeloIpi,
    Expression<int>? quantidadeSeloIpi,
    Expression<String>? enquadramentoLegalIpi,
    Expression<String>? cstIpi,
    Expression<double>? valorBaseCalculoIpi,
    Expression<double>? quantidadeUnidadeTributavel,
    Expression<double>? valorUnidadeTributavel,
    Expression<double>? aliquotaIpi,
    Expression<double>? valorIpi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (cnpjProdutor != null) 'CNPJ_PRODUTOR': cnpjProdutor,
      if (codigoSeloIpi != null) 'CODIGO_SELO_IPI': codigoSeloIpi,
      if (quantidadeSeloIpi != null) 'QUANTIDADE_SELO_IPI': quantidadeSeloIpi,
      if (enquadramentoLegalIpi != null) 'ENQUADRAMENTO_LEGAL_IPI': enquadramentoLegalIpi,
      if (cstIpi != null) 'CST_IPI': cstIpi,
      if (valorBaseCalculoIpi != null) 'VALOR_BASE_CALCULO_IPI': valorBaseCalculoIpi,
      if (quantidadeUnidadeTributavel != null) 'QUANTIDADE_UNIDADE_TRIBUTAVEL': quantidadeUnidadeTributavel,
      if (valorUnidadeTributavel != null) 'VALOR_UNIDADE_TRIBUTAVEL': valorUnidadeTributavel,
      if (aliquotaIpi != null) 'ALIQUOTA_IPI': aliquotaIpi,
      if (valorIpi != null) 'VALOR_IPI': valorIpi,
    });
  }

  NfeDetalheImpostoIpisCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<String>? cnpjProdutor,
      Value<String>? codigoSeloIpi,
      Value<int>? quantidadeSeloIpi,
      Value<String>? enquadramentoLegalIpi,
      Value<String>? cstIpi,
      Value<double>? valorBaseCalculoIpi,
      Value<double>? quantidadeUnidadeTributavel,
      Value<double>? valorUnidadeTributavel,
      Value<double>? aliquotaIpi,
      Value<double>? valorIpi,
	  }) {
    return NfeDetalheImpostoIpisCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      cnpjProdutor: cnpjProdutor ?? this.cnpjProdutor,
      codigoSeloIpi: codigoSeloIpi ?? this.codigoSeloIpi,
      quantidadeSeloIpi: quantidadeSeloIpi ?? this.quantidadeSeloIpi,
      enquadramentoLegalIpi: enquadramentoLegalIpi ?? this.enquadramentoLegalIpi,
      cstIpi: cstIpi ?? this.cstIpi,
      valorBaseCalculoIpi: valorBaseCalculoIpi ?? this.valorBaseCalculoIpi,
      quantidadeUnidadeTributavel: quantidadeUnidadeTributavel ?? this.quantidadeUnidadeTributavel,
      valorUnidadeTributavel: valorUnidadeTributavel ?? this.valorUnidadeTributavel,
      aliquotaIpi: aliquotaIpi ?? this.aliquotaIpi,
      valorIpi: valorIpi ?? this.valorIpi,
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
    if (cnpjProdutor.present) {
      map['CNPJ_PRODUTOR'] = Variable<String?>(cnpjProdutor.value);
    }
    if (codigoSeloIpi.present) {
      map['CODIGO_SELO_IPI'] = Variable<String?>(codigoSeloIpi.value);
    }
    if (quantidadeSeloIpi.present) {
      map['QUANTIDADE_SELO_IPI'] = Variable<int?>(quantidadeSeloIpi.value);
    }
    if (enquadramentoLegalIpi.present) {
      map['ENQUADRAMENTO_LEGAL_IPI'] = Variable<String?>(enquadramentoLegalIpi.value);
    }
    if (cstIpi.present) {
      map['CST_IPI'] = Variable<String?>(cstIpi.value);
    }
    if (valorBaseCalculoIpi.present) {
      map['VALOR_BASE_CALCULO_IPI'] = Variable<double?>(valorBaseCalculoIpi.value);
    }
    if (quantidadeUnidadeTributavel.present) {
      map['QUANTIDADE_UNIDADE_TRIBUTAVEL'] = Variable<double?>(quantidadeUnidadeTributavel.value);
    }
    if (valorUnidadeTributavel.present) {
      map['VALOR_UNIDADE_TRIBUTAVEL'] = Variable<double?>(valorUnidadeTributavel.value);
    }
    if (aliquotaIpi.present) {
      map['ALIQUOTA_IPI'] = Variable<double?>(aliquotaIpi.value);
    }
    if (valorIpi.present) {
      map['VALOR_IPI'] = Variable<double?>(valorIpi.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoIpisCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('cnpjProdutor: $cnpjProdutor, ')
          ..write('codigoSeloIpi: $codigoSeloIpi, ')
          ..write('quantidadeSeloIpi: $quantidadeSeloIpi, ')
          ..write('enquadramentoLegalIpi: $enquadramentoLegalIpi, ')
          ..write('cstIpi: $cstIpi, ')
          ..write('valorBaseCalculoIpi: $valorBaseCalculoIpi, ')
          ..write('quantidadeUnidadeTributavel: $quantidadeUnidadeTributavel, ')
          ..write('valorUnidadeTributavel: $valorUnidadeTributavel, ')
          ..write('aliquotaIpi: $aliquotaIpi, ')
          ..write('valorIpi: $valorIpi, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetalheImpostoIpisTable extends NfeDetalheImpostoIpis
    with TableInfo<$NfeDetalheImpostoIpisTable, NfeDetalheImpostoIpi> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetalheImpostoIpisTable(this._db, [this._alias]);
  
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
  final VerificationMeta _cnpjProdutorMeta =
      const VerificationMeta('cnpjProdutor');
  GeneratedColumn<String>? _cnpjProdutor;
  @override
  GeneratedColumn<String> get cnpjProdutor => _cnpjProdutor ??=
      GeneratedColumn<String>('CNPJ_PRODUTOR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoSeloIpiMeta =
      const VerificationMeta('codigoSeloIpi');
  GeneratedColumn<String>? _codigoSeloIpi;
  @override
  GeneratedColumn<String> get codigoSeloIpi => _codigoSeloIpi ??=
      GeneratedColumn<String>('CODIGO_SELO_IPI', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _quantidadeSeloIpiMeta =
      const VerificationMeta('quantidadeSeloIpi');
  GeneratedColumn<int>? _quantidadeSeloIpi;
  @override
  GeneratedColumn<int> get quantidadeSeloIpi => _quantidadeSeloIpi ??=
      GeneratedColumn<int>('QUANTIDADE_SELO_IPI', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _enquadramentoLegalIpiMeta =
      const VerificationMeta('enquadramentoLegalIpi');
  GeneratedColumn<String>? _enquadramentoLegalIpi;
  @override
  GeneratedColumn<String> get enquadramentoLegalIpi => _enquadramentoLegalIpi ??=
      GeneratedColumn<String>('ENQUADRAMENTO_LEGAL_IPI', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cstIpiMeta =
      const VerificationMeta('cstIpi');
  GeneratedColumn<String>? _cstIpi;
  @override
  GeneratedColumn<String> get cstIpi => _cstIpi ??=
      GeneratedColumn<String>('CST_IPI', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorBaseCalculoIpiMeta =
      const VerificationMeta('valorBaseCalculoIpi');
  GeneratedColumn<double>? _valorBaseCalculoIpi;
  @override
  GeneratedColumn<double> get valorBaseCalculoIpi => _valorBaseCalculoIpi ??=
      GeneratedColumn<double>('VALOR_BASE_CALCULO_IPI', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _quantidadeUnidadeTributavelMeta =
      const VerificationMeta('quantidadeUnidadeTributavel');
  GeneratedColumn<double>? _quantidadeUnidadeTributavel;
  @override
  GeneratedColumn<double> get quantidadeUnidadeTributavel => _quantidadeUnidadeTributavel ??=
      GeneratedColumn<double>('QUANTIDADE_UNIDADE_TRIBUTAVEL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorUnidadeTributavelMeta =
      const VerificationMeta('valorUnidadeTributavel');
  GeneratedColumn<double>? _valorUnidadeTributavel;
  @override
  GeneratedColumn<double> get valorUnidadeTributavel => _valorUnidadeTributavel ??=
      GeneratedColumn<double>('VALOR_UNIDADE_TRIBUTAVEL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaIpiMeta =
      const VerificationMeta('aliquotaIpi');
  GeneratedColumn<double>? _aliquotaIpi;
  @override
  GeneratedColumn<double> get aliquotaIpi => _aliquotaIpi ??=
      GeneratedColumn<double>('ALIQUOTA_IPI', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIpiMeta =
      const VerificationMeta('valorIpi');
  GeneratedColumn<double>? _valorIpi;
  @override
  GeneratedColumn<double> get valorIpi => _valorIpi ??=
      GeneratedColumn<double>('VALOR_IPI', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        cnpjProdutor,
        codigoSeloIpi,
        quantidadeSeloIpi,
        enquadramentoLegalIpi,
        cstIpi,
        valorBaseCalculoIpi,
        quantidadeUnidadeTributavel,
        valorUnidadeTributavel,
        aliquotaIpi,
        valorIpi,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DETALHE_IMPOSTO_IPI';
  
  @override
  String get actualTableName => 'NFE_DETALHE_IMPOSTO_IPI';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetalheImpostoIpi> instance,
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
    if (data.containsKey('CNPJ_PRODUTOR')) {
        context.handle(_cnpjProdutorMeta,
            cnpjProdutor.isAcceptableOrUnknown(data['CNPJ_PRODUTOR']!, _cnpjProdutorMeta));
    }
    if (data.containsKey('CODIGO_SELO_IPI')) {
        context.handle(_codigoSeloIpiMeta,
            codigoSeloIpi.isAcceptableOrUnknown(data['CODIGO_SELO_IPI']!, _codigoSeloIpiMeta));
    }
    if (data.containsKey('QUANTIDADE_SELO_IPI')) {
        context.handle(_quantidadeSeloIpiMeta,
            quantidadeSeloIpi.isAcceptableOrUnknown(data['QUANTIDADE_SELO_IPI']!, _quantidadeSeloIpiMeta));
    }
    if (data.containsKey('ENQUADRAMENTO_LEGAL_IPI')) {
        context.handle(_enquadramentoLegalIpiMeta,
            enquadramentoLegalIpi.isAcceptableOrUnknown(data['ENQUADRAMENTO_LEGAL_IPI']!, _enquadramentoLegalIpiMeta));
    }
    if (data.containsKey('CST_IPI')) {
        context.handle(_cstIpiMeta,
            cstIpi.isAcceptableOrUnknown(data['CST_IPI']!, _cstIpiMeta));
    }
    if (data.containsKey('VALOR_BASE_CALCULO_IPI')) {
        context.handle(_valorBaseCalculoIpiMeta,
            valorBaseCalculoIpi.isAcceptableOrUnknown(data['VALOR_BASE_CALCULO_IPI']!, _valorBaseCalculoIpiMeta));
    }
    if (data.containsKey('QUANTIDADE_UNIDADE_TRIBUTAVEL')) {
        context.handle(_quantidadeUnidadeTributavelMeta,
            quantidadeUnidadeTributavel.isAcceptableOrUnknown(data['QUANTIDADE_UNIDADE_TRIBUTAVEL']!, _quantidadeUnidadeTributavelMeta));
    }
    if (data.containsKey('VALOR_UNIDADE_TRIBUTAVEL')) {
        context.handle(_valorUnidadeTributavelMeta,
            valorUnidadeTributavel.isAcceptableOrUnknown(data['VALOR_UNIDADE_TRIBUTAVEL']!, _valorUnidadeTributavelMeta));
    }
    if (data.containsKey('ALIQUOTA_IPI')) {
        context.handle(_aliquotaIpiMeta,
            aliquotaIpi.isAcceptableOrUnknown(data['ALIQUOTA_IPI']!, _aliquotaIpiMeta));
    }
    if (data.containsKey('VALOR_IPI')) {
        context.handle(_valorIpiMeta,
            valorIpi.isAcceptableOrUnknown(data['VALOR_IPI']!, _valorIpiMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDetalheImpostoIpi map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetalheImpostoIpi.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetalheImpostoIpisTable createAlias(String alias) {
    return $NfeDetalheImpostoIpisTable(_db, alias);
  }
}