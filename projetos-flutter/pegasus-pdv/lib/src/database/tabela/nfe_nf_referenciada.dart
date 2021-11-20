/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_NF_REFERENCIADA] 
                                                                                
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

@DataClassName("NfeNfReferenciada")
@UseRowClass(NfeNfReferenciada)
class NfeNfReferenciadas extends Table {
  @override
  String get tableName => 'NFE_NF_REFERENCIADA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  IntColumn get codigoUf => integer().named('CODIGO_UF').nullable()();
  TextColumn get anoMes => text().named('ANO_MES').withLength(min: 0, max: 4).nullable()();
  TextColumn get cnpj => text().named('CNPJ').withLength(min: 0, max: 14).nullable()();
  TextColumn get modelo => text().named('MODELO').withLength(min: 0, max: 2).nullable()();
  TextColumn get serie => text().named('SERIE').withLength(min: 0, max: 3).nullable()();
  IntColumn get numeroNf => integer().named('NUMERO_NF').nullable()();
}

class NfeNfReferenciada extends DataClass implements Insertable<NfeNfReferenciada> {
  final int? id;
  final int? idNfeCabecalho;
  final int? codigoUf;
  final String? anoMes;
  final String? cnpj;
  final String? modelo;
  final String? serie;
  final int? numeroNf;

  NfeNfReferenciada(
    {
      required this.id,
      this.idNfeCabecalho,
      this.codigoUf,
      this.anoMes,
      this.cnpj,
      this.modelo,
      this.serie,
      this.numeroNf,
    }
  );

  factory NfeNfReferenciada.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeNfReferenciada(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      codigoUf: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_UF']),
      anoMes: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ANO_MES']),
      cnpj: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CNPJ']),
      modelo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODELO']),
      serie: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SERIE']),
      numeroNf: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_NF']),
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
    if (!nullToAbsent || codigoUf != null) {
      map['CODIGO_UF'] = Variable<int?>(codigoUf);
    }
    if (!nullToAbsent || anoMes != null) {
      map['ANO_MES'] = Variable<String?>(anoMes);
    }
    if (!nullToAbsent || cnpj != null) {
      map['CNPJ'] = Variable<String?>(cnpj);
    }
    if (!nullToAbsent || modelo != null) {
      map['MODELO'] = Variable<String?>(modelo);
    }
    if (!nullToAbsent || serie != null) {
      map['SERIE'] = Variable<String?>(serie);
    }
    if (!nullToAbsent || numeroNf != null) {
      map['NUMERO_NF'] = Variable<int?>(numeroNf);
    }
    return map;
  }

  NfeNfReferenciadasCompanion toCompanion(bool nullToAbsent) {
    return NfeNfReferenciadasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      codigoUf: codigoUf == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoUf),
      anoMes: anoMes == null && nullToAbsent
        ? const Value.absent()
        : Value(anoMes),
      cnpj: cnpj == null && nullToAbsent
        ? const Value.absent()
        : Value(cnpj),
      modelo: modelo == null && nullToAbsent
        ? const Value.absent()
        : Value(modelo),
      serie: serie == null && nullToAbsent
        ? const Value.absent()
        : Value(serie),
      numeroNf: numeroNf == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroNf),
    );
  }

  factory NfeNfReferenciada.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeNfReferenciada(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      codigoUf: serializer.fromJson<int>(json['codigoUf']),
      anoMes: serializer.fromJson<String>(json['anoMes']),
      cnpj: serializer.fromJson<String>(json['cnpj']),
      modelo: serializer.fromJson<String>(json['modelo']),
      serie: serializer.fromJson<String>(json['serie']),
      numeroNf: serializer.fromJson<int>(json['numeroNf']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'codigoUf': serializer.toJson<int?>(codigoUf),
      'anoMes': serializer.toJson<String?>(anoMes),
      'cnpj': serializer.toJson<String?>(cnpj),
      'modelo': serializer.toJson<String?>(modelo),
      'serie': serializer.toJson<String?>(serie),
      'numeroNf': serializer.toJson<int?>(numeroNf),
    };
  }

  NfeNfReferenciada copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          int? codigoUf,
          String? anoMes,
          String? cnpj,
          String? modelo,
          String? serie,
          int? numeroNf,
		}) =>
      NfeNfReferenciada(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        codigoUf: codigoUf ?? this.codigoUf,
        anoMes: anoMes ?? this.anoMes,
        cnpj: cnpj ?? this.cnpj,
        modelo: modelo ?? this.modelo,
        serie: serie ?? this.serie,
        numeroNf: numeroNf ?? this.numeroNf,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeNfReferenciada(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('codigoUf: $codigoUf, ')
          ..write('anoMes: $anoMes, ')
          ..write('cnpj: $cnpj, ')
          ..write('modelo: $modelo, ')
          ..write('serie: $serie, ')
          ..write('numeroNf: $numeroNf, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      codigoUf,
      anoMes,
      cnpj,
      modelo,
      serie,
      numeroNf,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeNfReferenciada &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.codigoUf == codigoUf &&
          other.anoMes == anoMes &&
          other.cnpj == cnpj &&
          other.modelo == modelo &&
          other.serie == serie &&
          other.numeroNf == numeroNf 
	   );
}

class NfeNfReferenciadasCompanion extends UpdateCompanion<NfeNfReferenciada> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<int?> codigoUf;
  final Value<String?> anoMes;
  final Value<String?> cnpj;
  final Value<String?> modelo;
  final Value<String?> serie;
  final Value<int?> numeroNf;

  const NfeNfReferenciadasCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.codigoUf = const Value.absent(),
    this.anoMes = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.modelo = const Value.absent(),
    this.serie = const Value.absent(),
    this.numeroNf = const Value.absent(),
  });

  NfeNfReferenciadasCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.codigoUf = const Value.absent(),
    this.anoMes = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.modelo = const Value.absent(),
    this.serie = const Value.absent(),
    this.numeroNf = const Value.absent(),
  });

  static Insertable<NfeNfReferenciada> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<int>? codigoUf,
    Expression<String>? anoMes,
    Expression<String>? cnpj,
    Expression<String>? modelo,
    Expression<String>? serie,
    Expression<int>? numeroNf,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (codigoUf != null) 'CODIGO_UF': codigoUf,
      if (anoMes != null) 'ANO_MES': anoMes,
      if (cnpj != null) 'CNPJ': cnpj,
      if (modelo != null) 'MODELO': modelo,
      if (serie != null) 'SERIE': serie,
      if (numeroNf != null) 'NUMERO_NF': numeroNf,
    });
  }

  NfeNfReferenciadasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<int>? codigoUf,
      Value<String>? anoMes,
      Value<String>? cnpj,
      Value<String>? modelo,
      Value<String>? serie,
      Value<int>? numeroNf,
	  }) {
    return NfeNfReferenciadasCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      codigoUf: codigoUf ?? this.codigoUf,
      anoMes: anoMes ?? this.anoMes,
      cnpj: cnpj ?? this.cnpj,
      modelo: modelo ?? this.modelo,
      serie: serie ?? this.serie,
      numeroNf: numeroNf ?? this.numeroNf,
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
    if (codigoUf.present) {
      map['CODIGO_UF'] = Variable<int?>(codigoUf.value);
    }
    if (anoMes.present) {
      map['ANO_MES'] = Variable<String?>(anoMes.value);
    }
    if (cnpj.present) {
      map['CNPJ'] = Variable<String?>(cnpj.value);
    }
    if (modelo.present) {
      map['MODELO'] = Variable<String?>(modelo.value);
    }
    if (serie.present) {
      map['SERIE'] = Variable<String?>(serie.value);
    }
    if (numeroNf.present) {
      map['NUMERO_NF'] = Variable<int?>(numeroNf.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeNfReferenciadasCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('codigoUf: $codigoUf, ')
          ..write('anoMes: $anoMes, ')
          ..write('cnpj: $cnpj, ')
          ..write('modelo: $modelo, ')
          ..write('serie: $serie, ')
          ..write('numeroNf: $numeroNf, ')
          ..write(')'))
        .toString();
  }
}

