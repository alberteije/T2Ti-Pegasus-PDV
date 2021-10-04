import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';

class BancoAgencia implements Comparable<BancoAgencia> {
  
  BancoAgencia();

  String 
      _id, 
      _idBanco,
      _numero, 
      _digito,
      _nome, 
      _telefone, 
      _contato, 
      _observacao, 
      _gerente;

  String get id => _id;
  set id(String value){
    if (value == null) value = "";
    _id = value;
  }

  String get numero => _numero;
  set numero(String value){
    if (value == null) value = "";
    _numero = value;
  }

  String get idBanco => _idBanco;
  set idBanco(String value){
    if (value == null) value = "";
    _idBanco = value;
  }

  String get digito => _numero;
  set digito(String value){
    if (value == null) value = "";
    _digito = value;
  }

  String get nome => _nome;
  set nome(String value){
    if (value == null) value = "";
    _nome = value;
  }

  String get telefone => _telefone;
  set telefone(String value){
    if (value == null) value = "";
    _telefone = value;
  }

  String get contato => _contato;
  set contato(String value){
    if (value == null) value = "";
    _contato = value;
  }

  String get observacao => _observacao;
  set observacao(String value){
    if (value == null) value = "";
    _observacao = value;
  }

  String get gerente => _gerente;
  set gerente(String value){
    if (value == null) value = "";
    _gerente = value;
  }

  BancoAgencia.fromMap(Map m) {
    id = m["id"];
    idBanco = m["idBanco"];
    numero = m["numero"];
    digito = m["digito"];
    nome = m["nome"];
    telefone = m["telefone"];
    contato = m["contato"];
    observacao = m["observacao"];
    gerente = m["gerente"];
  }

  Map<String, dynamic> get toMap {
    return {
      "id": _id,
      "idBanco": _idBanco,
      "numero": _numero,
      "digito": _digito,
      "nome": _nome,
      "telefone": _telefone, 
      "contato": _contato, 
      "observacao": _observacao, 
      "gerente": _gerente,
    };
  }
  

  @override
  int compareTo(BancoAgencia other) => _nome.compareTo(other._nome);  
}

class Id extends FieldWidgets<BancoAgencia> {
  Id([BancoAgencia bancoAgencia]):
  super
  (
    object: bancoAgencia,
    label: 'Id',
    value: bancoAgencia?.id
  );

  void onSaved(v) => object?.id = value = v;
}

class IdBanco extends FieldWidgets<BancoAgencia> {
  IdBanco([BancoAgencia bancoAgencia]):
  super
  (
    object: bancoAgencia,
    label: 'Id Banco',
    value: bancoAgencia?.idBanco
  );

  void onSaved(v) => object?.idBanco = value = v;
}

class Numero extends FieldWidgets<BancoAgencia> {
  Numero([BancoAgencia bancoAgencia]):
  super
  (
    object: bancoAgencia,
    label: 'Número',
    value: bancoAgencia?.numero,
    keyboardType: TextInputType.number
  );

  void onSaved(v) => object?.numero = value = v;

  @override
  CircleAvatar get circleAvatar =>
    CircleAvatar(child: Text(value.length > 1 ? value?.substring(0, 3) : ""));
}

class Digito extends FieldWidgets<BancoAgencia> {
  Digito([BancoAgencia bancoAgencia]):
  super
  (
    object: bancoAgencia,
    label: 'Digito',
    value: bancoAgencia?.digito
  );

  void onSaved(v) => object?.digito = value = v;
}

class Nome extends FieldWidgets<BancoAgencia> {
  Nome([BancoAgencia bancoAgencia]):
  super
  (
    object: bancoAgencia,
    label: 'Nome',
    value: bancoAgencia?.nome
  );

  void onSaved(v) => object?.nome = value = v;
}

class Telefone extends FieldWidgets<BancoAgencia> {
  Telefone([BancoAgencia bancoAgencia]):
  super
  (
    object: bancoAgencia,
    label: 'Telefone',
    value: bancoAgencia?.telefone
  );

  void onSaved(v) => object?.telefone = value = v;
}

class Contato extends FieldWidgets<BancoAgencia> {
  Contato([BancoAgencia bancoAgencia]):
  super
  (
    object: bancoAgencia,
    label: 'Contato',
    value: bancoAgencia?.contato,
    keyboardType: TextInputType.number
  );

  void onSaved(v) => object?.contato = value = v;
}

class Observacao extends FieldWidgets<BancoAgencia> {
  Observacao([BancoAgencia bancoAgencia]):
  super
  (
    object: bancoAgencia,
    label: 'Observacao',
    value: bancoAgencia?.observacao
  );

  void onSaved(v) => object?.observacao = value = v;
}

class Gerente extends FieldWidgets<BancoAgencia> {
  Gerente([BancoAgencia bancoAgencia]):
  super
  (
    object: bancoAgencia,
    label: 'Gerente',
    value: bancoAgencia?.gerente
  );

  void onSaved(v) => object?.gerente = value = v;
}
