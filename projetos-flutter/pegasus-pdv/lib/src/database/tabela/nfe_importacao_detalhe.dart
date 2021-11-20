/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_IMPORTACAO_DETALHE] 
                                                                                
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

@DataClassName("NfeImportacaoDetalhe")
@UseRowClass(NfeImportacaoDetalhe)
class NfeImportacaoDetalhes extends Table {
  @override
  String get tableName => 'NFE_IMPORTACAO_DETALHE';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDeclaracaoImportacao => integer().named('ID_NFE_DECLARACAO_IMPORTACAO').nullable().customConstraint('NULLABLE REFERENCES NFE_DECLARACAO_IMPORTACAO(ID)')();
  IntColumn get numeroAdicao => integer().named('NUMERO_ADICAO').nullable()();
  IntColumn get numeroSequencial => integer().named('NUMERO_SEQUENCIAL').nullable()();
  TextColumn get codigoFabricanteEstrangeiro => text().named('CODIGO_FABRICANTE_ESTRANGEIRO').withLength(min: 0, max: 60).nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  IntColumn get drawback => integer().named('DRAWBACK').nullable()();
}

class NfeImportacaoDetalhe extends DataClass implements Insertable<NfeImportacaoDetalhe> {
  final int? id;
  final int? idNfeDeclaracaoImportacao;
  final int? numeroAdicao;
  final int? numeroSequencial;
  final String? codigoFabricanteEstrangeiro;
  final double? valorDesconto;
  final int? drawback;

  NfeImportacaoDetalhe(
    {
      required this.id,
      this.idNfeDeclaracaoImportacao,
      this.numeroAdicao,
      this.numeroSequencial,
      this.codigoFabricanteEstrangeiro,
      this.valorDesconto,
      this.drawback,
    }
  );

