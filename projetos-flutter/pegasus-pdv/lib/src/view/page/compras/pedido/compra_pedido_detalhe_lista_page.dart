/*
Title: T2Ti ERP 3.0                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [COMPRA_PEDIDO_DETALHE] 
                                                                                
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
import 'package:flutter/foundation.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';

import 'compra_pedido_cabecalho_page.dart';
import 'compra_pedido_detalhe_persiste_page.dart';

class CompraPedidoDetalheListaPage extends StatefulWidget {
  final CompraPedidoCabecalhoMontado compraPedidoCabecalhoMontado;
  final FocusNode foco;
  final Function salvarCompraPedidoCabecalhoCallBack;

  const CompraPedidoDetalheListaPage({Key key, this.compraPedidoCabecalhoMontado, this.foco, this.salvarCompraPedidoCabecalhoCallBack}) : super(key: key);

  @override
  _CompraPedidoDetalheListaPageState createState() => _CompraPedidoDetalheListaPageState();
}

class _CompraPedidoDetalheListaPageState extends State<CompraPedidoDetalheListaPage> {
  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosAbaPage();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.inserir:
        _inserir();
        break;
      case AtalhoTelaType.salvar:
        widget.salvarCompraPedidoCabecalhoCallBack();
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
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            focusNode: widget.foco,
            autofocus: true,
            focusColor: ViewUtilLib.getBotaoFocusColor(),
            tooltip: Constantes.botaoInserirDica,
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              _inserir();
            }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(2.0),
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: DataTable(columns: _getColumns(), rows: _getRows()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _inserir() async {
    if (_podeAlterarPedido()) {
      var _compraDetalhe = CompraDetalhe();
      _compraDetalhe = await Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (BuildContext context) =>
            CompraPedidoDetalhePersistePage(
              compraPedidoCabecalho: CompraPedidoCabecalhoController.compraPedidoCabecalho,
              compraDetalhe: _compraDetalhe,
              title: 'Detalhes do Pedido - Inserindo',
              operacao: 'I')));
      if (_compraDetalhe!= null) { 
        CompraPedidoCabecalhoController.listaCompraDetalhe.add(_compraDetalhe);
      }
      setState(() {
        _getRows();
      });
    }
  }
  
  List<DataColumn> _getColumns() {
    List<DataColumn> lista = [];
    lista.add(DataColumn(numeric: true, label: Text('Id')));
    lista.add(DataColumn(label: Text('Produto')));
    lista.add(DataColumn(numeric: true, label: Text('Quantidade')));
    lista.add(DataColumn(numeric: true, label: Text('Valor Unitário')));
    lista.add(DataColumn(numeric: true, label: Text('Valor Subtotal')));
    lista.add(DataColumn(numeric: true, label: Text('Taxa Desconto')));
    lista.add(DataColumn(numeric: true, label: Text('Valor Desconto')));
    lista.add(DataColumn(numeric: true, label: Text('Valor Total')));
    return lista;
  }

  List<DataRow> _getRows() {
    if (CompraPedidoCabecalhoController.listaCompraDetalhe == null) {
      CompraPedidoCabecalhoController.listaCompraDetalhe = [];
    }
    List<DataRow> lista = [];
    for (var compraDetalhe in CompraPedidoCabecalhoController.listaCompraDetalhe) {
      if (compraDetalhe.compraPedidoDetalhe.quantidade > 0) {
        List<DataCell> _celulas = [];

        _celulas = [
          DataCell(Text('${ compraDetalhe.compraPedidoDetalhe.id ?? ''}'), onTap: () {
            _detalharCompraPedidoDetalhe(CompraPedidoCabecalhoController.compraPedidoCabecalho, compraDetalhe, context);
          }),
          DataCell(Text('${compraDetalhe.produto?.nome ?? ''}'), onTap: () { 
            _detalharCompraPedidoDetalhe(CompraPedidoCabecalhoController.compraPedidoCabecalho, compraDetalhe, context);
          }),
          DataCell(Text('${Constantes.formatoDecimalQuantidade.format(compraDetalhe.compraPedidoDetalhe.quantidade ?? 0)}'), onTap: () {
            _detalharCompraPedidoDetalhe(CompraPedidoCabecalhoController.compraPedidoCabecalho, compraDetalhe, context);
          }),
          DataCell(Text('${Constantes.formatoDecimalValor.format(compraDetalhe.compraPedidoDetalhe.valorUnitario ?? 0)}'), onTap: () {
            _detalharCompraPedidoDetalhe(CompraPedidoCabecalhoController.compraPedidoCabecalho, compraDetalhe, context);
          }),
          DataCell(Text('${Constantes.formatoDecimalValor.format(compraDetalhe.compraPedidoDetalhe.valorSubtotal ?? 0)}'), onTap: () {
            _detalharCompraPedidoDetalhe(CompraPedidoCabecalhoController.compraPedidoCabecalho, compraDetalhe, context);
          }),
          DataCell(Text('${Constantes.formatoDecimalTaxa.format(compraDetalhe.compraPedidoDetalhe.taxaDesconto ?? 0)}'), onTap: () {
            _detalharCompraPedidoDetalhe(CompraPedidoCabecalhoController.compraPedidoCabecalho, compraDetalhe, context);
          }),
          DataCell(Text('${Constantes.formatoDecimalValor.format(compraDetalhe.compraPedidoDetalhe.valorDesconto ?? 0)}'), onTap: () {
            _detalharCompraPedidoDetalhe(CompraPedidoCabecalhoController.compraPedidoCabecalho, compraDetalhe, context);
          }),
          DataCell(Text('${Constantes.formatoDecimalValor.format(compraDetalhe.compraPedidoDetalhe.valorTotal ?? 0)}'), onTap: () {
            _detalharCompraPedidoDetalhe(CompraPedidoCabecalhoController.compraPedidoCabecalho, compraDetalhe, context);
          }),
        ];

        lista.add(DataRow(cells: _celulas));
      }
    }
    _atualizarTotais();
    return lista;
  }

  void _detalharCompraPedidoDetalhe(CompraPedidoCabecalho compraPedidoCabecalho, CompraDetalhe compraDetalhe, BuildContext context) {
    if (_podeAlterarPedido()) {
      Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (BuildContext context) => CompraPedidoDetalhePersistePage(
            compraPedidoCabecalho: CompraPedidoCabecalhoController.compraPedidoCabecalho,
            compraDetalhe: compraDetalhe,
            title: 'Detalhes do Pedido - Alterando',
            operacao: 'A',
          )))
        .then((_) {
          setState(() {
            _getRows();
          });
        });
    }
  }

  void _atualizarTotais() {
    double subTotal = 0;        
    double totalDescontosItens = 0;
    for (CompraDetalhe compraDetalhe in CompraPedidoCabecalhoController.listaCompraDetalhe) {
      subTotal = subTotal + (compraDetalhe.compraPedidoDetalhe.valorTotal ?? 0);
      totalDescontosItens = totalDescontosItens + (compraDetalhe.compraPedidoDetalhe.valorDesconto ?? 0);
    }     
    double taxaDesconto = 0;
    double valorDesconto = 0;
    if (totalDescontosItens > 0) {
      valorDesconto = totalDescontosItens;
      taxaDesconto = valorDesconto / subTotal * 100;
      taxaDesconto = num.parse(taxaDesconto.toStringAsFixed(Constantes.decimaisValor));
      CompraPedidoCabecalhoPage.descontoNosItems = true; // se tem desconto nos itens vai impedir de fornecer desconto na venda
    } else {
      taxaDesconto = CompraPedidoCabecalhoController.compraPedidoCabecalho.taxaDesconto;
      valorDesconto = Biblioteca.calcularDesconto(subTotal, CompraPedidoCabecalhoController.compraPedidoCabecalho.taxaDesconto);
      CompraPedidoCabecalhoPage.descontoNosItems = false;
    }
    CompraPedidoCabecalhoController.compraPedidoCabecalho = 
      CompraPedidoCabecalhoController.compraPedidoCabecalho.copyWith(
        valorSubtotal: subTotal,
        taxaDesconto: taxaDesconto,
        valorDesconto: valorDesconto,
        valorTotal: subTotal - valorDesconto,
      );
  }
 
  bool _podeAlterarPedido() {
    bool retorno = true;
    if (CompraPedidoCabecalhoController.compraPedidoCabecalho.geraFinanceiro == 'S') {
      retorno = false;
      gerarDialogBoxInformacao(context, 'Não é possível alterar o item. Dados Financeiros já foram gerados.');
    } else if (CompraPedidoCabecalhoController.compraPedidoCabecalho.atualizouEstoque == 'S') {
      retorno = false;
      gerarDialogBoxInformacao(context, 'Não é possível alterar o item. Estoque já foi atualizado.');
    }
    return retorno;
  }

}