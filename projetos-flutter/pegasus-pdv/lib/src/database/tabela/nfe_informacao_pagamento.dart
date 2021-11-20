/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_INFORMACAO_PAGAMENTO] 
                                                                                
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

@DataClassName("NfeInformacaoPagamento")
@UseRowClass(NfeInformacaoPagamento)
class NfeInformacaoPagamentos extends Table {
  @override
  String get tableName => 'NFE_INFORMACAO_PAGAMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  TextColumn get indicadorPagamento => text().named('INDICADOR_PAGAMENTO').withLength(min: 0, max: 1).nullable()();
  TextColumn get meioPagamento => text().named('MEIO_PAGAMENTO').withLength(min: 0, max: 2).nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
  TextColumn get tipoIntegracao => text().named('TIPO_INTEGRACAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get cnpjOperadoraCartao => text().named('CNPJ_OPERADORA_CARTAO').withLength(min: 0, max: 14).nullable()();
  TextColumn get bandeira => text().named('BANDEIRA').withLength(min: 0, max: 2).nullable()();
  TextColumn get numeroAutorizacao => text().named('NUMERO_AUTORIZACAO').withLength(min: 0, max: 20).nullable()();
  RealColumn get troco => real().named('TROCO').nullable()();
}

class NfeInformacaoPagamento extends DataClass implements Insertable<NfeInformacaoPagamento> {
  final int? id;
  final int? idNfeCabecalho;
  final String? indicadorPagamento;
  final String? meioPagamento;
  final double? valor;
  final String? tipoIntegracao;
  final String? cnpjOperadoraCartao;
  final String? bandeira;
  final String? numeroAutorizacao;
  final double? troco;

  NfeInformacaoPagamento(
    {
      required this.id,
      this.idNfeCabecalho,
      this.indicadorPagamento,
      this.meioPagamento,
      this.valor,
      this.tipoIntegracao,
      this.cnpjOperadoraCartao,
      this.bandeira,
      this.numeroAutorizacao,
      this.troco,
    }
  );