  factory NfeImportacaoDetalhe.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeImportacaoDetalhe(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDeclaracaoImportacao: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DECLARACAO_IMPORTACAO']),
      numeroAdicao: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_ADICAO']),
      numeroSequencial: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_SEQUENCIAL']),
      codigoFabricanteEstrangeiro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_FABRICANTE_ESTRANGEIRO']),
      valorDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DESCONTO']),
      drawback: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}DRAWBACK']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeDeclaracaoImportacao != null) {
      map['ID_NFE_DECLARACAO_IMPORTACAO'] = Variable<int?>(idNfeDeclaracaoImportacao);
    }
    if (!nullToAbsent || numeroAdicao != null) {
      map['NUMERO_ADICAO'] = Variable<int?>(numeroAdicao);
    }
    if (!nullToAbsent || numeroSequencial != null) {
      map['NUMERO_SEQUENCIAL'] = Variable<int?>(numeroSequencial);
    }
    if (!nullToAbsent || codigoFabricanteEstrangeiro != null) {
      map['CODIGO_FABRICANTE_ESTRANGEIRO'] = Variable<String?>(codigoFabricanteEstrangeiro);
    }
    if (!nullToAbsent || valorDesconto != null) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto);
    }
    if (!nullToAbsent || drawback != null) {
      map['DRAWBACK'] = Variable<int?>(drawback);
    }
    return map;
  }

  NfeImportacaoDetalhesCompanion toCompanion(bool nullToAbsent) {
    return NfeImportacaoDetalhesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDeclaracaoImportacao: idNfeDeclaracaoImportacao == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDeclaracaoImportacao),
      numeroAdicao: numeroAdicao == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroAdicao),
      numeroSequencial: numeroSequencial == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroSequencial),
      codigoFabricanteEstrangeiro: codigoFabricanteEstrangeiro == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoFabricanteEstrangeiro),
      valorDesconto: valorDesconto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDesconto),
      drawback: drawback == null && nullToAbsent
        ? const Value.absent()
        : Value(drawback),
    );
  }

  factory NfeImportacaoDetalhe.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeImportacaoDetalhe(
      id: serializer.fromJson<int>(json['id']),
      idNfeDeclaracaoImportacao: serializer.fromJson<int>(json['idNfeDeclaracaoImportacao']),
      numeroAdicao: serializer.fromJson<int>(json['numeroAdicao']),
      numeroSequencial: serializer.fromJson<int>(json['numeroSequencial']),
      codigoFabricanteEstrangeiro: serializer.fromJson<String>(json['codigoFabricanteEstrangeiro']),
      valorDesconto: serializer.fromJson<double>(json['valorDesconto']),
      drawback: serializer.fromJson<int>(json['drawback']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDeclaracaoImportacao': serializer.toJson<int?>(idNfeDeclaracaoImportacao),
      'numeroAdicao': serializer.toJson<int?>(numeroAdicao),
      'numeroSequencial': serializer.toJson<int?>(numeroSequencial),
      'codigoFabricanteEstrangeiro': serializer.toJson<String?>(codigoFabricanteEstrangeiro),
      'valorDesconto': serializer.toJson<double?>(valorDesconto),
      'drawback': serializer.toJson<int?>(drawback),
    };
  }

  NfeImportacaoDetalhe copyWith(
        {
		  int? id,
          int? idNfeDeclaracaoImportacao,
          int? numeroAdicao,
          int? numeroSequencial,
          String? codigoFabricanteEstrangeiro,
          double? valorDesconto,
          int? drawback,
		}) =>
      NfeImportacaoDetalhe(
        id: id ?? this.id,
        idNfeDeclaracaoImportacao: idNfeDeclaracaoImportacao ?? this.idNfeDeclaracaoImportacao,
        numeroAdicao: numeroAdicao ?? this.numeroAdicao,
        numeroSequencial: numeroSequencial ?? this.numeroSequencial,
        codigoFabricanteEstrangeiro: codigoFabricanteEstrangeiro ?? this.codigoFabricanteEstrangeiro,
        valorDesconto: valorDesconto ?? this.valorDesconto,
        drawback: drawback ?? this.drawback,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeImportacaoDetalhe(')
          ..write('id: $id, ')
          ..write('idNfeDeclaracaoImportacao: $idNfeDeclaracaoImportacao, ')
          ..write('numeroAdicao: $numeroAdicao, ')
          ..write('numeroSequencial: $numeroSequencial, ')
          ..write('codigoFabricanteEstrangeiro: $codigoFabricanteEstrangeiro, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('drawback: $drawback, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDeclaracaoImportacao,
      numeroAdicao,
      numeroSequencial,
      codigoFabricanteEstrangeiro,
      valorDesconto,
      drawback,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeImportacaoDetalhe &&
          other.id == id &&
          other.idNfeDeclaracaoImportacao == idNfeDeclaracaoImportacao &&
          other.numeroAdicao == numeroAdicao &&
          other.numeroSequencial == numeroSequencial &&
          other.codigoFabricanteEstrangeiro == codigoFabricanteEstrangeiro &&
          other.valorDesconto == valorDesconto &&
          other.drawback == drawback 
	   );
}

class NfeImportacaoDetalhesCompanion extends UpdateCompanion<NfeImportacaoDetalhe> {

  final Value<int?> id;
  final Value<int?> idNfeDeclaracaoImportacao;
  final Value<int?> numeroAdicao;
  final Value<int?> numeroSequencial;
  final Value<String?> codigoFabricanteEstrangeiro;
  final Value<double?> valorDesconto;
  final Value<int?> drawback;

  const NfeImportacaoDetalhesCompanion({
    this.id = const Value.absent(),
    this.idNfeDeclaracaoImportacao = const Value.absent(),
    this.numeroAdicao = const Value.absent(),
    this.numeroSequencial = const Value.absent(),
    this.codigoFabricanteEstrangeiro = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.drawback = const Value.absent(),
  });

  NfeImportacaoDetalhesCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDeclaracaoImportacao = const Value.absent(),
    this.numeroAdicao = const Value.absent(),
    this.numeroSequencial = const Value.absent(),
    this.codigoFabricanteEstrangeiro = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.drawback = const Value.absent(),
  });

  static Insertable<NfeImportacaoDetalhe> custom({
    Expression<int>? id,
    Expression<int>? idNfeDeclaracaoImportacao,
    Expression<int>? numeroAdicao,
    Expression<int>? numeroSequencial,
    Expression<String>? codigoFabricanteEstrangeiro,
    Expression<double>? valorDesconto,
    Expression<int>? drawback,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDeclaracaoImportacao != null) 'ID_NFE_DECLARACAO_IMPORTACAO': idNfeDeclaracaoImportacao,
      if (numeroAdicao != null) 'NUMERO_ADICAO': numeroAdicao,
      if (numeroSequencial != null) 'NUMERO_SEQUENCIAL': numeroSequencial,
      if (codigoFabricanteEstrangeiro != null) 'CODIGO_FABRICANTE_ESTRANGEIRO': codigoFabricanteEstrangeiro,
      if (valorDesconto != null) 'VALOR_DESCONTO': valorDesconto,
      if (drawback != null) 'DRAWBACK': drawback,
    });
  }

  NfeImportacaoDetalhesCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDeclaracaoImportacao,
      Value<int>? numeroAdicao,
      Value<int>? numeroSequencial,
      Value<String>? codigoFabricanteEstrangeiro,
      Value<double>? valorDesconto,
      Value<int>? drawback,
	  }) {
    return NfeImportacaoDetalhesCompanion(
      id: id ?? this.id,
      idNfeDeclaracaoImportacao: idNfeDeclaracaoImportacao ?? this.idNfeDeclaracaoImportacao,
      numeroAdicao: numeroAdicao ?? this.numeroAdicao,
      numeroSequencial: numeroSequencial ?? this.numeroSequencial,
      codigoFabricanteEstrangeiro: codigoFabricanteEstrangeiro ?? this.codigoFabricanteEstrangeiro,
      valorDesconto: valorDesconto ?? this.valorDesconto,
      drawback: drawback ?? this.drawback,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeDeclaracaoImportacao.present) {
      map['ID_NFE_DECLARACAO_IMPORTACAO'] = Variable<int?>(idNfeDeclaracaoImportacao.value);
    }
    if (numeroAdicao.present) {
      map['NUMERO_ADICAO'] = Variable<int?>(numeroAdicao.value);
    }
    if (numeroSequencial.present) {
      map['NUMERO_SEQUENCIAL'] = Variable<int?>(numeroSequencial.value);
    }
    if (codigoFabricanteEstrangeiro.present) {
      map['CODIGO_FABRICANTE_ESTRANGEIRO'] = Variable<String?>(codigoFabricanteEstrangeiro.value);
    }
    if (valorDesconto.present) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto.value);
    }
    if (drawback.present) {
      map['DRAWBACK'] = Variable<int?>(drawback.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeImportacaoDetalhesCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDeclaracaoImportacao: $idNfeDeclaracaoImportacao, ')
          ..write('numeroAdicao: $numeroAdicao, ')
          ..write('numeroSequencial: $numeroSequencial, ')
          ..write('codigoFabricanteEstrangeiro: $codigoFabricanteEstrangeiro, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('drawback: $drawback, ')
          ..write(')'))
        .toString();
  }
}

