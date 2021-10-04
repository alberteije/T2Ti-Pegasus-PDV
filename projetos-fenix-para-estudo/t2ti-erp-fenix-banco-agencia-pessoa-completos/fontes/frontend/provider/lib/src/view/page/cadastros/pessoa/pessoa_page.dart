import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/view_model/cadastros/pessoa_view_model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'pessoa_persiste_page.dart';
import 'pessoa_juridica_persiste_page.dart';
import 'pessoa_fisica_persiste_page.dart';
import 'pessoa_contato_lista_page.dart';
import 'pessoa_telefone_lista_page.dart';
import 'pessoa_endereco_lista_page.dart';

List<Aba> _todasAsAbas = <Aba>[];

List<Aba> getAbasAtivas() {
  List<Aba> retorno = [];
  for (var item in _todasAsAbas) {
    if (item.visible) retorno.add(item);
  }
  return retorno;
}

class PessoaPage extends StatefulWidget {
  final Pessoa pessoa;
  final String title;
  final String operacao;

  PessoaPage({this.pessoa, this.title, this.operacao, Key key})
      : super(key: key);

  @override
  PessoaPageState createState() => PessoaPageState();
}

class PessoaPageState extends State<PessoaPage>
    with SingleTickerProviderStateMixin {
  TabController _abasController;
  String _estiloBotoesAba = 'iconsAndText';

  // Pessoa
  final GlobalKey<FormState> _pessoaPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _pessoaPersisteScaffoldKey =
      GlobalKey<ScaffoldState>();

  // Pessoa Física
  final GlobalKey<FormState> _pessoaFisicaPersisteFormKey =
      GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _pessoaFisicaPersisteScaffoldKey =
      GlobalKey<ScaffoldState>();

  // Pessos Jurídica
  final GlobalKey<FormState> _pessoaJuridicaPersisteFormKey =
      GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _pessoaJuridicaPersisteScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    atualizarAbas();
    _abasController =
        TabController(vsync: this, length: getAbasAtivas().length);
    _abasController.addListener(salvarForms);
    ViewUtilLib.paginaMestreDetalheFoiAlterada =
        false; // vamos controlar as alterações nas paginas filhas aqui para alertar ao usuario sobre possivel perda de dados
  }

  @override
  void dispose() {
    _abasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewUtilLib.getScaffoldAbaPage(
        widget.title,
        context,
        _abasController,
        getAbasAtivas(),
        getIndicator(),
        _estiloBotoesAba,
        salvarPessoa,
        alterarEstiloBotoes,
        avisarUsuarioAlteracoesNaPagina);
  }

  void atualizarAbas() {
    _todasAsAbas.clear();
    _todasAsAbas.add(Aba(
        icon: Icons.receipt,
        text: 'Detalhes',
        visible: true,
        pagina: PessoaPersistePage(
          formKey: _pessoaPersisteFormKey,
          scaffoldKey: _pessoaPersisteScaffoldKey,
          pessoa: widget.pessoa,
          atualizaPessoaCallBack: this.atualizarFisicaOuJuridica,
        )));
    _todasAsAbas.add(Aba(
        icon: Icons.person,
        text: 'Pessoa Física',
        visible: widget.pessoa.tipo == 'Física',
        pagina: PessoaFisicaPersistePage(
            formKey: _pessoaFisicaPersisteFormKey,
            scaffoldKey: _pessoaFisicaPersisteScaffoldKey,
            pessoa: widget.pessoa)));
    _todasAsAbas.add(Aba(
        icon: Icons.business,
        text: 'Pessoa Jurídica',
        visible: widget.pessoa.tipo == 'Jurídica',
        pagina: PessoaJuridicaPersistePage(
            formKey: _pessoaJuridicaPersisteFormKey,
            scaffoldKey: _pessoaJuridicaPersisteScaffoldKey,
            pessoa: widget.pessoa)));
    _todasAsAbas.add(Aba(
        icon: Icons.group,
        text: 'Contatos',
        visible: true,
        pagina: PessoaContatoListaPage(pessoa: widget.pessoa)));
    _todasAsAbas.add(Aba(
        icon: Icons.place,
        text: 'Endereços',
        visible: true,
        pagina: PessoaEnderecoListaPage(pessoa: widget.pessoa)));
    _todasAsAbas.add(Aba(
        icon: Icons.phone,
        text: 'Telefones',
        visible: true,
        pagina: PessoaTelefoneListaPage(pessoa: widget.pessoa)));
  }

  void atualizarFisicaOuJuridica() {
    setState(() {
      if (widget.pessoa.tipo == 'Física') {
          widget.pessoa.pessoaJuridica = null;
      } else {
          widget.pessoa.pessoaFisica = null;
      }
      atualizarAbas();
    });
  }

  void salvarForms() {
    // valida e salva o form PessoaDetalhe
    FormState formPessoa = _pessoaPersisteFormKey.currentState;
    if (formPessoa != null) {
      if (!formPessoa.validate()) {
        _abasController.animateTo(0);
      } else {
        _pessoaPersisteFormKey.currentState?.save();
      }
    }

    // valida e salva o form PessoaFisica
    FormState formPessoaFisica = _pessoaFisicaPersisteFormKey.currentState;
    if (formPessoaFisica != null) {
      if (!formPessoaFisica.validate()) {
        _abasController.animateTo(1);
      } else {
        _pessoaFisicaPersisteFormKey.currentState?.save();
      }
    }

    // valida e salva o form PessoaJuridica
    FormState formPessoaJuridica = _pessoaJuridicaPersisteFormKey.currentState;
    if (formPessoaJuridica != null) {
      if (!formPessoaJuridica.validate()) {
        _abasController.animateTo(1);
      } else {
        _pessoaJuridicaPersisteFormKey.currentState?.save();
      }
    }
  }

  void salvarPessoa() async {
    salvarForms();
    var pessoaProvider = Provider.of<PessoaViewModel>(context);
    if (widget.operacao == 'A') {
      await pessoaProvider.alterar(widget.pessoa);
    } else {
      await pessoaProvider.inserir(widget.pessoa);
    }
    Navigator.pop(context);
  }

  void alterarEstiloBotoes(String style) {
    setState(() {
      _estiloBotoesAba = style;
    });
  }

  Decoration getIndicator() {
    return ViewUtilLib.getShapeDecorationAbaPage(_estiloBotoesAba);
  }

  Future<bool> avisarUsuarioAlteracoesNaPagina() async {
    if (!ViewUtilLib.paginaMestreDetalheFoiAlterada) return true;
    return await ViewUtilLib.gerarDialogBoxFormAlterado(context);
  }
}
