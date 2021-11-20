/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_TRANSPORTE_VOLUME_LACRE] 
                                                                                
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

@DataClassName("NfeTransporteVolumeLacre")
@UseRowClass(NfeTransporteVolumeLacre)
class NfeTransporteVolumeLacres extends Table {
  @override
  String get tableName => 'NFE_TRANSPORTE_VOLUME_LACRE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeTransporteVolume => integer().named('ID_NFE_TRANSPORTE_VOLUME').nullable().customConstraint('NULLABLE REFERENCES NFE_TRANSPORTE_VOLUME(ID)')();
  TextColumn get numero => text().named('NUMERO').withLength(min: 0, max: 60).nullable()();
}

class NfeTransporteVolumeLacre extends DataClass implements Insertable<NfeTransporteVolumeLacre> {
  final int? id;
  final int? idNfeTransporteVolume;
  final String? numero;

  NfeTransporteVolumeLacre(
    {
      required this.id,
      this.idNfeTransporteVolume,
      this.numero,
    }
  );

  factory NfeTransporteVolumeLacre.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeTransporteVolumeLacre(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeTransporteVolume: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_TRANSPORTE_VOLUME']),
      numero: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeTransporteVolume != null) {
      map['ID_NFE_TRANSPORTE_VOLUME'] = Variable<int?>(idNfeTransporteVolume);
    }
    if (!nullToAbsent || numero != null) {
      map['NUMERO'] = Variable<String?>(numero);
    }
    return map;
  }

  NfeTransporteVolumeLacresCompanion toCompanion(bool nullToAbsent) {
    return NfeTransporteVolumeLacresCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeTransporteVolume: idNfeTransporteVolume == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeTransporteVolume),
      numero: numero == null && nullToAbsent
        ? const Value.absent()
        : Value(numero),
    );
  }

  factory NfeTransporteVolumeLacre.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeTransporteVolumeLacre(
      id: serializer.fromJson<int>(json['id']),
      idNfeTransporteVolume: serializer.fromJson<int>(json['idNfeTransporteVolume']),
      numero: serializer.fromJson<String>(json['numero']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeTransporteVolume': serializer.toJson<int?>(idNfeTransporteVolume),
      'numero': serializer.toJson<String?>(numero),
    };
  }

  NfeTransporteVolumeLacre copyWith(
        {
		  int? id,
          int? idNfeTransporteVolume,
          String? numero,
		}) =>
      NfeTransporteVolumeLacre(
        id: id ?? this.id,
        idNfeTransporteVolume: idNfeTransporteVolume ?? this.idNfeTransporteVolume,
        numero: numero ?? this.numero,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeTransporteVolumeLacre(')
          ..write('id: $id, ')
          ..write('idNfeTransporteVolume: $idNfeTransporteVolume, ')
          ..write('numero: $numero, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeTransporteVolume,
      numero,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeTransporteVolumeLacre &&
          other.id == id &&
          other.idNfeTransporteVolume == idNfeTransporteVolume &&
          other.numero == numero 
	   );
}

class NfeTransporteVolumeLacresCompanion extends UpdateCompanion<NfeTransporteVolumeLacre> {

  final Value<int?> id;
  final Value<int?> idNfeTransporteVolume;
  final Value<String?> numero;

  const NfeTransporteVolumeLacresCompanion({
    this.id = const Value.absent(),
    this.idNfeTransporteVolume = const Value.absent(),
    this.numero = const Value.absent(),
  });

  NfeTransporteVolumeLacresCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeTransporteVolume = const Value.absent(),
    this.numero = const Value.absent(),
  });

  static Insertable<NfeTransporteVolumeLacre> custom({
    Expression<int>? id,
    Expression<int>? idNfeTransporteVolume,
    Expression<String>? numero,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeTransporteVolume != null) 'ID_NFE_TRANSPORTE_VOLUME': idNfeTransporteVolume,
      if (numero != null) 'NUMERO': numero,
    });
  }

  NfeTransporteVolumeLacresCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeTransporteVolume,
      Value<String>? numero,
	  }) {
    return NfeTransporteVolumeLacresCompanion(
      id: id ?? this.id,
      idNfeTransporteVolume: idNfeTransporteVolume ?? this.idNfeTransporteVolume,
      numero: numero ?? this.numero,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeTransporteVolume.present) {
      map['ID_NFE_TRANSPORTE_VOLUME'] = Variable<int?>(idNfeTransporteVolume.value);
    }
    if (numero.present) {
      map['NUMERO'] = Variable<String?>(numero.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeTransporteVolumeLacresCompanion(')
          ..write('id: $id, ')
          ..write('idNfeTransporteVolume: $idNfeTransporteVolume, ')
          ..write('numero: $numero, ')
          ..write(')'))
        .toString();
  }
}

class $NfeTransporteVolumeLacresTable extends NfeTransporteVolumeLacres
    with TableInfo<$NfeTransporteVolumeLacresTable, NfeTransporteVolumeLacre> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeTransporteVolumeLacresTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeTransporteVolumeMeta =
      const VerificationMeta('idNfeTransporteVolume');
  GeneratedColumn<int>? _idNfeTransporteVolume;
  @override
  GeneratedColumn<int> get idNfeTransporteVolume =>
      _idNfeTransporteVolume ??= GeneratedColumn<int>('ID_NFE_TRANSPORTE_VOLUME', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_TRANSPORTE_VOLUME(ID)');
  final VerificationMeta _numeroMeta =
      const VerificationMeta('numero');
  GeneratedColumn<String>? _numero;
  @override
  GeneratedColumn<String> get numero => _numero ??=
      GeneratedColumn<String>('NUMERO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeTransporteVolume,
        numero,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_TRANSPORTE_VOLUME_LACRE';
  
  @override
  String get actualTableName => 'NFE_TRANSPORTE_VOLUME_LACRE';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeTransporteVolumeLacre> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_TRANSPORTE_VOLUME')) {
        context.handle(_idNfeTransporteVolumeMeta,
            idNfeTransporteVolume.isAcceptableOrUnknown(data['ID_NFE_TRANSPORTE_VOLUME']!, _idNfeTransporteVolumeMeta));
    }
    if (data.containsKey('NUMERO')) {
        context.handle(_numeroMeta,
            numero.isAcceptableOrUnknown(data['NUMERO']!, _numeroMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeTransporteVolumeLacre map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeTransporteVolumeLacre.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeTransporteVolumeLacresTable createAlias(String alias) {
    return $NfeTransporteVolumeLacresTable(_db, alias);
  }
}