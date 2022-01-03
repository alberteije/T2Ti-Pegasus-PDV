/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre PersistePage OneToOne relacionada à tabela [PESSOA_FISICA] 
                                                                                
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
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_abas.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';


class CardapioPersistePage extends StatefulWidget {
  final ProdutoMontado? produtoMontado;
  final GlobalKey<FormState>? formKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final FocusNode? foco;
  final Function? salvarProdutoCallBack;

  const CardapioPersistePage(
      {Key? key, this.formKey, this.scaffoldKey, this.produtoMontado, this.foco, this.salvarProdutoCallBack})
      : super(key: key);

  @override
  _CardapioPersistePageState createState() => _CardapioPersistePageState();
}

class _CardapioPersistePageState extends State<CardapioPersistePage> {
  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;
  final _foco = FocusNode();

  CardapioPerguntaPadraoMontado? perguntaMontadoSelecionada;
  int idMestre = 0;

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
    _foco.requestFocus();
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.salvar:
        widget.salvarProdutoCallBack!();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _perguntaController = TextEditingController();
    final _respostaController = TextEditingController();

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: widget.scaffoldKey,
          body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: widget.formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Scrollbar(
                child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  padding: ViewUtilLib.paddingAbaPersistePage,
                  child: BootstrapContainer(
                   fluid: true,
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
                    children: <Widget>[
                      const Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: TextFormField(
                              readOnly: true,
                              maxLength: 1000,
                              maxLines: 3,
                              initialValue: widget.produtoMontado!.produto?.descricao ?? 'Cadastre a Descrição no Produto',
                              decoration: getInputDecoration(
                                'Descrição do Produto',
                                'Descrição',
                                false),
                              onSaved: (String? value) {
                              },
                              validator: ValidaCampoFormulario.validarObrigatorio,
                              onChanged: (text) {
                              },
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
                              maxLength: 1000,
                              maxLines: 3,
                              initialValue: widget.produtoMontado!.cardapio?.modoPreparo ?? '',
                              decoration: getInputDecoration(
                                'Informe o Modo Preparo',
                                'Modo Preparo',
                                false),
                              onSaved: (String? value) {
                              },
                              validator: ValidaCampoFormulario.validarObrigatorio,
                              onChanged: (text) {
                                widget.produtoMontado!.cardapio = widget.produtoMontado!.cardapio!.copyWith(modoPreparo: text);
                                paginaMestreDetalheFoiAlterada = true;
                              },
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
                              maxLength: 1000,
                              maxLines: 3,
                              initialValue: widget.produtoMontado!.cardapio?.infoAlergico ?? '',
                              decoration: getInputDecoration(
                                'Informe as Informações Alérgicos',
                                'Informações Alérgicos',
                                false),
                              onSaved: (String? value) {
                              },
                              validator: ValidaCampoFormulario.validarObrigatorio,
                              onChanged: (text) {
                                widget.produtoMontado!.cardapio = widget.produtoMontado!.cardapio!.copyWith(infoAlergico: text);
                                paginaMestreDetalheFoiAlterada = true;
                              },
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
                              maxLength: 1000,
                              maxLines: 3,
                              initialValue: widget.produtoMontado!.cardapio?.ingredientes ?? '',
                              decoration: getInputDecoration(
                                'Informe os Ingredientes',
                                'Ingredientes',
                                false),
                              onSaved: (String? value) {
                              },
                              validator: ValidaCampoFormulario.validarObrigatorio,
                              onChanged: (text) {
                                widget.produtoMontado!.cardapio = widget.produtoMontado!.cardapio!.copyWith(ingredientes: text);
                                paginaMestreDetalheFoiAlterada = true;
                              },
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
                            child: 
                              Text(
                                '* indica que o campo é obrigatório',
                                style: Theme.of(context).textTheme.caption,
                              ),								
                          ),
                        ],
                      ),  
                      const Divider(color: Colors.white,),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
                            child: Text(
                              "Perguntas e Respostas Padrões", 
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          const Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 2,
                          ), 
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _perguntaController,
                                    decoration: getInputDecoration(
                                      'Informe uma pergunta',
                                      'Pergunta',
                                      false),
                                    onSaved: (String? value) {
                                    },
                                    onChanged: (text) {
                                    },
                                    
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Adiciona Pergunta',
                                    icon: const Icon(Icons.add),
                                    onPressed: () {       
                                      if (_perguntaController.text.isEmpty) {
                                        showInSnackBar('Por favor, insira uma pergunta.', context, corFundo: Colors.red);
                                      } else {
                                        ProdutoController.listaCardapioPerguntaPadraoMontado.add(
                                          CardapioPerguntaPadraoMontado(
                                            id: ++idMestre,
                                            cardapioPerguntaPadrao: CardapioPerguntaPadrao(id: null, pergunta: _perguntaController.text),
                                            listaCardapioRespostaPadrao: [],
                                          ),
                                        );
                                        setState(() {
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 170.0,
                            child: Scrollbar(
                              child: ListView(
                                padding: const EdgeInsets.all(2.0),
                                children: <Widget>[
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 2.0,
                                      child: DataTable(
                                        columns: getColumnsPergunta(),
                                        rows: getRowsPergunta()
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),                          
                          const Divider(color: Colors.white,),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _respostaController,
                                    decoration: getInputDecoration(
                                      'Informe uma resposta',
                                      'Resposta',
                                      false),
                                    onSaved: (String? value) {
                                    },
                                    onChanged: (text) {
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Adiciona Resposta',
                                    icon: const Icon(Icons.add),
                                    onPressed: () async {                                   
                                      if (_respostaController.text.isEmpty) {
                                        showInSnackBar('Por favor, insira uma resposta.', context, corFundo: Colors.red);
                                      } else {
                                        if (perguntaMontadoSelecionada == null) {
                                          showInSnackBar('Por favor, selecione uma pergunta para incluir respostas.', context, corFundo: Colors.red);
                                        } else {
                                          perguntaMontadoSelecionada!.listaCardapioRespostaPadrao.add(
                                            CardapioRespostaPadrao(id: null, resposta: _respostaController.text),
                                          );
                                          setState(() {
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 170.0,
                            child: Scrollbar(
                              child: ListView(
                                padding: const EdgeInsets.all(2.0),
                                children: <Widget>[
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 2.0,
                                      child: DataTable(
                                          columns: getColumnsResposta(),
                                          rows: getRowsResposta()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),                          
                          const Divider(color: Colors.white,),
                        ],
                      ),

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

  List<DataColumn> getColumnsPergunta() {
    List<DataColumn> lista = [];
    lista.add(
      const DataColumn(
        label: Text(''),
        tooltip: '',      
    ));
    lista.add(const DataColumn(
      label: Text(
        "Perguntas",
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ));
    return lista;
  }

  List<DataRow> getRowsPergunta() {
    List<DataRow> lista = [];
    for (var perguntaMontado in ProdutoController.listaCardapioPerguntaPadraoMontado) {
      List<DataCell> celulas = [];

      celulas = [
        DataCell(
            getBotaoGenericoPdv(
              descricao: 'Excluir',
              cor: Colors.red.shade400, 
              padding: const EdgeInsets.all(5),
              onPressed: () {
                _excluirPergunta(perguntaMontado);
              }
            ),
        ),
        DataCell(
          Text(perguntaMontado.cardapioPerguntaPadrao?.pergunta ?? '',
            style: TextStyle(
              color: perguntaMontado.id == perguntaMontadoSelecionada?.id ? Colors.blue : Colors.black, 
              fontWeight: perguntaMontado.id == perguntaMontadoSelecionada?.id ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: () => _exibirRespostas(perguntaMontado)
        ),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  void _exibirRespostas(CardapioPerguntaPadraoMontado perguntaMontado) {
    setState(() {
      perguntaMontadoSelecionada = perguntaMontado;
    });
  }

  void _excluirPergunta(CardapioPerguntaPadraoMontado perguntaMontado) {
    gerarDialogBoxExclusao(context, () {
      setState(() {
        if (perguntaMontado.id == perguntaMontadoSelecionada!.id) {
          perguntaMontadoSelecionada = null;  
        }
        ProdutoController.listaCardapioPerguntaPadraoMontado.removeWhere((item) => item.id == perguntaMontado.id);
      });
    });
  } 

  List<DataColumn> getColumnsResposta() {
    List<DataColumn> lista = [];
    lista.add(
      const DataColumn(
        label: Text(''),
        tooltip: '',      
    ));
    lista.add(const DataColumn(
      label: Text(
        "Respostas",
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ));
    return lista;
  }

  List<DataRow> getRowsResposta() {
    List<DataRow> lista = [];
    if (perguntaMontadoSelecionada != null) {
      for (var resposta in perguntaMontadoSelecionada!.listaCardapioRespostaPadrao) {
        List<DataCell> celulas = [];

        celulas = [
          DataCell(
              getBotaoGenericoPdv(
                descricao: 'Excluir',
                cor: Colors.red.shade400, 
                padding: const EdgeInsets.all(5),
                onPressed: () {
                  _excluirResposta(resposta);
                }
              ),
          ),
          DataCell(
            Text(resposta.resposta!),
          ),
        ];

        lista.add(DataRow(cells: celulas));
      }
    }
    return lista;
  }

  void _excluirResposta(CardapioRespostaPadrao resposta) {
    gerarDialogBoxExclusao(context, () {
      setState(() {
        perguntaMontadoSelecionada!.listaCardapioRespostaPadrao.removeWhere((item) => item.resposta == resposta.resposta);
      });
    });
  }  
}