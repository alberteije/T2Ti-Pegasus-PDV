/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_TRANSPORTE_REBOQUE] 
                                                                                
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

@DataClassName("NfeTransporteReboque")
@UseRowClass(NfeTransporteReboque)
class NfeTransporteReboques extends Table {
  @override
  String get tableName => 'NFE_TRANSPORTE_REBOQUE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeTransporte => integer().named('ID_NFE_TRANSPORTE').nullable().customConstraint('NULLABLE REFERENCES NFE_TRANSPORTE(ID)')();
  TextColumn get placa => text().named('PLACA').withLength(min: 0, max: 8).nullable()();
  TextColumn get uf => text().named('UF').withLength(min: 0, max: 2).nullable()();
  TextColumn get rntc => text().named('RNTC').withLength(min: 0, max: 20).nullable()();
  TextColumn get vagao => text().named('VAGAO').withLength(min: 0, max: 20).nullable()();
  TextColumn get balsa => text().named('BALSA').withLength(min: 0, max: 20).nullable()();
}

class NfeTransporteReboque extends DataClass implements Insertable<NfeTransporteReboque> {
  final int? id;
  final int? idNfeTransporte;
  final String? placa;
  final String? uf;
  final String? rntc;
  final String? vagao;
  final String? balsa;

  NfeTransporteReboque(
    {
      required this.id,
      this.idNfeTransporte,
      this.placa,
      this.uf,
      this.rntc,
      this.vagao,
      this.balsa,
    }
  );

