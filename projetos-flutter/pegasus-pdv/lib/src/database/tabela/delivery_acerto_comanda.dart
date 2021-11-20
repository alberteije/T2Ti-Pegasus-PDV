/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [DELIVERY_ACERTO_COMANDA] 
                                                                                
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

@DataClassName("DeliveryAcertoComanda")
@UseRowClass(DeliveryAcertoComanda)
class DeliveryAcertoComandas extends Table {
  @override
  String get tableName => 'DELIVERY_ACERTO_COMANDA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idDeliveryAcerto => integer().named('ID_DELIVERY_ACERTO').nullable().customConstraint('NULLABLE REFERENCES DELIVERY_ACERTO(ID)')();
  IntColumn get idDelivery => integer().named('ID_DELIVERY').nullable().customConstraint('NULLABLE REFERENCES DELIVERY(ID)')();
}

class DeliveryAcertoComanda extends DataClass implements Insertable<DeliveryAcertoComanda> {
  final int? id;
  final int? idDeliveryAcerto;
  final int? idDelivery;

  DeliveryAcertoComanda(
    {
      required this.id,
      this.idDeliveryAcerto,
      this.idDelivery,
    }
  );

  factory DeliveryAcertoComanda.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DeliveryAcertoComanda(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idDeliveryAcerto: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_DELIVERY_ACERTO']),
      idDelivery: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_DELIVERY']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idDeliveryAcerto != null) {
      map['ID_DELIVERY_ACERTO'] = Variable<int?>(idDeliveryAcerto);
    }
    if (!nullToAbsent || idDelivery != null) {
      map['ID_DELIVERY'] = Variable<int?>(idDelivery);
    }
    return map;
  }

  DeliveryAcertoComandasCompanion toCompanion(bool nullToAbsent) {
    return DeliveryAcertoComandasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idDeliveryAcerto: idDeliveryAcerto == null && nullToAbsent
        ? const Value.absent()
        : Value(idDeliveryAcerto),
      idDelivery: idDelivery == null && nullToAbsent
        ? const Value.absent()
        : Value(idDelivery),
    );
  }

  factory DeliveryAcertoComanda.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DeliveryAcertoComanda(
      id: serializer.fromJson<int>(json['id']),
      idDeliveryAcerto: serializer.fromJson<int>(json['idDeliveryAcerto']),
      idDelivery: serializer.fromJson<int>(json['idDelivery']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idDeliveryAcerto': serializer.toJson<int?>(idDeliveryAcerto),
      'idDelivery': serializer.toJson<int?>(idDelivery),
    };
  }

  DeliveryAcertoComanda copyWith(
        {
		  int? id,
          int? idDeliveryAcerto,
          int? idDelivery,
		}) =>
      DeliveryAcertoComanda(
        id: id ?? this.id,
        idDeliveryAcerto: idDeliveryAcerto ?? this.idDeliveryAcerto,
        idDelivery: idDelivery ?? this.idDelivery,
      );
  
  @override
  String toString() {
    return (StringBuffer('DeliveryAcertoComanda(')
          ..write('id: $id, ')
          ..write('idDeliveryAcerto: $idDeliveryAcerto, ')
          ..write('idDelivery: $idDelivery, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idDeliveryAcerto,
      idDelivery,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryAcertoComanda &&
          other.id == id &&
          other.idDeliveryAcerto == idDeliveryAcerto &&
          other.idDelivery == idDelivery 
	   );
}

class DeliveryAcertoComandasCompanion extends UpdateCompanion<DeliveryAcertoComanda> {

  final Value<int?> id;
  final Value<int?> idDeliveryAcerto;
  final Value<int?> idDelivery;

  const DeliveryAcertoComandasCompanion({
    this.id = const Value.absent(),
    this.idDeliveryAcerto = const Value.absent(),
    this.idDelivery = const Value.absent(),
  });

  DeliveryAcertoComandasCompanion.insert({
    this.id = const Value.absent(),
    this.idDeliveryAcerto = const Value.absent(),
    this.idDelivery = const Value.absent(),
  });

  static Insertable<DeliveryAcertoComanda> custom({
    Expression<int>? id,
    Expression<int>? idDeliveryAcerto,
    Expression<int>? idDelivery,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idDeliveryAcerto != null) 'ID_DELIVERY_ACERTO': idDeliveryAcerto,
      if (idDelivery != null) 'ID_DELIVERY': idDelivery,
    });
  }

  DeliveryAcertoComandasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idDeliveryAcerto,
      Value<int>? idDelivery,
	  }) {
    return DeliveryAcertoComandasCompanion(
      id: id ?? this.id,
      idDeliveryAcerto: idDeliveryAcerto ?? this.idDeliveryAcerto,
      idDelivery: idDelivery ?? this.idDelivery,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idDeliveryAcerto.present) {
      map['ID_DELIVERY_ACERTO'] = Variable<int?>(idDeliveryAcerto.value);
    }
    if (idDelivery.present) {
      map['ID_DELIVERY'] = Variable<int?>(idDelivery.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryAcertoComandasCompanion(')
          ..write('id: $id, ')
          ..write('idDeliveryAcerto: $idDeliveryAcerto, ')
          ..write('idDelivery: $idDelivery, ')
          ..write(')'))
        .toString();
  }
}

class $DeliveryAcertoComandasTable extends DeliveryAcertoComandas
    with TableInfo<$DeliveryAcertoComandasTable, DeliveryAcertoComanda> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DeliveryAcertoComandasTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idDeliveryAcertoMeta =
      const VerificationMeta('idDeliveryAcerto');
  GeneratedColumn<int>? _idDeliveryAcerto;
  @override
  GeneratedColumn<int> get idDeliveryAcerto =>
      _idDeliveryAcerto ??= GeneratedColumn<int>('ID_DELIVERY_ACERTO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES DELIVERY_ACERTO(ID)');
  final VerificationMeta _idDeliveryMeta =
      const VerificationMeta('idDelivery');
  GeneratedColumn<int>? _idDelivery;
  @override
  GeneratedColumn<int> get idDelivery =>
      _idDelivery ??= GeneratedColumn<int>('ID_DELIVERY', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES DELIVERY(ID)');
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idDeliveryAcerto,
        idDelivery,
      ];

  @override
  String get aliasedName => _alias ?? 'DELIVERY_ACERTO_COMANDA';
  
  @override
  String get actualTableName => 'DELIVERY_ACERTO_COMANDA';
  
  @override
  VerificationContext validateIntegrity(Insertable<DeliveryAcertoComanda> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_DELIVERY_ACERTO')) {
        context.handle(_idDeliveryAcertoMeta,
            idDeliveryAcerto.isAcceptableOrUnknown(data['ID_DELIVERY_ACERTO']!, _idDeliveryAcertoMeta));
    }
    if (data.containsKey('ID_DELIVERY')) {
        context.handle(_idDeliveryMeta,
            idDelivery.isAcceptableOrUnknown(data['ID_DELIVERY']!, _idDeliveryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeliveryAcertoComanda map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DeliveryAcertoComanda.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DeliveryAcertoComandasTable createAlias(String alias) {
    return $DeliveryAcertoComandasTable(_db, alias);
  }
}