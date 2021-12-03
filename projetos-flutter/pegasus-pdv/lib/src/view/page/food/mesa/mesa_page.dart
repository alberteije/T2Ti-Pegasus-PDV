/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [MESA] 
                                                                                
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
import 'dart:async';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class MesaPage extends StatefulWidget {
  final Mesa? mesa;
  final String? title;
  final String? operacao;

  const MesaPage({Key? key, this.mesa, this.title, this.operacao})
      : super(key: key);

  @override
  _MesaPageState createState() => _MesaPageState();
}

class _MesaPageState extends State<MesaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  final _quantidadeMesasController = MoneyMaskedTextController(
    decimalSeparator: '',
    thousandSeparator: '',    
    precision: 0, 
    initialValue: 0
  );
  final _quantidadeCadeirasController = MoneyMaskedTextController(
    decimalSeparator: '',
    thousandSeparator: '',    
    precision: 0, 
    initialValue: 0
  );  
  final _quantidadeCadeirasCriancasController = MoneyMaskedTextController(
    decimalSeparator: '',
    thousandSeparator: '',    
    precision: 0, 
    initialValue: 0
  );  

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;
  final _foco = FocusNode();

  Mesa? mesa;
  List<Mesa> listaMesa = [];

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
    mesa = widget.mesa;
    _foco.requestFocus();

    WidgetsBinding.instance!.addPostFrameCallback((_) => _consultarMesas());
  }

  Future _consultarMesas() async {
    await Sessao.db.mesaDao.consultarLista();
    setState(() {
    });
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
    listaMesa = Sessao.db.mesaDao.listaMesa;

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
            // drawerDragStartBehavior: DragStartBehavior.down,
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
          children: <Widget> [ 
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _quantidadeMesasController,
                decoration: getInputDecoration(
                  'Mesas',
                  'Mesas',
                  false),
                onChanged: (text) async {
                },
              ),                
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _quantidadeCadeirasController,
                decoration: getInputDecoration(
                  'Cadeiras Adulto',
                  'Cadeiras Adulto',
                  false),
                onChanged: (text) async {
                },
              ),                
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _quantidadeCadeirasCriancasController,
                decoration: getInputDecoration(
                  'Cadeiras Criança',
                  'Cadeiras Criança',
                  false),
                onChanged: (text) async {
                },
              ),                
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 0,
              child: Biblioteca.isTelaPequena(context)!
              ? 
              getBotaoTelaPequena(
                tooltip: 'Gerar Mesas',
                icone: const Icon(FontAwesomeIcons.utensils),
                onPressed: () async {
                  await _gerarMesas();
                }
              )
              :
              getBotaoTelaGrande(
                texto: 'Gerar Mesas',
                icone: const Icon(FontAwesomeIcons.utensils),
                onPressed: () async {
                  await _gerarMesas();
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBodySliverList() {
    Sessao.db.mesaDao.mesaStreamController.close();
    Sessao.db.mesaDao.mesaStreamController = StreamController<List<Mesa>>();

    return StreamBuilder<List<Mesa>>(
      stream: Sessao.db.mesaDao.mesaItemsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? CustomScrollView(
                slivers: <Widget>[
                  appBar(),
                  bodyGrid(snapshot.data!),
                ],
              )
            : const Center(child: CircularProgressIndicator());
      });
  }

  Widget appBar() => SliverAppBar(
    backgroundColor: Colors.black87,
    pinned: true,
    elevation: 10.0,
    forceElevated: true,
    expandedHeight: 80.0, // altura da caixa entre o topo da janela e os itens de mesa
    flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text('Mesas',
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
          Constantes.restauranteBackgroundImage,
          fit: BoxFit.cover,
        )),
  );

  Widget bodyGrid(List<Mesa> mesa) => SliverPadding(
    padding: const EdgeInsets.all(5.0),
    sliver: SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: definirQuantidadeDeCartoesPorLinha(context),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return menuStack(mesa[index]);
      }, childCount: mesa.length),
    )
  );

  int definirQuantidadeDeCartoesPorLinha(BuildContext context) {
    double larguraDaTela = MediaQuery.of(context).size.width;
    int larguraDoCartao = 150;
    int quantidadePorLinha = larguraDaTela ~/ larguraDoCartao;
    return quantidadePorLinha;
  }

  Widget menuStack(Mesa mesa) => InkWell(
    canRequestFocus: true,
    hoverColor: Colors.black38,
    onTap: () {
      Navigator.push(
        context, MaterialPageRoute(builder: (_) => MesaDetalhePage(mesa))
      ).then((value) async { await _consultarMesas(); });
    },
    splashColor: Colors.black,
    child: Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          menuImage(mesa),
          menuColor(mesa),
          menuData(mesa),
        ],
      ),
    ),
  );

  //stack 1/3 - primeira porção da pilha - a imagem - fica na parte de baixo do Stack
  Widget menuImage(Mesa mesa) => Image.asset(
    int.tryParse(mesa.numero!)!.isEven ? Constantes.mesaImage02 : Constantes.mesaImage02,
    fit: BoxFit.cover,
  );

  //stack 2/3 - segunda porção da pilha - a cor com a opacidade
  Widget menuColor(Mesa mesa) => Container(
    decoration: BoxDecoration(boxShadow: <BoxShadow>[
      BoxShadow(
        color: mesa.disponivel == 'S' ? Colors.blue.withOpacity(0.6) : Colors.red.withOpacity(0.6),
        blurRadius: 50.0, // efeito de fumaça
      ),
    ]),
  );

  //stack 3/3 - terceira porção da pilha - ícone e texto
  Widget menuData(Mesa mesa) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 35,
          foregroundDecoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xff536dfe), Color(0xff8e99f3)]), backgroundBlendMode: BlendMode.multiply,),      
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${mesa.quantidadeCadeiras}', style: const TextStyle(fontSize: 20.0, color: Colors.white)),
              Text('${mesa.quantidadeCadeirasCrianca ?? '0'}', style: const TextStyle(fontSize: 16.0)),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[      
            Text(mesa.numero.toString(), style: const TextStyle(fontSize: 50.0, color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
        Container(
          height: 35,
          foregroundDecoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xff536dfe), Color(0xff8e99f3)]), backgroundBlendMode: BlendMode.multiply,),      
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Carlos', style: TextStyle(fontSize: 14.0, color: Colors.white, )),
            ],
          ),
        ),
      ],
    );
  }

  /// MÉTODOS
  Future _gerarMesas() async {
    // verifica se já existem mesas no banco e se estão em uso
    final listaMesa = await Sessao.db.mesaDao.consultarListaFiltro('DISPONIVEL', 'N');
    if (listaMesa!.isNotEmpty) {
      gerarDialogBoxInformacao(context, 'Existem mesas em uso, procedimento não permitido.');
    } else {
      if (_quantidadeMesasController.numberValue <= 0) {
        gerarDialogBoxInformacao(context, 'Informe a quantidade de mesas.');
        return;
      } 
      if (_quantidadeCadeirasController.numberValue <= 0) {
        gerarDialogBoxInformacao(context, 'Informe a quantidade de cadeiras para adultos em cada mesa.');
        return;
      } 
      gerarDialogBoxConfirmacao(context, 'Deseja gerar as mesas? OBS: as mesas existentes serão apagadas.', () async {
        await Sessao.db.mesaDao.excluirTodos();
        await Sessao.db.mesaDao.inserirMesas(
          _quantidadeMesasController.numberValue.toInt(), 
          _quantidadeCadeirasController.numberValue.toInt(),
          _quantidadeCadeirasCriancasController.numberValue.toInt(),
        );
      });
      await _consultarMesas();
    }
  }
}

