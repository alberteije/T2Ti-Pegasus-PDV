/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_FECHAMENTO] 
                                                                                
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

@DataClassName("PdvFechamento")
@UseRowClass(PdvFechamento)
class PdvFechamentos extends Table {
  @override
  String get tableName => 'PDV_FECHAMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idPdvMovimento => integer().named('ID_PDV_MOVIMENTO').nullable().customConstraint('NULLABLE REFERENCES PDV_MOVIMENTO(ID)')();
  IntColumn get idPdvTipoPagamento => integer().named('ID_PDV_TIPO_PAGAMENTO').nullable().customConstraint('NULLABLE REFERENCES PDV_TIPO_PAGAMENTO(ID)')();
  RealColumn get valor => real().named('VALOR').nullable()();
}

class PdvFechamento extends DataClass implements Insertable<PdvFechamento> {
  final int? id;
  final int? idPdvMovimento;
  final int? idPdvTipoPagamento;
  final double? valor;

  PdvFechamento(
    {
      required this.id,
      this.idPdvMovimento,
      this.idPdvTipoPagamento,
      this.valor,
    }
  );

  factory PdvFechamento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PdvFechamento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idPdvMovimento: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_MOVIMENTO']),
      idPdvTipoPagamento: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_TIPO_PAGAMENTO']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idPdvMovimento != null) {
      map['ID_PDV_MOVIMENTO'] = Variable<int?>(idPdvMovimento);
    }
    if (!nullToAbsent || idPdvTipoPagamento != null) {
      map['ID_PDV_TIPO_PAGAMENTO'] = Variable<int?>(idPdvTipoPagamento);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    return map;
  }

  PdvFechamentosCompanion toCompanion(bool nullToAbsent) {
    return PdvFechamentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idPdvMovimento: idPdvMovimento == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvMovimento),
      idPdvTipoPagamento: idPdvTipoPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvTipoPagamento),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
    );
  }

  factory PdvFechamento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvFechamento(
      id: serializer.fromJson<int>(json['id']),
      idPdvMovimento: serializer.fromJson<int>(json['idPdvMovimento']),
      idPdvTipoPagamento: serializer.fromJson<int>(json['idPdvTipoPagamento']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idPdvMovimento': serializer.toJson<int?>(idPdvMovimento),
      'idPdvTipoPagamento': serializer.toJson<int?>(idPdvTipoPagamento),
      'valor': serializer.toJson<double?>(valor),
    };
  }

  PdvFechamento copyWith(
        {
		  int? id,
          int? idPdvMovimento,
          int? idPdvTipoPagamento,
          double? valor,
		}) =>
      PdvFechamento(
        id: id ?? this.id,
        idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
        idPdvTipoPagamento: idPdvTipoPagamento ?? this.idPdvTipoPagamento,
        valor: valor ?? this.valor,
      );
  
  @override
  String toString() {
    return (StringBuffer('PdvFechamento(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('idPdvTipoPagamento: $idPdvTipoPagamento, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idPdvMovimento,
      idPdvTipoPagamento,
      valor,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdvFechamento &&
          other.id == id &&
          other.idPdvMovimento == idPdvMovimento &&
          other.idPdvTipoPagamento == idPdvTipoPagamento &&
          other.valor == valor 
	   );
}

class PdvFechamentosCompanion extends UpdateCompanion<PdvFechamento> {

  final Value<int?> id;
  final Value<int?> idPdvMovimento;
  final Value<int?> idPdvTipoPagamento;
  final Value<double?> valor;

  const PdvFechamentosCompanion({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.idPdvTipoPagamento = const Value.absent(),
    this.valor = const Value.absent(),
  });

  PdvFechamentosCompanion.insert({
    this.id = const Value.absent(),
    this.idPdvMovimento = const Value.absent(),
    this.idPdvTipoPagamento = const Value.absent(),
    this.valor = const Value.absent(),
  });

  static Insertable<PdvFechamento> custom({
    Expression<int>? id,
    Expression<int>? idPdvMovimento,
    Expression<int>? idPdvTipoPagamento,
    Expression<double>? valor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idPdvMovimento != null) 'ID_PDV_MOVIMENTO': idPdvMovimento,
      if (idPdvTipoPagamento != null) 'ID_PDV_TIPO_PAGAMENTO': idPdvTipoPagamento,
      if (valor != null) 'VALOR': valor,
    });
  }

  PdvFechamentosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idPdvMovimento,
      Value<int>? idPdvTipoPagamento,
      Value<double>? valor,
	  }) {
    return PdvFechamentosCompanion(
      id: id ?? this.id,
      idPdvMovimento: idPdvMovimento ?? this.idPdvMovimento,
      idPdvTipoPagamento: idPdvTipoPagamento ?? this.idPdvTipoPagamento,
      valor: valor ?? this.valor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idPdvMovimento.present) {
      map['ID_PDV_MOVIMENTO'] = Variable<int?>(idPdvMovimento.value);
    }
    if (idPdvTipoPagamento.present) {
      map['ID_PDV_TIPO_PAGAMENTO'] = Variable<int?>(idPdvTipoPagamento.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdvFechamentosCompanion(')
          ..write('id: $id, ')
          ..write('idPdvMovimento: $idPdvMovimento, ')
          ..write('idPdvTipoPagamento: $idPdvTipoPagamento, ')
          ..write('valor: $valor, ')
          ..write(')'))
        .toString();
  }
}

class $PdvFechamentosTable extends PdvFechamentos
    with TableInfo<$PdvFechamentosTable, PdvFechamento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PdvFechamentosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idPdvMovimentoMeta =
      const VerificationMeta('idPdvMovimento');
  GeneratedColumn<int>? _idPdvMovimento;
  @override
  GeneratedColumn<int> get idPdvMovimento =>
      _idPdvMovimento ??= GeneratedColumn<int>('ID_PDV_MOVIMENTO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PDV_MOVIMENTO(ID)');
  final VerificationMeta _idPdvTipoPagamentoMeta =
      const VerificationMeta('idPdvTipoPagamento');
  GeneratedColumn<int>? _idPdvTipoPagamento;
  @override
  GeneratedColumn<int> get idPdvTipoPagamento =>
      _idPdvTipoPagamento ??= GeneratedColumn<int>('ID_PDV_TIPO_PAGAMENTO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PDV_TIPO_PAGAMENTO(ID)');
  final VerificationMeta _valorMeta =
      const VerificationMeta('valor');
  GeneratedColumn<double>? _valor;
  @override
  GeneratedColumn<double> get valor => _valor ??=
      GeneratedColumn<double>('VALOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idPdvMovimento,
        idPdvTipoPagamento,
        valor,
      ];

  @override
  String get aliasedName => _alias ?? 'PDV_FECHAMENTO';
  
  @override
  String get actualTableName => 'PDV_FECHAMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<PdvFechamento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_PDV_MOVIMENTO')) {
        context.handle(_idPdvMovimentoMeta,
            idPdvMovimento.isAcceptableOrUnknown(data['ID_PDV_MOVIMENTO']!, _idPdvMovimentoMeta));
    }
    if (data.containsKey('ID_PDV_TIPO_PAGAMENTO')) {
        context.handle(_idPdvTipoPagamentoMeta,
            idPdvTipoPagamento.isAcceptableOrUnknown(data['ID_PDV_TIPO_PAGAMENTO']!, _idPdvTipoPagamentoMeta));
    }
    if (data.containsKey('VALOR')) {
        context.handle(_valorMeta,
            valor.isAcceptableOrUnknown(data['VALOR']!, _valorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdvFechamento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PdvFechamento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PdvFechamentosTable createAlias(String alias) {
    return $PdvFechamentosTable(_db, alias);
  }
}