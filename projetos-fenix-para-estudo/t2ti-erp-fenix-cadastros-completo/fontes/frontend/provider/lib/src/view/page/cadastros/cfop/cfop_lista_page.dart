/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [CFOP] 
                                                                                
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

class CfopListaPage extends StatefulWidget {
  @override
  _CfopListaPageState createState() => _CfopListaPageState();
}

class _CfopListaPageState extends State<CfopListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CfopViewModel>(context).listaCfop == null && Provider.of<CfopViewModel>(context).objetoJsonErro == null) {
      Provider.of<CfopViewModel>(context).consultarLista();
    }
    var listaCfop = Provider.of<CfopViewModel>(context).listaCfop;
    var colunas = Cfop.colunas;
    var campos = Cfop.campos;

    final CfopDataSource _cfopDataSource =
        CfopDataSource(listaCfop, context);

    void _sort<T>(Comparable<T> getField(Cfop cfop), int columnIndex, bool ascending) {
      _cfopDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<CfopViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cfop'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<CfopViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cfop'),
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
                          title: 'Cfop - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<CfopViewModel>(context)
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
            child: listaCfop == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Cfop'),
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
									_sort<num>((Cfop cfop) => cfop.id,
										columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Código'),
								tooltip: 'Código',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Cfop cfop) => cfop.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cfop cfop) => cfop.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Aplicação'),
								tooltip: 'Aplicação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cfop cfop) => cfop.aplicacao,
									columnIndex, ascending),
							),
                        ],
                        source: _cfopDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<CfopViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class CfopDataSource extends DataTableSource {
  final List<Cfop> listaCfop;
  final BuildContext context;

  CfopDataSource(this.listaCfop, this.context);

  void _sort<T>(Comparable<T> getField(Cfop cfop), bool ascending) {
    listaCfop.sort((Cfop a, Cfop b) {
      if (!ascending) {
        final Cfop c = a;
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
    if (index >= listaCfop.length) return null;
    final Cfop cfop = listaCfop[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ cfop.id ?? ''}'), onTap: () {
          detalharCfop(cfop, context);
        }),
		DataCell(Text('${cfop.codigo ?? ''}'), onTap: () {
			detalharCfop(cfop, context);
		}),
		DataCell(Text('${cfop.descricao ?? ''}'), onTap: () {
			detalharCfop(cfop, context);
		}),
		DataCell(Text('${cfop.aplicacao ?? ''}'), onTap: () {
			detalharCfop(cfop, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaCfop.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharCfop(Cfop cfop, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/cfopDetalhe',
    arguments: cfop,
  );
}