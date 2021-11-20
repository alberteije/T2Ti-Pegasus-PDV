/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [TRIBUT_ISS] 
                                                                                
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

@DataClassName("TributIss")
@UseRowClass(TributIss)
class TributIsss extends Table {
  @override
  String get tableName => 'TRIBUT_ISS';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idTributOperacaoFiscal => integer().named('ID_TRIBUT_OPERACAO_FISCAL').nullable().customConstraint('NULLABLE REFERENCES TRIBUT_OPERACAO_FISCAL(ID)')();
  TextColumn get modalidadeBaseCalculo => text().named('MODALIDADE_BASE_CALCULO').withLength(min: 0, max: 1).nullable()();
  RealColumn get porcentoBaseCalculo => real().named('PORCENTO_BASE_CALCULO').nullable()();
  RealColumn get aliquotaPorcento => real().named('ALIQUOTA_PORCENTO').nullable()();
  RealColumn get aliquotaUnidade => real().named('ALIQUOTA_UNIDADE').nullable()();
  RealColumn get valorPrecoMaximo => real().named('VALOR_PRECO_MAXIMO').nullable()();
  RealColumn get valorPautaFiscal => real().named('VALOR_PAUTA_FISCAL').nullable()();
  IntColumn get itemListaServico => integer().named('ITEM_LISTA_SERVICO').nullable()();
  TextColumn get codigoTributacao => text().named('CODIGO_TRIBUTACAO').withLength(min: 0, max: 1).nullable()();
}

class TributIss extends DataClass implements Insertable<TributIss> {
  final int? id;
  final int? idTributOperacaoFiscal;
  final String? modalidadeBaseCalculo;
  final double? porcentoBaseCalculo;
  final double? aliquotaPorcento;
  final double? aliquotaUnidade;
  final double? valorPrecoMaximo;
  final double? valorPautaFiscal;
  final int? itemListaServico;
  final String? codigoTributacao;

  TributIss(
    {
      required this.id,
      this.idTributOperacaoFiscal,
      this.modalidadeBaseCalculo,
      this.porcentoBaseCalculo,
      this.aliquotaPorcento,
      this.aliquotaUnidade,
      this.valorPrecoMaximo,
      this.valorPautaFiscal,
      this.itemListaServico,
      this.codigoTributacao,
    }
  );

