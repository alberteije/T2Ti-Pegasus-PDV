/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ENTREGADOR_ROTA_DETALHE] 
                                                                                
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

@DataClassName("EntregadorRotaDetalhe")
@UseRowClass(EntregadorRotaDetalhe)
class EntregadorRotaDetalhes extends Table {
  @override
  String get tableName => 'ENTREGADOR_ROTA_DETALHE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idEntregadorRota => integer().named('ID_ENTREGADOR_ROTA').nullable().customConstraint('NULLABLE REFERENCES ENTREGADOR_ROTA(ID)')();
  IntColumn get idDelivery => integer().named('ID_DELIVERY').nullable().customConstraint('NULLABLE REFERENCES DELIVERY(ID)')();
  IntColumn get posicaoNaFila => integer().named('POSICAO_NA_FILA').nullable()();
  IntColumn get latitude => integer().named('LATITUDE').nullable()();
  IntColumn get longitude => integer().named('LONGITUDE').nullable()();
}

class EntregadorRotaDetalhe extends DataClass implements Insertable<EntregadorRotaDetalhe> {
  final int? id;
  final int? idEntregadorRota;
  final int? idDelivery;
  final int? posicaoNaFila;
  final int? latitude;
  final int? longitude;

  EntregadorRotaDetalhe(
    {
      required this.id,
      this.idEntregadorRota,
      this.idDelivery,
      this.posicaoNaFila,
      this.latitude,
      this.longitude,
    }
  );

