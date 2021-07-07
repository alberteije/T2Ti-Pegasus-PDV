/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [TRIBUT_GRUPO_TRIBUTARIO] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';


class TributGrupoTributarioPersistePage extends StatefulWidget {
  final TributGrupoTributario tributGrupoTributario;
  final String title;
  final String operacao;

  const TributGrupoTributarioPersistePage({Key key, this.tributGrupoTributario, this.title, this.operacao})
      : super(key: key);

  @override
  _TributGrupoTributarioPersistePageState createState() => _TributGrupoTributarioPersistePageState();
}

class _TributGrupoTributarioPersistePageState extends State<TributGrupoTributarioPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;
  final _foco = FocusNode();

  TributGrupoTributario tributGrupoTributario;

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
    tributGrupoTributario = widget.tributGrupoTributario;
    _foco.requestFocus();
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
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title), 
            actions: widget.operacao == "I"
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
                    children: <Widget>[
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: TextFormField(
                              validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                              focusNode: _foco,
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: widget.tributGrupoTributario?.descricao ?? '',
                              decoration: getInputDecoration(
                                'Informe a Descrição do Grupo Tributário',
                                'Descrição *',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                tributGrupoTributario = tributGrupoTributario.copyWith(descricao: text);
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
                            child: InputDecorator(
                              decoration: getInputDecoration(
                                'Selecione a Opção Desejada',
                                'Origem da Mercadoria',
                                true),
                              isEmpty: tributGrupoTributario.origemMercadoria == null,
                              child: getDropDownButton(tributGrupoTributario.origemMercadoria,
                                (String newValue) {
                                  _formFoiAlterado = true;
                                  setState(() {
                                    tributGrupoTributario = tributGrupoTributario.copyWith(origemMercadoria: newValue);
                                  });
                                  }, <String>[
                                    '0-Nacional - Exceto as indicadas nos códigos 3, 4, 5 e 8',
                                    '1-Estrangeira – Importação direta, exceto a indicada no código 6',
                                    '2-Estrangeira – Adquirida no mercado interno, exceto a indicada no código 7',
                                    '3-Nacional - Conteúdo de Importação > 40% e <= 70%',
                                    '4-Nacional - Produção conforme processos produtivos - Decreto/Lei',
                                    '5-Nacional - Conteúdo de Importação <= 40%',
                                    '6-Estrangeira – Importação direta - Resolução CAMEX e gás natural',
                                    '7-Estrangeira – Adquirida no mercado interno - Resolução CAMEX e gás natural',
                                    '8-Nacional - Conteúdo de Importação > 70%',
                                  ],
                                validator: ValidaCampoFormulario.validarObrigatorio,
                              )
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
                              initialValue: widget.tributGrupoTributario?.observacao ?? '',
                              decoration: getInputDecoration(
                                'Observações Gerais',
                                'Observação',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                tributGrupoTributario = tributGrupoTributario.copyWith(observacao: text);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _getBotoesRodape(context: context),
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

  Future<void> _salvar() async {
    if (_validarForm()) {
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        if (widget.operacao == 'A') {
          await Sessao.db.tributGrupoTributarioDao.alterar(tributGrupoTributario);
        } else {
          await Sessao.db.tributGrupoTributarioDao.inserir(tributGrupoTributario);
        }
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
      final listaProduto = await Sessao.db.produtoDao.consultarListaFiltro('ID_TRIBUT_GRUPO_TRIBUTARIO', tributGrupoTributario.id.toString());
      if (listaProduto.length > 0) {
        showInSnackBar('Existem produtos vinculados a este Grupo Tributário.', context);
      } else {
        await Sessao.db.tributGrupoTributarioDao.excluir(tributGrupoTributario);
        Navigator.of(context).pop();
      }
    });
  }  

  List<Widget> _getBotoesRodape({BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
      Container(
        width: 350,
        child: getBotaoGenericoPdv(
          descricao: 'Atribuir Grupo Tributário a Todos os Produtos',
          cor: Colors.green, 
          onPressed: () {
            _atribuirGrupoAProdutos();
          }
        ),
      )
    );
    return listaBotoes;
  }  

  Future<void> _atribuirGrupoAProdutos() async {
    if (_validarForm()) {
      if (tributGrupoTributario.id == null) {
        final _idInserido = await Sessao.db.tributGrupoTributarioDao.inserir(tributGrupoTributario);
        tributGrupoTributario = await Sessao.db.tributGrupoTributarioDao.consultarObjeto(_idInserido);
      }
      final _registrosAtualizados = await Sessao.db.produtoDao.atualizarGrupoTributario(tributGrupoTributario.id);
      showInSnackBar(
        'Foram atualizados ' + _registrosAtualizados.toString() + ' produtos.', 
        context, 
        corFundo: ViewUtilLib.getBackgroundColorSnackBarAzul()
      );
      Navigator.of(context).pop();
    }
  }

  bool _validarForm() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
      return false;
    } else {
      form.save();
      return true;
    }
  }


}