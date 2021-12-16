/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [CARDAPIO_PERGUNTA_PADRAO] 
                                                                                
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

import '../database_classes.dart';

@DataClassName("CardapioPerguntaPadrao")
@UseRowClass(CardapioPerguntaPadrao)
class CardapioPerguntaPadraos extends Table {
  @override
  String get tableName => 'CARDAPIO_PERGUNTA_PADRAO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idCardapio => integer().named('ID_CARDAPIO').nullable().customConstraint('NULLABLE REFERENCES CARDAPIO(ID)')();
  TextColumn get pergunta => text().named('PERGUNTA').withLength(min: 0, max: 100).nullable()();
}

class CardapioPerguntaPadraoMontado {
  int id;
  CardapioPerguntaPadrao? cardapioPerguntaPadrao;
  List<CardapioRespostaPadrao> listaCardapioRespostaPadrao;

  CardapioPerguntaPadraoMontado({
    required this.id,
    this.cardapioPerguntaPadrao,
    required this.listaCardapioRespostaPadrao,
  });
}

class CardapioPerguntaPadrao extends DataClass implements Insertable<CardapioPerguntaPadrao> {
  final int? id;
  final int? idCardapio;
  final String? pergunta;

  CardapioPerguntaPadrao(
    {
      required this.id,
      this.idCardapio,
      this.pergunta,
    }
  );

  factory CardapioPerguntaPadrao.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CardapioPerguntaPadrao(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idCardapio: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_CARDAPIO']),
      pergunta: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PERGUNTA']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idCardapio != null) {
      map['ID_CARDAPIO'] = Variable<int?>(idCardapio);
    }
    if (!nullToAbsent || pergunta != null) {
      map['PERGUNTA'] = Variable<String?>(pergunta);
    }
    return map;
  }

  CardapioPerguntaPadraosCompanion toCompanion(bool nullToAbsent) {
    return CardapioPerguntaPadraosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idCardapio: idCardapio == null && nullToAbsent
        ? const Value.absent()
        : Value(idCardapio),
      pergunta: pergunta == null && nullToAbsent
        ? const Value.absent()
        : Value(pergunta),
    );
  }

  factory CardapioPerguntaPadrao.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CardapioPerguntaPadrao(
      id: serializer.fromJson<int>(json['id']),
      idCardapio: serializer.fromJson<int>(json['idCardapio']),
      pergunta: serializer.fromJson<String>(json['pergunta']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idCardapio': serializer.toJson<int?>(idCardapio),
      'pergunta': serializer.toJson<String?>(pergunta),
    };
  }

  CardapioPerguntaPadrao copyWith(
        {
		  int? id,
          int? idCardapio,
          String? pergunta,
		}) =>
      CardapioPerguntaPadrao(
        id: id ?? this.id,
        idCardapio: idCardapio ?? this.idCardapio,
        pergunta: pergunta ?? this.pergunta,
      );
  
  @override
  String toString() {
    return (StringBuffer('CardapioPerguntaPadrao(')
          ..write('id: $id, ')
          ..write('idCardapio: $idCardapio, ')
          ..write('pergunta: $pergunta, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idCardapio,
      pergunta,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardapioPerguntaPadrao &&
          other.id == id &&
          other.idCardapio == idCardapio &&
          other.pergunta == pergunta 
	   );
}

class CardapioPerguntaPadraosCompanion extends UpdateCompanion<CardapioPerguntaPadrao> {

  final Value<int?> id;
  final Value<int?> idCardapio;
  final Value<String?> pergunta;

  const CardapioPerguntaPadraosCompanion({
    this.id = const Value.absent(),
    this.idCardapio = const Value.absent(),
    this.pergunta = const Value.absent(),
  });

  CardapioPerguntaPadraosCompanion.insert({
    this.id = const Value.absent(),
    this.idCardapio = const Value.absent(),
    this.pergunta = const Value.absent(),
  });

  static Insertable<CardapioPerguntaPadrao> custom({
    Expression<int>? id,
    Expression<int>? idCardapio,
    Expression<String>? pergunta,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idCardapio != null) 'ID_CARDAPIO': idCardapio,
      if (pergunta != null) 'PERGUNTA': pergunta,
    });
  }

  CardapioPerguntaPadraosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idCardapio,
      Value<String>? pergunta,
	  }) {
    return CardapioPerguntaPadraosCompanion(
      id: id ?? this.id,
      idCardapio: idCardapio ?? this.idCardapio,
      pergunta: pergunta ?? this.pergunta,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idCardapio.present) {
      map['ID_CARDAPIO'] = Variable<int?>(idCardapio.value);
    }
    if (pergunta.present) {
      map['PERGUNTA'] = Variable<String?>(pergunta.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardapioPerguntaPadraosCompanion(')
          ..write('id: $id, ')
          ..write('idCardapio: $idCardapio, ')
          ..write('pergunta: $pergunta, ')
          ..write(')'))
        .toString();
  }
}

class $CardapioPerguntaPadraosTable extends CardapioPerguntaPadraos
    with TableInfo<$CardapioPerguntaPadraosTable, CardapioPerguntaPadrao> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CardapioPerguntaPadraosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idCardapioMeta =
      const VerificationMeta('idCardapio');
  GeneratedColumn<int>? _idCardapio;
  @override
  GeneratedColumn<int> get idCardapio =>
      _idCardapio ??= GeneratedColumn<int>('ID_CARDAPIO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES CARDAPIO(ID)');
  final VerificationMeta _perguntaMeta =
      const VerificationMeta('pergunta');
  GeneratedColumn<String>? _pergunta;
  @override
  GeneratedColumn<String> get pergunta => _pergunta ??=
      GeneratedColumn<String>('PERGUNTA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idCardapio,
        pergunta,
      ];

  @override
  String get aliasedName => _alias ?? 'CARDAPIO_PERGUNTA_PADRAO';
  
  @override
  String get actualTableName => 'CARDAPIO_PERGUNTA_PADRAO';
  
  @override
  VerificationContext validateIntegrity(Insertable<CardapioPerguntaPadrao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_CARDAPIO')) {
        context.handle(_idCardapioMeta,
            idCardapio.isAcceptableOrUnknown(data['ID_CARDAPIO']!, _idCardapioMeta));
    }
    if (data.containsKey('PERGUNTA')) {
        context.handle(_perguntaMeta,
            pergunta.isAcceptableOrUnknown(data['PERGUNTA']!, _perguntaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardapioPerguntaPadrao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CardapioPerguntaPadrao.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CardapioPerguntaPadraosTable createAlias(String alias) {
    return $CardapioPerguntaPadraosTable(_db, alias);
  }
}