  factory EntregadorRotaDetalhe.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EntregadorRotaDetalhe(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idEntregadorRota: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_ENTREGADOR_ROTA']),
      idDelivery: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_DELIVERY']),
      posicaoNaFila: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}POSICAO_NA_FILA']),
      latitude: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}LATITUDE']),
      longitude: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}LONGITUDE']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idEntregadorRota != null) {
      map['ID_ENTREGADOR_ROTA'] = Variable<int?>(idEntregadorRota);
    }
    if (!nullToAbsent || idDelivery != null) {
      map['ID_DELIVERY'] = Variable<int?>(idDelivery);
    }
    if (!nullToAbsent || posicaoNaFila != null) {
      map['POSICAO_NA_FILA'] = Variable<int?>(posicaoNaFila);
    }
    if (!nullToAbsent || latitude != null) {
      map['LATITUDE'] = Variable<int?>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['LONGITUDE'] = Variable<int?>(longitude);
    }
    return map;
  }

  EntregadorRotaDetalhesCompanion toCompanion(bool nullToAbsent) {
    return EntregadorRotaDetalhesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idEntregadorRota: idEntregadorRota == null && nullToAbsent
        ? const Value.absent()
        : Value(idEntregadorRota),
      idDelivery: idDelivery == null && nullToAbsent
        ? const Value.absent()
        : Value(idDelivery),
      posicaoNaFila: posicaoNaFila == null && nullToAbsent
        ? const Value.absent()
        : Value(posicaoNaFila),
      latitude: latitude == null && nullToAbsent
        ? const Value.absent()
        : Value(latitude),
      longitude: longitude == null && nullToAbsent
        ? const Value.absent()
        : Value(longitude),
    );
  }

  factory EntregadorRotaDetalhe.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EntregadorRotaDetalhe(
      id: serializer.fromJson<int>(json['id']),
      idEntregadorRota: serializer.fromJson<int>(json['idEntregadorRota']),
      idDelivery: serializer.fromJson<int>(json['idDelivery']),
      posicaoNaFila: serializer.fromJson<int>(json['posicaoNaFila']),
      latitude: serializer.fromJson<int>(json['latitude']),
      longitude: serializer.fromJson<int>(json['longitude']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idEntregadorRota': serializer.toJson<int?>(idEntregadorRota),
      'idDelivery': serializer.toJson<int?>(idDelivery),
      'posicaoNaFila': serializer.toJson<int?>(posicaoNaFila),
      'latitude': serializer.toJson<int?>(latitude),
      'longitude': serializer.toJson<int?>(longitude),
    };
  }

  EntregadorRotaDetalhe copyWith(
        {
		  int? id,
          int? idEntregadorRota,
          int? idDelivery,
          int? posicaoNaFila,
          int? latitude,
          int? longitude,
		}) =>
      EntregadorRotaDetalhe(
        id: id ?? this.id,
        idEntregadorRota: idEntregadorRota ?? this.idEntregadorRota,
        idDelivery: idDelivery ?? this.idDelivery,
        posicaoNaFila: posicaoNaFila ?? this.posicaoNaFila,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
  
  @override
  String toString() {
    return (StringBuffer('EntregadorRotaDetalhe(')
          ..write('id: $id, ')
          ..write('idEntregadorRota: $idEntregadorRota, ')
          ..write('idDelivery: $idDelivery, ')
          ..write('posicaoNaFila: $posicaoNaFila, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idEntregadorRota,
      idDelivery,
      posicaoNaFila,
      latitude,
      longitude,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntregadorRotaDetalhe &&
          other.id == id &&
          other.idEntregadorRota == idEntregadorRota &&
          other.idDelivery == idDelivery &&
          other.posicaoNaFila == posicaoNaFila &&
          other.latitude == latitude &&
          other.longitude == longitude 
	   );
}

class EntregadorRotaDetalhesCompanion extends UpdateCompanion<EntregadorRotaDetalhe> {

  final Value<int?> id;
  final Value<int?> idEntregadorRota;
  final Value<int?> idDelivery;
  final Value<int?> posicaoNaFila;
  final Value<int?> latitude;
  final Value<int?> longitude;

  const EntregadorRotaDetalhesCompanion({
    this.id = const Value.absent(),
    this.idEntregadorRota = const Value.absent(),
    this.idDelivery = const Value.absent(),
    this.posicaoNaFila = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });

  EntregadorRotaDetalhesCompanion.insert({
    this.id = const Value.absent(),
    this.idEntregadorRota = const Value.absent(),
    this.idDelivery = const Value.absent(),
    this.posicaoNaFila = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });

  static Insertable<EntregadorRotaDetalhe> custom({
    Expression<int>? id,
    Expression<int>? idEntregadorRota,
    Expression<int>? idDelivery,
    Expression<int>? posicaoNaFila,
    Expression<int>? latitude,
    Expression<int>? longitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idEntregadorRota != null) 'ID_ENTREGADOR_ROTA': idEntregadorRota,
      if (idDelivery != null) 'ID_DELIVERY': idDelivery,
      if (posicaoNaFila != null) 'POSICAO_NA_FILA': posicaoNaFila,
      if (latitude != null) 'LATITUDE': latitude,
      if (longitude != null) 'LONGITUDE': longitude,
    });
  }

  EntregadorRotaDetalhesCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idEntregadorRota,
      Value<int>? idDelivery,
      Value<int>? posicaoNaFila,
      Value<int>? latitude,
      Value<int>? longitude,
	  }) {
    return EntregadorRotaDetalhesCompanion(
      id: id ?? this.id,
      idEntregadorRota: idEntregadorRota ?? this.idEntregadorRota,
      idDelivery: idDelivery ?? this.idDelivery,
      posicaoNaFila: posicaoNaFila ?? this.posicaoNaFila,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idEntregadorRota.present) {
      map['ID_ENTREGADOR_ROTA'] = Variable<int?>(idEntregadorRota.value);
    }
    if (idDelivery.present) {
      map['ID_DELIVERY'] = Variable<int?>(idDelivery.value);
    }
    if (posicaoNaFila.present) {
      map['POSICAO_NA_FILA'] = Variable<int?>(posicaoNaFila.value);
    }
    if (latitude.present) {
      map['LATITUDE'] = Variable<int?>(latitude.value);
    }
    if (longitude.present) {
      map['LONGITUDE'] = Variable<int?>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntregadorRotaDetalhesCompanion(')
          ..write('id: $id, ')
          ..write('idEntregadorRota: $idEntregadorRota, ')
          ..write('idDelivery: $idDelivery, ')
          ..write('posicaoNaFila: $posicaoNaFila, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write(')'))
        .toString();
  }
}

class $EntregadorRotaDetalhesTable extends EntregadorRotaDetalhes
    with TableInfo<$EntregadorRotaDetalhesTable, EntregadorRotaDetalhe> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EntregadorRotaDetalhesTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idEntregadorRotaMeta =
      const VerificationMeta('idEntregadorRota');
  GeneratedColumn<int>? _idEntregadorRota;
  @override
  GeneratedColumn<int> get idEntregadorRota =>
      _idEntregadorRota ??= GeneratedColumn<int>('ID_ENTREGADOR_ROTA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES ENTREGADOR_ROTA(ID)');
  final VerificationMeta _idDeliveryMeta =
      const VerificationMeta('idDelivery');
  GeneratedColumn<int>? _idDelivery;
  @override
  GeneratedColumn<int> get idDelivery =>
      _idDelivery ??= GeneratedColumn<int>('ID_DELIVERY', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES DELIVERY(ID)');
  final VerificationMeta _posicaoNaFilaMeta =
      const VerificationMeta('posicaoNaFila');
  GeneratedColumn<int>? _posicaoNaFila;
  @override
  GeneratedColumn<int> get posicaoNaFila => _posicaoNaFila ??=
      GeneratedColumn<int>('POSICAO_NA_FILA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  GeneratedColumn<int>? _latitude;
  @override
  GeneratedColumn<int> get latitude => _latitude ??=
      GeneratedColumn<int>('LATITUDE', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  GeneratedColumn<int>? _longitude;
  @override
  GeneratedColumn<int> get longitude => _longitude ??=
      GeneratedColumn<int>('LONGITUDE', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idEntregadorRota,
        idDelivery,
        posicaoNaFila,
        latitude,
        longitude,
      ];

  @override
  String get aliasedName => _alias ?? 'ENTREGADOR_ROTA_DETALHE';
  
  @override
  String get actualTableName => 'ENTREGADOR_ROTA_DETALHE';
  
  @override
  VerificationContext validateIntegrity(Insertable<EntregadorRotaDetalhe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_ENTREGADOR_ROTA')) {
        context.handle(_idEntregadorRotaMeta,
            idEntregadorRota.isAcceptableOrUnknown(data['ID_ENTREGADOR_ROTA']!, _idEntregadorRotaMeta));
    }
    if (data.containsKey('ID_DELIVERY')) {
        context.handle(_idDeliveryMeta,
            idDelivery.isAcceptableOrUnknown(data['ID_DELIVERY']!, _idDeliveryMeta));
    }
    if (data.containsKey('POSICAO_NA_FILA')) {
        context.handle(_posicaoNaFilaMeta,
            posicaoNaFila.isAcceptableOrUnknown(data['POSICAO_NA_FILA']!, _posicaoNaFilaMeta));
    }
    if (data.containsKey('LATITUDE')) {
        context.handle(_latitudeMeta,
            latitude.isAcceptableOrUnknown(data['LATITUDE']!, _latitudeMeta));
    }
    if (data.containsKey('LONGITUDE')) {
        context.handle(_longitudeMeta,
            longitude.isAcceptableOrUnknown(data['LONGITUDE']!, _longitudeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntregadorRotaDetalhe map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EntregadorRotaDetalhe.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EntregadorRotaDetalhesTable createAlias(String alias) {
    return $EntregadorRotaDetalhesTable(_db, alias);
  }
}