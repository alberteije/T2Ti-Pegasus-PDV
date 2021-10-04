import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/cadastros/banco.dart';
import 'package:fenix/src/model/cadastros/banco_agencia.dart';
import 'package:fenix/src/view_model/cadastros/banco_agencia_view_model.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/view/shared/lookup_page.dart';

class BancoAgenciaPersistePage extends StatefulWidget {
  final BancoAgencia bancoAgencia;
  final String title;
  final String operacao;

  const BancoAgenciaPersistePage({Key key, this.bancoAgencia, this.title, this.operacao})
      : super(key: key);

  @override
  BancoAgenciaPersistePageState createState() => BancoAgenciaPersistePageState();
}

class BancoAgenciaPersistePageState extends State<BancoAgenciaPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var bancoAgenciaProvider = Provider.of<BancoAgenciaViewModel>(context);
    var importaBancoController = TextEditingController();
    importaBancoController.text = widget.bancoAgencia?.banco?.nome ?? '';

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
                if (widget.operacao == 'A') {
                  await bancoAgenciaProvider.alterar(widget.bancoAgencia);
                } else {
                  await bancoAgenciaProvider.inserir(widget.bancoAgencia);
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: TextFormField(
                            controller: importaBancoController,
                            readOnly: true,
                            decoration:
                                ViewUtilLib.getInputDecorationPersistePage(
                                    'Importe o Banco vinculado',
                                    'Banco *',
                                    false),
                            onSaved: (String value) {
                              widget.bancoAgencia.banco.nome = value;
                            },
                            validator: ValidaCampoFormulario
                                .validarObrigatorioAlfanumerico,
                            onChanged: (text) {
                              _formFoiAlterado = true;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: IconButton(
                          tooltip: 'Importar Banco',
                          icon: const Icon(Icons.search),
                          onPressed: () async {
                            ///chamando o lookup
                            Map<String, dynamic> objetoJsonRetorno =
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LookupPage(
                                        title: 'Importar Banco',
                                        colunas: Banco.colunas,
                                        campos: Banco.campos,
                                        rota: '/banco/',
                                      ),
                                      fullscreenDialog: true,
                                    ));
                            if (objetoJsonRetorno != null) {
                              if (objetoJsonRetorno['nome'] != null) {
                                importaBancoController.text =
                                    objetoJsonRetorno['nome'];
                                widget.bancoAgencia.idBanco =
                                    objetoJsonRetorno['id'];
                                widget.bancoAgencia.banco =
                                    new Banco.fromJson(objetoJsonRetorno);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o número da Agência', 'Número *', false),
                    onSaved: (String value) {
                      widget.bancoAgencia.numero = value;
                    },
                    initialValue: widget.bancoAgencia?.numero ?? '',
                    validator: ValidaCampoFormulario.validarObrigatorioNumerico,
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o dígito do número da Agência',
                        'Dígito *',
                        false),
                    onSaved: (String value) {
                      widget.bancoAgencia.digito = value;
                    },
                    initialValue: widget.bancoAgencia?.digito ?? '',
                    validator: ValidaCampoFormulario.validarObrigatorioNumerico,
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o nome da Agência', 'Nome *', false),
                    onSaved: (String value) {
                      widget.bancoAgencia.nome = value;
                    },
                    initialValue: widget.bancoAgencia?.nome ?? '',
                    validator:
                        ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o telefone da Agência', 'Telefone', false),
                    onSaved: (String value) {
                      widget.bancoAgencia.telefone = value;
                    },
                    initialValue: widget.bancoAgencia?.telefone ?? '',
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o contato da Agência', 'Contato', false),
                    onSaved: (String value) {
                      widget.bancoAgencia.contato = value;
                    },
                    initialValue: widget.bancoAgencia?.contato ?? '',
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe a observação', 'Observação', false),
                    onSaved: (String value) {
                      widget.bancoAgencia.observacao = value;
                    },
                    initialValue: widget.bancoAgencia?.observacao ?? '',
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o nome do gerente', 'Gerente', false),
                    onSaved: (String value) {
                      widget.bancoAgencia.gerente = value;
                    },
                    initialValue: widget.bancoAgencia?.gerente ?? '',
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
