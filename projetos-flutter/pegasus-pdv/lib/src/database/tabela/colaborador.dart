/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [COLABORADOR] 
                                                                                
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

@DataClassName("Colaborador")
@UseRowClass(Colaborador)
class Colaboradors extends Table {
  @override
  String get tableName => 'COLABORADOR';

  IntColumn get id => integer().named('ID').autoIncrement()();
  TextColumn get nome => text().named('NOME').withLength(min: 0, max: 100).nullable()();
  TextColumn get cpf => text().named('CPF').withLength(min: 0, max: 11).nullable()();
  TextColumn get telefone => text().named('TELEFONE').withLength(min: 0, max: 15).nullable()();
  TextColumn get celular => text().named('CELULAR').withLength(min: 0, max: 15).nullable()();
  TextColumn get email => text().named('EMAIL').withLength(min: 0, max: 250).nullable()();
  RealColumn get comissaoVista => real().named('COMISSAO_VISTA').nullable()();
  RealColumn get comissaoPrazo => real().named('COMISSAO_PRAZO').nullable()();
  TextColumn get nivelAutorizacao => text().named('NIVEL_AUTORIZACAO').withLength(min: 0, max: 1).nullable()();
  TextColumn get entregadorVeiculo => text().named('ENTREGADOR_VEICULO').withLength(min: 0, max: 1).nullable()();
}

class Colaborador extends DataClass implements Insertable<Colaborador> {
  final int? id;
  final String? nome;
  final String? cpf;
  final String? telefone;
  final String? celular;
  final String? email;
  final double? comissaoVista;
  final double? comissaoPrazo;
  final String? nivelAutorizacao;
  final String? entregadorVeiculo;

  Colaborador(
    {
      required this.id,
      this.nome,
      this.cpf,
      this.telefone,
      this.celular,
      this.email,
      this.comissaoVista,
      this.comissaoPrazo,
      this.nivelAutorizacao,
      this.entregadorVeiculo,
    }
  );

