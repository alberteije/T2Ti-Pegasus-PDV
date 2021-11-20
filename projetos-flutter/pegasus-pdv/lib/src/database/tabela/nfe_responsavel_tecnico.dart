/*
Title: T2Ti ERP Pegasus                                                                
Description: Table Moor relacionada à tabela [NFE_RESPONSAVEL_TECNICO] 
                                                                                
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

@DataClassName("NfeResponsavelTecnico")
@UseRowClass(NfeResponsavelTecnico)
class NfeResponsavelTecnicos extends Table {
  @override
  String get tableName => 'NFE_RESPONSAVEL_TECNICO';

  IntColumn get id => integer().named('ID').autoIncrement()();
  IntColumn get idNfeCabecalho => integer().named('ID_NFE_CABECALHO').nullable().customConstraint('NULLABLE REFERENCES NFE_CABECALHO(ID)')();
  TextColumn get cnpj => text().named('CNPJ').withLength(min: 0, max: 14).nullable()();
  TextColumn get contato => text().named('CONTATO').withLength(min: 0, max: 60).nullable()();
  TextColumn get email => text().named('EMAIL').withLength(min: 0, max: 60).nullable()();
  TextColumn get telefone => text().named('TELEFONE').withLength(min: 0, max: 14).nullable()();
  TextColumn get identificadorCsrt => text().named('IDENTIFICADOR_CSRT').withLength(min: 0, max: 2).nullable()();
  TextColumn get hashCsrt => text().named('HASH_CSRT').withLength(min: 0, max: 28).nullable()();
}

class NfeResponsavelTecnico extends DataClass implements Insertable<NfeResponsavelTecnico> {
  final int? id;
  final int? idNfeCabecalho;
  final String? cnpj;
  final String? contato;
  final String? email;
  final String? telefone;
  final String? identificadorCsrt;
  final String? hashCsrt;

  NfeResponsavelTecnico(
    {
      required this.id,
      this.idNfeCabecalho,
      this.cnpj,
      this.contato,
      this.email,
      this.telefone,
      this.identificadorCsrt,
      this.hashCsrt,
    }
  );

  factory NfeResponsavelTecnico.fromData(Map<String, dynamic> data, GeneratedDatabase db, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NfeResponsavelTecnico(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID']),
      idNfeCabecalho: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}ID_NFE_CABECALHO']),
      cnpj: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CNPJ']),
      contato: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}CONTATO']),
      email: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}EMAIL']),
      telefone: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}TELEFONE']),
      identificadorCsrt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}IDENTIFICADOR_CSRT']),
      hashCsrt: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}HASH_CSRT']),
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
    if (!nullToAbsent || cnpj != null) {
      map['CNPJ'] = Variable<String?>(cnpj);
    }
    if (!nullToAbsent || contato != null) {
      map['CONTATO'] = Variable<String?>(contato);
    }
    if (!nullToAbsent || email != null) {
      map['EMAIL'] = Variable<String?>(email);
    }
    if (!nullToAbsent || telefone != null) {
      map['TELEFONE'] = Variable<String?>(telefone);
    }
    if (!nullToAbsent || identificadorCsrt != null) {
      map['IDENTIFICADOR_CSRT'] = Variable<String?>(identificadorCsrt);
    }
    if (!nullToAbsent || hashCsrt != null) {
      map['HASH_CSRT'] = Variable<String?>(hashCsrt);
    }
    return map;
  }

  NfeResponsavelTecnicosCompanion toCompanion(bool nullToAbsent) {
    return NfeResponsavelTecnicosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idNfeCabecalho: idNfeCabecalho == null && nullToAbsent
        ? const Value.absent()
        : Value(idNfeCabecalho),
      cnpj: cnpj == null && nullToAbsent
        ? const Value.absent()
        : Value(cnpj),
      contato: contato == null && nullToAbsent
        ? const Value.absent()
        : Value(contato),
      email: email == null && nullToAbsent
        ? const Value.absent()
        : Value(email),
      telefone: telefone == null && nullToAbsent
        ? const Value.absent()
        : Value(telefone),
      identificadorCsrt: identificadorCsrt == null && nullToAbsent
        ? const Value.absent()
        : Value(identificadorCsrt),
      hashCsrt: hashCsrt == null && nullToAbsent
        ? const Value.absent()
        : Value(hashCsrt),
    );
  }

  factory NfeResponsavelTecnico.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NfeResponsavelTecnico(
      id: serializer.fromJson<int>(json['id']),
      idNfeCabecalho: serializer.fromJson<int>(json['idNfeCabecalho']),
      cnpj: serializer.fromJson<String>(json['cnpj']),
      contato: serializer.fromJson<String>(json['contato']),
      email: serializer.fromJson<String>(json['email']),
      telefone: serializer.fromJson<String>(json['telefone']),
      identificadorCsrt: serializer.fromJson<String>(json['identificadorCsrt']),
      hashCsrt: serializer.fromJson<String>(json['hashCsrt']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idNfeCabecalho': serializer.toJson<int?>(idNfeCabecalho),
      'cnpj': serializer.toJson<String?>(cnpj),
      'contato': serializer.toJson<String?>(contato),
      'email': serializer.toJson<String?>(email),
      'telefone': serializer.toJson<String?>(telefone),
      'identificadorCsrt': serializer.toJson<String?>(identificadorCsrt),
      'hashCsrt': serializer.toJson<String?>(hashCsrt),
    };
  }

  NfeResponsavelTecnico copyWith(
        {
		  int? id,
          int? idNfeCabecalho,
          String? cnpj,
          String? contato,
          String? email,
          String? telefone,
          String? identificadorCsrt,
          String? hashCsrt,
		}) =>
      NfeResponsavelTecnico(
        id: id ?? this.id,
        idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
        cnpj: cnpj ?? this.cnpj,
        contato: contato ?? this.contato,
        email: email ?? this.email,
        telefone: telefone ?? this.telefone,
        identificadorCsrt: identificadorCsrt ?? this.identificadorCsrt,
        hashCsrt: hashCsrt ?? this.hashCsrt,
      );
  
  @override
  String toString() {
    return (StringBuffer('NfeResponsavelTecnico(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('cnpj: $cnpj, ')
          ..write('contato: $contato, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('identificadorCsrt: $identificadorCsrt, ')
          ..write('hashCsrt: $hashCsrt, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
      id,
      idNfeCabecalho,
      cnpj,
      contato,
      email,
      telefone,
      identificadorCsrt,
      hashCsrt,
	]);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NfeResponsavelTecnico &&
          other.id == id &&
          other.idNfeCabecalho == idNfeCabecalho &&
          other.cnpj == cnpj &&
          other.contato == contato &&
          other.email == email &&
          other.telefone == telefone &&
          other.identificadorCsrt == identificadorCsrt &&
          other.hashCsrt == hashCsrt 
	   );
}

class NfeResponsavelTecnicosCompanion extends UpdateCompanion<NfeResponsavelTecnico> {

  final Value<int?> id;
  final Value<int?> idNfeCabecalho;
  final Value<String?> cnpj;
  final Value<String?> contato;
  final Value<String?> email;
  final Value<String?> telefone;
  final Value<String?> identificadorCsrt;
  final Value<String?> hashCsrt;

  const NfeResponsavelTecnicosCompanion({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.contato = const Value.absent(),
    this.email = const Value.absent(),
    this.telefone = const Value.absent(),
    this.identificadorCsrt = const Value.absent(),
    this.hashCsrt = const Value.absent(),
  });

  NfeResponsavelTecnicosCompanion.insert({
    this.id = const Value.absent(),
    this.idNfeCabecalho = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.contato = const Value.absent(),
    this.email = const Value.absent(),
    this.telefone = const Value.absent(),
    this.identificadorCsrt = const Value.absent(),
    this.hashCsrt = const Value.absent(),
  });

  static Insertable<NfeResponsavelTecnico> custom({
    Expression<int>? id,
    Expression<int>? idNfeCabecalho,
    Expression<String>? cnpj,
    Expression<String>? contato,
    Expression<String>? email,
    Expression<String>? telefone,
    Expression<String>? identificadorCsrt,
    Expression<String>? hashCsrt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (idNfeCabecalho != null) 'ID_NFE_CABECALHO': idNfeCabecalho,
      if (cnpj != null) 'CNPJ': cnpj,
      if (contato != null) 'CONTATO': contato,
      if (email != null) 'EMAIL': email,
      if (telefone != null) 'TELEFONE': telefone,
      if (identificadorCsrt != null) 'IDENTIFICADOR_CSRT': identificadorCsrt,
      if (hashCsrt != null) 'HASH_CSRT': hashCsrt,
    });
  }

  NfeResponsavelTecnicosCompanion copyWith(
      {
	  Value<int>? id,
      Value<int>? idNfeCabecalho,
      Value<String>? cnpj,
      Value<String>? contato,
      Value<String>? email,
      Value<String>? telefone,
      Value<String>? identificadorCsrt,
      Value<String>? hashCsrt,
	  }) {
    return NfeResponsavelTecnicosCompanion(
      id: id ?? this.id,
      idNfeCabecalho: idNfeCabecalho ?? this.idNfeCabecalho,
      cnpj: cnpj ?? this.cnpj,
      contato: contato ?? this.contato,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      identificadorCsrt: identificadorCsrt ?? this.identificadorCsrt,
      hashCsrt: hashCsrt ?? this.hashCsrt,
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
    if (cnpj.present) {
      map['CNPJ'] = Variable<String?>(cnpj.value);
    }
    if (contato.present) {
      map['CONTATO'] = Variable<String?>(contato.value);
    }
    if (email.present) {
      map['EMAIL'] = Variable<String?>(email.value);
    }
    if (telefone.present) {
      map['TELEFONE'] = Variable<String?>(telefone.value);
    }
    if (identificadorCsrt.present) {
      map['IDENTIFICADOR_CSRT'] = Variable<String?>(identificadorCsrt.value);
    }
    if (hashCsrt.present) {
      map['HASH_CSRT'] = Variable<String?>(hashCsrt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NfeResponsavelTecnicosCompanion(')
          ..write('id: $id, ')
          ..write('idNfeCabecalho: $idNfeCabecalho, ')
          ..write('cnpj: $cnpj, ')
          ..write('contato: $contato, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('identificadorCsrt: $identificadorCsrt, ')
          ..write('hashCsrt: $hashCsrt, ')
          ..write(')'))
        .toString();
  }
}

class $NfeResponsavelTecnicosTable extends NfeResponsavelTecnicos
    with TableInfo<$NfeResponsavelTecnicosTable, NfeResponsavelTecnico> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NfeResponsavelTecnicosTable(this._db, [this._alias]);
  
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
  final VerificationMeta _cnpjMeta =
      const VerificationMeta('cnpj');
  GeneratedColumn<String>? _cnpj;
  @override
  GeneratedColumn<String> get cnpj => _cnpj ??=
      GeneratedColumn<String>('CNPJ', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _contatoMeta =
      const VerificationMeta('contato');
  GeneratedColumn<String>? _contato;
  @override
  GeneratedColumn<String> get contato => _contato ??=
      GeneratedColumn<String>('CONTATO', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailMeta =
      const VerificationMeta('email');
  GeneratedColumn<String>? _email;
  @override
  GeneratedColumn<String> get email => _email ??=
      GeneratedColumn<String>('EMAIL', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  GeneratedColumn<String>? _telefone;
  @override
  GeneratedColumn<String> get telefone => _telefone ??=
      GeneratedColumn<String>('TELEFONE', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _identificadorCsrtMeta =
      const VerificationMeta('identificadorCsrt');
  GeneratedColumn<String>? _identificadorCsrt;
  @override
  GeneratedColumn<String> get identificadorCsrt => _identificadorCsrt ??=
      GeneratedColumn<String>('IDENTIFICADOR_CSRT', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _hashCsrtMeta =
      const VerificationMeta('hashCsrt');
  GeneratedColumn<String>? _hashCsrt;
  @override
  GeneratedColumn<String> get hashCsrt => _hashCsrt ??=
      GeneratedColumn<String>('HASH_CSRT', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
		    
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idNfeCabecalho,
        cnpj,
        contato,
        email,
        telefone,
        identificadorCsrt,
        hashCsrt,
      ];

  @override
  String get aliasedName => _alias ?? 'NFE_RESPONSAVEL_TECNICO';
  
  @override
  String get actualTableName => 'NFE_RESPONSAVEL_TECNICO';
  
  @override
  VerificationContext validateIntegrity(Insertable<NfeResponsavelTecnico> instance,
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
    if (data.containsKey('CNPJ')) {
        context.handle(_cnpjMeta,
            cnpj.isAcceptableOrUnknown(data['CNPJ']!, _cnpjMeta));
    }
    if (data.containsKey('CONTATO')) {
        context.handle(_contatoMeta,
            contato.isAcceptableOrUnknown(data['CONTATO']!, _contatoMeta));
    }
    if (data.containsKey('EMAIL')) {
        context.handle(_emailMeta,
            email.isAcceptableOrUnknown(data['EMAIL']!, _emailMeta));
    }
    if (data.containsKey('TELEFONE')) {
        context.handle(_telefoneMeta,
            telefone.isAcceptableOrUnknown(data['TELEFONE']!, _telefoneMeta));
    }
    if (data.containsKey('IDENTIFICADOR_CSRT')) {
        context.handle(_identificadorCsrtMeta,
            identificadorCsrt.isAcceptableOrUnknown(data['IDENTIFICADOR_CSRT']!, _identificadorCsrtMeta));
    }
    if (data.containsKey('HASH_CSRT')) {
        context.handle(_hashCsrtMeta,
            hashCsrt.isAcceptableOrUnknown(data['HASH_CSRT']!, _hashCsrtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NfeResponsavelTecnico map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NfeResponsavelTecnico.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NfeResponsavelTecnicosTable createAlias(String alias) {
    return $NfeResponsavelTecnicosTable(_db, alias);
  }
}