/*
Title: T2Ti ERP 3.0                                                                
Description: Dashboard - resumo dos itens do caixa
                                                                                
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
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';

import 'package:pegasus_pdv/src/view/page/page.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<double> _totaisVendasSemanal = [0];
  List<double> _totaisVendasMensal = [0];
  List<double> _totaisVendasAnual = [0];
  List<List<double>> _graficos;

  static final List<String> _dropDownPeriodoAnterior = [
    'Última Semana',
    'Último Mês',
    'Último Ano'
  ];

  static final List<String> _dropDownPeriodoPosterior = [
    'Próxima Semana',
    'Próximo Mês',
    'Próximo Ano'
  ];

  String _itemDropDownFinanceiro = _dropDownPeriodoAnterior[0];
  String _itemDropDownVendas = _dropDownPeriodoAnterior[0];
  String _itemDropDownFluxo = _dropDownPeriodoPosterior[0];

  int _graficoSelecionado = 0;
  int _estoqueCritico = 0;

  double _totalVendas = 0;
  double _totalDespesas = 0;
  double _totalReceitas = 0;
  double _totalReceber = 0;
  double _totalPagar = 0;
  double _totalRecebimentosVencidos = 0;
  double _totalPagamentosVencidos = 0;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosCaixa();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _carregarDados());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.escape:
        Navigator.pop(context);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _graficos = [
      _totaisVendasSemanal,
      _totaisVendasMensal,
      _totaisVendasAnual
    ];

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.deepPurple.shade200, Colors.deepPurple.shade600]),
                ),
              ),
              ListView.builder(
                itemCount: 4,
                itemBuilder: _mainListBuilder,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _regiaoFinanceiro(context);
    if (index == 1) return _regiaoVendas(context);
    if (index == 2) return _regiaoEstoque(context);
    if (index == 3) return _rodapeTela(context);
    return null;
  }

  Container _regiaoFinanceiro(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    'Dashboard',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  BootstrapContainer(                    
                    fluid: true,
                    decoration: BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
                    children: <Widget>[			  			  
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-sm-12 col-xl-6',
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Resumo Financeiro",
                                            style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: Biblioteca.isTelaPequena(context) ? 13.0 : 15.0),
                                          ),
                                          DropdownButton(
                                            isDense: true,
                                            value: _itemDropDownFinanceiro,
                                            onChanged: (String value) {
                                              _itemDropDownFinanceiro = value;
                                              _carregarDados();
                                            },
                                            items: _dropDownPeriodoAnterior.map((String title) {
                                              return DropdownMenuItem(
                                                value: title,
                                                child: Text(title,
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: Biblioteca.isTelaPequena(context) ? 12.0 : 14.0)),
                                              );
                                            }).toList()
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      thickness: 2,
                                    ),
                                    Row(              
                                      children: <Widget> [ 
                                        Expanded(
                                          flex: 1,
                                          child: _getTile(
                                            _getItemResumoFinanceiro(
                                              'Receitas', 
                                              _totalReceitas, 
                                              Colors.blue.shade900, 
                                              FontAwesomeIcons.commentDollar
                                            ),
                                            onTap: _chamarContasReceber,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: _getTile(
                                            _getItemResumoFinanceiro(
                                              'Despesas', _totalDespesas, 
                                              Colors.red.shade900, 
                                              FontAwesomeIcons.commentsDollar
                                            ),
                                            onTap: _chamarContasPagar,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                                      child: Text(              
                                        'Saldo: ' + 'R\$ ${Constantes.formatoDecimalValor.format(_totalReceitas - _totalDespesas)}',
                                        style: 
                                        _totalDespesas > _totalReceitas
                                        ? TextStyle(
                                          fontWeight: FontWeight.w600, 
                                          fontSize: 17.0, 
                                          color: Colors.red, 
                                          fontStyle: FontStyle.italic
                                          )
                                        : TextStyle(
                                          fontWeight: FontWeight.w600, 
                                          fontSize: 17.0, 
                                          color: Colors.blue, 
                                          fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-sm-12 col-xl-6',
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                child: Column(
                                  children: <Widget>[                                        
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Fluxo de Caixa",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: Biblioteca.isTelaPequena(context) ? 13.0 : 15.0),
                                          ),
                                          DropdownButton(
                                            isDense: true,
                                            value: _itemDropDownFluxo,
                                            onChanged: (String value) {
                                              _itemDropDownFluxo = value;
                                              _carregarDados();
                                            },
                                            items: _dropDownPeriodoPosterior.map((String title) {
                                              return DropdownMenuItem(
                                                value: title,
                                                child: Text(title,
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: Biblioteca.isTelaPequena(context) ? 12.0 : 14.0)),
                                              );
                                            }).toList()
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      thickness: 2,
                                    ),
                                    _getItemFinanceiro('A Receber', _totalReceber, Colors.blueAccent.shade100, Colors.blue.shade900, FontAwesomeIcons.handHoldingUsd),            
                                    _getItemFinanceiro('A Pagar', _totalPagar, Colors.redAccent.shade100, Colors.red.shade900, FontAwesomeIcons.fileInvoiceDollar),            
                                    _getItemFinanceiro('Saldo', _totalReceber - _totalPagar, Colors.greenAccent.shade100, Colors.green.shade900, FontAwesomeIcons.searchDollar),            
                                  ],
                                ),
                              ),
                            ),                                  
                          ),
                        ],
                      ),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-sm-12 col-xl-6',
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    InkWell(
                                      onTap: _chamarContasReceber,
                                      child: _getItemFinanceiro(
                                        'Recebimentos Vencidos',
                                        _totalRecebimentosVencidos, 
                                        Colors.blue.shade100, 
                                        Colors.blue.shade500, 
                                        FontAwesomeIcons.info),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-sm-12 col-xl-6',
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    InkWell(
                                      onTap: _chamarContasPagar,
                                      child: _getItemFinanceiro(
                                        'Pagamentos Vencidos', 
                                        _totalPagamentosVencidos, 
                                        Colors.red.shade100, 
                                        Colors.red.shade500, 
                                        FontAwesomeIcons.skullCrossbones),            
                                    ),                                    
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage(Constantes.dashboardIcon),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _regiaoVendas(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Desempenho de Vendas",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                    _getTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Total das Vendas',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: Biblioteca.isTelaPequena(context) ? 13.0 : 15.0,
                                          )),
                                    Text('R\$ ${Constantes.formatoDecimalValor.format(_totalVendas ?? 0)}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: Biblioteca.isTelaPequena(context) ? 20.0 : 34.0)),
                                  ],
                                ),
                                DropdownButton(
                                  isDense: true,
                                  value: _itemDropDownVendas,
                                  onChanged: (String value) {
                                    _itemDropDownVendas = value;
                                    _graficoSelecionado = _dropDownPeriodoAnterior.indexOf(value);
                                    _carregarDados();
                                  },
                                  items: _dropDownPeriodoAnterior.map((String title) {
                                    return DropdownMenuItem(
                                      value: title,
                                      child: Text(title,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w400,
                                            fontSize: Biblioteca.isTelaPequena(context) ? 12.0 : 14.0)),
                                    );
                                  }).toList()
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 4.0)),
                            Sparkline(
                              data: _graficos[_graficoSelecionado],
                              lineWidth: 5.0,
                              lineColor: Colors.greenAccent,
                            ),
                          ],
                        )
                      ),
                      onTap: _chamarVendas,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _regiaoEstoque(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 30.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Posição do Estoque",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                    _getTile(
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Itens com Estoque Crítico',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: Biblioteca.isTelaPequena(context) ? 12.0 : 14.0)),
                                Text(_estoqueCritico.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0))
                              ],
                            ),
                            Material(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(FontAwesomeIcons.truckLoading,
                                    color: Colors.white, size: 30.0),
                              ))
                            ),
                          ]
                        ),
                      ),
                      onTap: _chamarEstoque,
                    ),                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            onTap: onTap != null
                ? () => onTap()
                : () { print('Nada foi implementado'); },
            child: child));
  }

  Widget _getItemResumoFinanceiro(String descricao, double valor, Color corIcone, IconData icone) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 32, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: corIcone,
            shape: CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(icone, color: Colors.white, size: 30.0),
            )),
          Padding(padding: EdgeInsets.only(bottom: 16.0)),
          Text(descricao, style: TextStyle(color: Colors.black87)),
          Text('R\$ ${Constantes.formatoDecimalValor.format(valor ?? 0)}', //valor
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: Biblioteca.isTelaPequena(context) ? 16.00 : 24.0)),
        ]
      ),
    );
  }

  Widget _getItemFinanceiro(String descricao, double valor, Color corFundo, Color corIcone, IconData icone) {
    return Container(
      child: Card(
        color: corFundo,
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(descricao,
                    style: TextStyle(color: Colors.black)),
                  SizedBox(
                    width: 1,
                  ),
                  Text('R\$ ${Constantes.formatoDecimalValor.format(valor ?? 0)}',
                    style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0)
                  ),
                ],
              ),
              Material(
                color: corIcone,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(icone,
                      color: Colors.white, size: 30.0),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _rodapeTela(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getBotoesRodape(context: context),
                    ),
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
          descricao: Biblioteca.isMobile() ? 'Sair' : 'Sair [ESC]',
          cor: Colors.green, 
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      )
    );
    return listaBotoes;
  }

  Future _carregarDados() async {
    // resumo financeiro - receitas
    _totalReceitas = await Sessao.db.contasReceberDao.consultarReceitas(periodo: _itemDropDownFinanceiro);

    // resumo financeiro - recebimentos vencidos
    _totalRecebimentosVencidos = await Sessao.db.contasReceberDao.consultarRecebimentosVencidos();

    // resumo financeiro - despesas
    _totalDespesas = await Sessao.db.contasPagarDao.consultarDespesas(periodo: _itemDropDownFinanceiro);

    // resumo financeiro - pagamentos vencidos
    _totalPagamentosVencidos = await Sessao.db.contasPagarDao.consultarPagamentosVencidos();

    // fluxo de caixa - a receber
    _totalReceber = await Sessao.db.contasReceberDao.consultarFluxo(periodo: _itemDropDownFluxo);

    // fluxo de caixa - a pagar
    _totalPagar = await Sessao.db.contasPagarDao.consultarFluxo(periodo: _itemDropDownFluxo);

    // desempenho de vendas
   _totalVendas = await Sessao.db.pdvVendaCabecalhoDao.consultarVendas(periodo: _itemDropDownVendas);
    if (_itemDropDownVendas.contains('Semana')) {
      _totaisVendasSemanal = await Sessao.db.pdvVendaCabecalhoDao.consultarVendasParaGrafico(periodo: _itemDropDownVendas);
    } else if (_itemDropDownVendas.contains('Mês')) {
      _totaisVendasMensal = await Sessao.db.pdvVendaCabecalhoDao.consultarVendasParaGrafico(periodo: _itemDropDownVendas);
    } else if (_itemDropDownVendas.contains('Ano')) {
      _totaisVendasAnual = await Sessao.db.pdvVendaCabecalhoDao.consultarVendasParaGrafico(periodo: _itemDropDownVendas);
    }   

    // posicao estoque
    _estoqueCritico = await Sessao.db.produtoDao.consultarEstoqueCritico();
    setState(() {
    });
  }

  _chamarContasReceber() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => ContasReceberListaPage()))
      .then((_) {    
    });
  }

  _chamarContasPagar() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => ContasPagarListaPage()))
      .then((_) {    
    });
  }

  _chamarEstoque() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => EstoqueListaPage()))
      .then((_) {    
    });
  }

  _chamarVendas() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => VendasListaPage()))
      .then((_) {    
    });
  }

}