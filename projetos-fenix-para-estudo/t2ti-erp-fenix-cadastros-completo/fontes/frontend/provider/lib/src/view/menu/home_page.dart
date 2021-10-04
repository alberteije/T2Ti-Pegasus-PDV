/*
Title: T2Ti ERP Fenix                                                                
Description: Menu principal da aplicação - Menu Externo - Área de Trabalho
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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

Based on: Flutter UIKit by Pawan Kumar - https://github.com/iampawan/Flutter-UI-Kit
*******************************************************************************/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fenix/src/model/menu/menu.dart';
import 'package:fenix/src/view_model/menu/menu_view_model.dart';
import 'package:fenix/src/infra/constantes.dart';

class HomePage extends StatelessWidget {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return homeScaffold(context);
  }

  // scaffold principal
  Widget homeScaffold(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Scaffold(key: _scaffoldState, body: bodySliverList(context)),
      );

  Widget bodySliverList(BuildContext context) {
    MenuViewModel menuViewModel = MenuViewModel();
    return StreamBuilder<List<Menu>>(
        stream: menuViewModel.menuItemsStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? CustomScrollView(
                  slivers: <Widget>[
                    appBar(),
                    bodyGrid(context, snapshot.data),
                  ],
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  // appbar - menu principal
  Widget appBar() => SliverAppBar(
        backgroundColor: Colors.black87,
        pinned: true,
        elevation: 10.0,
        forceElevated: true,
        expandedHeight:
            150.0, // altura da caixa entre o topo da janela e os itens de menu
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(Constantes.appNameString,
                style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    // sombra atrás da fonte
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 2.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )),
            background: Image.asset(
              // imagem de fundo do menu
              Constantes.t2tiBackgroundImage,
              fit: BoxFit.cover,
            )),
      );

  // bodygrid - grid que contém os itens de menu
  Widget bodyGrid(BuildContext context, List<Menu> menu) => SliverPadding(
      padding: EdgeInsets.all(5.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: definirQuantidadeDeCartoesPorLinha(context),
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return menuStack(context, menu[index]);
        }, childCount: menu.length),
      ));

  int definirQuantidadeDeCartoesPorLinha(BuildContext context) {
    double larguraDaTela = MediaQuery.of(context).size.width;
    int larguraDoCartao = 180;
    int quantidadePorLinha = larguraDaTela ~/ larguraDoCartao;
    return quantidadePorLinha;
  }

  // menuStack - cada item do menu
  Widget menuStack(BuildContext context, Menu menu) => InkWell(
        // https://api.flutter.dev/flutter/material/InkWell-class.html
        canRequestFocus: true,
        hoverColor: Colors.black38,
        onTap: () => abrirSubMenu(context, menu),
        splashColor: Colors
            .black, // cor que será ativada ao redor do botão quando ele for pressionado
        child: Card(
          // https://api.flutter.dev/flutter/material/Card-class.html
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          child: Stack(
            // https://api.flutter.dev/flutter/widgets/Stack-class.html
            fit: StackFit.expand,
            children: <Widget>[
              menuImage(menu),
              menuColor(),
              menuData(menu),
            ],
          ),
        ),
      );

  //stack 1/3 - primeira porção da pilha - a imagem - fica na parte de baixo do Stack
  Widget menuImage(Menu menu) => Image.asset(
        menu.image,
        fit: BoxFit.cover,
      );

  //stack 2/3 - segunda porção da pilha - a cor com a opacidade
  Widget menuColor() => new Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 50.0, // efeito de fumaça
          ),
        ]),
      );

  //stack 3/3 - terceira porção da pilha - ícone e texto
  Widget menuData(Menu menu) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            menu.icon,
            color: Colors.white,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            menu.title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, ),
                textAlign: TextAlign.center,
          )
        ],
      );

  // chama o submenu do módulo selecionado
  void abrirSubMenu(BuildContext context, Menu menu) {
    Navigator.pushNamed(context, "${menu.route}");
  }

}
