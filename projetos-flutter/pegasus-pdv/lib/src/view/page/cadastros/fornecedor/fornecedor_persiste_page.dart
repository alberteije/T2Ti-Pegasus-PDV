/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [FORNECEDOR] 
                                                                                
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

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/dropdown_lista.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';


class FornecedorPersistePage extends StatefulWidget {
  final Fornecedor fornecedor;
  final String title;
  final String operacao;

  const FornecedorPersistePage({Key key, this.fornecedor, this.title, this.operacao})
      : super(key: key);

  @override
  _FornecedorPersistePageState createState() => _FornecedorPersistePageState();
}

class _FornecedorPersistePageState extends State<FornecedorPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;
  final _foco = FocusNode();

  Fornecedor fornecedor;

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
    fornecedor = widget.fornecedor;
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

    final _telefoneController = MaskedTextController(
      mask: Constantes.mascaraTELEFONE,
      text: fornecedor?.telefone ?? '',
    );
    final _celularController = MaskedTextController(
      mask: Constantes.mascaraTELEFONE,
      text: fornecedor?.celular ?? '',
    );
    final _cepController = MaskedTextController(
      mask: Constantes.mascaraCEP,
      text: fornecedor?.cep ?? '',
    );
    final _cpfController = MaskedTextController(
      mask: Constantes.mascaraCPF,
      text: fornecedor?.cpfCnpj?? '',
    );
    final _cnpjController = MaskedTextController(
      mask: Constantes.mascaraCNPJ,
      text: fornecedor?.cpfCnpj ?? '',
    );

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
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: InputDecorator(
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Tipo Pessoa',
                                  'Tipo Pessoa',
                                  true),
                                isEmpty: fornecedor.tipoPessoa == null,
                                child: getDropDownButton(fornecedor.tipoPessoa,
                                  (String newValue) {
                                    setState(() {
                                      fornecedor = fornecedor.copyWith(tipoPessoa: newValue);
                                    });
                                }, <String>[
                                  'Física',
                                  'Jurídica',
                                  ],
                                  validator: ValidaCampoFormulario.validarObrigatorio,
                                ),
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-8',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                focusNode: _foco,
                                validator: ValidaCampoFormulario.validarObrigatorio,
                                maxLength: 150,
                                maxLines: 1,
                                initialValue: fornecedor?.nome ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Nome',
                                  'Nome',
                                  true,
                                  paddingVertical: 18),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(nome: text);
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: fornecedor?.tipoPessoa == 'Jurídica',
                        child: Divider(color: Colors.white,),
                      ),
                      Visibility(
                        visible: fornecedor?.tipoPessoa == 'Jurídica',
                        child: BootstrapRow(                          
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(                              
                              sizes: 'col-12',
                              child: TextFormField(
                                maxLength: 150,
                                maxLines: 1,
                                initialValue: fornecedor?.fantasia ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Fantasia',
                                  'Fantasia',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(fantasia: text);
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
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                validator: ValidaCampoFormulario.validarEmail,
                                maxLength: 250,
                                maxLines: 3,
                                initialValue: fornecedor?.email ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Email',
                                  'Email',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(email: text);
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 250,
                                maxLines: 3,
                                initialValue: fornecedor?.url ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Url',
                                  'Url',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(url: text);
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
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: fornecedor?.tipoPessoa == 'Física' ? 14 : 18,
                                keyboardType: TextInputType.number,
                                controller: fornecedor?.tipoPessoa == 'Física' ? _cpfController : _cnpjController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Cpf Cnpj',
                                  'Cpf / Cnpj',
                                  true,
                                  paddingVertical: 15),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(cpfCnpj: Biblioteca.removerMascara(text));
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: InputDecorator(
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Data Cadastro',
                                  'Data Cadastro',
                                  true),
                                isEmpty: fornecedor.dataCadastro == null,
                                child: DatePickerItem(
                                  mascara: 'dd/MM/yyyy',
                                  dateTime: fornecedor.dataCadastro,
                                  firstDate: DateTime.parse('1900-01-01'),
                                  lastDate: DateTime.now(),
                                  onChanged: (DateTime value) {
                                    setState(() {
                                      fornecedor = fornecedor.copyWith(dataCadastro: value);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: fornecedor?.tipoPessoa == 'Física',
                        child: Divider(color: Colors.white,),
                      ),
                      Visibility(
                        visible: fornecedor?.tipoPessoa == 'Física',
                        child: BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12 col-md-6',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: InputDecorator(
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Sexo',
                                    'Sexo',
                                    true),
                                  isEmpty: fornecedor.sexo == null,
                                  child: getDropDownButton(fornecedor.sexo,
                                    (String newValue) {
                                      setState(() {
                                        fornecedor = fornecedor.copyWith(sexo: newValue);
                                      });
                                  }, <String>[
                                    'M',
                                    'F',
                                ])),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-12 col-md-6',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: TextFormField(
                                  maxLength: 20,
                                  maxLines: 1,
                                  initialValue: fornecedor?.rg ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Rg',
                                    'Rg',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    fornecedor = fornecedor.copyWith(rg: text);
                                    _formFoiAlterado = true;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: fornecedor?.tipoPessoa == 'Física',
                        child: Divider(color: Colors.white,),
                      ),
                      Visibility(
                        visible: fornecedor?.tipoPessoa == 'Física',
                          child: BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12 col-md-6',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: TextFormField(
                                  maxLength: 20,
                                  maxLines: 1,
                                  initialValue: fornecedor?.orgaoRg ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Orgao Rg',
                                    'Orgao Rg',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    fornecedor = fornecedor.copyWith(orgaoRg: text);
                                    _formFoiAlterado = true;
                                  },
                                ),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-12 col-md-6',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: InputDecorator(
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Data Emissao Rg',
                                    'Data Emissao Rg',
                                    true),
                                  isEmpty: fornecedor.dataEmissaoRg == null,
                                  child: DatePickerItem(
                                    mascara: 'dd/MM/yyyy',
                                    dateTime: fornecedor.dataEmissaoRg,
                                    firstDate: DateTime.parse('1900-01-01'),
                                    lastDate: DateTime.now(),
                                    onChanged: (DateTime value) {
                                      setState(() {
                                        fornecedor = fornecedor.copyWith(dataEmissaoRg: value);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: fornecedor?.tipoPessoa == 'Jurídica',
                        child: Divider(color: Colors.white,),
                      ),
                      Visibility(
                        visible: fornecedor?.tipoPessoa == 'Jurídica',
                        child: BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12 col-md-6',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: TextFormField(
                                  maxLength: 30,
                                  maxLines: 1,
                                  initialValue: fornecedor?.inscricaoEstadual ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Inscricao Estadual',
                                    'Inscricao Estadual',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    fornecedor = fornecedor.copyWith(inscricaoEstadual: text);
                                    _formFoiAlterado = true;
                                  },
                                ),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-12 col-md-6',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: TextFormField(
                                  maxLength: 30,
                                  maxLines: 1,
                                  initialValue: fornecedor?.inscricaoMunicipal ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Inscricao Municipal',
                                    'Inscricao Municipal',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    fornecedor = fornecedor.copyWith(inscricaoMunicipal: text);
                                    _formFoiAlterado = true;
                                  },
                                ),
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
                              maxLength: 250,
                              maxLines: 3,
                              initialValue: fornecedor?.logradouro ?? '',
                              decoration: getInputDecoration(
                                'Conteúdo para o campo Logradouro',
                                'Logradouro',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                fornecedor = fornecedor.copyWith(logradouro: text);
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
                              child: InputDecorator(
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Uf',
                                  'Uf',
                                  true),
                                isEmpty: fornecedor?.uf == null,
                                child: getDropDownButton(fornecedor.uf,
                                  (String newValue) {
                                setState(() {
                                  fornecedor = fornecedor.copyWith(uf: newValue);
                                });
                                }, DropdownLista.listaUF)),                                                      
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 9,
                                keyboardType: TextInputType.number,
                                controller: _cepController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Cep',
                                  'Cep',
                                  true,
                                  paddingVertical: 18),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(cep: Biblioteca.removerMascara(text));
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 10,
                                maxLines: 1,
                                initialValue: fornecedor?.numero ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Numero',
                                  'Numero',
                                  true,
                                  paddingVertical: 18),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(numero: text);
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
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: fornecedor?.complemento ?? '',
                              decoration: getInputDecoration(
                                'Conteúdo para o campo Complemento',
                                'Complemento',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                fornecedor = fornecedor.copyWith(complemento: text);
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
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 100,
                                maxLines: 1,
                                initialValue: fornecedor?.bairro ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Bairro',
                                  'Bairro',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(bairro: text);
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 100,
                                maxLines: 1,
                                initialValue: fornecedor?.cidade ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Cidade',
                                  'Cidade',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(cidade: text);
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
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 14,
                                keyboardType: TextInputType.number,
                                controller: _telefoneController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Telefone',
                                  'Telefone',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(telefone: Biblioteca.removerMascara(text));
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 14,
                                keyboardType: TextInputType.number,
                                controller: _celularController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Celular',
                                  'Celular',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  fornecedor = fornecedor.copyWith(celular: Biblioteca.removerMascara(text));
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
                              maxLength: 50,
                              maxLines: 1,
                              initialValue: fornecedor?.contato ?? '',
                              decoration: getInputDecoration(
                                'Conteúdo para o campo Contato',
                                'Contato',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                fornecedor = fornecedor.copyWith(contato: text);
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

  Future<void> _salvar() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
    } else {
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        form.save();
        if (widget.operacao == 'A') {
          Sessao.db.fornecedorDao.alterar(fornecedor);
        } else {
          Sessao.db.fornecedorDao.inserir(fornecedor);
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
      await Sessao.db.fornecedorDao.excluir(widget.fornecedor);
      Navigator.of(context).pop();
    });
  }  

}