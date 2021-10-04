/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre PersistePage OneToOne relacionada à tabela [TRIBUT_PIS] 
                                                                                
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
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_abas.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class TributPisPersistePage extends StatefulWidget {
  final TributConfiguraOfGtMontado tributConfiguraOfGtMontado;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final FocusNode foco;
  final Function salvarTributConfiguraOfGtCallBack;

  const TributPisPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.tributConfiguraOfGtMontado, this.foco, this.salvarTributConfiguraOfGtCallBack})
      : super(key: key);

  @override
  _TributPisPersistePageState createState() => _TributPisPersistePageState();
}

class _TributPisPersistePageState extends State<TributPisPersistePage> {
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
    final _aliquotaPorcentoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGtMontado?.tributPis?.aliquotaPorcento ?? 0);

    if (widget.tributConfiguraOfGtMontado.tributPis == null) {
      widget.tributConfiguraOfGtMontado.tributPis = TributPis(id: null);
    }

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
                            child: TextFormField(
                              readOnly: true,
                              maxLength: 2,
                              maxLines: 1,
                              initialValue: widget.tributConfiguraOfGtMontado?.tributPis?.cstPis ?? '',
                              decoration: getInputDecoration(
                                'Informe o CST PIS',
                                'CST PIS',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                widget.tributConfiguraOfGtMontado.tributPis = 
                                widget.tributConfiguraOfGtMontado.tributPis.copyWith(cstPis: text);
                                paginaMestreDetalheFoiAlterada = true;
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
                              readOnly: true,
                              maxLength: 20,
                              maxLines: 1,
                              initialValue: widget.tributConfiguraOfGtMontado?.tributPis?.modalidadeBaseCalculo ?? '',
                              decoration: getInputDecoration(
                                'Informe a Modalidade Base Cálculo',
                                'Modalidade Base Cálculo',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                widget.tributConfiguraOfGtMontado.tributPis = 
                                widget.tributConfiguraOfGtMontado.tributPis.copyWith(modalidadeBaseCalculo: text);
                                paginaMestreDetalheFoiAlterada = true;
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
                              readOnly: true,
                              keyboardType: TextInputType.number,
                              controller: _aliquotaPorcentoController,
                              decoration: getInputDecoration(
                                'Informe a Alíquota do Porcento',
                                'Alíquota Porcento',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                widget.tributConfiguraOfGtMontado.tributPis = 
                                widget.tributConfiguraOfGtMontado.tributPis.copyWith(aliquotaPorcento: _aliquotaPorcentoController.numberValue);
                                paginaMestreDetalheFoiAlterada = true;
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
}