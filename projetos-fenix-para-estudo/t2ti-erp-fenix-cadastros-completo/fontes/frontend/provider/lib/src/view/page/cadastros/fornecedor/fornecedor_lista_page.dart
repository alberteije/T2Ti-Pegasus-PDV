/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FORNECEDOR] 
                                                                                
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
import 'fornecedor_persiste_page.dart';

class FornecedorListaPage extends StatefulWidget {
  @override
  _FornecedorListaPageState createState() => _FornecedorListaPageState();
}

class _FornecedorListaPageState extends State<FornecedorListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FornecedorViewModel>(context).listaFornecedor == null && Provider.of<FornecedorViewModel>(context).objetoJsonErro == null) {
      Provider.of<FornecedorViewModel>(context).consultarLista();
    }
    var listaFornecedor = Provider.of<FornecedorViewModel>(context).listaFornecedor;
    var colunas = Fornecedor.colunas;
    var campos = Fornecedor.campos;

    final FornecedorDataSource _fornecedorDataSource =
        FornecedorDataSource(listaFornecedor, context);

    void _sort<T>(Comparable<T> getField(Fornecedor fornecedor), int columnIndex, bool ascending) {
      _fornecedorDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FornecedorViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Fornecedor'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FornecedorViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Fornecedor'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FornecedorPersistePage(fornecedor: Fornecedor(), title: 'Fornecedor - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FornecedorViewModel>(context).consultarLista();
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
                          title: 'Fornecedor - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FornecedorViewModel>(context)
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
            child: listaFornecedor == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Fornecedor'),
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
									_sort<num>((Fornecedor fornecedor) => fornecedor.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Pessoa'),
								tooltip: 'Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Fornecedor fornecedor) => fornecedor.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Desde'),
								tooltip: 'Fornecedor Desde',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Fornecedor fornecedor) => fornecedor.desde,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Cadastro'),
								tooltip: 'Data de Cadastro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Fornecedor fornecedor) => fornecedor.dataCadastro,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Fornecedor fornecedor) => fornecedor.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _fornecedorDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FornecedorViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FornecedorDataSource extends DataTableSource {
  final List<Fornecedor> listaFornecedor;
  final BuildContext context;

  FornecedorDataSource(this.listaFornecedor, this.context);

  void _sort<T>(Comparable<T> getField(Fornecedor fornecedor), bool ascending) {
    listaFornecedor.sort((Fornecedor a, Fornecedor b) {
      if (!ascending) {
        final Fornecedor c = a;
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
    if (index >= listaFornecedor.length) return null;
    final Fornecedor fornecedor = listaFornecedor[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ fornecedor.id ?? ''}'), onTap: () {
          detalharFornecedor(fornecedor, context);
        }),
		DataCell(Text('${fornecedor.pessoa?.nome ?? ''}'), onTap: () {
			detalharFornecedor(fornecedor, context);
		}),
		DataCell(Text('${fornecedor.desde ?? ''}'), onTap: () {
			detalharFornecedor(fornecedor, context);
		}),
		DataCell(Text('${fornecedor.dataCadastro ?? ''}'), onTap: () {
			detalharFornecedor(fornecedor, context);
		}),
		DataCell(Text('${fornecedor.observacao ?? ''}'), onTap: () {
			detalharFornecedor(fornecedor, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFornecedor.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFornecedor(Fornecedor fornecedor, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/fornecedorDetalhe',
    arguments: fornecedor,
  );
}