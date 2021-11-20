/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PRODUTO_FICHA_TECNICA] 
                                                                                
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

@DataClassName("ProdutoFichaTecnica")
@UseRowClass(ProdutoFichaTecnica)
class ProdutoFichaTecnicas extends Table {
  @override
  String get tableName => 'PRODUTO_FICHA_TECNICA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idProduto => integer().named('ID_PRODUTO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO(ID)')();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 50).nullable()();
  IntColumn get idProdutoFilho => integer().named('ID_PRODUTO_FILHO').nullable().customConstraint('NULLABLE REFERENCES PRODUTO_FILHO(ID)')();
  RealColumn get quantidade => real().named('QUANTIDADE').nullable()();
  RealColumn get valorCusto => real().named('VALOR_CUSTO').nullable()();
  RealColumn get percentualCusto => real().named('PERCENTUAL_CUSTO').nullable()();
}

class ProdutoFichaTecnica extends DataClass implements Insertable<ProdutoFichaTecnica> {
  final int? id;
  final int? idProduto;
  final String? descricao;
  final int? idProdutoFilho;
  final double? quantidade;
  final double? valorCusto;
  final double? percentualCusto;

  ProdutoFichaTecnica(
    {
      required this.id,
      this.idProduto,
      this.descricao,
      this.idProdutoFilho,
      this.quantidade,
      this.valorCusto,
      this.percentualCusto,
    }
  );

