/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_DETALHE_IMPOSTO_II] 
                                                                                
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

@DataClassName("NfeDetalheImpostoIi")
@UseRowClass(NfeDetalheImpostoIi)
class NfeDetalheImpostoIis extends Table {
  @override
  String get tableName => 'NFE_DETALHE_IMPOSTO_II';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeDetalhe => integer().named('ID_NFE_DETALHE').nullable().customConstraint('NULLABLE REFERENCES NFE_DETALHE(ID)')();
  RealColumn get valorBcIi => real().named('VALOR_BC_II').nullable()();
  RealColumn get valorDespesasAduaneiras => real().named('VALOR_DESPESAS_ADUANEIRAS').nullable()();
  RealColumn get valorImpostoImportacao => real().named('VALOR_IMPOSTO_IMPORTACAO').nullable()();
  RealColumn get valorIof => real().named('VALOR_IOF').nullable()();
}

class NfeDetalheImpostoIi extends DataClass implements Insertable<NfeDetalheImpostoIi> {
  final int? id;
  final int? idNfeDetalhe;
  final double? valorBcIi;
  final double? valorDespesasAduaneiras;
  final double? valorImpostoImportacao;
  final double? valorIof;

  NfeDetalheImpostoIi(
    {
      required this.id,
      this.idNfeDetalhe,
      this.valorBcIi,
      this.valorDespesasAduaneiras,
      this.valorImpostoImportacao,
      this.valorIof,
    }
  );

  factory NfeDetalheImpostoIi.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeDetalheImpostoIi(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeDetalhe: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_DETALHE']),
      valorBcIi: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_BC_II']),
      valorDespesasAduaneiras: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DESPESAS_ADUANEIRAS']),
      valorImpostoImportacao: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IMPOSTO_IMPORTACAO']),
      valorIof: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_IOF']),
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
    if (!nullToAbsent || valorBcIi != null) {
      map['VALOR_BC_II'] = Variable<double?>(valorBcIi);
    }
    if (!nullToAbsent || valorDespesasAduaneiras != null) {
      map['VALOR_DESPESAS_ADUANEIRAS'] = Variable<double?>(valorDespesasAduaneiras);
    }
    if (!nullToAbsent || valorImpostoImportacao != null) {
      map['VALOR_IMPOSTO_IMPORTACAO'] = Variable<double?>(valorImpostoImportacao);
    }
    if (!nullToAbsent || valorIof != null) {
      map['VALOR_IOF'] = Variable<double?>(valorIof);
    }
    return map;
  }

