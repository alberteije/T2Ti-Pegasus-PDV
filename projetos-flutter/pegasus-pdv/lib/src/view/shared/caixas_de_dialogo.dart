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
import 'package:pegasus_pdv/src/infra/infra.dart';


/// Retorna a dialog box informando que o form foi alterado
Future gerarDialogBoxFormAlterado(BuildContext context, {Function? onOkPressed}) async {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      borderSide: const BorderSide(color: Colors.green, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Alterações não Concluídas',
      desc: 'Deseja fechar o formulário e perder as alterações?',
      showCloseIcon: true,
      btnCancelOnPress: ()  {},
      btnOkOnPress: () async { 
        if (onOkPressed != null) {
          onOkPressed(); 
        }
        Navigator.of(context).pop();
      },
      btnOkText: 'Sim',
      btnCancelText: 'Não',
    ).show();
  } else {
    showDialogDesktop(
      context: context, 
      titulo: 'Alterações não Concluídas', 
      mensagem: 'Deseja fechar o formulário e perder as alterações?', 
      tipo: DialogType.QUESTION, 
      onOkPressed: () async { 
        if (onOkPressed != null) {
          onOkPressed(); 
        }
        Navigator.of(context).pop();
      });
  }
}

/// Retorna um diálogo de exclusão
gerarDialogBoxExclusao(BuildContext context, Function onOkPressed, {String? mensagemPersonalizada}) {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      borderSide: const BorderSide(color: Colors.green, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Exclusão de Registro',
      desc: mensagemPersonalizada ?? 'Deseja excluir esse registro?',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: onOkPressed,
      btnOkText: 'Sim',
      btnCancelText: 'Não',
    ).show();
  } else {
    showDialogDesktop(
      context: context, 
      titulo: 'Exclusão de Registro', 
      mensagem: mensagemPersonalizada ?? 'Deseja excluir esse registro?', 
      tipo: DialogType.QUESTION, 
      onOkPressed: onOkPressed);
  }
} 

/// Retorna um diálogo de informação
gerarDialogBoxInformacao(BuildContext context, String mensagem, {Function? onOkPressed}) {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      borderSide: const BorderSide(color: Colors.green, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Informação do Sistema',
      desc: mensagem,
      showCloseIcon: true,
      btnOkOnPress: onOkPressed ?? () {},
    ).show();
  } else {
    showDialogDesktop(
      context: context, 
      titulo: 'Informação do Sistema', 
      mensagem: mensagem, 
      tipo: DialogType.INFO, 
      onOkPressed: onOkPressed);
  }
}

/// Retorna um diálogo de confirmação
gerarDialogBoxConfirmacao(BuildContext? context, String mensagem, Function onOkPressed, {Function? onCancelPressed}) {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context!,
      dialogType: DialogType.QUESTION,
      borderSide: const BorderSide(color: Colors.green, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Pergunta do Sistema',
      desc: mensagem,
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: onOkPressed,
      btnOkText: 'Sim',
      btnCancelText: 'Não',
    ).show();
  } else {
    showDialogDesktop(
      context: context!, 
      titulo: 'Pergunta do Sistema', 
      mensagem: mensagem, 
      tipo: DialogType.QUESTION, 
      onOkPressed: onOkPressed);
  }
}

/// Retorna um diálogo de informação
gerarDialogBoxErro(BuildContext? context, String mensagem, {Function? onOkPressed}) {
  if (Biblioteca.isMobile()) {
    AwesomeDialog(
      context: context!,
      dialogType: DialogType.ERROR,
      borderSide: const BorderSide(color: Colors.red, width: 2),
      width: 400,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Erro no Sistema',
      desc: mensagem,
      showCloseIcon: true,
      btnOkOnPress: onOkPressed ?? () {},
    ).show();
  } else {
    showDialogDesktop(
      context: context!, 
      titulo: 'Erro no Sistema', 
      mensagem: mensagem, 
      tipo: DialogType.ERROR, 
      onOkPressed: onOkPressed);
  }
}

/// exibe uma caixa de diálogo no desktop com possibilidade de focar os botões
showDialogDesktop({required BuildContext context, String? titulo, String? mensagem, DialogType? tipo, Function? onOkPressed}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _corpoDialogoDesktop(context: context, titulo: titulo!, mensagem: mensagem, tipo: tipo, onOkPressed: onOkPressed),
      );      
    },
  );
}

_corpoDialogoDesktop({BuildContext? context, required String titulo, String? mensagem, DialogType? tipo, Function? onOkPressed}){
  return Stack(
    children: <Widget>[
      Container(
        width: 400,
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
        margin: const EdgeInsets.only(top: 45),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black,offset: Offset(0,10),
            blurRadius: 10
            ),
          ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(titulo, style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
            const Divider(thickness: 1,),
            const SizedBox(height: 15,),
            tipo == DialogType.ERROR            
            ? 
              SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                    child: Text(mensagem!, style: const TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                ),
              )
            :            
              Text(mensagem!, style: const TextStyle(fontSize: 14),textAlign: TextAlign.center,),
            const SizedBox(height: 22,),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getBotoesRodapeDialogoDesktop(context: context, tipo: tipo, onOkPressed: onOkPressed),
                    ),
                  ],
                ),
              ),
            ),
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
              borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: _definirImagemDialogo(tipo),
            ),
          ),
      ),
    ],
  );
}

Widget _definirImagemDialogo(DialogType? tipo) {
  switch (tipo) {
    case DialogType.QUESTION :
      return Image.asset(Constantes.dialogQuestionIcon);
    case DialogType.INFO :
      return Image.asset(Constantes.dialogInfoIcon);
    case DialogType.ERROR :
      return Image.asset(Constantes.dialogErrorIcon);
    default:
      return Image.asset(Constantes.dialogInfoIcon);
  }
}

List<Widget> _getBotoesRodapeDialogoDesktop({BuildContext? context, DialogType? tipo, Function? onOkPressed}) {
  List<Widget> listaBotoes = [];

  if (tipo == DialogType.INFO || tipo == DialogType.ERROR) {
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context!)! ? 130 : 150,
        child: TextButton(
          autofocus: true,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent.withOpacity(0.3)),
          ),
          child: const Text('OK'),
          onPressed: onOkPressed as void Function()? ?? () { Navigator.pop(context); },
        ),              
      ),
    );
  } else {
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context!)! ? 130 : 150,
        child: TextButton(
          autofocus: true,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent.withOpacity(0.3)),
          ),
          child: const Text('Sim'),
          onPressed: onOkPressed == null ? () { Navigator.pop(context); } : () { Navigator.pop(context); onOkPressed.call(); },
        ),             
      ),
    );
    listaBotoes.add(
      const SizedBox(width: 10.0),
    );
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context)! ? 130 : 150,
        child: TextButton(
          autofocus: true,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent.withOpacity(0.3)),
          ),
          child: const Text('Não'),
          onPressed: () {
              Navigator.of(context).pop();
            },
        ),             
      ),
    );
  }
  return listaBotoes;
}

/// Mostra uma snackbar com uma mensagem
showInSnackBar(String value, BuildContext context, {Color? corFundo}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(value),
    backgroundColor: corFundo ?? Colors.red,
  ));
}

gerarDialogBoxEspera(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  );
}
