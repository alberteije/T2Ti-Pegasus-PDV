import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_juridica.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

class PessoaJuridicaPersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const PessoaJuridicaPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.pessoa})
      : super(key: key);

  @override
  PessoaJuridicaPersistePageState createState() =>
      PessoaJuridicaPersistePageState();
}

class PessoaJuridicaPersistePageState
    extends State<PessoaJuridicaPersistePage> {
  @override
  Widget build(BuildContext context) {
    var cnpjController = new MaskedTextController(
      mask: '00.000.000/0000-00',
      text: widget.pessoa?.pessoaJuridica?.cnpj ?? '',
    );

    // se pessoa juridica estiver nulo aqui vamos instanciar o objeto
    // isso pode ocorrer caso a Pessoa tenha sido persistida sem PF e sem PJ por outro sistema que não este
    // ou se o usuário mudar de PF para PJ numa pessoa que já existe
    if (widget.pessoa.pessoaJuridica == null) {
      widget.pessoa.pessoaJuridica = new PessoaJuridica();
    }

    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: widget.scaffoldKey,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: widget.formKey,
          autovalidate: true,
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
                    controller: cnpjController,
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o CNPJ da Pessoa', 'CNPJ *', false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaJuridica.cnpj = value;
                    },
                    validator: ValidaCampoFormulario.validarCNPJ,
                    onChanged: (text) {
                      widget.pessoa.pessoaJuridica.cnpj = text;
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o nome de fantasia', 'Nome Fantasia', false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaJuridica.nomeFantasia = value;
                    },
                    initialValue:
                        widget.pessoa?.pessoaJuridica?.nomeFantasia ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe a Inscrição Estadual',
                        'Inscrição Estadual',
                        false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaJuridica.inscricaoEstadual = value;
                    },
                    initialValue:
                        widget.pessoa?.pessoaJuridica?.inscricaoEstadual ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe a Inscrição Municipal',
                        'Inscrição Municipal',
                        false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaJuridica.inscricaoMunicipal = value;
                    },
                    initialValue:
                        widget.pessoa?.pessoaJuridica?.inscricaoMunicipal ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe a Data de Constituição',
                        'Data de Constituição',
                        true),
                    isEmpty:
                        widget.pessoa.pessoaJuridica?.dataConstituicao == null,
                    child: DatePickerItem(
                      dateTime: widget.pessoa.pessoaJuridica?.dataConstituicao,
                      onChanged: (DateTime value) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoa.pessoaJuridica?.dataConstituicao =
                              value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'Tipo de Regime', 'Tipo de Regime', true),
                      isEmpty: widget.pessoa.pessoaJuridica == null ||
                          widget.pessoa.pessoaJuridica?.tipoRegime == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoa.pessoaJuridica?.tipoRegime,
                          (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoa.pessoaJuridica?.tipoRegime = newValue;
                        });
                      }, <String>[
                        '1-Lucro Real',
                        '2-Lucro Presumido',
                        '3-Simples Nacional'
                      ])),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'Código Regime Tributário', 'CRT', true),
                      isEmpty: widget.pessoa.pessoaJuridica == null ||
                          widget.pessoa.pessoaJuridica?.crt == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoa.pessoaJuridica?.crt, (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoa.pessoaJuridica?.crt = newValue;
                        });
                      }, <String>[
                        '1-Simples Nacional',
                        '2-Simples Nacional - Excesso',
                        '3-Regime Normal'
                      ])),
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
}
