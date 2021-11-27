/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [PRODUTO] 
                                                                                
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
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_abas.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';

class ProdutoPersistePage extends StatefulWidget {
  final ProdutoMontado? produtoMontado;
  final GlobalKey<FormState>? formKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final FocusNode? foco;
  final Function? salvarProdutoCallBack;
  final Function? atualizarProdutoCallBack;

  const ProdutoPersistePage({Key? key, this.formKey, this.scaffoldKey, this.produtoMontado, this.foco, this.salvarProdutoCallBack, this.atualizarProdutoCallBack})
      : super(key: key);

  @override
  _ProdutoPersistePageState createState() => _ProdutoPersistePageState();
}

class _ProdutoPersistePageState extends State<ProdutoPersistePage> {
  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;
  final _foco = FocusNode();

  Produto? _produto;

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

    _produto = widget.produtoMontado!.produto;
    _produto ??= Produto(id: null); // se produto for nulo, instancia
    _foco.requestFocus();
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      // case AtalhoTelaType.excluir:
      //   _excluir();
      //   break;
      case AtalhoTelaType.salvar:
        widget.salvarProdutoCallBack!();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _importaProdutoUnidadeController = TextEditingController();
    _importaProdutoUnidadeController.text = widget.produtoMontado?.produtoUnidade?.sigla ?? '';
    final _importaTributGrupoTributarioController = TextEditingController();
    _importaTributGrupoTributarioController.text = widget.produtoMontado?.tributGrupoTributario?.descricao ?? '';
    final _importaProdutoTipoController = TextEditingController();
    _importaProdutoTipoController.text = widget.produtoMontado?.produtoTipo?.descricao ?? '';
    final _importaProdutoSubgrupoController = TextEditingController();
    _importaProdutoSubgrupoController.text = widget.produtoMontado?.produtoSubgrupo?.nome ?? '';
	