class MesaDetalhePage extends StatefulWidget {
  const MesaDetalhePage(this.mesa, {Key? key}) : super(key: key);

  final Mesa mesa;

  @override
  _MesaDetalhePageState createState() => _MesaDetalhePageState();
}

class _MesaDetalhePageState extends State<MesaDetalhePage> {
  Mesa? mesa;

  @override
  void initState() {
    super.initState();
    mesa = widget.mesa;
  }
  
  @override
  Widget build(BuildContext context) {
    final listItems = <Widget>[

      ListTile(
        contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 2),
        leading: Wrap( 
          spacing: 12,
          children: const [
            SizedBox(width: 1,),
            Icon(
              Icons.chair,
              color: Colors.black54,
            ),
          ]
        ),
        title: Text("Quantidade de Cadeiras para Adultos",
          style: TextStyle(
            color: Colors.white,
            fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0,
            fontWeight: FontWeight.bold
          ),
        ),                    
        trailing:
        SizedBox(
          width: Biblioteca.isTelaPequena(context)! ? 120 : 200,
          child: SliderTheme(
            data: ViewUtilLib.sliderThemeData(context),
            child: SpinBox( 
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0
              ),
              max: 20,
              min: 1,
              value: mesa!.quantidadeCadeiras!.toDouble(),
              decimals: 0,
              step: 1,
              onChanged: (value) { 
                mesa = mesa!.copyWith(
                  quantidadeCadeiras: value.toInt(),
                );
                setState(() {
                });
              },
            ),                          
          ),    
        ),
      ),  
      ListTile(
        contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 2),
        leading: Wrap( 
          spacing: 12,
          children: const [
            SizedBox(width: 1,),
            Icon(
              Icons.chair_sharp,
              color: Colors.black54,
            ),
          ]
        ),
        title: Text("Quantidade de Cadeiras para Crianças",
          style: TextStyle(
            color: Colors.white,
            fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0,
            fontWeight: FontWeight.bold
          ),
        ),                    
        trailing:
        SizedBox(
          width: Biblioteca.isTelaPequena(context)! ? 120 : 200,
          child: SliderTheme(
            data: ViewUtilLib.sliderThemeData(context),
            child: SpinBox( 
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: Biblioteca.isTelaPequena(context)! ? 14.0 : 16.0
              ),
              max: 20,
              min: 0,
              value: mesa!.quantidadeCadeirasCrianca?.toDouble() ?? 0,
              decimals: 0,
              step: 1,
              onChanged: (value) { 
                mesa = mesa!.copyWith(
                  quantidadeCadeirasCrianca: value.toInt(),
                );
                setState(() {
                });
              },
            ),                          
          ),    
        ),
      ),  

    ].expand((widget) => [widget, const Divider()]).toList();

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Color.lerp(Colors.grey[850], Colors.blueGrey, 0.8),
        appBar: AppBar(
          backgroundColor: Color.lerp(Colors.grey[850], Colors.white, 0.4),
          bottom: MesaTileDetalhe(mesa!),
        ),
        body: ListView(padding: const EdgeInsets.only(top: 50.0), children: listItems),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    await Sessao.db.mesaDao.alterar(mesa!);
    return true;
  }

}

