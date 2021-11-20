/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_TIPO_PAGAMENTO] 
                                                                                
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

@DataClassName("PdvTipoPagamento")
@UseRowClass(PdvTipoPagamento)
class PdvTipoPagamentos extends Table {
  @override
  String get tableName => 'PDV_TIPO_PAGAMENTO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get codigo => text().named('CODIGO').withLength(min: 0, max: 3).nullable()();
  TextColumn get descricao => text().named('DESCRICAO').withLength(min: 0, max: 20).nullable()();
  TextColumn get tef => text().named('TEF').withLength(min: 0, max: 1).nullable()();
  TextColumn get imprimeVinculado => text().named('IMPRIME_VINCULADO').withLength(min: 0, max: 1).nullable()();
  TextColumn get permiteTroco => text().named('PERMITE_TROCO').withLength(min: 0, max: 1).nullable()();
  TextColumn get tefTipoGp => text().named('TEF_TIPO_GP').withLength(min: 0, max: 1).nullable()();
  TextColumn get geraParcelas => text().named('GERA_PARCELAS').withLength(min: 0, max: 1).nullable()();
  TextColumn get codigoPagamentoNfce => text().named('CODIGO_PAGAMENTO_NFCE').withLength(min: 0, max: 2).nullable()();
}

class PdvTipoPagamento extends DataClass implements Insertable<PdvTipoPagamento> {
  final int? id;
  final String? codigo;
  final String? descricao;
  final String? tef;
  final String? imprimeVinculado;
  final String? permiteTroco;
  final String? tefTipoGp;
  final String? geraParcelas;
  final String? codigoPagamentoNfce;

  PdvTipoPagamento(
    {
      required this.id,
      this.codigo,
      this.descricao,
      this.tef,
      this.imprimeVinculado,
      this.permiteTroco,
      this.tefTipoGp,
      this.geraParcelas,
      this.codigoPagamentoNfce,
    }
  );

