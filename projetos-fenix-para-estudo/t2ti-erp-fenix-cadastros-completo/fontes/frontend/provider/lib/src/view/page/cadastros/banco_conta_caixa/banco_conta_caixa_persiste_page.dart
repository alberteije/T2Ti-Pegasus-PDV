/*
Title: T2Ti ERP Fenix                                                                
Description: PersistePage relacionada à tabela [BANCO_CONTA_CAIXA] 
                                                                                
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
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'package:fenix/src/view/shared/lookup_page.dart';

class BancoContaCaixaPersistePage extends StatefulWidget {
  final BancoContaCaixa bancoContaCaixa;
  final String title;
  final String operacao;

  const BancoContaCaixaPersistePage({Key key, this.bancoContaCaixa, this.title, this.operacao})
      : super(key: key);

  @override
  BancoContaCaixaPersistePageState createState() => BancoContaCaixaPersistePageState();
}

class BancoContaCaixaPersistePageState extends State<BancoContaCaixaPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var bancoContaCaixaProvider = Provider.of<BancoContaCaixaViewModel>(context);
	
	var importaBancoAgenciaController = TextEditingController();
	importaBancoAgenciaController.text = widget.bancoContaCaixa?.bancoAgencia?.nome ?? '';
	
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
                  await bancoContaCaixaProvider.alterar(widget.bancoContaCaixa);
                } else {
                  await bancoContaCaixaProvider.inserir(widget.bancoContaCaixa);
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
				  					controller: importaBancoAgenciaController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe a Agência Vinculada',
				  						'Agência *',
				  						false),
				  					onSaved: (String value) {
				  						widget.bancoContaCaixa?.bancoAgencia?.nome = value;
				  					},
				  					onChanged: (text) {
				  						_formFoiAlterado = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Agência',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Agência',
				  										colunas: BancoAgencia.colunas,
				  										campos: BancoAgencia.campos,
				  										rota: '/banco-agencia/',
				  										campoPesquisaPadrao: 'nome',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaBancoAgenciaController.text = objetoJsonRetorno['nome'];
				  						widget.bancoContaCaixa.idBancoAgencia = objetoJsonRetorno['id'];
				  						widget.bancoContaCaixa.bancoAgencia = new BancoAgencia.fromJson(objetoJsonRetorno);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 20,
				  	maxLines: 1,
				  	initialValue: widget.bancoContaCaixa?.numero ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Número da Conta',
				  		'Número',
				  		false),
				  	onSaved: (String value) {
				  		widget.bancoContaCaixa.numero = value;
				  	},
				  	onChanged: (text) {
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 1,
				  	maxLines: 1,
				  	initialValue: widget.bancoContaCaixa?.digito ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Dígito da Conta',
				  		'Dígito',
				  		false),
				  	onSaved: (String value) {
				  		widget.bancoContaCaixa.digito = value;
				  	},
				  	onChanged: (text) {
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.bancoContaCaixa?.nome ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome da Conta',
				  		'Nome',
				  		false),
				  	onSaved: (String value) {
				  		widget.bancoContaCaixa.nome = value;
				  	},
				  	onChanged: (text) {
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione o Tipo da Conta',
				  		'Tipo',
				  		true),
				  	isEmpty: widget.bancoContaCaixa.tipo == null,
				  	child: ViewUtilLib.getDropDownButton(widget.bancoContaCaixa.tipo,
				  		(String newValue) {
				  	setState(() {
				  		widget.bancoContaCaixa.tipo = newValue;
				  	});
				  	}, <String>[
				  		'Corrente',
				  		'Poupança',
				  		'Investimento',
				  		'Caixa Interno',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 250,
				  	maxLines: 3,
				  	initialValue: widget.bancoContaCaixa?.descricao ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Descrição da Conta/Caixa',
				  		'Descrição',
				  		false),
				  	onSaved: (String value) {
				  		widget.bancoContaCaixa.descricao = value;
				  	},
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