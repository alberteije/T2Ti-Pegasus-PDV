/*
Title: T2Ti ERP 3.0                                                                
Description: PersistePage relacionada à tabela [COMANDA] 
                                                                                
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

class ComandaPage extends StatefulWidget {
  final String? title;
  /// I=Indoor
  /// D=Delivery
  /// T=Takeout 
  final String tipo;
  final Mesa mesa;
  final ComandaMontado? comandaMontado;

  const ComandaPage({Key? key, this.title, required this.mesa, required this.tipo, this.comandaMontado})
      : super(key: key);

  @override
  _ComandaPageState createState() => _ComandaPageState();
}

class _ComandaPageState extends State<ComandaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;
  final _foco = FocusNode();

  List<ComandaMontado> listaComandaMontado = [];

  late String _titulo = '';

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

    if (widget.tipo == 'I') {
      _titulo = widget.title! + ' [Mesa: ' + widget.mesa.numero! + ']';
    } else {
      final tipo = widget.tipo == 'T' ? 'Takeout' : 'Delivery';
      _titulo = widget.title! + ' [' + tipo + ']';
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) => _consultarComandas());
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

    if (widget.tipo == 'I') {
      listaItems.add(
        Expanded(
          flex: 1,
          child: getBotaoGenerico(
            context: context, 
            icone: FontAwesomeIcons.pager, 
            textOuTip: 'Adicionar Comanda',
            onPressed: _adicionarComanda,
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
        gridComComandas(),
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
        title: Text(_titulo,
            style: const TextStyle(
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

  
  Widget gridComComandas() {
    return SliverPadding(
      padding: const EdgeInsets.all(5.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: definirQuantidadeDeCartoesPorLinha(context),
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 0.73,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return comandaStack(index);
        }, childCount: listaComandaMontado.length),
      )
    );
  }

  int definirQuantidadeDeCartoesPorLinha(BuildContext context) {
    double larguraDaTela = MediaQuery.of(context).size.width;
    int larguraDoCartao = 200;
    int quantidadePorLinha = larguraDaTela ~/ larguraDoCartao;
    return quantidadePorLinha;
  }

  Widget comandaStack(int index) {
    return InkWell(
      canRequestFocus: true,
      hoverColor: Colors.black38,
      onTap: () {
        listaComandaMontado[index].cliente ??= Cliente(id: null);
        listaComandaMontado[index].colaborador ??= Colaborador(id: null);

        Navigator.push(
          context, MaterialPageRoute(builder: (_) => ComandaCadastroPage(listaComandaMontado[index]))
        ).then((value) async { await _consultarComandas(); });
      },
      splashColor: Colors.black,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            comandaImage(),
            comandaColor(),
            comandaData(listaComandaMontado[index]),
          ],
        ),
      ),
    );
  }

  //stack 1/3 - primeira porção da pilha - a imagem - fica na parte de baixo do Stack
  Widget comandaImage() => Image.asset(
    Constantes.fundoComandaImage,
    fit: BoxFit.cover,
  );

  //stack 2/3 - segunda porção da pilha - a cor com a opacidade
  Widget comandaColor() => Container(
    decoration: BoxDecoration(boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.amber.withOpacity(0.5),
        blurRadius: 50.0, // efeito de fumaça
      ),
    ]),
  );

  //stack 3/3 - terceira porção da pilha - ícone e texto
  Widget comandaData(ComandaMontado comandaMontado) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // parte de cima
        Padding(
          padding: const EdgeInsets.fromLTRB(85, 15, 5, 0),
          child: Column(
            children: [
              const Text('Comanda Nº', style: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.bold)),
              Text(comandaMontado.comanda!.id.toString().padLeft(8, '0'), style: const TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
              Text(Biblioteca.formatarData(comandaMontado.comanda!.dataChegada), style: const TextStyle(fontSize: 10.0, color: Colors.black54, fontWeight: FontWeight.bold)),
              Text(comandaMontado.comanda!.horaChegada ?? '', style: const TextStyle(fontSize: 10.0, color: Colors.black54, fontWeight: FontWeight.bold)),
            ],
          ),                 
        ),

        // parte de baixo
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
            children: [
              Text('Quantidade de Itens: ' + comandaMontado.listaComandaDetalheMontado!.length.toString(), style: const TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.bold)),
              Text('Quantidade de Pessoas: ' + (comandaMontado.comanda!.quantidadePessoas?.toString() ?? '0'), style: const TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.bold)),
              Text('Valor Subtotal: ' + Biblioteca.formatarValorDecimal(comandaMontado.comanda!.valorSubtotal), style: const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
              Text('Valor Desconto: ' + Biblioteca.formatarValorDecimal(comandaMontado.comanda!.valorDesconto), style: const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
              Text('Valor Total: ' + Biblioteca.formatarValorDecimal(comandaMontado.comanda!.valorTotal), style: const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
              Text('Valor por Pessoa: '  + Biblioteca.formatarValorDecimal(comandaMontado.comanda!.valorPorPessoa), style: const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    tooltip: 'Adicionar Itens',
                    icon: const Icon(Icons.add_box),
                    onPressed: () async { _adicionarItens(comandaMontado); }, 
                  ),
                  IconButton(
                    tooltip: 'Cancelar Comanda',
                    icon: const Icon(Icons.cancel),
                    onPressed: () async { _cancelarComanda(comandaMontado); }, 
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// MÉTODOS  
  Future _consultarComandas() async {
    if (widget.tipo == 'I') {
      if (widget.comandaMontado == null) { // não está vindo da página com a relação de comandas
        listaComandaMontado = 
          await Sessao.db.comandaDao.consultarListaMontado(
            idMesa: widget.mesa.id!, 
            codigoCompartilhado: 0, 
            situacao: 'A'
          );
      } else { // veio da página que lista as comandas
        listaComandaMontado = 
          await Sessao.db.comandaDao.consultarListaMontado(
            idMesa: widget.comandaMontado!.comanda!.idMesa!, 
            codigoCompartilhado: widget.comandaMontado!.comanda!.codigoCompartilhado!, 
            situacao: widget.comandaMontado!.comanda!.situacao!            
          );
      }
      // }
      if (listaComandaMontado.isEmpty) {
        _adicionarComanda();
      }
    } else {
      _adicionarComanda();
    }
    setState(() {
    });
  }

  Future _adicionarComanda() async {
    if (widget.tipo == 'I') {
      ComandaMontado comandaMontado = ComandaMontado(
        comanda: Comanda(
          id: null,
          idMesa: widget.mesa.id,
          dataChegada: Biblioteca.removerTempoDaData(DateTime.now()),
          horaChegada: Biblioteca.formatarHora(DateTime.now()),
          quantidadePessoas: 1,
          codigoCompartilhado: listaComandaMontado.isNotEmpty ? listaComandaMontado[0].comanda!.id! : null,
          tipo: widget.tipo, // indoor
          situacao: 'A',
        ),
        cliente: Cliente(id: null),
        colaborador: Colaborador(id: null),
        listaComandaDetalheMontado: [],
      );
      comandaMontado.comanda = await Sessao.db.comandaDao.inserir(comandaMontado);

      // se for a primeira comanda, coloca o código compartilhado nela
      if (listaComandaMontado.isEmpty) {
        comandaMontado.comanda = comandaMontado.comanda!.copyWith(
          codigoCompartilhado: comandaMontado.comanda!.id!,
        );
        await Sessao.db.comandaDao.alterar(comandaMontado);
      }
      listaComandaMontado = 
        await Sessao.db.comandaDao.consultarListaMontado(
          idMesa: comandaMontado.comanda!.idMesa!, 
          codigoCompartilhado: comandaMontado.comanda!.codigoCompartilhado!, 
          situacao: comandaMontado.comanda!.situacao!            
        );

      final mesa = widget.mesa.copyWith(disponivel: 'N');
      await Sessao.db.mesaDao.alterar(mesa);
    } else { 
      if (listaComandaMontado.length != 1) { // só permite adicionar UMA comanda para Takeout ou Delivery
        if (widget.comandaMontado != null) { // essa janela foi chamada pela janela que lista as comandas
          listaComandaMontado.add(widget.comandaMontado!);
        } else {
          ComandaMontado comandaMontado = ComandaMontado(
            comanda: Comanda(
              id: null,
              idMesa: null,
              dataChegada: Biblioteca.removerTempoDaData(DateTime.now()),
              horaChegada: Biblioteca.formatarHora(DateTime.now()),
              quantidadePessoas: 1,
              tipo: widget.tipo, // takeout ou delivery
              situacao: 'A',
            ),
            cliente: Cliente(id: null),
            colaborador: Colaborador(id: null),
            listaComandaDetalheMontado: [],
          );
          comandaMontado.comanda = await Sessao.db.comandaDao.inserir(comandaMontado);
          listaComandaMontado.add(comandaMontado);
        }
      }
    }
    setState(() {
    });
  }

  Future _cancelarComanda(ComandaMontado comandaMontado) async {
    if (comandaMontado.comanda!.situacao == 'C') {
      showInSnackBar('Essa comanda já foi cancelada!', context, corFundo: Colors.white);
    } else {
      gerarDialogBoxConfirmacao(context, 'Deseja cancelar a comanda?', () async {
        comandaMontado.comanda = comandaMontado.comanda!.copyWith(
          dataSaida: Biblioteca.removerTempoDaData(DateTime.now()),
          horaSaida: Biblioteca.formatarHora(DateTime.now()),
          situacao: 'C',
        );
        await Sessao.db.comandaDao.excluir(comandaMontado);
        await _consultarComandas();
        if (listaComandaMontado.isEmpty) {
          final mesa = widget.mesa.copyWith(disponivel: 'S');
          await Sessao.db.mesaDao.alterar(mesa);
          Navigator.pop(context);  
        }
      }); 
    } 
  }

  Future _adicionarItens(ComandaMontado comandaMontado) async {
    if (comandaMontado.comanda!.situacao == 'C') {
      showInSnackBar('Essa comanda foi cancelada!', context, corFundo: Colors.white);
    } else {
      comandaMontado.cliente ??= Cliente(id: null);
      comandaMontado.colaborador ??= Colaborador(id: null);

      Navigator.push(
        context, MaterialPageRoute(builder: (_) => ComandaDetalhePage(comandaMontado))
      ).then((value) async { await _consultarComandas(); });
    }
  }

}