class MesaTileDetalhe extends StatelessWidget implements PreferredSizeWidget {
  const MesaTileDetalhe(this.mesa, {Key? key}) : super(key: key);

  final Mesa mesa;

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {     
    final tileText = <Widget>[         
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${mesa.quantidadeCadeiras}', style: const TextStyle(fontSize: 12.0, color: Colors.white)),
          Text('${mesa.quantidadeCadeirasCrianca ?? '0'}', style: const TextStyle(fontSize: 12.0, color: Colors.white)),
        ],
      ),
      Text(mesa.numero.toString(), style: const TextStyle(fontSize: 50.0, color: Colors.white, fontWeight: FontWeight.bold)),
      const Text('Carlos', style: TextStyle(fontSize: 12.0, color: Colors.white, )),
    ];

    final tile = Container(
      margin: const EdgeInsets.all(0.0),
      width: 110,
      height: 110,
      foregroundDecoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.amberAccent]), backgroundBlendMode: BlendMode.multiply,),
      child: RawMaterialButton(
        fillColor: Colors.grey[800],
        disabledElevation: 10.0,
        padding: const EdgeInsets.all(4.0),
        onPressed: () {  },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: tileText
        ),
      ),
    );

    return Hero(
      tag: 'hero-${mesa.numero}',
      flightShuttleBuilder: (_, anim, __, ___, ____) =>
          ScaleTransition(scale: anim.drive(Tween(begin: 1, end: 1.75)), child: tile),
      child: Transform.scale(scale: 1.75, child: tile),
    );     
  }
}
