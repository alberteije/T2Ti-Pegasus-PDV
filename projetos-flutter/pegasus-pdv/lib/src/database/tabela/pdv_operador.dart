/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [PDV_OPERADOR] 
                                                                                
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

@DataClassName("PdvOperador")
@UseRowClass(PdvOperador)
class PdvOperadors extends Table {
  @override
  String get tableName => 'PDV_OPERADOR';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idColaborador => integer().named('ID_COLABORADOR').nullable().customConstraint('NULLABLE REFERENCES COLABORADOR(ID)')();
  TextColumn get login => text().named('LOGIN').withLength(min: 0, max: 20).nullable()();
  TextColumn get senha => text().named('SENHA').withLength(min: 0, max: 20).nullable()();
}

class PdvOperador extends DataClass implements Insertable<PdvOperador> {
  final int? id;
  final int? idColaborador;
  final String? login;
  final String? senha;

  PdvOperador(
    {
      required this.id,
      this.idColaborador,
      this.login,
      this.senha,
    }
  );

  factory PdvOperador.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PdvOperador(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idColaborador: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_COLABORADOR']),
      login: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}LOGIN']),
      senha: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}SENHA']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['ID'] = Variable<int?>(id);
    }
    if (!nullToAbsent || idColaborador != null) {
      map['ID_COLABORADOR'] = Variable<int?>(idColaborador);
    }
    if (!nullToAbsent || login != null) {
      map['LOGIN'] = Variable<String?>(login);
    }
    if (!nullToAbsent || senha != null) {
      map['SENHA'] = Variable<String?>(senha);
    }
    return map;
  }

  PdvOperadorsCompanion toCompanion(bool nullToAbsent) {
    return PdvOperadorsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idColaborador: idColaborador == null && nullToAbsent
        ? const Value.absent()
        : Value(idColaborador),
      login: login == null && nullToAbsent
        ? const Value.absent()
        : Value(login),
      senha: senha == null && nullToAbsent
        ? const Value.absent()
        : Value(senha),
    );
  }

  factory PdvOperador.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PdvOperador(
      id: serializer.fromJson<int>(json['id']),
      idColaborador: serializer.fromJson<int>(json['idColaborador']),
      login: serializer.fromJson<String>(json['login']),
      senha: serializer.fromJson<String>(json['senha']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idColaborador': serializer.toJson<int?>(idColaborador),
      'login': serializer.toJson<String?>(login),
      'senha': serializer.toJson<String?>(senha),
    };
  }

  PdvOperador copyWith(
        {
		  int? id,
          int? idColaborador,
          String? login,
          String? senha,
		}) =>
      PdvOperador(
        id: id ?? this.id,
        idColaborador: idColaborador ?? this.idColaborador,
        login: login ?? this.login,
        senha: senha ?? this.senha,
      );
  
  @override
  String toString() {
    return (StringBuffer('PdvOperador(')
          ..write('id: $id, ')
          ..write('idColaborador: $idColaborador, ')
          ..write('login: $login, ')
          ..write('senha: $senha, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idColaborador,
      login,
      senha,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdvOperador &&
          other.id == id &&
          other.idColaborador == idColaborador &&
          other.login == login &&
          other.senha == senha 
	   );
}

class PdvOperadorsCompanion extends UpdateCompanion<PdvOperador> {

  final Value<int?> id;
  final Value<int?> idColaborador;
  final Value<String?> login;
  final Value<String?> senha;

  const PdvOperadorsCompanion({
    this.id = const Value.absent(),
    this.idColaborador = const Value.absent(),
    this.login = const Value.absent(),
    this.senha = const Value.absent(),
  });

  PdvOperadorsCompanion.insert({
    this.id = const Value.absent(),
    this.idColaborador = const Value.absent(),
    this.login = const Value.absent(),
    this.senha = const Value.absent(),
  });

  static Insertable<PdvOperador> custom({
    Expression<int>? id,
    Expression<int>? idColaborador,
    Expression<String>? login,
    Expression<String>? senha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idColaborador != null) 'ID_COLABORADOR': idColaborador,
      if (login != null) 'LOGIN': login,
      if (senha != null) 'SENHA': senha,
    });
  }

  PdvOperadorsCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idColaborador,
      Value<String>? login,
      Value<String>? senha,
	  }) {
    return PdvOperadorsCompanion(
      id: id ?? this.id,
      idColaborador: idColaborador ?? this.idColaborador,
      login: login ?? this.login,
      senha: senha ?? this.senha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int?>(id.value);
    }
    if (idColaborador.present) {
      map['ID_COLABORADOR'] = Variable<int?>(idColaborador.value);
    }
    if (login.present) {
      map['LOGIN'] = Variable<String?>(login.value);
    }
    if (senha.present) {
      map['SENHA'] = Variable<String?>(senha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdvOperadorsCompanion(')
          ..write('id: $id, ')
          ..write('idColaborador: $idColaborador, ')
          ..write('login: $login, ')
          ..write('senha: $senha, ')
          ..write(')'))
        .toString();
  }
}

class $PdvOperadorsTable extends PdvOperadors
    with TableInfo<$PdvOperadorsTable, PdvOperador> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PdvOperadorsTable(this._db, [this._alias]);
  
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int>? _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('ID', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');

  final VerificationMeta _idColaboradorMeta =
      const VerificationMeta('idColaborador');
  GeneratedColumn<int>? _idColaborador;
  @override
  GeneratedColumn<int> get idColaborador =>
      _idColaborador ??= GeneratedColumn<int>('ID_COLABORADOR', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          $customConstraints: 'NULLABLE REFERENCES COLABORADOR(ID)');
  final VerificationMeta _loginMeta =
      const VerificationMeta('login');
  GeneratedColumn<String>? _login;
  @override
  GeneratedColumn<String> get login => _login ??=
      GeneratedColumn<String>('LOGIN', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _senhaMeta =
      const VerificationMeta('senha');
  GeneratedColumn<String>? _senha;
  @override
  GeneratedColumn<String> get senha => _senha ??=
      GeneratedColumn<String>('SENHA', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idColaborador,
        login,
        senha,
      ];

  @override
  String get aliasedName => _alias ?? 'PDV_OPERADOR';
  
  @override
  String get actualTableName => 'PDV_OPERADOR';
  
  @override
  VerificationContext validateIntegrity(Insertable<PdvOperador> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('ID_COLABORADOR')) {
        context.handle(_idColaboradorMeta,
            idColaborador.isAcceptableOrUnknown(data['ID_COLABORADOR']!, _idColaboradorMeta));
    }
    if (data.containsKey('LOGIN')) {
        context.handle(_loginMeta,
            login.isAcceptableOrUnknown(data['LOGIN']!, _loginMeta));
    }
    if (data.containsKey('SENHA')) {
        context.handle(_senhaMeta,
            senha.isAcceptableOrUnknown(data['SENHA']!, _senhaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdvOperador map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PdvOperador.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PdvOperadorsTable createAlias(String alias) {
    return $PdvOperadorsTable(_db, alias);
  }
}