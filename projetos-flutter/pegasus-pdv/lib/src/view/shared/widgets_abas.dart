/*
Title: T2Ti ERP 3.0                                                                
Description: Armazena os widgets das páginas com abas.
                                                                                
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

import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';


/// Utilizado para saber se algo foi alterado em qualquer uma das páginas de detalhe
/// para avisar ao usuário que dados serão perdidos caso ele saia da tela/página.
bool paginaMestreDetalheFoiAlterada;

/// Retorna o ShapeDecoration para a página de abas
ShapeDecoration getShapeDecorationAbaPage(String estiloBotoesAba) {
  switch (estiloBotoesAba) {
    case 'iconsAndText':
      return ShapeDecoration(
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              side: BorderSide(
                color: Colors.white24,
                width: 2.0,
              ),
            ) +
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              side: BorderSide(
                color: Colors.transparent,
                width: 4.0,
              ),
            ),
      );

    case 'iconsOnly':
      return ShapeDecoration(
        shape: const CircleBorder(
              side: BorderSide(
                color: Colors.white24,
                width: 4.0,
              ),
            ) +
            const CircleBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 4.0,
              ),
            ),
      );

    case 'textOnly':
      return ShapeDecoration(
        shape: const StadiumBorder(
              side: BorderSide(
                color: Colors.white24,
                width: 2.0,
              ),
            ) +
            const StadiumBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 4.0,
              ),
            ),
      );

    default:
      return null;
  }
}

/// Retorna o Scaffold da página de Abas - Página mestre/detalhe
WillPopScope getScaffoldAbaPage(
    String title,
    BuildContext context,
    TabController controllerAbas,
    List<Aba> abasAtivas,
    Decoration indicatorTabBar,
    String estiloBotoesAba,
    Function onPressedIconButton,
    Function(String) onSelectedPopupMenuButton,   
    Future<bool> Function() onWillPop,
    {bool comBotaoExclusao = false, Function excluir, List<Widget> botoesPersonalizados}
    ) {
  return WillPopScope(
    onWillPop: onWillPop,
    child: Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: (botoesPersonalizados != null)
                 ? botoesPersonalizados
                 : comBotaoExclusao 
                    ? _getBotoesAppBarComExclusao(context, onPressedIconButton, onSelectedPopupMenuButton, excluir)
                    : _getBotoesAppBar(context, onPressedIconButton, onSelectedPopupMenuButton),
        bottom: TabBar(
          controller: controllerAbas,
          isScrollable: true,
          indicator: indicatorTabBar,
          tabs: abasAtivas.map<Tab>((Aba aba) {
            switch (estiloBotoesAba) {
              case 'iconsAndText':
                return Tab(text: aba.text, icon: Icon(aba.icon));
              case 'iconsOnly':
                return Tab(icon: Icon(aba.icon));
              case 'textOnly':
                return Tab(text: aba.text);
            }
            return null;
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: controllerAbas,
        children: abasAtivas.map<Widget>((Aba aba) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Container(
              key: ObjectKey(aba.icon),
              padding: const EdgeInsets.all(0.0), //12.0
              child: aba.pagina == null
                ? Card(
                    child: Center(
                      child: Icon(
                        aba.icon,
                        color: Theme.of(context).accentColor,
                        size: 128.0,
                      ),
                    ),
                  )
                : aba.pagina,
            ),
          );
        }).toList(),
      ),
    ),
  );
}

List<Widget> _getBotoesAppBar(BuildContext context, Function() onPressedBotaoSalvar, Function(String) onSelectedPopupMenuButton) {
  if (Biblioteca.isTelaPequena(context)) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,                
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
      _getPopupMenu(onSelectedPopupMenuButton),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
      _getPopupMenu(onSelectedPopupMenuButton),
    ];
  }
}

List<Widget> _getBotoesAppBarComExclusao(
  BuildContext context, Function() onPressedBotaoSalvar, Function(String) onSelectedPopupMenuButton, Function excluir) {
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
        onPressed: onPressedBotaoSalvar,
      ),
      _getPopupMenu(onSelectedPopupMenuButton),
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
        onPressed: onPressedBotaoSalvar,
      ),
      _getPopupMenu(onSelectedPopupMenuButton),
    ];
  }
}

PopupMenuButton<String> _getPopupMenu(Function(String) onSelectedPopupMenuButton) {
  return PopupMenuButton<String> (
    onSelected: onSelectedPopupMenuButton,
    itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
      const PopupMenuItem<String>(
        value: 'iconsAndText',
        child: Text('Ícones e Texto'),
      ),
      const PopupMenuItem<String>(
        value: 'iconsOnly',
        child: Text('Apenas Ícones'),
      ),
      const PopupMenuItem<String>(
        value: 'textOnly',
        child: Text('Apenas Texto'),
      ),
    ],
  );
}

/// Classe usada para montar a aba nas páginas mestre/detalhe
class Aba {
  Aba({this.icon, this.text, this.visible, this.pagina});
  IconData icon;
  String text;
  bool visible;
  Widget pagina;
}