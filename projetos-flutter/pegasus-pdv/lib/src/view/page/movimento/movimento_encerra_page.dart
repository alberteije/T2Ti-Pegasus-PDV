/*
Title: T2Ti ERP 3.0                                                                
Description: Caixa - Página de Encerramento do Movimento
                                                                                
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

Based on: Flutter UI Challenges by Many - https://github.com/lohanidamodar/flutter_ui_challenges
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';
import 'package:pegasus_pdv/src/view/page/movimento/movimento_lista_page.dart';
import 'package:pegasus_pdv/src/view/page/relatorios/encerra_movimento_relatorio.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';

class MovimentoEncerraPage extends StatefulWidget {
  final String title;

  const MovimentoEncerraPage({Key key, this.title}) : super(key: key);

  @override
  _MovimentoEncerraPageState createState() => _MovimentoEncerraPageState();
}

class _MovimentoEncerraPageState extends State<MovimentoEncerraPage> {
  final _valorController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: 0);

  final _tipoPagamentoFoco = FocusNode();
  final _valorFoco = FocusNode();

  double _totalFechamento = 0;
  PdvTipoPagamento _tipoPagamento = Sessao.listaTipoPagamento[0];
  static List<PdvFechamento> _listaFechamento = [];

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();

    _valorController.afterChange = (_, __) {
      _valorController.selection = TextSelection.collapsed(
        offset: _valorController.text.length,
      );
    };

    _valorFoco.addListener(() {
      if(_valorFoco.hasFocus) {
        _valorController.selection = TextSelection(baseOffset: 0, extentOffset: _valorController.text.length);
      }
    });

    _shortcutMap = getAtalhosCaixa();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );
    _listaFechamento = [];
    _valorFoco.requestFocus();        
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.cancelar:
        Navigator.pop(context);
        break;
      case AtalhoTelaType.confirmar:
        _confirmar();
        break;
      case AtalhoTelaType.escape:
        Navigator.pop(context);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  gradient: LinearGradient(colors: [Colors.red.shade200, Colors.red.shade600]),
                ),
              ),
              ListView.builder(
                itemCount: 5,
                itemBuilder: _mainListBuilder,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return cabecalhoTela(context);
    if (index == 1) return dadosFechamento(context);
    // if (index == 2) return dadosOperador(context); 
    // if (index == 3) return dadosGerente(context);  
    if (index == 2) return rodapeTela(context);
    return null;
  }

  Container cabecalhoTela(BuildContext context) {
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
                    widget.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Informe os dados para encerrar o movimento [" + Sessao.movimento.id.toString() + "]",
                    textAlign: TextAlign.center,
                    ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                  ),
                  BootstrapContainer(
                    fluid: false,
                    decoration: BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
                    children: <Widget>[			  			  
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: ListTile(
                                title: Text("Data da Abertura"),
                                subtitle: Text(Biblioteca.formatarData(Sessao.movimento.dataAbertura)), 
                                leading: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: ListTile(
                                title: Text("Hora da Abertura"),
                                subtitle: Text(Sessao.movimento.horaAbertura), 
                                leading: Icon(Icons.timer),
                              ),
                            ),
                          ),
                        ],
                      ),
					          ],
				          ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getBotaoGenericoPdv(
                        descricao: 'Visualizar Movimentos Anteriores',
                        cor: Colors.blue, 
                        onPressed: () {
                          Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MovimentoListaPage()))
                            .then((_) {
                            });
                        }
                      ),                                         
                      SizedBox(
                        width: 10.0,
                      ),
                      getBotaoGenericoPdv(
                        descricao: 'Imprime Movimento Atual',
                        cor: Colors.green,
                        onPressed: () {
                          Navigator.of(context)
                            .push(MaterialPageRoute(
                              builder: (BuildContext context) => EncerraMovimentoRelatorio(movimento: Sessao.movimento)))
                            .then((_) {
                            });                      
                        }
                      ),                                         
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
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
                  backgroundImage: AssetImage(Constantes.caixaIcon),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container dadosFechamento(BuildContext context) {
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
                    Text("Informe os dados do fechamento"),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Tipo Pagamento',
                        hintText: 'Selecione o tipo de pagamento desejado',
                        contentPadding: EdgeInsets.zero,
                      ),
                      isEmpty: _tipoPagamento == null,
                      child: DropdownButton<PdvTipoPagamento>(
                        focusNode: _tipoPagamentoFoco,
                        isExpanded: true,
                        value: _tipoPagamento,
                        onChanged: (PdvTipoPagamento newValue) {
                          setState(() {
                            _tipoPagamento = newValue;
                          });
                        },
                        items: Sessao.listaTipoPagamento.map<DropdownMenuItem<PdvTipoPagamento>>((PdvTipoPagamento value) {
                          return DropdownMenuItem<PdvTipoPagamento>(
                            value: value,
                            child: Text(value.descricao),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      // enableInteractiveSelection: !Biblioteca.isDesktop(),
                      textAlign: TextAlign.end,
                      focusNode: _valorFoco,
                      keyboardType: TextInputType.number,
                      controller: _valorController,
                      decoration: getInputDecoration(
                        'Informe o valor para o tipo',
                        'Valor',
                        false),
                      onSubmitted: (value) {
                        _adicionarPagamento();
                      },
                      onChanged: (text) {
                      },
                    ),                                    
                    Divider(
                      indent: 0,
                      endIndent: 0,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 170.0,
                      child: Scrollbar(
                        child: ListView(
                          padding: const EdgeInsets.all(2.0),
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Card(
                                color: Colors.white,
                                elevation: 2.0,
                                child: DataTable(
                                  columns: getColumnsFechamento(),
                                  rows: getRowsFechamento()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Divider(
                      indent: 0,
                      endIndent: 0,
                      thickness: 2,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Total Geral Informado: ",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Spacer(),
                        Text(
                          'R\$ ${Constantes.formatoDecimalValor.format(_totalFechamento ?? 0)}',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
                        )
                      ],
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

  List<DataColumn> getColumnsFechamento() {
    List<DataColumn> lista = [];
    lista.add(DataColumn(
      label: Text(
        "Tipo",
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ));
    lista.add(DataColumn(
      numeric: true,
      label: Text(
        "Valor",
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ));
    return lista;
  }

  List<DataRow> getRowsFechamento() {
    List<DataRow> lista = [];
    for (var itemPagamento in _listaFechamento) {
      List<DataCell> celulas = [];

      celulas = [
        DataCell(
          Text(
            _getDescricaoTipoPagamento(itemPagamento),
          ), 
          onTap: () => _excluirPagamento(itemPagamento)),
        DataCell(
          Text('${Constantes.formatoDecimalValor.format(itemPagamento.valor ?? 0)}'),
          onTap: () => _excluirPagamento(itemPagamento)),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  Container rodapeTela(BuildContext context) {
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
        width: Biblioteca.isTelaPequena(context) ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Cancelar' : 'Cancelar [F11]',
          cor: Colors.red, 
          onPressed: () {
            Navigator.pop(context, false);
          }
        ),        
      ),
    );
    listaBotoes.add(
      SizedBox(width: 10.0),
    );
    listaBotoes.add(
      Container(
        width: Biblioteca.isTelaPequena(context) ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Confirmar' : 'Confirmar [F12]',
          cor: Colors.green, 
          onPressed: () {
            _confirmar();
          }
        ),
      ),
    );
    return listaBotoes;
  }

  String _getDescricaoTipoPagamento(PdvFechamento itemPagamento){
    final tipoFiltrado = Sessao.listaTipoPagamento.where( ((tipo) => tipo.id == itemPagamento.idPdvTipoPagamento)).toList();    
    return tipoFiltrado[0].descricao;
  }

  void _adicionarPagamento() {
    if (_valorController.numberValue > 0) {
      final pagamentoFiltrado = _listaFechamento.where(((pagamento) => pagamento.idPdvTipoPagamento == _tipoPagamento.id)).toList();    
      if (pagamentoFiltrado.length == 0) {
        PdvFechamento itemPagamento = PdvFechamento(
          id: null,
          idPdvTipoPagamento: _tipoPagamento.id,
          idPdvMovimento: Sessao.movimento.id,
          valor: _valorController.numberValue
        );
        _listaFechamento.add(itemPagamento);
      }
    }
    setState(() {
      _atualizarTotais();
      _tipoPagamentoFoco.requestFocus();        
    });
  }

  void _excluirPagamento(PdvFechamento itemPagamento) {
    gerarDialogBoxExclusao(context, () {
      // Navigator.of(context).pop();
      setState(() {
        _listaFechamento.removeWhere((item) => item.idPdvTipoPagamento == itemPagamento.idPdvTipoPagamento);
        _atualizarTotais();
      });
      _tipoPagamentoFoco.requestFocus();        
    });
  }  

  void _atualizarTotais() {
    _totalFechamento = 0;
    for (var item in _listaFechamento) {
      _totalFechamento = _totalFechamento + item.valor;
    }
  }

  void _confirmar() {
    gerarDialogBoxConfirmacao(context, 'Deseja encerrar o movimento atual?', () async {
      _atualizarTotais();
      Sessao.movimento = await Sessao.db.pdvMovimentoDao.encerrarMovimento(Sessao.movimento, listaFechamento: _listaFechamento);
      Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (BuildContext context) => EncerraMovimentoRelatorio(movimento: Sessao.movimento)))
        .then((_) async {
          Sessao.movimento = PdvMovimento(id: null, dataAbertura: DateTime.now(), horaAbertura: Biblioteca.formatarHora(DateTime.now()), statusMovimento: 'A');
          Sessao.movimento = await Sessao.db.pdvMovimentoDao.iniciarMovimento(Sessao.movimento);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
    });
  }

}
