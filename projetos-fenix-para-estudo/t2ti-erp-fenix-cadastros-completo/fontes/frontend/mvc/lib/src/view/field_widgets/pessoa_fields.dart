import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/model/pessoa.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_controller.dart';

/// Classe que tem algum controle relacionado a página pessoa_persiste
class PessoaFieldsPersiste extends PessoaFieldsLista {

  /// controla se está no form persiste
  bool _inFormPersiste = false;
  
  /// chave do formulário da página pessoa_persiste
  final GlobalKey<FormState> _formKeyPessoaPersistePage = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyPessoaPersistePage {
    if (!_inFormPersiste) {
      _inFormPersiste = true;
    }
    return _formKeyPessoaPersistePage;
  }

  /// controle do botão salvar da página pessoa_persiste
  void onPressedBotaoSalvar([BuildContext context]) {
    if (!_formKeyPessoaPersistePage.currentState.validate()) return;
    /// após salvar o estado corrente do form, teremos o objeto _pessoa preenchido
    _formKeyPessoaPersistePage.currentState.save();
    /// passa o _inFormPersiste para false, pois fecharemos a página e voltaremos para a página anterior
    _inFormPersiste = false;
    PessoaController.persistir(_pessoa);
    PessoaController.refrescarLista();
  }
}

/// Classe que tem algum controle relacionado a página pessoa_lista
class PessoaFieldsLista extends PessoaFields {
  final GlobalKey<ScaffoldState> scaffoldKeyPessoaListaPage = GlobalKey<ScaffoldState>();
}

/// Classe que declara e disponibiliza os FieldWidgets
class PessoaFields {
  FieldWidgets<Pessoa> 
                    _fieldId,
                    _fieldNome,
                    _fieldTipo,
                    _fieldSite,
                    _fieldEmail,
                    _fieldCliente,
                    _fieldFornecedor,
                    _fieldTransportadora,
                    _fieldColaborador,
                    _fieldContador;

  FieldId get fieldId => _fieldId;
  set fieldId(FieldId fieldId) => _fieldId = fieldId;

  FieldNome get fieldNome => _fieldNome;
  set fieldNome(FieldNome fieldNome) => _fieldNome = fieldNome;

  FieldTipo get fieldTipo => _fieldTipo;
  set fieldTipo(FieldTipo fieldTipo) => _fieldTipo = fieldTipo;

  FieldSite get fieldSite => _fieldSite;
  set fieldSite(FieldSite fieldSite) => _fieldSite = fieldSite;

  FieldEmail get fieldEmail => _fieldEmail;
  set fieldEmail(FieldEmail fieldEmail) => _fieldEmail = fieldEmail;

  FieldCliente get fieldCliente => _fieldCliente;
  set fieldCliente(FieldCliente fieldCliente) => _fieldCliente = fieldCliente;

  FieldFornecedor get fieldFornecedor => _fieldFornecedor;
  set fieldFornecedor(FieldFornecedor fieldFornecedor) => _fieldFornecedor = fieldFornecedor;

  FieldTransportadora get fieldTransportadora => _fieldTransportadora;
  set fieldTransportadora(FieldTransportadora fieldTransportadora) => _fieldTransportadora = fieldTransportadora;

  FieldColaborador get fieldColaborador => _fieldColaborador;
  set fieldColaborador(FieldColaborador fieldColaborador) => _fieldColaborador = fieldColaborador;

  FieldContador get fieldContador => _fieldContador;
  set fieldContador(FieldContador fieldContador) => _fieldContador = fieldContador;

  /// PODO (Plain Old Dart Object) Pessoa vinculado aos FieldWidgets
  Pessoa _pessoa;

  /// Inicializa os FieldWidgets, se possível com os valores do objeto Pessoa
  void init([Object pessoa]) {
    if (pessoa == null) {
      _pessoa = Pessoa();
    }
    else {
      if (pessoa is! Pessoa) return;
      _pessoa = (pessoa as Pessoa);
    }
    _fieldId = FieldId(_pessoa);
    _fieldNome = FieldNome(_pessoa);
    _fieldTipo = FieldTipo(_pessoa);
    _fieldSite = FieldSite(_pessoa);
    _fieldEmail = FieldEmail(_pessoa);
    _fieldCliente = FieldCliente(_pessoa);
    _fieldFornecedor = FieldFornecedor(_pessoa);
    _fieldTransportadora = FieldTransportadora(_pessoa);
    _fieldColaborador = FieldColaborador(_pessoa);
    _fieldContador = FieldContador(_pessoa);
  }
}

