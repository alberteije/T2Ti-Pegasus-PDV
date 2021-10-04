/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [CONTAS_RECEBER] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';

class ContasReceberPersistePage extends StatefulWidget {
  final ContasReceberMontado contasReceberMontado;
  final String title;
  final String operacao;

  const ContasReceberPersistePage({Key key, this.contasReceberMontado, this.title, this.operacao})
      : super(key: key);

  @override
  _ContasReceberPersistePageState createState() => _ContasReceberPersistePageState();
}

class _ContasReceberPersistePageState extends State<ContasReceberPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  ContasReceber _contasReceber;

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );

    _shortcutMap = getAtalhosPersistePage();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    _contasReceber = widget.contasReceberMontado.contasReceber;
    if (_contasReceber == null) {
      _contasReceber = ContasReceber(id: null,);
    }
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.excluir:
        _excluir();
        break;
      case AtalhoTelaType.salvar:
        _salvar();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _taxaJuroController = MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: _contasReceber?.taxaJuro ?? 0);
    final _importaClienteController = TextEditingController();
    _importaClienteController.text = widget.contasReceberMontado.cliente?.nome ?? '';
    final _taxaMultaController = MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: _contasReceber?.taxaMulta ?? 0);
    final _taxaDescontoController = MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: _contasReceber?.taxaDesconto ?? 0);
    final _valorJuroController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _contasReceber?.valorJuro ?? 0);
    final _valorMultaController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _contasReceber?.valorMulta ?? 0);
    final _valorDescontoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _contasReceber?.valorDesconto ?? 0);
    final _valorRecebidoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _contasReceber?.valorRecebido ?? 0);
    final _valorAReceberController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _contasReceber?.valorAReceber ?? 0);
	
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title), 
            actions: widget.operacao == 'I' 
              ? getBotoesAppBarPersistePage(context: context, salvar: _salvar,)
              : getBotoesAppBarPersistePageComExclusao(context: context, salvar: _salvar, excluir: _excluir),
          ),      
          body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              onWillPop: _avisarUsuarioFormAlterado,
              child: Scrollbar(
                child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  child: BootstrapContainer(
                    fluid: true,
                    decoration: BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
                    children: [
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextFormField(
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      controller: _importaClienteController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Conteúdo para o campo Cliente',
                                        'Cliente *',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      onChanged: (text) {
                                        // _contasReceber?.cliente?.nome = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Cliente',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                            LookupLocalPage(
                                              title: 'Importar Cliente',
                                              colunas: ClienteDao.colunas,
                                              campos: ClienteDao.campos,
                                              campoPesquisaPadrao: 'Nome',
                                              valorPesquisaPadrao: '%',
                                              metodoConsultaCallBack: _filtrarClienteLookup,                                             
                                              permiteCadastro: true,
                                              metodoCadastroCallBack: () { Navigator.pushNamed(context, '/clienteLista',); },
                                            ),
                                            fullscreenDialog: true,
                                          ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['nome'] != null) {
                                          _importaClienteController.text = _objetoJsonRetorno['nome'];
                                          _contasReceber = _contasReceber.copyWith(idCliente: _objetoJsonRetorno['id']);
                                          widget.contasReceberMontado.cliente = widget.contasReceberMontado.cliente.copyWith(
                                            nome: _objetoJsonRetorno['nome'],
                                          );          
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: InputDecorator(                              
                                decoration: getInputDecoration(
                                  '',
                                  'Data Lançamento',
                                  true),
                                isEmpty: _contasReceber.dataLancamento == null,
                                child: DatePickerItem(
                                  mascara: 'dd/MM/yyyy',
                                  dateTime: _contasReceber.dataLancamento,
                                  firstDate: DateTime.parse('1900-01-01'),
                                  lastDate: DateTime.now(),
                                  onChanged: (DateTime value) {
                                    setState(() {
                                      _contasReceber = _contasReceber.copyWith(dataLancamento: value);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: InputDecorator(                              
                                decoration: getInputDecoration(
                                  '',
                                  'Data Vencimento',
                                  true),
                                isEmpty: _contasReceber.dataVencimento == null,
                                child: DatePickerItem(
                                  mascara: 'dd/MM/yyyy',
                                  dateTime:  _contasReceber.dataVencimento,
                                  firstDate: DateTime.parse('1900-01-01'),
                                  lastDate: DateTime.parse('2050-01-01'),
                                  onChanged: (DateTime value) {
                                    setState(() {
                                      _contasReceber = _contasReceber.copyWith(dataVencimento: value);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: InputDecorator(                              
                                decoration: getInputDecoration(
                                  '',
                                  'Data Recebimento',
                                  true,
                                  ),
                                isEmpty: _contasReceber.dataRecebimento == null,
                                child: DatePickerItem(                                  
                                  mascara: 'dd/MM/yyyy',
                                  dateTime: _contasReceber.dataRecebimento,
                                  firstDate: DateTime.parse('1900-01-01'),
                                  lastDate: DateTime.parse('2050-01-01'),
                                  onChanged: (DateTime value) {
                                    _contasReceber = _contasReceber.copyWith(dataRecebimento: value);
                                    _atualizarTotais();
                                  },
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: TextFormField(
                              maxLength: 50,
                              maxLines: 1,
                              initialValue: _contasReceber?.numeroDocumento ?? '',
                              decoration: getInputDecoration(
                                '',
                                'Número do Documento',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                _contasReceber = _contasReceber.copyWith(numeroDocumento: text);
                                _formFoiAlterado = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: TextFormField(
                              maxLength: 1000,
                              maxLines: 3,
                              initialValue: _contasReceber?.historico ?? '',
                              decoration: getInputDecoration(
                                '',
                                'Histórico',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                _contasReceber = _contasReceber.copyWith(historico: text);
                                _formFoiAlterado = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                controller: _valorAReceberController,
                                decoration: getInputDecoration(
                                  '',
                                  'Valor a Receber',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  _contasReceber = _contasReceber.copyWith(valorAReceber: _valorAReceberController.numberValue);
                                  _formFoiAlterado = true;
                                  _atualizarTotais();
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                controller: _taxaDescontoController,
                                decoration: getInputDecoration(
                                  '',
                                  'Taxa Desconto',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  if (_taxaDescontoController.numberValue >= 100) {
                                    _taxaDescontoController.updateValue(99.9);
                                  }
                                  _contasReceber = _contasReceber.copyWith(taxaDesconto: _taxaDescontoController.numberValue);
                                  _formFoiAlterado = true;
                                  _atualizarTotais();
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                textAlign: TextAlign.end,
                                controller: _valorDescontoController,
                                decoration: getInputDecoration(
                                  '',
                                  'Valor Desconto',
                                  false,
                                  cor: ViewUtilLib.getTextFieldReadOnlyColor()),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  _contasReceber = _contasReceber.copyWith(valorDesconto: _valorDescontoController.numberValue);
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-3',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                controller: _taxaJuroController,
                                decoration: getInputDecoration(
                                  '',
                                  'Taxa Juros',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  _contasReceber = _contasReceber.copyWith(taxaJuro: _taxaJuroController.numberValue);
                                  _formFoiAlterado = true;
                                  _atualizarTotais();
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-3',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                textAlign: TextAlign.end,
                                controller: _valorJuroController,
                                decoration: getInputDecoration(
                                  '',
                                  'Valor Juros',
                                  false,
                                  cor: ViewUtilLib.getTextFieldReadOnlyColor()),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  _contasReceber = _contasReceber.copyWith(valorJuro: _valorJuroController.numberValue);
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-3',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                controller: _taxaMultaController,
                                decoration: getInputDecoration(
                                  '',
                                  'Taxa Multa',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  _contasReceber = _contasReceber.copyWith(taxaMulta: _taxaMultaController.numberValue);
                                  _formFoiAlterado = true;
                                  _atualizarTotais();
                                },
                              ),                            
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-3',
                            child: Padding(                              
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                textAlign: TextAlign.end,
                                controller: _valorMultaController,
                                decoration: getInputDecoration(
                                  '',
                                  'Valor Multa',
                                  false,
                                  cor: ViewUtilLib.getTextFieldReadOnlyColor()),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  _contasReceber = _contasReceber.copyWith(valorMulta: _valorMultaController.numberValue);
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: TextFormField(
                              enableInteractiveSelection: !Biblioteca.isDesktop(),
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              textAlign: TextAlign.end,
                              controller: _valorRecebidoController,
                              decoration: getInputDecoration(
                                '',
                                'Valor Recebido',
                                false,
                                cor: ViewUtilLib.getTextFieldReadOnlyColor()),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                _contasReceber = _contasReceber.copyWith(valorRecebido: _valorRecebidoController.numberValue);
                                _formFoiAlterado = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: 
                              Text(
                                '* indica que o campo é obrigatório',
                                style: Theme.of(context).textTheme.caption,
                              ),								
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,),
                    ],
                  ),
                ),
              ),			  
            ),
          ),
        ),
      ),
    );
  }

  void _filtrarClienteLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.clienteDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  Future<void> _salvar() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
    } else {
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        _contasReceber = _contasReceber.copyWith(statusRecebimento: 'A');
        form.save();
        if (_contasReceber.dataRecebimento != null) {
          _contasReceber = _contasReceber.copyWith(statusRecebimento: 'R');
        }
        if (widget.operacao == 'A') {
          Sessao.db.contasReceberDao.alterar(_contasReceber);
        } else {
          Sessao.db.contasReceberDao.inserir(_contasReceber);
       }
        // Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    }
  }

  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) return true;

    return await gerarDialogBoxFormAlterado(context);
  }

  void _excluir() {
    gerarDialogBoxExclusao(context, () async {
      await Sessao.db.contasReceberDao.excluir(_contasReceber);
      Navigator.of(context).pop();
    });
  }  

  _atualizarTotais() {
    double valorDesconto = Biblioteca.calcularDesconto(_contasReceber.valorAReceber, _contasReceber.taxaDesconto);
    double valorJuros = Biblioteca.calcularJuros(_contasReceber.valorAReceber, _contasReceber.taxaJuro, _contasReceber.dataVencimento);
    double valorMulta = Biblioteca.calcularMulta(_contasReceber.valorAReceber, _contasReceber.taxaMulta);
    double valorRecebido = (_contasReceber.valorAReceber ?? 0) + valorJuros + valorMulta - valorDesconto;

    // double subTotal = Biblioteca.multiplicarMonetario(widget.compraDetalhe.compraPedidoDetalhe.quantidade, widget.compraDetalhe.compraPedidoDetalhe.valorUnitario);
    setState(() {
      _contasReceber = 
        _contasReceber.copyWith(
          valorJuro: valorJuros,
          valorMulta: valorMulta,
          valorDesconto: valorDesconto,
          valorRecebido: valorRecebido,
        );       
    });
  }

}