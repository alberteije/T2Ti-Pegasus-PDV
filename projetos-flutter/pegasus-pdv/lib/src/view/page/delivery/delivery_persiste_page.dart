/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [DELIVERY] 
                                                                                
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
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

import 'package:extended_masked_text/extended_masked_text.dart';

class DeliveryPersistePage extends StatefulWidget {
  final DeliveryMontado? deliveryMontado;
  final String? title;
  final String? operacao;

  const DeliveryPersistePage({Key? key, this.deliveryMontado, this.title, this.operacao})
      : super(key: key);

  @override
  DeliveryPersistePageState createState() => DeliveryPersistePageState();
}

class DeliveryPersistePageState extends State<DeliveryPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;
  final _foco = FocusNode();

  Delivery? _delivery;

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
    _delivery = widget.deliveryMontado?.delivery;
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
    final importaTaxaEntregaController = TextEditingController();
    importaTaxaEntregaController.text = widget.deliveryMontado?.taxaEntrega?.nome ?? '';
    final importaColaboradorController = TextEditingController();
    importaColaboradorController.text = widget.deliveryMontado?.colaborador?.nome ?? '';
    final telefonePrincipalController = MaskedTextController(
      mask: Constantes.mascaraTELEFONE,
      text: _delivery?.telefonePrincipal ?? '',
    );
    final telefoneRecadoController = MaskedTextController(
      mask: Constantes.mascaraTELEFONE,
      text: _delivery?.telefoneRecado ?? '',
    );
    final celularController = MaskedTextController(
      mask: Constantes.mascaraTELEFONE,
      text: _delivery?.celular ?? '',
    );
    final importaCepController = TextEditingController();
    importaCepController.text = _delivery?.cep ?? '';
    final importaUfController = TextEditingController();
    importaUfController.text = _delivery?.uf ?? '';
    final valorFreteController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _delivery?.valorFrete ?? 0);
    final valorRecebidoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _delivery?.valorRecebido ?? 0);
    final valorSolicitadoTrocoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: _delivery?.valorSolicitadoTroco ?? 0);
	
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title!), 
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
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
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
                                  child: SizedBox(
                                    child: TextFormField(
                                      controller: importaTaxaEntregaController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe a Taxa de Entrega Vinculada',
                                        'Taxa de Entrega *',
                                        false),
                                      onSaved: (String? value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      onChanged: (text) {
                                        // widget.deliveryMontado?.taxaEntrega?.nome = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Taxa de Entrega',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic>? objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupLocalPage(
                                                title: 'Importar Taxa de Entrega',
                                                colunas: TaxaEntregaDao.colunas,
                                                campos: TaxaEntregaDao.campos,
                                                campoPesquisaPadrao: 'Nome',
                                                valorPesquisaPadrao: '%',
                                                metodoConsultaCallBack: _filtrarTaxaEntregaLookup,                                             
                                                permiteCadastro: false,
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (objetoJsonRetorno != null) {
                                        if (objetoJsonRetorno['nome'] != null) {
                                          importaTaxaEntregaController.text = objetoJsonRetorno['nome'];
                                          _delivery = _delivery!.copyWith(
                                            idTaxaEntrega: objetoJsonRetorno['id'],
                                            valorFrete: objetoJsonRetorno['valor'],
                                          );
                                          // widget.deliveryMontado!.taxaEntrega = widget.deliveryMontado!.taxaEntrega!.copyWith(
                                          //   nome: _objetoJsonRetorno['nome'],
                                          // );
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
                                  child: SizedBox(
                                    child: TextFormField(
                                      controller: importaColaboradorController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe o Colaborador Vinculado',
                                        'Colaborador *',
                                        false),
                                      onSaved: (String? value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      onChanged: (text) {
                                        // delivery?.colaborador?.pessoa?.nome = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Colaborador',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic>? objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupLocalPage(
                                                title: 'Importar Colaborador',
                                                colunas: ColaboradorDao.colunas,
                                                campos: ColaboradorDao.campos,
                                                campoPesquisaPadrao: 'Nome',
                                                valorPesquisaPadrao: '%',
                                                metodoConsultaCallBack: _filtrarColaboradorLookup,                                             
                                                permiteCadastro: false,
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (objetoJsonRetorno != null) {
                                        if (objetoJsonRetorno['nome'] != null) {
                                          importaColaboradorController.text = objetoJsonRetorno['nome'];
                                          _delivery = _delivery!.copyWith(
                                            idColaborador: objetoJsonRetorno['id'],
                                          );
                                          // widget.deliveryMontado!.colaborador = widget.deliveryMontado!.colaborador!.copyWith(
                                          //   nome: _objetoJsonRetorno['nome'],
                                          // );
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
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: _delivery?.cep ?? '',
                              decoration: getInputDecoration(
                                'Informe o CEP',
                                'CEP',
                                false),
                              onSaved: (String? value) {
                              },
                              validator: ValidaCampoFormulario.validarAlfanumerico,
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(cep: text);
                                _formFoiAlterado = true;
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
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: _delivery?.cep ?? '',
                              decoration: getInputDecoration(
                                'Informe a UF',
                                'UF',
                                false),
                              onSaved: (String? value) {
                              },
                              validator: ValidaCampoFormulario.validarAlfanumerico,
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(uf: text);
                                _formFoiAlterado = true;
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
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: _delivery?.nomeCliente ?? '',
                              decoration: getInputDecoration(
                                'Informe o Nome do Cliente',
                                'Nome Cliente',
                                false),
                              onSaved: (String? value) {
                              },
                              validator: ValidaCampoFormulario.validarAlfanumerico,
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(nomeCliente: text);
                                _formFoiAlterado = true;
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
                              keyboardType: TextInputType.number,
                              controller: telefonePrincipalController,
                              decoration: getInputDecoration(
                                'Informe o Telefone Principal',
                                'Telefone Principal',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(telefonePrincipal: text);
                                _formFoiAlterado = true;
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
                              keyboardType: TextInputType.number,
                              controller: telefoneRecadoController,
                              decoration: getInputDecoration(
                                'Informe o Telefone Recado',
                                'Telefone Recado',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(telefoneRecado: text);
                                _formFoiAlterado = true;
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
                              keyboardType: TextInputType.number,
                              controller: celularController,
                              decoration: getInputDecoration(
                                'Informe o Celular',
                                'Celular',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(celular: text);
                                _formFoiAlterado = true;
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
                              initialValue: _delivery?.logradouro ?? '',
                              decoration: getInputDecoration(
                                'Informe o Logradouro',
                                'Logradouro',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(logradouro: text);
                                _formFoiAlterado = true;
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
                              maxLength: 10,
                              maxLines: 1,
                              initialValue: _delivery?.numero ?? '',
                              decoration: getInputDecoration(
                                'Informe o Número',
                                'Número',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(numero: text);
                                _formFoiAlterado = true;
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
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: _delivery?.complemento ?? '',
                              decoration: getInputDecoration(
                                'Informe o Complemento',
                                'Complemento',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(complemento: text);
                                _formFoiAlterado = true;
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
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: _delivery?.bairro ?? '',
                              decoration: getInputDecoration(
                                'Informe o Bairro',
                                'Bairro',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(bairro: text);
                                _formFoiAlterado = true;
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
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: _delivery?.cidade ?? '',
                              decoration: getInputDecoration(
                                'Informe o Município',
                                'Município',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(cidade: text);
                                _formFoiAlterado = true;
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
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              controller: valorFreteController,
                              decoration: getInputDecoration(
                                'Informe o Valor do Frete',
                                'Valor Frete',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(valorFrete: valorFreteController.numberValue);
                                _formFoiAlterado = true;
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
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              controller: valorRecebidoController,
                              decoration: getInputDecoration(
                                'Informe o Valor do Recebido',
                                'Valor Recebido',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(valorRecebido: valorRecebidoController.numberValue);
                                _formFoiAlterado = true;
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
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.end,
                              controller: valorSolicitadoTrocoController,
                              decoration: getInputDecoration(
                                'Informe o Valor do Solicitado Troco',
                                'Valor Solicitado Troco',
                                false),
                              onSaved: (String? value) {
                              },
                              onChanged: (text) {
                                _delivery = _delivery!.copyWith(valorSolicitadoTroco: valorSolicitadoTrocoController.numberValue);
                                _formFoiAlterado = true;
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
                            child: InputDecorator(
                              decoration: getInputDecoration(
                                'Informe a Previsão Preparo',
                                'Previsão Preparo',
                                true),
                              isEmpty: _delivery!.previsaoPreparo == null,
                              child: DatePickerItem(
                                mascara: 'dd/MM/yyyy',
                                dateTime: _delivery!.previsaoPreparo,
                                firstDate: DateTime.parse('1900-01-01'),
                                lastDate: DateTime.now(),
                                onChanged: (DateTime? value) {
                                    _formFoiAlterado = true;
                                    setState(() {
                                      _delivery = _delivery!.copyWith(previsaoPreparo: value);
                                  });
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
                            child: InputDecorator(
                              decoration: getInputDecoration(
                                'Informe a Início Preparo',
                                'Início Preparo',
                                true),
                              isEmpty: _delivery!.inicioPreparo == null,
                              child: DatePickerItem(
                                mascara: 'dd/MM/yyyy',
                                dateTime: _delivery!.inicioPreparo,
                                firstDate: DateTime.parse('1900-01-01'),
                                lastDate: DateTime.now(),
                                onChanged: (DateTime? value) {
                                    _formFoiAlterado = true;
                                    setState(() {
                                      _delivery = _delivery!.copyWith(inicioPreparo: value);
                                  });
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
                            child: InputDecorator(
                              decoration: getInputDecoration(
                                'Informe a Previsão Entrega',
                                'Previsão Entrega',
                                true),
                              isEmpty: _delivery!.previsaoEntrega == null,
                              child: DatePickerItem(
                                mascara: 'dd/MM/yyyy',
                                dateTime: _delivery!.previsaoEntrega,
                                firstDate: DateTime.parse('1900-01-01'),
                                lastDate: DateTime.now(),
                                onChanged: (DateTime? value) {
                                    _formFoiAlterado = true;
                                    setState(() {
                                      _delivery = _delivery!.copyWith(previsaoEntrega: value);
                                  });
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
                            child: InputDecorator(
                              decoration: getInputDecoration(
                                'Informe a Saiu para Entrega',
                                'Saiu para Entrega',
                                true),
                              isEmpty: _delivery!.saiuParaEntrega == null,
                              child: DatePickerItem(
                                mascara: 'dd/MM/yyyy',
                                dateTime: _delivery!.saiuParaEntrega,
                                firstDate: DateTime.parse('1900-01-01'),
                                lastDate: DateTime.now(),
                                onChanged: (DateTime? value) {
                                    _formFoiAlterado = true;
                                    setState(() {
                                      _delivery = _delivery!.copyWith(saiuParaEntrega: value);
                                  });
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
                            child: InputDecorator(
                              decoration: getInputDecoration(
                                'Informe a Entregue',
                                'Entregue',
                                true),
                              isEmpty: _delivery!.entregue == null,
                              child: DatePickerItem(
                                mascara: 'dd/MM/yyyy',
                                dateTime: _delivery!.entregue,
                                firstDate: DateTime.parse('1900-01-01'),
                                lastDate: DateTime.now(),
                                onChanged: (DateTime? value) {
                                    _formFoiAlterado = true;
                                    setState(() {
                                      _delivery = _delivery!.copyWith(entregue: value);
                                  });
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
                            child: InputDecorator(
                              decoration: getInputDecoration(
                                'Informe a Pronto para Retirada',
                                'Pronto para Retirada',
                                true),
                              isEmpty: _delivery!.prontoParaRetirada == null,
                              child: DatePickerItem(
                                mascara: 'dd/MM/yyyy',
                                dateTime: _delivery!.prontoParaRetirada,
                                firstDate: DateTime.parse('1900-01-01'),
                                lastDate: DateTime.now(),
                                onChanged: (DateTime? value) {
                                    _formFoiAlterado = true;
                                    setState(() {
                                      _delivery = _delivery!.copyWith(prontoParaRetirada: value);
                                  });
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
                            child: InputDecorator(
                              decoration: getInputDecoration(
                                'Informe a Retirou',
                                'Retirou',
                                true),
                              isEmpty: _delivery!.retirou == null,
                              child: DatePickerItem(
                                mascara: 'dd/MM/yyyy',
                                dateTime: _delivery!.retirou,
                                firstDate: DateTime.parse('1900-01-01'),
                                lastDate: DateTime.now(),
                                onChanged: (DateTime? value) {
                                    _formFoiAlterado = true;
                                    setState(() {
                                      _delivery = _delivery!.copyWith(retirou: value);
                                  });
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

  void _filtrarTaxaEntregaLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.taxaEntregaDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _filtrarColaboradorLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.colaboradorDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  Future<void> _salvar() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
    } else {
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        form.save();
        if (widget.operacao == 'A') {
          await Sessao.db.deliveryDao.alterar(_delivery!);
        } else {
          await Sessao.db.deliveryDao.inserir(_delivery!);
        }
        if (!mounted) return;
        Navigator.of(context).pop();
        showInSnackBar("Registro salvo com sucesso!", context, corFundo: Colors.green);
      });
    }
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
  
  void _excluir() {
    gerarDialogBoxExclusao(context, () async {
      await Sessao.db.deliveryDao.excluir(_delivery!);
      if (!mounted) return;
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context, corFundo: Colors.green);
    });
  }  
}