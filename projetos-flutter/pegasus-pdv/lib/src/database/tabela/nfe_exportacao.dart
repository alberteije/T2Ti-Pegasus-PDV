/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_EXPORTACAO] 
                                                                                
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

@DataClassName("NfeExportacao")
@UseRowClass(NfeExportacao)
class NfeExportacaos extends Table {
  @override
  String get tableName => 'NFE_EXPORTACAO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  IntColumn get drawback => integer().named('DRAWBACK').nullable()();
  IntColumn get numeroRegistro => integer().named('NUMERO_REGISTRO').nullable()();
  TextColumn get chaveAcesso => text().named('CHAVE_ACESSO').withLength(min: 0, max: 44).nullable()();
  RealColumn get quantidade => real().named('QUANTIDADE').nullable()();
}

class NfeExportacao extends DataClass implements Insertable<NfeExportacao> {
  final int? id;
  final int? idNfeDetalhe;
  final int? drawback;
  final int? numeroRegistro;
  final String? chaveAcesso;
  final double? quantidade;

  NfeExportacao(
    {
      required this.id,
      this.idNfeDetalhe,
      this.drawback,
      this.numeroRegistro,
      this.chaveAcesso,
      this.quantidade,
    }
  );

  factory NfeExportacao.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeExportacao(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      drawback: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}DRAWBACK']),
      numeroRegistro: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_REGISTRO']),
      chaveAcesso: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CHAVE_ACESSO']),
      quantidade: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeDetalhe != null) {
      map['ID_NFE_DETALHE'] = Variable<int?>(idNfeDetalhe);
    }
    if (!nullToAbsent || drawback != null) {
      map['DRAWBACK'] = Variable<int?>(drawback);
    }
    if (!nullToAbsent || numeroRegistro != null) {
      map['NUMERO_REGISTRO'] = Variable<int?>(numeroRegistro);
    }
    if (!nullToAbsent || chaveAcesso != null) {
      map['CHAVE_ACESSO'] = Variable<String?>(chaveAcesso);
    }
    if (!nullToAbsent || quantidade != null) {
      map['QUANTIDADE'] = Variable<double?>(quantidade);
    }
    return map;
  }

  NfeExportacaosCompanion toCompanion(bool nullToAbsent) {
    return NfeExportacaosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      drawback: drawback == null && nullToAbsent
        ? const Value.absent()
        : Value(drawback),
      numeroRegistro: numeroRegistro == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroRegistro),
      chaveAcesso: chaveAcesso == null && nullToAbsent
        ? const Value.absent()
        : Value(chaveAcesso),
      quantidade: quantidade == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidade),
    );
  }

  factory NfeExportacao.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeExportacao(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      drawback: serializer.fromJson<int>(json['drawback']),
      numeroRegistro: serializer.fromJson<int>(json['numeroRegistro']),
      chaveAcesso: serializer.fromJson<String>(json['chaveAcesso']),
      quantidade: serializer.fromJson<double>(json['quantidade']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'drawback': serializer.toJson<int?>(drawback),
      'numeroRegistro': serializer.toJson<int?>(numeroRegistro),
      'chaveAcesso': serializer.toJson<String?>(chaveAcesso),
      'quantidade': serializer.toJson<double?>(quantidade),
    };
  }

  NfeExportacao copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          int? drawback,
          int? numeroRegistro,
          String? chaveAcesso,
          double? quantidade,
		}) =>
      NfeExportacao(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        drawback: drawback ?? this.drawback,
        numeroRegistro: numeroRegistro ?? this.numeroRegistro,
        chaveAcesso: chaveAcesso ?? this.chaveAcesso,
        quantidade: quantidade ?? this.quantidade,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeExportacao(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('drawback: $drawback, ')
          ..write('numeroRegistro: $numeroRegistro, ')
          ..write('chaveAcesso: $chaveAcesso, ')
          ..write('quantidade: $quantidade, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      drawback,
      numeroRegistro,
      chaveAcesso,
      quantidade,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeExportacao &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.drawback == drawback &&
          other.numeroRegistro == numeroRegistro &&
          other.chaveAcesso == chaveAcesso &&
          other.quantidade == quantidade 
	   );
}

class NfeExportacaosCompanion extends UpdateCompanion<NfeExportacao> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<int?> drawback;
  final Value<int?> numeroRegistro;
  final Value<String?> chaveAcesso;
  final Value<double?> quantidade;

  const NfeExportacaosCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.drawback = const Value.absent(),
    this.numeroRegistro = const Value.absent(),
    this.chaveAcesso = const Value.absent(),
    this.quantidade = const Value.absent(),
  });

  NfeExportacaosCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.drawback = const Value.absent(),
    this.numeroRegistro = const Value.absent(),
    this.chaveAcesso = const Value.absent(),
    this.quantidade = const Value.absent(),
  });

  static Insertable<NfeExportacao> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<int>? drawback,
    Expression<int>? numeroRegistro,
    Expression<String>? chaveAcesso,
    Expression<double>? quantidade,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (drawback != null) 'DRAWBACK': drawback,
      if (numeroRegistro != null) 'NUMERO_REGISTRO': numeroRegistro,
      if (chaveAcesso != null) 'CHAVE_ACESSO': chaveAcesso,
      if (quantidade != null) 'QUANTIDADE': quantidade,
    });
  }

  NfeExportacaosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<int>? drawback,
      Value<int>? numeroRegistro,
      Value<String>? chaveAcesso,
      Value<double>? quantidade,
	  }) {
    return NfeExportacaosCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      drawback: drawback ?? this.drawback,
      numeroRegistro: numeroRegistro ?? this.numeroRegistro,
      chaveAcesso: chaveAcesso ?? this.chaveAcesso,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeDetalhe.present) {
      map['ID_NFE_DETALHE'] = Variable<int?>(idNfeDetalhe.value);
    }
    if (drawback.present) {
      map['DRAWBACK'] = Variable<int?>(drawback.value);
    }
    if (numeroRegistro.present) {
      map['NUMERO_REGISTRO'] = Variable<int?>(numeroRegistro.value);
    }
    if (chaveAcesso.present) {
      map['CHAVE_ACESSO'] = Variable<String?>(chaveAcesso.value);
    }
    if (quantidade.present) {
      map['QUANTIDADE'] = Variable<double?>(quantidade.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeExportacaosCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('drawback: $drawback, ')
          ..write('numeroRegistro: $numeroRegistro, ')
          ..write('chaveAcesso: $chaveAcesso, ')
          ..write('quantidade: $quantidade, ')
          ..write(')'))
        .toString();
  }
}

