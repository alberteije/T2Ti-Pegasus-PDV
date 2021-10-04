/*
Title: T2Ti ERP 3.0                                                                
Description: Armazena os botões utilizados pelas páginas/telas.
                                                                                
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';

Widget getBotaoTelaGrande({String texto, Icon icone, Function onPressed}) {
  return 
  Container(
    height: 50,
    padding: const EdgeInsets.all(8.0),
    child:  ElevatedButton.icon(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return Colors.indigo;
          return Colors.black26;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Colors.black54;
        }),
      ),
      label: Text(texto),
      icon: icone,
      onPressed: onPressed,
    ),
  );
}

Widget getBotaoTelaPequena({String tooltip, Icon icone, Function onPressed}) {
  return IconButton(
    focusColor: Colors.indigo,
    tooltip: tooltip,                
    icon: icone,
    onPressed: onPressed,
  );
}

Widget getBotaoFiltro({BuildContext context, Function chamarFiltro}) {
  if (Biblioteca.isTelaPequena(context)) {
    return getBotaoTelaPequena(
        tooltip: Constantes.botaoFiltrarDica,                
        icone: ViewUtilLib.getIconBotaoFiltro(),
        onPressed: chamarFiltro
      );
  } else {
    return getBotaoTelaGrande(
        texto: Constantes.botaoFiltrarDescricao,
        icone: ViewUtilLib.getIconBotaoFiltro(),
        onPressed: chamarFiltro,
      );
  }
}

List<Widget> getBotoesNavigationBarListaPage(
  {BuildContext context, Function chamarFiltro, Function gerarRelatorio}) {
  if (Biblioteca.isTelaPequena(context)) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoFiltrarDica,                
        icone: ViewUtilLib.getIconBotaoFiltro(),
        onPressed: chamarFiltro,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoImprimirDica,                
        icone: ViewUtilLib.getIconBotaoPdf(),
        onPressed: gerarRelatorio,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoFiltrarDescricao,
        icone: ViewUtilLib.getIconBotaoFiltro(),
        onPressed: chamarFiltro,
      ),
      getBotaoTelaGrande(
        texto: Constantes.botaoImprimirDescricao,                
        icone: ViewUtilLib.getIconBotaoPdf(),
        onPressed: gerarRelatorio,
      ),
    ];
  }
}

List<Widget> getBotoesAppBarDetalhePage(
  {BuildContext context, Function excluir, Function alterar}) {
  if (Biblioteca.isTelaPequena(context)) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoExcluirDica,                
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoAlterarDica,                
        icone: ViewUtilLib.getIconBotaoAlterar(),
        onPressed: alterar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoExcluirDescricao,
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaGrande(
        texto: Constantes.botaoAlterarDescricao,                
        icone: ViewUtilLib.getIconBotaoAlterar(),
        onPressed: alterar,
      ),
    ];
  }
}

List<Widget> getBotoesAppBarPersistePage(
  {BuildContext context, Function salvar}) {
  if (Biblioteca.isTelaPequena(context)) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,                
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  }
}

List<Widget> getBotoesAppBarPersistePageComExclusao(
  {BuildContext context, Function salvar, Function excluir}) {
  if (Biblioteca.isTelaPequena(context)) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoExcluirDica,                
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,                
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoExcluirDescricao,
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaGrande(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: salvar,
      ),
    ];
  }
}

MaterialButton getBotaoInternoCaixa(
  {String texto, IconData icone, double tamanhoIcone, Color corBotao, double paddingAll, double height, double minWidth, Function onPressed}) {
    return MaterialButton(
      height: height ?? 70.0,
      padding: EdgeInsets.all(paddingAll),
      textColor: Colors.white,
      minWidth: minWidth ?? 80,          
      child: Column(
        children: <Widget>[
          FaIcon(icone, size: tamanhoIcone),
          Text(
            texto,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      color: corBotao,
      elevation: 0,
      onPressed: onPressed,
    );
}

InkWell getBotaoIncrementaCaixa({Function incrementar}) {
  return InkWell(
    onTap: incrementar,
    splashColor: Colors.lightBlue,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          Icons.add,
          color: Colors.green,
          size: 20,
        ),
      ),
    ),
  );
}

InkWell getBotaoDecrementaCaixa({Function decrementar}) {
  return InkWell(
    onTap: decrementar,
    splashColor: Colors.redAccent.shade200,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          Icons.remove,
          color: Colors.redAccent,
          size: 20,                                  
        ),
      ),
    ),
  );
}

ElevatedButton getBotaoGenericoPdv({String descricao, Color cor, Function onPressed, EdgeInsetsGeometry padding, Size tamanho}) {
  return ElevatedButton(
    child: Text(descricao),
    style: ElevatedButton.styleFrom(
      fixedSize: tamanho,
      elevation: 2,
      primary: cor, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      padding: padding,
    ),
    onPressed: onPressed,
  );
}