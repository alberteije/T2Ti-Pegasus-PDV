import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_telefone.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

class PessoaTelefonePersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final PessoaTelefone pessoaTelefone;
  final String title;
  final String operacao;

  const PessoaTelefonePersistePage(
      {Key key, this.pessoa, this.pessoaTelefone, this.title, this.operacao})
      : super(key: key);

  @override
  PessoaTelefonePersistePageState createState() =>
      PessoaTelefonePersistePageState();
}

class PessoaTelefonePersistePageState
    extends State<PessoaTelefonePersistePage> {
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
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'Tipo de Telefone', 'Tipo', true),
                      isEmpty: widget.pessoaTelefone.tipo == null ||
                          widget.pessoaTelefone?.tipo == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoaTelefone?.tipo, (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoaTelefone?.tipo = newValue;
                        });
                      }, <String>[
                        'Residencial',
                        'Comercial',
                        'Celular',
                        'Outro',
                      ])),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Número do Telefone', 'Número', false),
                    onSaved: (String value) {
                      widget.pessoaTelefone.numero = value;
                    },
                    initialValue: widget.pessoaTelefone?.numero ?? '',
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
