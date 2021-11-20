/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_SINTEGRA_60A] 
                                                                                
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

@DataClassName("EcfSintegra60A")
@UseRowClass(EcfSintegra60A)
class EcfSintegra60As extends Table {
  @override
  String get tableName => 'ECF_SINTEGRA_60A';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idEcfSintegra60M => integer().named('ID_ECF_SINTEGRA_60M').nullable().customConstraint('NULLABLE REFERENCES ECF_SINTEGRA_60M(ID)')();
  TextColumn get situacaoTributaria => text().named('SITUACAO_TRIBUTARIA').withLength(min: 0, max: 4).nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
}

class EcfSintegra60A extends DataClass implements Insertable<EcfSintegra60A> {
  final int? id;
  final int? idEcfSintegra60M;
  final String? situacaoTributaria;
  final double? valor;

  EcfSintegra60A(
    {
      required this.id,
      this.idEcfSintegra60M,
      this.situacaoTributaria,
      this.valor,
    }
  );

  factory EcfSintegra60A.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EcfSintegra60A(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idEcfSintegra60M: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_ECF_SINTEGRA_60M']),
      situacaoTributaria: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SITUACAO_TRIBUTARIA']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idEcfSintegra60M != null) {
      map['ID_ECF_SINTEGRA_60M'] = Variable<int?>(idEcfSintegra60M);
    }
    if (!nullToAbsent || situacaoTributaria != null) {
      map['SITUACAO_TRIBUTARIA'] = Variable<String?>(situacaoTributaria);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    return map;
  }

