/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [UF] 
                                                                                
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

class UfListaPage extends StatefulWidget {
  @override
  _UfListaPageState createState() => _UfListaPageState();
}

class _UfListaPageState extends State<UfListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<UfViewModel>(context).listaUf == null && Provider.of<UfViewModel>(context).objetoJsonErro == null) {
      Provider.of<UfViewModel>(context).consultarLista();
    }
    var listaUf = Provider.of<UfViewModel>(context).listaUf;
    var colunas = Uf.colunas;
    var campos = Uf.campos;

    final UfDataSource _ufDataSource =
        UfDataSource(listaUf, context);

    void _sort<T>(Comparable<T> getField(Uf uf), int columnIndex, bool ascending) {
      _ufDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<UfViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Uf'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<UfViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Uf'),
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
                          title: 'Uf - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<UfViewModel>(context)
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
            child: listaUf == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Uf'),
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
									_sort<num>((Uf uf) => uf.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Sigla'),
								tooltip: 'Sigla',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Uf uf) => uf.sigla,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Uf uf) => uf.nome,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Código IBGE UF'),
								tooltip: 'Código IBGE UF',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Uf uf) => uf.codigoIbge,
									columnIndex, ascending),
							),
                        ],
                        source: _ufDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<UfViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class UfDataSource extends DataTableSource {
  final List<Uf> listaUf;
  final BuildContext context;

  UfDataSource(this.listaUf, this.context);

  void _sort<T>(Comparable<T> getField(Uf uf), bool ascending) {
    listaUf.sort((Uf a, Uf b) {
      if (!ascending) {
        final Uf c = a;
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
    if (index >= listaUf.length) return null;
    final Uf uf = listaUf[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ uf.id ?? ''}'), onTap: () {
          detalharUf(uf, context);
        }),
		DataCell(Text('${uf.sigla ?? ''}'), onTap: () {
			detalharUf(uf, context);
		}),
		DataCell(Text('${uf.nome ?? ''}'), onTap: () {
			detalharUf(uf, context);
		}),
		DataCell(Text('${uf.codigoIbge ?? ''}'), onTap: () {
			detalharUf(uf, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaUf.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharUf(Uf uf, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/ufDetalhe',
    arguments: uf,
  );
}