  factory NfeTransporteReboque.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeTransporteReboque(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeTransporte: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_TRANSPORTE']),
      placa: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PLACA']),
      uf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}UF']),
      rntc: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RNTC']),
      vagao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}VAGAO']),
      balsa: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}BALSA']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeTransporte != null) {
      map['ID_NFE_TRANSPORTE'] = Variable<int?>(idNfeTransporte);
    }
    if (!nullToAbsent || placa != null) {
      map['PLACA'] = Variable<String?>(placa);
    }
    if (!nullToAbsent || uf != null) {
      map['UF'] = Variable<String?>(uf);
    }
    if (!nullToAbsent || rntc != null) {
      map['RNTC'] = Variable<String?>(rntc);
    }
    if (!nullToAbsent || vagao != null) {
      map['VAGAO'] = Variable<String?>(vagao);
    }
    if (!nullToAbsent || balsa != null) {
      map['BALSA'] = Variable<String?>(balsa);
    }
    return map;
  }

  NfeTransporteReboquesCompanion toCompanion(bool nullToAbsent) {
    return NfeTransporteReboquesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeTransporte: idNfeTransporte == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeTransporte),
      placa: placa == null && nullToAbsent
        ? const Value.absent()
        : Value(placa),
      uf: uf == null && nullToAbsent
        ? const Value.absent()
        : Value(uf),
      rntc: rntc == null && nullToAbsent
        ? const Value.absent()
        : Value(rntc),
      vagao: vagao == null && nullToAbsent
        ? const Value.absent()
        : Value(vagao),
      balsa: balsa == null && nullToAbsent
        ? const Value.absent()
        : Value(balsa),
    );
  }

  factory NfeTransporteReboque.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeTransporteReboque(
      id: serializer.fromJson<int>(json['id']),
      idNfeTransporte: serializer.fromJson<int>(json['idNfeTransporte']),
      placa: serializer.fromJson<String>(json['placa']),
      uf: serializer.fromJson<String>(json['uf']),
      rntc: serializer.fromJson<String>(json['rntc']),
      vagao: serializer.fromJson<String>(json['vagao']),
      balsa: serializer.fromJson<String>(json['balsa']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeTransporte': serializer.toJson<int?>(idNfeTransporte),
      'placa': serializer.toJson<String?>(placa),
      'uf': serializer.toJson<String?>(uf),
      'rntc': serializer.toJson<String?>(rntc),
      'vagao': serializer.toJson<String?>(vagao),
      'balsa': serializer.toJson<String?>(balsa),
    };
  }

  NfeTransporteReboque copyWith(
        {
		  int? id,
          int? idNfeTransporte,
          String? placa,
          String? uf,
          String? rntc,
          String? vagao,
          String? balsa,
		}) =>
      NfeTransporteReboque(
        id: id ?? this.id,
        idNfeTransporte: idNfeTransporte ?? this.idNfeTransporte,
        placa: placa ?? this.placa,
        uf: uf ?? this.uf,
        rntc: rntc ?? this.rntc,
        vagao: vagao ?? this.vagao,
        balsa: balsa ?? this.balsa,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeTransporteReboque(')
          ..write('id: $id, ')
          ..write('idNfeTransporte: $idNfeTransporte, ')
          ..write('placa: $placa, ')
          ..write('uf: $uf, ')
          ..write('rntc: $rntc, ')
          ..write('vagao: $vagao, ')
          ..write('balsa: $balsa, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeTransporte,
      placa,
      uf,
      rntc,
      vagao,
      balsa,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeTransporteReboque &&
          other.id == id &&
          other.idNfeTransporte == idNfeTransporte &&
          other.placa == placa &&
          other.uf == uf &&
          other.rntc == rntc &&
          other.vagao == vagao &&
          other.balsa == balsa 
	   );
}

class NfeTransporteReboquesCompanion extends UpdateCompanion<NfeTransporteReboque> {

  final Value<int?> id;
  final Value<int?> idNfeTransporte;
  final Value<String?> placa;
  final Value<String?> uf;
  final Value<String?> rntc;
  final Value<String?> vagao;
  final Value<String?> balsa;

  const NfeTransporteReboquesCompanion({
    this.id = const Value.absent(),
    this.idNfeTransporte = const Value.absent(),
    this.placa = const Value.absent(),
    this.uf = const Value.absent(),
    this.rntc = const Value.absent(),
    this.vagao = const Value.absent(),
    this.balsa = const Value.absent(),
  });

  NfeTransporteReboquesCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeTransporte = const Value.absent(),
    this.placa = const Value.absent(),
    this.uf = const Value.absent(),
    this.rntc = const Value.absent(),
    this.vagao = const Value.absent(),
    this.balsa = const Value.absent(),
  });

  static Insertable<NfeTransporteReboque> custom({
    Expression<int>? id,
    Expression<int>? idNfeTransporte,
    Expression<String>? placa,
    Expression<String>? uf,
    Expression<String>? rntc,
    Expression<String>? vagao,
    Expression<String>? balsa,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeTransporte != null) 'ID_NFE_TRANSPORTE': idNfeTransporte,
      if (placa != null) 'PLACA': placa,
      if (uf != null) 'UF': uf,
      if (rntc != null) 'RNTC': rntc,
      if (vagao != null) 'VAGAO': vagao,
      if (balsa != null) 'BALSA': balsa,
    });
  }

  NfeTransporteReboquesCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeTransporte,
      Value<String>? placa,
      Value<String>? uf,
      Value<String>? rntc,
      Value<String>? vagao,
      Value<String>? balsa,
	  }) {
    return NfeTransporteReboquesCompanion(
      id: id ?? this.id,
      idNfeTransporte: idNfeTransporte ?? this.idNfeTransporte,
      placa: placa ?? this.placa,
      uf: uf ?? this.uf,
      rntc: rntc ?? this.rntc,
      vagao: vagao ?? this.vagao,
      balsa: balsa ?? this.balsa,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeTransporte.present) {
      map['ID_NFE_TRANSPORTE'] = Variable<int?>(idNfeTransporte.value);
    }
    if (placa.present) {
      map['PLACA'] = Variable<String?>(placa.value);
    }
    if (uf.present) {
      map['UF'] = Variable<String?>(uf.value);
    }
    if (rntc.present) {
      map['RNTC'] = Variable<String?>(rntc.value);
    }
    if (vagao.present) {
      map['VAGAO'] = Variable<String?>(vagao.value);
    }
    if (balsa.present) {
      map['BALSA'] = Variable<String?>(balsa.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeTransporteReboquesCompanion(')
          ..write('id: $id, ')
          ..write('idNfeTransporte: $idNfeTransporte, ')
          ..write('placa: $placa, ')
          ..write('uf: $uf, ')
          ..write('rntc: $rntc, ')
          ..write('vagao: $vagao, ')
          ..write('balsa: $balsa, ')
          ..write(')'))
        .toString();
  }
}

class $NfeTransporteReboquesTable extends NfeTransporteReboques
    with TableInfo<$NfeTransporteReboquesTable, NfeTransporteReboque> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeTransporteReboquesTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeTransporteMeta =
      const VerificationMeta('idNfeTransporte');
  GeneratedColumn<int>? _idNfeTransporte;
  @override
  GeneratedColumn<int> get idNfeTransporte =>
      _idNfeTransporte ??= GeneratedColumn<int>('ID_NFE_TRANSPORTE', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_TRANSPORTE(ID)');
  final VerificationMeta _placaMeta =
      const VerificationMeta('placa');
  GeneratedColumn<String>? _placa;
  @override
  GeneratedColumn<String> get placa => _placa ??=
      GeneratedColumn<String>('PLACA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ufMeta =
      const VerificationMeta('uf');
  GeneratedColumn<String>? _uf;
  @override
  GeneratedColumn<String> get uf => _uf ??=
      GeneratedColumn<String>('UF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _rntcMeta =
      const VerificationMeta('rntc');
  GeneratedColumn<String>? _rntc;
  @override
  GeneratedColumn<String> get rntc => _rntc ??=
      GeneratedColumn<String>('RNTC', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _vagaoMeta =
      const VerificationMeta('vagao');
  GeneratedColumn<String>? _vagao;
  @override
  GeneratedColumn<String> get vagao => _vagao ??=
      GeneratedColumn<String>('VAGAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _balsaMeta =
      const VerificationMeta('balsa');
  GeneratedColumn<String>? _balsa;
  @override
  GeneratedColumn<String> get balsa => _balsa ??=
      GeneratedColumn<String>('BALSA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeTransporte,
        placa,
        uf,
        rntc,
        vagao,
        balsa,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_TRANSPORTE_REBOQUE';
  
  @override
  String get actualTableName => 'NFE_TRANSPORTE_REBOQUE';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeTransporteReboque> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_TRANSPORTE')) {
        context.handle(_idNfeTransporteMeta,
            idNfeTransporte.isAcceptableOrUnknown(data['ID_NFE_TRANSPORTE']!, _idNfeTransporteMeta));
    }
    if (data.containsKey('PLACA')) {
        context.handle(_placaMeta,
            placa.isAcceptableOrUnknown(data['PLACA']!, _placaMeta));
    }
    if (data.containsKey('UF')) {
        context.handle(_ufMeta,
            uf.isAcceptableOrUnknown(data['UF']!, _ufMeta));
    }
    if (data.containsKey('RNTC')) {
        context.handle(_rntcMeta,
            rntc.isAcceptableOrUnknown(data['RNTC']!, _rntcMeta));
    }
    if (data.containsKey('VAGAO')) {
        context.handle(_vagaoMeta,
            vagao.isAcceptableOrUnknown(data['VAGAO']!, _vagaoMeta));
    }
    if (data.containsKey('BALSA')) {
        context.handle(_balsaMeta,
            balsa.isAcceptableOrUnknown(data['BALSA']!, _balsaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeTransporteReboque map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeTransporteReboque.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeTransporteReboquesTable createAlias(String alias) {
    return $NfeTransporteReboquesTable(_db, alias);
  }
}