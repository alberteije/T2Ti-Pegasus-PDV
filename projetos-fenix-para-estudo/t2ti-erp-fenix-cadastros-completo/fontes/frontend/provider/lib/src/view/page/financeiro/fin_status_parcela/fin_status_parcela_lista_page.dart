/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FIN_STATUS_PARCELA] 
                                                                                
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
import 'fin_status_parcela_persiste_page.dart';

class FinStatusParcelaListaPage extends StatefulWidget {
  @override
  _FinStatusParcelaListaPageState createState() => _FinStatusParcelaListaPageState();
}

class _FinStatusParcelaListaPageState extends State<FinStatusParcelaListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinStatusParcelaViewModel>(context).listaFinStatusParcela == null && Provider.of<FinStatusParcelaViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinStatusParcelaViewModel>(context).consultarLista();
    }
    var listaFinStatusParcela = Provider.of<FinStatusParcelaViewModel>(context).listaFinStatusParcela;
    var colunas = FinStatusParcela.colunas;
    var campos = FinStatusParcela.campos;

    final FinStatusParcelaDataSource _finStatusParcelaDataSource =
        FinStatusParcelaDataSource(listaFinStatusParcela, context);

    void _sort<T>(Comparable<T> getField(FinStatusParcela finStatusParcela), int columnIndex, bool ascending) {
      _finStatusParcelaDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinStatusParcelaViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Status Parcela'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinStatusParcelaViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Status Parcela'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FinStatusParcelaPersistePage(finStatusParcela: FinStatusParcela(), title: 'Status Parcela - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinStatusParcelaViewModel>(context).consultarLista();
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
                          title: 'Status Parcela - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinStatusParcelaViewModel>(context)
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
            child: listaFinStatusParcela == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Status Parcela'),
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
									_sort<num>((FinStatusParcela finStatusParcela) => finStatusParcela.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Situação'),
								tooltip: 'Situação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinStatusParcela finStatusParcela) => finStatusParcela.situacao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinStatusParcela finStatusParcela) => finStatusParcela.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Procedimento'),
								tooltip: 'Procedimento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinStatusParcela finStatusParcela) => finStatusParcela.procedimento,
									columnIndex, ascending),
							),
                        ],
                        source: _finStatusParcelaDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinStatusParcelaViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinStatusParcelaDataSource extends DataTableSource {
  final List<FinStatusParcela> listaFinStatusParcela;
  final BuildContext context;

  FinStatusParcelaDataSource(this.listaFinStatusParcela, this.context);

  void _sort<T>(Comparable<T> getField(FinStatusParcela finStatusParcela), bool ascending) {
    listaFinStatusParcela.sort((FinStatusParcela a, FinStatusParcela b) {
      if (!ascending) {
        final FinStatusParcela c = a;
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
    if (index >= listaFinStatusParcela.length) return null;
    final FinStatusParcela finStatusParcela = listaFinStatusParcela[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finStatusParcela.id ?? ''}'), onTap: () {
          detalharFinStatusParcela(finStatusParcela, context);
        }),
		DataCell(Text('${finStatusParcela.situacao ?? ''}'), onTap: () {
			detalharFinStatusParcela(finStatusParcela, context);
		}),
		DataCell(Text('${finStatusParcela.descricao ?? ''}'), onTap: () {
			detalharFinStatusParcela(finStatusParcela, context);
		}),
		DataCell(Text('${finStatusParcela.procedimento ?? ''}'), onTap: () {
			detalharFinStatusParcela(finStatusParcela, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinStatusParcela.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinStatusParcela(FinStatusParcela finStatusParcela, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finStatusParcelaDetalhe',
    arguments: finStatusParcela,
  );
}