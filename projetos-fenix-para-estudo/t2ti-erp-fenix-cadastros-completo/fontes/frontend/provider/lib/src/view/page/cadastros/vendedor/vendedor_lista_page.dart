/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [VENDEDOR] 
                                                                                
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
import 'vendedor_persiste_page.dart';

class VendedorListaPage extends StatefulWidget {
  @override
  _VendedorListaPageState createState() => _VendedorListaPageState();
}

class _VendedorListaPageState extends State<VendedorListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<VendedorViewModel>(context).listaVendedor == null && Provider.of<VendedorViewModel>(context).objetoJsonErro == null) {
      Provider.of<VendedorViewModel>(context).consultarLista();
    }
    var listaVendedor = Provider.of<VendedorViewModel>(context).listaVendedor;
    var colunas = Vendedor.colunas;
    var campos = Vendedor.campos;

    final VendedorDataSource _vendedorDataSource =
        VendedorDataSource(listaVendedor, context);

    void _sort<T>(Comparable<T> getField(Vendedor vendedor), int columnIndex, bool ascending) {
      _vendedorDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<VendedorViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Vendedor'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendedorViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Vendedor'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  VendedorPersistePage(vendedor: Vendedor(), title: 'Vendedor - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<VendedorViewModel>(context).consultarLista();
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
                          title: 'Vendedor - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<VendedorViewModel>(context)
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
            child: listaVendedor == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Vendedor'),
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
									_sort<num>((Vendedor vendedor) => vendedor.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Colaborador'),
								tooltip: 'Colaborador',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Vendedor vendedor) => vendedor.colaborador?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Comissão'),
								tooltip: 'Taxa Comissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Vendedor vendedor) => vendedor.comissao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Meta de Venda'),
								tooltip: 'Meta de Venda',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Vendedor vendedor) => vendedor.metaVenda,
									columnIndex, ascending),
							),
                        ],
                        source: _vendedorDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<VendedorViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class VendedorDataSource extends DataTableSource {
  final List<Vendedor> listaVendedor;
  final BuildContext context;

  VendedorDataSource(this.listaVendedor, this.context);

  void _sort<T>(Comparable<T> getField(Vendedor vendedor), bool ascending) {
    listaVendedor.sort((Vendedor a, Vendedor b) {
      if (!ascending) {
        final Vendedor c = a;
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
    if (index >= listaVendedor.length) return null;
    final Vendedor vendedor = listaVendedor[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ vendedor.id ?? ''}'), onTap: () {
          detalharVendedor(vendedor, context);
        }),
		DataCell(Text('${vendedor.colaborador?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendedor(vendedor, context);
		}),
		DataCell(Text('${vendedor.comissao != null ? Constantes.formatoDecimalTaxa.format(vendedor.comissao) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharVendedor(vendedor, context);
		}),
		DataCell(Text('${vendedor.metaVenda != null ? Constantes.formatoDecimalValor.format(vendedor.metaVenda) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendedor(vendedor, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaVendedor.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharVendedor(Vendedor vendedor, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/vendedorDetalhe',
    arguments: vendedor,
  );
}