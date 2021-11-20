/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_R07] 
                                                                                
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

@DataClassName("EcfR07")
@UseRowClass(EcfR07)
class EcfR07s extends Table {
  @override
  String get tableName => 'ECF_R07';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idEcfR06 => integer().named('ID_ECF_R06').nullable().customConstraint('NULLABLE REFERENCES ECF_R06(ID)')();
  IntColumn get ccf => integer().named('CCF').nullable()();
  TextColumn get meioPagamento => text().named('MEIO_PAGAMENTO').withLength(min: 0, max: 20).nullable()();
  RealColumn get valorPagamento => real().named('VALOR_PAGAMENTO').nullable()();
  TextColumn get estorno => text().named('ESTORNO').withLength(min: 0, max: 1).nullable()();
  RealColumn get valorEstorno => real().named('VALOR_ESTORNO').nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()();
}

class EcfR07 extends DataClass implements Insertable<EcfR07> {
  final int? id;
  final int? idEcfR06;
  final int? ccf;
  final String? meioPagamento;
  final double? valorPagamento;
  final String? estorno;
  final double? valorEstorno;
  final String? hashRegistro;

  EcfR07(
    {
      required this.id,
      this.idEcfR06,
      this.ccf,
      this.meioPagamento,
      this.valorPagamento,
      this.estorno,
      this.valorEstorno,
      this.hashRegistro,
    }
  );