  factory TributIss.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TributIss(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idTributOperacaoFiscal: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_TRIBUT_OPERACAO_FISCAL']),
      modalidadeBaseCalculo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}MODALIDADE_BASE_CALCULO']),
      porcentoBaseCalculo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}PORCENTO_BASE_CALCULO']),
      aliquotaPorcento: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_PORCENTO']),
      aliquotaUnidade: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}ALIQUOTA_UNIDADE']),
      valorPrecoMaximo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PRECO_MAXIMO']),
      valorPautaFiscal: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}VALOR_PAUTA_FISCAL']),
      itemListaServico: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ITEM_LISTA_SERVICO']),
      codigoTributacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_TRIBUTACAO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idTributOperacaoFiscal != null) {
      map['ID_TRIBUT_OPERACAO_FISCAL'] = Variable<int?>(idTributOperacaoFiscal);
    }
    if (!nullToAbsent || modalidadeBaseCalculo != null) {
      map['MODALIDADE_BASE_CALCULO'] = Variable<String?>(modalidadeBaseCalculo);
    }
    if (!nullToAbsent || porcentoBaseCalculo != null) {
      map['PORCENTO_BASE_CALCULO'] = Variable<double?>(porcentoBaseCalculo);
    }
    if (!nullToAbsent || aliquotaPorcento != null) {
      map['ALIQUOTA_PORCENTO'] = Variable<double?>(aliquotaPorcento);
    }
    if (!nullToAbsent || aliquotaUnidade != null) {
      map['ALIQUOTA_UNIDADE'] = Variable<double?>(aliquotaUnidade);
    }
    if (!nullToAbsent || valorPrecoMaximo != null) {
      map['VALOR_PRECO_MAXIMO'] = Variable<double?>(valorPrecoMaximo);
    }
    if (!nullToAbsent || valorPautaFiscal != null) {
      map['VALOR_PAUTA_FISCAL'] = Variable<double?>(valorPautaFiscal);
    }
    if (!nullToAbsent || itemListaServico != null) {
      map['ITEM_LISTA_SERVICO'] = Variable<int?>(itemListaServico);
    }
    if (!nullToAbsent || codigoTributacao != null) {
      map['CODIGO_TRIBUTACAO'] = Variable<String?>(codigoTributacao);
    }
    return map;
  }

  TributIsssCompanion toCompanion(bool nullToAbsent) {
    return TributIsssCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idTributOperacaoFiscal: idTributOperacaoFiscal == null && nullToAbsent
        ? const Value.absent()
        : Value(idTributOperacaoFiscal),
      modalidadeBaseCalculo: modalidadeBaseCalculo == null && nullToAbsent
        ? const Value.absent()
        : Value(modalidadeBaseCalculo),
      porcentoBaseCalculo: porcentoBaseCalculo == null && nullToAbsent
        ? const Value.absent()
        : Value(porcentoBaseCalculo),
      aliquotaPorcento: aliquotaPorcento == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaPorcento),
      aliquotaUnidade: aliquotaUnidade == null && nullToAbsent
        ? const Value.absent()
        : Value(aliquotaUnidade),
      valorPrecoMaximo: valorPrecoMaximo == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPrecoMaximo),
      valorPautaFiscal: valorPautaFiscal == null && nullToAbsent
        ? const Value.absent()
        : Value(valorPautaFiscal),
      itemListaServico: itemListaServico == null && nullToAbsent
        ? const Value.absent()
        : Value(itemListaServico),
      codigoTributacao: codigoTributacao == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoTributacao),
    );
  }

  factory TributIss.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TributIss(
      id: serializer.fromJson<int>(json['id']),
      idTributOperacaoFiscal: serializer.fromJson<int>(json['idTributOperacaoFiscal']),
      modalidadeBaseCalculo: serializer.fromJson<String>(json['modalidadeBaseCalculo']),
      porcentoBaseCalculo: serializer.fromJson<double>(json['porcentoBaseCalculo']),
      aliquotaPorcento: serializer.fromJson<double>(json['aliquotaPorcento']),
      aliquotaUnidade: serializer.fromJson<double>(json['aliquotaUnidade']),
      valorPrecoMaximo: serializer.fromJson<double>(json['valorPrecoMaximo']),
      valorPautaFiscal: serializer.fromJson<double>(json['valorPautaFiscal']),
      itemListaServico: serializer.fromJson<int>(json['itemListaServico']),
      codigoTributacao: serializer.fromJson<String>(json['codigoTributacao']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idTributOperacaoFiscal': serializer.toJson<int?>(idTributOperacaoFiscal),
      'modalidadeBaseCalculo': serializer.toJson<String?>(modalidadeBaseCalculo),
      'porcentoBaseCalculo': serializer.toJson<double?>(porcentoBaseCalculo),
      'aliquotaPorcento': serializer.toJson<double?>(aliquotaPorcento),
      'aliquotaUnidade': serializer.toJson<double?>(aliquotaUnidade),
      'valorPrecoMaximo': serializer.toJson<double?>(valorPrecoMaximo),
      'valorPautaFiscal': serializer.toJson<double?>(valorPautaFiscal),
      'itemListaServico': serializer.toJson<int?>(itemListaServico),
      'codigoTributacao': serializer.toJson<String?>(codigoTributacao),
    };
  }

  TributIss copyWith(
        {
		  int? id,
          int? idTributOperacaoFiscal,
          String? modalidadeBaseCalculo,
          double? porcentoBaseCalculo,
          double? aliquotaPorcento,
          double? aliquotaUnidade,
          double? valorPrecoMaximo,
          double? valorPautaFiscal,
          int? itemListaServico,
          String? codigoTributacao,
		}) =>
      TributIss(
        id: id ?? this.id,
        idTributOperacaoFiscal: idTributOperacaoFiscal ?? this.idTributOperacaoFiscal,
        modalidadeBaseCalculo: modalidadeBaseCalculo ?? this.modalidadeBaseCalculo,
        porcentoBaseCalculo: porcentoBaseCalculo ?? this.porcentoBaseCalculo,
        aliquotaPorcento: aliquotaPorcento ?? this.aliquotaPorcento,
        aliquotaUnidade: aliquotaUnidade ?? this.aliquotaUnidade,
        valorPrecoMaximo: valorPrecoMaximo ?? this.valorPrecoMaximo,
        valorPautaFiscal: valorPautaFiscal ?? this.valorPautaFiscal,
        itemListaServico: itemListaServico ?? this.itemListaServico,
        codigoTributacao: codigoTributacao ?? this.codigoTributacao,
      );
  
  @override
  String toString() {
    return (StringBuffer('TributIss(')
          ..write('id: $id, ')
          ..write('idTributOperacaoFiscal: $idTributOperacaoFiscal, ')
          ..write('modalidadeBaseCalculo: $modalidadeBaseCalculo, ')
          ..write('porcentoBaseCalculo: $porcentoBaseCalculo, ')
          ..write('aliquotaPorcento: $aliquotaPorcento, ')
          ..write('aliquotaUnidade: $aliquotaUnidade, ')
          ..write('valorPrecoMaximo: $valorPrecoMaximo, ')
          ..write('valorPautaFiscal: $valorPautaFiscal, ')
          ..write('itemListaServico: $itemListaServico, ')
          ..write('codigoTributacao: $codigoTributacao, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idTributOperacaoFiscal,
      modalidadeBaseCalculo,
      porcentoBaseCalculo,
      aliquotaPorcento,
      aliquotaUnidade,
      valorPrecoMaximo,
      valorPautaFiscal,
      itemListaServico,
      codigoTributacao,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TributIss &&
          other.id == id &&
          other.idTributOperacaoFiscal == idTributOperacaoFiscal &&
          other.modalidadeBaseCalculo == modalidadeBaseCalculo &&
          other.porcentoBaseCalculo == porcentoBaseCalculo &&
          other.aliquotaPorcento == aliquotaPorcento &&
          other.aliquotaUnidade == aliquotaUnidade &&
          other.valorPrecoMaximo == valorPrecoMaximo &&
          other.valorPautaFiscal == valorPautaFiscal &&
          other.itemListaServico == itemListaServico &&
          other.codigoTributacao == codigoTributacao 
	   );
}

class TributIsssCompanion extends UpdateCompanion<TributIss> {

  final Value<int?> id;
  final Value<int?> idTributOperacaoFiscal;
  final Value<String?> modalidadeBaseCalculo;
  final Value<double?> porcentoBaseCalculo;
  final Value<double?> aliquotaPorcento;
  final Value<double?> aliquotaUnidade;
  final Value<double?> valorPrecoMaximo;
  final Value<double?> valorPautaFiscal;
  final Value<int?> itemListaServico;
  final Value<String?> codigoTributacao;

  const TributIsssCompanion({
    this.id = const Value.absent(),
    this.idTributOperacaoFiscal = const Value.absent(),
    this.modalidadeBaseCalculo = const Value.absent(),
    this.porcentoBaseCalculo = const Value.absent(),
    this.aliquotaPorcento = const Value.absent(),
    this.aliquotaUnidade = const Value.absent(),
    this.valorPrecoMaximo = const Value.absent(),
    this.valorPautaFiscal = const Value.absent(),
    this.itemListaServico = const Value.absent(),
    this.codigoTributacao = const Value.absent(),
  });

  TributIsssCompanion.insert({
    this.id = const Value.absent(),
    this.idTributOperacaoFiscal = const Value.absent(),
    this.modalidadeBaseCalculo = const Value.absent(),
    this.porcentoBaseCalculo = const Value.absent(),
    this.aliquotaPorcento = const Value.absent(),
    this.aliquotaUnidade = const Value.absent(),
    this.valorPrecoMaximo = const Value.absent(),
    this.valorPautaFiscal = const Value.absent(),
    this.itemListaServico = const Value.absent(),
    this.codigoTributacao = const Value.absent(),
  });

  static Insertable<TributIss> custom({
    Expression<int>? id,
    Expression<int>? idTributOperacaoFiscal,
    Expression<String>? modalidadeBaseCalculo,
    Expression<double>? porcentoBaseCalculo,
    Expression<double>? aliquotaPorcento,
    Expression<double>? aliquotaUnidade,
    Expression<double>? valorPrecoMaximo,
    Expression<double>? valorPautaFiscal,
    Expression<int>? itemListaServico,
    Expression<String>? codigoTributacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idTributOperacaoFiscal != null) 'ID_TRIBUT_OPERACAO_FISCAL': idTributOperacaoFiscal,
      if (modalidadeBaseCalculo != null) 'MODALIDADE_BASE_CALCULO': modalidadeBaseCalculo,
      if (porcentoBaseCalculo != null) 'PORCENTO_BASE_CALCULO': porcentoBaseCalculo,
      if (aliquotaPorcento != null) 'ALIQUOTA_PORCENTO': aliquotaPorcento,
      if (aliquotaUnidade != null) 'ALIQUOTA_UNIDADE': aliquotaUnidade,
      if (valorPrecoMaximo != null) 'VALOR_PRECO_MAXIMO': valorPrecoMaximo,
      if (valorPautaFiscal != null) 'VALOR_PAUTA_FISCAL': valorPautaFiscal,
      if (itemListaServico != null) 'ITEM_LISTA_SERVICO': itemListaServico,
      if (codigoTributacao != null) 'CODIGO_TRIBUTACAO': codigoTributacao,
    });
  }

  TributIsssCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idTributOperacaoFiscal,
      Value<String>? modalidadeBaseCalculo,
      Value<double>? porcentoBaseCalculo,
      Value<double>? aliquotaPorcento,
      Value<double>? aliquotaUnidade,
      Value<double>? valorPrecoMaximo,
      Value<double>? valorPautaFiscal,
      Value<int>? itemListaServico,
      Value<String>? codigoTributacao,
	  }) {
    return TributIsssCompanion(
      id: id ?? this.id,
      idTributOperacaoFiscal: idTributOperacaoFiscal ?? this.idTributOperacaoFiscal,
      modalidadeBaseCalculo: modalidadeBaseCalculo ?? this.modalidadeBaseCalculo,
      porcentoBaseCalculo: porcentoBaseCalculo ?? this.porcentoBaseCalculo,
      aliquotaPorcento: aliquotaPorcento ?? this.aliquotaPorcento,
      aliquotaUnidade: aliquotaUnidade ?? this.aliquotaUnidade,
      valorPrecoMaximo: valorPrecoMaximo ?? this.valorPrecoMaximo,
      valorPautaFiscal: valorPautaFiscal ?? this.valorPautaFiscal,
      itemListaServico: itemListaServico ?? this.itemListaServico,
      codigoTributacao: codigoTributacao ?? this.codigoTributacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idTributOperacaoFiscal.present) {
      map['ID_TRIBUT_OPERACAO_FISCAL'] = Variable<int?>(idTributOperacaoFiscal.value);
    }
    if (modalidadeBaseCalculo.present) {
      map['MODALIDADE_BASE_CALCULO'] = Variable<String?>(modalidadeBaseCalculo.value);
    }
    if (porcentoBaseCalculo.present) {
      map['PORCENTO_BASE_CALCULO'] = Variable<double?>(porcentoBaseCalculo.value);
    }
    if (aliquotaPorcento.present) {
      map['ALIQUOTA_PORCENTO'] = Variable<double?>(aliquotaPorcento.value);
    }
    if (aliquotaUnidade.present) {
      map['ALIQUOTA_UNIDADE'] = Variable<double?>(aliquotaUnidade.value);
    }
    if (valorPrecoMaximo.present) {
      map['VALOR_PRECO_MAXIMO'] = Variable<double?>(valorPrecoMaximo.value);
    }
    if (valorPautaFiscal.present) {
      map['VALOR_PAUTA_FISCAL'] = Variable<double?>(valorPautaFiscal.value);
    }
    if (itemListaServico.present) {
      map['ITEM_LISTA_SERVICO'] = Variable<int?>(itemListaServico.value);
    }
    if (codigoTributacao.present) {
      map['CODIGO_TRIBUTACAO'] = Variable<String?>(codigoTributacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TributIsssCompanion(')
          ..write('id: $id, ')
          ..write('idTributOperacaoFiscal: $idTributOperacaoFiscal, ')
          ..write('modalidadeBaseCalculo: $modalidadeBaseCalculo, ')
          ..write('porcentoBaseCalculo: $porcentoBaseCalculo, ')
          ..write('aliquotaPorcento: $aliquotaPorcento, ')
          ..write('aliquotaUnidade: $aliquotaUnidade, ')
          ..write('valorPrecoMaximo: $valorPrecoMaximo, ')
          ..write('valorPautaFiscal: $valorPautaFiscal, ')
          ..write('itemListaServico: $itemListaServico, ')
          ..write('codigoTributacao: $codigoTributacao, ')
          ..write(')'))
        .toString();
  }
}

class $TributIsssTable extends TributIsss
    with TableInfo<$TributIsssTable, TributIss> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TributIsssTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idTributOperacaoFiscalMeta =
      const VerificationMeta('idTributOperacaoFiscal');
  GeneratedColumn<int>? _idTributOperacaoFiscal;
  @override
  GeneratedColumn<int> get idTributOperacaoFiscal =>
      _idTributOperacaoFiscal ??= GeneratedColumn<int>('ID_TRIBUT_OPERACAO_FISCAL', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES TRIBUT_OPERACAO_FISCAL(ID)');
  final VerificationMeta _modalidadeBaseCalculoMeta =
      const VerificationMeta('modalidadeBaseCalculo');
  GeneratedColumn<String>? _modalidadeBaseCalculo;
  @override
  GeneratedColumn<String> get modalidadeBaseCalculo => _modalidadeBaseCalculo ??=
      GeneratedColumn<String>('MODALIDADE_BASE_CALCULO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _porcentoBaseCalculoMeta =
      const VerificationMeta('porcentoBaseCalculo');
  GeneratedColumn<double>? _porcentoBaseCalculo;
  @override
  GeneratedColumn<double> get porcentoBaseCalculo => _porcentoBaseCalculo ??=
      GeneratedColumn<double>('PORCENTO_BASE_CALCULO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaPorcentoMeta =
      const VerificationMeta('aliquotaPorcento');
  GeneratedColumn<double>? _aliquotaPorcento;
  @override
  GeneratedColumn<double> get aliquotaPorcento => _aliquotaPorcento ??=
      GeneratedColumn<double>('ALIQUOTA_PORCENTO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _aliquotaUnidadeMeta =
      const VerificationMeta('aliquotaUnidade');
  GeneratedColumn<double>? _aliquotaUnidade;
  @override
  GeneratedColumn<double> get aliquotaUnidade => _aliquotaUnidade ??=
      GeneratedColumn<double>('ALIQUOTA_UNIDADE', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPrecoMaximoMeta =
      const VerificationMeta('valorPrecoMaximo');
  GeneratedColumn<double>? _valorPrecoMaximo;
  @override
  GeneratedColumn<double> get valorPrecoMaximo => _valorPrecoMaximo ??=
      GeneratedColumn<double>('VALOR_PRECO_MAXIMO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _valorPautaFiscalMeta =
      const VerificationMeta('valorPautaFiscal');
  GeneratedColumn<double>? _valorPautaFiscal;
  @override
  GeneratedColumn<double> get valorPautaFiscal => _valorPautaFiscal ??=
      GeneratedColumn<double>('VALOR_PAUTA_FISCAL', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _itemListaServicoMeta =
      const VerificationMeta('itemListaServico');
  GeneratedColumn<int>? _itemListaServico;
  @override
  GeneratedColumn<int> get itemListaServico => _itemListaServico ??=
      GeneratedColumn<int>('ITEM_LISTA_SERVICO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _codigoTributacaoMeta =
      const VerificationMeta('codigoTributacao');
  GeneratedColumn<String>? _codigoTributacao;
  @override
  GeneratedColumn<String> get codigoTributacao => _codigoTributacao ??=
      GeneratedColumn<String>('CODIGO_TRIBUTACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idTributOperacaoFiscal,
        modalidadeBaseCalculo,
        porcentoBaseCalculo,
        aliquotaPorcento,
        aliquotaUnidade,
        valorPrecoMaximo,
        valorPautaFiscal,
        itemListaServico,
        codigoTributacao,
      ];

  @override
  String get aliasedName => _alias ?? 'TRIBUT_ISS';
  
  @override
  String get actualTableName => 'TRIBUT_ISS';
  
  @override
  VerificationContext validateIntegrity(Insertable<TributIss> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_TRIBUT_OPERACAO_FISCAL')) {
        context.handle(_idTributOperacaoFiscalMeta,
            idTributOperacaoFiscal.isAcceptableOrUnknown(data['ID_TRIBUT_OPERACAO_FISCAL']!, _idTributOperacaoFiscalMeta));
    }
    if (data.containsKey('MODALIDADE_BASE_CALCULO')) {
        context.handle(_modalidadeBaseCalculoMeta,
            modalidadeBaseCalculo.isAcceptableOrUnknown(data['MODALIDADE_BASE_CALCULO']!, _modalidadeBaseCalculoMeta));
    }
    if (data.containsKey('PORCENTO_BASE_CALCULO')) {
        context.handle(_porcentoBaseCalculoMeta,
            porcentoBaseCalculo.isAcceptableOrUnknown(data['PORCENTO_BASE_CALCULO']!, _porcentoBaseCalculoMeta));
    }
    if (data.containsKey('ALIQUOTA_PORCENTO')) {
        context.handle(_aliquotaPorcentoMeta,
            aliquotaPorcento.isAcceptableOrUnknown(data['ALIQUOTA_PORCENTO']!, _aliquotaPorcentoMeta));
    }
    if (data.containsKey('ALIQUOTA_UNIDADE')) {
        context.handle(_aliquotaUnidadeMeta,
            aliquotaUnidade.isAcceptableOrUnknown(data['ALIQUOTA_UNIDADE']!, _aliquotaUnidadeMeta));
    }
    if (data.containsKey('VALOR_PRECO_MAXIMO')) {
        context.handle(_valorPrecoMaximoMeta,
            valorPrecoMaximo.isAcceptableOrUnknown(data['VALOR_PRECO_MAXIMO']!, _valorPrecoMaximoMeta));
    }
    if (data.containsKey('VALOR_PAUTA_FISCAL')) {
        context.handle(_valorPautaFiscalMeta,
            valorPautaFiscal.isAcceptableOrUnknown(data['VALOR_PAUTA_FISCAL']!, _valorPautaFiscalMeta));
    }
    if (data.containsKey('ITEM_LISTA_SERVICO')) {
        context.handle(_itemListaServicoMeta,
            itemListaServico.isAcceptableOrUnknown(data['ITEM_LISTA_SERVICO']!, _itemListaServicoMeta));
    }
    if (data.containsKey('CODIGO_TRIBUTACAO')) {
        context.handle(_codigoTributacaoMeta,
            codigoTributacao.isAcceptableOrUnknown(data['CODIGO_TRIBUTACAO']!, _codigoTributacaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TributIss map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TributIss.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TributIsssTable createAlias(String alias) {
    return $TributIsssTable(_db, alias);
  }
}