/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_ALIQUOTAS] 
                                                                                
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

@DataClassName("EcfAliquotas")
@UseRowClass(EcfAliquotas)
class EcfAliquotass extends Table {
  @override
  String get tableName => 'ECF_ALIQUOTAS';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get totalizadorParcial => text().named('TOTALIZADOR_PARCIAL').withLength(min: 0, max: 10).nullable()();
  TextColumn get ecfIcmsSt => text().named('ECF_ICMS_ST').withLength(min: 0, max: 4).nullable()();
  TextColumn get pafPSt => text().named('PAF_P_ST').withLength(min: 0, max: 1).nullable()();
}

class EcfAliquotas extends DataClass implements Insertable<EcfAliquotas> {
  final int? id;
  final String? totalizadorParcial;
  final String? ecfIcmsSt;
  final String? pafPSt;

  EcfAliquotas(
    {
      required this.id,
      this.totalizadorParcial,
      this.ecfIcmsSt,
      this.pafPSt,
    }
  );

  factory EcfAliquotas.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EcfAliquotas(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      totalizadorParcial: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TOTALIZADOR_PARCIAL']),
      ecfIcmsSt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ECF_ICMS_ST']),
      pafPSt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PAF_P_ST']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || totalizadorParcial != null) {
      map['TOTALIZADOR_PARCIAL'] = Variable<String?>(totalizadorParcial);
    }
    if (!nullToAbsent || ecfIcmsSt != null) {
      map['ECF_ICMS_ST'] = Variable<String?>(ecfIcmsSt);
    }
    if (!nullToAbsent || pafPSt != null) {
      map['PAF_P_ST'] = Variable<String?>(pafPSt);
    }
    return map;
  }

  EcfAliquotassCompanion toCompanion(bool nullToAbsent) {
    return EcfAliquotassCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      totalizadorParcial: totalizadorParcial == null && nullToAbsent
        ? const Value.absent()
        : Value(totalizadorParcial),
      ecfIcmsSt: ecfIcmsSt == null && nullToAbsent
        ? const Value.absent()
        : Value(ecfIcmsSt),
      pafPSt: pafPSt == null && nullToAbsent
        ? const Value.absent()
        : Value(pafPSt),
    );
  }

  factory EcfAliquotas.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EcfAliquotas(
      id: serializer.fromJson<int>(json['id']),
      totalizadorParcial: serializer.fromJson<String>(json['totalizadorParcial']),
      ecfIcmsSt: serializer.fromJson<String>(json['ecfIcmsSt']),
      pafPSt: serializer.fromJson<String>(json['pafPSt']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'totalizadorParcial': serializer.toJson<String?>(totalizadorParcial),
      'ecfIcmsSt': serializer.toJson<String?>(ecfIcmsSt),
      'pafPSt': serializer.toJson<String?>(pafPSt),
    };
  }

  EcfAliquotas copyWith(
        {
		  int? id,
          String? totalizadorParcial,
          String? ecfIcmsSt,
          String? pafPSt,
		}) =>
      EcfAliquotas(
        id: id ?? this.id,
        totalizadorParcial: totalizadorParcial ?? this.totalizadorParcial,
        ecfIcmsSt: ecfIcmsSt ?? this.ecfIcmsSt,
        pafPSt: pafPSt ?? this.pafPSt,
      );
  
  @override
  String toString() {
    return (StringBuffer('EcfAliquotas(')
          ..write('id: $id, ')
          ..write('totalizadorParcial: $totalizadorParcial, ')
          ..write('ecfIcmsSt: $ecfIcmsSt, ')
          ..write('pafPSt: $pafPSt, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      totalizadorParcial,
      ecfIcmsSt,
      pafPSt,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcfAliquotas &&
          other.id == id &&
          other.totalizadorParcial == totalizadorParcial &&
          other.ecfIcmsSt == ecfIcmsSt &&
          other.pafPSt == pafPSt 
	   );
}

class EcfAliquotassCompanion extends UpdateCompanion<EcfAliquotas> {

  final Value<int?> id;
  final Value<String?> totalizadorParcial;
  final Value<String?> ecfIcmsSt;
  final Value<String?> pafPSt;

  const EcfAliquotassCompanion({
    this.id = const Value.absent(),
    this.totalizadorParcial = const Value.absent(),
    this.ecfIcmsSt = const Value.absent(),
    this.pafPSt = const Value.absent(),
  });

  EcfAliquotassCompanion.insert({
    this.id = const Value.absent(),
    this.totalizadorParcial = const Value.absent(),
    this.ecfIcmsSt = const Value.absent(),
    this.pafPSt = const Value.absent(),
  });

  static Insertable<EcfAliquotas> custom({
    Expression<int>? id,
    Expression<String>? totalizadorParcial,
    Expression<String>? ecfIcmsSt,
    Expression<String>? pafPSt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (totalizadorParcial != null) 'TOTALIZADOR_PARCIAL': totalizadorParcial,
      if (ecfIcmsSt != null) 'ECF_ICMS_ST': ecfIcmsSt,
      if (pafPSt != null) 'PAF_P_ST': pafPSt,
    });
  }

  EcfAliquotassCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? totalizadorParcial,
      Value<String>? ecfIcmsSt,
      Value<String>? pafPSt,
	  }) {
    return EcfAliquotassCompanion(
      id: id ?? this.id,
      totalizadorParcial: totalizadorParcial ?? this.totalizadorParcial,
      ecfIcmsSt: ecfIcmsSt ?? this.ecfIcmsSt,
      pafPSt: pafPSt ?? this.pafPSt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (totalizadorParcial.present) {
      map['TOTALIZADOR_PARCIAL'] = Variable<String?>(totalizadorParcial.value);
    }
    if (ecfIcmsSt.present) {
      map['ECF_ICMS_ST'] = Variable<String?>(ecfIcmsSt.value);
    }
    if (pafPSt.present) {
      map['PAF_P_ST'] = Variable<String?>(pafPSt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcfAliquotassCompanion(')
          ..write('id: $id, ')
          ..write('totalizadorParcial: $totalizadorParcial, ')
          ..write('ecfIcmsSt: $ecfIcmsSt, ')
          ..write('pafPSt: $pafPSt, ')
          ..write(')'))
        .toString();
  }
}

class $EcfAliquotassTable extends EcfAliquotass
    with TableInfo<$EcfAliquotassTable, EcfAliquotas> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EcfAliquotassTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _totalizadorParcialMeta =
      const VerificationMeta('totalizadorParcial');
  GeneratedColumn<String>? _totalizadorParcial;
  @override
  GeneratedColumn<String> get totalizadorParcial => _totalizadorParcial ??=
      GeneratedColumn<String>('TOTALIZADOR_PARCIAL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _ecfIcmsStMeta =
      const VerificationMeta('ecfIcmsSt');
  GeneratedColumn<String>? _ecfIcmsSt;
  @override
  GeneratedColumn<String> get ecfIcmsSt => _ecfIcmsSt ??=
      GeneratedColumn<String>('ECF_ICMS_ST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _pafPStMeta =
      const VerificationMeta('pafPSt');
  GeneratedColumn<String>? _pafPSt;
  @override
  GeneratedColumn<String> get pafPSt => _pafPSt ??=
      GeneratedColumn<String>('PAF_P_ST', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        totalizadorParcial,
        ecfIcmsSt,
        pafPSt,
      ];

  @override
  String get aliasedName => _alias ?? 'ECF_ALIQUOTAS';
  
  @override
  String get actualTableName => 'ECF_ALIQUOTAS';
  
  @override
  VerificationContext validateIntegrity(Insertable<EcfAliquotas> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('TOTALIZADOR_PARCIAL')) {
        context.handle(_totalizadorParcialMeta,
            totalizadorParcial.isAcceptableOrUnknown(data['TOTALIZADOR_PARCIAL']!, _totalizadorParcialMeta));
    }
    if (data.containsKey('ECF_ICMS_ST')) {
        context.handle(_ecfIcmsStMeta,
            ecfIcmsSt.isAcceptableOrUnknown(data['ECF_ICMS_ST']!, _ecfIcmsStMeta));
    }
    if (data.containsKey('PAF_P_ST')) {
        context.handle(_pafPStMeta,
            pafPSt.isAcceptableOrUnknown(data['PAF_P_ST']!, _pafPStMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EcfAliquotas map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EcfAliquotas.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EcfAliquotassTable createAlias(String alias) {
    return $EcfAliquotassTable(_db, alias);
  }
}