  factory EcfR07.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EcfR07(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idEcfR06: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_ECF_R06']),
      ccf: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CCF']),
      meioPagamento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MEIO_PAGAMENTO']),
      valorPagamento: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PAGAMENTO']),
      estorno: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ESTORNO']),
      valorEstorno: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_ESTORNO']),
      hashRegistro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HASH_REGISTRO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idEcfR06 != null) {
      map['ID_ECF_R06'] = Variable<int?>(idEcfR06);
    }
    if (!nullToAbsent || ccf != null) {
      map['CCF'] = Variable<int?>(ccf);
    }
    if (!nullToAbsent || meioPagamento != null) {
      map['MEIO_PAGAMENTO'] = Variable<String?>(meioPagamento);
    }
    if (!nullToAbsent || valorPagamento != null) {
      map['VALOR_PAGAMENTO'] = Variable<double?>(valorPagamento);
    }
    if (!nullToAbsent || estorno != null) {
      map['ESTORNO'] = Variable<String?>(estorno);
    }
    if (!nullToAbsent || valorEstorno != null) {
      map['VALOR_ESTORNO'] = Variable<double?>(valorEstorno);
    }
    if (!nullToAbsent || hashRegistro != null) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro);
    }
    return map;
  }

  EcfR07sCompanion toCompanion(bool nullToAbsent) {
    return EcfR07sCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idEcfR06: idEcfR06 == null && nullToAbsent
        ? const Value.absent()
        : Value(idEcfR06),
      ccf: ccf == null && nullToAbsent
        ? const Value.absent()
        : Value(ccf),
      meioPagamento: meioPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(meioPagamento),
      valorPagamento: valorPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPagamento),
      estorno: estorno == null && nullToAbsent
        ? const Value.absent()
        : Value(estorno),
      valorEstorno: valorEstorno == null && nullToAbsent
        ? const Value.absent()
        : Value(valorEstorno),
      hashRegistro: hashRegistro == null && nullToAbsent
        ? const Value.absent()
        : Value(hashRegistro),
    );
  }

  factory EcfR07.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EcfR07(
      id: serializer.fromJson<int>(json['id']),
      idEcfR06: serializer.fromJson<int>(json['idEcfR06']),
      ccf: serializer.fromJson<int>(json['ccf']),
      meioPagamento: serializer.fromJson<String>(json['meioPagamento']),
      valorPagamento: serializer.fromJson<double>(json['valorPagamento']),
      estorno: serializer.fromJson<String>(json['estorno']),
      valorEstorno: serializer.fromJson<double>(json['valorEstorno']),
      hashRegistro: serializer.fromJson<String>(json['hashRegistro']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idEcfR06': serializer.toJson<int?>(idEcfR06),
      'ccf': serializer.toJson<int?>(ccf),
      'meioPagamento': serializer.toJson<String?>(meioPagamento),
      'valorPagamento': serializer.toJson<double?>(valorPagamento),
      'estorno': serializer.toJson<String?>(estorno),
      'valorEstorno': serializer.toJson<double?>(valorEstorno),
      'hashRegistro': serializer.toJson<String?>(hashRegistro),
    };
  }

  EcfR07 copyWith(
        {
		  int? id,
          int? idEcfR06,
          int? ccf,
          String? meioPagamento,
          double? valorPagamento,
          String? estorno,
          double? valorEstorno,
          String? hashRegistro,
		}) =>
      EcfR07(
        id: id ?? this.id,
        idEcfR06: idEcfR06 ?? this.idEcfR06,
        ccf: ccf ?? this.ccf,
        meioPagamento: meioPagamento ?? this.meioPagamento,
        valorPagamento: valorPagamento ?? this.valorPagamento,
        estorno: estorno ?? this.estorno,
        valorEstorno: valorEstorno ?? this.valorEstorno,
        hashRegistro: hashRegistro ?? this.hashRegistro,
      );
  
  @override
  String toString() {
    return (StringBuffer('EcfR07(')
          ..write('id: $id, ')
          ..write('idEcfR06: $idEcfR06, ')
          ..write('ccf: $ccf, ')
          ..write('meioPagamento: $meioPagamento, ')
          ..write('valorPagamento: $valorPagamento, ')
          ..write('estorno: $estorno, ')
          ..write('valorEstorno: $valorEstorno, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idEcfR06,
      ccf,
      meioPagamento,
      valorPagamento,
      estorno,
      valorEstorno,
      hashRegistro,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcfR07 &&
          other.id == id &&
          other.idEcfR06 == idEcfR06 &&
          other.ccf == ccf &&
          other.meioPagamento == meioPagamento &&
          other.valorPagamento == valorPagamento &&
          other.estorno == estorno &&
          other.valorEstorno == valorEstorno &&
          other.hashRegistro == hashRegistro 
	   );
}

class EcfR07sCompanion extends UpdateCompanion<EcfR07> {

  final Value<int?> id;
  final Value<int?> idEcfR06;
  final Value<int?> ccf;
  final Value<String?> meioPagamento;
  final Value<double?> valorPagamento;
  final Value<String?> estorno;
  final Value<double?> valorEstorno;
  final Value<String?> hashRegistro;

  const EcfR07sCompanion({
    this.id = const Value.absent(),
    this.idEcfR06 = const Value.absent(),
    this.ccf = const Value.absent(),
    this.meioPagamento = const Value.absent(),
    this.valorPagamento = const Value.absent(),
    this.estorno = const Value.absent(),
    this.valorEstorno = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  EcfR07sCompanion.insert({
    this.id = const Value.absent(),
    this.idEcfR06 = const Value.absent(),
    this.ccf = const Value.absent(),
    this.meioPagamento = const Value.absent(),
    this.valorPagamento = const Value.absent(),
    this.estorno = const Value.absent(),
    this.valorEstorno = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  static Insertable<EcfR07> custom({
    Expression<int>? id,
    Expression<int>? idEcfR06,
    Expression<int>? ccf,
    Expression<String>? meioPagamento,
    Expression<double>? valorPagamento,
    Expression<String>? estorno,
    Expression<double>? valorEstorno,
    Expression<String>? hashRegistro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idEcfR06 != null) 'ID_ECF_R06': idEcfR06,
      if (ccf != null) 'CCF': ccf,
      if (meioPagamento != null) 'MEIO_PAGAMENTO': meioPagamento,
      if (valorPagamento != null) 'VALOR_PAGAMENTO': valorPagamento,
      if (estorno != null) 'ESTORNO': estorno,
      if (valorEstorno != null) 'VALOR_ESTORNO': valorEstorno,
      if (hashRegistro != null) 'HASH_REGISTRO': hashRegistro,
    });
  }

  EcfR07sCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idEcfR06,
      Value<int>? ccf,
      Value<String>? meioPagamento,
      Value<double>? valorPagamento,
      Value<String>? estorno,
      Value<double>? valorEstorno,
      Value<String>? hashRegistro,
	  }) {
    return EcfR07sCompanion(
      id: id ?? this.id,
      idEcfR06: idEcfR06 ?? this.idEcfR06,
      ccf: ccf ?? this.ccf,
      meioPagamento: meioPagamento ?? this.meioPagamento,
      valorPagamento: valorPagamento ?? this.valorPagamento,
      estorno: estorno ?? this.estorno,
      valorEstorno: valorEstorno ?? this.valorEstorno,
      hashRegistro: hashRegistro ?? this.hashRegistro,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idEcfR06.present) {
      map['ID_ECF_R06'] = Variable<int?>(idEcfR06.value);
    }
    if (ccf.present) {
      map['CCF'] = Variable<int?>(ccf.value);
    }
    if (meioPagamento.present) {
      map['MEIO_PAGAMENTO'] = Variable<String?>(meioPagamento.value);
    }
    if (valorPagamento.present) {
      map['VALOR_PAGAMENTO'] = Variable<double?>(valorPagamento.value);
    }
    if (estorno.present) {
      map['ESTORNO'] = Variable<String?>(estorno.value);
    }
    if (valorEstorno.present) {
      map['VALOR_ESTORNO'] = Variable<double?>(valorEstorno.value);
    }
    if (hashRegistro.present) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcfR07sCompanion(')
          ..write('id: $id, ')
          ..write('idEcfR06: $idEcfR06, ')
          ..write('ccf: $ccf, ')
          ..write('meioPagamento: $meioPagamento, ')
          ..write('valorPagamento: $valorPagamento, ')
          ..write('estorno: $estorno, ')
          ..write('valorEstorno: $valorEstorno, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }
}

class $EcfR07sTable extends EcfR07s
    with TableInfo<$EcfR07sTable, EcfR07> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EcfR07sTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idEcfR06Meta =
      const VerificationMeta('idEcfR06');
  GeneratedColumn<int>? _idEcfR06;
  @override
  GeneratedColumn<int> get idEcfR06 =>
      _idEcfR06 ??= GeneratedColumn<int>('ID_ECF_R06', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES ECF_R06(ID)');
  final VerificationMeta _ccfMeta =
      const VerificationMeta('ccf');
  GeneratedColumn<int>? _ccf;
  @override
  GeneratedColumn<int> get ccf => _ccf ??=
      GeneratedColumn<int>('CCF', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _meioPagamentoMeta =
      const VerificationMeta('meioPagamento');
  GeneratedColumn<String>? _meioPagamento;
  @override
  GeneratedColumn<String> get meioPagamento => _meioPagamento ??=
      GeneratedColumn<String>('MEIO_PAGAMENTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorPagamentoMeta =
      const VerificationMeta('valorPagamento');
  GeneratedColumn<double>? _valorPagamento;
  @override
  GeneratedColumn<double> get valorPagamento => _valorPagamento ??=
      GeneratedColumn<double>('VALOR_PAGAMENTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _estornoMeta =
      const VerificationMeta('estorno');
  GeneratedColumn<String>? _estorno;
  @override
  GeneratedColumn<String> get estorno => _estorno ??=
      GeneratedColumn<String>('ESTORNO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorEstornoMeta =
      const VerificationMeta('valorEstorno');
  GeneratedColumn<double>? _valorEstorno;
  @override
  GeneratedColumn<double> get valorEstorno => _valorEstorno ??=
      GeneratedColumn<double>('VALOR_ESTORNO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _hashRegistroMeta =
      const VerificationMeta('hashRegistro');
  GeneratedColumn<String>? _hashRegistro;
  @override
  GeneratedColumn<String> get hashRegistro => _hashRegistro ??=
      GeneratedColumn<String>('HASH_REGISTRO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idEcfR06,
        ccf,
        meioPagamento,
        valorPagamento,
        estorno,
        valorEstorno,
        hashRegistro,
      ];

  @override
  String get aliasedName => _alias ?? 'ECF_R07';
  
  @override
  String get actualTableName => 'ECF_R07';
  
  @override
  VerificationContext validateIntegrity(Insertable<EcfR07> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_ECF_R06')) {
        context.handle(_idEcfR06Meta,
            idEcfR06.isAcceptableOrUnknown(data['ID_ECF_R06']!, _idEcfR06Meta));
    }
    if (data.containsKey('CCF')) {
        context.handle(_ccfMeta,
            ccf.isAcceptableOrUnknown(data['CCF']!, _ccfMeta));
    }
    if (data.containsKey('MEIO_PAGAMENTO')) {
        context.handle(_meioPagamentoMeta,
            meioPagamento.isAcceptableOrUnknown(data['MEIO_PAGAMENTO']!, _meioPagamentoMeta));
    }
    if (data.containsKey('VALOR_PAGAMENTO')) {
        context.handle(_valorPagamentoMeta,
            valorPagamento.isAcceptableOrUnknown(data['VALOR_PAGAMENTO']!, _valorPagamentoMeta));
    }
    if (data.containsKey('ESTORNO')) {
        context.handle(_estornoMeta,
            estorno.isAcceptableOrUnknown(data['ESTORNO']!, _estornoMeta));
    }
    if (data.containsKey('VALOR_ESTORNO')) {
        context.handle(_valorEstornoMeta,
            valorEstorno.isAcceptableOrUnknown(data['VALOR_ESTORNO']!, _valorEstornoMeta));
    }
    if (data.containsKey('HASH_REGISTRO')) {
        context.handle(_hashRegistroMeta,
            hashRegistro.isAcceptableOrUnknown(data['HASH_REGISTRO']!, _hashRegistroMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EcfR07 map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EcfR07.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EcfR07sTable createAlias(String alias) {
    return $EcfR07sTable(_db, alias);
  }
}