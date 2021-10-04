/*
Title: T2Ti ERP Fenix                                                                
Description: PersistePage relacionada à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
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

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

class FinConfiguracaoBoletoPersistePage extends StatefulWidget {
  final FinConfiguracaoBoleto finConfiguracaoBoleto;
  final String title;
  final String operacao;

  const FinConfiguracaoBoletoPersistePage({Key key, this.finConfiguracaoBoleto, this.title, this.operacao})
      : super(key: key);

  @override
  FinConfiguracaoBoletoPersistePageState createState() => FinConfiguracaoBoletoPersistePageState();
}

class FinConfiguracaoBoletoPersistePageState extends State<FinConfiguracaoBoletoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var finConfiguracaoBoletoProvider = Provider.of<FinConfiguracaoBoletoViewModel>(context);
	
	var taxaMultaController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.finConfiguracaoBoleto?.taxaMulta ?? 0);
	var taxaJuroController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.finConfiguracaoBoleto?.taxaJuro ?? 0);
	
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
                  await finConfiguracaoBoletoProvider.alterar(widget.finConfiguracaoBoleto);
                } else {
                  await finConfiguracaoBoletoProvider.inserir(widget.finConfiguracaoBoleto);
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
				  TextFormField(
				  	maxLength: 11,
				  	maxLines: 1,
				  	initialValue: widget.finConfiguracaoBoleto?.idBancoContaCaixa?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Importe a Conta Caixa Vinculada',
				  		'Conta Caixa *',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.idBancoContaCaixa = int.tryParse(text);
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.finConfiguracaoBoleto?.instrucao01 ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Instrução 01 do Boleto',
				  		'Instrução 01',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.instrucao01 = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.finConfiguracaoBoleto?.instrucao02 ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Instrução 02 do Boleto',
				  		'Instrução 02',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.instrucao02 = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 250,
				  	maxLines: 3,
				  	initialValue: widget.finConfiguracaoBoleto?.caminhoArquivoRemessa ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Caminho Arquivo Remessa',
				  		'Caminho Arquivo Remessa',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.caminhoArquivoRemessa = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 250,
				  	maxLines: 3,
				  	initialValue: widget.finConfiguracaoBoleto?.caminhoArquivoRetorno ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Caminho Arquivo Retorno',
				  		'Caminho Arquivo Retorno',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.caminhoArquivoRetorno = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 250,
				  	maxLines: 3,
				  	initialValue: widget.finConfiguracaoBoleto?.caminhoArquivoLogotipo ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Caminho Arquivo Logotipo',
				  		'Caminho Arquivo Logotipo',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.caminhoArquivoLogotipo = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 250,
				  	maxLines: 3,
				  	initialValue: widget.finConfiguracaoBoleto?.caminhoArquivoPdf ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Caminho Arquivo PDF',
				  		'Caminho Arquivo PDF',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.caminhoArquivoPdf = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 250,
				  	maxLines: 3,
				  	initialValue: widget.finConfiguracaoBoleto?.mensagem ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Mensagem do Boleto',
				  		'Mensagem',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.mensagem = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.finConfiguracaoBoleto?.localPagamento ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Local de Pagamento do Boleto',
				  		'Local Pagamento',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.localPagamento = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Layout de Remessa do Boleto',
				  		'Layout Remessa',
				  		true),
				  	isEmpty: widget.finConfiguracaoBoleto.layoutRemessa == null,
				  	child: ViewUtilLib.getDropDownButton(widget.finConfiguracaoBoleto.layoutRemessa,
				  		(String newValue) {
				  	setState(() {
				  		widget.finConfiguracaoBoleto.layoutRemessa = newValue;
				  	});
				  	}, <String>[
				  		'CNAB 240',
				  		'CNAB 400',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Aceite',
				  		true),
				  	isEmpty: widget.finConfiguracaoBoleto.aceite == null,
				  	child: ViewUtilLib.getDropDownButton(widget.finConfiguracaoBoleto.aceite,
				  		(String newValue) {
				  	setState(() {
				  		widget.finConfiguracaoBoleto.aceite = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Espécie do Boleto',
				  		'Espécie',
				  		true),
				  	isEmpty: widget.finConfiguracaoBoleto.especie == null,
				  	child: ViewUtilLib.getDropDownButton(widget.finConfiguracaoBoleto.especie,
				  		(String newValue) {
				  	setState(() {
				  		widget.finConfiguracaoBoleto.especie = newValue;
				  	});
				  	}, <String>[
				  		'DM-Duplicata Mercantil',
				  		'DS-Duplicata de Serviços',
				  		'RC-Recibo',
				  		'NP-Nota Promissória',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 3,
				  	maxLines: 1,
				  	initialValue: widget.finConfiguracaoBoleto?.carteira ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Carteira do Boleto',
				  		'Carteira',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.carteira = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 20,
				  	maxLines: 1,
				  	initialValue: widget.finConfiguracaoBoleto?.codigoConvenio ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Código de Convênio do Boleto',
				  		'Código Convênio',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.codigoConvenio = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 20,
				  	maxLines: 1,
				  	initialValue: widget.finConfiguracaoBoleto?.codigoCedente ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Código de Cedente do Boleto',
				  		'Código Cedente',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.codigoCedente = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: taxaMultaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Taxa de Multa',
				  		'Taxa Multa',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.taxaMulta = taxaMultaController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: taxaJuroController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Taxa de Juros',
				  		'Taxa Juros',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.taxaJuro = taxaJuroController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 11,
				  	maxLines: 1,
				  	initialValue: widget.finConfiguracaoBoleto?.diasProtesto?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Quantidade de Dias para Protesto',
				  		'Dias Protesto',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.diasProtesto = int.tryParse(text);
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 50,
				  	maxLines: 1,
				  	initialValue: widget.finConfiguracaoBoleto?.nossoNumeroAnterior ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nosso Número Anterior',
				  		'Nosso Número Anterior',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finConfiguracaoBoleto.nossoNumeroAnterior = text;
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