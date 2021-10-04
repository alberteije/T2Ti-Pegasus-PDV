import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/model/banco_agencia.dart';
import 'package:t2ti_erp_fenix/src/controller/banco_agencia_controller.dart';
import 'package:t2ti_erp_fenix/src/service/banco_agencia_service.dart';

class BancoAgenciaPersistindo extends BancoAgenciaEditando {
  @override
  void init([Object bancoAgencia]) {
    super.init(bancoAgencia);
  }

  void onPressed([BuildContext context]) {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    _inForm = false;
    persistir();
    refresh();
  }

  void setBanco([String banco]){
    _bancoAgencia.idBanco = banco;
    _idBanco = IdBanco(_bancoAgencia);
  }
}

class BancoAgenciaEditando extends BancoAgenciaListando {
  bool _inForm = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey {
    if (!_inForm) {
      _inForm = true;
    }
    return _formKey;
  }

  Future persistir([BancoAgencia bancoAgencia]) {
    if (bancoAgencia == null) {
      bancoAgencia = _bancoAgencia;
    }
    return BancoAgenciaService.salvar(bancoAgencia.toMap);
  }

  Future<bool> excluir([BancoAgencia bancoAgencia]) async {
    if (bancoAgencia == null) {
      bancoAgencia = _bancoAgencia;
    }
    return await BancoAgenciaService.excluir(bancoAgencia.toMap);
  }
}

class BancoAgenciaListando extends BancoAgenciaCampos {
  BancoAgencia _bancoAgencia;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<BancoAgencia> get items => _listaBancoAgencia;
  List<BancoAgencia> _listaBancoAgencia;

  Future<List<BancoAgencia>> refresh() async {
    _listaBancoAgencia = await BancoAgenciaController.getListaBancoAgencia();
    BancoAgenciaController.recarregar();
    return _listaBancoAgencia;
  }

  void sort() async {
    _listaBancoAgencia = await BancoAgenciaController.ordenar();
    BancoAgenciaController.recarregar();
  }

  void init([Object bancoAgencia]) {
    if (bancoAgencia == null) {
      _bancoAgencia = BancoAgencia();
    }
    else {
      if (bancoAgencia is! BancoAgencia) return;
      _bancoAgencia = (bancoAgencia as BancoAgencia);
    }
    _id = Id(_bancoAgencia);
    _idBanco = IdBanco(_bancoAgencia);
    _numero = Numero(_bancoAgencia);
    _digito = Digito(_bancoAgencia);
    _nome = Nome(_bancoAgencia);
    _telefone = Telefone(_bancoAgencia);
    _contato = Contato(_bancoAgencia);
    _observacao = Observacao(_bancoAgencia);
    _gerente = Gerente(_bancoAgencia);
  }
}

class BancoAgenciaCampos {
  FieldWidgets<BancoAgencia> 
  _id, 
  _idBanco,
  _numero, 
  _digito,
  _nome, 
  _telefone, 
  _contato, 
  _observacao, 
  _gerente;

  Id get id => _id;
  set id(Id id) => _id = id;

  IdBanco get idBanco => _idBanco;
  set idBanco(IdBanco idBanco) => _idBanco = idBanco;

  Numero get numero => _numero;
  set numero(Numero numero) => _numero = numero;

  Digito get digito => _digito;
  set digito(Digito digito) => _digito = digito;

  Nome get nome => _nome;
  set nome(Nome nome) => _nome = nome;

  Telefone get telefone => _telefone;
  set telefone(Telefone telefone) => _telefone = telefone;

  Contato get contato => _contato;
  set contato(Contato contato) => _contato = contato;

  Observacao get observacao => _observacao;
  set observacao(Observacao observacao) => _observacao = observacao;

  Gerente get gerente => _gerente;
  set gerente(Gerente gerente) => _gerente = gerente;
}
