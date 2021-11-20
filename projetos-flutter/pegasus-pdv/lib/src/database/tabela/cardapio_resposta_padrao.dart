/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [CARDAPIO_RESPOSTA_PADRAO] 
                                                                                
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

@DataClassName("CardapioRespostaPadrao")
@UseRowClass(CardapioRespostaPadrao)
class CardapioRespostaPadraos extends Table {
  @override
  String get tableName => 'CARDAPIO_RESPOSTA_PADRAO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idCardapioPerguntaPadrao => integer().named('ID_CARDAPIO_PERGUNTA_PADRAO').nullable().customConstraint('NULLABLE REFERENCES CARDAPIO_PERGUNTA_PADRAO(ID)')();
  TextColumn get resposta => text().named('RESPOSTA').withLength(min: 0, max: 100).nullable()();
}

class CardapioRespostaPadrao extends DataClass implements Insertable<CardapioRespostaPadrao> {
  final int? id;
  final int? idCardapioPerguntaPadrao;
  final String? resposta;

  CardapioRespostaPadrao(
    {
      required this.id,
      this.idCardapioPerguntaPadrao,
      this.resposta,
    }
  );

  factory CardapioRespostaPadrao.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CardapioRespostaPadrao(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idCardapioPerguntaPadrao: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_CARDAPIO_PERGUNTA_PADRAO']),
      resposta: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}RESPOSTA']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idCardapioPerguntaPadrao != null) {
      map['ID_CARDAPIO_PERGUNTA_PADRAO'] = Variable<int?>(idCardapioPerguntaPadrao);
    }
    if (!nullToAbsent || resposta != null) {
      map['RESPOSTA'] = Variable<String?>(resposta);
    }
    return map;
  }

  CardapioRespostaPadraosCompanion toCompanion(bool nullToAbsent) {
    return CardapioRespostaPadraosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idCardapioPerguntaPadrao: idCardapioPerguntaPadrao == null && nullToAbsent
        ? const Value.absent()
        : Value(idCardapioPerguntaPadrao),
      resposta: resposta == null && nullToAbsent
        ? const Value.absent()
        : Value(resposta),
    );
  }

  factory CardapioRespostaPadrao.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CardapioRespostaPadrao(
      id: serializer.fromJson<int>(json['id']),
      idCardapioPerguntaPadrao: serializer.fromJson<int>(json['idCardapioPerguntaPadrao']),
      resposta: serializer.fromJson<String>(json['resposta']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idCardapioPerguntaPadrao': serializer.toJson<int?>(idCardapioPerguntaPadrao),
      'resposta': serializer.toJson<String?>(resposta),
    };
  }

  CardapioRespostaPadrao copyWith(
        {
		  int? id,
          int? idCardapioPerguntaPadrao,
          String? resposta,
		}) =>
      CardapioRespostaPadrao(
        id: id ?? this.id,
        idCardapioPerguntaPadrao: idCardapioPerguntaPadrao ?? this.idCardapioPerguntaPadrao,
        resposta: resposta ?? this.resposta,
      );
  
  @override
  String toString() {
    return (StringBuffer('CardapioRespostaPadrao(')
          ..write('id: $id, ')
          ..write('idCardapioPerguntaPadrao: $idCardapioPerguntaPadrao, ')
          ..write('resposta: $resposta, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idCardapioPerguntaPadrao,
      resposta,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardapioRespostaPadrao &&
          other.id == id &&
          other.idCardapioPerguntaPadrao == idCardapioPerguntaPadrao &&
          other.resposta == resposta 
	   );
}

class CardapioRespostaPadraosCompanion extends UpdateCompanion<CardapioRespostaPadrao> {

  final Value<int?> id;
  final Value<int?> idCardapioPerguntaPadrao;
  final Value<String?> resposta;

  const CardapioRespostaPadraosCompanion({
    this.id = const Value.absent(),
    this.idCardapioPerguntaPadrao = const Value.absent(),
    this.resposta = const Value.absent(),
  });

  CardapioRespostaPadraosCompanion.insert({
    this.id = const Value.absent(),
    this.idCardapioPerguntaPadrao = const Value.absent(),
    this.resposta = const Value.absent(),
  });

  static Insertable<CardapioRespostaPadrao> custom({
    Expression<int>? id,
    Expression<int>? idCardapioPerguntaPadrao,
    Expression<String>? resposta,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idCardapioPerguntaPadrao != null) 'ID_CARDAPIO_PERGUNTA_PADRAO': idCardapioPerguntaPadrao,
      if (resposta != null) 'RESPOSTA': resposta,
    });
  }

  CardapioRespostaPadraosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idCardapioPerguntaPadrao,
      Value<String>? resposta,
	  }) {
    return CardapioRespostaPadraosCompanion(
      id: id ?? this.id,
      idCardapioPerguntaPadrao: idCardapioPerguntaPadrao ?? this.idCardapioPerguntaPadrao,
      resposta: resposta ?? this.resposta,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idCardapioPerguntaPadrao.present) {
      map['ID_CARDAPIO_PERGUNTA_PADRAO'] = Variable<int?>(idCardapioPerguntaPadrao.value);
    }
    if (resposta.present) {
      map['RESPOSTA'] = Variable<String?>(resposta.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardapioRespostaPadraosCompanion(')
          ..write('id: $id, ')
          ..write('idCardapioPerguntaPadrao: $idCardapioPerguntaPadrao, ')
          ..write('resposta: $resposta, ')
          ..write(')'))
        .toString();
  }
}

class $CardapioRespostaPadraosTable extends CardapioRespostaPadraos
    with TableInfo<$CardapioRespostaPadraosTable, CardapioRespostaPadrao> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CardapioRespostaPadraosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idCardapioPerguntaPadraoMeta =
      const VerificationMeta('idCardapioPerguntaPadrao');
  GeneratedColumn<int>? _idCardapioPerguntaPadrao;
  @override
  GeneratedColumn<int> get idCardapioPerguntaPadrao =>
      _idCardapioPerguntaPadrao ??= GeneratedColumn<int>('ID_CARDAPIO_PERGUNTA_PADRAO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES CARDAPIO_PERGUNTA_PADRAO(ID)');
  final VerificationMeta _respostaMeta =
      const VerificationMeta('resposta');
  GeneratedColumn<String>? _resposta;
  @override
  GeneratedColumn<String> get resposta => _resposta ??=
      GeneratedColumn<String>('RESPOSTA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idCardapioPerguntaPadrao,
        resposta,
      ];

  @override
  String get aliasedName => _alias ?? 'CARDAPIO_RESPOSTA_PADRAO';
  
  @override
  String get actualTableName => 'CARDAPIO_RESPOSTA_PADRAO';
  
  @override
  VerificationContext validateIntegrity(Insertable<CardapioRespostaPadrao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_CARDAPIO_PERGUNTA_PADRAO')) {
        context.handle(_idCardapioPerguntaPadraoMeta,
            idCardapioPerguntaPadrao.isAcceptableOrUnknown(data['ID_CARDAPIO_PERGUNTA_PADRAO']!, _idCardapioPerguntaPadraoMeta));
    }
    if (data.containsKey('RESPOSTA')) {
        context.handle(_respostaMeta,
            resposta.isAcceptableOrUnknown(data['RESPOSTA']!, _respostaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardapioRespostaPadrao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CardapioRespostaPadrao.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CardapioRespostaPadraosTable createAlias(String alias) {
    return $CardapioRespostaPadraosTable(_db, alias);
  }
}