/*
Title: T2Ti ERP 3.0                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [NFE_DETALHE] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';


class NfeDetalheListaPage extends StatefulWidget {
  final NfeCabecalhoMontado nfeCabecalhoMontado;
  final FocusNode foco;

  const NfeDetalheListaPage({Key key, this.nfeCabecalhoMontado, this.foco}) : super(key: key);

  @override
  _NfeDetalheListaPageState createState() => _NfeDetalheListaPageState();
}

class _NfeDetalheListaPageState extends State<NfeDetalheListaPage> {
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
          /*floatingActionButton: FloatingActionButton(
            focusNode: widget.foco,
            autofocus: true,
            focusColor: ViewUtilLib.getBotaoFocusColor(),
            tooltip: Constantes.botaoInserirDica,
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              _inserir();
            }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,*/
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
  
  List<DataColumn> _getColumns() {
    List<DataColumn> lista = [];
    // lista.add(DataColumn(numeric: true, label: Text('Número do Item')));
    lista.add(DataColumn(label: Text('Produto')));
    lista.add(DataColumn(label: Text('Código do Produto')));
    lista.add(DataColumn(label: Text('GTIN')));
    lista.add(DataColumn(label: Text('Unidade')));
    lista.add(DataColumn(numeric: true, label: Text('Quantidade')));
    lista.add(DataColumn(numeric: true, label: Text('Valor Unitário')));
    lista.add(DataColumn(numeric: true, label: Text('Valor Desconto')));
    lista.add(DataColumn(numeric: true, label: Text('Valor Subtotal')));
    lista.add(DataColumn(numeric: true, label: Text('Valor Total')));
    return lista;
  }

  List<DataRow> _getRows() {
    List<DataRow> lista = [];
    for (var nfeDetalheMontado in widget.nfeCabecalhoMontado.listaNfeDetalheMontado) {
      List<DataCell> _celulas = [];

      _celulas = [
        // DataCell(Text('${nfeDetalheMontado.nfeDetalhe.numeroItem ?? ''}'), ),
        DataCell(Text('${nfeDetalheMontado.nfeDetalhe.nomeProduto ?? ''}'), ),
        DataCell(Text('${nfeDetalheMontado.nfeDetalhe.codigoProduto ?? ''}'), ),
        DataCell(Text('${nfeDetalheMontado.nfeDetalhe.gtin ?? ''}'), ),
        DataCell(Text('${nfeDetalheMontado.nfeDetalhe.unidadeComercial ?? ''}'), ),
        DataCell(Text('${Biblioteca.formatarValorDecimal(nfeDetalheMontado.nfeDetalhe.quantidadeComercial)}'), ),
        DataCell(Text('${Biblioteca.formatarValorDecimal(nfeDetalheMontado.nfeDetalhe.valorUnitarioComercial)}'), ),
        DataCell(Text('${Biblioteca.formatarValorDecimal(nfeDetalheMontado.nfeDetalhe.valorDesconto)}'), ),
        DataCell(Text('${Biblioteca.formatarValorDecimal(nfeDetalheMontado.nfeDetalhe.valorSubtotal)}'), ),
        DataCell(Text('${Biblioteca.formatarValorDecimal(nfeDetalheMontado.nfeDetalhe.valorTotal)}'),),
      ];

      lista.add(DataRow(cells: _celulas));
    }
    return lista;
  }

  /*void _detalharNfeDetalhe(
      NfeCabecalho nfeCabecalho, NfeDetalhe nfeDetalhe, BuildContext context) {
        Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (BuildContext context) => NfeDetalhePersistePage(
              nfeCabecalho: nfeCabecalho,
              nfeDetalhe: nfeDetalhe,
			  title: "Nfe Detalhe - Editando",
			  operacao: "A"
			)))
          .then((_) {
            setState(() {
              _getRows();
            });
          });
  }*/
  
}