/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [PESSOA_FISICA] 
                                                                                
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

import 'package:fenix/src/view/shared/lookup_page.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

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
	var importaNivelFormacaoController = TextEditingController();
	importaNivelFormacaoController.text = widget.pessoa?.pessoaFisica?.nivelFormacao?.nome ?? '';
	var importaEstadoCivilController = TextEditingController();
	importaEstadoCivilController.text = widget.pessoa?.pessoaFisica?.estadoCivil?.nome ?? '';
	var cpfController = new MaskedTextController(
		mask: Constantes.mascaraCPF,
		text: widget.pessoa?.pessoaFisica?.cpf ?? '',
	);
	
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
				  Row(
				  	children: <Widget>[
				  		Expanded(
				  			flex: 1,
				  			child: Container(
				  				child: TextFormField(
				  					controller: importaNivelFormacaoController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Nível de Formação Vinculado',
				  						'Nível Formação *',
				  						false),
				  					onSaved: (String value) {
				  						widget.pessoa?.pessoaFisica?.nivelFormacao?.nome = value;
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Nível Formação',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Nível Formação',
				  										colunas: NivelFormacao.colunas,
				  										campos: NivelFormacao.campos,
				  										rota: '/nivel-formacao/',
				  										campoPesquisaPadrao: 'nome',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaNivelFormacaoController.text = objetoJsonRetorno['nome'];
				  						widget.pessoa.pessoaFisica?.idNivelFormacao = objetoJsonRetorno['id'];
				  						widget.pessoa.pessoaFisica?.nivelFormacao = new NivelFormacao.fromJson(objetoJsonRetorno);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
				  ),
				  const SizedBox(height: 24.0),
				  Row(
				  	children: <Widget>[
				  		Expanded(
				  			flex: 1,
				  			child: Container(
				  				child: TextFormField(
				  					controller: importaEstadoCivilController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Estado Civil Vinculado',
				  						'Estado Civil *',
				  						false),
				  					onSaved: (String value) {
				  						widget.pessoa?.pessoaFisica?.estadoCivil?.nome = value;
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Estado Civil',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Estado Civil',
				  										colunas: EstadoCivil.colunas,
				  										campos: EstadoCivil.campos,
				  										rota: '/estado-civil/',
				  										campoPesquisaPadrao: 'nome',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaEstadoCivilController.text = objetoJsonRetorno['nome'];
				  						widget.pessoa.pessoaFisica?.idEstadoCivil = objetoJsonRetorno['id'];
				  						widget.pessoa.pessoaFisica?.estadoCivil = new EstadoCivil.fromJson(objetoJsonRetorno);
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
				  	controller: cpfController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o CPF da Pessoa',
				  		'CPF *',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaFisica?.cpf = value;
				  	},
				  	validator: ValidaCampoFormulario.validarObrigatorioCPF,
				  	onChanged: (text) {
				  		widget.pessoa.pessoaFisica?.cpf = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 20,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.pessoaFisica?.rg ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o RG da Pessoa',
				  		'RG',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaFisica?.rg = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 20,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.pessoaFisica?.orgaoRg ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Órgão de Emissão do RG',
				  		'Órgão RG',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaFisica?.orgaoRg = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data de Emissão do RG',
				  		'Data Emissão',
				  		true),
				  	isEmpty: widget.pessoa.pessoaFisica?.dataEmissaoRg == null,
				  	child: DatePickerItem(
				  		dateTime: widget.pessoa.pessoaFisica?.dataEmissaoRg,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
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
				  		'Informe a Data de Nascimento da Pessoa',
				  		'Data Nascimento',
				  		true),
				  	isEmpty: widget.pessoa.pessoaFisica?.dataNascimento == null,
				  	child: DatePickerItem(
				  		dateTime: widget.pessoa.pessoaFisica?.dataNascimento,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
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
				  		'Informe o Sexo da Pessoa',
				  		'Sexo',
				  		true),
				  	isEmpty: widget.pessoa?.pessoaFisica?.sexo == null ||
				  		widget.pessoa?.pessoaFisica == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.pessoaFisica?.sexo,
				  		(String newValue) {
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
				  		'Informe a Raça da Pessoa',
				  		'Raça',
				  		true),
				  	isEmpty: widget.pessoa?.pessoaFisica?.raca == null ||
				  		widget.pessoa?.pessoaFisica == null,
				  	child: ViewUtilLib.getDropDownButton(widget.pessoa.pessoaFisica?.raca,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.pessoa.pessoaFisica?.raca = newValue;
				  	});
				  	}, <String>[
				  		'Branco',
				  		'Moreno',
				  		'Negro',
				  		'Pardo',
				  		'Amarelo',
				  		'Indígena',
				  		'Outro',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.pessoaFisica?.nacionalidade ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Nacionalidade da Pessoa',
				  		'Nacionalidade',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaFisica?.nacionalidade = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.pessoaFisica?.naturalidade ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Naturalidade da Pessoa',
				  		'Naturalidade',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaFisica?.naturalidade = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 200,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.pessoaFisica?.nomePai ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome do Pai da Pessoa',
				  		'Nome Pai',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaFisica?.nomePai = value;
				  	},
				  	onChanged: (text) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 200,
				  	maxLines: 1,
				  	initialValue: widget.pessoa?.pessoaFisica?.nomeMae ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome da Mãe da Pessoa',
				  		'Nome Mãe',
				  		false),
				  	onSaved: (String value) {
				  		widget.pessoa.pessoaFisica?.nomeMae = value;
				  	},
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