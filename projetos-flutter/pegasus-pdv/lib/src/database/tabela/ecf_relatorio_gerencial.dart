/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [ECF_RELATORIO_GERENCIAL] 
                                                                                
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

@DataClassName("EcfRelatorioGerencial")
@UseRowClass(EcfRelatorioGerencial)
class EcfRelatorioGerencials extends Table {
  @override
  String get tableName => 'ECF_RELATORIO_GERENCIAL';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idPdvConfiguracao => integer().named('ID_PDV_CONFIGURACAO').nullable().customConstraint('NULLABLE REFERENCES PDV_CONFIGURACAO(ID)')();
  IntColumn get x => integer().named('X').nullable()();
  IntColumn get meiosPagamento => integer().named('MEIOS_PAGAMENTO').nullable()();
  IntColumn get davEmitidos => integer().named('DAV_EMITIDOS').nullable()();
  IntColumn get identificacaoPaf => integer().named('IDENTIFICACAO_PAF').nullable()();
  IntColumn get parametrosConfiguracao => integer().named('PARAMETROS_CONFIGURACAO').nullable()();
  IntColumn get outros => integer().named('OUTROS').nullable()();
}

class EcfRelatorioGerencial extends DataClass implements Insertable<EcfRelatorioGerencial> {
  final int? id;
  final int? idPdvConfiguracao;
  final int? x;
  final int? meiosPagamento;
  final int? davEmitidos;
  final int? identificacaoPaf;
  final int? parametrosConfiguracao;
  final int? outros;

  EcfRelatorioGerencial(
    {
      required this.id,
      this.idPdvConfiguracao,
      this.x,
      this.meiosPagamento,
      this.davEmitidos,
      this.identificacaoPaf,
      this.parametrosConfiguracao,
      this.outros,
    }
  );

