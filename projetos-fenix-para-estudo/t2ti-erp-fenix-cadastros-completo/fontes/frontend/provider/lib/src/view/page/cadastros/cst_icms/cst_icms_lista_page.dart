/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [CST_ICMS] 
                                                                                
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

class CstIcmsListaPage extends StatefulWidget {
  @override
  _CstIcmsListaPageState createState() => _CstIcmsListaPageState();
}

class _CstIcmsListaPageState extends State<CstIcmsListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CstIcmsViewModel>(context).listaCstIcms == null && Provider.of<CstIcmsViewModel>(context).objetoJsonErro == null) {
      Provider.of<CstIcmsViewModel>(context).consultarLista();
    }
    var listaCstIcms = Provider.of<CstIcmsViewModel>(context).listaCstIcms;
    var colunas = CstIcms.colunas;
    var campos = CstIcms.campos;

    final CstIcmsDataSource _cstIcmsDataSource =
        CstIcmsDataSource(listaCstIcms, context);

    void _sort<T>(Comparable<T> getField(CstIcms cstIcms), int columnIndex, bool ascending) {
      _cstIcmsDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<CstIcmsViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cst Icms'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<CstIcmsViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cst Icms'),
          actions: <Widget>[],
        ),
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
                          title: 'Cst Icms - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<CstIcmsViewModel>(context)
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
            child: listaCstIcms == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Cst Icms'),
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
									_sort<num>((CstIcms cstIcms) => cstIcms.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código'),
								tooltip: 'Código',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CstIcms cstIcms) => cstIcms.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CstIcms cstIcms) => cstIcms.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CstIcms cstIcms) => cstIcms.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _cstIcmsDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<CstIcmsViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class CstIcmsDataSource extends DataTableSource {
  final List<CstIcms> listaCstIcms;
  final BuildContext context;

  CstIcmsDataSource(this.listaCstIcms, this.context);

  void _sort<T>(Comparable<T> getField(CstIcms cstIcms), bool ascending) {
    listaCstIcms.sort((CstIcms a, CstIcms b) {
      if (!ascending) {
        final CstIcms c = a;
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
    if (index >= listaCstIcms.length) return null;
    final CstIcms cstIcms = listaCstIcms[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ cstIcms.id ?? ''}'), onTap: () {
          detalharCstIcms(cstIcms, context);
        }),
		DataCell(Text('${cstIcms.codigo ?? ''}'), onTap: () {
			detalharCstIcms(cstIcms, context);
		}),
		DataCell(Text('${cstIcms.descricao ?? ''}'), onTap: () {
			detalharCstIcms(cstIcms, context);
		}),
		DataCell(Text('${cstIcms.observacao ?? ''}'), onTap: () {
			detalharCstIcms(cstIcms, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaCstIcms.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharCstIcms(CstIcms cstIcms, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/cstIcmsDetalhe',
    arguments: cstIcms,
  );
}