  factory ProdutoFichaTecnica.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ProdutoFichaTecnica(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idProduto: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
      idProdutoFilho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PRODUTO_FILHO']),
      quantidade: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}QUANTIDADE']),
      valorCusto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_CUSTO']),
      percentualCusto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PERCENTUAL_CUSTO']),
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
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    if (!nullToAbsent || idProdutoFilho != null) {
      map['ID_PRODUTO_FILHO'] = Variable<int?>(idProdutoFilho);
    }
    if (!nullToAbsent || quantidade != null) {
      map['QUANTIDADE'] = Variable<double?>(quantidade);
    }
    if (!nullToAbsent || valorCusto != null) {
      map['VALOR_CUSTO'] = Variable<double?>(valorCusto);
    }
    if (!nullToAbsent || percentualCusto != null) {
      map['PERCENTUAL_CUSTO'] = Variable<double?>(percentualCusto);
    }
    return map;
  }

  ProdutoFichaTecnicasCompanion toCompanion(bool nullToAbsent) {
    return ProdutoFichaTecnicasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idProduto: idProduto == null && nullToAbsent
        ? const Value.absent()
        : Value(idProduto),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
      idProdutoFilho: idProdutoFilho == null && nullToAbsent
        ? const Value.absent()
        : Value(idProdutoFilho),
      quantidade: quantidade == null && nullToAbsent
        ? const Value.absent()
        : Value(quantidade),
      valorCusto: valorCusto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorCusto),
      percentualCusto: percentualCusto == null && nullToAbsent
        ? const Value.absent()
        : Value(percentualCusto),
    );
  }

  factory ProdutoFichaTecnica.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProdutoFichaTecnica(
      id: serializer.fromJson<int>(json['id']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      descricao: serializer.fromJson<String>(json['descricao']),
      idProdutoFilho: serializer.fromJson<int>(json['idProdutoFilho']),
      quantidade: serializer.fromJson<double>(json['quantidade']),
      valorCusto: serializer.fromJson<double>(json['valorCusto']),
      percentualCusto: serializer.fromJson<double>(json['percentualCusto']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idProduto': serializer.toJson<int?>(idProduto),
      'descricao': serializer.toJson<String?>(descricao),
      'idProdutoFilho': serializer.toJson<int?>(idProdutoFilho),
      'quantidade': serializer.toJson<double?>(quantidade),
      'valorCusto': serializer.toJson<double?>(valorCusto),
      'percentualCusto': serializer.toJson<double?>(percentualCusto),
    };
  }

  ProdutoFichaTecnica copyWith(
        {
		  int? id,
          int? idProduto,
          String? descricao,
          int? idProdutoFilho,
          double? quantidade,
          double? valorCusto,
          double? percentualCusto,
		}) =>
      ProdutoFichaTecnica(
        id: id ?? this.id,
        idProduto: idProduto ?? this.idProduto,
        descricao: descricao ?? this.descricao,
        idProdutoFilho: idProdutoFilho ?? this.idProdutoFilho,
        quantidade: quantidade ?? this.quantidade,
        valorCusto: valorCusto ?? this.valorCusto,
        percentualCusto: percentualCusto ?? this.percentualCusto,
      );
  
  @override
  String toString() {
    return (StringBuffer('ProdutoFichaTecnica(')
          ..write('id: $id, ')
          ..write('idProduto: $idProduto, ')
          ..write('descricao: $descricao, ')
          ..write('idProdutoFilho: $idProdutoFilho, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorCusto: $valorCusto, ')
          ..write('percentualCusto: $percentualCusto, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idProduto,
      descricao,
      idProdutoFilho,
      quantidade,
      valorCusto,
      percentualCusto,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdutoFichaTecnica &&
          other.id == id &&
          other.idProduto == idProduto &&
          other.descricao == descricao &&
          other.idProdutoFilho == idProdutoFilho &&
          other.quantidade == quantidade &&
          other.valorCusto == valorCusto &&
          other.percentualCusto == percentualCusto 
	   );
}

class ProdutoFichaTecnicasCompanion extends UpdateCompanion<ProdutoFichaTecnica> {

  final Value<int?> id;
  final Value<int?> idProduto;
  final Value<String?> descricao;
  final Value<int?> idProdutoFilho;
  final Value<double?> quantidade;
  final Value<double?> valorCusto;
  final Value<double?> percentualCusto;

  const ProdutoFichaTecnicasCompanion({
    this.id = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.descricao = const Value.absent(),
    this.idProdutoFilho = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorCusto = const Value.absent(),
    this.percentualCusto = const Value.absent(),
  });

  ProdutoFichaTecnicasCompanion.insert({
    this.id = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.descricao = const Value.absent(),
    this.idProdutoFilho = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.valorCusto = const Value.absent(),
    this.percentualCusto = const Value.absent(),
  });

  static Insertable<ProdutoFichaTecnica> custom({
    Expression<int>? id,
    Expression<int>? idProduto,
    Expression<String>? descricao,
    Expression<int>? idProdutoFilho,
    Expression<double>? quantidade,
    Expression<double>? valorCusto,
    Expression<double>? percentualCusto,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idProduto != null) 'ID_PRODUTO': idProduto,
      if (descricao != null) 'DESCRICAO': descricao,
      if (idProdutoFilho != null) 'ID_PRODUTO_FILHO': idProdutoFilho,
      if (quantidade != null) 'QUANTIDADE': quantidade,
      if (valorCusto != null) 'VALOR_CUSTO': valorCusto,
      if (percentualCusto != null) 'PERCENTUAL_CUSTO': percentualCusto,
    });
  }

  ProdutoFichaTecnicasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idProduto,
      Value<String>? descricao,
      Value<int>? idProdutoFilho,
      Value<double>? quantidade,
      Value<double>? valorCusto,
      Value<double>? percentualCusto,
	  }) {
    return ProdutoFichaTecnicasCompanion(
      id: id ?? this.id,
      idProduto: idProduto ?? this.idProduto,
      descricao: descricao ?? this.descricao,
      idProdutoFilho: idProdutoFilho ?? this.idProdutoFilho,
      quantidade: quantidade ?? this.quantidade,
      valorCusto: valorCusto ?? this.valorCusto,
      percentualCusto: percentualCusto ?? this.percentualCusto,
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
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    if (idProdutoFilho.present) {
      map['ID_PRODUTO_FILHO'] = Variable<int?>(idProdutoFilho.value);
    }
    if (quantidade.present) {
      map['QUANTIDADE'] = Variable<double?>(quantidade.value);
    }
    if (valorCusto.present) {
      map['VALOR_CUSTO'] = Variable<double?>(valorCusto.value);
    }
    if (percentualCusto.present) {
      map['PERCENTUAL_CUSTO'] = Variable<double?>(percentualCusto.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutoFichaTecnicasCompanion(')
          ..write('id: $id, ')
          ..write('idProduto: $idProduto, ')
          ..write('descricao: $descricao, ')
          ..write('idProdutoFilho: $idProdutoFilho, ')
          ..write('quantidade: $quantidade, ')
          ..write('valorCusto: $valorCusto, ')
          ..write('percentualCusto: $percentualCusto, ')
          ..write(')'))
        .toString();
  }
}

class $ProdutoFichaTecnicasTable extends ProdutoFichaTecnicas
    with TableInfo<$ProdutoFichaTecnicasTable, ProdutoFichaTecnica> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProdutoFichaTecnicasTable(this._db, [this._alias]);
  
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
  final VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  GeneratedColumn<String>? _descricao;
  @override
  GeneratedColumn<String> get descricao => _descricao ??=
      GeneratedColumn<String>('DESCRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _idProdutoFilhoMeta =
      const VerificationMeta('idProdutoFilho');
  GeneratedColumn<int>? _idProdutoFilho;
  @override
  GeneratedColumn<int> get idProdutoFilho =>
      _idProdutoFilho ??= GeneratedColumn<int>('ID_PRODUTO_FILHO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PRODUTO_FILHO(ID)');
  final VerificationMeta _quantidadeMeta =
      const VerificationMeta('quantidade');
  GeneratedColumn<double>? _quantidade;
  @override
  GeneratedColumn<double> get quantidade => _quantidade ??=
      GeneratedColumn<double>('QUANTIDADE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorCustoMeta =
      const VerificationMeta('valorCusto');
  GeneratedColumn<double>? _valorCusto;
  @override
  GeneratedColumn<double> get valorCusto => _valorCusto ??=
      GeneratedColumn<double>('VALOR_CUSTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _percentualCustoMeta =
      const VerificationMeta('percentualCusto');
  GeneratedColumn<double>? _percentualCusto;
  @override
  GeneratedColumn<double> get percentualCusto => _percentualCusto ??=
      GeneratedColumn<double>('PERCENTUAL_CUSTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idProduto,
        descricao,
        idProdutoFilho,
        quantidade,
        valorCusto,
        percentualCusto,
      ];

  @override
  String get aliasedName => _alias ?? 'PRODUTO_FICHA_TECNICA';
  
  @override
  String get actualTableName => 'PRODUTO_FICHA_TECNICA';
  
  @override
  VerificationContext validateIntegrity(Insertable<ProdutoFichaTecnica> instance,
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
    if (data.containsKey('DESCRICAO')) {
        context.handle(_descricaoMeta,
            descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
    }
    if (data.containsKey('ID_PRODUTO_FILHO')) {
        context.handle(_idProdutoFilhoMeta,
            idProdutoFilho.isAcceptableOrUnknown(data['ID_PRODUTO_FILHO']!, _idProdutoFilhoMeta));
    }
    if (data.containsKey('QUANTIDADE')) {
        context.handle(_quantidadeMeta,
            quantidade.isAcceptableOrUnknown(data['QUANTIDADE']!, _quantidadeMeta));
    }
    if (data.containsKey('VALOR_CUSTO')) {
        context.handle(_valorCustoMeta,
            valorCusto.isAcceptableOrUnknown(data['VALOR_CUSTO']!, _valorCustoMeta));
    }
    if (data.containsKey('PERCENTUAL_CUSTO')) {
        context.handle(_percentualCustoMeta,
            percentualCusto.isAcceptableOrUnknown(data['PERCENTUAL_CUSTO']!, _percentualCustoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProdutoFichaTecnica map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ProdutoFichaTecnica.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ProdutoFichaTecnicasTable createAlias(String alias) {
    return $ProdutoFichaTecnicasTable(_db, alias);
  }
}