  NfeDetalheImpostoIisCompanion toCompanion(bool nullToAbsent) {
    return NfeDetalheImpostoIisCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeDetalhe: idNfeDetalhe == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeDetalhe),
      valorBcIi: valorBcIi == null && nullToAbsent
        ? const Value.absent()
        : Value(valorBcIi),
      valorDespesasAduaneiras: valorDespesasAduaneiras == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDespesasAduaneiras),
      valorImpostoImportacao: valorImpostoImportacao == null && nullToAbsent
        ? const Value.absent()
        : Value(valorImpostoImportacao),
      valorIof: valorIof == null && nullToAbsent
        ? const Value.absent()
        : Value(valorIof),
    );
  }

  factory NfeDetalheImpostoIi.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeDetalheImpostoIi(
      id: serializer.fromJson<int>(json['id']),
      idNfeDetalhe: serializer.fromJson<int>(json['idNfeDetalhe']),
      valorBcIi: serializer.fromJson<double>(json['valorBcIi']),
      valorDespesasAduaneiras: serializer.fromJson<double>(json['valorDespesasAduaneiras']),
      valorImpostoImportacao: serializer.fromJson<double>(json['valorImpostoImportacao']),
      valorIof: serializer.fromJson<double>(json['valorIof']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeDetalhe': serializer.toJson<int?>(idNfeDetalhe),
      'valorBcIi': serializer.toJson<double?>(valorBcIi),
      'valorDespesasAduaneiras': serializer.toJson<double?>(valorDespesasAduaneiras),
      'valorImpostoImportacao': serializer.toJson<double?>(valorImpostoImportacao),
      'valorIof': serializer.toJson<double?>(valorIof),
    };
  }

  NfeDetalheImpostoIi copyWith(
        {
		  int? id,
          int? idNfeDetalhe,
          double? valorBcIi,
          double? valorDespesasAduaneiras,
          double? valorImpostoImportacao,
          double? valorIof,
		}) =>
      NfeDetalheImpostoIi(
        id: id ?? this.id,
        idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
        valorBcIi: valorBcIi ?? this.valorBcIi,
        valorDespesasAduaneiras: valorDespesasAduaneiras ?? this.valorDespesasAduaneiras,
        valorImpostoImportacao: valorImpostoImportacao ?? this.valorImpostoImportacao,
        valorIof: valorIof ?? this.valorIof,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoIi(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('valorBcIi: $valorBcIi, ')
          ..write('valorDespesasAduaneiras: $valorDespesasAduaneiras, ')
          ..write('valorImpostoImportacao: $valorImpostoImportacao, ')
          ..write('valorIof: $valorIof, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeDetalhe,
      valorBcIi,
      valorDespesasAduaneiras,
      valorImpostoImportacao,
      valorIof,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeDetalheImpostoIi &&
          other.id == id &&
          other.idNfeDetalhe == idNfeDetalhe &&
          other.valorBcIi == valorBcIi &&
          other.valorDespesasAduaneiras == valorDespesasAduaneiras &&
          other.valorImpostoImportacao == valorImpostoImportacao &&
          other.valorIof == valorIof 
	   );
}

class NfeDetalheImpostoIisCompanion extends UpdateCompanion<NfeDetalheImpostoIi> {

  final Value<int?> id;
  final Value<int?> idNfeDetalhe;
  final Value<double?> valorBcIi;
  final Value<double?> valorDespesasAduaneiras;
  final Value<double?> valorImpostoImportacao;
  final Value<double?> valorIof;

  const NfeDetalheImpostoIisCompanion({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.valorBcIi = const Value.absent(),
    this.valorDespesasAduaneiras = const Value.absent(),
    this.valorImpostoImportacao = const Value.absent(),
    this.valorIof = const Value.absent(),
  });

  NfeDetalheImpostoIisCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeDetalhe = const Value.absent(),
    this.valorBcIi = const Value.absent(),
    this.valorDespesasAduaneiras = const Value.absent(),
    this.valorImpostoImportacao = const Value.absent(),
    this.valorIof = const Value.absent(),
  });

  static Insertable<NfeDetalheImpostoIi> custom({
    Expression<int>? id,
    Expression<int>? idNfeDetalhe,
    Expression<double>? valorBcIi,
    Expression<double>? valorDespesasAduaneiras,
    Expression<double>? valorImpostoImportacao,
    Expression<double>? valorIof,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeDetalhe != null) 'ID_NFE_DETALHE': idNfeDetalhe,
      if (valorBcIi != null) 'VALOR_BC_II': valorBcIi,
      if (valorDespesasAduaneiras != null) 'VALOR_DESPESAS_ADUANEIRAS': valorDespesasAduaneiras,
      if (valorImpostoImportacao != null) 'VALOR_IMPOSTO_IMPORTACAO': valorImpostoImportacao,
      if (valorIof != null) 'VALOR_IOF': valorIof,
    });
  }

  NfeDetalheImpostoIisCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeDetalhe,
      Value<double>? valorBcIi,
      Value<double>? valorDespesasAduaneiras,
      Value<double>? valorImpostoImportacao,
      Value<double>? valorIof,
	  }) {
    return NfeDetalheImpostoIisCompanion(
      id: id ?? this.id,
      idNfeDetalhe: idNfeDetalhe ?? this.idNfeDetalhe,
      valorBcIi: valorBcIi ?? this.valorBcIi,
      valorDespesasAduaneiras: valorDespesasAduaneiras ?? this.valorDespesasAduaneiras,
      valorImpostoImportacao: valorImpostoImportacao ?? this.valorImpostoImportacao,
      valorIof: valorIof ?? this.valorIof,
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
    if (valorBcIi.present) {
      map['VALOR_BC_II'] = Variable<double?>(valorBcIi.value);
    }
    if (valorDespesasAduaneiras.present) {
      map['VALOR_DESPESAS_ADUANEIRAS'] = Variable<double?>(valorDespesasAduaneiras.value);
    }
    if (valorImpostoImportacao.present) {
      map['VALOR_IMPOSTO_IMPORTACAO'] = Variable<double?>(valorImpostoImportacao.value);
    }
    if (valorIof.present) {
      map['VALOR_IOF'] = Variable<double?>(valorIof.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeDetalheImpostoIisCompanion(')
          ..write('id: $id, ')
          ..write('idNfeDetalhe: $idNfeDetalhe, ')
          ..write('valorBcIi: $valorBcIi, ')
          ..write('valorDespesasAduaneiras: $valorDespesasAduaneiras, ')
          ..write('valorImpostoImportacao: $valorImpostoImportacao, ')
          ..write('valorIof: $valorIof, ')
          ..write(')'))
        .toString();
  }
}

class $NfeDetalheImpostoIisTable extends NfeDetalheImpostoIis
    with TableInfo<$NfeDetalheImpostoIisTable, NfeDetalheImpostoIi> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeDetalheImpostoIisTable(this._db, [this._alias]);
  
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
  final VerificationMeta _valorBcIiMeta =
      const VerificationMeta('valorBcIi');
  GeneratedColumn<double>? _valorBcIi;
  @override
  GeneratedColumn<double> get valorBcIi => _valorBcIi ??=
      GeneratedColumn<double>('VALOR_BC_II', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorDespesasAduaneirasMeta =
      const VerificationMeta('valorDespesasAduaneiras');
  GeneratedColumn<double>? _valorDespesasAduaneiras;
  @override
  GeneratedColumn<double> get valorDespesasAduaneiras => _valorDespesasAduaneiras ??=
      GeneratedColumn<double>('VALOR_DESPESAS_ADUANEIRAS', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorImpostoImportacaoMeta =
      const VerificationMeta('valorImpostoImportacao');
  GeneratedColumn<double>? _valorImpostoImportacao;
  @override
  GeneratedColumn<double> get valorImpostoImportacao => _valorImpostoImportacao ??=
      GeneratedColumn<double>('VALOR_IMPOSTO_IMPORTACAO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorIofMeta =
      const VerificationMeta('valorIof');
  GeneratedColumn<double>? _valorIof;
  @override
  GeneratedColumn<double> get valorIof => _valorIof ??=
      GeneratedColumn<double>('VALOR_IOF', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeDetalhe,
        valorBcIi,
        valorDespesasAduaneiras,
        valorImpostoImportacao,
        valorIof,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_DETALHE_IMPOSTO_II';
  
  @override
  String get actualTableName => 'NFE_DETALHE_IMPOSTO_II';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeDetalheImpostoIi> instance,
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
    if (data.containsKey('VALOR_BC_II')) {
        context.handle(_valorBcIiMeta,
            valorBcIi.isAcceptableOrUnknown(data['VALOR_BC_II']!, _valorBcIiMeta));
    }
    if (data.containsKey('VALOR_DESPESAS_ADUANEIRAS')) {
        context.handle(_valorDespesasAduaneirasMeta,
            valorDespesasAduaneiras.isAcceptableOrUnknown(data['VALOR_DESPESAS_ADUANEIRAS']!, _valorDespesasAduaneirasMeta));
    }
    if (data.containsKey('VALOR_IMPOSTO_IMPORTACAO')) {
        context.handle(_valorImpostoImportacaoMeta,
            valorImpostoImportacao.isAcceptableOrUnknown(data['VALOR_IMPOSTO_IMPORTACAO']!, _valorImpostoImportacaoMeta));
    }
    if (data.containsKey('VALOR_IOF')) {
        context.handle(_valorIofMeta,
            valorIof.isAcceptableOrUnknown(data['VALOR_IOF']!, _valorIofMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeDetalheImpostoIi map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeDetalheImpostoIi.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeDetalheImpostoIisTable createAlias(String alias) {
    return $NfeDetalheImpostoIisTable(_db, alias);
  }
}