/*
Title: T2Ti ERP Fenix                                                                
Description: PersistePage relacionada à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

class FinFechamentoCaixaBancoPersistePage extends StatefulWidget {
  final FinFechamentoCaixaBanco finFechamentoCaixaBanco;
  final String title;
  final String operacao;

  const FinFechamentoCaixaBancoPersistePage({Key key, this.finFechamentoCaixaBanco, this.title, this.operacao})
      : super(key: key);

  @override
  FinFechamentoCaixaBancoPersistePageState createState() => FinFechamentoCaixaBancoPersistePageState();
}

class FinFechamentoCaixaBancoPersistePageState extends State<FinFechamentoCaixaBancoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var finFechamentoCaixaBancoProvider = Provider.of<FinFechamentoCaixaBancoViewModel>(context);
	
	var importaBancoContaCaixaController = TextEditingController();
	importaBancoContaCaixaController.text = widget.finFechamentoCaixaBanco?.bancoContaCaixa?.nome ?? '';
	var mesAnoController = new MaskedTextController(
		mask: Constantes.mascaraMES_ANO,
		text: widget.finFechamentoCaixaBanco?.mesAno ?? '',
	);
	var saldoAnteriorController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.finFechamentoCaixaBanco?.saldoAnterior ?? 0);
	var recebimentosController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.finFechamentoCaixaBanco?.recebimentos ?? 0);
	var pagamentosController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.finFechamentoCaixaBanco?.pagamentos ?? 0);
	var saldoContaController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.finFechamentoCaixaBanco?.saldoConta ?? 0);
	var chequeNaoCompensadoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.finFechamentoCaixaBanco?.chequeNaoCompensado ?? 0);
	var saldoDisponivelController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.finFechamentoCaixaBanco?.saldoDisponivel ?? 0);
	
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
                  await finFechamentoCaixaBancoProvider.alterar(widget.finFechamentoCaixaBanco);
                } else {
                  await finFechamentoCaixaBancoProvider.inserir(widget.finFechamentoCaixaBanco);
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
				  					controller: importaBancoContaCaixaController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe a Conta Caixa Vinculada',
				  						'Conta Caixa *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.finFechamentoCaixaBanco?.bancoContaCaixa?.nome = text;
				  						_formFoiAlterado = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Conta Caixa',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Conta Caixa',
				  										colunas: BancoContaCaixa.colunas,
				  										campos: BancoContaCaixa.campos,
				  										rota: '/banco-conta-caixa/',
				  										campoPesquisaPadrao: 'nome',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaBancoContaCaixaController.text = objetoJsonRetorno['nome'];
				  						widget.finFechamentoCaixaBanco.idBancoContaCaixa = objetoJsonRetorno['id'];
				  						widget.finFechamentoCaixaBanco.bancoContaCaixa = new BancoContaCaixa.fromJson(objetoJsonRetorno);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data do Fechamento',
				  		'Data do Fechamento',
				  		true),
				  	isEmpty: widget.finFechamentoCaixaBanco.dataFechamento == null,
				  	child: DatePickerItem(
				  		dateTime: widget.finFechamentoCaixaBanco.dataFechamento,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			setState(() {
				  				widget.finFechamentoCaixaBanco.dataFechamento = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: mesAnoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Mês/Ano',
				  		'Mês/Ano *',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finFechamentoCaixaBanco.mesAno = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 2,
				  	maxLines: 1,
				  	initialValue: widget.finFechamentoCaixaBanco?.mes ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Mês',
				  		'Mês *',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finFechamentoCaixaBanco.mes = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 4,
				  	maxLines: 1,
				  	initialValue: widget.finFechamentoCaixaBanco?.ano ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Ano',
				  		'Ano *',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finFechamentoCaixaBanco.ano = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: saldoAnteriorController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor do Saldo Anterior',
				  		'Valor Saldo Anterior',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finFechamentoCaixaBanco.saldoAnterior = saldoAnteriorController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: recebimentosController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Total de Recebimentos',
				  		'Total Recebimentos',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finFechamentoCaixaBanco.recebimentos = recebimentosController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: pagamentosController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Total de Pagamentos',
				  		'Total Pagamentos',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finFechamentoCaixaBanco.pagamentos = pagamentosController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: saldoContaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor do Saldo em Conta',
				  		'Saldo em Conta',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finFechamentoCaixaBanco.saldoConta = saldoContaController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: chequeNaoCompensadoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Total de Cheques Não Compensados',
				  		'Cheques Não Compensados',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finFechamentoCaixaBanco.chequeNaoCompensado = chequeNaoCompensadoController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: saldoDisponivelController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valo do Saldo Disponível',
				  		'Saldo Disponível',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finFechamentoCaixaBanco.saldoDisponivel = saldoDisponivelController.numberValue;
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