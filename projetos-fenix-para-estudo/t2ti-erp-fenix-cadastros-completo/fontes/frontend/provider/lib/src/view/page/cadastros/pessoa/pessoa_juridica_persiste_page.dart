/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [PESSOA_JURIDICA] 
                                                                                
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
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

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

class PessoaJuridicaPersistePageState extends State<PessoaJuridicaPersistePage> {
  @override
  Widget build(BuildContext context) {
	var cnpjController = new MaskedTextController(
		mask: Constantes.mascaraCNPJ,
		text: widget.pessoa?.pessoaJuridica?.cnpj ?? '',
	);
	
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
				  		'Informe o CNPJ da Pessoa',
				  		'CNPJ *',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaJuridica?.cnpj = value;
				  	},
				  	validator: ValidaCampoFormulario.validarObrigatorioCNPJ,
				  	onChanged: (text) {
				  		widget.pessoa.pessoaJuridica?.cnpj = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.pessoaJuridica?.nomeFantasia ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome de Fantasia da Pessoa Jurídica',
				  		'Nome de Fantasia',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaJuridica?.nomeFantasia = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 45,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.pessoaJuridica?.inscricaoEstadual ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Inscrição Estadual da Pessoa Jurídica',
				  		'Inscrição Estadual',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaJuridica?.inscricaoEstadual = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 45,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.pessoaJuridica?.inscricaoMunicipal ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Inscrição Municipal da Pessoa Jurídica',
				  		'Inscrição Municipal',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaJuridica?.inscricaoMunicipal = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data de Constituição da Pessoa Jurídica',
				  		'Data Constituição',
				  		true),
				  	isEmpty: widget.pessoa.pessoaJuridica?.dataConstituicao == null,
				  	child: DatePickerItem(
				  		dateTime: widget.pessoa.pessoaJuridica?.dataConstituicao,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.pessoa.pessoaJuridica?.dataConstituicao = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Tipo de Regime da Pessoa Jurídica',
				  		'Tipo Regime',
				  		true),
				  	isEmpty: widget.pessoa?.pessoaJuridica?.tipoRegime == null ||
				  		widget.pessoa?.pessoaJuridica == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.pessoaJuridica?.tipoRegime,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoa.pessoaJuridica?.tipoRegime = newValue;
				  	});
				  	}, <String>[
				  		'1-Lucro REAL',
				  		'2-Lucro presumido',
				  		'3-Simples nacional',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Código de Regime Tributário',
				  		'CRT',
				  		true),
				  	isEmpty: widget.pessoa?.pessoaJuridica?.crt == null ||
				  		widget.pessoa?.pessoaJuridica == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.pessoaJuridica?.crt,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoa.pessoaJuridica?.crt = newValue;
				  	});
				  	}, <String>[
				  		'1-Simples Nacional',
				  		'2-Simples Nacional - excesso de sublimite da receita bruta',
				  		'3-Regime Normal',
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