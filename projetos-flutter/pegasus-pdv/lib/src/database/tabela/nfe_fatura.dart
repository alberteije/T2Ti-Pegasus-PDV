/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_FATURA] 
                                                                                
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

@DataClassName("NfeFatura")
@UseRowClass(NfeFatura)
class NfeFaturas extends Table {
  @override
  String get tableName => 'NFE_FATURA';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  TextColumn get numero => text().named('NUMERO').withLength(min: 0, max: 60).nullable()();
  RealColumn get valorOriginal => real().named('VALOR_ORIGINAL').nullable()();
  RealColumn get valorDesconto => real().named('VALOR_DESCONTO').nullable()();
  RealColumn get valorLiquido => real().named('VALOR_LIQUIDO').nullable()();
}

class NfeFatura extends DataClass implements Insertable<NfeFatura> {
  final int? id;
  final int? idNfeCabecalho;
  final String? numero;
  final double? valorOriginal;
  final double? valorDesconto;
  final double? valorLiquido;

  NfeFatura(
    {
      required this.id,
      this.idNfeCabecalho,
      this.numero,
      this.valorOriginal,
      this.valorDesconto,
      this.valorLiquido,
    }
  );

  factory NfeFatura.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeFatura(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      numero: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO']),
      valorOriginal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ORIGINAL']),
      valorDesconto: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_DESCONTO']),
      valorLiquido: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_LIQUIDO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idNfeCabecalho != null) {
      map['ID_NFE_CABECALHO'] = Variable<int?>(idNfeCabecalho);
    }
    if (!nullToAbsent || numero != null) {
      map['NUMERO'] = Variable<String?>(numero);
    }
    if (!nullToAbsent || valorOriginal != null) {
      map['VALOR_ORIGINAL'] = Variable<double?>(valorOriginal);
    }
    if (!nullToAbsent || valorDesconto != null) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto);
    }
    if (!nullToAbsent || valorLiquido != null) {
      map['VALOR_LIQUIDO'] = Variable<double?>(valorLiquido);
    }
    return map;
  }

  NfeFaturasCompanion toCompanion(bool nullToAbsent) {
    return NfeFaturasCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      numero: numero == null && nullToAbsent
        ? const Value.absent()
        : Value(numero),
      valorOriginal: valorOriginal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorOriginal),
      valorDesconto: valorDesconto == null && nullToAbsent
        ? const Value.absent()
        : Value(valorDesconto),
      valorLiquido: valorLiquido == null && nullToAbsent
        ? const Value.absent()
        : Value(valorLiquido),
    );
  }

  factory NfeFatura.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeFatura(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      numero: serializer.fromJson<String>(json['numero']),
      valorOriginal: serializer.fromJson<double>(json['valorOriginal']),
      valorDesconto: serializer.fromJson<double>(json['valorDesconto']),
      valorLiquido: serializer.fromJson<double>(json['valorLiquido']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'numero': serializer.toJson<String?>(numero),
      'valorOriginal': serializer.toJson<double?>(valorOriginal),
      'valorDesconto': serializer.toJson<double?>(valorDesconto),
      'valorLiquido': serializer.toJson<double?>(valorLiquido),
    };
  }

  NfeFatura copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          String? numero,
          double? valorOriginal,
          double? valorDesconto,
          double? valorLiquido,
		}) =>
      NfeFatura(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        numero: numero ?? this.numero,
        valorOriginal: valorOriginal ?? this.valorOriginal,
        valorDesconto: valorDesconto ?? this.valorDesconto,
        valorLiquido: valorLiquido ?? this.valorLiquido,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeFatura(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('numero: $numero, ')
          ..write('valorOriginal: $valorOriginal, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorLiquido: $valorLiquido, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      numero,
      valorOriginal,
      valorDesconto,
      valorLiquido,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeFatura &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.numero == numero &&
          other.valorOriginal == valorOriginal &&
          other.valorDesconto == valorDesconto &&
          other.valorLiquido == valorLiquido 
	   );
}

class NfeFaturasCompanion extends UpdateCompanion<NfeFatura> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<String?> numero;
  final Value<double?> valorOriginal;
  final Value<double?> valorDesconto;
  final Value<double?> valorLiquido;

  const NfeFaturasCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.numero = const Value.absent(),
    this.valorOriginal = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorLiquido = const Value.absent(),
  });

  NfeFaturasCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.numero = const Value.absent(),
    this.valorOriginal = const Value.absent(),
    this.valorDesconto = const Value.absent(),
    this.valorLiquido = const Value.absent(),
  });

  static Insertable<NfeFatura> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<String>? numero,
    Expression<double>? valorOriginal,
    Expression<double>? valorDesconto,
    Expression<double>? valorLiquido,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (numero != null) 'NUMERO': numero,
      if (valorOriginal != null) 'VALOR_ORIGINAL': valorOriginal,
      if (valorDesconto != null) 'VALOR_DESCONTO': valorDesconto,
      if (valorLiquido != null) 'VALOR_LIQUIDO': valorLiquido,
    });
  }

  NfeFaturasCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<String>? numero,
      Value<double>? valorOriginal,
      Value<double>? valorDesconto,
      Value<double>? valorLiquido,
	  }) {
    return NfeFaturasCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      numero: numero ?? this.numero,
      valorOriginal: valorOriginal ?? this.valorOriginal,
      valorDesconto: valorDesconto ?? this.valorDesconto,
      valorLiquido: valorLiquido ?? this.valorLiquido,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idNfeCabecalho.present) {
      map['ID_NFE_CABECALHO'] = Variable<int?>(idNfeCabecalho.value);
    }
    if (numero.present) {
      map['NUMERO'] = Variable<String?>(numero.value);
    }
    if (valorOriginal.present) {
      map['VALOR_ORIGINAL'] = Variable<double?>(valorOriginal.value);
    }
    if (valorDesconto.present) {
      map['VALOR_DESCONTO'] = Variable<double?>(valorDesconto.value);
    }
    if (valorLiquido.present) {
      map['VALOR_LIQUIDO'] = Variable<double?>(valorLiquido.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeFaturasCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('numero: $numero, ')
          ..write('valorOriginal: $valorOriginal, ')
          ..write('valorDesconto: $valorDesconto, ')
          ..write('valorLiquido: $valorLiquido, ')
          ..write(')'))
        .toString();
  }
}

