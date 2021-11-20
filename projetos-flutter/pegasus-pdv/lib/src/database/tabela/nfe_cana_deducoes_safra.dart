/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_CANA_DEDUCOES_SAFRA] 
                                                                                
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

@DataClassName("NfeCanaDeducoesSafra")
@UseRowClass(NfeCanaDeducoesSafra)
class NfeCanaDeducoesSafras extends Table {
  @override
  String get tableName => 'NFE_CANA_DEDUCOES_SAFRA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCana => integer().named('ID_NFE_CANA').nullable().customConstraint('NULLABLE REFERENCES NFE_CANA(ID)')();
  TextColumn get decricao => text().named('DECRICAO').withLength(min: 0, max: 60).nullable()();
  RealColumn get valorDeducao => real().named('VALOR_DEDUCAO').nullable()();
  RealColumn get valorFornecimento => real().named('VALOR_FORNECIMENTO').nullable()();
  RealColumn get valorTotalDeducao => real().named('VALOR_TOTAL_DEDUCAO').nullable()();
  RealColumn get valorLiquidoFornecimento => real().named('VALOR_LIQUIDO_FORNECIMENTO').nullable()();
}

class NfeCanaDeducoesSafra extends DataClass implements Insertable<NfeCanaDeducoesSafra> {
  final int? id;
  final int? idNfeCana;
  final String? decricao;
  final double? valorDeducao;
  final double? valorFornecimento;
  final double? valorTotalDeducao;
  final double? valorLiquidoFornecimento;

  NfeCanaDeducoesSafra(
    {
      required this.id,
      this.idNfeCana,
      this.decricao,
      this.valorDeducao,
      this.valorFornecimento,
      this.valorTotalDeducao,
      this.valorLiquidoFornecimento,
    }
  );

