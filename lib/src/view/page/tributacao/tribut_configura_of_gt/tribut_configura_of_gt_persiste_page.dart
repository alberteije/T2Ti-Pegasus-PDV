/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre PersistePage relacionada à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/controller/controller.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';
import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';


class TributConfiguraOfGtPersistePage extends StatefulWidget {
  final TributConfiguraOfGtMontado tributConfiguraOfGtMontado;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final FocusNode foco;
  final Function salvarTributConfiguraOfGtCallBack;
  final Function atualizarTributConfiguraOfGtCallBack;

  const TributConfiguraOfGtPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.tributConfiguraOfGtMontado, this.foco, this.salvarTributConfiguraOfGtCallBack, this.atualizarTributConfiguraOfGtCallBack})
      : super(key: key);

  @override
  _TributConfiguraOfGtPersistePageState createState() => _TributConfiguraOfGtPersistePageState();
}

class _TributConfiguraOfGtPersistePageState extends State<TributConfiguraOfGtPersistePage> {
  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;
  final _foco = FocusNode();

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
        widget.salvarTributConfiguraOfGtCallBack();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final _importaTributGrupoTributarioController = TextEditingController();
    _importaTributGrupoTributarioController.text = widget.tributConfiguraOfGtMontado?.tributGrupoTributario?.descricao ?? '';
    final _importaTributOperacaoFiscalController = TextEditingController();
    _importaTributOperacaoFiscalController.text = widget.tributConfiguraOfGtMontado?.tributOperacaoFiscal?.descricao ?? '';

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
                    decoration: BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
                    children: <Widget>[			  			  
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
                                      focusNode: _foco,
                                      controller: _importaTributGrupoTributarioController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe o Grupo Tributário Vinculado',
                                        'Grupo Tributário *',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                                      onChanged: (text) {
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Grupo Tributário',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupLocalPage(
                                                title: 'Importar Grupo Tributário',
                                                colunas: TributGrupoTributarioDao.colunas,
                                                campos: TributGrupoTributarioDao.campos,
                                                campoPesquisaPadrao: 'descricao',
                                                valorPesquisaPadrao: '%',
                                                metodoConsultaCallBack: _filtrarGrupoTributarioLookup,                                             
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['descricao'] != null) {
                                          _importaTributGrupoTributarioController.text = _objetoJsonRetorno['descricao'];
                                          widget.tributConfiguraOfGtMontado.tributGrupoTributario = TributGrupoTributario(
                                              id: _objetoJsonRetorno['id'],
                                              descricao: _objetoJsonRetorno['descricao']
                                          );
                                          widget.tributConfiguraOfGtMontado.tributConfiguraOfGt = 
                                            widget.tributConfiguraOfGtMontado.tributConfiguraOfGt.copyWith(
                                              idTributGrupoTributario: _objetoJsonRetorno['id'],
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
                            sizes: 'col-12',
                            child: 
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextFormField(
                                      controller: _importaTributOperacaoFiscalController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe a Operação Fiscal Vinculada',
                                        'Operação Fiscal *',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                                      onChanged: (text) {
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Operação Fiscal',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupLocalPage(
                                                title: 'Importar Operação Fiscal',
                                                colunas: TributOperacaoFiscalDao.colunas,
                                                campos: TributOperacaoFiscalDao.campos,
                                                campoPesquisaPadrao: 'descricao',
                                                valorPesquisaPadrao: '%',
                                                metodoConsultaCallBack: TributOperacaoFiscalController.filtrarOperacaoFiscalLookup,                                             
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['descricao'] != null) {
                                          _importaTributOperacaoFiscalController.text = _objetoJsonRetorno['descricao'];
                                          widget.tributConfiguraOfGtMontado.tributOperacaoFiscal = TributOperacaoFiscal(
                                              id: _objetoJsonRetorno['id'],
                                              descricao: _objetoJsonRetorno['descricao']
                                          );
                                          widget.tributConfiguraOfGtMontado.tributConfiguraOfGt = 
                                            widget.tributConfiguraOfGtMontado.tributConfiguraOfGt.copyWith(
                                              idTributOperacaoFiscal: _objetoJsonRetorno['id'],
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

  void _filtrarGrupoTributarioLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.tributGrupoTributarioDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

}