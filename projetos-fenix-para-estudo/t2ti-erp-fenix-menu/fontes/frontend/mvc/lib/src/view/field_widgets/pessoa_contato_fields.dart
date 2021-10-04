import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/model/pessoa_contato.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_contato_controller.dart';

/// Classe que tem algum controle relacionado a página pessoa_contato_persiste
class PessoaContatoFieldsPersiste extends PessoaContatoFieldsLista {
  /// controla se está no form persiste
  bool _inFormPersiste = false;
  
  /// chave do formulário da página pessoa_contato_persiste
  final GlobalKey<FormState> _formKeyPessoaContatoPersistePage = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyPessoaContatoPersistePage {
    if (!_inFormPersiste) {
      _inFormPersiste = true;
    }
    return _formKeyPessoaContatoPersistePage;
  }

  /// controle do botão salvar da página pessoa_contato_persiste
  void onPressedBotaoSalvar([BuildContext context]) {
    if (!_formKeyPessoaContatoPersistePage.currentState.validate()) return;
    /// após salvar o estado corrente do form, teremos o objeto _pessoaContato preenchido
    _formKeyPessoaContatoPersistePage.currentState.save();
    /// passa o _inForm para false, pois fecharemos a página e voltaremos para a página anterior
    _inFormPersiste = false;
    PessoaContatoController.persistir(_pessoaContato);
    PessoaContatoController.refrescarLista();
  }

}

/// Classe que tem algum controle relacionado a página pessoa_contato_lista
class PessoaContatoFieldsLista extends PessoaContatoFields {
  final GlobalKey<ScaffoldState> scaffoldKeyPessoaContatoListaPage = GlobalKey<ScaffoldState>();
}

/// Classe que declara e disponibiliza os FieldWidgets
class PessoaContatoFields {
  FieldWidgets<PessoaContato> 
                    _fieldId, 
                    _fieldIdPessoa, 
                    _fieldEmail, 
                    _fieldNome, 
                    _fieldObservacao;

  FieldId get fieldId => _fieldId;
  set fieldId(FieldId fieldId) => _fieldId = fieldId;

  FieldIdPessoa get fieldIdPessoa => _fieldIdPessoa;
  set fieldIdPessoa(FieldIdPessoa fieldIdPessoa) => _fieldIdPessoa = fieldIdPessoa;

  FieldEmail get fieldEmail => _fieldEmail;
  set fieldEmail(FieldEmail fieldEmail) => _fieldEmail = fieldEmail;

  FieldNome get fieldNome => _fieldNome;
  set fieldNome(FieldNome fieldNome) => _fieldNome = fieldNome;

  FieldObservacao get fieldObservacao => _fieldObservacao;
  set fieldObservacao(FieldObservacao fieldObservacao) => _fieldObservacao = fieldObservacao;

  /// PODO (Plain Old Dart Object) PessoaContato vinculado aos FieldWidgets
  PessoaContato _pessoaContato;

  /// Inicializa os FieldWidgets, se possível com os valores do objeto PessoaContato
  void init([Object pessoaContato]) {
    if (pessoaContato == null) {
      _pessoaContato = PessoaContato();
    }
    else {
      if (pessoaContato is! PessoaContato) return;
      _pessoaContato = (pessoaContato as PessoaContato);
    }
    _fieldId = FieldId(_pessoaContato);
    _fieldEmail = FieldEmail(_pessoaContato);
    _fieldNome = FieldNome(_pessoaContato);
    _fieldObservacao = FieldObservacao(_pessoaContato);
  }
}

/// Classes para instanciar os FieldWidgets individualmente
class FieldId extends FieldWidgets<PessoaContato> {
  FieldId([PessoaContato pessoaContato]):
  super
  (
    object: pessoaContato,
    label: 'Id',
    value: pessoaContato?.id
  );

  void onSaved(v) => object?.id = value = v;

  @override
  CircleAvatar get circleAvatar =>
    CircleAvatar(child: Text(value?.toString()));
}

class FieldIdPessoa extends FieldWidgets<PessoaContato> {
  FieldIdPessoa([PessoaContato pessoaContato]):
  super
  (
    object: pessoaContato,
    label: 'Id Pessoa',
    value: pessoaContato?.idPessoa
  );

  void onSaved(v) => object?.idPessoa = value = v;
}

class FieldNome extends FieldWidgets<PessoaContato> {
  FieldNome([PessoaContato pessoaContato]):
  super
  (
    object: pessoaContato,
    label: 'Nome',
    value: pessoaContato?.nome
  );

  void onSaved(v) => object?.nome = value = v;
}

class FieldEmail extends FieldWidgets<PessoaContato> {
  FieldEmail([PessoaContato pessoaContato]):
  super
  (
    object: pessoaContato,
    label: 'Email',
    value: pessoaContato?.email,
  );

  void onSaved(v) => object?.email = value = v;
}

class FieldObservacao extends FieldWidgets<PessoaContato> {
  FieldObservacao([PessoaContato pessoaContato]):
  super
  (
    object: pessoaContato,
    label: 'Observacao',
    value: pessoaContato?.observacao
  );

  void onSaved(v) => object?.observacao = value = v;
}