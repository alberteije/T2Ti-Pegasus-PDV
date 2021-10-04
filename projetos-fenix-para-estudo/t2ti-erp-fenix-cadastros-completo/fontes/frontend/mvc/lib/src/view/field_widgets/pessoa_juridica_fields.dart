import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/model/pessoa_juridica.dart';

/// Classe que tem algum controle relacionado a página pessoa_juridica_persiste
class PessoaJuridicaFieldsPersiste extends PessoaJuridicaFieldsLista {

  /// controla se está no form persiste
  bool _inFormPersiste = false;
  
  /// chave do formulário da página pessoa_juridica_persiste
  final GlobalKey<FormState> _formKeyPessoaJuridicaPersistePage = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyPessoaJuridicaPersistePage {
    if (!_inFormPersiste) {
      _inFormPersiste = true;
    }
    return _formKeyPessoaJuridicaPersistePage;
  }

  /// controle do botão salvar da página pessoa_juridica_persiste
  void onPressedBotaoSalvar([BuildContext context]) {
    if (!_formKeyPessoaJuridicaPersistePage.currentState.validate()) return;
    /// após salvar o estado corrente do form, teremos o objeto _pessoaJuridica preenchido
    _formKeyPessoaJuridicaPersistePage.currentState.save();
    /// passa o _inFormPersiste para false, pois fecharemos a página e voltaremos para a página anterior
    _inFormPersiste = false;
    // PessoaJuridicaController.persistir(_pessoaJuridica);
    // PessoaJuridicaController.refrescarLista();
  }
}

/// Classe que tem algum controle relacionado a página pessoa_juridica_lista
class PessoaJuridicaFieldsLista extends PessoaJuridicaFields {
  final GlobalKey<ScaffoldState> scaffoldKeyPessoaJuridicaListaPage = GlobalKey<ScaffoldState>();
}

/// Classe que declara e disponibiliza os FieldWidgets
class PessoaJuridicaFields {
  FieldWidgets<PessoaJuridica> 
                    _fieldId,
                    _fieldIdPessoa,
                    _fieldCnpj,
                    _fieldNomeFantasia,
                    _fieldInscricaoEstadual,
                    _fieldInscricaoMunicipal,
                    _fieldDataConstituicao,
                    _fieldTipoRegime,
                    _fieldCrt;

  FieldId get fieldId => _fieldId;
  set fieldId(FieldId fieldId) => _fieldId = fieldId;

  FieldIdPessoa get fieldIdPessoa => _fieldIdPessoa;
  set fieldIdPessoa(FieldIdPessoa fieldIdPessoa) => _fieldIdPessoa = fieldIdPessoa;

  FieldCnpj get fieldCnpj => _fieldCnpj;
  set fieldCnpj(FieldCnpj fieldCnpj) => _fieldCnpj = fieldCnpj;

  FieldNomeFantasia get fieldNomeFantasia => _fieldNomeFantasia;
  set fieldNomeFantasia(FieldNomeFantasia fieldNomeFantasia) => _fieldNomeFantasia = fieldNomeFantasia;

  FieldInscricaoEstadual get fieldInscricaoEstadual => _fieldInscricaoEstadual;
  set fieldInscricaoEstadual(FieldInscricaoEstadual fieldInscricaoEstadual) => _fieldInscricaoEstadual = fieldInscricaoEstadual;

  FieldInscricaoMunicipal get fieldInscricaoMunicipal => _fieldInscricaoMunicipal;
  set fieldInscricaoMunicipal(FieldInscricaoMunicipal fieldInscricaoMunicipal) => _fieldInscricaoMunicipal = fieldInscricaoMunicipal;

  FieldDataConstituicao get fieldDataConstituicao => _fieldDataConstituicao;
  set fieldDataConstituicao(FieldDataConstituicao fieldDataConstituicao) => _fieldDataConstituicao = fieldDataConstituicao;

  FieldTipoRegime get fieldTipoRegime => _fieldTipoRegime;
  set fieldTipoRegime(FieldTipoRegime fieldTipoRegime) => _fieldTipoRegime = fieldTipoRegime;

  FieldCrt get fieldCrt => _fieldCrt;
  set fieldCrt(FieldCrt fieldCrt) => _fieldCrt = fieldCrt;

  /// PODO (Plain Old Dart Object) PessoaJuridica vinculado aos FieldWidgets
  PessoaJuridica _pessoaJuridica;