  factory EcfRelatorioGerencial.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EcfRelatorioGerencial(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idPdvConfiguracao: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_PDV_CONFIGURACAO']),
      x: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}X']),
      meiosPagamento: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}MEIOS_PAGAMENTO']),
      davEmitidos: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}DAV_EMITIDOS']),
      identificacaoPaf: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}IDENTIFICACAO_PAF']),
      parametrosConfiguracao: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}PARAMETROS_CONFIGURACAO']),
      outros: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}OUTROS']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idPdvConfiguracao != null) {
      map['ID_PDV_CONFIGURACAO'] = Variable<int?>(idPdvConfiguracao);
    }
    if (!nullToAbsent || x != null) {
      map['X'] = Variable<int?>(x);
    }
    if (!nullToAbsent || meiosPagamento != null) {
      map['MEIOS_PAGAMENTO'] = Variable<int?>(meiosPagamento);
    }
    if (!nullToAbsent || davEmitidos != null) {
      map['DAV_EMITIDOS'] = Variable<int?>(davEmitidos);
    }
    if (!nullToAbsent || identificacaoPaf != null) {
      map['IDENTIFICACAO_PAF'] = Variable<int?>(identificacaoPaf);
    }
    if (!nullToAbsent || parametrosConfiguracao != null) {
      map['PARAMETROS_CONFIGURACAO'] = Variable<int?>(parametrosConfiguracao);
    }
    if (!nullToAbsent || outros != null) {
      map['OUTROS'] = Variable<int?>(outros);
    }
    return map;
  }

  EcfRelatorioGerencialsCompanion toCompanion(bool nullToAbsent) {
    return EcfRelatorioGerencialsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idPdvConfiguracao: idPdvConfiguracao == null && nullToAbsent
        ? const Value.absent()
        : Value(idPdvConfiguracao),
      x: x == null && nullToAbsent
        ? const Value.absent()
        : Value(x),
      meiosPagamento: meiosPagamento == null && nullToAbsent
        ? const Value.absent()
        : Value(meiosPagamento),
      davEmitidos: davEmitidos == null && nullToAbsent
        ? const Value.absent()
        : Value(davEmitidos),
      identificacaoPaf: identificacaoPaf == null && nullToAbsent
        ? const Value.absent()
        : Value(identificacaoPaf),
      parametrosConfiguracao: parametrosConfiguracao == null && nullToAbsent
        ? const Value.absent()
        : Value(parametrosConfiguracao),
      outros: outros == null && nullToAbsent
        ? const Value.absent()
        : Value(outros),
    );
  }

  factory EcfRelatorioGerencial.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EcfRelatorioGerencial(
      id: serializer.fromJson<int>(json['id']),
      idPdvConfiguracao: serializer.fromJson<int>(json['idPdvConfiguracao']),
      x: serializer.fromJson<int>(json['x']),
      meiosPagamento: serializer.fromJson<int>(json['meiosPagamento']),
      davEmitidos: serializer.fromJson<int>(json['davEmitidos']),
      identificacaoPaf: serializer.fromJson<int>(json['identificacaoPaf']),
      parametrosConfiguracao: serializer.fromJson<int>(json['parametrosConfiguracao']),
      outros: serializer.fromJson<int>(json['outros']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idPdvConfiguracao': serializer.toJson<int?>(idPdvConfiguracao),
      'x': serializer.toJson<int?>(x),
      'meiosPagamento': serializer.toJson<int?>(meiosPagamento),
      'davEmitidos': serializer.toJson<int?>(davEmitidos),
      'identificacaoPaf': serializer.toJson<int?>(identificacaoPaf),
      'parametrosConfiguracao': serializer.toJson<int?>(parametrosConfiguracao),
      'outros': serializer.toJson<int?>(outros),
    };
  }

  EcfRelatorioGerencial copyWith(
        {
		  int? id,
          int? idPdvConfiguracao,
          int? x,
          int? meiosPagamento,
          int? davEmitidos,
          int? identificacaoPaf,
          int? parametrosConfiguracao,
          int? outros,
		}) =>
      EcfRelatorioGerencial(
        id: id ?? this.id,
        idPdvConfiguracao: idPdvConfiguracao ?? this.idPdvConfiguracao,
        x: x ?? this.x,
        meiosPagamento: meiosPagamento ?? this.meiosPagamento,
        davEmitidos: davEmitidos ?? this.davEmitidos,
        identificacaoPaf: identificacaoPaf ?? this.identificacaoPaf,
        parametrosConfiguracao: parametrosConfiguracao ?? this.parametrosConfiguracao,
        outros: outros ?? this.outros,
      );
  
  @override
  String toString() {
    return (StringBuffer('EcfRelatorioGerencial(')
          ..write('id: $id, ')
          ..write('idPdvConfiguracao: $idPdvConfiguracao, ')
          ..write('x: $x, ')
          ..write('meiosPagamento: $meiosPagamento, ')
          ..write('davEmitidos: $davEmitidos, ')
          ..write('identificacaoPaf: $identificacaoPaf, ')
          ..write('parametrosConfiguracao: $parametrosConfiguracao, ')
          ..write('outros: $outros, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idPdvConfiguracao,
      x,
      meiosPagamento,
      davEmitidos,
      identificacaoPaf,
      parametrosConfiguracao,
      outros,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcfRelatorioGerencial &&
          other.id == id &&
          other.idPdvConfiguracao == idPdvConfiguracao &&
          other.x == x &&
          other.meiosPagamento == meiosPagamento &&
          other.davEmitidos == davEmitidos &&
          other.identificacaoPaf == identificacaoPaf &&
          other.parametrosConfiguracao == parametrosConfiguracao &&
          other.outros == outros 
	   );
}

class EcfRelatorioGerencialsCompanion extends UpdateCompanion<EcfRelatorioGerencial> {

  final Value<int?> id;
  final Value<int?> idPdvConfiguracao;
  final Value<int?> x;
  final Value<int?> meiosPagamento;
  final Value<int?> davEmitidos;
  final Value<int?> identificacaoPaf;
  final Value<int?> parametrosConfiguracao;
  final Value<int?> outros;

  const EcfRelatorioGerencialsCompanion({
    this.id = const Value.absent(),
    this.idPdvConfiguracao = const Value.absent(),
    this.x = const Value.absent(),
    this.meiosPagamento = const Value.absent(),
    this.davEmitidos = const Value.absent(),
    this.identificacaoPaf = const Value.absent(),
    this.parametrosConfiguracao = const Value.absent(),
    this.outros = const Value.absent(),
  });

  EcfRelatorioGerencialsCompanion.insert({
    this.id = const Value.absent(),
    this.idPdvConfiguracao = const Value.absent(),
    this.x = const Value.absent(),
    this.meiosPagamento = const Value.absent(),
    this.davEmitidos = const Value.absent(),
    this.identificacaoPaf = const Value.absent(),
    this.parametrosConfiguracao = const Value.absent(),
    this.outros = const Value.absent(),
  });

  static Insertable<EcfRelatorioGerencial> custom({
    Expression<int>? id,
    Expression<int>? idPdvConfiguracao,
    Expression<int>? x,
    Expression<int>? meiosPagamento,
    Expression<int>? davEmitidos,
    Expression<int>? identificacaoPaf,
    Expression<int>? parametrosConfiguracao,
    Expression<int>? outros,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idPdvConfiguracao != null) 'ID_PDV_CONFIGURACAO': idPdvConfiguracao,
      if (x != null) 'X': x,
      if (meiosPagamento != null) 'MEIOS_PAGAMENTO': meiosPagamento,
      if (davEmitidos != null) 'DAV_EMITIDOS': davEmitidos,
      if (identificacaoPaf != null) 'IDENTIFICACAO_PAF': identificacaoPaf,
      if (parametrosConfiguracao != null) 'PARAMETROS_CONFIGURACAO': parametrosConfiguracao,
      if (outros != null) 'OUTROS': outros,
    });
  }

  EcfRelatorioGerencialsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idPdvConfiguracao,
      Value<int>? x,
      Value<int>? meiosPagamento,
      Value<int>? davEmitidos,
      Value<int>? identificacaoPaf,
      Value<int>? parametrosConfiguracao,
      Value<int>? outros,
	  }) {
    return EcfRelatorioGerencialsCompanion(
      id: id ?? this.id,
      idPdvConfiguracao: idPdvConfiguracao ?? this.idPdvConfiguracao,
      x: x ?? this.x,
      meiosPagamento: meiosPagamento ?? this.meiosPagamento,
      davEmitidos: davEmitidos ?? this.davEmitidos,
      identificacaoPaf: identificacaoPaf ?? this.identificacaoPaf,
      parametrosConfiguracao: parametrosConfiguracao ?? this.parametrosConfiguracao,
      outros: outros ?? this.outros,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idPdvConfiguracao.present) {
      map['ID_PDV_CONFIGURACAO'] = Variable<int?>(idPdvConfiguracao.value);
    }
    if (x.present) {
      map['X'] = Variable<int?>(x.value);
    }
    if (meiosPagamento.present) {
      map['MEIOS_PAGAMENTO'] = Variable<int?>(meiosPagamento.value);
    }
    if (davEmitidos.present) {
      map['DAV_EMITIDOS'] = Variable<int?>(davEmitidos.value);
    }
    if (identificacaoPaf.present) {
      map['IDENTIFICACAO_PAF'] = Variable<int?>(identificacaoPaf.value);
    }
    if (parametrosConfiguracao.present) {
      map['PARAMETROS_CONFIGURACAO'] = Variable<int?>(parametrosConfiguracao.value);
    }
    if (outros.present) {
      map['OUTROS'] = Variable<int?>(outros.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcfRelatorioGerencialsCompanion(')
          ..write('id: $id, ')
          ..write('idPdvConfiguracao: $idPdvConfiguracao, ')
          ..write('x: $x, ')
          ..write('meiosPagamento: $meiosPagamento, ')
          ..write('davEmitidos: $davEmitidos, ')
          ..write('identificacaoPaf: $identificacaoPaf, ')
          ..write('parametrosConfiguracao: $parametrosConfiguracao, ')
          ..write('outros: $outros, ')
          ..write(')'))
        .toString();
  }
}

class $EcfRelatorioGerencialsTable extends EcfRelatorioGerencials
    with TableInfo<$EcfRelatorioGerencialsTable, EcfRelatorioGerencial> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EcfRelatorioGerencialsTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idPdvConfiguracaoMeta =
      const VerificationMeta('idPdvConfiguracao');
  GeneratedColumn<int>? _idPdvConfiguracao;
  @override
  GeneratedColumn<int> get idPdvConfiguracao =>
      _idPdvConfiguracao ??= GeneratedColumn<int>('ID_PDV_CONFIGURACAO', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES PDV_CONFIGURACAO(ID)');
  final VerificationMeta _xMeta =
      const VerificationMeta('x');
  GeneratedColumn<int>? _x;
  @override
  GeneratedColumn<int> get x => _x ??=
      GeneratedColumn<int>('X', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _meiosPagamentoMeta =
      const VerificationMeta('meiosPagamento');
  GeneratedColumn<int>? _meiosPagamento;
  @override
  GeneratedColumn<int> get meiosPagamento => _meiosPagamento ??=
      GeneratedColumn<int>('MEIOS_PAGAMENTO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _davEmitidosMeta =
      const VerificationMeta('davEmitidos');
  GeneratedColumn<int>? _davEmitidos;
  @override
  GeneratedColumn<int> get davEmitidos => _davEmitidos ??=
      GeneratedColumn<int>('DAV_EMITIDOS', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _identificacaoPafMeta =
      const VerificationMeta('identificacaoPaf');
  GeneratedColumn<int>? _identificacaoPaf;
  @override
  GeneratedColumn<int> get identificacaoPaf => _identificacaoPaf ??=
      GeneratedColumn<int>('IDENTIFICACAO_PAF', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _parametrosConfiguracaoMeta =
      const VerificationMeta('parametrosConfiguracao');
  GeneratedColumn<int>? _parametrosConfiguracao;
  @override
  GeneratedColumn<int> get parametrosConfiguracao => _parametrosConfiguracao ??=
      GeneratedColumn<int>('PARAMETROS_CONFIGURACAO', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _outrosMeta =
      const VerificationMeta('outros');
  GeneratedColumn<int>? _outros;
  @override
  GeneratedColumn<int> get outros => _outros ??=
      GeneratedColumn<int>('OUTROS', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idPdvConfiguracao,
        x,
        meiosPagamento,
        davEmitidos,
        identificacaoPaf,
        parametrosConfiguracao,
        outros,
      ];

  @override
  String get aliasedName => _alias ?? 'ECF_RELATORIO_GERENCIAL';
  
  @override
  String get actualTableName => 'ECF_RELATORIO_GERENCIAL';
  
  @override
  VerificationContext validateIntegrity(Insertable<EcfRelatorioGerencial> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_PDV_CONFIGURACAO')) {
        context.handle(_idPdvConfiguracaoMeta,
            idPdvConfiguracao.isAcceptableOrUnknown(data['ID_PDV_CONFIGURACAO']!, _idPdvConfiguracaoMeta));
    }
    if (data.containsKey('X')) {
        context.handle(_xMeta,
            x.isAcceptableOrUnknown(data['X']!, _xMeta));
    }
    if (data.containsKey('MEIOS_PAGAMENTO')) {
        context.handle(_meiosPagamentoMeta,
            meiosPagamento.isAcceptableOrUnknown(data['MEIOS_PAGAMENTO']!, _meiosPagamentoMeta));
    }
    if (data.containsKey('DAV_EMITIDOS')) {
        context.handle(_davEmitidosMeta,
            davEmitidos.isAcceptableOrUnknown(data['DAV_EMITIDOS']!, _davEmitidosMeta));
    }
    if (data.containsKey('IDENTIFICACAO_PAF')) {
        context.handle(_identificacaoPafMeta,
            identificacaoPaf.isAcceptableOrUnknown(data['IDENTIFICACAO_PAF']!, _identificacaoPafMeta));
    }
    if (data.containsKey('PARAMETROS_CONFIGURACAO')) {
        context.handle(_parametrosConfiguracaoMeta,
            parametrosConfiguracao.isAcceptableOrUnknown(data['PARAMETROS_CONFIGURACAO']!, _parametrosConfiguracaoMeta));
    }
    if (data.containsKey('OUTROS')) {
        context.handle(_outrosMeta,
            outros.isAcceptableOrUnknown(data['OUTROS']!, _outrosMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EcfRelatorioGerencial map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EcfRelatorioGerencial.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EcfRelatorioGerencialsTable createAlias(String alias) {
    return $EcfRelatorioGerencialsTable(_db, alias);
  }
}