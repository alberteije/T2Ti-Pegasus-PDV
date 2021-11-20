/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_E3] 
                                                                                
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

@DataClassName("EcfE3")
@UseRowClass(EcfE3)
class EcfE3s extends Table {
  @override
  String get tableName => 'ECF_E3';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get serieEcf => text().named('SERIE_ECF').withLength(min: 0, max: 20).nullable()();
  TextColumn get mfAdicional => text().named('MF_ADICIONAL').withLength(min: 0, max: 1).nullable()();
  TextColumn get tipoEcf => text().named('TIPO_ECF').withLength(min: 0, max: 7).nullable()();
  TextColumn get marcaEcf => text().named('MARCA_ECF').withLength(min: 0, max: 20).nullable()();
  TextColumn get modeloEcf => text().named('MODELO_ECF').withLength(min: 0, max: 20).nullable()();
  DateTimeColumn get dataEstoque => dateTime().named('DATA_ESTOQUE').nullable()();
  TextColumn get horaEstoque => text().named('HORA_ESTOQUE').withLength(min: 0, max: 8).nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()();
}

class EcfE3 extends DataClass implements Insertable<EcfE3> {
  final int? id;
  final String? serieEcf;
  final String? mfAdicional;
  final String? tipoEcf;
  final String? marcaEcf;
  final String? modeloEcf;
  final DateTime? dataEstoque;
  final String? horaEstoque;
  final String? hashRegistro;

  EcfE3(
    {
      required this.id,
      this.serieEcf,
      this.mfAdicional,
      this.tipoEcf,
      this.marcaEcf,
      this.modeloEcf,
      this.dataEstoque,
      this.horaEstoque,
      this.hashRegistro,
    }
  );