/// Classes para instanciar os FieldWidgets individualmente
class FieldId extends FieldWidgets<Pessoa> {
  FieldId([Pessoa pessoa]):
  super
  (
    object: pessoa,
    label: 'Id',
    value: pessoa?.id
  );

  void onSaved(v) => object?.id = value = v;

  @override
  CircleAvatar get circleAvatar =>
    CircleAvatar(child: Text(value?.toString()));
}

class FieldNome extends FieldWidgets<Pessoa> {
  FieldNome([Pessoa pessoa]):
  super
  (
    object: pessoa,
    label: 'Nome',
    value: pessoa?.nome
  );

  void onSaved(v) => object?.nome = value = v;
}

class FieldTipo extends FieldWidgets<Pessoa> {
  FieldTipo([Pessoa pessoa]):
  super
  (
    object: pessoa,
    label: '',
    value: pessoa?.tipo,
  );

  void onSaved(v) => object?.tipo = value = v;

  @override
  CircleAvatar get circleAvatar =>
    CircleAvatar(child: Text(value.length > 0 ? value?.substring(0, 1) : ""));
    // CircleAvatar(child: Text(value?.toString()));
}

class FieldSite extends FieldWidgets<Pessoa> {
  FieldSite([Pessoa pessoa]):
  super
  (
    object: pessoa,
    label: 'Site',
    value: pessoa?.site
  );

  void onSaved(v) => object?.site = value = v;
}

class FieldEmail extends FieldWidgets<Pessoa> {
  FieldEmail([Pessoa pessoa]):
  super
  (
    object: pessoa,
    label: 'Email',
    value: pessoa?.email,
  );

  void onSaved(v) => object?.email = value = v;
}

class FieldCliente extends FieldWidgets<Pessoa> {
  FieldCliente([Pessoa pessoa]):
  super
  (
    object: pessoa,
    value: pessoa?.cliente == "S",
    tristate: false,
  );
  
  @override
  void onChanged(bool value) {
    if (value) 
    {
      object.cliente = "S";
    }
    else {
      object.cliente = "N";
    }
   
    PessoaController.refrescarTela();
  }

  @override
  get changed => onChanged;
}

class FieldFornecedor extends FieldWidgets<Pessoa> {
  FieldFornecedor([Pessoa pessoa]):
  super
  (
    object: pessoa,
    value: pessoa?.fornecedor == "S",
    tristate: false,
  );
  
  @override
  void onChanged(bool value) {
    if (value) 
    {
      object.fornecedor = "S";
    }
    else {
      object.fornecedor = "N";
    }
    PessoaController.refrescarTela();
  }

  @override
  get changed => onChanged;
}

class FieldTransportadora extends FieldWidgets<Pessoa> {
  FieldTransportadora([Pessoa pessoa]):
  super
  (
    object: pessoa,
    value: pessoa?.transportadora == "S",
    tristate: false,
  );
  
  @override
  void onChanged(bool value) {
    if (value) 
    {
      object.transportadora = "S";
    }
    else {
      object.transportadora = "N";
    }
    PessoaController.refrescarTela();
  }

  @override
  get changed => onChanged;
}

class FieldColaborador extends FieldWidgets<Pessoa> {
  FieldColaborador([Pessoa pessoa]):
  super
  (
    object: pessoa,
    value: pessoa?.colaborador == "S",
    tristate: false,
  );
  
  @override
  void onChanged(bool value) {
    if (value) 
    {
      object.colaborador = "S";
    }
    else {
      object.colaborador = "N";
    }
    PessoaController.refrescarTela();
  }

  @override
  get changed => onChanged;
}

class FieldContador extends FieldWidgets<Pessoa> {
  FieldContador([Pessoa pessoa]):
  super
  (
    object: pessoa,
    value: pessoa?.contador == "S",
    tristate: false,
  );
  
  @override
  void onChanged(bool value) {
    if (value) 
    {
      object.contador = "S";
    }
    else {
      object.contador = "N";
    }
    PessoaController.refrescarTela();
  }

  @override
  get changed => onChanged;

}