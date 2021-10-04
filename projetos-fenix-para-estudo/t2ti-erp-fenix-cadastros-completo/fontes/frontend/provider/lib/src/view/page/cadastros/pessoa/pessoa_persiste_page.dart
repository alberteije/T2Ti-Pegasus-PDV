/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [PESSOA] 
                                                                                
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

import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

class PessoaPersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function atualizaPessoaCallBack;

  const PessoaPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.pessoa, this.atualizaPessoaCallBack})
      : super(key: key);

  @override
  PessoaPersistePageState createState() => PessoaPersistePageState();
}

class PessoaPersistePageState extends State<PessoaPersistePage> {
  @override
  Widget build(BuildContext context) {

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
				  	maxLength: 150,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.nome ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o nome da Pessoa',
				  		'Nome *',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.nome = value;
				  	},
				  	validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Tipo de pessoa: Física ou Jurídica',
				  		'Tipo',
				  		true),
				  	isEmpty: widget.pessoa.tipo == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.tipo,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoa.tipo = newValue;
              widget.atualizaPessoaCallBack();
				  	});
				  	}, <String>[
				  		'Física',
				  		'Jurídica',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.url,
				  	maxLength: 250,
				  	maxLines: 3,
				  	initialValue: widget.pessoa?.site ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o site da Pessoa',
				  		'Site',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.site = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.emailAddress,
				  	maxLength: 250,
				  	maxLines: 3,
				  	initialValue: widget.pessoa?.email ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o e-mail da Pessoa',
				  		'E-Mail',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.email = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Pessoa é Cliente?',
				  		'Pessoa é Cliente',
				  		true),
				  	isEmpty: widget.pessoa.cliente == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.cliente,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoa.cliente = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Pessoa é Fornecedor?',
				  		'Pessoa é Fornecedor',
				  		true),
				  	isEmpty: widget.pessoa.fornecedor == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.fornecedor,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoa.fornecedor = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Pessoa é Transportadora?',
				  		'Pessoa é Transportadora',
				  		true),
				  	isEmpty: widget.pessoa.transportadora == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.transportadora,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoa.transportadora = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Pessoa é Colaborador?',
				  		'Pessoa é Colaborador',
				  		true),
				  	isEmpty: widget.pessoa.colaborador == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.colaborador,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoa.colaborador = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Pessoa é Contador?',
				  		'Pessoa é Contador',
				  		true),
				  	isEmpty: widget.pessoa.contador == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.contador,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoa.contador = newValue;
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
}
