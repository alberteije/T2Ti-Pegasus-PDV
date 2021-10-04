/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FIN_CHEQUE_EMITIDO] 
                                                                                
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
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/filtro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'fin_cheque_emitido_persiste_page.dart';

class FinChequeEmitidoListaPage extends StatefulWidget {
  @override
  _FinChequeEmitidoListaPageState createState() => _FinChequeEmitidoListaPageState();
}

class _FinChequeEmitidoListaPageState extends State<FinChequeEmitidoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinChequeEmitidoViewModel>(context).listaFinChequeEmitido == null && Provider.of<FinChequeEmitidoViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinChequeEmitidoViewModel>(context).consultarLista();
    }
    var listaFinChequeEmitido = Provider.of<FinChequeEmitidoViewModel>(context).listaFinChequeEmitido;
    var colunas = FinChequeEmitido.colunas;
    var campos = FinChequeEmitido.campos;

    final FinChequeEmitidoDataSource _finChequeEmitidoDataSource =
        FinChequeEmitidoDataSource(listaFinChequeEmitido, context);

    void _sort<T>(Comparable<T> getField(FinChequeEmitido finChequeEmitido), int columnIndex, bool ascending) {
      _finChequeEmitidoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinChequeEmitidoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Cheque Emitido'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinChequeEmitidoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Cheque Emitido'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FinChequeEmitidoPersistePage(finChequeEmitido: FinChequeEmitido(), title: 'Cheque Emitido - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinChequeEmitidoViewModel>(context).consultarLista();
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: ViewUtilLib.getBottomAppBarColor(),
          shape: CircularNotchedRectangle(),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoFiltro(),
                onPressed: () async {
                  Filtro filtro = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FiltroPage(
                          title: 'Cheque Emitido - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinChequeEmitidoViewModel>(context)
                          .consultarLista(filtro: filtro);
                    }
                  }
                },
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refrescarTela,
          child: Scrollbar(
            child: listaFinChequeEmitido == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Cheque Emitido'),
                        rowsPerPage: _rowsPerPage,
                        onRowsPerPageChanged: (int value) {
                          setState(() {
                            _rowsPerPage = value;
                          });
                        },
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                        columns: <DataColumn>[
							DataColumn(
								label: const Text('Id'),
								numeric: true,
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeEmitido finChequeEmitido) => finChequeEmitido.id,
										columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Cheque'),
								tooltip: 'Cheque',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeEmitido finChequeEmitido) => finChequeEmitido.cheque?.numero,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor'),
								tooltip: 'Valor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeEmitido finChequeEmitido) => finChequeEmitido.valor,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nominal A'),
								tooltip: 'Nominal A',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinChequeEmitido finChequeEmitido) => finChequeEmitido.nominalA,
									columnIndex, ascending),
							),
                        ],
                        source: _finChequeEmitidoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinChequeEmitidoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinChequeEmitidoDataSource extends DataTableSource {
  final List<FinChequeEmitido> listaFinChequeEmitido;
  final BuildContext context;

  FinChequeEmitidoDataSource(this.listaFinChequeEmitido, this.context);

  void _sort<T>(Comparable<T> getField(FinChequeEmitido finChequeEmitido), bool ascending) {
    listaFinChequeEmitido.sort((FinChequeEmitido a, FinChequeEmitido b) {
      if (!ascending) {
        final FinChequeEmitido c = a;
        a = b;
        b = c;
      }
      Comparable<T> aValue = getField(a);
      Comparable<T> bValue = getField(b);

      if (aValue == null) aValue = '' as Comparable<T>;
      if (bValue == null) bValue = '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= listaFinChequeEmitido.length) return null;
    final FinChequeEmitido finChequeEmitido = listaFinChequeEmitido[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finChequeEmitido.id ?? ''}'), onTap: () {
          detalharFinChequeEmitido(finChequeEmitido, context);
        }),
		DataCell(Text('${finChequeEmitido.cheque?.numero ?? ''}'), onTap: () {
			detalharFinChequeEmitido(finChequeEmitido, context);
		}),
		DataCell(Text('${finChequeEmitido.valor != null ? Constantes.formatoDecimalValor.format(finChequeEmitido.valor) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinChequeEmitido(finChequeEmitido, context);
		}),
		DataCell(Text('${finChequeEmitido.nominalA ?? ''}'), onTap: () {
			detalharFinChequeEmitido(finChequeEmitido, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinChequeEmitido.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinChequeEmitido(FinChequeEmitido finChequeEmitido, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finChequeEmitidoDetalhe',
    arguments: finChequeEmitido,
  );
}