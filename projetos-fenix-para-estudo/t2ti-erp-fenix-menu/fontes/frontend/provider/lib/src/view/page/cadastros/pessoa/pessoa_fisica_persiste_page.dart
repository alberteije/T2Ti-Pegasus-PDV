import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_fisica.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

class PessoaFisicaPersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const PessoaFisicaPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.pessoa})
      : super(key: key);

  @override
  PessoaFisicaPersistePageState createState() =>
      PessoaFisicaPersistePageState();
}

class PessoaFisicaPersistePageState extends State<PessoaFisicaPersistePage> {
  @override
  Widget build(BuildContext context) {
    var cpfController = new MaskedTextController(
      mask: '000.000.000-00',
      text: widget.pessoa?.pessoaFisica?.cpf ?? '',
    );

    // se pessoa fisica estiver nulo aqui vamos instanciar o objeto
    // isso pode ocorrer caso a Pessoa tenha sido persistida sem PF e sem PJ por outro sistema que não este
    // ou se o usuário mudar de PF para PJ numa pessoa que já existe
    if (widget.pessoa.pessoaFisica == null) {
      widget.pessoa.pessoaFisica = new PessoaFisica();
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
                    controller: cpfController,
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o CPF da Pessoa', 'CPF *', false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaFisica.cpf = value;
                    },
                    validator: ValidaCampoFormulario.validarCPF,
                    onChanged: (text) {
                      widget.pessoa.pessoaFisica.cpf = text;
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o RG', 'RG', false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaFisica.rg = value;
                    },
                    initialValue: widget.pessoa?.pessoaFisica?.rg ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o Órgão do RG', 'Órgão RG', false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaFisica.orgaoRg = value;
                    },
                    initialValue: widget.pessoa?.pessoaFisica?.orgaoRg ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe a Data de Emissão do RG',
                        'Data de Emissão do RG',
                        true),
                    isEmpty: widget.pessoa.pessoaFisica?.dataEmissaoRg == null,
                    child: DatePickerItem(
                      dateTime: widget.pessoa.pessoaFisica?.dataEmissaoRg,
                      onChanged: (DateTime value) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoa.pessoaFisica?.dataEmissaoRg = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe a Data de Nascimento',
                        'Data de Nascimento',
                        true),
                    isEmpty: widget.pessoa.pessoaFisica?.dataNascimento == null,
                    child: DatePickerItem(
                      dateTime: widget.pessoa.pessoaFisica?.dataNascimento,
                      onChanged: (DateTime value) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoa.pessoaFisica?.dataNascimento = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'Sexo', 'Sexo', true),
                      isEmpty: widget.pessoa.pessoaFisica == null ||
                          widget.pessoa.pessoaFisica?.sexo == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoa.pessoaFisica?.sexo, (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoa.pessoaFisica?.sexo = newValue;
                        });
                      }, <String>[
                        'Masculino',
                        'Feminino',
                      ])),
                  const SizedBox(height: 24.0),
                  InputDecorator(
                      decoration: ViewUtilLib.getInputDecorationPersistePage(
                          'Raça', 'Raça', true),
                      isEmpty: widget.pessoa.pessoaFisica == null ||
                          widget.pessoa.pessoaFisica?.raca == null,
                      child: ViewUtilLib.getDropDownButton(
                          widget.pessoa.pessoaFisica?.raca, (String newValue) {
                        ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                        setState(() {
                          widget.pessoa.pessoaFisica?.raca = newValue;
                        });
                      }, <String>[
                        'Branco',
                        'Negro',
                        'Pardo',
                        'Indio',
                      ])),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe a Nacionalidade', 'Nacionalidade', false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaFisica.nacionalidade = value;
                    },
                    initialValue:
                        widget.pessoa?.pessoaFisica?.nacionalidade ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe a Naturalidade', 'Naturalidade', false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaFisica.naturalidade = value;
                    },
                    initialValue:
                        widget.pessoa?.pessoaFisica?.naturalidade ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o Nome do Pai', 'Nome do Pai', false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaFisica.nomePai = value;
                    },
                    initialValue: widget.pessoa?.pessoaFisica?.nomePai ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: ViewUtilLib.getInputDecorationPersistePage(
                        'Informe o Nome da Mãe', 'Nome da Mãe', false),
                    onSaved: (String value) {
                      widget.pessoa.pessoaFisica.nomeMae = value;
                    },
                    initialValue: widget.pessoa?.pessoaFisica?.nomeMae ?? '',
                    onChanged: (text) {
                      ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
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
}