class $NfeExportacaosTable extends NfeExportacaos
    with TableInfo<$NfeExportacaosTable, NfeExportacao> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeExportacaosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeDetalheMeta =
      const VerificationMeta('idNfeDetalhe');
  GeneratedColumn<int>? _idNfeDetalhe;
  @override
  GeneratedColumn<int> get idNfeDetalhe =>
      _idNfeDetalhe ??= GeneratedColumn<int>('ID_NFE_DETALHE', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_DETALHE(ID)');
  final VerificationMeta _drawbackMeta =
      const VerificationMeta('drawback');
  GeneratedColumn<int>? _drawback;
  @override
  GeneratedColumn<int> get drawback => _drawback ??=
      GeneratedColumn<int>('DRAWBACK', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _numeroRegistroMeta =
      const VerificationMeta('numeroRegistro');
  GeneratedColumn<int>? _numeroRegistro;
  @override
  GeneratedColumn<int> get numeroRegistro => _numeroRegistro ??=
      GeneratedColumn<int>('NUMERO_REGISTRO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _chaveAcessoMeta =
      const VerificationMeta('chaveAcesso');
  GeneratedColumn<String>? _chaveAcesso;
  @override
  GeneratedColumn<String> get chaveAcesso => _chaveAcesso ??=
      GeneratedColumn<String>('CHAVE_ACESSO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  GeneratedColumn<double>? _quantidade;
  @override
  GeneratedColumn<double> get quantidade => _quantidade ??=
      GeneratedColumn<double>('QUANTIDADE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        drawback,
        numeroRegistro,
        chaveAcesso,
        quantidade,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_EXPORTACAO';
  
  @override
  String get actualTableName => 'NFE_EXPORTACAO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeExportacao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_DETALHE')) {
        context.handle(_idNfeDetalheMeta,
            idNfeDetalhe.isAcceptableOrUnknown(data['ID_NFE_DETALHE']!, _idNfeDetalheMeta));
    }
    if (data.containsKey('DRAWBACK')) {
        context.handle(_drawbackMeta,
            drawback.isAcceptableOrUnknown(data['DRAWBACK']!, _drawbackMeta));
    }
    if (data.containsKey('NUMERO_REGISTRO')) {
        context.handle(_numeroRegistroMeta,
            numeroRegistro.isAcceptableOrUnknown(data['NUMERO_REGISTRO']!, _numeroRegistroMeta));
    }
    if (data.containsKey('CHAVE_ACESSO')) {
        context.handle(_chaveAcessoMeta,
            chaveAcesso.isAcceptableOrUnknown(data['CHAVE_ACESSO']!, _chaveAcessoMeta));
    }
    if (data.containsKey('QUANTIDADE')) {
        context.handle(_quantidadeMeta,
            quantidade.isAcceptableOrUnknown(data['QUANTIDADE']!, _quantidadeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeExportacao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeExportacao.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeExportacaosTable createAlias(String alias) {
    return $NfeExportacaosTable(_db, alias);
  }
}