  factory NfeInformacaoPagamento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeInformacaoPagamento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      indicadorPagamento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}INDICADOR_PAGAMENTO']),
      meioPagamento: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MEIO_PAGAMENTO']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
      tipoIntegracao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TIPO_INTEGRACAO']),
      cnpjOperadoraCartao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CNPJ_OPERADORA_CARTAO']),
      bandeira: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}BANDEIRA']),
      numeroAutorizacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NUMERO_AUTORIZACAO']),
      troco: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}TROCO']),
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
    if (!nullToAbsent || indicadorPagamento != null) {
      map['INDICADOR_PAGAMENTO'] = Variable<String?>(indicadorPagamento);
    }
    if (!nullToAbsent || meioPagamento != null) {
      map['MEIO_PAGAMENTO'] = Variable<String?>(meioPagamento);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    if (!nullToAbsent || tipoIntegracao != null) {
      map['TIPO_INTEGRACAO'] = Variable<String?>(tipoIntegracao);
    }
    if (!nullToAbsent || cnpjOperadoraCartao != null) {
      map['CNPJ_OPERADORA_CARTAO'] = Variable<String?>(cnpjOperadoraCartao);
    }
    if (!nullToAbsent || bandeira != null) {
      map['BANDEIRA'] = Variable<String?>(bandeira);
    }
    if (!nullToAbsent || numeroAutorizacao != null) {
      map['NUMERO_AUTORIZACAO'] = Variable<String?>(numeroAutorizacao);
    }
    if (!nullToAbsent || troco != null) {
      map['TROCO'] = Variable<double?>(troco);
    }
    return map;
  }

  NfeInformacaoPagamentosCompanion toCompanion(bool nullToAbsent) {
    return NfeInformacaoPagamentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      indicadorPagamento: indicadorPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(indicadorPagamento),
      meioPagamento: meioPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(meioPagamento),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
      tipoIntegracao: tipoIntegracao == null && nullToAbsent
        ? const Value.absent()
        : Value(tipoIntegracao),
      cnpjOperadoraCartao: cnpjOperadoraCartao == null && nullToAbsent
        ? const Value.absent()
        : Value(cnpjOperadoraCartao),
      bandeira: bandeira == null && nullToAbsent
        ? const Value.absent()
        : Value(bandeira),
      numeroAutorizacao: numeroAutorizacao == null && nullToAbsent
        ? const Value.absent()
        : Value(numeroAutorizacao),
      troco: troco == null && nullToAbsent
        ? const Value.absent()
        : Value(troco),
    );
  }

  factory NfeInformacaoPagamento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeInformacaoPagamento(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      indicadorPagamento: serializer.fromJson<String>(json['indicadorPagamento']),
      meioPagamento: serializer.fromJson<String>(json['meioPagamento']),
      valor: serializer.fromJson<double>(json['valor']),
      tipoIntegracao: serializer.fromJson<String>(json['tipoIntegracao']),
      cnpjOperadoraCartao: serializer.fromJson<String>(json['cnpjOperadoraCartao']),
      bandeira: serializer.fromJson<String>(json['bandeira']),
      numeroAutorizacao: serializer.fromJson<String>(json['numeroAutorizacao']),
      troco: serializer.fromJson<double>(json['troco']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'indicadorPagamento': serializer.toJson<String?>(indicadorPagamento),
      'meioPagamento': serializer.toJson<String?>(meioPagamento),
      'valor': serializer.toJson<double?>(valor),
      'tipoIntegracao': serializer.toJson<String?>(tipoIntegracao),
      'cnpjOperadoraCartao': serializer.toJson<String?>(cnpjOperadoraCartao),
      'bandeira': serializer.toJson<String?>(bandeira),
      'numeroAutorizacao': serializer.toJson<String?>(numeroAutorizacao),
      'troco': serializer.toJson<double?>(troco),
    };
  }

  NfeInformacaoPagamento copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          String? indicadorPagamento,
          String? meioPagamento,
          double? valor,
          String? tipoIntegracao,
          String? cnpjOperadoraCartao,
          String? bandeira,
          String? numeroAutorizacao,
          double? troco,
		}) =>
      NfeInformacaoPagamento(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        indicadorPagamento: indicadorPagamento ?? this.indicadorPagamento,
        meioPagamento: meioPagamento ?? this.meioPagamento,
        valor: valor ?? this.valor,
        tipoIntegracao: tipoIntegracao ?? this.tipoIntegracao,
        cnpjOperadoraCartao: cnpjOperadoraCartao ?? this.cnpjOperadoraCartao,
        bandeira: bandeira ?? this.bandeira,
        numeroAutorizacao: numeroAutorizacao ?? this.numeroAutorizacao,
        troco: troco ?? this.troco,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeInformacaoPagamento(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('indicadorPagamento: $indicadorPagamento, ')
          ..write('meioPagamento: $meioPagamento, ')
          ..write('valor: $valor, ')
          ..write('tipoIntegracao: $tipoIntegracao, ')
          ..write('cnpjOperadoraCartao: $cnpjOperadoraCartao, ')
          ..write('bandeira: $bandeira, ')
          ..write('numeroAutorizacao: $numeroAutorizacao, ')
          ..write('troco: $troco, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      indicadorPagamento,
      meioPagamento,
      valor,
      tipoIntegracao,
      cnpjOperadoraCartao,
      bandeira,
      numeroAutorizacao,
      troco,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeInformacaoPagamento &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.indicadorPagamento == indicadorPagamento &&
          other.meioPagamento == meioPagamento &&
          other.valor == valor &&
          other.tipoIntegracao == tipoIntegracao &&
          other.cnpjOperadoraCartao == cnpjOperadoraCartao &&
          other.bandeira == bandeira &&
          other.numeroAutorizacao == numeroAutorizacao &&
          other.troco == troco 
	   );
}

class NfeInformacaoPagamentosCompanion extends UpdateCompanion<NfeInformacaoPagamento> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<String?> indicadorPagamento;
  final Value<String?> meioPagamento;
  final Value<double?> valor;
  final Value<String?> tipoIntegracao;
  final Value<String?> cnpjOperadoraCartao;
  final Value<String?> bandeira;
  final Value<String?> numeroAutorizacao;
  final Value<double?> troco;

  const NfeInformacaoPagamentosCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.indicadorPagamento = const Value.absent(),
    this.meioPagamento = const Value.absent(),
    this.valor = const Value.absent(),
    this.tipoIntegracao = const Value.absent(),
    this.cnpjOperadoraCartao = const Value.absent(),
    this.bandeira = const Value.absent(),
    this.numeroAutorizacao = const Value.absent(),
    this.troco = const Value.absent(),
  });

  NfeInformacaoPagamentosCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.indicadorPagamento = const Value.absent(),
    this.meioPagamento = const Value.absent(),
    this.valor = const Value.absent(),
    this.tipoIntegracao = const Value.absent(),
    this.cnpjOperadoraCartao = const Value.absent(),
    this.bandeira = const Value.absent(),
    this.numeroAutorizacao = const Value.absent(),
    this.troco = const Value.absent(),
  });

  static Insertable<NfeInformacaoPagamento> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<String>? indicadorPagamento,
    Expression<String>? meioPagamento,
    Expression<double>? valor,
    Expression<String>? tipoIntegracao,
    Expression<String>? cnpjOperadoraCartao,
    Expression<String>? bandeira,
    Expression<String>? numeroAutorizacao,
    Expression<double>? troco,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (indicadorPagamento != null) 'INDICADOR_PAGAMENTO': indicadorPagamento,
      if (meioPagamento != null) 'MEIO_PAGAMENTO': meioPagamento,
      if (valor != null) 'VALOR': valor,
      if (tipoIntegracao != null) 'TIPO_INTEGRACAO': tipoIntegracao,
      if (cnpjOperadoraCartao != null) 'CNPJ_OPERADORA_CARTAO': cnpjOperadoraCartao,
      if (bandeira != null) 'BANDEIRA': bandeira,
      if (numeroAutorizacao != null) 'NUMERO_AUTORIZACAO': numeroAutorizacao,
      if (troco != null) 'TROCO': troco,
    });
  }

  NfeInformacaoPagamentosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<String>? indicadorPagamento,
      Value<String>? meioPagamento,
      Value<double>? valor,
      Value<String>? tipoIntegracao,
      Value<String>? cnpjOperadoraCartao,
      Value<String>? bandeira,
      Value<String>? numeroAutorizacao,
      Value<double>? troco,
	  }) {
    return NfeInformacaoPagamentosCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      indicadorPagamento: indicadorPagamento ?? this.indicadorPagamento,
      meioPagamento: meioPagamento ?? this.meioPagamento,
      valor: valor ?? this.valor,
      tipoIntegracao: tipoIntegracao ?? this.tipoIntegracao,
      cnpjOperadoraCartao: cnpjOperadoraCartao ?? this.cnpjOperadoraCartao,
      bandeira: bandeira ?? this.bandeira,
      numeroAutorizacao: numeroAutorizacao ?? this.numeroAutorizacao,
      troco: troco ?? this.troco,
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
    if (indicadorPagamento.present) {
      map['INDICADOR_PAGAMENTO'] = Variable<String?>(indicadorPagamento.value);
    }
    if (meioPagamento.present) {
      map['MEIO_PAGAMENTO'] = Variable<String?>(meioPagamento.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    if (tipoIntegracao.present) {
      map['TIPO_INTEGRACAO'] = Variable<String?>(tipoIntegracao.value);
    }
    if (cnpjOperadoraCartao.present) {
      map['CNPJ_OPERADORA_CARTAO'] = Variable<String?>(cnpjOperadoraCartao.value);
    }
    if (bandeira.present) {
      map['BANDEIRA'] = Variable<String?>(bandeira.value);
    }
    if (numeroAutorizacao.present) {
      map['NUMERO_AUTORIZACAO'] = Variable<String?>(numeroAutorizacao.value);
    }
    if (troco.present) {
      map['TROCO'] = Variable<double?>(troco.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeInformacaoPagamentosCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('indicadorPagamento: $indicadorPagamento, ')
          ..write('meioPagamento: $meioPagamento, ')
          ..write('valor: $valor, ')
          ..write('tipoIntegracao: $tipoIntegracao, ')
          ..write('cnpjOperadoraCartao: $cnpjOperadoraCartao, ')
          ..write('bandeira: $bandeira, ')
          ..write('numeroAutorizacao: $numeroAutorizacao, ')
          ..write('troco: $troco, ')
          ..write(')'))
        .toString();
  }
}

class $NfeInformacaoPagamentosTable extends NfeInformacaoPagamentos
    with TableInfo<$NfeInformacaoPagamentosTable, NfeInformacaoPagamento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeInformacaoPagamentosTable(this._db, [this._alias]);
  
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
  final VerificationMeta _indicadorPagamentoMeta =
      const VerificationMeta('indicadorPagamento');
  GeneratedColumn<String>? _indicadorPagamento;
  @override
  GeneratedColumn<String> get indicadorPagamento => _indicadorPagamento ??=
      GeneratedColumn<String>('INDICADOR_PAGAMENTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _meioPagamentoMeta =
      const VerificationMeta('meioPagamento');
  GeneratedColumn<String>? _meioPagamento;
  @override
  GeneratedColumn<String> get meioPagamento => _meioPagamento ??=
      GeneratedColumn<String>('MEIO_PAGAMENTO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _valorMeta =
      const VerificationMeta('valor');
  GeneratedColumn<double>? _valor;
  @override
  GeneratedColumn<double> get valor => _valor ??=
      GeneratedColumn<double>('VALOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _tipoIntegracaoMeta =
      const VerificationMeta('tipoIntegracao');
  GeneratedColumn<String>? _tipoIntegracao;
  @override
  GeneratedColumn<String> get tipoIntegracao => _tipoIntegracao ??=
      GeneratedColumn<String>('TIPO_INTEGRACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cnpjOperadoraCartaoMeta =
      const VerificationMeta('cnpjOperadoraCartao');
  GeneratedColumn<String>? _cnpjOperadoraCartao;
  @override
  GeneratedColumn<String> get cnpjOperadoraCartao => _cnpjOperadoraCartao ??=
      GeneratedColumn<String>('CNPJ_OPERADORA_CARTAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _bandeiraMeta =
      const VerificationMeta('bandeira');
  GeneratedColumn<String>? _bandeira;
  @override
  GeneratedColumn<String> get bandeira => _bandeira ??=
      GeneratedColumn<String>('BANDEIRA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _numeroAutorizacaoMeta =
      const VerificationMeta('numeroAutorizacao');
  GeneratedColumn<String>? _numeroAutorizacao;
  @override
  GeneratedColumn<String> get numeroAutorizacao => _numeroAutorizacao ??=
      GeneratedColumn<String>('NUMERO_AUTORIZACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _trocoMeta =
      const VerificationMeta('troco');
  GeneratedColumn<double>? _troco;
  @override
  GeneratedColumn<double> get troco => _troco ??=
      GeneratedColumn<double>('TROCO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        indicadorPagamento,
        meioPagamento,
        valor,
        tipoIntegracao,
        cnpjOperadoraCartao,
        bandeira,
        numeroAutorizacao,
        troco,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_INFORMACAO_PAGAMENTO';
  
  @override
  String get actualTableName => 'NFE_INFORMACAO_PAGAMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeInformacaoPagamento> instance,
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
    if (data.containsKey('INDICADOR_PAGAMENTO')) {
        context.handle(_indicadorPagamentoMeta,
            indicadorPagamento.isAcceptableOrUnknown(data['INDICADOR_PAGAMENTO']!, _indicadorPagamentoMeta));
    }
    if (data.containsKey('MEIO_PAGAMENTO')) {
        context.handle(_meioPagamentoMeta,
            meioPagamento.isAcceptableOrUnknown(data['MEIO_PAGAMENTO']!, _meioPagamentoMeta));
    }
    if (data.containsKey('VALOR')) {
        context.handle(_valorMeta,
            valor.isAcceptableOrUnknown(data['VALOR']!, _valorMeta));
    }
    if (data.containsKey('TIPO_INTEGRACAO')) {
        context.handle(_tipoIntegracaoMeta,
            tipoIntegracao.isAcceptableOrUnknown(data['TIPO_INTEGRACAO']!, _tipoIntegracaoMeta));
    }
    if (data.containsKey('CNPJ_OPERADORA_CARTAO')) {
        context.handle(_cnpjOperadoraCartaoMeta,
            cnpjOperadoraCartao.isAcceptableOrUnknown(data['CNPJ_OPERADORA_CARTAO']!, _cnpjOperadoraCartaoMeta));
    }
    if (data.containsKey('BANDEIRA')) {
        context.handle(_bandeiraMeta,
            bandeira.isAcceptableOrUnknown(data['BANDEIRA']!, _bandeiraMeta));
    }
    if (data.containsKey('NUMERO_AUTORIZACAO')) {
        context.handle(_numeroAutorizacaoMeta,
            numeroAutorizacao.isAcceptableOrUnknown(data['NUMERO_AUTORIZACAO']!, _numeroAutorizacaoMeta));
    }
    if (data.containsKey('TROCO')) {
        context.handle(_trocoMeta,
            troco.isAcceptableOrUnknown(data['TROCO']!, _trocoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeInformacaoPagamento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeInformacaoPagamento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeInformacaoPagamentosTable createAlias(String alias) {
    return $NfeInformacaoPagamentosTable(_db, alias);
  }
}