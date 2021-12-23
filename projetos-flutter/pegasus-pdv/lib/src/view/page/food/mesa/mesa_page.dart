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
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';

import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class MesaPage extends StatefulWidget {
  final String? title;
  /// CAD=Cadastro
  /// RES=Reserva
  /// COM=Comanda 
  final String? operacao;
  final Reserva? reserva;

  const MesaPage({Key? key, this.title, this.operacao, this.reserva})
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
    _foco.requestFocus();

    WidgetsBinding.instance!.addPostFrameCallback((_) => _consultarMesas());
  }

  Future _consultarMesas() async {
    if (widget.operacao == 'CAD') {
      listaMesa = await Sessao.db.mesaDao.consultarLista();
    } else if (widget.operacao == 'RES') {
      listaMesa = await Sessao.db.reservaDao.consultarListaReservaDia(widget.reserva!.dataReserva!);
    } else if (widget.operacao == 'COM') {
      listaMesa = await Sessao.db.reservaDao.consultarMesasParaComanda();
    }
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

    if (widget.operacao == 'CAD') {
      listaItems.add(
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
      );
      listaItems.add(
        const SizedBox(
          width: 8,
        ),
      );
      listaItems.add(
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
      );
      listaItems.add(
        const SizedBox(
          width: 8,
        ),
      );
      listaItems.add(
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
      );
      listaItems.add(
        const SizedBox(
          width: 8,
        ),
      );
      listaItems.add(
        Expanded(
          flex: 0,
          child: getBotaoGenerico(
            context: context, 
            icone: FontAwesomeIcons.utensils, 
            textOuTip: 'Gerar Mesas',
            onPressed: _gerarMesas,
          ),
        ),
      );
    } else if (widget.operacao == 'RES') {
      listaItems.add(
        Expanded(
          flex: 1,
          child: getBotaoGenerico(
            context: context, 
            icone: FontAwesomeIcons.chair, 
            textOuTip: 'Confirmar Seleção',
            onPressed: _confirmarSelecaoParaReserva,
          ),          
        ),
      );    
    } else if (widget.operacao == 'COM') {
      listaItems.add(
        Expanded(
          flex: 1,
          child: getBotaoGenerico(
            context: context, 
            icone: FontAwesomeIcons.handHolding, 
            textOuTip: 'Takeout',
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (_) => ComandaPage(title: 'Comandas', mesa: Mesa(id: null), tipo: 'T'))
              ).then((value) async { await _consultarMesas(); });
            },
          ),          
        ),
      );    
      listaItems.add(
        const SizedBox(
          width: 8,
        ),
      );
      listaItems.add(
        Expanded(
          flex: 1,
          child: getBotaoGenerico(
            context: context, 
            icone: FontAwesomeIcons.bicycle, 
            textOuTip: 'Delivery',
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (_) => ComandaPage(title: 'Comandas', mesa: Mesa(id: null), tipo: 'D'))
              ).then((value) async { await _consultarMesas(); });
            },
          ),          
        ),
      );    
      listaItems.add(
        const SizedBox(
          width: 8,
        ),
      );
      listaItems.add(
        Expanded(
          flex: 1,
          child: getBotaoGenerico(
            context: context, 
            icone: FontAwesomeIcons.list, 
            textOuTip: 'Consultar',
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ComandaListaPage())
              ).then((value) async { await _consultarMesas(); });
            },
          ),          
        ),
      );    
    }
    return listaItems;
  }

  Widget _getBodySliverList() {
    return CustomScrollView(
      slivers: <Widget>[
        appBar(),
        gridComMesas(),
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
        title: Text(widget.title!,
            style: const TextStyle(
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

  
  Widget gridComMesas() {
    return SliverPadding(
      padding: const EdgeInsets.all(5.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: definirQuantidadeDeCartoesPorLinha(context),
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return mesaStack(index);
        }, childCount: listaMesa.length),
      )
    );
  }

  int definirQuantidadeDeCartoesPorLinha(BuildContext context) {
    double larguraDaTela = MediaQuery.of(context).size.width;
    int larguraDoCartao = 150;
    int quantidadePorLinha = larguraDaTela ~/ larguraDoCartao;
    return quantidadePorLinha;
  }

  Widget mesaStack(int index) {
    return InkWell(
      onLongPress: () { 
        _selecionarMesa(index); 
        setState(() {
        });
      },
      onDoubleTap: () { 
        _selecionarMesa(index); 
        setState(() {
        });
      },
      canRequestFocus: true,
      hoverColor: Colors.black38,
      onTap: () {
        if (widget.operacao == 'CAD') {
          Navigator.push(
            context, MaterialPageRoute(builder: (_) => MesaCadastroPage(listaMesa[index]))
          ).then((value) async { await _consultarMesas(); });
        } else if (widget.operacao == 'COM') { 
          Navigator.push(
            context, MaterialPageRoute(builder: (_) => ComandaPage(title: 'Comandas', mesa: listaMesa[index], tipo: 'I'))
          ).then((value) async { await _consultarMesas(); });
        }
      },
      splashColor: Colors.black,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            mesaImage(listaMesa[index]),
            mesaColor(listaMesa[index]),
            mesaData(listaMesa[index]),
          ],
        ),
      ),
    );
  }

  void _selecionarMesa(int index) {
    if (widget.operacao == 'RES') {
      if (listaMesa[index].disponivel == 'R') {
        listaMesa[index] = listaMesa[index].copyWith(
          disponivel: 'S', 
        );
      } else if (listaMesa[index].disponivel == 'S') {
        listaMesa[index] = listaMesa[index].copyWith(
          disponivel: 'R', // não será persistido no banco, apenas para controlar a marcação da mesa visualmente para a reserva
        );
      }
    }
  }

  //stack 1/3 - primeira porção da pilha - a imagem - fica na parte de baixo do Stack
  Widget mesaImage(Mesa mesa) => Image.asset(
    int.tryParse(mesa.numero!)!.isEven ? Constantes.mesaImage02 : Constantes.mesaImage02,
    fit: BoxFit.cover,
  );

  //stack 2/3 - segunda porção da pilha - a cor com a opacidade
  Widget mesaColor(Mesa mesa) => Container(
    decoration: BoxDecoration(boxShadow: <BoxShadow>[
      BoxShadow(
        color: _definirCorMesa(mesa),
        blurRadius: 50.0, // efeito de fumaça
      ),
    ]),
  );

  Color _definirCorMesa(Mesa mesa) {
    switch (mesa.disponivel) {
      case 'S' :
        return Colors.blue.withOpacity(0.6);
      case 'N' :
        return Colors.red.withOpacity(0.6);
      case 'R' :
        return Colors.yellow.withOpacity(0.6);
      default:
        return Colors.blue.withOpacity(0.6);
    }
  }

  //stack 3/3 - terceira porção da pilha - ícone e texto
  Widget mesaData(Mesa mesa) {
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
          height: 40,
          foregroundDecoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xff536dfe), Color(0xff8e99f3)]), backgroundBlendMode: BlendMode.multiply,),      
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.operacao ==  'COM' 
              ? IconButton(
                  tooltip: 'Encerrar Mesa',
                  icon: const Icon(Icons.task_alt),
                  onPressed: () async { _encerrarMesa(mesa); }, 
                )
              : Text((mesa.observacao?.isNotEmpty ?? false) ? 'OBS' : '', style: const TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold)),
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
        await _consultarMesas();
      });
    }
  }

  void _confirmarSelecaoParaReserva() {
    final List<Mesa> listaMesaReserva = [];
    for (var mesa in listaMesa) {
      if (mesa.disponivel == 'R') {
        listaMesaReserva.add(mesa);
      }
    }
    Navigator.pop(context, listaMesaReserva);
  }

  Future _encerrarMesa(Mesa mesa) async {
    gerarDialogBoxConfirmacao(context, 'Deseja encerrar o movimento de mesa? OBS: todas as comandas da mesa serão encerradas.', () async {
    final listaComandaMontado = 
      await Sessao.db.comandaDao.consultarListaMontado(
        idMesa: mesa.id!, 
        codigoCompartilhado: 0, 
        situacao: 'A'
      );      

      for (var comandaMontado in listaComandaMontado) {
        comandaMontado.comanda = comandaMontado.comanda!.copyWith(
          dataSaida: Biblioteca.removerTempoDaData(DateTime.now()),
          horaSaida: Biblioteca.formatarHora(DateTime.now()),
          situacao: 'F',
        );
        await Sessao.db.comandaDao.alterar(comandaMontado);        
      }
      mesa = mesa.copyWith(
        disponivel: 'S',
      );
      await Sessao.db.mesaDao.alterar(mesa);
      await _consultarMesas();
    });

  }  
   
}