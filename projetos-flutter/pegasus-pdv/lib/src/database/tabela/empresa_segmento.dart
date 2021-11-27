/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [EMPRESA_SEGMENTO] 
                                                                                
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

@DataClassName("EmpresaSegmento")
@UseRowClass(EmpresaSegmento)
class EmpresaSegmentos extends Table {
  @override
  String get tableName => 'EMPRESA_SEGMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get codigo => text().named('CODIGO').withLength(min: 0, max: 2).nullable()();
  TextColumn get denominacao => text().named('DENOMINACAO').withLength(min: 0, max: 100).nullable()();
  TextColumn get divisoes => text().named('DIVISOES').withLength(min: 0, max: 6).nullable()();
}

class EmpresaSegmento extends DataClass implements Insertable<EmpresaSegmento> {
  final int? id;
  final String? codigo;
  final String? denominacao;
  final String? divisoes;

  EmpresaSegmento(
    {
      required this.id,
      this.codigo,
      this.denominacao,
      this.divisoes,
    }
  );

  factory EmpresaSegmento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EmpresaSegmento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      codigo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO']),
      denominacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DENOMINACAO']),
      divisoes: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DIVISOES']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || codigo != null) {
      map['CODIGO'] = Variable<String?>(codigo);
    }
    if (!nullToAbsent || denominacao != null) {
      map['DENOMINACAO'] = Variable<String?>(denominacao);
    }
    if (!nullToAbsent || divisoes != null) {
      map['DIVISOES'] = Variable<String?>(divisoes);
    }
    return map;
  }

  EmpresaSegmentosCompanion toCompanion(bool nullToAbsent) {
    return EmpresaSegmentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      codigo: codigo == null && nullToAbsent
        ? const Value.absent()
        : Value(codigo),
      denominacao: denominacao == null && nullToAbsent
        ? const Value.absent()
        : Value(denominacao),
      divisoes: divisoes == null && nullToAbsent
        ? const Value.absent()
        : Value(divisoes),
    );
  }

  factory EmpresaSegmento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EmpresaSegmento(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      denominacao: serializer.fromJson<String>(json['denominacao']),
      divisoes: serializer.fromJson<String>(json['divisoes']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'codigo': serializer.toJson<String?>(codigo),
      'denominacao': serializer.toJson<String?>(denominacao),
      'divisoes': serializer.toJson<String?>(divisoes),
    };
  }

  EmpresaSegmento copyWith(
        {
		  int? id,
          String? codigo,
          String? denominacao,
          String? divisoes,
		}) =>
      EmpresaSegmento(
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        denominacao: denominacao ?? this.denominacao,
        divisoes: divisoes ?? this.divisoes,
      );
  
  @override
  String toString() {
    return (StringBuffer('EmpresaSegmento(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('denominacao: $denominacao, ')
          ..write('divisoes: $divisoes, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      codigo,
      denominacao,
      divisoes,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmpresaSegmento &&
          other.id == id &&
          other.codigo == codigo &&
          other.denominacao == denominacao &&
          other.divisoes == divisoes 
	   );
}

class EmpresaSegmentosCompanion extends UpdateCompanion<EmpresaSegmento> {

  final Value<int?> id;
  final Value<String?> codigo;
  final Value<String?> denominacao;
  final Value<String?> divisoes;

  const EmpresaSegmentosCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.denominacao = const Value.absent(),
    this.divisoes = const Value.absent(),
  });

  EmpresaSegmentosCompanion.insert({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.denominacao = const Value.absent(),
    this.divisoes = const Value.absent(),
  });

  static Insertable<EmpresaSegmento> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? denominacao,
    Expression<String>? divisoes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (codigo != null) 'CODIGO': codigo,
      if (denominacao != null) 'DENOMINACAO': denominacao,
      if (divisoes != null) 'DIVISOES': divisoes,
    });
  }

  EmpresaSegmentosCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? codigo,
      Value<String>? denominacao,
      Value<String>? divisoes,
	  }) {
    return EmpresaSegmentosCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      denominacao: denominacao ?? this.denominacao,
      divisoes: divisoes ?? this.divisoes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (codigo.present) {
      map['CODIGO'] = Variable<String?>(codigo.value);
    }
    if (denominacao.present) {
      map['DENOMINACAO'] = Variable<String?>(denominacao.value);
    }
    if (divisoes.present) {
      map['DIVISOES'] = Variable<String?>(divisoes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmpresaSegmentosCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('denominacao: $denominacao, ')
          ..write('divisoes: $divisoes, ')
          ..write(')'))
        .toString();
  }
}

class $EmpresaSegmentosTable extends EmpresaSegmentos
    with TableInfo<$EmpresaSegmentosTable, EmpresaSegmento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EmpresaSegmentosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _codigoMeta =
      const VerificationMeta('codigo');
  GeneratedColumn<String>? _codigo;
  @override
  GeneratedColumn<String> get codigo => _codigo ??=
      GeneratedColumn<String>('CODIGO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _denominacaoMeta =
      const VerificationMeta('denominacao');
  GeneratedColumn<String>? _denominacao;
  @override
  GeneratedColumn<String> get denominacao => _denominacao ??=
      GeneratedColumn<String>('DENOMINACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _divisoesMeta =
      const VerificationMeta('divisoes');
  GeneratedColumn<String>? _divisoes;
  @override
  GeneratedColumn<String> get divisoes => _divisoes ??=
      GeneratedColumn<String>('DIVISOES', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        codigo,
        denominacao,
        divisoes,
      ];

  @override
  String get aliasedName => _alias ?? 'EMPRESA_SEGMENTO';
  
  @override
  String get actualTableName => 'EMPRESA_SEGMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<EmpresaSegmento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('CODIGO')) {
        context.handle(_codigoMeta,
            codigo.isAcceptableOrUnknown(data['CODIGO']!, _codigoMeta));
    }
    if (data.containsKey('DENOMINACAO')) {
        context.handle(_denominacaoMeta,
            denominacao.isAcceptableOrUnknown(data['DENOMINACAO']!, _denominacaoMeta));
    }
    if (data.containsKey('DIVISOES')) {
        context.handle(_divisoesMeta,
            divisoes.isAcceptableOrUnknown(data['DIVISOES']!, _divisoesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmpresaSegmento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EmpresaSegmento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EmpresaSegmentosTable createAlias(String alias) {
    return $EmpresaSegmentosTable(_db, alias);
  }
}