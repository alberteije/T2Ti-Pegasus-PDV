/*
Title: T2Ti ERP 3.0                                                                
Description: Página de cadastro da configuração para recebimento de informações
sobre NFC-e, MFE e SAT
                                                                                
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
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/model/model.dart';
import 'package:pegasus_pdv/src/service/service.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class ConfiguracaoAbaCadastro extends StatefulWidget {
  final String title;
  final String modulo;
  
  const ConfiguracaoAbaCadastro({Key key, this.title, this.modulo}): super(key: key);

  @override
  _ConfiguracaoAbaCadastroState createState() => _ConfiguracaoAbaCadastroState();
}

class _ConfiguracaoAbaCadastroState extends State<ConfiguracaoAbaCadastro> {
  final _emailController = TextEditingController(text: Sessao.empresa.email ?? '');
  final _whatsappController = MaskedTextController(
    mask: Constantes.mascaraTELEFONE,
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final _valorFoco = FocusNode();

  String _textoInformativo = '';
  String _textoAgradecimento = '';

  @override
  Widget build(BuildContext context) {

    switch (widget.modulo) {
      case 'NFC':
        _textoInformativo = 'Em breve você poderá emitir NFC-e a partir deste sistema. Se quiser receber informações sobre '
                            'a emissão da NFC-e a partir do Pegasus PDV, informe seus dados abaixo.';        
        break;
      case 'SAT':
        _textoInformativo = 'Após a contratação do plano SAT, você poderá configurar os dados do SAT aqui';
        break;
      case 'MFE':
        _textoInformativo = 'Após a contratação do plano MFE (CE), você poderá configurar os dados do MFE aqui';
        break;
      default:
    }

    return Scaffold(
      body: SizedBox.expand(
        child: contentBox(context),
      ),
    );
  }
  
  contentBox(context) {
    return ListView(
      // padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
      children: <Widget>[
        Form(
          key: _formKey,
          autovalidateMode: _autoValidate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              cabecalhoTela(context),
              //conteudoTela(context),              
            ],
          ),
        ),
      ]
    );
  }

  Padding cabecalhoTela(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                child: Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  elevation: 5.0,
                  color: Colors.blueGrey.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(_textoInformativo, textAlign: TextAlign.center,),                
                      ),
                      Visibility(
                        visible: _textoAgradecimento != '',
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            _textoAgradecimento, 
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.red),
                            ),                
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
            ],
          ),
        ),        
    );
  }

  Container conteudoTela(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.yellow.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: ValidaCampoFormulario.validarObrigatorioEmail,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 250,
                      focusNode: _valorFoco,
                      controller: _emailController,
                      decoration: getInputDecoration(
                        'Informe o EMail',
                        'EMail *',
                        false),
                      onSaved: (String value) {
                      },
                      onChanged: (text) {
                      },
                    ),                    
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: _whatsappController,
                      maxLength: 15,
                      decoration: getInputDecoration(
                        'Conteúdo para o campo WhatsApp',
                        'WhatsApp',
                        false),
                      onSaved: (String value) {
                      },
                      onChanged: (text) {
                      },
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
        ],
      ),
    );
  }

  List<Widget> _getBotoesRodape({BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
       Container(
        width: 200,
        child: getBotaoGenericoPdv(
          descricao: 'Confirmar',
          cor: Colors.green, 
          onPressed: () {
            _confirmar();
          }
        ),
      ),
    );
    return listaBotoes;
  }

  void _confirmar() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      _valorFoco.requestFocus();        
    } else {
      UsuarioService servico = UsuarioService();
      // novo usuário
      UsuarioModel usuario = UsuarioModel(
        email: _emailController.text,
        whatsapp: _whatsappController.text,
        modulo: widget.modulo,
        news: 'S',
      );
      // grava o usuário no servidor
      usuario = await servico.gravarDadosInformacao(usuario);
      if (usuario != null) {
        setState(() {
          _textoAgradecimento = 'Obrigado, seu cadastro foi realizado com sucesso. Entraremos em contato quando tivermos novidades.';
        });
      }
    }
  }

}