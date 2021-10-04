/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FIN_NATUREZA_FINANCEIRA] 
                                                                                
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
import 'fin_natureza_financeira_persiste_page.dart';

class FinNaturezaFinanceiraListaPage extends StatefulWidget {
  @override
  _FinNaturezaFinanceiraListaPageState createState() => _FinNaturezaFinanceiraListaPageState();
}

class _FinNaturezaFinanceiraListaPageState extends State<FinNaturezaFinanceiraListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinNaturezaFinanceiraViewModel>(context).listaFinNaturezaFinanceira == null && Provider.of<FinNaturezaFinanceiraViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinNaturezaFinanceiraViewModel>(context).consultarLista();
    }
    var listaFinNaturezaFinanceira = Provider.of<FinNaturezaFinanceiraViewModel>(context).listaFinNaturezaFinanceira;
    var colunas = FinNaturezaFinanceira.colunas;
    var campos = FinNaturezaFinanceira.campos;

    final FinNaturezaFinanceiraDataSource _finNaturezaFinanceiraDataSource =
        FinNaturezaFinanceiraDataSource(listaFinNaturezaFinanceira, context);

    void _sort<T>(Comparable<T> getField(FinNaturezaFinanceira finNaturezaFinanceira), int columnIndex, bool ascending) {
      _finNaturezaFinanceiraDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinNaturezaFinanceiraViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Natureza Financeira'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinNaturezaFinanceiraViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Natureza Financeira'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FinNaturezaFinanceiraPersistePage(finNaturezaFinanceira: FinNaturezaFinanceira(), title: 'Natureza Financeira - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinNaturezaFinanceiraViewModel>(context).consultarLista();
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
                          title: 'Natureza Financeira - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinNaturezaFinanceiraViewModel>(context)
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
            child: listaFinNaturezaFinanceira == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Natureza Financeira'),
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
									_sort<num>((FinNaturezaFinanceira finNaturezaFinanceira) => finNaturezaFinanceira.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código'),
								tooltip: 'Código',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinNaturezaFinanceira finNaturezaFinanceira) => finNaturezaFinanceira.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinNaturezaFinanceira finNaturezaFinanceira) => finNaturezaFinanceira.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Tipo'),
								tooltip: 'Tipo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinNaturezaFinanceira finNaturezaFinanceira) => finNaturezaFinanceira.tipo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Aplicação'),
								tooltip: 'Aplicação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinNaturezaFinanceira finNaturezaFinanceira) => finNaturezaFinanceira.aplicacao,
									columnIndex, ascending),
							),
                        ],
                        source: _finNaturezaFinanceiraDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinNaturezaFinanceiraViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinNaturezaFinanceiraDataSource extends DataTableSource {
  final List<FinNaturezaFinanceira> listaFinNaturezaFinanceira;
  final BuildContext context;

  FinNaturezaFinanceiraDataSource(this.listaFinNaturezaFinanceira, this.context);

  void _sort<T>(Comparable<T> getField(FinNaturezaFinanceira finNaturezaFinanceira), bool ascending) {
    listaFinNaturezaFinanceira.sort((FinNaturezaFinanceira a, FinNaturezaFinanceira b) {
      if (!ascending) {
        final FinNaturezaFinanceira c = a;
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
    if (index >= listaFinNaturezaFinanceira.length) return null;
    final FinNaturezaFinanceira finNaturezaFinanceira = listaFinNaturezaFinanceira[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finNaturezaFinanceira.id ?? ''}'), onTap: () {
          detalharFinNaturezaFinanceira(finNaturezaFinanceira, context);
        }),
		DataCell(Text('${finNaturezaFinanceira.codigo ?? ''}'), onTap: () {
			detalharFinNaturezaFinanceira(finNaturezaFinanceira, context);
		}),
		DataCell(Text('${finNaturezaFinanceira.descricao ?? ''}'), onTap: () {
			detalharFinNaturezaFinanceira(finNaturezaFinanceira, context);
		}),
		DataCell(Text('${finNaturezaFinanceira.tipo ?? ''}'), onTap: () {
			detalharFinNaturezaFinanceira(finNaturezaFinanceira, context);
		}),
		DataCell(Text('${finNaturezaFinanceira.aplicacao ?? ''}'), onTap: () {
			detalharFinNaturezaFinanceira(finNaturezaFinanceira, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinNaturezaFinanceira.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinNaturezaFinanceira(FinNaturezaFinanceira finNaturezaFinanceira, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finNaturezaFinanceiraDetalhe',
    arguments: finNaturezaFinanceira,
  );
}