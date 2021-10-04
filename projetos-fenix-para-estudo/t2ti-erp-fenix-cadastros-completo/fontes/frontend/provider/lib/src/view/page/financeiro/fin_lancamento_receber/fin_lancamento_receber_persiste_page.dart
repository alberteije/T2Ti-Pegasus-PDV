/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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

class FinLancamentoReceberPersistePage extends StatefulWidget {
  final FinLancamentoReceber finLancamentoReceber;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function atualizaFinLancamentoReceberCallBack;

  const FinLancamentoReceberPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.finLancamentoReceber, this.atualizaFinLancamentoReceberCallBack})
      : super(key: key);

  @override
  FinLancamentoReceberPersistePageState createState() => FinLancamentoReceberPersistePageState();
}

class FinLancamentoReceberPersistePageState extends State<FinLancamentoReceberPersistePage> {
  @override
  Widget build(BuildContext context) {
	var importaFinDocumentoOrigemController = TextEditingController();
	importaFinDocumentoOrigemController.text = widget.finLancamentoReceber?.finDocumentoOrigem?.sigla ?? '';
	var importaFinNaturezaFinanceiraController = TextEditingController();
	importaFinNaturezaFinanceiraController.text = widget.finLancamentoReceber?.finNaturezaFinanceira?.descricao ?? '';
	var importaClienteController = TextEditingController();
	importaClienteController.text = widget.finLancamentoReceber?.cliente?.pessoa?.nome ?? '';
	var valorTotalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.finLancamentoReceber?.valorTotal ?? 0);
	var valorAReceberController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.finLancamentoReceber?.valorAReceber ?? 0);
	var taxaComissaoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.finLancamentoReceber?.taxaComissao ?? 0);
	var valorComissaoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.finLancamentoReceber?.valorComissao ?? 0);

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
				  					controller: importaFinDocumentoOrigemController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Documento de Origem Vinculado',
				  						'Documento de Origem *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.finLancamentoReceber?.finDocumentoOrigem?.sigla = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Documento de Origem',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Documento de Origem',
				  										colunas: FinDocumentoOrigem.colunas,
				  										campos: FinDocumentoOrigem.campos,
				  										rota: '/fin-documento-origem/',
				  										campoPesquisaPadrao: 'sigla',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['sigla'] != null) {
				  						importaFinDocumentoOrigemController.text = objetoJsonRetorno['sigla'];
				  						widget.finLancamentoReceber.idFinDocumentoOrigem = objetoJsonRetorno['id'];
				  						widget.finLancamentoReceber.finDocumentoOrigem = new FinDocumentoOrigem.fromJson(objetoJsonRetorno);
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
				  					controller: importaFinNaturezaFinanceiraController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe a Natureza Financeira Vinculada',
				  						'Natureza Financeira *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.finLancamentoReceber?.finNaturezaFinanceira?.descricao = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Natureza Financeira',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Natureza Financeira',
				  										colunas: FinNaturezaFinanceira.colunas,
				  										campos: FinNaturezaFinanceira.campos,
				  										rota: '/fin-natureza-financeira/',
				  										campoPesquisaPadrao: 'descricao',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['descricao'] != null) {
				  						importaFinNaturezaFinanceiraController.text = objetoJsonRetorno['descricao'];
				  						widget.finLancamentoReceber.idFinNaturezaFinanceira = objetoJsonRetorno['id'];
				  						widget.finLancamentoReceber.finNaturezaFinanceira = new FinNaturezaFinanceira.fromJson(objetoJsonRetorno);
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
				  					controller: importaClienteController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Cliente Vinculado',
				  						'Cliente *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.finLancamentoReceber?.cliente?.pessoa?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Cliente',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Cliente',
				  										colunas: Cliente.colunas,
				  										campos: Cliente.campos,
				  										rota: '/cliente/',
				  										campoPesquisaPadrao: 'pessoa?.nome',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['pessoa?.nome'] != null) {
				  						importaClienteController.text = objetoJsonRetorno['pessoa?.nome'];
				  						widget.finLancamentoReceber.idCliente = objetoJsonRetorno['id'];
				  						widget.finLancamentoReceber.cliente = new Cliente.fromJson(objetoJsonRetorno);
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
				  	maxLength: 11,
				  	maxLines: 1,
				  	initialValue: widget.finLancamentoReceber?.quantidadeParcela?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Quantidade de Parcelas',
				  		'Quantidade de Parcelas',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finLancamentoReceber.quantidadeParcela = int.tryParse(text);
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorTotalController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Total',
				  		'Valor Total',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finLancamentoReceber.valorTotal = valorTotalController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorAReceberController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor a Receber',
				  		'Valor a Receber',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finLancamentoReceber.valorAReceber = valorAReceberController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data de Lançamento',
				  		'Data de Lançamento',
				  		true),
				  	isEmpty: widget.finLancamentoReceber.dataLancamento == null,
				  	child: DatePickerItem(
				  		dateTime: widget.finLancamentoReceber.dataLancamento,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.finLancamentoReceber.dataLancamento = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 50,
				  	maxLines: 1,
				  	initialValue: widget.finLancamentoReceber?.numeroDocumento ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Número do Documento',
				  		'Número do Documento',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finLancamentoReceber.numeroDocumento = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data do Primeiro Vencimento',
				  		'Data do Primeiro Vencimento',
				  		true),
				  	isEmpty: widget.finLancamentoReceber.primeiroVencimento == null,
				  	child: DatePickerItem(
				  		dateTime: widget.finLancamentoReceber.primeiroVencimento,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.parse('2100-01-01'),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.finLancamentoReceber.primeiroVencimento = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: taxaComissaoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Taxa de Comissão',
				  		'Taxa de Comissão',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finLancamentoReceber.taxaComissao = taxaComissaoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorComissaoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor da Comissão',
				  		'Valor Comissão',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finLancamentoReceber.valorComissao = valorComissaoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 11,
				  	maxLines: 1,
				  	initialValue: widget.finLancamentoReceber?.intervaloEntreParcelas?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Intervalo Entre Parcelas (Dias)',
				  		'Intervalo Entre Parcelas',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finLancamentoReceber.intervaloEntreParcelas = int.tryParse(text);
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 2,
				  	maxLines: 1,
				  	initialValue: widget.finLancamentoReceber?.diaFixo ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Dia Fixo para o Recebimento',
				  		'Dia Fixo',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.finLancamentoReceber.diaFixo = text;
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