  /// Inicializa os FieldWidgets, se possível com os valores do objeto PessoaJuridica
  void init([Object pessoaJuridica]) {
    if (pessoaJuridica == null) {
      _pessoaJuridica = PessoaJuridica(
        "1", "1", "00000000000191", "Empresa de Teste", "123", "456", "10101990", "0", "0"
      );
    }
    else {
      if (pessoaJuridica is! PessoaJuridica) return;
      _pessoaJuridica = (pessoaJuridica as PessoaJuridica);
    }
    _fieldId = FieldId(_pessoaJuridica);
    _fieldIdPessoa = FieldIdPessoa(_pessoaJuridica);
    _fieldCnpj = FieldCnpj(_pessoaJuridica);
    _fieldNomeFantasia = FieldNomeFantasia(_pessoaJuridica);
    _fieldInscricaoEstadual = FieldInscricaoEstadual(_pessoaJuridica);
    _fieldInscricaoMunicipal = FieldInscricaoMunicipal(_pessoaJuridica);
    _fieldDataConstituicao = FieldDataConstituicao(_pessoaJuridica);
    _fieldTipoRegime = FieldTipoRegime(_pessoaJuridica);
    _fieldCrt = FieldCrt(_pessoaJuridica);
  }
}

/// Classes para instanciar os FieldWidgets individualmente
class FieldId extends FieldWidgets<PessoaJuridica> {
  FieldId([PessoaJuridica pessoaJuridica]):
  super
  (
    object: pessoaJuridica,
    label: 'Id',
    value: pessoaJuridica?.id
  );

  void onSaved(v) => object?.id = value = v;

  @override
  CircleAvatar get circleAvatar =>
    CircleAvatar(child: Text(value?.toString()));
}

class FieldIdPessoa extends FieldWidgets<PessoaJuridica> {
  FieldIdPessoa([PessoaJuridica pessoaJuridica]):
  super
  (
    object: pessoaJuridica,
    label: 'Id Pessoa',
    value: pessoaJuridica?.idPessoa
  );

  void onSaved(v) => object?.idPessoa = value = v;
}

class FieldCnpj extends FieldWidgets<PessoaJuridica> {
  FieldCnpj([PessoaJuridica pessoaJuridica]):
  super
  (
    object: pessoaJuridica,
    label: 'CNPJ',
    value: pessoaJuridica?.cnpj,
  );

  void onSaved(v) => object?.cnpj = value = v;
}

class FieldNomeFantasia extends FieldWidgets<PessoaJuridica> {
  FieldNomeFantasia([PessoaJuridica pessoaJuridica]):
  super
  (
    object: pessoaJuridica,
    label: 'Nome Fantasia',
    value: pessoaJuridica?.nomeFantasia
  );

  void onSaved(v) => object?.nomeFantasia = value = v;
}

class FieldInscricaoEstadual extends FieldWidgets<PessoaJuridica> {
  FieldInscricaoEstadual([PessoaJuridica pessoaJuridica]):
  super
  (
    object: pessoaJuridica,
    label: 'Inscrição Estadual',
    value: pessoaJuridica?.inscricaoEstadual,
  );

  void onSaved(v) => object?.inscricaoEstadual = value = v;
}

class FieldInscricaoMunicipal extends FieldWidgets<PessoaJuridica> {
  FieldInscricaoMunicipal([PessoaJuridica pessoaJuridica]):
  super
  (
    object: pessoaJuridica,
    label: 'Inscrição Municipal',
    value: pessoaJuridica?.inscricaoMunicipal,
  );

  void onSaved(v) => object?.inscricaoMunicipal = value = v;
}

class FieldDataConstituicao extends FieldWidgets<PessoaJuridica> {
  FieldDataConstituicao([PessoaJuridica pessoaJuridica]):
  super
  (
    object: pessoaJuridica,
    label: 'Data Constituição',
    value: pessoaJuridica?.dataConstituicao,
  );

  void onSaved(v) => object?.dataConstituicao = value = v;
}

class FieldTipoRegime extends FieldWidgets<PessoaJuridica> {
  FieldTipoRegime([PessoaJuridica pessoaJuridica]):
  super
  (
    object: pessoaJuridica,
    label: 'Tipo Regime',
    value: pessoaJuridica?.tipoRegime,
  );

  void onSaved(v) => object?.tipoRegime = value = v;
}

class FieldCrt extends FieldWidgets<PessoaJuridica> {
  FieldCrt([PessoaJuridica pessoaJuridica]):
  super
  (
    object: pessoaJuridica,
    label: 'CRT',
    value: pessoaJuridica?.crt,
  );

  void onSaved(v) => object?.crt = value = v;
}