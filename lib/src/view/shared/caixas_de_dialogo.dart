/*
Title: T2Ti ERP 3.0                                                                
Description: Armazena as caixas de diálogo que são usadas pelas páginas
                                                                                
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
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

/// Retorna a dialog box informando que o form foi alterado
Future gerarDialogBoxFormAlterado(BuildContext context) async {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.QUESTION,
    borderSide: BorderSide(color: Colors.green, width: 2),
    width: 400,
    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Alterações não Concluídas',
    desc: 'Deseja fechar o formulário e perder as alterações?',
    showCloseIcon: true,
    btnCancelOnPress: ()  {},
    btnOkOnPress: () async { Navigator.of(context).pop(); },
    btnOkText: 'Sim',
    btnCancelText: 'Não',
  )..show();
}

/// Retorna um diálogo de exclusão
gerarDialogBoxExclusao(BuildContext context, Function onOkPressed, {String mensagemPersonalizada}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.QUESTION,
    borderSide: BorderSide(color: Colors.green, width: 2),
    width: 400,
    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Exclusão de Registro',
    desc: mensagemPersonalizada == null ? 'Deseja excluir esse registro?' : mensagemPersonalizada,
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: onOkPressed,
    btnOkText: 'Sim',
    btnCancelText: 'Não',
  )..show();
}

/// Retorna um diálogo de informação
gerarDialogBoxInformacao(BuildContext context, String mensagem, {Function onOkPressed}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.INFO,
    borderSide: BorderSide(color: Colors.green, width: 2),
    width: 400,
    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Informação do Sistema',
    desc: mensagem,
    showCloseIcon: true,
    btnOkOnPress: onOkPressed == null ? () {} : onOkPressed,
  )..show();
}

/// Retorna um diálogo de confirmação
gerarDialogBoxConfirmacao(BuildContext context, String mensagem, Function onOkPressed) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.QUESTION,
    borderSide: BorderSide(color: Colors.green, width: 2),
    width: 400,
    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Pergunta do Sistema',
    desc: mensagem,
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: onOkPressed,
    btnOkText: 'Sim',
    btnCancelText: 'Não',
  )..show();
}

/// Mostra uma snackbar com uma mensagem
showInSnackBar(String value, BuildContext context, {Color corFundo}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(value),
    backgroundColor: corFundo == null ? Colors.red : corFundo,
  ));
}
