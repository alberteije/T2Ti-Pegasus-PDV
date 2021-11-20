/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [RESERVA_MESA] 
                                                                                
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

@DataClassName("ReservaMesa")
@UseRowClass(ReservaMesa)
class ReservaMesas extends Table {
  @override
  String get tableName => 'RESERVA_MESA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idReserva => integer().named('ID_RESERVA').nullable().customConstraint('NULLABLE REFERENCES RESERVA(ID)')();
  IntColumn get idMesa => integer().named('ID_MESA').nullable().customConstraint('NULLABLE REFERENCES MESA(ID)')();
}

class ReservaMesa extends DataClass implements Insertable<ReservaMesa> {
  final int? id;
  final int? idReserva;
  final int? idMesa;

  ReservaMesa(
    {
      required this.id,
      this.idReserva,
      this.idMesa,
    }
  );

  factory ReservaMesa.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ReservaMesa(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idReserva: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_RESERVA']),
      idMesa: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_MESA']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idReserva != null) {
      map['ID_RESERVA'] = Variable<int?>(idReserva);
    }
    if (!nullToAbsent || idMesa != null) {
      map['ID_MESA'] = Variable<int?>(idMesa);
    }
    return map;
  }

  ReservaMesasCompanion toCompanion(bool nullToAbsent) {
    return ReservaMesasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idReserva: idReserva == null && nullToAbsent
        ? const Value.absent()
        : Value(idReserva),
      idMesa: idMesa == null && nullToAbsent
        ? const Value.absent()
        : Value(idMesa),
    );
  }

  factory ReservaMesa.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ReservaMesa(
      id: serializer.fromJson<int>(json['id']),
      idReserva: serializer.fromJson<int>(json['idReserva']),
      idMesa: serializer.fromJson<int>(json['idMesa']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idReserva': serializer.toJson<int?>(idReserva),
      'idMesa': serializer.toJson<int?>(idMesa),
    };
  }

  ReservaMesa copyWith(
        {
		  int? id,
          int? idReserva,
          int? idMesa,
		}) =>
      ReservaMesa(
        id: id ?? this.id,
        idReserva: idReserva ?? this.idReserva,
        idMesa: idMesa ?? this.idMesa,
      );
  
  @override
  String toString() {
    return (StringBuffer('ReservaMesa(')
          ..write('id: $id, ')
          ..write('idReserva: $idReserva, ')
          ..write('idMesa: $idMesa, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idReserva,
      idMesa,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReservaMesa &&
          other.id == id &&
          other.idReserva == idReserva &&
          other.idMesa == idMesa 
	   );
}

class ReservaMesasCompanion extends UpdateCompanion<ReservaMesa> {

  final Value<int?> id;
  final Value<int?> idReserva;
  final Value<int?> idMesa;

  const ReservaMesasCompanion({
    this.id = const Value.absent(),
    this.idReserva = const Value.absent(),
    this.idMesa = const Value.absent(),
  });

  ReservaMesasCompanion.insert({
    this.id = const Value.absent(),
    this.idReserva = const Value.absent(),
    this.idMesa = const Value.absent(),
  });

  static Insertable<ReservaMesa> custom({
    Expression<int>? id,
    Expression<int>? idReserva,
    Expression<int>? idMesa,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idReserva != null) 'ID_RESERVA': idReserva,
      if (idMesa != null) 'ID_MESA': idMesa,
    });
  }

  ReservaMesasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idReserva,
      Value<int>? idMesa,
	  }) {
    return ReservaMesasCompanion(
      id: id ?? this.id,
      idReserva: idReserva ?? this.idReserva,
      idMesa: idMesa ?? this.idMesa,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idReserva.present) {
      map['ID_RESERVA'] = Variable<int?>(idReserva.value);
    }
    if (idMesa.present) {
      map['ID_MESA'] = Variable<int?>(idMesa.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReservaMesasCompanion(')
          ..write('id: $id, ')
          ..write('idReserva: $idReserva, ')
          ..write('idMesa: $idMesa, ')
          ..write(')'))
        .toString();
  }
}

class $ReservaMesasTable extends ReservaMesas
    with TableInfo<$ReservaMesasTable, ReservaMesa> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ReservaMesasTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idReservaMeta =
      const VerificationMeta('idReserva');
  GeneratedColumn<int>? _idReserva;
  @override
  GeneratedColumn<int> get idReserva =>
      _idReserva ??= GeneratedColumn<int>('ID_RESERVA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES RESERVA(ID)');
  final VerificationMeta _idMesaMeta =
      const VerificationMeta('idMesa');
  GeneratedColumn<int>? _idMesa;
  @override
  GeneratedColumn<int> get idMesa =>
      _idMesa ??= GeneratedColumn<int>('ID_MESA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES MESA(ID)');
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idReserva,
        idMesa,
      ];

  @override
  String get aliasedName => _alias ?? 'RESERVA_MESA';
  
  @override
  String get actualTableName => 'RESERVA_MESA';
  
  @override
  VerificationContext validateIntegrity(Insertable<ReservaMesa> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_RESERVA')) {
        context.handle(_idReservaMeta,
            idReserva.isAcceptableOrUnknown(data['ID_RESERVA']!, _idReservaMeta));
    }
    if (data.containsKey('ID_MESA')) {
        context.handle(_idMesaMeta,
            idMesa.isAcceptableOrUnknown(data['ID_MESA']!, _idMesaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReservaMesa map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ReservaMesa.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ReservaMesasTable createAlias(String alias) {
    return $ReservaMesasTable(_db, alias);
  }
}