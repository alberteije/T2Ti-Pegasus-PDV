/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre PersistePage OneToOne relacionada à tabela [TRIBUT_ICMS_UF] 
                                                                                
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

class TributIcmsUfPersistePage extends StatefulWidget {
  final TributConfiguraOfGtMontado tributConfiguraOfGtMontado;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final FocusNode foco;
  final Function salvarTributConfiguraOfGtCallBack;

  const TributIcmsUfPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.tributConfiguraOfGtMontado, this.foco, this.salvarTributConfiguraOfGtCallBack})
      : super(key: key);

  @override
  _TributIcmsUfPersistePageState createState() => _TributIcmsUfPersistePageState();
}

class _TributIcmsUfPersistePageState extends State<TributIcmsUfPersistePage> {
  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;
  final _foco = FocusNode();
  // bool _formFoiAlterado = false;

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
    final _aliquotaController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.aliquota ?? 0);
    final _valorPautaController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.valorPauta ?? 0);
    final _valorPrecoMaximoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.valorPrecoMaximo ?? 0);
    final _mvaController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.mva ?? 0);
    final _porcentoBcController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.porcentoBc ?? 0);
    // final _aliquotaInternaStController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.aliquotaInternaSt ?? 0);
    // final _aliquotaInterestadualStController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.aliquotaInterestadualSt ?? 0);
    // final _porcentoBcStController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.porcentoBcSt ?? 0);
    // final _aliquotaIcmsStController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.aliquotaIcmsSt ?? 0);
    // final _valorPautaStController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.valorPautaSt ?? 0);
    // final _valorPrecoMaximoStController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.valorPrecoMaximoSt ?? 0);

    if (widget.tributConfiguraOfGtMontado.tributIcmsUf == null) {
      widget.tributConfiguraOfGtMontado.tributIcmsUf = TributIcmsUf(id: null);
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
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                readOnly: true,
                                maxLength: 10,
                                maxLines: 1,
                                initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.ufDestino ?? Sessao.empresa.uf,
                                decoration: getInputDecoration(
                                  'Informe a UF de Destino',
                                  'UF *',
                                  true,
                                  paddingVertical: 18),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                  widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(ufDestino: Sessao.empresa.uf);
                                  paginaMestreDetalheFoiAlterada = true;
                                  // _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: InputDecorator(
                                decoration: getInputDecoration(
                                  'Selecione a Opção Desejada',
                                  'CFOP *',
                                  true),
                                isEmpty: widget.tributConfiguraOfGtMontado.tributIcmsUf.cfop == null,
                                child: getDropDownButton(widget.tributConfiguraOfGtMontado.tributIcmsUf.cfop?.toString(),
                                  (String newValue) {
                                    // _formFoiAlterado = true;
                                    paginaMestreDetalheFoiAlterada = true;
                                    setState(() {
                                      widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                      widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(cfop: int.tryParse(newValue));
                                    });
                                  }, <String>[
                                  '5101',
                                  '5102',
                                  '5103',
                                  '5104',
                                  '5115',
                                  '5405',
                                  '5656',
                                  '5667',
                                  '5933',
                              ],
                              validator: ValidaCampoFormulario.validarObrigatorio,
                              )),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: Sessao.empresa.crt.substring(0,1) == '1' 
                                ?  
                                InputDecorator(
                                  decoration: getInputDecoration(
                                    'Selecione a Opção Desejada',
                                    'CSOSN *',
                                    true),
                                  isEmpty: widget.tributConfiguraOfGtMontado.tributIcmsUf.csosn == null,
                                  child: getDropDownButton(widget.tributConfiguraOfGtMontado.tributIcmsUf.csosn,
                                    (String newValue) {
                                      // _formFoiAlterado = true;
                                      paginaMestreDetalheFoiAlterada = true;
                                      setState(() {
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(csosn: newValue);
                                      });
                                    }, <String>[
                                    '102',
                                    '300',
                                    '500',
                                    ],
                                    validator: ValidaCampoFormulario.validarObrigatorio,
                                  )
                                )                                                                                    
                                :
                                TextFormField(
                                  maxLength: 2,
                                  maxLines: 1,
                                  initialValue: widget.tributConfiguraOfGtMontado?.tributIcmsUf?.cst ?? '',
                                  decoration: getInputDecoration(
                                    'Informe o CST',
                                    'CST',
                                    true,
                                    paddingVertical: 18),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                    widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(cst: text);
                                    paginaMestreDetalheFoiAlterada = true;
                                    // _formFoiAlterado = true;
                                  },
                                ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: Sessao.empresa.crt.substring(0,1) != '1',
                        child: Column(
                          children: [
                            Divider(color: Colors.white,),
                            BootstrapRow(
                              height: 60,
                              children: <BootstrapCol>[
                                BootstrapCol(
                                  sizes: 'col-12 col-md-6',
                                  child: Padding(
                                    padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                    child: InputDecorator(
                                      decoration: getInputDecoration(
                                        'Selecione a Opção Desejada',
                                        'Modalidade Base Cálculo',
                                        true),
                                      isEmpty: widget.tributConfiguraOfGtMontado.tributIcmsUf.modalidadeBc == null,
                                      child: getDropDownButton(widget.tributConfiguraOfGtMontado.tributIcmsUf.modalidadeBc,
                                        (String newValue) {
                                      paginaMestreDetalheFoiAlterada = true;
                                      setState(() {
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(modalidadeBc: newValue);
                                      });
                                      }, <String>[
                                        '0-Margem Valor Agregado (%)',
                                        '1-Pauta (Valor)',
                                        '2-Preço Tabelado Máx. (valor)',
                                        '3-Valor da Operação',
                                    ])),
                                  ),
                                ),
                                BootstrapCol(
                                  sizes: 'col-12 col-md-6',
                                  child: Padding(
                                    padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _aliquotaController,
                                      decoration: getInputDecoration(
                                        'Informe o Alíquota caso Modalidade BC=3',
                                        'Alíquota',
                                        true,
                                        paddingVertical: 18),
                                      onSaved: (String value) {
                                      },
                                      onChanged: (text) {
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(aliquota: _aliquotaController.numberValue);
                                        paginaMestreDetalheFoiAlterada = true;
                                        // _formFoiAlterado = true;
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
                                  sizes: 'col-12 col-md-6',
                                  child: Padding(
                                    padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _valorPautaController,
                                      decoration: getInputDecoration(
                                        'Informe o Valor Pauta, caso Modalidade BC=1',
                                        'Valor Pauta',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      onChanged: (text) {
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(valorPauta: _valorPautaController.numberValue);
                                        paginaMestreDetalheFoiAlterada = true;
                                        // _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                BootstrapCol(
                                  sizes: 'col-12 col-md-6',
                                  child: Padding(
                                    padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _valorPrecoMaximoController,
                                      decoration: getInputDecoration(
                                        'Informe o Valor Preço Máximo, caso Modalidade BC=2',
                                        'Valor Preço Máximo',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      onChanged: (text) {
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(valorPrecoMaximo: _valorPrecoMaximoController.numberValue);
                                        paginaMestreDetalheFoiAlterada = true;
                                        // _formFoiAlterado = true;
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
                                  sizes: 'col-12 col-md-6',
                                  child: Padding(
                                    padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _mvaController,
                                      decoration: getInputDecoration(
                                        'Informe o Valor da Margem Valor Agregado',
                                        'Valor MVA',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      onChanged: (text) {
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(mva: _mvaController.numberValue);
                                        paginaMestreDetalheFoiAlterada = true;
                                        // _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                BootstrapCol(
                                  sizes: 'col-12 col-md-6',
                                  child: Padding(
                                    padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _porcentoBcController,
                                      decoration: getInputDecoration(
                                        'Informe o Porcentual da Base de Cálculo',
                                        'Porcento Base Cálculo',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      onChanged: (text) {
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                                        widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(porcentoBc: _porcentoBcController.numberValue);
                                        paginaMestreDetalheFoiAlterada = true;
                                        // _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),                      
                      // Divider(color: Colors.white,),
                      // BootstrapRow(
                      //   height: 60,
                      //   children: <BootstrapCol>[
                      //     BootstrapCol(
                      //       sizes: 'col-12',
                      //       child: InputDecorator(
                      //         decoration: getInputDecoration(
                      //           'Selecione a Opção Desejada',
                      //           'Modalidade Base Cálculo ST',
                      //           true),
                      //         isEmpty: widget.tributConfiguraOfGtMontado.tributIcmsUf.modalidadeBcSt == null,
                      //         child: getDropDownButton(widget.tributConfiguraOfGtMontado.tributIcmsUf.modalidadeBcSt,
                      //           (String newValue) {
                      //         paginaMestreDetalheFoiAlterada = true;
                      //         setState(() {
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(modalidadeBcSt: newValue);
                      //         });
                      //         }, <String>[
                      //           '0-Preço tabelado ou máximo sugerido',
                      //           '1-Lista Negativa (valor)',
                      //           '2-Lista Positiva (valor)',
                      //           '3-Lista Neutra (valor)',
                      //           '4-Margem Valor Agregado (%)',
                      //           '5-Pauta (valor)',
                      //       ])),
                      //     ),
                      //   ],
                      // ),
                      // Divider(color: Colors.white,),
                      // BootstrapRow(
                      //   height: 60,
                      //   children: <BootstrapCol>[
                      //     BootstrapCol(
                      //       sizes: 'col-12',
                      //       child: TextFormField(
                      //         keyboardType: TextInputType.number,
                      //         controller: _aliquotaInternaStController,
                      //         decoration: getInputDecoration(
                      //           'Informe a Alíquota Interna ST',
                      //           'Alíquota Interna ST',
                      //           false),
                      //         onSaved: (String value) {
                      //         },
                      //         onChanged: (text) {
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(aliquotaInternaSt: _aliquotaInternaStController.numberValue);
                      //           paginaMestreDetalheFoiAlterada = true;
                      //           // _formFoiAlterado = true;
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Divider(color: Colors.white,),
                      // BootstrapRow(
                      //   height: 60,
                      //   children: <BootstrapCol>[
                      //     BootstrapCol(
                      //       sizes: 'col-12',
                      //       child: TextFormField(
                      //         keyboardType: TextInputType.number,
                      //         controller: _aliquotaInterestadualStController,
                      //         decoration: getInputDecoration(
                      //           'Informe a Alíquota Interestadual ST',
                      //           'Alíquota Interestadual ST',
                      //           false),
                      //         onSaved: (String value) {
                      //         },
                      //         onChanged: (text) {
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(aliquotaInterestadualSt: _aliquotaInterestadualStController.numberValue);
                      //           paginaMestreDetalheFoiAlterada = true;
                      //           // _formFoiAlterado = true;
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Divider(color: Colors.white,),
                      // BootstrapRow(
                      //   height: 60,
                      //   children: <BootstrapCol>[
                      //     BootstrapCol(
                      //       sizes: 'col-12',
                      //       child: TextFormField(
                      //         keyboardType: TextInputType.number,
                      //         controller: _porcentoBcStController,
                      //         decoration: getInputDecoration(
                      //           'Informe o Porcentual da Base de Cálculo ST',
                      //           'Porcento Base Cálculo ST',
                      //           false),
                      //         onSaved: (String value) {
                      //         },
                      //         onChanged: (text) {
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(porcentoBcSt: _porcentoBcStController.numberValue);
                      //           paginaMestreDetalheFoiAlterada = true;
                      //           // _formFoiAlterado = true;
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Divider(color: Colors.white,),
                      // BootstrapRow(
                      //   height: 60,
                      //   children: <BootstrapCol>[
                      //     BootstrapCol(
                      //       sizes: 'col-12',
                      //       child: TextFormField(
                      //         keyboardType: TextInputType.number,
                      //         controller: _aliquotaIcmsStController,
                      //         decoration: getInputDecoration(
                      //           'Informe o Alíquota ICMS ST',
                      //           'Alíquota ICMS ST',
                      //           false),
                      //         onSaved: (String value) {
                      //         },
                      //         onChanged: (text) {
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(aliquotaIcmsSt: _aliquotaIcmsStController.numberValue);
                      //           paginaMestreDetalheFoiAlterada = true;
                      //           // _formFoiAlterado = true;
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Divider(color: Colors.white,),
                      // BootstrapRow(
                      //   height: 60,
                      //   children: <BootstrapCol>[
                      //     BootstrapCol(
                      //       sizes: 'col-12',
                      //       child: TextFormField(
                      //         keyboardType: TextInputType.number,
                      //         controller: _valorPautaStController,
                      //         decoration: getInputDecoration(
                      //           'Informe o Valor Pauta ST, caso Modalidade BC ST=5',
                      //           'Valor Pauta ST',
                      //           false),
                      //         onSaved: (String value) {
                      //         },
                      //         onChanged: (text) {
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(valorPautaSt: _valorPautaStController.numberValue);
                      //           paginaMestreDetalheFoiAlterada = true;
                      //           // _formFoiAlterado = true;
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Divider(color: Colors.white,),
                      // BootstrapRow(
                      //   height: 60,
                      //   children: <BootstrapCol>[
                      //     BootstrapCol(
                      //       sizes: 'col-12',
                      //       child: TextFormField(
                      //         keyboardType: TextInputType.number,
                      //         controller: _valorPrecoMaximoStController,
                      //         decoration: getInputDecoration(
                      //           'Informe o Valor Preço Máximo ST, caso Modalidade BC ST=0',
                      //           'Valor Preço Máximo ST',
                      //           false),
                      //         onSaved: (String value) {
                      //         },
                      //         onChanged: (text) {
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf = 
                      //           widget.tributConfiguraOfGtMontado.tributIcmsUf.copyWith(valorPrecoMaximoSt: _valorPrecoMaximoStController.numberValue);
                      //           paginaMestreDetalheFoiAlterada = true;
                      //           // _formFoiAlterado = true;
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
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