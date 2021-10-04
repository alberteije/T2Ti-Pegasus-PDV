import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/cadastros/banco.dart';
import 'package:fenix/src/view_model/cadastros/banco_view_model.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

class BancoPersistePage extends StatefulWidget {
  final Banco banco;
  final String title;
  final String operacao;

  const BancoPersistePage({Key key, this.banco, this.title, this.operacao})
      : super(key: key);

  @override
  BancoPersistePageState createState() => BancoPersistePageState();
}

class BancoPersistePageState extends State<BancoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var bancoProvider = Provider.of<BancoViewModel>(context);

    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: ViewUtilLib.getIconBotaoSalvar(),
            onPressed: () async {
              final FormState form = _formKey.currentState;
              if (!form.validate()) {
                _autoValidate = true;
                ViewUtilLib.showInSnackBar(
                    'Por favor, corrija os erros apresentados antes de continuar.',
                    _scaffoldKey);
              } else {
                form.save();
                if (widget.operacao == 'A') {
                  await bancoProvider.alterar(widget.banco);
                } else {
                  await bancoProvider.inserir(widget.banco);
                }
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
                    keyboardType: TextInputType.number,
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o código FEBRABAN para o banco',
                        'Código *',
                        false),
                    onSaved: (String value) {
                      widget.banco.codigo = value;
                    },
                    initialValue: widget.banco?.codigo ?? '',
                    validator: ValidaCampoFormulario.validarObrigatorioNumerico,
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o nome do Banco', 'Nome *', false),
                    onSaved: (String value) {
                      widget.banco.nome = value;
                    },
                    initialValue: widget.banco?.nome ?? '',
                    validator:
                        ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe a URL do Banco', 'URL', false),
                    onSaved: (String value) {
                      widget.banco.url = value;
                    },
                    initialValue: widget.banco?.url ?? '',
                    onChanged: (text) {
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