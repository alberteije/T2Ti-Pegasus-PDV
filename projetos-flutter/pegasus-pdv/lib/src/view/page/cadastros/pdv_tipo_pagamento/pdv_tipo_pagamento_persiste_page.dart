/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [PDV_TIPO_PAGAMENTO] 
                                                                                
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

class PdvTipoPagamentoPersistePage extends StatefulWidget {
  final PdvTipoPagamento pdvTipoPagamento;
  final String title;
  final String operacao;

  const PdvTipoPagamentoPersistePage({Key key, this.pdvTipoPagamento, this.title, this.operacao})
      : super(key: key);

  @override
  _PdvTipoPagamentoPersistePageState createState() => _PdvTipoPagamentoPersistePageState();
}

class _PdvTipoPagamentoPersistePageState extends State<PdvTipoPagamentoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;
  final _foco = FocusNode();

  PdvTipoPagamento pdvTipoPagamento;

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
    pdvTipoPagamento = widget.pdvTipoPagamento;
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
                    padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,                    // children: [
                    children: <Widget>[			  			  
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: TextFormField(
                              focusNode: _foco,
                              validator: ValidaCampoFormulario.validarObrigatorio,
                              maxLength: 3,
                              maxLines: 1,
                              initialValue: pdvTipoPagamento?.codigo ?? '',
                              decoration: getInputDecoration(
                                'Conteúdo para o campo Codigo',
                                'Codigo',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                pdvTipoPagamento = pdvTipoPagamento.copyWith(codigo: text);
                                _formFoiAlterado = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: Sessao.configuracaoPdv.moduloFiscalPrincipal == 'NFC',
                        child: Divider(color: Colors.white,),
                      ),
                      Visibility(
                        visible: Sessao.configuracaoPdv.moduloFiscalPrincipal == 'NFC',
                        child: BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: TextFormField(
                                validator: ValidaCampoFormulario.validarObrigatorio,
                                maxLength: 3,
                                maxLines: 1,
                                initialValue: pdvTipoPagamento?.codigoPagamentoNfce ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Codigo da NFC-e',
                                  'Codigo NFC-e',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  pdvTipoPagamento = pdvTipoPagamento.copyWith(codigoPagamentoNfce: text);
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: TextFormField(
                              validator: ValidaCampoFormulario.validarObrigatorio,
                              maxLength: 20,
                              maxLines: 1,
                              initialValue: pdvTipoPagamento?.descricao ?? '',
                              decoration: getInputDecoration(
                                'Conteúdo para o campo Descricao',
                                'Descricao',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                pdvTipoPagamento = pdvTipoPagamento.copyWith(descricao: text);
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
                                'Conteúdo para o campo Gera Parcelas',
                                'Gera Parcelas',
                                true),
                              isEmpty: pdvTipoPagamento.geraParcelas == null,
                              child: getDropDownButton(pdvTipoPagamento.geraParcelas,
                                (String newValue) {
                                  setState(() {
                                    pdvTipoPagamento = pdvTipoPagamento.copyWith(geraParcelas: newValue);
                                  });
                              }, <String>[
                                'S',
                                'N',
                              ],
                              validator: ValidaCampoFormulario.validarObrigatorio,
                            )),
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

  Future<void> _salvar() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
    } else {
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        form.save();        
        bool tudoCerto = false;
        if (widget.operacao == 'A') {
          await Sessao.db.pdvTipoPagamentoDao.alterar(pdvTipoPagamento);
          tudoCerto = true;
        } else {
          final tipoPagamento = await Sessao.db.pdvTipoPagamentoDao.consultarObjetoFiltro('CODIGO', pdvTipoPagamento.codigo);
          if (tipoPagamento == null) {
            await Sessao.db.pdvTipoPagamentoDao.inserir(pdvTipoPagamento);
            tudoCerto = true;
          } else {
            showInSnackBar('Já existe um tipo de pagamento cadastrado com o CÓDIGO informado.', context);
          }        
        }
        if (tudoCerto) {
          await Sessao.popularObjetosPrincipais(context); // pode afetar o parcelamento, por isso importante recarregar
          Navigator.of(context).pop();
        }
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
      await Sessao.db.pdvTipoPagamentoDao.excluir(pdvTipoPagamento);
      Navigator.of(context).pop();
    });
  }  

}