import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_contato.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

class PessoaContatoPersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final PessoaContato pessoaContato;
  final String title;
  final String operacao;

  const PessoaContatoPersistePage(
      {Key key, this.pessoa, this.pessoaContato, this.title, this.operacao})
      : super(key: key);

  @override
  PessoaContatoPersistePageState createState() =>
      PessoaContatoPersistePageState();
}

class PessoaContatoPersistePageState extends State<PessoaContatoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () async {
              final FormState form = _formKey.currentState;
              if (!form.validate()) {
                _autoValidate = true;
                ViewUtilLib.showInSnackBar(
                    'Por favor, corrija os erros apresentados antes de continuar.',
                    _scaffoldKey);
              } else {
                form.save();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          onWillPop: _avisarUsuarioFormAlterado,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o nome do contato', 'Nome *', false),
                    onSaved: (String value) {
                      widget.pessoaContato.nome = value;
                    },
                    initialValue: widget.pessoaContato?.nome ?? '',
                    validator:
                        ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o Email da Pessoa', 'Email', false),
                    onSaved: (String value) {
                      widget.pessoaContato.email = value;
                    },
                    initialValue: widget.pessoaContato?.email ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Observações', 'Observação', false),
                    onSaved: (String value) {
                      widget.pessoaContato.observacao = value;
                    },
                    initialValue: widget.pessoaContato?.observacao ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    '* indica que o campo é obrigatório',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) return true;

    return await ViewUtilLib.gerarDialogBoxFormAlterado(context);
  }
}