  factory EcfE3.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EcfE3(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      serieEcf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SERIE_ECF']),
      mfAdicional: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MF_ADICIONAL']),
      tipoEcf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_ECF']),
      marcaEcf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MARCA_ECF']),
      modeloEcf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODELO_ECF']),
      dataEstoque: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_ESTOQUE']),
      horaEstoque: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_ESTOQUE']),
      hashRegistro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HASH_REGISTRO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || serieEcf != null) {
      map['SERIE_ECF'] = Variable<String?>(serieEcf);
    }
    if (!nullToAbsent || mfAdicional != null) {
      map['MF_ADICIONAL'] = Variable<String?>(mfAdicional);
    }
    if (!nullToAbsent || tipoEcf != null) {
      map['TIPO_ECF'] = Variable<String?>(tipoEcf);
    }
    if (!nullToAbsent || marcaEcf != null) {
      map['MARCA_ECF'] = Variable<String?>(marcaEcf);
    }
    if (!nullToAbsent || modeloEcf != null) {
      map['MODELO_ECF'] = Variable<String?>(modeloEcf);
    }
    if (!nullToAbsent || dataEstoque != null) {
      map['DATA_ESTOQUE'] = Variable<DateTime?>(dataEstoque);
    }
    if (!nullToAbsent || horaEstoque != null) {
      map['HORA_ESTOQUE'] = Variable<String?>(horaEstoque);
    }
    if (!nullToAbsent || hashRegistro != null) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro);
    }
    return map;
  }

  EcfE3sCompanion toCompanion(bool nullToAbsent) {
    return EcfE3sCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      serieEcf: serieEcf == null && nullToAbsent
        ? const Value.absent()
        : Value(serieEcf),
      mfAdicional: mfAdicional == null && nullToAbsent
        ? const Value.absent()
        : Value(mfAdicional),
      tipoEcf: tipoEcf == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoEcf),
      marcaEcf: marcaEcf == null && nullToAbsent
        ? const Value.absent()
        : Value(marcaEcf),
      modeloEcf: modeloEcf == null && nullToAbsent
        ? const Value.absent()
        : Value(modeloEcf),
      dataEstoque: dataEstoque == null && nullToAbsent
        ? const Value.absent()
        : Value(dataEstoque),
      horaEstoque: horaEstoque == null && nullToAbsent
        ? const Value.absent()
        : Value(horaEstoque),
      hashRegistro: hashRegistro == null && nullToAbsent
        ? const Value.absent()
        : Value(hashRegistro),
    );
  }

  factory EcfE3.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EcfE3(
      id: serializer.fromJson<int>(json['id']),
      serieEcf: serializer.fromJson<String>(json['serieEcf']),
      mfAdicional: serializer.fromJson<String>(json['mfAdicional']),
      tipoEcf: serializer.fromJson<String>(json['tipoEcf']),
      marcaEcf: serializer.fromJson<String>(json['marcaEcf']),
      modeloEcf: serializer.fromJson<String>(json['modeloEcf']),
      dataEstoque: serializer.fromJson<DateTime>(json['dataEstoque']),
      horaEstoque: serializer.fromJson<String>(json['horaEstoque']),
      hashRegistro: serializer.fromJson<String>(json['hashRegistro']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'serieEcf': serializer.toJson<String?>(serieEcf),
      'mfAdicional': serializer.toJson<String?>(mfAdicional),
      'tipoEcf': serializer.toJson<String?>(tipoEcf),
      'marcaEcf': serializer.toJson<String?>(marcaEcf),
      'modeloEcf': serializer.toJson<String?>(modeloEcf),
      'dataEstoque': serializer.toJson<DateTime?>(dataEstoque),
      'horaEstoque': serializer.toJson<String?>(horaEstoque),
      'hashRegistro': serializer.toJson<String?>(hashRegistro),
    };
  }

  EcfE3 copyWith(
        {
		  int? id,
          String? serieEcf,
          String? mfAdicional,
          String? tipoEcf,
          String? marcaEcf,
          String? modeloEcf,
          DateTime? dataEstoque,
          String? horaEstoque,
          String? hashRegistro,
		}) =>
      EcfE3(
        id: id ?? this.id,
        serieEcf: serieEcf ?? this.serieEcf,
        mfAdicional: mfAdicional ?? this.mfAdicional,
        tipoEcf: tipoEcf ?? this.tipoEcf,
        marcaEcf: marcaEcf ?? this.marcaEcf,
        modeloEcf: modeloEcf ?? this.modeloEcf,
        dataEstoque: dataEstoque ?? this.dataEstoque,
        horaEstoque: horaEstoque ?? this.horaEstoque,
        hashRegistro: hashRegistro ?? this.hashRegistro,
      );
  
  @override
  String toString() {
    return (StringBuffer('EcfE3(')
          ..write('id: $id, ')
          ..write('serieEcf: $serieEcf, ')
          ..write('mfAdicional: $mfAdicional, ')
          ..write('tipoEcf: $tipoEcf, ')
          ..write('marcaEcf: $marcaEcf, ')
          ..write('modeloEcf: $modeloEcf, ')
          ..write('dataEstoque: $dataEstoque, ')
          ..write('horaEstoque: $horaEstoque, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      serieEcf,
      mfAdicional,
      tipoEcf,
      marcaEcf,
      modeloEcf,
      dataEstoque,
      horaEstoque,
      hashRegistro,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcfE3 &&
          other.id == id &&
          other.serieEcf == serieEcf &&
          other.mfAdicional == mfAdicional &&
          other.tipoEcf == tipoEcf &&
          other.marcaEcf == marcaEcf &&
          other.modeloEcf == modeloEcf &&
          other.dataEstoque == dataEstoque &&
          other.horaEstoque == horaEstoque &&
          other.hashRegistro == hashRegistro 
	   );
}

class EcfE3sCompanion extends UpdateCompanion<EcfE3> {

  final Value<int?> id;
  final Value<String?> serieEcf;
  final Value<String?> mfAdicional;
  final Value<String?> tipoEcf;
  final Value<String?> marcaEcf;
  final Value<String?> modeloEcf;
  final Value<DateTime?> dataEstoque;
  final Value<String?> horaEstoque;
  final Value<String?> hashRegistro;

  const EcfE3sCompanion({
    this.id = const Value.absent(),
    this.serieEcf = const Value.absent(),
    this.mfAdicional = const Value.absent(),
    this.tipoEcf = const Value.absent(),
    this.marcaEcf = const Value.absent(),
    this.modeloEcf = const Value.absent(),
    this.dataEstoque = const Value.absent(),
    this.horaEstoque = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  EcfE3sCompanion.insert({
    this.id = const Value.absent(),
    this.serieEcf = const Value.absent(),
    this.mfAdicional = const Value.absent(),
    this.tipoEcf = const Value.absent(),
    this.marcaEcf = const Value.absent(),
    this.modeloEcf = const Value.absent(),
    this.dataEstoque = const Value.absent(),
    this.horaEstoque = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  static Insertable<EcfE3> custom({
    Expression<int>? id,
    Expression<String>? serieEcf,
    Expression<String>? mfAdicional,
    Expression<String>? tipoEcf,
    Expression<String>? marcaEcf,
    Expression<String>? modeloEcf,
    Expression<DateTime>? dataEstoque,
    Expression<String>? horaEstoque,
    Expression<String>? hashRegistro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (serieEcf != null) 'SERIE_ECF': serieEcf,
      if (mfAdicional != null) 'MF_ADICIONAL': mfAdicional,
      if (tipoEcf != null) 'TIPO_ECF': tipoEcf,
      if (marcaEcf != null) 'MARCA_ECF': marcaEcf,
      if (modeloEcf != null) 'MODELO_ECF': modeloEcf,
      if (dataEstoque != null) 'DATA_ESTOQUE': dataEstoque,
      if (horaEstoque != null) 'HORA_ESTOQUE': horaEstoque,
      if (hashRegistro != null) 'HASH_REGISTRO': hashRegistro,
    });
  }

  EcfE3sCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? serieEcf,
      Value<String>? mfAdicional,
      Value<String>? tipoEcf,
      Value<String>? marcaEcf,
      Value<String>? modeloEcf,
      Value<DateTime>? dataEstoque,
      Value<String>? horaEstoque,
      Value<String>? hashRegistro,
	  }) {
    return EcfE3sCompanion(
      id: id ?? this.id,
      serieEcf: serieEcf ?? this.serieEcf,
      mfAdicional: mfAdicional ?? this.mfAdicional,
      tipoEcf: tipoEcf ?? this.tipoEcf,
      marcaEcf: marcaEcf ?? this.marcaEcf,
      modeloEcf: modeloEcf ?? this.modeloEcf,
      dataEstoque: dataEstoque ?? this.dataEstoque,
      horaEstoque: horaEstoque ?? this.horaEstoque,
      hashRegistro: hashRegistro ?? this.hashRegistro,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (serieEcf.present) {
      map['SERIE_ECF'] = Variable<String?>(serieEcf.value);
    }
    if (mfAdicional.present) {
      map['MF_ADICIONAL'] = Variable<String?>(mfAdicional.value);
    }
    if (tipoEcf.present) {
      map['TIPO_ECF'] = Variable<String?>(tipoEcf.value);
    }
    if (marcaEcf.present) {
      map['MARCA_ECF'] = Variable<String?>(marcaEcf.value);
    }
    if (modeloEcf.present) {
      map['MODELO_ECF'] = Variable<String?>(modeloEcf.value);
    }
    if (dataEstoque.present) {
      map['DATA_ESTOQUE'] = Variable<DateTime?>(dataEstoque.value);
    }
    if (horaEstoque.present) {
      map['HORA_ESTOQUE'] = Variable<String?>(horaEstoque.value);
    }
    if (hashRegistro.present) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcfE3sCompanion(')
          ..write('id: $id, ')
          ..write('serieEcf: $serieEcf, ')
          ..write('mfAdicional: $mfAdicional, ')
          ..write('tipoEcf: $tipoEcf, ')
          ..write('marcaEcf: $marcaEcf, ')
          ..write('modeloEcf: $modeloEcf, ')
          ..write('dataEstoque: $dataEstoque, ')
          ..write('horaEstoque: $horaEstoque, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }
}

class $EcfE3sTable extends EcfE3s
    with TableInfo<$EcfE3sTable, EcfE3> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EcfE3sTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _serieEcfMeta =
      const VerificationMeta('serieEcf');
  GeneratedColumn<String>? _serieEcf;
  @override
  GeneratedColumn<String> get serieEcf => _serieEcf ??=
      GeneratedColumn<String>('SERIE_ECF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _mfAdicionalMeta =
      const VerificationMeta('mfAdicional');
  GeneratedColumn<String>? _mfAdicional;
  @override
  GeneratedColumn<String> get mfAdicional => _mfAdicional ??=
      GeneratedColumn<String>('MF_ADICIONAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _tipoEcfMeta =
      const VerificationMeta('tipoEcf');
  GeneratedColumn<String>? _tipoEcf;
  @override
  GeneratedColumn<String> get tipoEcf => _tipoEcf ??=
      GeneratedColumn<String>('TIPO_ECF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _marcaEcfMeta =
      const VerificationMeta('marcaEcf');
  GeneratedColumn<String>? _marcaEcf;
  @override
  GeneratedColumn<String> get marcaEcf => _marcaEcf ??=
      GeneratedColumn<String>('MARCA_ECF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _modeloEcfMeta =
      const VerificationMeta('modeloEcf');
  GeneratedColumn<String>? _modeloEcf;
  @override
  GeneratedColumn<String> get modeloEcf => _modeloEcf ??=
      GeneratedColumn<String>('MODELO_ECF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dataEstoqueMeta =
      const VerificationMeta('dataEstoque');
  GeneratedColumn<DateTime>? _dataEstoque;
  @override
  GeneratedColumn<DateTime> get dataEstoque => _dataEstoque ??=
      GeneratedColumn<DateTime>('DATA_ESTOQUE', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaEstoqueMeta =
      const VerificationMeta('horaEstoque');
  GeneratedColumn<String>? _horaEstoque;
  @override
  GeneratedColumn<String> get horaEstoque => _horaEstoque ??=
      GeneratedColumn<String>('HORA_ESTOQUE', aliasedName, true,
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
        serieEcf,
        mfAdicional,
        tipoEcf,
        marcaEcf,
        modeloEcf,
        dataEstoque,
        horaEstoque,
        hashRegistro,
      ];

  @override
  String get aliasedName => _alias ?? 'ECF_E3';
  
  @override
  String get actualTableName => 'ECF_E3';
  
  @override
  VerificationContext validateIntegrity(Insertable<EcfE3> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('SERIE_ECF')) {
        context.handle(_serieEcfMeta,
            serieEcf.isAcceptableOrUnknown(data['SERIE_ECF']!, _serieEcfMeta));
    }
    if (data.containsKey('MF_ADICIONAL')) {
        context.handle(_mfAdicionalMeta,
            mfAdicional.isAcceptableOrUnknown(data['MF_ADICIONAL']!, _mfAdicionalMeta));
    }
    if (data.containsKey('TIPO_ECF')) {
        context.handle(_tipoEcfMeta,
            tipoEcf.isAcceptableOrUnknown(data['TIPO_ECF']!, _tipoEcfMeta));
    }
    if (data.containsKey('MARCA_ECF')) {
        context.handle(_marcaEcfMeta,
            marcaEcf.isAcceptableOrUnknown(data['MARCA_ECF']!, _marcaEcfMeta));
    }
    if (data.containsKey('MODELO_ECF')) {
        context.handle(_modeloEcfMeta,
            modeloEcf.isAcceptableOrUnknown(data['MODELO_ECF']!, _modeloEcfMeta));
    }
    if (data.containsKey('DATA_ESTOQUE')) {
        context.handle(_dataEstoqueMeta,
            dataEstoque.isAcceptableOrUnknown(data['DATA_ESTOQUE']!, _dataEstoqueMeta));
    }
    if (data.containsKey('HORA_ESTOQUE')) {
        context.handle(_horaEstoqueMeta,
            horaEstoque.isAcceptableOrUnknown(data['HORA_ESTOQUE']!, _horaEstoqueMeta));
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
  EcfE3 map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EcfE3.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EcfE3sTable createAlias(String alias) {
    return $EcfE3sTable(_db, alias);
  }
}