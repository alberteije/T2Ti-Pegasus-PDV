/*
Title: T2Ti ERP 3.0                                                                
Description: AbaDetalhe PersistePage relacionada à tabela [PRODUTO_FICHA_TECNICA] 
                                                                                
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

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_abas.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';


class ProdutoFichaTecnicaPersistePage extends StatefulWidget {
  final Produto? produto;
  final ProdutoFichaTecnica? produtoFichaTecnica;
  final String? title;
  final String? operacao;

  const ProdutoFichaTecnicaPersistePage(
      {Key? key, this.produto, this.produtoFichaTecnica, this.title, this.operacao})
      : super(key: key);

  @override
  _ProdutoFichaTecnicaPersistePageState createState() => _ProdutoFichaTecnicaPersistePageState();
}

class _ProdutoFichaTecnicaPersistePageState extends State<ProdutoFichaTecnicaPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;

  ProdutoFichaTecnica? produtoFichaTecnica;

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

    produtoFichaTecnica = widget.produtoFichaTecnica;
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.salvar:
        _salvar();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final _quantidadeController = MoneyMaskedTextController(precision: Constantes.decimaisQuantidade, initialValue: widget.produtoFichaTecnica?.quantidade ?? 0);
    // final _valorCustoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.produtoFichaTecnica?.valorCusto ?? 0);
    // final _percentualCustoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.produtoFichaTecnica?.percentualCusto ?? 0);
    final _importaProdutoController = TextEditingController();
    _importaProdutoController.text = produtoFichaTecnica?.descricao ?? '';

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title!), 
            actions: widget.operacao == 'I'
              ? getBotoesAppBarPersistePage(context: context, salvar: _salvar)
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
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
                      children: <Widget>[		
                        const Divider(color: Colors.black,),
                        Text('Produto Pai: ' + (widget.produto?.nome ?? ''),
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.blue, fontStyle: FontStyle.italic),
                        ),
                        const Divider(color: Colors.black,),
                        BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      child: TextFormField(
                                        validator: ValidaCampoFormulario.validarObrigatorio,
                                        controller: _importaProdutoController,
                                        readOnly: true,
                                        decoration: getInputDecoration(
                                          'Conteúdo para o campo Produto',
                                          'Produto/Insumo *',
                                          false),
                                        onSaved: (String? value) {
                                        },
                                        onChanged: (text) {
                                          paginaMestreDetalheFoiAlterada = true;
                                          _formFoiAlterado = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: IconButton(
                                      tooltip: 'Importar Produto',
                                      icon: ViewUtilLib.getIconBotaoLookup(),
                                      onPressed: () async {
                                        ///chamando o lookup
                                        Map<String, dynamic>? _objetoJsonRetorno =
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                LookupLocalPage(
                                                  title: 'Importar Produto',
                                                  colunas: ProdutoDao.colunas,
                                                  campos: ProdutoDao.campos,
                                                  campoPesquisaPadrao: 'nome',
                                                  valorPesquisaPadrao: '%',
                                                  metodoConsultaCallBack: _filtrarProdutoLookup,
                                                  permiteCadastro: true,
                                                  metodoCadastroCallBack: () { Navigator.pushNamed(context, '/produtoLista',); },
                                                ),
                                                fullscreenDialog: true,
                                              ));
                                        if (_objetoJsonRetorno != null) {
                                          if (_objetoJsonRetorno['nome'] != null) {
                                            _importaProdutoController.text = _objetoJsonRetorno['nome'];
                                           produtoFichaTecnica = produtoFichaTecnica!.copyWith
                                                                (
                                                                  idProduto: widget.produto!.id,
                                                                  idProdutoFilho: _objetoJsonRetorno['id'],
                                                                  descricao: _objetoJsonRetorno['nome'],
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
                        const Divider(color: Colors.white,),
                        BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                controller: _quantidadeController,
                                decoration: getInputDecoration(
                                  'Informe a Quantidade',
                                  'Quantidade',
                                  false),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  produtoFichaTecnica = produtoFichaTecnica!.copyWith(quantidade: _quantidadeController.numberValue);
                                  paginaMestreDetalheFoiAlterada = true;
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ],
                        ),
                        // const Divider(color: Colors.white,),
                        // BootstrapRow(
                        //   height: 60,
                        //   children: <BootstrapCol>[
                        //     BootstrapCol(
                        //       sizes: 'col-12',
                        //       child: TextFormField(
                        //         keyboardType: TextInputType.number,
                        //         textAlign: TextAlign.end,
                        //         controller: _valorCustoController,
                        //         decoration: getInputDecoration(
                        //           'Informe o Valor Custo',
                        //           'Valor Custo',
                        //           false),
                        //         onSaved: (String? value) {
                        //         },
                        //         onChanged: (text) {
                        //           produtoFichaTecnica = produtoFichaTecnica!.copyWith(valorCusto: _valorCustoController.numberValue);
                        //           paginaMestreDetalheFoiAlterada = true;
                        //           _formFoiAlterado = true;
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(color: Colors.white,),
                        // BootstrapRow(
                        //   height: 60,
                        //   children: <BootstrapCol>[
                        //     BootstrapCol(
                        //       sizes: 'col-12',
                        //       child: TextFormField(
                        //         keyboardType: TextInputType.number,
                        //         textAlign: TextAlign.end,
                        //         controller: _percentualCustoController,
                        //         decoration: getInputDecoration(
                        //           'Informe o Percentual Custo',
                        //           'Percentual Custo',
                        //           false),
                        //         onSaved: (String? value) {
                        //         },
                        //         onChanged: (text) {
                        //           produtoFichaTecnica = produtoFichaTecnica!.copyWith(percentualCusto: _percentualCustoController.numberValue);
                        //           paginaMestreDetalheFoiAlterada = true;
                        //           _formFoiAlterado = true;
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const Divider(color: Colors.white,),
                        BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: 
                                Text('* indica que o campo é obrigatório',
                                style: Theme.of(context).textTheme.caption,
                              ),								
                            ),
                          ],
                        ),
                        const Divider(color: Colors.white,),
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

  void _filtrarProdutoLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.produtoDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  Future<void> _salvar() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
    } else {
      form.save();
      Navigator.of(context).pop(produtoFichaTecnica);
    }
  }
  
  void _excluir() {
    gerarDialogBoxExclusao(context, () {
      ProdutoController.listaProdutoFichaTecnica.remove(widget.produtoFichaTecnica);
      Navigator.of(context).pop();
    });
  }
  
  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState? form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) {
      return true;
    } else {
      await (gerarDialogBoxFormAlterado(context));
      return false;
    }
  }
}