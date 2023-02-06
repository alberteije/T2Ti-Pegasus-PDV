/*
Title: T2Ti ERP 3.0                                                                
Description: página de apresentação do cardápio digital
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2022 T2Ti.COM                                          
                                                                                
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

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';

class CardapioPage extends StatefulWidget {
  final String? title;

  const CardapioPage({Key? key, this.title})
      : super(key: key);

  @override
  CardapioPageState createState() => CardapioPageState();
}

class CardapioPageState extends State<CardapioPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;
  final _foco = FocusNode();

  // List<ComandaMontado> listaComandaMontado = [];
  List<ProdutoMontado> listaProdutoMontado = [];

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
    _foco.requestFocus();

    WidgetsBinding.instance.addPostFrameCallback((_) => _consultarProdutos());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.excluir:
        break;
      case AtalhoTelaType.salvar:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {	
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        textTheme: Typography.whiteMountainView.apply(fontFamily: 'Roboto Condensed'),
        primaryTextTheme: Typography.whiteMountainView.apply(fontFamily: 'Share Tech Mono'),
      ), 
      child: FocusableActionDetector(
        actions: _actionMap,
        shortcuts: _shortcutMap,
        child: Focus(
          autofocus: true,
          child: Scaffold(
            backgroundColor: Colors.blueGrey[900],
            key: _scaffoldKey,
            bottomNavigationBar: _getBottomNavigationBar(),
            body: _getBodySliverList(),
          ),
        ),
      ),
    );
  }

  Widget _getBottomNavigationBar() {
      return BottomAppBar(
        color: ViewUtilLib.getBottomAppBarColor(),          
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(              
            children: _getItensBottomNavigationBar(),            
          ),
        ),
      );
  }

  List<Widget> _getItensBottomNavigationBar() {
    List<Widget> listaItems = [];
    return listaItems;
  }

  Widget _getBodySliverList() {
    return CustomScrollView(
      slivers: <Widget>[
        appBar(),
        gridComProdutos(),
      ],
    );
  }

  Widget appBar() => SliverAppBar(
    backgroundColor: Colors.black87,
    pinned: true,
    elevation: 10.0,
    forceElevated: true,
    expandedHeight: 80.0, // altura da caixa entre o topo da janela e os itens de mesa
    flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text('Cardápio Digital',
            style: TextStyle(
              color: Colors.amber,
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
          Constantes.comandaBackgroundImage,
          fit: BoxFit.cover,
        )),
  );

  
  Widget gridComProdutos() {
    return SliverPadding(
      padding: const EdgeInsets.all(5.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: definirQuantidadeDeCartoesPorLinha(context),
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return cardapioStack(index);
        }, childCount: listaProdutoMontado.length),
      )
    );
  }

  int definirQuantidadeDeCartoesPorLinha(BuildContext context) {
    double larguraDaTela = MediaQuery.of(context).size.width;
    int larguraDoCartao = 250;
    int quantidadePorLinha = larguraDaTela ~/ larguraDoCartao;
    return quantidadePorLinha;
  }

  Widget cardapioStack(int index) {    
    return InkWell(
      canRequestFocus: true,
      hoverColor: Colors.black38,
      onTap: () async {
        ProdutoController.listaProdutoImagem = await Sessao.db.produtoImagemDao.consultarListaFiltro('ID_PRODUTO', listaProdutoMontado[index].produto!.id.toString());
        if (!mounted) return;
        Navigator.push(
          context, MaterialPageRoute(builder: (_) => CardapioDetalhePage(listaProdutoMontado[index]))
        ).then((value) { });
      },
      splashColor: Colors.black,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            cardapioImage(listaProdutoMontado[index]),
            cardapioColor(),
            cardapioData(listaProdutoMontado[index]),
          ],
        ),
      ),
    );
  }

  //stack 1/3 - primeira porção da pilha - a imagem - fica na parte de baixo do Stack
  Widget cardapioImage(ProdutoMontado produtoMontado) {
    final imagem = produtoMontado.listaProdutoImagem!.isEmpty ? null : produtoMontado.listaProdutoImagem![0].imagem;
    if (imagem == null) {
      return Image.asset(
        Constantes.fundoComandaImage,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      );
    } else {
      return Image.memory(
        produtoMontado.listaProdutoImagem![0].imagem!,
        fit: BoxFit.cover,
      );
    }
  }

  //stack 2/3 - segunda porção da pilha - a cor com a opacidade
  Widget cardapioColor() => Container(
    decoration: BoxDecoration(boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.green.withOpacity(0.3),
        blurRadius: 50.0, // efeito de fumaça
      ),
    ]),
  );

  //stack 3/3 - terceira porção da pilha - ícone e texto
  Widget cardapioData(ProdutoMontado produtoMontado) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // parte de cima
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 120,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(1.0),
                blurRadius: 30.0, // efeito de fumaça
              ),
            ]),          
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(produtoMontado.produto!.nome!, style: const TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),

        // parte de baixo
        Container(
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(1.0),
              blurRadius: 30.0, // efeito de fumaça
            ),
          ]),          
          padding: const EdgeInsets.fromLTRB(8, 2, 15, 20),
          child: Column(
            children: [
              Text('R\$ ${Biblioteca.formatarValorDecimal(produtoMontado.produto!.valorVenda!)}', style: const TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  /// MÉTODOS  
  Future _consultarProdutos() async {
    listaProdutoMontado = 
      (await Sessao.db.produtoDao.consultarListaMontado(
        campo: 'IPPT', 
        valor: 'P', 
      )
    )!;
    // carrega a primeira imagem de cada produto
    for (var produtoMontado in listaProdutoMontado) {
      produtoMontado.listaProdutoImagem = await Sessao.db.produtoImagemDao.consultarListaPrimeiraImagemFiltro('ID_PRODUTO', produtoMontado.produto!.id.toString());
    }
    setState(() {
    });
  }
  
}