class $NfeNfReferenciadasTable extends NfeNfReferenciadas
    with TableInfo<$NfeNfReferenciadasTable, NfeNfReferenciada> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeNfReferenciadasTable(this._db, [this._alias]);
  
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
  final VerificationMeta _codigoUfMeta =
      const VerificationMeta('codigoUf');
  GeneratedColumn<int>? _codigoUf;
  @override
  GeneratedColumn<int> get codigoUf => _codigoUf ??=
      GeneratedColumn<int>('CODIGO_UF', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _anoMesMeta =
      const VerificationMeta('anoMes');
  GeneratedColumn<String>? _anoMes;
  @override
  GeneratedColumn<String> get anoMes => _anoMes ??=
      GeneratedColumn<String>('ANO_MES', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cnpjMeta =
      const VerificationMeta('cnpj');
  GeneratedColumn<String>? _cnpj;
  @override
  GeneratedColumn<String> get cnpj => _cnpj ??=
      GeneratedColumn<String>('CNPJ', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _modeloMeta =
      const VerificationMeta('modelo');
  GeneratedColumn<String>? _modelo;
  @override
  GeneratedColumn<String> get modelo => _modelo ??=
      GeneratedColumn<String>('MODELO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _serieMeta =
      const VerificationMeta('serie');
  GeneratedColumn<String>? _serie;
  @override
  GeneratedColumn<String> get serie => _serie ??=
      GeneratedColumn<String>('SERIE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroNfMeta =
      const VerificationMeta('numeroNf');
  GeneratedColumn<int>? _numeroNf;
  @override
  GeneratedColumn<int> get numeroNf => _numeroNf ??=
      GeneratedColumn<int>('NUMERO_NF', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        codigoUf,
        anoMes,
        cnpj,
        modelo,
        serie,
        numeroNf,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_NF_REFERENCIADA';
  
  @override
  String get actualTableName => 'NFE_NF_REFERENCIADA';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeNfReferenciada> instance,
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
    if (data.containsKey('CODIGO_UF')) {
        context.handle(_codigoUfMeta,
            codigoUf.isAcceptableOrUnknown(data['CODIGO_UF']!, _codigoUfMeta));
    }
    if (data.containsKey('ANO_MES')) {
        context.handle(_anoMesMeta,
            anoMes.isAcceptableOrUnknown(data['ANO_MES']!, _anoMesMeta));
    }
    if (data.containsKey('CNPJ')) {
        context.handle(_cnpjMeta,
            cnpj.isAcceptableOrUnknown(data['CNPJ']!, _cnpjMeta));
    }
    if (data.containsKey('MODELO')) {
        context.handle(_modeloMeta,
            modelo.isAcceptableOrUnknown(data['MODELO']!, _modeloMeta));
    }
    if (data.containsKey('SERIE')) {
        context.handle(_serieMeta,
            serie.isAcceptableOrUnknown(data['SERIE']!, _serieMeta));
    }
    if (data.containsKey('NUMERO_NF')) {
        context.handle(_numeroNfMeta,
            numeroNf.isAcceptableOrUnknown(data['NUMERO_NF']!, _numeroNfMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeNfReferenciada map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeNfReferenciada.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeNfReferenciadasTable createAlias(String alias) {
    return $NfeNfReferenciadasTable(_db, alias);
  }
}