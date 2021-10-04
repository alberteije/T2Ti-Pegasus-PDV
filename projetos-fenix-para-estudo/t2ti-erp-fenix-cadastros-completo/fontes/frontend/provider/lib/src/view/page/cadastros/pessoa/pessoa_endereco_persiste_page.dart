/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe PersistePage relacionada à tabela [PESSOA_ENDERECO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fenix/src/infra/constantes.dart';
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

class PessoaEnderecoPersistePageState extends State<PessoaEnderecoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
	var cepController = new MaskedTextController(
		mask: Constantes.mascaraCEP,
		text: widget.pessoaEndereco?.cep ?? '',
	);
	
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
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.pessoaEndereco?.logradouro ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Logradouro',
				  		'Logradouro',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoaEndereco.logradouro = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 10,
				  	maxLines: 1,
				  	initialValue: widget.pessoaEndereco?.numero ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Número do Endereço',
				  		'Número',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoaEndereco.numero = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.pessoaEndereco?.bairro ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Bairro do Endereço',
				  		'Bairro',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoaEndereco.bairro = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 11,
				  	maxLines: 1,
				  	initialValue: widget.pessoaEndereco?.municipioIbge ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Código IBGE do Município',
				  		'Município IBGE',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoaEndereco.municipioIbge = int.tryParse(value);
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a UF do Endereço',
				  		'UF',
				  		true),
				  	isEmpty: widget.pessoaEndereco.uf == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoaEndereco.uf,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoaEndereco.uf = newValue;
				  	});
				  	}, DropdownLista.listaUF)),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: cepController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o CEP do Endereço',
				  		'CEP',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoaEndereco.cep = value;
				  	},
				  	onChanged: (text) {
				  		widget.pessoaEndereco.cep = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.pessoaEndereco?.cidade ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome da Cidade do Endereço',
				  		'Cidade',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoaEndereco.cidade = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.pessoaEndereco?.complemento ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Complemento do Endereço',
				  		'Complemento',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoaEndereco.complemento = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'É Endereço Principal?',
				  		'É Endereço Principal',
				  		true),
				  	isEmpty: widget.pessoaEndereco.principal == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoaEndereco.principal,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoaEndereco.principal = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'É Endereço de Entrega?',
				  		'É Endereço de Entrega',
				  		true),
				  	isEmpty: widget.pessoaEndereco.entrega == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoaEndereco.entrega,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoaEndereco.entrega = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'É Endereço de Cobrança?',
				  		'É Endereço de Cobrança',
				  		true),
				  	isEmpty: widget.pessoaEndereco.cobranca == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoaEndereco.cobranca,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoaEndereco.cobranca = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'É Endereço de Correspondência?',
				  		'É Endereço de Correspondência',
				  		true),
				  	isEmpty: widget.pessoaEndereco.correspondencia == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoaEndereco.correspondencia,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoaEndereco.correspondencia = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
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

  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) return true;

    return await ViewUtilLib.gerarDialogBoxFormAlterado(context);
  }
}