  factory NfeCanaDeducoesSafra.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeCanaDeducoesSafra(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCana: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CANA']),
      decricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DECRICAO']),
      valorDeducao: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DEDUCAO']),
      valorFornecimento: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_FORNECIMENTO']),
      valorTotalDeducao: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_TOTAL_DEDUCAO']),
      valorLiquidoFornecimento: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_LIQUIDO_FORNECIMENTO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeCana != null) {
      map['ID_NFE_CANA'] = Variable<int?>(idNfeCana);
    }
    if (!nullToAbsent || decricao != null) {
      map['DECRICAO'] = Variable<String?>(decricao);
    }
    if (!nullToAbsent || valorDeducao != null) {
      map['VALOR_DEDUCAO'] = Variable<double?>(valorDeducao);
    }
    if (!nullToAbsent || valorFornecimento != null) {
      map['VALOR_FORNECIMENTO'] = Variable<double?>(valorFornecimento);
    }
    if (!nullToAbsent || valorTotalDeducao != null) {
      map['VALOR_TOTAL_DEDUCAO'] = Variable<double?>(valorTotalDeducao);
    }
    if (!nullToAbsent || valorLiquidoFornecimento != null) {
      map['VALOR_LIQUIDO_FORNECIMENTO'] = Variable<double?>(valorLiquidoFornecimento);
    }
    return map;
  }

  NfeCanaDeducoesSafrasCompanion toCompanion(bool nullToAbsent) {
    return NfeCanaDeducoesSafrasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCana: idNfeCana == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCana),
      decricao: decricao == null && nullToAbsent
        ? const Value.absent()
        : Value(decricao),
      valorDeducao: valorDeducao == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDeducao),
      valorFornecimento: valorFornecimento == null && nullToAbsent
        ? const Value.absent()
        : Value(valorFornecimento),
      valorTotalDeducao: valorTotalDeducao == null && nullToAbsent
        ? const Value.absent()
        : Value(valorTotalDeducao),
      valorLiquidoFornecimento: valorLiquidoFornecimento == null && nullToAbsent
        ? const Value.absent()
        : Value(valorLiquidoFornecimento),
    );
  }

  factory NfeCanaDeducoesSafra.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeCanaDeducoesSafra(
      id: serializer.fromJson<int>(json['id']),
      idNfeCana: serializer.fromJson<int>(json['idNfeCana']),
      decricao: serializer.fromJson<String>(json['decricao']),
      valorDeducao: serializer.fromJson<double>(json['valorDeducao']),
      valorFornecimento: serializer.fromJson<double>(json['valorFornecimento']),
      valorTotalDeducao: serializer.fromJson<double>(json['valorTotalDeducao']),
      valorLiquidoFornecimento: serializer.fromJson<double>(json['valorLiquidoFornecimento']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCana': serializer.toJson<int?>(idNfeCana),
      'decricao': serializer.toJson<String?>(decricao),
      'valorDeducao': serializer.toJson<double?>(valorDeducao),
      'valorFornecimento': serializer.toJson<double?>(valorFornecimento),
      'valorTotalDeducao': serializer.toJson<double?>(valorTotalDeducao),
      'valorLiquidoFornecimento': serializer.toJson<double?>(valorLiquidoFornecimento),
    };
  }

  NfeCanaDeducoesSafra copyWith(
        {
		  int? id,
          int? idNfeCana,
          String? decricao,
          double? valorDeducao,
          double? valorFornecimento,
          double? valorTotalDeducao,
          double? valorLiquidoFornecimento,
		}) =>
      NfeCanaDeducoesSafra(
        id: id ?? this.id,
        idNfeCana: idNfeCana ?? this.idNfeCana,
        decricao: decricao ?? this.decricao,
        valorDeducao: valorDeducao ?? this.valorDeducao,
        valorFornecimento: valorFornecimento ?? this.valorFornecimento,
        valorTotalDeducao: valorTotalDeducao ?? this.valorTotalDeducao,
        valorLiquidoFornecimento: valorLiquidoFornecimento ?? this.valorLiquidoFornecimento,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeCanaDeducoesSafra(')
          ..write('id: $id, ')
          ..write('idNfeCana: $idNfeCana, ')
          ..write('decricao: $decricao, ')
          ..write('valorDeducao: $valorDeducao, ')
          ..write('valorFornecimento: $valorFornecimento, ')
          ..write('valorTotalDeducao: $valorTotalDeducao, ')
          ..write('valorLiquidoFornecimento: $valorLiquidoFornecimento, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCana,
      decricao,
      valorDeducao,
      valorFornecimento,
      valorTotalDeducao,
      valorLiquidoFornecimento,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeCanaDeducoesSafra &&
          other.id == id &&
          other.idNfeCana == idNfeCana &&
          other.decricao == decricao &&
          other.valorDeducao == valorDeducao &&
          other.valorFornecimento == valorFornecimento &&
          other.valorTotalDeducao == valorTotalDeducao &&
          other.valorLiquidoFornecimento == valorLiquidoFornecimento 
	   );
}

class NfeCanaDeducoesSafrasCompanion extends UpdateCompanion<NfeCanaDeducoesSafra> {

  final Value<int?> id;
  final Value<int?> idNfeCana;
  final Value<String?> decricao;
  final Value<double?> valorDeducao;
  final Value<double?> valorFornecimento;
  final Value<double?> valorTotalDeducao;
  final Value<double?> valorLiquidoFornecimento;

  const NfeCanaDeducoesSafrasCompanion({
    this.id = const Value.absent(),
    this.idNfeCana = const Value.absent(),
    this.decricao = const Value.absent(),
    this.valorDeducao = const Value.absent(),
    this.valorFornecimento = const Value.absent(),
    this.valorTotalDeducao = const Value.absent(),
    this.valorLiquidoFornecimento = const Value.absent(),
  });

  NfeCanaDeducoesSafrasCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCana = const Value.absent(),
    this.decricao = const Value.absent(),
    this.valorDeducao = const Value.absent(),
    this.valorFornecimento = const Value.absent(),
    this.valorTotalDeducao = const Value.absent(),
    this.valorLiquidoFornecimento = const Value.absent(),
  });

  static Insertable<NfeCanaDeducoesSafra> custom({
    Expression<int>? id,
    Expression<int>? idNfeCana,
    Expression<String>? decricao,
    Expression<double>? valorDeducao,
    Expression<double>? valorFornecimento,
    Expression<double>? valorTotalDeducao,
    Expression<double>? valorLiquidoFornecimento,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCana != null) 'ID_NFE_CANA': idNfeCana,
      if (decricao != null) 'DECRICAO': decricao,
      if (valorDeducao != null) 'VALOR_DEDUCAO': valorDeducao,
      if (valorFornecimento != null) 'VALOR_FORNECIMENTO': valorFornecimento,
      if (valorTotalDeducao != null) 'VALOR_TOTAL_DEDUCAO': valorTotalDeducao,
      if (valorLiquidoFornecimento != null) 'VALOR_LIQUIDO_FORNECIMENTO': valorLiquidoFornecimento,
    });
  }

  NfeCanaDeducoesSafrasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCana,
      Value<String>? decricao,
      Value<double>? valorDeducao,
      Value<double>? valorFornecimento,
      Value<double>? valorTotalDeducao,
      Value<double>? valorLiquidoFornecimento,
	  }) {
    return NfeCanaDeducoesSafrasCompanion(
      id: id ?? this.id,
      idNfeCana: idNfeCana ?? this.idNfeCana,
      decricao: decricao ?? this.decricao,
      valorDeducao: valorDeducao ?? this.valorDeducao,
      valorFornecimento: valorFornecimento ?? this.valorFornecimento,
      valorTotalDeducao: valorTotalDeducao ?? this.valorTotalDeducao,
      valorLiquidoFornecimento: valorLiquidoFornecimento ?? this.valorLiquidoFornecimento,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeCana.present) {
      map['ID_NFE_CANA'] = Variable<int?>(idNfeCana.value);
    }
    if (decricao.present) {
      map['DECRICAO'] = Variable<String?>(decricao.value);
    }
    if (valorDeducao.present) {
      map['VALOR_DEDUCAO'] = Variable<double?>(valorDeducao.value);
    }
    if (valorFornecimento.present) {
      map['VALOR_FORNECIMENTO'] = Variable<double?>(valorFornecimento.value);
    }
    if (valorTotalDeducao.present) {
      map['VALOR_TOTAL_DEDUCAO'] = Variable<double?>(valorTotalDeducao.value);
    }
    if (valorLiquidoFornecimento.present) {
      map['VALOR_LIQUIDO_FORNECIMENTO'] = Variable<double?>(valorLiquidoFornecimento.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeCanaDeducoesSafrasCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCana: $idNfeCana, ')
          ..write('decricao: $decricao, ')
          ..write('valorDeducao: $valorDeducao, ')
          ..write('valorFornecimento: $valorFornecimento, ')
          ..write('valorTotalDeducao: $valorTotalDeducao, ')
          ..write('valorLiquidoFornecimento: $valorLiquidoFornecimento, ')
          ..write(')'))
        .toString();
  }
}

