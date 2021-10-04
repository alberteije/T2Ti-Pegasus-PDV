/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FIN_DOCUMENTO_ORIGEM] 
                                                                                
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
import 'fin_documento_origem_persiste_page.dart';

class FinDocumentoOrigemListaPage extends StatefulWidget {
  @override
  _FinDocumentoOrigemListaPageState createState() => _FinDocumentoOrigemListaPageState();
}

class _FinDocumentoOrigemListaPageState extends State<FinDocumentoOrigemListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinDocumentoOrigemViewModel>(context).listaFinDocumentoOrigem == null && Provider.of<FinDocumentoOrigemViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinDocumentoOrigemViewModel>(context).consultarLista();
    }
    var listaFinDocumentoOrigem = Provider.of<FinDocumentoOrigemViewModel>(context).listaFinDocumentoOrigem;
    var colunas = FinDocumentoOrigem.colunas;
    var campos = FinDocumentoOrigem.campos;

    final FinDocumentoOrigemDataSource _finDocumentoOrigemDataSource =
        FinDocumentoOrigemDataSource(listaFinDocumentoOrigem, context);

    void _sort<T>(Comparable<T> getField(FinDocumentoOrigem finDocumentoOrigem), int columnIndex, bool ascending) {
      _finDocumentoOrigemDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinDocumentoOrigemViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Documento Origem'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinDocumentoOrigemViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Documento Origem'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FinDocumentoOrigemPersistePage(finDocumentoOrigem: FinDocumentoOrigem(), title: 'Documento Origem - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinDocumentoOrigemViewModel>(context).consultarLista();
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
                          title: 'Documento Origem - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinDocumentoOrigemViewModel>(context)
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
            child: listaFinDocumentoOrigem == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Documento Origem'),
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
									_sort<num>((FinDocumentoOrigem finDocumentoOrigem) => finDocumentoOrigem.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código'),
								tooltip: 'Código',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinDocumentoOrigem finDocumentoOrigem) => finDocumentoOrigem.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Sigla'),
								tooltip: 'Sigla',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinDocumentoOrigem finDocumentoOrigem) => finDocumentoOrigem.sigla,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinDocumentoOrigem finDocumentoOrigem) => finDocumentoOrigem.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _finDocumentoOrigemDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinDocumentoOrigemViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinDocumentoOrigemDataSource extends DataTableSource {
  final List<FinDocumentoOrigem> listaFinDocumentoOrigem;
  final BuildContext context;

  FinDocumentoOrigemDataSource(this.listaFinDocumentoOrigem, this.context);

  void _sort<T>(Comparable<T> getField(FinDocumentoOrigem finDocumentoOrigem), bool ascending) {
    listaFinDocumentoOrigem.sort((FinDocumentoOrigem a, FinDocumentoOrigem b) {
      if (!ascending) {
        final FinDocumentoOrigem c = a;
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
    if (index >= listaFinDocumentoOrigem.length) return null;
    final FinDocumentoOrigem finDocumentoOrigem = listaFinDocumentoOrigem[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finDocumentoOrigem.id ?? ''}'), onTap: () {
          detalharFinDocumentoOrigem(finDocumentoOrigem, context);
        }),
		DataCell(Text('${finDocumentoOrigem.codigo ?? ''}'), onTap: () {
			detalharFinDocumentoOrigem(finDocumentoOrigem, context);
		}),
		DataCell(Text('${finDocumentoOrigem.sigla ?? ''}'), onTap: () {
			detalharFinDocumentoOrigem(finDocumentoOrigem, context);
		}),
		DataCell(Text('${finDocumentoOrigem.descricao ?? ''}'), onTap: () {
			detalharFinDocumentoOrigem(finDocumentoOrigem, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinDocumentoOrigem.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinDocumentoOrigem(FinDocumentoOrigem finDocumentoOrigem, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finDocumentoOrigemDetalhe',
    arguments: finDocumentoOrigem,
  );
}