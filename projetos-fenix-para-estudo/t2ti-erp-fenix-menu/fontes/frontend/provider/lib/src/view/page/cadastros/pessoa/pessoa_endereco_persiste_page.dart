import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_endereco.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';
import 'package:fenix/src/view/shared/dropdown_lista.dart';

class PessoaEnderecoPersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final PessoaEndereco pessoaEndereco;
  final String title;
  final String operacao;

  const PessoaEnderecoPersistePage(
      {Key key, this.pessoa, this.pessoaEndereco, this.title, this.operacao})
      : super(key: key);

  @override
  PessoaEnderecoPersistePageState createState() =>
      PessoaEnderecoPersistePageState();
}

class PessoaEnderecoPersistePageState
    extends State<PessoaEnderecoPersistePage> {
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
                        'Informe o logradouro da Pessoa',
                        'Logradouro *',
                        false),
                    onSaved: (String value) {
                      widget.pessoaEndereco.logradouro = value;
                    },
                    initialValue: widget.pessoaEndereco?.logradouro ?? '',
                    validator:
                        ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Número do Endereco', 'Número', false),
                    onSaved: (String value) {
                      widget.pessoaEndereco.numero = value;
                    },
                    initialValue: widget.pessoaEndereco?.numero ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Bairro do Endereco', 'Bairro', false),
                    onSaved: (String value) {
                      widget.pessoaEndereco.bairro = value;
                    },
                    initialValue: widget.pessoaEndereco?.bairro ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Código do Município no IBGE', 'Município IBGE', false),
                    onSaved: (String value) {
                      widget.pessoaEndereco.municipioIbge = int.tryParse(value);
                    },
                    initialValue:
                        widget.pessoaEndereco?.municipioIbge?.toString() ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'UF do Endereço', 'UF', true),
                      isEmpty: widget.pessoaEndereco.uf == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoaEndereco.uf, (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoaEndereco.uf = newValue;
                        });
                      }, DropdownLista.listaUF)),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'CEP do Endereco', 'CEP', false),
                    onSaved: (String value) {
                      widget.pessoaEndereco.cep = value;
                    },
                    initialValue: widget.pessoaEndereco?.cep ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Cidade do Endereco', 'Cidade', false),
                    onSaved: (String value) {
                      widget.pessoaEndereco.cidade = value;
                    },
                    initialValue: widget.pessoaEndereco?.cidade ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Complemento do Endereco', 'Complemento', false),
                    onSaved: (String value) {
                      widget.pessoaEndereco.complemento = value;
                    },
                    initialValue: widget.pessoaEndereco?.complemento ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'Endereço é Principal',
                          'É Endereço Principal?',
                          true),
                      isEmpty: widget.pessoaEndereco.principal == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoaEndereco.principal, (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoaEndereco.principal = newValue;
                        });
                      }, <String>['Sim', 'Não'])),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'Endereço é de Entrega',
                          'É Endereço de Entrega?',
                          true),
                      isEmpty: widget.pessoaEndereco.entrega == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoaEndereco.entrega, (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoaEndereco.entrega = newValue;
                        });
                      }, <String>['Sim', 'Não'])),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'Endereço é de Cobrança',
                          'É Endereço de Cobrança?',
                          true),
                      isEmpty: widget.pessoaEndereco.cobranca == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoaEndereco.cobranca, (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoaEndereco.cobranca = newValue;
                        });
                      }, <String>['Sim', 'Não'])),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'Endereço é de Correspondência',
                          'É Endereço de Correspondência?',
                          true),
                      isEmpty: widget.pessoaEndereco.correspondencia == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoaEndereco.correspondencia,
                          (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoaEndereco.correspondencia = newValue;
                        });
                      }, <String>['Sim', 'Não'])),
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
