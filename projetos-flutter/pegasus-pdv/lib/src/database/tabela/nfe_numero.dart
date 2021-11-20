/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_NUMERO] 
                                                                                
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

@DataClassName("NfeNumero")
@UseRowClass(NfeNumero)
class NfeNumeros extends Table {
  @override
  String get tableName => 'NFE_NUMERO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get modelo => text().named('MODELO').withLength(min: 0, max: 2).nullable()();
  TextColumn get serie => text().named('SERIE').withLength(min: 0, max: 3).nullable()();
  IntColumn get numero => integer().named('NUMERO').nullable()();
}

class NfeNumero extends DataClass implements Insertable<NfeNumero> {
  final int? id;
  final String? modelo;
  final String? serie;
  final int? numero;

  NfeNumero(
    {
      required this.id,
      this.modelo,
      this.serie,
      this.numero,
    }
  );

  factory NfeNumero.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeNumero(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      modelo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODELO']),
      serie: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SERIE']),
      numero: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || modelo != null) {
      map['MODELO'] = Variable<String?>(modelo);
    }
    if (!nullToAbsent || serie != null) {
      map['SERIE'] = Variable<String?>(serie);
    }
    if (!nullToAbsent || numero != null) {
      map['NUMERO'] = Variable<int?>(numero);
    }
    return map;
  }

  NfeNumerosCompanion toCompanion(bool nullToAbsent) {
    return NfeNumerosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      modelo: modelo == null && nullToAbsent
        ? const Value.absent()
        : Value(modelo),
      serie: serie == null && nullToAbsent
        ? const Value.absent()
        : Value(serie),
      numero: numero == null && nullToAbsent
        ? const Value.absent()
        : Value(numero),
    );
  }

  factory NfeNumero.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeNumero(
      id: serializer.fromJson<int>(json['id']),
      modelo: serializer.fromJson<String>(json['modelo']),
      serie: serializer.fromJson<String>(json['serie']),
      numero: serializer.fromJson<int>(json['numero']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'modelo': serializer.toJson<String?>(modelo),
      'serie': serializer.toJson<String?>(serie),
      'numero': serializer.toJson<int?>(numero),
    };
  }

  NfeNumero copyWith(
        {
		  int? id,
          String? modelo,
          String? serie,
          int? numero,
		}) =>
      NfeNumero(
        id: id ?? this.id,
        modelo: modelo ?? this.modelo,
        serie: serie ?? this.serie,
        numero: numero ?? this.numero,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeNumero(')
          ..write('id: $id, ')
          ..write('modelo: $modelo, ')
          ..write('serie: $serie, ')
          ..write('numero: $numero, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      modelo,
      serie,
      numero,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeNumero &&
          other.id == id &&
          other.modelo == modelo &&
          other.serie == serie &&
          other.numero == numero 
	   );
}

class NfeNumerosCompanion extends UpdateCompanion<NfeNumero> {

  final Value<int?> id;
  final Value<String?> modelo;
  final Value<String?> serie;
  final Value<int?> numero;

  const NfeNumerosCompanion({
    this.id = const Value.absent(),
    this.modelo = const Value.absent(),
    this.serie = const Value.absent(),
    this.numero = const Value.absent(),
  });

  NfeNumerosCompanion.insert({
    this.id = const Value.absent(),
    this.modelo = const Value.absent(),
    this.serie = const Value.absent(),
    this.numero = const Value.absent(),
  });

  static Insertable<NfeNumero> custom({
    Expression<int>? id,
    Expression<String>? modelo,
    Expression<String>? serie,
    Expression<int>? numero,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (modelo != null) 'MODELO': modelo,
      if (serie != null) 'SERIE': serie,
      if (numero != null) 'NUMERO': numero,
    });
  }

  NfeNumerosCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? modelo,
      Value<String>? serie,
      Value<int>? numero,
	  }) {
    return NfeNumerosCompanion(
      id: id ?? this.id,
      modelo: modelo ?? this.modelo,
      serie: serie ?? this.serie,
      numero: numero ?? this.numero,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (modelo.present) {
      map['MODELO'] = Variable<String?>(modelo.value);
    }
    if (serie.present) {
      map['SERIE'] = Variable<String?>(serie.value);
    }
    if (numero.present) {
      map['NUMERO'] = Variable<int?>(numero.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeNumerosCompanion(')
          ..write('id: $id, ')
          ..write('modelo: $modelo, ')
          ..write('serie: $serie, ')
          ..write('numero: $numero, ')
          ..write(')'))
        .toString();
  }
}

class $NfeNumerosTable extends NfeNumeros
    with TableInfo<$NfeNumerosTable, NfeNumero> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeNumerosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

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
  final VerificationMeta _numeroMeta =
      const VerificationMeta('numero');
  GeneratedColumn<int>? _numero;
  @override
  GeneratedColumn<int> get numero => _numero ??=
      GeneratedColumn<int>('NUMERO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        modelo,
        serie,
        numero,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_NUMERO';
  
  @override
  String get actualTableName => 'NFE_NUMERO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeNumero> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('MODELO')) {
        context.handle(_modeloMeta,
            modelo.isAcceptableOrUnknown(data['MODELO']!, _modeloMeta));
    }
    if (data.containsKey('SERIE')) {
        context.handle(_serieMeta,
            serie.isAcceptableOrUnknown(data['SERIE']!, _serieMeta));
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
  NfeNumero map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeNumero.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeNumerosTable createAlias(String alias) {
    return $NfeNumerosTable(_db, alias);
  }
}