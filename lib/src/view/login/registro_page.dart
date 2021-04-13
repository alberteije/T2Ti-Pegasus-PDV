/*
Title: T2Ti ERP 3.0                                                                
Description: Página de registro do usuário
                                                                                
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

class RegistroPage extends StatefulWidget {
  final String title;
  
  const RegistroPage({Key key, this.title}): super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _emailController = TextEditingController(text: Sessao.empresa.email ?? '');
  final _whatsappController = MaskedTextController(
    mask: Constantes.mascaraTELEFONE,
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final _valorFoco = FocusNode();

  String _textoInformativo = 'Informe seus dados abaixo para continuar usando a aplicação. Nenhum valor será cobrado, apenas '
                             'armazenaremos seus dados para lhe enviar informações valiosas sobre as novidades da T2Ti.';

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),        
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }
  
  contentBox(context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      child: Stack(
        children: <Widget>[
          Container(
            width: 500,
            padding: EdgeInsets.only(left: 20, top: 55, right: 20, bottom: 10),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0, 10), blurRadius: 10),
              ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                cabecalhoTela(context),
                conteudoTela(context),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Image.asset(Constantes.profileImage)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container cabecalhoTela(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
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
                    padding: EdgeInsets.all(20),
                    child: Text(_textoInformativo),                
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
    );
  }

  Container conteudoTela(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
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
      Usuario usuario = Usuario(
        email: _emailController.text,
        whatsapp: _whatsappController.text,
        pendente: 'S',
        news: 'S',
      );
      // chama o método registrar e observa o que acontece
      usuario = await servico.registrar(usuario);
      // se continua pendente, pede para o usuário confirmar o e-mail que recebeu
      if (usuario != null) {
        if (usuario.pendente == 'S') {
          setState(() {
            _textoInformativo = 'Confirme seus dados no e-mail que foi enviado para sua conta. Dessa forma, seu cadastro será concluído.';
          });
        } else {
          // senão, altera a empresa local informando que o usuário foi registrado e fecha a janela
          Sessao.empresa = Sessao.empresa.copyWith(registrado: true);
          await Sessao.db.empresaDao.alterar(Sessao.empresa);
          Navigator.pop(context, true);
        }
      }
    }
  }

}