/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [PRODUTO_MARCA] 
                                                                                
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
import 'produto_marca_persiste_page.dart';

class ProdutoMarcaListaPage extends StatefulWidget {
  @override
  _ProdutoMarcaListaPageState createState() => _ProdutoMarcaListaPageState();
}

class _ProdutoMarcaListaPageState extends State<ProdutoMarcaListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ProdutoMarcaViewModel>(context).listaProdutoMarca == null && Provider.of<ProdutoMarcaViewModel>(context).objetoJsonErro == null) {
      Provider.of<ProdutoMarcaViewModel>(context).consultarLista();
    }
    var listaProdutoMarca = Provider.of<ProdutoMarcaViewModel>(context).listaProdutoMarca;
    var colunas = ProdutoMarca.colunas;
    var campos = ProdutoMarca.campos;

    final ProdutoMarcaDataSource _produtoMarcaDataSource =
        ProdutoMarcaDataSource(listaProdutoMarca, context);

    void _sort<T>(Comparable<T> getField(ProdutoMarca produtoMarca), int columnIndex, bool ascending) {
      _produtoMarcaDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ProdutoMarcaViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Produto Marca'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ProdutoMarcaViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Produto Marca'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  ProdutoMarcaPersistePage(produtoMarca: ProdutoMarca(), title: 'Produto Marca - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<ProdutoMarcaViewModel>(context).consultarLista();
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
                          title: 'Produto Marca - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ProdutoMarcaViewModel>(context)
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
            child: listaProdutoMarca == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Produto Marca'),
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
									_sort<num>((ProdutoMarca produtoMarca) => produtoMarca.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ProdutoMarca produtoMarca) => produtoMarca.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ProdutoMarca produtoMarca) => produtoMarca.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _produtoMarcaDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<ProdutoMarcaViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class ProdutoMarcaDataSource extends DataTableSource {
  final List<ProdutoMarca> listaProdutoMarca;
  final BuildContext context;

  ProdutoMarcaDataSource(this.listaProdutoMarca, this.context);

  void _sort<T>(Comparable<T> getField(ProdutoMarca produtoMarca), bool ascending) {
    listaProdutoMarca.sort((ProdutoMarca a, ProdutoMarca b) {
      if (!ascending) {
        final ProdutoMarca c = a;
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
    if (index >= listaProdutoMarca.length) return null;
    final ProdutoMarca produtoMarca = listaProdutoMarca[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ produtoMarca.id ?? ''}'), onTap: () {
          detalharProdutoMarca(produtoMarca, context);
        }),
		DataCell(Text('${produtoMarca.nome ?? ''}'), onTap: () {
			detalharProdutoMarca(produtoMarca, context);
		}),
		DataCell(Text('${produtoMarca.descricao ?? ''}'), onTap: () {
			detalharProdutoMarca(produtoMarca, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaProdutoMarca.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharProdutoMarca(ProdutoMarca produtoMarca, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/produtoMarcaDetalhe',
    arguments: produtoMarca,
  );
}