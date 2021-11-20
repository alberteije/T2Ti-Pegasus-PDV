/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_TOTAL_TIPO_PAGAMENTO] 
                                                                                
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

@DataClassName("PdvTotalTipoPagamento")
@UseRowClass(PdvTotalTipoPagamento)
class PdvTotalTipoPagamentos extends Table {
  @override
  String get tableName => 'PDV_TOTAL_TIPO_PAGAMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idPdvVendaCabecalho => integer().named('ID_PDV_VENDA_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES PDV_VENDA_CABECALHO(ID)')();
  IntColumn get idPdvTipoPagamento => integer().named('ID_PDV_TIPO_PAGAMENTO').nullable().customConstraint('NULLABLE REFERENCES PDV_TIPO_PAGAMENTO(ID)')();
  DateTimeColumn get dataVenda => dateTime().named('DATA_VENDA').nullable()();
  TextColumn get horaVenda => text().named('HORA_VENDA').withLength(min: 0, max: 8).nullable()();
  TextColumn get serieEcf => text().named('SERIE_ECF').withLength(min: 0, max: 20).nullable()();
  IntColumn get coo => integer().named('COO').nullable()();
  IntColumn get ccf => integer().named('CCF').nullable()();
  IntColumn get gnf => integer().named('GNF').nullable()();
  RealColumn get valor => real().named('VALOR').nullable()();
  TextColumn get nsu => text().named('NSU').withLength(min: 0, max: 30).nullable()();
  TextColumn get estorno => text().named('ESTORNO').withLength(min: 0, max: 1).nullable()();
  TextColumn get rede => text().named('REDE').withLength(min: 0, max: 10).nullable()();
  TextColumn get cartaoDc => text().named('CARTAO_DC').withLength(min: 0, max: 1).nullable()();
  TextColumn get hashRegistro => text().named('HASH_REGISTRO').withLength(min: 0, max: 32).nullable()();
}

class PdvTotalTipoPagamento extends DataClass implements Insertable<PdvTotalTipoPagamento> {
  final int? id;
  final int? idPdvVendaCabecalho;
  final int? idPdvTipoPagamento;
  final DateTime? dataVenda;
  final String? horaVenda;
  final String? serieEcf;
  final int? coo;
  final int? ccf;
  final int? gnf;
  final double? valor;
  final String? nsu;
  final String? estorno;
  final String? rede;
  final String? cartaoDc;
  final String? hashRegistro;

  PdvTotalTipoPagamento(
    {
      required this.id,
      this.idPdvVendaCabecalho,
      this.idPdvTipoPagamento,
      this.dataVenda,
      this.horaVenda,
      this.serieEcf,
      this.coo,
      this.ccf,
      this.gnf,
      this.valor,
      this.nsu,
      this.estorno,
      this.rede,
      this.cartaoDc,
      this.hashRegistro,
    }
  );