  factory PdvTipoPagamento.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PdvTipoPagamento(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      codigo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO']),
      descricao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}DESCRICAO']),
      tef: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TEF']),
      imprimeVinculado: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}IMPRIME_VINCULADO']),
      permiteTroco: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}PERMITE_TROCO']),
      tefTipoGp: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TEF_TIPO_GP']),
      geraParcelas: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}GERA_PARCELAS']),
      codigoPagamentoNfce: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CODIGO_PAGAMENTO_NFCE']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || codigo != null) {
      map['CODIGO'] = Variable<String?>(codigo);
    }
    if (!nullToAbsent || descricao != null) {
      map['DESCRICAO'] = Variable<String?>(descricao);
    }
    if (!nullToAbsent || tef != null) {
      map['TEF'] = Variable<String?>(tef);
    }
    if (!nullToAbsent || imprimeVinculado != null) {
      map['IMPRIME_VINCULADO'] = Variable<String?>(imprimeVinculado);
    }
    if (!nullToAbsent || permiteTroco != null) {
      map['PERMITE_TROCO'] = Variable<String?>(permiteTroco);
    }
    if (!nullToAbsent || tefTipoGp != null) {
      map['TEF_TIPO_GP'] = Variable<String?>(tefTipoGp);
    }
    if (!nullToAbsent || geraParcelas != null) {
      map['GERA_PARCELAS'] = Variable<String?>(geraParcelas);
    }
    if (!nullToAbsent || codigoPagamentoNfce != null) {
      map['CODIGO_PAGAMENTO_NFCE'] = Variable<String?>(codigoPagamentoNfce);
    }
    return map;
  }

  PdvTipoPagamentosCompanion toCompanion(bool nullToAbsent) {
    return PdvTipoPagamentosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      codigo: codigo == null && nullToAbsent
        ? const Value.absent()
        : Value(codigo),
      descricao: descricao == null && nullToAbsent
        ? const Value.absent()
        : Value(descricao),
      tef: tef == null && nullToAbsent
        ? const Value.absent()
        : Value(tef),
      imprimeVinculado: imprimeVinculado == null && nullToAbsent
        ? const Value.absent()
        : Value(imprimeVinculado),
      permiteTroco: permiteTroco == null && nullToAbsent
        ? const Value.absent()
        : Value(permiteTroco),
      tefTipoGp: tefTipoGp == null && nullToAbsent
        ? const Value.absent()
        : Value(tefTipoGp),
      geraParcelas: geraParcelas == null && nullToAbsent
        ? const Value.absent()
        : Value(geraParcelas),
      codigoPagamentoNfce: codigoPagamentoNfce == null && nullToAbsent
        ? const Value.absent()
        : Value(codigoPagamentoNfce),
    );
  }

  factory PdvTipoPagamento.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvTipoPagamento(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      descricao: serializer.fromJson<String>(json['descricao']),
      tef: serializer.fromJson<String>(json['tef']),
      imprimeVinculado: serializer.fromJson<String>(json['imprimeVinculado']),
      permiteTroco: serializer.fromJson<String>(json['permiteTroco']),
      tefTipoGp: serializer.fromJson<String>(json['tefTipoGp']),
      geraParcelas: serializer.fromJson<String>(json['geraParcelas']),
      codigoPagamentoNfce: serializer.fromJson<String>(json['codigoPagamentoNfce']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'codigo': serializer.toJson<String?>(codigo),
      'descricao': serializer.toJson<String?>(descricao),
      'tef': serializer.toJson<String?>(tef),
      'imprimeVinculado': serializer.toJson<String?>(imprimeVinculado),
      'permiteTroco': serializer.toJson<String?>(permiteTroco),
      'tefTipoGp': serializer.toJson<String?>(tefTipoGp),
      'geraParcelas': serializer.toJson<String?>(geraParcelas),
      'codigoPagamentoNfce': serializer.toJson<String?>(codigoPagamentoNfce),
    };
  }

  PdvTipoPagamento copyWith(
        {
		  int? id,
          String? codigo,
          String? descricao,
          String? tef,
          String? imprimeVinculado,
          String? permiteTroco,
          String? tefTipoGp,
          String? geraParcelas,
          String? codigoPagamentoNfce,
		}) =>
      PdvTipoPagamento(
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        descricao: descricao ?? this.descricao,
        tef: tef ?? this.tef,
        imprimeVinculado: imprimeVinculado ?? this.imprimeVinculado,
        permiteTroco: permiteTroco ?? this.permiteTroco,
        tefTipoGp: tefTipoGp ?? this.tefTipoGp,
        geraParcelas: geraParcelas ?? this.geraParcelas,
        codigoPagamentoNfce: codigoPagamentoNfce ?? this.codigoPagamentoNfce,
      );
  
  @override
  String toString() {
    return (StringBuffer('PdvTipoPagamento(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao, ')
          ..write('tef: $tef, ')
          ..write('imprimeVinculado: $imprimeVinculado, ')
          ..write('permiteTroco: $permiteTroco, ')
          ..write('tefTipoGp: $tefTipoGp, ')
          ..write('geraParcelas: $geraParcelas, ')
          ..write('codigoPagamentoNfce: $codigoPagamentoNfce, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      codigo,
      descricao,
      tef,
      imprimeVinculado,
      permiteTroco,
      tefTipoGp,
      geraParcelas,
      codigoPagamentoNfce,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdvTipoPagamento &&
          other.id == id &&
          other.codigo == codigo &&
          other.descricao == descricao &&
          other.tef == tef &&
          other.imprimeVinculado == imprimeVinculado &&
          other.permiteTroco == permiteTroco &&
          other.tefTipoGp == tefTipoGp &&
          other.geraParcelas == geraParcelas &&
          other.codigoPagamentoNfce == codigoPagamentoNfce 
	   );
}

class PdvTipoPagamentosCompanion extends UpdateCompanion<PdvTipoPagamento> {

  final Value<int?> id;
  final Value<String?> codigo;
  final Value<String?> descricao;
  final Value<String?> tef;
  final Value<String?> imprimeVinculado;
  final Value<String?> permiteTroco;
  final Value<String?> tefTipoGp;
  final Value<String?> geraParcelas;
  final Value<String?> codigoPagamentoNfce;

  const PdvTipoPagamentosCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.tef = const Value.absent(),
    this.imprimeVinculado = const Value.absent(),
    this.permiteTroco = const Value.absent(),
    this.tefTipoGp = const Value.absent(),
    this.geraParcelas = const Value.absent(),
    this.codigoPagamentoNfce = const Value.absent(),
  });

  PdvTipoPagamentosCompanion.insert({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.tef = const Value.absent(),
    this.imprimeVinculado = const Value.absent(),
    this.permiteTroco = const Value.absent(),
    this.tefTipoGp = const Value.absent(),
    this.geraParcelas = const Value.absent(),
    this.codigoPagamentoNfce = const Value.absent(),
  });

  static Insertable<PdvTipoPagamento> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? descricao,
    Expression<String>? tef,
    Expression<String>? imprimeVinculado,
    Expression<String>? permiteTroco,
    Expression<String>? tefTipoGp,
    Expression<String>? geraParcelas,
    Expression<String>? codigoPagamentoNfce,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (codigo != null) 'CODIGO': codigo,
      if (descricao != null) 'DESCRICAO': descricao,
      if (tef != null) 'TEF': tef,
      if (imprimeVinculado != null) 'IMPRIME_VINCULADO': imprimeVinculado,
      if (permiteTroco != null) 'PERMITE_TROCO': permiteTroco,
      if (tefTipoGp != null) 'TEF_TIPO_GP': tefTipoGp,
      if (geraParcelas != null) 'GERA_PARCELAS': geraParcelas,
      if (codigoPagamentoNfce != null) 'CODIGO_PAGAMENTO_NFCE': codigoPagamentoNfce,
    });
  }

  PdvTipoPagamentosCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? codigo,
      Value<String>? descricao,
      Value<String>? tef,
      Value<String>? imprimeVinculado,
      Value<String>? permiteTroco,
      Value<String>? tefTipoGp,
      Value<String>? geraParcelas,
      Value<String>? codigoPagamentoNfce,
	  }) {
    return PdvTipoPagamentosCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      tef: tef ?? this.tef,
      imprimeVinculado: imprimeVinculado ?? this.imprimeVinculado,
      permiteTroco: permiteTroco ?? this.permiteTroco,
      tefTipoGp: tefTipoGp ?? this.tefTipoGp,
      geraParcelas: geraParcelas ?? this.geraParcelas,
      codigoPagamentoNfce: codigoPagamentoNfce ?? this.codigoPagamentoNfce,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (codigo.present) {
      map['CODIGO'] = Variable<String?>(codigo.value);
    }
    if (descricao.present) {
      map['DESCRICAO'] = Variable<String?>(descricao.value);
    }
    if (tef.present) {
      map['TEF'] = Variable<String?>(tef.value);
    }
    if (imprimeVinculado.present) {
      map['IMPRIME_VINCULADO'] = Variable<String?>(imprimeVinculado.value);
    }
    if (permiteTroco.present) {
      map['PERMITE_TROCO'] = Variable<String?>(permiteTroco.value);
    }
    if (tefTipoGp.present) {
      map['TEF_TIPO_GP'] = Variable<String?>(tefTipoGp.value);
    }
    if (geraParcelas.present) {
      map['GERA_PARCELAS'] = Variable<String?>(geraParcelas.value);
    }
    if (codigoPagamentoNfce.present) {
      map['CODIGO_PAGAMENTO_NFCE'] = Variable<String?>(codigoPagamentoNfce.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdvTipoPagamentosCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao, ')
          ..write('tef: $tef, ')
          ..write('imprimeVinculado: $imprimeVinculado, ')
          ..write('permiteTroco: $permiteTroco, ')
          ..write('tefTipoGp: $tefTipoGp, ')
          ..write('geraParcelas: $geraParcelas, ')
          ..write('codigoPagamentoNfce: $codigoPagamentoNfce, ')
          ..write(')'))
        .toString();
  }
}

