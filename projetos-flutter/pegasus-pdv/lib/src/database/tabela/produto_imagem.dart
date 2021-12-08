/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PRODUTO_IMAGEM] 
                                                                                
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

@DataClassName("ProdutoImagem")
@UseRowClass(ProdutoImagem)
class ProdutoImagems extends Table {
  @override
  String get tableName => 'PRODUTO_IMAGEM';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idProduto => integer().named('ID_PRODUTO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO(ID)')();
  BlobColumn get imagem => blob().named('IMAGEM').nullable()();
}

class ProdutoImagem extends DataClass implements Insertable<ProdutoImagem> {
  final int? id;
  final int? idProduto;
  final Uint8List? imagem;

  ProdutoImagem(
    {
      required this.id,
      this.idProduto,
      this.imagem,
    }
  );

  factory ProdutoImagem.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProdutoImagem(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idProduto: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO']),
      imagem: const BlobType().mapFromDatabaseResponse(data['${effectivePrefix}IMAGEM']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idProduto != null) {
      map['ID_PRODUTO'] = Variable<int?>(idProduto);
    }
    if (!nullToAbsent || imagem != null) {
      map['IMAGEM'] = Variable<Uint8List?>(imagem);
    }
    return map;
  }

  ProdutoImagemsCompanion toCompanion(bool nullToAbsent) {
    return ProdutoImagemsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idProduto: idProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(idProduto),
      imagem: imagem == null && nullToAbsent
        ? const Value.absent()
        : Value(imagem),
    );
  }

  factory ProdutoImagem.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProdutoImagem(
      id: serializer.fromJson<int>(json['id']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      imagem: serializer.fromJson<Uint8List>(json['imagem']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idProduto': serializer.toJson<int?>(idProduto),
      'imagem': serializer.toJson<Uint8List?>(imagem),
    };
  }

  ProdutoImagem copyWith(
        {
		  int? id,
          int? idProduto,
          Uint8List? imagem,
		}) =>
      ProdutoImagem(
        id: id ?? this.id,
        idProduto: idProduto ?? this.idProduto,
        imagem: imagem ?? this.imagem,
      );
  
  @override
  String toString() {
    return (StringBuffer('ProdutoImagem(')
          ..write('id: $id, ')
          ..write('idProduto: $idProduto, ')
          ..write('imagem: $imagem, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idProduto,
      imagem,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdutoImagem &&
          other.id == id &&
          other.idProduto == idProduto &&
          other.imagem == imagem 
	   );
}

class ProdutoImagemsCompanion extends UpdateCompanion<ProdutoImagem> {

  final Value<int?> id;
  final Value<int?> idProduto;
  final Value<Uint8List?> imagem;

  const ProdutoImagemsCompanion({
    this.id = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.imagem = const Value.absent(),
  });

  ProdutoImagemsCompanion.insert({
    this.id = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.imagem = const Value.absent(),
  });

  static Insertable<ProdutoImagem> custom({
    Expression<int>? id,
    Expression<int>? idProduto,
    Expression<Uint8List>? imagem,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idProduto != null) 'ID_PRODUTO': idProduto,
      if (imagem != null) 'IMAGEM': imagem,
    });
  }

  ProdutoImagemsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idProduto,
      Value<Uint8List>? imagem,
	  }) {
    return ProdutoImagemsCompanion(
      id: id ?? this.id,
      idProduto: idProduto ?? this.idProduto,
      imagem: imagem ?? this.imagem,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idProduto.present) {
      map['ID_PRODUTO'] = Variable<int?>(idProduto.value);
    }
    if (imagem.present) {
      map['IMAGEM'] = Variable<Uint8List?>(imagem.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutoImagemsCompanion(')
          ..write('id: $id, ')
          ..write('idProduto: $idProduto, ')
          ..write('imagem: $imagem, ')
          ..write(')'))
        .toString();
  }
}

class $ProdutoImagemsTable extends ProdutoImagems
    with TableInfo<$ProdutoImagemsTable, ProdutoImagem> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProdutoImagemsTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idProdutoMeta =
      const VerificationMeta('idProduto');
  GeneratedColumn<int>? _idProduto;
  @override
  GeneratedColumn<int> get idProduto =>
      _idProduto ??= GeneratedColumn<int>('ID_PRODUTO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PRODUTO(ID)');
  final VerificationMeta _imagemMeta =
      const VerificationMeta('imagem');
  GeneratedColumn<Uint8List>? _imagem;
  @override
  GeneratedColumn<Uint8List> get imagem => _imagem ??=
      GeneratedColumn<Uint8List>('IMAGEM', aliasedName, true,
          typeName: 'BLOB', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idProduto,
        imagem,
      ];

  @override
  String get aliasedName => _alias ?? 'PRODUTO_IMAGEM';
  
  @override
  String get actualTableName => 'PRODUTO_IMAGEM';
  
  @override
  VerificationContext validateIntegrity(Insertable<ProdutoImagem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_PRODUTO')) {
        context.handle(_idProdutoMeta,
            idProduto.isAcceptableOrUnknown(data['ID_PRODUTO']!, _idProdutoMeta));
    }
    if (data.containsKey('IMAGEM')) {
        context.handle(_imagemMeta,
            imagem.isAcceptableOrUnknown(data['IMAGEM']!, _imagemMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProdutoImagem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProdutoImagem.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProdutoImagemsTable createAlias(String alias) {
    return $ProdutoImagemsTable(_db, alias);
  }
}