class $NfeFaturasTable extends NfeFaturas
    with TableInfo<$NfeFaturasTable, NfeFatura> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeFaturasTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idNfeCabecalhoMeta =
      const VerificationMeta('idNfeCabecalho');
  GeneratedColumn<int>? _idNfeCabecalho;
  @override
  GeneratedColumn<int> get idNfeCabecalho =>
      _idNfeCabecalho ??= GeneratedColumn<int>('ID_NFE_CABECALHO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES NFE_CABECALHO(ID)');
  final VerificationMeta _numeroMeta =
      const VerificationMeta('numero');
  GeneratedColumn<String>? _numero;
  @override
  GeneratedColumn<String> get numero => _numero ??=
      GeneratedColumn<String>('NUMERO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorOriginalMeta =
      const VerificationMeta('valorOriginal');
  GeneratedColumn<double>? _valorOriginal;
  @override
  GeneratedColumn<double> get valorOriginal => _valorOriginal ??=
      GeneratedColumn<double>('VALOR_ORIGINAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorDescontoMeta =
      const VerificationMeta('valorDesconto');
  GeneratedColumn<double>? _valorDesconto;
  @override
  GeneratedColumn<double> get valorDesconto => _valorDesconto ??=
      GeneratedColumn<double>('VALOR_DESCONTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorLiquidoMeta =
      const VerificationMeta('valorLiquido');
  GeneratedColumn<double>? _valorLiquido;
  @override
  GeneratedColumn<double> get valorLiquido => _valorLiquido ??=
      GeneratedColumn<double>('VALOR_LIQUIDO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        numero,
        valorOriginal,
        valorDesconto,
        valorLiquido,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_FATURA';
  
  @override
  String get actualTableName => 'NFE_FATURA';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeFatura> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_NFE_CABECALHO')) {
        context.handle(_idNfeCabecalhoMeta,
            idNfeCabecalho.isAcceptableOrUnknown(data['ID_NFE_CABECALHO']!, _idNfeCabecalhoMeta));
    }
    if (data.containsKey('NUMERO')) {
        context.handle(_numeroMeta,
            numero.isAcceptableOrUnknown(data['NUMERO']!, _numeroMeta));
    }
    if (data.containsKey('VALOR_ORIGINAL')) {
        context.handle(_valorOriginalMeta,
            valorOriginal.isAcceptableOrUnknown(data['VALOR_ORIGINAL']!, _valorOriginalMeta));
    }
    if (data.containsKey('VALOR_DESCONTO')) {
        context.handle(_valorDescontoMeta,
            valorDesconto.isAcceptableOrUnknown(data['VALOR_DESCONTO']!, _valorDescontoMeta));
    }
    if (data.containsKey('VALOR_LIQUIDO')) {
        context.handle(_valorLiquidoMeta,
            valorLiquido.isAcceptableOrUnknown(data['VALOR_LIQUIDO']!, _valorLiquidoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeFatura map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeFatura.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeFaturasTable createAlias(String alias) {
    return $NfeFaturasTable(_db, alias);
  }
}