    final _valorCompraController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _produto?.valorCompra ?? 0);
    final _valorVendaController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _produto?.valorVenda ?? 0);
    final _valorCustoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _produto?.valorCusto ?? 0);
    final _quantidadeEstoqueController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _produto?.quantidadeEstoque ?? 0);
    final _estoqueMinimoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _produto?.estoqueMinimo ?? 0);
    final _estoqueMaximoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _produto?.estoqueMaximo ?? 0);

    final _ncmController = MaskedTextController(
      mask: '00000000',
      text: _produto!.codigoNcm ?? '',
    );

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        child: Scaffold(drawerDragStartBehavior: DragStartBehavior.down,
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
                  child: BootstrapContainer(
                    fluid: true,
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,                    // children: [
                    children: <Widget>[			  			  
                      const Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                              sizes: 'col-12',
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: _foco,
                                    validator: ValidaCampoFormulario.validarObrigatorio,
                                    controller: _importaProdutoUnidadeController,
                                    readOnly: true,
                                    decoration: getInputDecoration(
                                      'Conteúdo para o campo Unidade',
                                      'Unidade *',
                                      false),
                                    onSaved: (String? value) {
                                    },
                                    onChanged: (text) {
                                      paginaMestreDetalheFoiAlterada = true;
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Unidade',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic>? _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                          builder: (BuildContext context) => LookupLocalPage(
                                            title: 'Importar Unidade',
                                            colunas: ProdutoUnidadeDao.colunas,
                                            campos: ProdutoUnidadeDao.campos,
                                            campoPesquisaPadrao: 'sigla',
                                            valorPesquisaPadrao: '%',
                                            metodoConsultaCallBack: _filtrarUnidadeLookup,                                             
                                            permiteCadastro: true,
                                            metodoCadastroCallBack: () { Navigator.pushNamed(context, '/produtoUnidadeLista',); },
                                          ),
                                          fullscreenDialog: true,
                                        ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['sigla'] != null) {
                                          _importaProdutoUnidadeController.text = _objetoJsonRetorno['sigla'];
                                          _produto = _produto!.copyWith(idProdutoUnidade: _objetoJsonRetorno['id']);
                                          widget.produtoMontado!.produtoUnidade = widget.produtoMontado!.produtoUnidade!.copyWith(
                                            sigla: _objetoJsonRetorno['sigla'],
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
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: _foco,
                                    validator: ValidaCampoFormulario.validarObrigatorio,
                                    controller: _importaProdutoTipoController,
                                    readOnly: true,
                                    decoration: getInputDecoration(
                                      'Conteúdo para o campo Tipo',
                                      'Tipo *',
                                      false),
                                    onSaved: (String? value) {
                                    },
                                    onChanged: (text) {
                                      paginaMestreDetalheFoiAlterada = true;
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Tipo',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic>? _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                          builder: (BuildContext context) => LookupLocalPage(
                                            title: 'Importar Tipo',
                                            colunas: ProdutoTipoDao.colunas,
                                            campos: ProdutoTipoDao.campos,
                                            campoPesquisaPadrao: 'descricao',
                                            valorPesquisaPadrao: '%',
                                            metodoConsultaCallBack: _filtrarTipoLookup,                                             
                                            permiteCadastro: true,
                                            metodoCadastroCallBack: () { Navigator.pushNamed(context, '/produtoTipoLista',); },
                                          ),
                                          fullscreenDialog: true,
                                        ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['descricao'] != null) {
                                          _importaProdutoTipoController.text = _objetoJsonRetorno['descricao'];
                                          _produto = _produto!.copyWith(idProdutoTipo: _objetoJsonRetorno['id']);
                                          widget.produtoMontado!.produtoTipo = widget.produtoMontado!.produtoTipo!.copyWith(
                                            descricao: _objetoJsonRetorno['descricao'],
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
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: _foco,
                                    validator: ValidaCampoFormulario.validarObrigatorio,
                                    controller: _importaProdutoSubgrupoController,
                                    readOnly: true,
                                    decoration: getInputDecoration(
                                      'Conteúdo para o campo Subgrupo',
                                      'Subgrupo *',
                                      false),
                                    onSaved: (String? value) {
                                    },
                                    onChanged: (text) {
                                      paginaMestreDetalheFoiAlterada = true;
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Subgrupo',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic>? _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                          builder: (BuildContext context) => LookupLocalPage(
                                            title: 'Importar Subgrupo',
                                            colunas: ProdutoSubgrupoDao.colunas,
                                            campos: ProdutoSubgrupoDao.campos,
                                            campoPesquisaPadrao: 'nome',
                                            valorPesquisaPadrao: '%',
                                            metodoConsultaCallBack: _filtrarSubgrupoLookup,                                             
                                            permiteCadastro: true,
                                            metodoCadastroCallBack: () { Navigator.pushNamed(context, '/produtoSubgrupoLista',); },
                                          ),
                                          fullscreenDialog: true,
                                        ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['nome'] != null) {
                                          _importaProdutoSubgrupoController.text = _objetoJsonRetorno['nome'];
                                          _produto = _produto!.copyWith(idProdutoSubgrupo: _objetoJsonRetorno['id']);
                                          widget.produtoMontado!.produtoSubgrupo = widget.produtoMontado!.produtoSubgrupo!.copyWith(
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
                      Visibility(
                        visible: Sessao.configuracaoPdv!.modulo != 'G',
                        child: const Divider(color: Colors.white,),
                      ),
                      Visibility(
                        visible: Sessao.configuracaoPdv!.modulo != 'G',
                        child: BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      focusNode: _foco,
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      controller: _importaTributGrupoTributarioController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Conteúdo para o campo Grupo Tributário',
                                        'Grupo Tributário *',
                                        false),
                                      onSaved: (String? value) {
                                      },
                                      onChanged: (text) {
                                        paginaMestreDetalheFoiAlterada = true;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: IconButton(
                                      tooltip: 'Importar Grupo Tributário',
                                      icon: ViewUtilLib.getIconBotaoLookup(),
                                      onPressed: () async {
                                        ///chamando o lookup
                                        Map<String, dynamic>? _objetoJsonRetorno =
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                            builder: (BuildContext context) => LookupLocalPage(
                                              title: 'Importar Grupo Tributário',
                                              colunas: TributGrupoTributarioDao.colunas,
                                              campos: TributGrupoTributarioDao.campos,
                                              campoPesquisaPadrao: 'descricao',
                                              valorPesquisaPadrao: '%',
                                              metodoConsultaCallBack: _filtrarGrupoTributarioLookup,                                             
                                              // permiteCadastro: true,
                                              // metodoCadastroCallBack: () { Navigator.pushNamed(context, '/produtoUnidadeLista',); },
                                            ),
                                            fullscreenDialog: true,
                                          ));
                                        if (_objetoJsonRetorno != null) {
                                          if (_objetoJsonRetorno['descricao'] != null) {
                                            _importaTributGrupoTributarioController.text = _objetoJsonRetorno['descricao'];
                                            _produto = _produto!.copyWith(idTributGrupoTributario: _objetoJsonRetorno['id']);
                                            widget.produtoMontado!.tributGrupoTributario = widget.produtoMontado!.tributGrupoTributario!.copyWith(
                                              descricao: _objetoJsonRetorno['descricao'],
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
                      ),
                      const Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: TextFormField(
                                validator: ValidaCampoFormulario.validarObrigatorio,
                                maxLength: 14,
                                maxLines: 1,
                                initialValue: _produto?.gtin ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Gtin',
                                  'Gtin',
                                  false),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  _produto = _produto!.copyWith(gtin: text);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: TextFormField(
                                maxLength: 50,
                                maxLines: 1,
                                initialValue: _produto?.codigoInterno ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Codigo Interno',
                                  'Codigo Interno',
                                  false),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  _produto = _produto!.copyWith(codigoInterno: text);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
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
                              validator: ValidaCampoFormulario.validarObrigatorio,
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: _produto?.nome ?? '',
                              decoration: getInputDecoration(
                                'Conteúdo para o campo Nome',
                                'Nome',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _produto = _produto!.copyWith(nome: text);
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
                              maxLength: 250,
                              maxLines: 3,
                              initialValue: _produto?.descricao ?? '',
                              decoration: getInputDecoration(
                                'Conteúdo para o campo Descricao',
                                'Descricao',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _produto = _produto!.copyWith(descricao: text);
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
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: TextFormField(
                                validator: ValidaCampoFormulario.validarObrigatorio,
                                controller: _ncmController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo NCM',
                                  'Código NCM',
                                  true,
                                  paddingVertical: 18),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  _produto = _produto!.copyWith(codigoNcm: text);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: InputDecorator(
                                decoration: getInputDecoration(
                                  'Indicador de Produção Própria ou de Terceiros',
                                  'Produção [P]rópria ou [T]erceiros',
                                  true),
                                isEmpty: _produto!.ippt == null,
                                child: getDropDownButton(_produto!.ippt,
                                  (String? newValue) {
                                    setState(() {
                                      widget.produtoMontado!.produto = _produto!.copyWith(ippt: newValue);
                                      _produto = _produto!.copyWith(ippt: newValue);
                                      widget.atualizarProdutoCallBack!();
                                    });
                                }, <String>[
                                  'P',
                                  'T',
                                  ],
                                  validator: ValidaCampoFormulario.validarObrigatorio,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                textAlign: TextAlign.end,
                                controller: _valorCompraController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Valor Compra',
                                  'Valor Compra',
                                  false),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  _produto = _produto!.copyWith(valorCompra: _valorCompraController.numberValue);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                validator: ValidaCampoFormulario.validarObrigatorioDouble,
                                textAlign: TextAlign.end,
                                controller: _valorVendaController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Valor Venda',
                                  'Valor Venda',
                                  false),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  _produto = _produto!.copyWith(valorVenda: _valorVendaController.numberValue);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                // validator: ValidaCampoFormulario.validarObrigatorioDouble,
                                textAlign: TextAlign.end,
                                controller: _valorCustoController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Valor Custo',
                                  'Valor Custo',
                                  false),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  _produto = _produto!.copyWith(valorCusto: _valorCustoController.numberValue);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                textAlign: TextAlign.end,
                                controller: _quantidadeEstoqueController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Quantidade Estoque',
                                  'Quantidade Estoque',
                                  false),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  _produto = _produto!.copyWith(quantidadeEstoque: _quantidadeEstoqueController.numberValue);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                textAlign: TextAlign.end,
                                controller: _estoqueMinimoController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Estoque Minimo',
                                  'Estoque Minimo',
                                  false),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  _produto = _produto!.copyWith(estoqueMinimo: _estoqueMinimoController.numberValue);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context)!,
                              child: TextFormField(
                                enableInteractiveSelection: !Biblioteca.isDesktop(),
                                textAlign: TextAlign.end,
                                controller: _estoqueMaximoController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Estoque Maximo',
                                  'Estoque Maximo',
                                  false),
                                onSaved: (String? value) {
                                },
                                onChanged: (text) {
                                  _produto = _produto!.copyWith(estoqueMaximo: _estoqueMaximoController.numberValue);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
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

  void _filtrarUnidadeLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.produtoUnidadeDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _filtrarTipoLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.produtoTipoDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _filtrarGrupoTributarioLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.tributGrupoTributarioDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _filtrarSubgrupoLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.produtoSubgrupoDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

}