  factory PdvTotalTipoPagamento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PdvTotalTipoPagamento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idPdvVendaCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_VENDA_CABECALHO']),
      idPdvTipoPagamento: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_TIPO_PAGAMENTO']),
      dataVenda: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}DATA_VENDA']),
      horaVenda: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HORA_VENDA']),
      serieEcf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SERIE_ECF']),
      coo: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}COO']),
      ccf: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}CCF']),
      gnf: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}GNF']),
      valor: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR']),
      nsu: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NSU']),
      estorno: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ESTORNO']),
      rede: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}REDE']),
      cartaoDc: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CARTAO_DC']),
      hashRegistro: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HASH_REGISTRO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idPdvVendaCabecalho != null) {
      map['ID_PDV_VENDA_CABECALHO'] = Variable<int?>(idPdvVendaCabecalho);
    }
    if (!nullToAbsent || idPdvTipoPagamento != null) {
      map['ID_PDV_TIPO_PAGAMENTO'] = Variable<int?>(idPdvTipoPagamento);
    }
    if (!nullToAbsent || dataVenda != null) {
      map['DATA_VENDA'] = Variable<DateTime?>(dataVenda);
    }
    if (!nullToAbsent || horaVenda != null) {
      map['HORA_VENDA'] = Variable<String?>(horaVenda);
    }
    if (!nullToAbsent || serieEcf != null) {
      map['SERIE_ECF'] = Variable<String?>(serieEcf);
    }
    if (!nullToAbsent || coo != null) {
      map['COO'] = Variable<int?>(coo);
    }
    if (!nullToAbsent || ccf != null) {
      map['CCF'] = Variable<int?>(ccf);
    }
    if (!nullToAbsent || gnf != null) {
      map['GNF'] = Variable<int?>(gnf);
    }
    if (!nullToAbsent || valor != null) {
      map['VALOR'] = Variable<double?>(valor);
    }
    if (!nullToAbsent || nsu != null) {
      map['NSU'] = Variable<String?>(nsu);
    }
    if (!nullToAbsent || estorno != null) {
      map['ESTORNO'] = Variable<String?>(estorno);
    }
    if (!nullToAbsent || rede != null) {
      map['REDE'] = Variable<String?>(rede);
    }
    if (!nullToAbsent || cartaoDc != null) {
      map['CARTAO_DC'] = Variable<String?>(cartaoDc);
    }
    if (!nullToAbsent || hashRegistro != null) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro);
    }
    return map;
  }

  PdvTotalTipoPagamentosCompanion toCompanion(bool nullToAbsent) {
    return PdvTotalTipoPagamentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idPdvVendaCabecalho: idPdvVendaCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvVendaCabecalho),
      idPdvTipoPagamento: idPdvTipoPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvTipoPagamento),
      dataVenda: dataVenda == null && nullToAbsent
        ? const Value.absent()
        : Value(dataVenda),
      horaVenda: horaVenda == null && nullToAbsent
        ? const Value.absent()
        : Value(horaVenda),
      serieEcf: serieEcf == null && nullToAbsent
        ? const Value.absent()
        : Value(serieEcf),
      coo: coo == null && nullToAbsent
        ? const Value.absent()
        : Value(coo),
      ccf: ccf == null && nullToAbsent
        ? const Value.absent()
        : Value(ccf),
      gnf: gnf == null && nullToAbsent
        ? const Value.absent()
        : Value(gnf),
      valor: valor == null && nullToAbsent
        ? const Value.absent()
        : Value(valor),
      nsu: nsu == null && nullToAbsent
        ? const Value.absent()
        : Value(nsu),
      estorno: estorno == null && nullToAbsent
        ? const Value.absent()
        : Value(estorno),
      rede: rede == null && nullToAbsent
        ? const Value.absent()
        : Value(rede),
      cartaoDc: cartaoDc == null && nullToAbsent
        ? const Value.absent()
        : Value(cartaoDc),
      hashRegistro: hashRegistro == null && nullToAbsent
        ? const Value.absent()
        : Value(hashRegistro),
    );
  }

  factory PdvTotalTipoPagamento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvTotalTipoPagamento(
      id: serializer.fromJson<int>(json['id']),
      idPdvVendaCabecalho: serializer.fromJson<int>(json['idPdvVendaCabecalho']),
      idPdvTipoPagamento: serializer.fromJson<int>(json['idPdvTipoPagamento']),
      dataVenda: serializer.fromJson<DateTime>(json['dataVenda']),
      horaVenda: serializer.fromJson<String>(json['horaVenda']),
      serieEcf: serializer.fromJson<String>(json['serieEcf']),
      coo: serializer.fromJson<int>(json['coo']),
      ccf: serializer.fromJson<int>(json['ccf']),
      gnf: serializer.fromJson<int>(json['gnf']),
      valor: serializer.fromJson<double>(json['valor']),
      nsu: serializer.fromJson<String>(json['nsu']),
      estorno: serializer.fromJson<String>(json['estorno']),
      rede: serializer.fromJson<String>(json['rede']),
      cartaoDc: serializer.fromJson<String>(json['cartaoDc']),
      hashRegistro: serializer.fromJson<String>(json['hashRegistro']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idPdvVendaCabecalho': serializer.toJson<int?>(idPdvVendaCabecalho),
      'idPdvTipoPagamento': serializer.toJson<int?>(idPdvTipoPagamento),
      'dataVenda': serializer.toJson<DateTime?>(dataVenda),
      'horaVenda': serializer.toJson<String?>(horaVenda),
      'serieEcf': serializer.toJson<String?>(serieEcf),
      'coo': serializer.toJson<int?>(coo),
      'ccf': serializer.toJson<int?>(ccf),
      'gnf': serializer.toJson<int?>(gnf),
      'valor': serializer.toJson<double?>(valor),
      'nsu': serializer.toJson<String?>(nsu),
      'estorno': serializer.toJson<String?>(estorno),
      'rede': serializer.toJson<String?>(rede),
      'cartaoDc': serializer.toJson<String?>(cartaoDc),
      'hashRegistro': serializer.toJson<String?>(hashRegistro),
    };
  }

  PdvTotalTipoPagamento copyWith(
        {
		  int? id,
          int? idPdvVendaCabecalho,
          int? idPdvTipoPagamento,
          DateTime? dataVenda,
          String? horaVenda,
          String? serieEcf,
          int? coo,
          int? ccf,
          int? gnf,
          double? valor,
          String? nsu,
          String? estorno,
          String? rede,
          String? cartaoDc,
          String? hashRegistro,
		}) =>
      PdvTotalTipoPagamento(
        id: id ?? this.id,
        idPdvVendaCabecalho: idPdvVendaCabecalho ?? this.idPdvVendaCabecalho,
        idPdvTipoPagamento: idPdvTipoPagamento ?? this.idPdvTipoPagamento,
        dataVenda: dataVenda ?? this.dataVenda,
        horaVenda: horaVenda ?? this.horaVenda,
        serieEcf: serieEcf ?? this.serieEcf,
        coo: coo ?? this.coo,
        ccf: ccf ?? this.ccf,
        gnf: gnf ?? this.gnf,
        valor: valor ?? this.valor,
        nsu: nsu ?? this.nsu,
        estorno: estorno ?? this.estorno,
        rede: rede ?? this.rede,
        cartaoDc: cartaoDc ?? this.cartaoDc,
        hashRegistro: hashRegistro ?? this.hashRegistro,
      );
  
  @override
  String toString() {
    return (StringBuffer('PdvTotalTipoPagamento(')
          ..write('id: $id, ')
          ..write('idPdvVendaCabecalho: $idPdvVendaCabecalho, ')
          ..write('idPdvTipoPagamento: $idPdvTipoPagamento, ')
          ..write('dataVenda: $dataVenda, ')
          ..write('horaVenda: $horaVenda, ')
          ..write('serieEcf: $serieEcf, ')
          ..write('coo: $coo, ')
          ..write('ccf: $ccf, ')
          ..write('gnf: $gnf, ')
          ..write('valor: $valor, ')
          ..write('nsu: $nsu, ')
          ..write('estorno: $estorno, ')
          ..write('rede: $rede, ')
          ..write('cartaoDc: $cartaoDc, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idPdvVendaCabecalho,
      idPdvTipoPagamento,
      dataVenda,
      horaVenda,
      serieEcf,
      coo,
      ccf,
      gnf,
      valor,
      nsu,
      estorno,
      rede,
      cartaoDc,
      hashRegistro,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdvTotalTipoPagamento &&
          other.id == id &&
          other.idPdvVendaCabecalho == idPdvVendaCabecalho &&
          other.idPdvTipoPagamento == idPdvTipoPagamento &&
          other.dataVenda == dataVenda &&
          other.horaVenda == horaVenda &&
          other.serieEcf == serieEcf &&
          other.coo == coo &&
          other.ccf == ccf &&
          other.gnf == gnf &&
          other.valor == valor &&
          other.nsu == nsu &&
          other.estorno == estorno &&
          other.rede == rede &&
          other.cartaoDc == cartaoDc &&
          other.hashRegistro == hashRegistro 
	   );
}

class PdvTotalTipoPagamentosCompanion extends UpdateCompanion<PdvTotalTipoPagamento> {

  final Value<int?> id;
  final Value<int?> idPdvVendaCabecalho;
  final Value<int?> idPdvTipoPagamento;
  final Value<DateTime?> dataVenda;
  final Value<String?> horaVenda;
  final Value<String?> serieEcf;
  final Value<int?> coo;
  final Value<int?> ccf;
  final Value<int?> gnf;
  final Value<double?> valor;
  final Value<String?> nsu;
  final Value<String?> estorno;
  final Value<String?> rede;
  final Value<String?> cartaoDc;
  final Value<String?> hashRegistro;

  const PdvTotalTipoPagamentosCompanion({
    this.id = const Value.absent(),
    this.idPdvVendaCabecalho = const Value.absent(),
    this.idPdvTipoPagamento = const Value.absent(),
    this.dataVenda = const Value.absent(),
    this.horaVenda = const Value.absent(),
    this.serieEcf = const Value.absent(),
    this.coo = const Value.absent(),
    this.ccf = const Value.absent(),
    this.gnf = const Value.absent(),
    this.valor = const Value.absent(),
    this.nsu = const Value.absent(),
    this.estorno = const Value.absent(),
    this.rede = const Value.absent(),
    this.cartaoDc = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  PdvTotalTipoPagamentosCompanion.insert({
    this.id = const Value.absent(),
    this.idPdvVendaCabecalho = const Value.absent(),
    this.idPdvTipoPagamento = const Value.absent(),
    this.dataVenda = const Value.absent(),
    this.horaVenda = const Value.absent(),
    this.serieEcf = const Value.absent(),
    this.coo = const Value.absent(),
    this.ccf = const Value.absent(),
    this.gnf = const Value.absent(),
    this.valor = const Value.absent(),
    this.nsu = const Value.absent(),
    this.estorno = const Value.absent(),
    this.rede = const Value.absent(),
    this.cartaoDc = const Value.absent(),
    this.hashRegistro = const Value.absent(),
  });

  static Insertable<PdvTotalTipoPagamento> custom({
    Expression<int>? id,
    Expression<int>? idPdvVendaCabecalho,
    Expression<int>? idPdvTipoPagamento,
    Expression<DateTime>? dataVenda,
    Expression<String>? horaVenda,
    Expression<String>? serieEcf,
    Expression<int>? coo,
    Expression<int>? ccf,
    Expression<int>? gnf,
    Expression<double>? valor,
    Expression<String>? nsu,
    Expression<String>? estorno,
    Expression<String>? rede,
    Expression<String>? cartaoDc,
    Expression<String>? hashRegistro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idPdvVendaCabecalho != null) 'ID_PDV_VENDA_CABECALHO': idPdvVendaCabecalho,
      if (idPdvTipoPagamento != null) 'ID_PDV_TIPO_PAGAMENTO': idPdvTipoPagamento,
      if (dataVenda != null) 'DATA_VENDA': dataVenda,
      if (horaVenda != null) 'HORA_VENDA': horaVenda,
      if (serieEcf != null) 'SERIE_ECF': serieEcf,
      if (coo != null) 'COO': coo,
      if (ccf != null) 'CCF': ccf,
      if (gnf != null) 'GNF': gnf,
      if (valor != null) 'VALOR': valor,
      if (nsu != null) 'NSU': nsu,
      if (estorno != null) 'ESTORNO': estorno,
      if (rede != null) 'REDE': rede,
      if (cartaoDc != null) 'CARTAO_DC': cartaoDc,
      if (hashRegistro != null) 'HASH_REGISTRO': hashRegistro,
    });
  }

  PdvTotalTipoPagamentosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idPdvVendaCabecalho,
      Value<int>? idPdvTipoPagamento,
      Value<DateTime>? dataVenda,
      Value<String>? horaVenda,
      Value<String>? serieEcf,
      Value<int>? coo,
      Value<int>? ccf,
      Value<int>? gnf,
      Value<double>? valor,
      Value<String>? nsu,
      Value<String>? estorno,
      Value<String>? rede,
      Value<String>? cartaoDc,
      Value<String>? hashRegistro,
	  }) {
    return PdvTotalTipoPagamentosCompanion(
      id: id ?? this.id,
      idPdvVendaCabecalho: idPdvVendaCabecalho ?? this.idPdvVendaCabecalho,
      idPdvTipoPagamento: idPdvTipoPagamento ?? this.idPdvTipoPagamento,
      dataVenda: dataVenda ?? this.dataVenda,
      horaVenda: horaVenda ?? this.horaVenda,
      serieEcf: serieEcf ?? this.serieEcf,
      coo: coo ?? this.coo,
      ccf: ccf ?? this.ccf,
      gnf: gnf ?? this.gnf,
      valor: valor ?? this.valor,
      nsu: nsu ?? this.nsu,
      estorno: estorno ?? this.estorno,
      rede: rede ?? this.rede,
      cartaoDc: cartaoDc ?? this.cartaoDc,
      hashRegistro: hashRegistro ?? this.hashRegistro,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idPdvVendaCabecalho.present) {
      map['ID_PDV_VENDA_CABECALHO'] = Variable<int?>(idPdvVendaCabecalho.value);
    }
    if (idPdvTipoPagamento.present) {
      map['ID_PDV_TIPO_PAGAMENTO'] = Variable<int?>(idPdvTipoPagamento.value);
    }
    if (dataVenda.present) {
      map['DATA_VENDA'] = Variable<DateTime?>(dataVenda.value);
    }
    if (horaVenda.present) {
      map['HORA_VENDA'] = Variable<String?>(horaVenda.value);
    }
    if (serieEcf.present) {
      map['SERIE_ECF'] = Variable<String?>(serieEcf.value);
    }
    if (coo.present) {
      map['COO'] = Variable<int?>(coo.value);
    }
    if (ccf.present) {
      map['CCF'] = Variable<int?>(ccf.value);
    }
    if (gnf.present) {
      map['GNF'] = Variable<int?>(gnf.value);
    }
    if (valor.present) {
      map['VALOR'] = Variable<double?>(valor.value);
    }
    if (nsu.present) {
      map['NSU'] = Variable<String?>(nsu.value);
    }
    if (estorno.present) {
      map['ESTORNO'] = Variable<String?>(estorno.value);
    }
    if (rede.present) {
      map['REDE'] = Variable<String?>(rede.value);
    }
    if (cartaoDc.present) {
      map['CARTAO_DC'] = Variable<String?>(cartaoDc.value);
    }
    if (hashRegistro.present) {
      map['HASH_REGISTRO'] = Variable<String?>(hashRegistro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdvTotalTipoPagamentosCompanion(')
          ..write('id: $id, ')
          ..write('idPdvVendaCabecalho: $idPdvVendaCabecalho, ')
          ..write('idPdvTipoPagamento: $idPdvTipoPagamento, ')
          ..write('dataVenda: $dataVenda, ')
          ..write('horaVenda: $horaVenda, ')
          ..write('serieEcf: $serieEcf, ')
          ..write('coo: $coo, ')
          ..write('ccf: $ccf, ')
          ..write('gnf: $gnf, ')
          ..write('valor: $valor, ')
          ..write('nsu: $nsu, ')
          ..write('estorno: $estorno, ')
          ..write('rede: $rede, ')
          ..write('cartaoDc: $cartaoDc, ')
          ..write('hashRegistro: $hashRegistro, ')
          ..write(')'))
        .toString();
  }
}

class $PdvTotalTipoPagamentosTable extends PdvTotalTipoPagamentos
    with TableInfo<$PdvTotalTipoPagamentosTable, PdvTotalTipoPagamento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PdvTotalTipoPagamentosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idPdvVendaCabecalhoMeta =
      const VerificationMeta('idPdvVendaCabecalho');
  GeneratedColumn<int>? _idPdvVendaCabecalho;
  @override
  GeneratedColumn<int> get idPdvVendaCabecalho =>
      _idPdvVendaCabecalho ??= GeneratedColumn<int>('ID_PDV_VENDA_CABECALHO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PDV_VENDA_CABECALHO(ID)');
  final VerificationMeta _idPdvTipoPagamentoMeta =
      const VerificationMeta('idPdvTipoPagamento');
  GeneratedColumn<int>? _idPdvTipoPagamento;
  @override
  GeneratedColumn<int> get idPdvTipoPagamento =>
      _idPdvTipoPagamento ??= GeneratedColumn<int>('ID_PDV_TIPO_PAGAMENTO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PDV_TIPO_PAGAMENTO(ID)');
  final VerificationMeta _dataVendaMeta =
      const VerificationMeta('dataVenda');
  GeneratedColumn<DateTime>? _dataVenda;
  @override
  GeneratedColumn<DateTime> get dataVenda => _dataVenda ??=
      GeneratedColumn<DateTime>('DATA_VENDA', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _horaVendaMeta =
      const VerificationMeta('horaVenda');
  GeneratedColumn<String>? _horaVenda;
  @override
  GeneratedColumn<String> get horaVenda => _horaVenda ??=
      GeneratedColumn<String>('HORA_VENDA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _serieEcfMeta =
      const VerificationMeta('serieEcf');
  GeneratedColumn<String>? _serieEcf;
  @override
  GeneratedColumn<String> get serieEcf => _serieEcf ??=
      GeneratedColumn<String>('SERIE_ECF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cooMeta =
      const VerificationMeta('coo');
  GeneratedColumn<int>? _coo;
  @override
  GeneratedColumn<int> get coo => _coo ??=
      GeneratedColumn<int>('COO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _ccfMeta =
      const VerificationMeta('ccf');
  GeneratedColumn<int>? _ccf;
  @override
  GeneratedColumn<int> get ccf => _ccf ??=
      GeneratedColumn<int>('CCF', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _gnfMeta =
      const VerificationMeta('gnf');
  GeneratedColumn<int>? _gnf;
  @override
  GeneratedColumn<int> get gnf => _gnf ??=
      GeneratedColumn<int>('GNF', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _valorMeta =
      const VerificationMeta('valor');
  GeneratedColumn<double>? _valor;
  @override
  GeneratedColumn<double> get valor => _valor ??=
      GeneratedColumn<double>('VALOR', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _nsuMeta =
      const VerificationMeta('nsu');
  GeneratedColumn<String>? _nsu;
  @override
  GeneratedColumn<String> get nsu => _nsu ??=
      GeneratedColumn<String>('NSU', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _estornoMeta =
      const VerificationMeta('estorno');
  GeneratedColumn<String>? _estorno;
  @override
  GeneratedColumn<String> get estorno => _estorno ??=
      GeneratedColumn<String>('ESTORNO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _redeMeta =
      const VerificationMeta('rede');
  GeneratedColumn<String>? _rede;
  @override
  GeneratedColumn<String> get rede => _rede ??=
      GeneratedColumn<String>('REDE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cartaoDcMeta =
      const VerificationMeta('cartaoDc');
  GeneratedColumn<String>? _cartaoDc;
  @override
  GeneratedColumn<String> get cartaoDc => _cartaoDc ??=
      GeneratedColumn<String>('CARTAO_DC', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
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
        idPdvVendaCabecalho,
        idPdvTipoPagamento,
        dataVenda,
        horaVenda,
        serieEcf,
        coo,
        ccf,
        gnf,
        valor,
        nsu,
        estorno,
        rede,
        cartaoDc,
        hashRegistro,
      ];

  @override
  String get aliasedName => _alias ?? 'PDV_TOTAL_TIPO_PAGAMENTO';
  
  @override
  String get actualTableName => 'PDV_TOTAL_TIPO_PAGAMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<PdvTotalTipoPagamento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_PDV_VENDA_CABECALHO')) {
        context.handle(_idPdvVendaCabecalhoMeta,
            idPdvVendaCabecalho.isAcceptableOrUnknown(data['ID_PDV_VENDA_CABECALHO']!, _idPdvVendaCabecalhoMeta));
    }
    if (data.containsKey('ID_PDV_TIPO_PAGAMENTO')) {
        context.handle(_idPdvTipoPagamentoMeta,
            idPdvTipoPagamento.isAcceptableOrUnknown(data['ID_PDV_TIPO_PAGAMENTO']!, _idPdvTipoPagamentoMeta));
    }
    if (data.containsKey('DATA_VENDA')) {
        context.handle(_dataVendaMeta,
            dataVenda.isAcceptableOrUnknown(data['DATA_VENDA']!, _dataVendaMeta));
    }
    if (data.containsKey('HORA_VENDA')) {
        context.handle(_horaVendaMeta,
            horaVenda.isAcceptableOrUnknown(data['HORA_VENDA']!, _horaVendaMeta));
    }
    if (data.containsKey('SERIE_ECF')) {
        context.handle(_serieEcfMeta,
            serieEcf.isAcceptableOrUnknown(data['SERIE_ECF']!, _serieEcfMeta));
    }
    if (data.containsKey('COO')) {
        context.handle(_cooMeta,
            coo.isAcceptableOrUnknown(data['COO']!, _cooMeta));
    }
    if (data.containsKey('CCF')) {
        context.handle(_ccfMeta,
            ccf.isAcceptableOrUnknown(data['CCF']!, _ccfMeta));
    }
    if (data.containsKey('GNF')) {
        context.handle(_gnfMeta,
            gnf.isAcceptableOrUnknown(data['GNF']!, _gnfMeta));
    }
    if (data.containsKey('VALOR')) {
        context.handle(_valorMeta,
            valor.isAcceptableOrUnknown(data['VALOR']!, _valorMeta));
    }
    if (data.containsKey('NSU')) {
        context.handle(_nsuMeta,
            nsu.isAcceptableOrUnknown(data['NSU']!, _nsuMeta));
    }
    if (data.containsKey('ESTORNO')) {
        context.handle(_estornoMeta,
            estorno.isAcceptableOrUnknown(data['ESTORNO']!, _estornoMeta));
    }
    if (data.containsKey('REDE')) {
        context.handle(_redeMeta,
            rede.isAcceptableOrUnknown(data['REDE']!, _redeMeta));
    }
    if (data.containsKey('CARTAO_DC')) {
        context.handle(_cartaoDcMeta,
            cartaoDc.isAcceptableOrUnknown(data['CARTAO_DC']!, _cartaoDcMeta));
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
  PdvTotalTipoPagamento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PdvTotalTipoPagamento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PdvTotalTipoPagamentosTable createAlias(String alias) {
    return $PdvTotalTipoPagamentosTable(_db, alias);
  }
}