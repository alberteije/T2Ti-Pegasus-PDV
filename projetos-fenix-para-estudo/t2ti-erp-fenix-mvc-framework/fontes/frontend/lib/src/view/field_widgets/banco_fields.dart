import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/model/banco.dart';
import 'package:t2ti_erp_fenix/src/controller/banco_controller.dart';

/// Classe que tem algum controle relacionado a página banco_persiste
class BancoFieldsPersiste extends BancoFieldsLista {
  /// controla se está no form persiste
  bool _inFormPersiste = false;
  
  /// chave do formulário da página banco_persiste
  final GlobalKey<FormState> _formKeyBancoPersistePage = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyBancoPersistePage {
    if (!_inFormPersiste) {
      _inFormPersiste = true;
    }
    return _formKeyBancoPersistePage;
  }

  /// controle do botão salvar da página banco_persiste
  void onPressedBotaoSalvar([BuildContext context]) {
    if (!_formKeyBancoPersistePage.currentState.validate()) return;
    /// após salvar o estado corrente do form, teremos o objeto _banco preenchido
    _formKeyBancoPersistePage.currentState.save();
    /// passa o _inForm para false, pois fecharemos a página e voltaremos para a página anterior
    _inFormPersiste = false;
    BancoController.persistir(_banco);
    BancoController.refrescarLista();
  }

}

/// Classe que tem algum controle relacionado a página banco_lista
class BancoFieldsLista extends BancoFields {
  final GlobalKey<ScaffoldState> scaffoldKeyBancoListaPage = GlobalKey<ScaffoldState>();
}

/// Classe que declara e disponibiliza os FieldWidgets
class BancoFields {
  FieldWidgets<Banco> 
                    _fieldId, 
                    _fieldCodigo, 
                    _fieldNome, 
                    _fieldUrl;

  FieldId get fieldId => _fieldId;
  set fieldId(FieldId fieldId) => _fieldId = fieldId;

  FieldCodigo get fieldCodigo => _fieldCodigo;
  set fieldCodigo(FieldCodigo fieldCodigo) => _fieldCodigo = fieldCodigo;

  FieldNome get fieldNome => _fieldNome;
  set fieldNome(FieldNome fieldNome) => _fieldNome = fieldNome;

  FieldUrl get fieldUrl => _fieldUrl;
  set fieldUrl(FieldUrl fieldUrl) => _fieldUrl = fieldUrl;

  /// PODO (Plain Old Dart Object) Banco vinculado aos FieldWidgets
  Banco _banco;

  /// Inicializa os FieldWidgets, se possível com os valores do objeto Banco
  void init([Object banco]) {
    if (banco == null) {
      _banco = Banco();
    }
    else {
      if (banco is! Banco) return;
      _banco = (banco as Banco);
    }
    _fieldId = FieldId(_banco);
    _fieldCodigo = FieldCodigo(_banco);
    _fieldNome = FieldNome(_banco);
    _fieldUrl = FieldUrl(_banco);
  }
}

/// Classes para instanciar os FieldWidgets individualmente
class FieldId extends FieldWidgets<Banco> {
  FieldId([Banco banco]):
  super
  (
    object: banco,
    label: 'Id',
    value: banco?.id
  );

  void onSaved(v) => object?.id = value = v;
}

class FieldCodigo extends FieldWidgets<Banco> {
  FieldCodigo([Banco banco]):
  super
  (
    object: banco,
    label: 'Código',
    value: banco?.codigo,
    keyboardType: TextInputType.number
  );

  void onSaved(v) => object?.codigo = value = v;

  @override
  CircleAvatar get circleAvatar =>
    CircleAvatar(child: Text(value.length > 1 ? value?.substring(0, 3) : ""));
}

class FieldNome extends FieldWidgets<Banco> {
  FieldNome([Banco banco]):
  super
  (
    object: banco,
    label: 'Nome',
    value: banco?.nome
  );

  void onSaved(v) => object?.nome = value = v;
}

class FieldUrl extends FieldWidgets<Banco> {
  FieldUrl([Banco banco]):
  super
  (
    object: banco,
    label: 'Url',
    value: banco?.url
  );

  void onSaved(v) => object?.url = value = v;
}