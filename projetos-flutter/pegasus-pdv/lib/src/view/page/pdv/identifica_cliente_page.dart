/*
Title: T2Ti ERP 3.0                                                                
Description: Caixa - Página que serve para identificar o cliente pelo 
CPF (pelo menos) e nome (opcional), podendo também pesquisar pelo cliente
                                                                                
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

Based on: Flutter UI Challenges by Many - https://github.com/lohanidamodar/flutter_ui_challenges
*******************************************************************************/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class IdentificaClientePage extends StatefulWidget {
  final String title;
  
  const IdentificaClientePage({Key key, this.title}): super(key: key);

  @override
  _IdentificaClientePageState createState() => _IdentificaClientePageState();
}

class _IdentificaClientePageState extends State<IdentificaClientePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.always;

  final _cpfController = MaskedTextController(
    mask: Constantes.mascaraCPF,
    text: Sessao.vendaAtual.cpfCnpjCliente ?? '',
  );
  final _importaClienteController = TextEditingController();

  var _subtitulo = 'Informe o CPF e o nome do cliente (opcional) ou importe um cliente cadastrado';
  final _valorFoco = FocusNode();

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosCaixa();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
    _valorFoco.requestFocus();        
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.cancelar:
        Navigator.pop(context);
        break;
      case AtalhoTelaType.confirmar:
        _efetuarOperacao();
        break;
      case AtalhoTelaType.escape:
        Navigator.pop(context);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _importaClienteController.text = Sessao.vendaAtual.nomeCliente ?? '';

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade600]),
                ),
              ),
              ListView.builder(
                itemCount: 3,
                itemBuilder: _mainListBuilder,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return cabecalhoTela(context);
    // if (index == 1) return dadosFechamento(context);
    if (index == 1) return conteudoTela(context);
    return null;
  }
  
  Container cabecalhoTela(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(                
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      _subtitulo,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage(Constantes.opcoesGerenteIcon),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Container conteudoTela(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: ValidaCampoFormulario.validarObrigatorioCPF,
                        focusNode: _valorFoco,                      
                        maxLength: 14,
                        keyboardType: TextInputType.number,
                        controller: _cpfController,
                        decoration: getInputDecoration(
                          'Conteúdo para o campo CPF',
                          'CPF',
                          true,
                          paddingVertical: 15),
                        onChanged: (text) {
                        },
                        onFieldSubmitted: (value) {
                          _efetuarOperacao();
                        },
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: TextFormField(
                                maxLength: 150,
                                maxLines: 1,
                                controller: _importaClienteController,
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Nome',
                                  'Nome',
                                  true,
                                  paddingVertical: 18),
                                onChanged: (text) {
                                },
                                onFieldSubmitted: (value) {
                                  _efetuarOperacao();
                                },
                              ),                              
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: IconButton(
                              tooltip: 'Importar Cliente',
                              icon: ViewUtilLib.getIconBotaoLookup(),
                              onPressed: () async {
                                Map<String, dynamic> objetoJsonRetorno = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => LookupLocalPage(
                                        title: 'Importar Cliente',
                                        colunas: ClienteDao.colunas,
                                        campos: ClienteDao.campos,
                                        campoPesquisaPadrao: 'nome',
                                        valorPesquisaPadrao: '%',
                                        metodoConsultaCallBack: _filtrarClienteLookup,
                                        permiteCadastro: true,
                                        metodoCadastroCallBack: () { Navigator.pushNamed(context, '/clienteLista',); },
                                      ),
                                      fullscreenDialog: true,
                                    ));
                                if (objetoJsonRetorno != null) {
                                  setState(() {
                                    Sessao.vendaAtual = 
                                    Sessao.vendaAtual.copyWith(
                                      idCliente: objetoJsonRetorno['id'],
                                      nomeCliente: objetoJsonRetorno['nome'],
                                      cpfCnpjCliente: objetoJsonRetorno['cpfCnpj'],
                                    );
                                    _importaClienteController.text = objetoJsonRetorno['nome'];
                                    _cpfController.text = objetoJsonRetorno['cpfCnpj'];                                    
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _getBotoesRodape(context: context),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _filtrarClienteLookup(String campo, String valor) async {
    var listaFiltrada = await Sessao.db.clienteDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  List<Widget> _getBotoesRodape({BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
      Container(
        width: Biblioteca.isTelaPequena(context) ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Cancelar' : 'Cancelar [F11]',
          cor: Colors.red, 
          onPressed: () {
            Navigator.pop(context, false);
          }
        ),        
      ),
    );
    listaBotoes.add(
      SizedBox(width: 10.0),
    );
    listaBotoes.add(
      Container(
        width: Biblioteca.isTelaPequena(context) ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Confirmar' : 'Confirmar [F12]',
          cor: Colors.green, 
          onPressed: () {
            _efetuarOperacao();
          }
        ),
      ),
    );
    return listaBotoes;
  }

  void _efetuarOperacao() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
      _valorFoco.requestFocus();
    } else {
      Sessao.vendaAtual = 
      Sessao.vendaAtual.copyWith(
        nomeCliente: _importaClienteController.text,
        cpfCnpjCliente: Biblioteca.removerMascara(_cpfController.text),        
      );
      Navigator.pop(context, true);
    }
  }

}