class $NfeImportacaoDetalhesTable extends NfeImportacaoDetalhes
    with TableInfo<$NfeImportacaoDetalhesTable, NfeImportacaoDetalhe> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeImportacaoDetalhesTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeDeclaracaoImportacaoMeta =
      const VerificationMeta('idNfeDeclaracaoImportacao');
  GeneratedColumn<int>? _idNfeDeclaracaoImportacao;
  @override
  GeneratedColumn<int> get idNfeDeclaracaoImportacao =>
      _idNfeDeclaracaoImportacao ??= GeneratedColumn<int>('ID_NFE_DECLARACAO_IMPORTACAO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_DECLARACAO_IMPORTACAO(ID)');
  final VerificationMeta _numeroAdicaoMeta =
      const VerificationMeta('numeroAdicao');
  GeneratedColumn<int>? _numeroAdicao;
  @override
  GeneratedColumn<int> get numeroAdicao => _numeroAdicao ??=
      GeneratedColumn<int>('NUMERO_ADICAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _numeroSequencialMeta =
      const VerificationMeta('numeroSequencial');
  GeneratedColumn<int>? _numeroSequencial;
  @override
  GeneratedColumn<int> get numeroSequencial => _numeroSequencial ??=
      GeneratedColumn<int>('NUMERO_SEQUENCIAL', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _codigoFabricanteEstrangeiroMeta =
      const VerificationMeta('codigoFabricanteEstrangeiro');
  GeneratedColumn<String>? _codigoFabricanteEstrangeiro;
  @override
  GeneratedColumn<String> get codigoFabricanteEstrangeiro => _codigoFabricanteEstrangeiro ??=
      GeneratedColumn<String>('CODIGO_FABRICANTE_ESTRANGEIRO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorDescontoMeta =
      const VerificationMeta('valorDesconto');
  GeneratedColumn<double>? _valorDesconto;
  @override
  GeneratedColumn<double> get valorDesconto => _valorDesconto ??=
      GeneratedColumn<double>('VALOR_DESCONTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _drawbackMeta =
      const VerificationMeta('drawback');
  GeneratedColumn<int>? _drawback;
  @override
  GeneratedColumn<int> get drawback => _drawback ??=
      GeneratedColumn<int>('DRAWBACK', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDeclaracaoImportacao,
        numeroAdicao,
        numeroSequencial,
        codigoFabricanteEstrangeiro,
        valorDesconto,
        drawback,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_IMPORTACAO_DETALHE';
  
  @override
  String get actualTableName => 'NFE_IMPORTACAO_DETALHE';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeImportacaoDetalhe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_DECLARACAO_IMPORTACAO')) {
        context.handle(_idNfeDeclaracaoImportacaoMeta,
            idNfeDeclaracaoImportacao.isAcceptableOrUnknown(data['ID_NFE_DECLARACAO_IMPORTACAO']!, _idNfeDeclaracaoImportacaoMeta));
    }
    if (data.containsKey('NUMERO_ADICAO')) {
        context.handle(_numeroAdicaoMeta,
            numeroAdicao.isAcceptableOrUnknown(data['NUMERO_ADICAO']!, _numeroAdicaoMeta));
    }
    if (data.containsKey('NUMERO_SEQUENCIAL')) {
        context.handle(_numeroSequencialMeta,
            numeroSequencial.isAcceptableOrUnknown(data['NUMERO_SEQUENCIAL']!, _numeroSequencialMeta));
    }
    if (data.containsKey('CODIGO_FABRICANTE_ESTRANGEIRO')) {
        context.handle(_codigoFabricanteEstrangeiroMeta,
            codigoFabricanteEstrangeiro.isAcceptableOrUnknown(data['CODIGO_FABRICANTE_ESTRANGEIRO']!, _codigoFabricanteEstrangeiroMeta));
    }
    if (data.containsKey('VALOR_DESCONTO')) {
        context.handle(_valorDescontoMeta,
            valorDesconto.isAcceptableOrUnknown(data['VALOR_DESCONTO']!, _valorDescontoMeta));
    }
    if (data.containsKey('DRAWBACK')) {
        context.handle(_drawbackMeta,
            drawback.isAcceptableOrUnknown(data['DRAWBACK']!, _drawbackMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeImportacaoDetalhe map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeImportacaoDetalhe.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeImportacaoDetalhesTable createAlias(String alias) {
    return $NfeImportacaoDetalhesTable(_db, alias);
  }
}