class $PdvTipoPagamentosTable extends PdvTipoPagamentos
    with TableInfo<$PdvTipoPagamentosTable, PdvTipoPagamento> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PdvTipoPagamentosTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _codigoMeta =
      const VerificationMeta('codigo');
  GeneratedColumn<String>? _codigo;
  @override
  GeneratedColumn<String> get codigo => _codigo ??=
      GeneratedColumn<String>('CODIGO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  GeneratedColumn<String>? _descricao;
  @override
  GeneratedColumn<String> get descricao => _descricao ??=
      GeneratedColumn<String>('DESCRICAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _tefMeta =
      const VerificationMeta('tef');
  GeneratedColumn<String>? _tef;
  @override
  GeneratedColumn<String> get tef => _tef ??=
      GeneratedColumn<String>('TEF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _imprimeVinculadoMeta =
      const VerificationMeta('imprimeVinculado');
  GeneratedColumn<String>? _imprimeVinculado;
  @override
  GeneratedColumn<String> get imprimeVinculado => _imprimeVinculado ??=
      GeneratedColumn<String>('IMPRIME_VINCULADO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _permiteTrocoMeta =
      const VerificationMeta('permiteTroco');
  GeneratedColumn<String>? _permiteTroco;
  @override
  GeneratedColumn<String> get permiteTroco => _permiteTroco ??=
      GeneratedColumn<String>('PERMITE_TROCO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _tefTipoGpMeta =
      const VerificationMeta('tefTipoGp');
  GeneratedColumn<String>? _tefTipoGp;
  @override
  GeneratedColumn<String> get tefTipoGp => _tefTipoGp ??=
      GeneratedColumn<String>('TEF_TIPO_GP', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _geraParcelasMeta =
      const VerificationMeta('geraParcelas');
  GeneratedColumn<String>? _geraParcelas;
  @override
  GeneratedColumn<String> get geraParcelas => _geraParcelas ??=
      GeneratedColumn<String>('GERA_PARCELAS', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _codigoPagamentoNfceMeta =
      const VerificationMeta('codigoPagamentoNfce');
  GeneratedColumn<String>? _codigoPagamentoNfce;
  @override
  GeneratedColumn<String> get codigoPagamentoNfce => _codigoPagamentoNfce ??=
      GeneratedColumn<String>('CODIGO_PAGAMENTO_NFCE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        codigo,
        descricao,
        tef,
        imprimeVinculado,
        permiteTroco,
        tefTipoGp,
        geraParcelas,
        codigoPagamentoNfce,
      ];

  @override
  String get aliasedName => _alias ?? 'PDV_TIPO_PAGAMENTO';
  
  @override
  String get actualTableName => 'PDV_TIPO_PAGAMENTO';
  
  @override
  VerificationContext validateIntegrity(Insertable<PdvTipoPagamento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('CODIGO')) {
        context.handle(_codigoMeta,
            codigo.isAcceptableOrUnknown(data['CODIGO']!, _codigoMeta));
    }
    if (data.containsKey('DESCRICAO')) {
        context.handle(_descricaoMeta,
            descricao.isAcceptableOrUnknown(data['DESCRICAO']!, _descricaoMeta));
    }
    if (data.containsKey('TEF')) {
        context.handle(_tefMeta,
            tef.isAcceptableOrUnknown(data['TEF']!, _tefMeta));
    }
    if (data.containsKey('IMPRIME_VINCULADO')) {
        context.handle(_imprimeVinculadoMeta,
            imprimeVinculado.isAcceptableOrUnknown(data['IMPRIME_VINCULADO']!, _imprimeVinculadoMeta));
    }
    if (data.containsKey('PERMITE_TROCO')) {
        context.handle(_permiteTrocoMeta,
            permiteTroco.isAcceptableOrUnknown(data['PERMITE_TROCO']!, _permiteTrocoMeta));
    }
    if (data.containsKey('TEF_TIPO_GP')) {
        context.handle(_tefTipoGpMeta,
            tefTipoGp.isAcceptableOrUnknown(data['TEF_TIPO_GP']!, _tefTipoGpMeta));
    }
    if (data.containsKey('GERA_PARCELAS')) {
        context.handle(_geraParcelasMeta,
            geraParcelas.isAcceptableOrUnknown(data['GERA_PARCELAS']!, _geraParcelasMeta));
    }
    if (data.containsKey('CODIGO_PAGAMENTO_NFCE')) {
        context.handle(_codigoPagamentoNfceMeta,
            codigoPagamentoNfce.isAcceptableOrUnknown(data['CODIGO_PAGAMENTO_NFCE']!, _codigoPagamentoNfceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdvTipoPagamento map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PdvTipoPagamento.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PdvTipoPagamentosTable createAlias(String alias) {
    return $PdvTipoPagamentosTable(_db, alias);
  }
}