  factory Colaborador.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Colaborador(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      nome: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NOME']),
      cpf: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CPF']),
      telefone: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TELEFONE']),
      celular: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CELULAR']),
      email: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL']),
      comissaoVista: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}COMISSAO_VISTA']),
      comissaoPrazo: const RealType().mapFromDatabaseResponse(data['${effectivePrefix}COMISSAO_PRAZO']),
      nivelAutorizacao: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}NIVEL_AUTORIZACAO']),
      entregadorVeiculo: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}ENTREGADOR_VEICULO']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || nome != null) {
      map['NOME'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || cpf != null) {
      map['CPF'] = Variable<String?>(cpf);
    }
    if (!nullToAbsent || telefone != null) {
      map['TELEFONE'] = Variable<String?>(telefone);
    }
    if (!nullToAbsent || celular != null) {
      map['CELULAR'] = Variable<String?>(celular);
    }
    if (!nullToAbsent || email != null) {
      map['EMAIL'] = Variable<String?>(email);
    }
    if (!nullToAbsent || comissaoVista != null) {
      map['COMISSAO_VISTA'] = Variable<double?>(comissaoVista);
    }
    if (!nullToAbsent || comissaoPrazo != null) {
      map['COMISSAO_PRAZO'] = Variable<double?>(comissaoPrazo);
    }
    if (!nullToAbsent || nivelAutorizacao != null) {
      map['NIVEL_AUTORIZACAO'] = Variable<String?>(nivelAutorizacao);
    }
    if (!nullToAbsent || entregadorVeiculo != null) {
      map['ENTREGADOR_VEICULO'] = Variable<String?>(entregadorVeiculo);
    }
    return map;
  }

  ColaboradorsCompanion toCompanion(bool nullToAbsent) {
    return ColaboradorsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nome: nome == null && nullToAbsent
        ? const Value.absent()
        : Value(nome),
      cpf: cpf == null && nullToAbsent
        ? const Value.absent()
        : Value(cpf),
      telefone: telefone == null && nullToAbsent
        ? const Value.absent()
        : Value(telefone),
      celular: celular == null && nullToAbsent
        ? const Value.absent()
        : Value(celular),
      email: email == null && nullToAbsent
        ? const Value.absent()
        : Value(email),
      comissaoVista: comissaoVista == null && nullToAbsent
        ? const Value.absent()
        : Value(comissaoVista),
      comissaoPrazo: comissaoPrazo == null && nullToAbsent
        ? const Value.absent()
        : Value(comissaoPrazo),
      nivelAutorizacao: nivelAutorizacao == null && nullToAbsent
        ? const Value.absent()
        : Value(nivelAutorizacao),
      entregadorVeiculo: entregadorVeiculo == null && nullToAbsent
        ? const Value.absent()
        : Value(entregadorVeiculo),
    );
  }

  factory Colaborador.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Colaborador(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      cpf: serializer.fromJson<String>(json['cpf']),
      telefone: serializer.fromJson<String>(json['telefone']),
      celular: serializer.fromJson<String>(json['celular']),
      email: serializer.fromJson<String>(json['email']),
      comissaoVista: serializer.fromJson<double>(json['comissaoVista']),
      comissaoPrazo: serializer.fromJson<double>(json['comissaoPrazo']),
      nivelAutorizacao: serializer.fromJson<String>(json['nivelAutorizacao']),
      entregadorVeiculo: serializer.fromJson<String>(json['entregadorVeiculo']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'nome': serializer.toJson<String?>(nome),
      'cpf': serializer.toJson<String?>(cpf),
      'telefone': serializer.toJson<String?>(telefone),
      'celular': serializer.toJson<String?>(celular),
      'email': serializer.toJson<String?>(email),
      'comissaoVista': serializer.toJson<double?>(comissaoVista),
      'comissaoPrazo': serializer.toJson<double?>(comissaoPrazo),
      'nivelAutorizacao': serializer.toJson<String?>(nivelAutorizacao),
      'entregadorVeiculo': serializer.toJson<String?>(entregadorVeiculo),
    };
  }

  Colaborador copyWith(
        {
		  int? id,
          String? nome,
          String? cpf,
          String? telefone,
          String? celular,
          String? email,
          double? comissaoVista,
          double? comissaoPrazo,
          String? nivelAutorizacao,
          String? entregadorVeiculo,
		}) =>
      Colaborador(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        cpf: cpf ?? this.cpf,
        telefone: telefone ?? this.telefone,
        celular: celular ?? this.celular,
        email: email ?? this.email,
        comissaoVista: comissaoVista ?? this.comissaoVista,
        comissaoPrazo: comissaoPrazo ?? this.comissaoPrazo,
        nivelAutorizacao: nivelAutorizacao ?? this.nivelAutorizacao,
        entregadorVeiculo: entregadorVeiculo ?? this.entregadorVeiculo,
      );
  
  @override
  String toString() {
    return (StringBuffer('Colaborador(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cpf: $cpf, ')
          ..write('telefone: $telefone, ')
          ..write('celular: $celular, ')
          ..write('email: $email, ')
          ..write('comissaoVista: $comissaoVista, ')
          ..write('comissaoPrazo: $comissaoPrazo, ')
          ..write('nivelAutorizacao: $nivelAutorizacao, ')
          ..write('entregadorVeiculo: $entregadorVeiculo, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      nome,
      cpf,
      telefone,
      celular,
      email,
      comissaoVista,
      comissaoPrazo,
      nivelAutorizacao,
      entregadorVeiculo,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Colaborador &&
          other.id == id &&
          other.nome == nome &&
          other.cpf == cpf &&
          other.telefone == telefone &&
          other.celular == celular &&
          other.email == email &&
          other.comissaoVista == comissaoVista &&
          other.comissaoPrazo == comissaoPrazo &&
          other.nivelAutorizacao == nivelAutorizacao &&
          other.entregadorVeiculo == entregadorVeiculo 
	   );
}

class ColaboradorsCompanion extends UpdateCompanion<Colaborador> {

  final Value<int?> id;
  final Value<String?> nome;
  final Value<String?> cpf;
  final Value<String?> telefone;
  final Value<String?> celular;
  final Value<String?> email;
  final Value<double?> comissaoVista;
  final Value<double?> comissaoPrazo;
  final Value<String?> nivelAutorizacao;
  final Value<String?> entregadorVeiculo;

  const ColaboradorsCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.cpf = const Value.absent(),
    this.telefone = const Value.absent(),
    this.celular = const Value.absent(),
    this.email = const Value.absent(),
    this.comissaoVista = const Value.absent(),
    this.comissaoPrazo = const Value.absent(),
    this.nivelAutorizacao = const Value.absent(),
    this.entregadorVeiculo = const Value.absent(),
  });

  ColaboradorsCompanion.insert({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.cpf = const Value.absent(),
    this.telefone = const Value.absent(),
    this.celular = const Value.absent(),
    this.email = const Value.absent(),
    this.comissaoVista = const Value.absent(),
    this.comissaoPrazo = const Value.absent(),
    this.nivelAutorizacao = const Value.absent(),
    this.entregadorVeiculo = const Value.absent(),
  });

  static Insertable<Colaborador> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? cpf,
    Expression<String>? telefone,
    Expression<String>? celular,
    Expression<String>? email,
    Expression<double>? comissaoVista,
    Expression<double>? comissaoPrazo,
    Expression<String>? nivelAutorizacao,
    Expression<String>? entregadorVeiculo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (nome != null) 'NOME': nome,
      if (cpf != null) 'CPF': cpf,
      if (telefone != null) 'TELEFONE': telefone,
      if (celular != null) 'CELULAR': celular,
      if (email != null) 'EMAIL': email,
      if (comissaoVista != null) 'COMISSAO_VISTA': comissaoVista,
      if (comissaoPrazo != null) 'COMISSAO_PRAZO': comissaoPrazo,
      if (nivelAutorizacao != null) 'NIVEL_AUTORIZACAO': nivelAutorizacao,
      if (entregadorVeiculo != null) 'ENTREGADOR_VEICULO': entregadorVeiculo,
    });
  }

  ColaboradorsCompanion copyWith(
      {
	  Value<int>? id,
      Value<String>? nome,
      Value<String>? cpf,
      Value<String>? telefone,
      Value<String>? celular,
      Value<String>? email,
      Value<double>? comissaoVista,
      Value<double>? comissaoPrazo,
      Value<String>? nivelAutorizacao,
      Value<String>? entregadorVeiculo,
	  }) {
    return ColaboradorsCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      telefone: telefone ?? this.telefone,
      celular: celular ?? this.celular,
      email: email ?? this.email,
      comissaoVista: comissaoVista ?? this.comissaoVista,
      comissaoPrazo: comissaoPrazo ?? this.comissaoPrazo,
      nivelAutorizacao: nivelAutorizacao ?? this.nivelAutorizacao,
      entregadorVeiculo: entregadorVeiculo ?? this.entregadorVeiculo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (nome.present) {
      map['NOME'] = Variable<String?>(nome.value);
    }
    if (cpf.present) {
      map['CPF'] = Variable<String?>(cpf.value);
    }
    if (telefone.present) {
      map['TELEFONE'] = Variable<String?>(telefone.value);
    }
    if (celular.present) {
      map['CELULAR'] = Variable<String?>(celular.value);
    }
    if (email.present) {
      map['EMAIL'] = Variable<String?>(email.value);
    }
    if (comissaoVista.present) {
      map['COMISSAO_VISTA'] = Variable<double?>(comissaoVista.value);
    }
    if (comissaoPrazo.present) {
      map['COMISSAO_PRAZO'] = Variable<double?>(comissaoPrazo.value);
    }
    if (nivelAutorizacao.present) {
      map['NIVEL_AUTORIZACAO'] = Variable<String?>(nivelAutorizacao.value);
    }
    if (entregadorVeiculo.present) {
      map['ENTREGADOR_VEICULO'] = Variable<String?>(entregadorVeiculo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ColaboradorsCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('cpf: $cpf, ')
          ..write('telefone: $telefone, ')
          ..write('celular: $celular, ')
          ..write('email: $email, ')
          ..write('comissaoVista: $comissaoVista, ')
          ..write('comissaoPrazo: $comissaoPrazo, ')
          ..write('nivelAutorizacao: $nivelAutorizacao, ')
          ..write('entregadorVeiculo: $entregadorVeiculo, ')
          ..write(')'))
        .toString();
  }
}