class $NfeCanaDeducoesSafrasTable extends NfeCanaDeducoesSafras
    with TableInfo<$NfeCanaDeducoesSafrasTable, NfeCanaDeducoesSafra> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeCanaDeducoesSafrasTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeCanaMeta =
      const VerificationMeta('idNfeCana');
  GeneratedColumn<int>? _idNfeCana;
  @override
  GeneratedColumn<int> get idNfeCana =>
      _idNfeCana ??= GeneratedColumn<int>('ID_NFE_CANA', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_CANA(ID)');
  final VerificationMeta _decricaoMeta =
      const VerificationMeta('decricao');
  GeneratedColumn<String>? _decricao;
  @override
  GeneratedColumn<String> get decricao => _decricao ??=
      GeneratedColumn<String>('DECRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorDeducaoMeta =
      const VerificationMeta('valorDeducao');
  GeneratedColumn<double>? _valorDeducao;
  @override
  GeneratedColumn<double> get valorDeducao => _valorDeducao ??=
      GeneratedColumn<double>('VALOR_DEDUCAO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorFornecimentoMeta =
      const VerificationMeta('valorFornecimento');
  GeneratedColumn<double>? _valorFornecimento;
  @override
  GeneratedColumn<double> get valorFornecimento => _valorFornecimento ??=
      GeneratedColumn<double>('VALOR_FORNECIMENTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorTotalDeducaoMeta =
      const VerificationMeta('valorTotalDeducao');
  GeneratedColumn<double>? _valorTotalDeducao;
  @override
  GeneratedColumn<double> get valorTotalDeducao => _valorTotalDeducao ??=
      GeneratedColumn<double>('VALOR_TOTAL_DEDUCAO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorLiquidoFornecimentoMeta =
      const VerificationMeta('valorLiquidoFornecimento');
  GeneratedColumn<double>? _valorLiquidoFornecimento;
  @override
  GeneratedColumn<double> get valorLiquidoFornecimento => _valorLiquidoFornecimento ??=
      GeneratedColumn<double>('VALOR_LIQUIDO_FORNECIMENTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCana,
        decricao,
        valorDeducao,
        valorFornecimento,
        valorTotalDeducao,
        valorLiquidoFornecimento,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_CANA_DEDUCOES_SAFRA';
  
  @override
  String get actualTableName => 'NFE_CANA_DEDUCOES_SAFRA';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeCanaDeducoesSafra> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_CANA')) {
        context.handle(_idNfeCanaMeta,
            idNfeCana.isAcceptableOrUnknown(data['ID_NFE_CANA']!, _idNfeCanaMeta));
    }
    if (data.containsKey('DECRICAO')) {
        context.handle(_decricaoMeta,
            decricao.isAcceptableOrUnknown(data['DECRICAO']!, _decricaoMeta));
    }
    if (data.containsKey('VALOR_DEDUCAO')) {
        context.handle(_valorDeducaoMeta,
            valorDeducao.isAcceptableOrUnknown(data['VALOR_DEDUCAO']!, _valorDeducaoMeta));
    }
    if (data.containsKey('VALOR_FORNECIMENTO')) {
        context.handle(_valorFornecimentoMeta,
            valorFornecimento.isAcceptableOrUnknown(data['VALOR_FORNECIMENTO']!, _valorFornecimentoMeta));
    }
    if (data.containsKey('VALOR_TOTAL_DEDUCAO')) {
        context.handle(_valorTotalDeducaoMeta,
            valorTotalDeducao.isAcceptableOrUnknown(data['VALOR_TOTAL_DEDUCAO']!, _valorTotalDeducaoMeta));
    }
    if (data.containsKey('VALOR_LIQUIDO_FORNECIMENTO')) {
        context.handle(_valorLiquidoFornecimentoMeta,
            valorLiquidoFornecimento.isAcceptableOrUnknown(data['VALOR_LIQUIDO_FORNECIMENTO']!, _valorLiquidoFornecimentoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeCanaDeducoesSafra map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeCanaDeducoesSafra.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeCanaDeducoesSafrasTable createAlias(String alias) {
    return $NfeCanaDeducoesSafrasTable(_db, alias);
  }
}