  EcfSintegra60AsCompanion toCompanion(bool nullToAbsent) {
    return EcfSintegra60AsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idEcfSintegra60M: idEcfSintegra60M == null && nullToAbsent
        ? const Value.absent()
        : Value(idEcfSintegra60M),
      situacaoTributaria: situacaoTributaria == null && nullToAbsent
        ? const Value.absent()
        : Value(situacaoTributaria),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
    );
  }

  factory EcfSintegra60A.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EcfSintegra60A(
      id: serializer.fromJson<int>(json['id']),
      idEcfSintegra60M: serializer.fromJson<int>(json['idEcfSintegra60M']),
      situacaoTributaria: serializer.fromJson<String>(json['situacaoTributaria']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idEcfSintegra60M': serializer.toJson<int?>(idEcfSintegra60M),
      'situacaoTributaria': serializer.toJson<String?>(situacaoTributaria),
      'valor': serializer.toJson<double?>(valor),
    };
  }

  EcfSintegra60A copyWith(
        {
		  int? id,
          int? idEcfSintegra60M,
          String? situacaoTributaria,
          double? valor,
		}) =>
      EcfSintegra60A(
        id: id ?? this.id,
        idEcfSintegra60M: idEcfSintegra60M ?? this.idEcfSintegra60M,
        situacaoTributaria: situacaoTributaria ?? this.situacaoTributaria,
        valor: valor ?? this.valor,
      );
  
  @override
  String toString() {
    return (StringBuffer('EcfSintegra60A(')
          ..write('id: $id, ')
          ..write('idEcfSintegra60M: $idEcfSintegra60M, ')
          ..write('situacaoTributaria: $situacaoTributaria, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idEcfSintegra60M,
      situacaoTributaria,
      valor,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcfSintegra60A &&
          other.id == id &&
          other.idEcfSintegra60M == idEcfSintegra60M &&
          other.situacaoTributaria == situacaoTributaria &&
          other.valor == valor 
	   );
}

class EcfSintegra60AsCompanion extends UpdateCompanion<EcfSintegra60A> {

  final Value<int?> id;
  final Value<int?> idEcfSintegra60M;
  final Value<String?> situacaoTributaria;
  final Value<double?> valor;

  const EcfSintegra60AsCompanion({
    this.id = const Value.absent(),
    this.idEcfSintegra60M = const Value.absent(),
    this.situacaoTributaria = const Value.absent(),
    this.valor = const Value.absent(),
  });

  EcfSintegra60AsCompanion.insert({
    this.id = const Value.absent(),
    this.idEcfSintegra60M = const Value.absent(),
    this.situacaoTributaria = const Value.absent(),
    this.valor = const Value.absent(),
  });

  static Insertable<EcfSintegra60A> custom({
    Expression<int>? id,
    Expression<int>? idEcfSintegra60M,
    Expression<String>? situacaoTributaria,
    Expression<double>? valor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idEcfSintegra60M != null) 'ID_ECF_SINTEGRA_60M': idEcfSintegra60M,
      if (situacaoTributaria != null) 'SITUACAO_TRIBUTARIA': situacaoTributaria,
      if (valor != null) 'VALOR': valor,
    });
  }

  EcfSintegra60AsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idEcfSintegra60M,
      Value<String>? situacaoTributaria,
      Value<double>? valor,
	  }) {
    return EcfSintegra60AsCompanion(
      id: id ?? this.id,
      idEcfSintegra60M: idEcfSintegra60M ?? this.idEcfSintegra60M,
      situacaoTributaria: situacaoTributaria ?? this.situacaoTributaria,
      valor: valor ?? this.valor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idEcfSintegra60M.present) {
      map['ID_ECF_SINTEGRA_60M'] = Variable<int?>(idEcfSintegra60M.value);
    }
    if (situacaoTributaria.present) {
      map['SITUACAO_TRIBUTARIA'] = Variable<String?>(situacaoTributaria.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcfSintegra60AsCompanion(')
          ..write('id: $id, ')
          ..write('idEcfSintegra60M: $idEcfSintegra60M, ')
          ..write('situacaoTributaria: $situacaoTributaria, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }
}

class $EcfSintegra60AsTable extends EcfSintegra60As
    with TableInfo<$EcfSintegra60AsTable, EcfSintegra60A> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EcfSintegra60AsTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idEcfSintegra60MMeta =
      const VerificationMeta('idEcfSintegra60M');
  GeneratedColumn<int>? _idEcfSintegra60M;
  @override
  GeneratedColumn<int> get idEcfSintegra60M =>
      _idEcfSintegra60M ??= GeneratedColumn<int>('ID_ECF_SINTEGRA_60M', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES ECF_SINTEGRA_60M(ID)');
  final VerificationMeta _situacaoTributariaMeta =
      const VerificationMeta('situacaoTributaria');
  GeneratedColumn<String>? _situacaoTributaria;
  @override
  GeneratedColumn<String> get situacaoTributaria => _situacaoTributaria ??=
      GeneratedColumn<String>('SITUACAO_TRIBUTARIA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorMeta =
      const VerificationMeta('valor');
  GeneratedColumn<double>? _valor;
  @override
  GeneratedColumn<double> get valor => _valor ??=
      GeneratedColumn<double>('VALOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idEcfSintegra60M,
        situacaoTributaria,
        valor,
      ];

  @override
  String get aliasedName => _alias ?? 'ECF_SINTEGRA_60A';
  
  @override
  String get actualTableName => 'ECF_SINTEGRA_60A';
  
  @override
  VerificationContext validateIntegrity(Insertable<EcfSintegra60A> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_ECF_SINTEGRA_60M')) {
        context.handle(_idEcfSintegra60MMeta,
            idEcfSintegra60M.isAcceptableOrUnknown(data['ID_ECF_SINTEGRA_60M']!, _idEcfSintegra60MMeta));
    }
    if (data.containsKey('SITUACAO_TRIBUTARIA')) {
        context.handle(_situacaoTributariaMeta,
            situacaoTributaria.isAcceptableOrUnknown(data['SITUACAO_TRIBUTARIA']!, _situacaoTributariaMeta));
    }
    if (data.containsKey('VALOR')) {
        context.handle(_valorMeta,
            valor.isAcceptableOrUnknown(data['VALOR']!, _valorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EcfSintegra60A map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EcfSintegra60A.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EcfSintegra60AsTable createAlias(String alias) {
    return $EcfSintegra60AsTable(_db, alias);
  }
}