class $ColaboradorsTable extends Colaboradors
    with TableInfo<$ColaboradorsTable, Colaborador> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ColaboradorsTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _nomeMeta =
      const VerificationMeta('nome');
  GeneratedColumn<String>? _nome;
  @override
  GeneratedColumn<String> get nome => _nome ??=
      GeneratedColumn<String>('NOME', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cpfMeta =
      const VerificationMeta('cpf');
  GeneratedColumn<String>? _cpf;
  @override
  GeneratedColumn<String> get cpf => _cpf ??=
      GeneratedColumn<String>('CPF', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  GeneratedColumn<String>? _telefone;
  @override
  GeneratedColumn<String> get telefone => _telefone ??=
      GeneratedColumn<String>('TELEFONE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _celularMeta =
      const VerificationMeta('celular');
  GeneratedColumn<String>? _celular;
  @override
  GeneratedColumn<String> get celular => _celular ??=
      GeneratedColumn<String>('CELULAR', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailMeta =
      const VerificationMeta('email');
  GeneratedColumn<String>? _email;
  @override
  GeneratedColumn<String> get email => _email ??=
      GeneratedColumn<String>('EMAIL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _comissaoVistaMeta =
      const VerificationMeta('comissaoVista');
  GeneratedColumn<double>? _comissaoVista;
  @override
  GeneratedColumn<double> get comissaoVista => _comissaoVista ??=
      GeneratedColumn<double>('COMISSAO_VISTA', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _comissaoPrazoMeta =
      const VerificationMeta('comissaoPrazo');
  GeneratedColumn<double>? _comissaoPrazo;
  @override
  GeneratedColumn<double> get comissaoPrazo => _comissaoPrazo ??=
      GeneratedColumn<double>('COMISSAO_PRAZO', aliasedName, true,
          typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _nivelAutorizacaoMeta =
      const VerificationMeta('nivelAutorizacao');
  GeneratedColumn<String>? _nivelAutorizacao;
  @override
  GeneratedColumn<String> get nivelAutorizacao => _nivelAutorizacao ??=
      GeneratedColumn<String>('NIVEL_AUTORIZACAO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _entregadorVeiculoMeta =
      const VerificationMeta('entregadorVeiculo');
  GeneratedColumn<String>? _entregadorVeiculo;
  @override
  GeneratedColumn<String> get entregadorVeiculo => _entregadorVeiculo ??=
      GeneratedColumn<String>('ENTREGADOR_VEICULO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        cpf,
        telefone,
        celular,
        email,
        comissaoVista,
        comissaoPrazo,
        nivelAutorizacao,
        entregadorVeiculo,
      ];

  @override
  String get aliasedName => _alias ?? 'COLABORADOR';
  
  @override
  String get actualTableName => 'COLABORADOR';
  
  @override
  VerificationContext validateIntegrity(Insertable<Colaborador> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('NOME')) {
        context.handle(_nomeMeta,
            nome.isAcceptableOrUnknown(data['NOME']!, _nomeMeta));
    }
    if (data.containsKey('CPF')) {
        context.handle(_cpfMeta,
            cpf.isAcceptableOrUnknown(data['CPF']!, _cpfMeta));
    }
    if (data.containsKey('TELEFONE')) {
        context.handle(_telefoneMeta,
            telefone.isAcceptableOrUnknown(data['TELEFONE']!, _telefoneMeta));
    }
    if (data.containsKey('CELULAR')) {
        context.handle(_celularMeta,
            celular.isAcceptableOrUnknown(data['CELULAR']!, _celularMeta));
    }
    if (data.containsKey('EMAIL')) {
        context.handle(_emailMeta,
            email.isAcceptableOrUnknown(data['EMAIL']!, _emailMeta));
    }
    if (data.containsKey('COMISSAO_VISTA')) {
        context.handle(_comissaoVistaMeta,
            comissaoVista.isAcceptableOrUnknown(data['COMISSAO_VISTA']!, _comissaoVistaMeta));
    }
    if (data.containsKey('COMISSAO_PRAZO')) {
        context.handle(_comissaoPrazoMeta,
            comissaoPrazo.isAcceptableOrUnknown(data['COMISSAO_PRAZO']!, _comissaoPrazoMeta));
    }
    if (data.containsKey('NIVEL_AUTORIZACAO')) {
        context.handle(_nivelAutorizacaoMeta,
            nivelAutorizacao.isAcceptableOrUnknown(data['NIVEL_AUTORIZACAO']!, _nivelAutorizacaoMeta));
    }
    if (data.containsKey('ENTREGADOR_VEICULO')) {
        context.handle(_entregadorVeiculoMeta,
            entregadorVeiculo.isAcceptableOrUnknown(data['ENTREGADOR_VEICULO']!, _entregadorVeiculoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Colaborador map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Colaborador.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ColaboradorsTable createAlias(String alias) {
    return $ColaboradorsTable(_db, alias);
  }
}