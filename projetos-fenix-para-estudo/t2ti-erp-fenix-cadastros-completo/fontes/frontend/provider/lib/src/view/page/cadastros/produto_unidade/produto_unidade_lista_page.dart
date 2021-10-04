/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [PRODUTO_UNIDADE] 
                                                                                
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
import 'produto_unidade_persiste_page.dart';

class ProdutoUnidadeListaPage extends StatefulWidget {
  @override
  _ProdutoUnidadeListaPageState createState() => _ProdutoUnidadeListaPageState();
}

class _ProdutoUnidadeListaPageState extends State<ProdutoUnidadeListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ProdutoUnidadeViewModel>(context).listaProdutoUnidade == null && Provider.of<ProdutoUnidadeViewModel>(context).objetoJsonErro == null) {
      Provider.of<ProdutoUnidadeViewModel>(context).consultarLista();
    }
    var listaProdutoUnidade = Provider.of<ProdutoUnidadeViewModel>(context).listaProdutoUnidade;
    var colunas = ProdutoUnidade.colunas;
    var campos = ProdutoUnidade.campos;

    final ProdutoUnidadeDataSource _produtoUnidadeDataSource =
        ProdutoUnidadeDataSource(listaProdutoUnidade, context);

    void _sort<T>(Comparable<T> getField(ProdutoUnidade produtoUnidade), int columnIndex, bool ascending) {
      _produtoUnidadeDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ProdutoUnidadeViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Produto Unidade'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ProdutoUnidadeViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Produto Unidade'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  ProdutoUnidadePersistePage(produtoUnidade: ProdutoUnidade(), title: 'Produto Unidade - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<ProdutoUnidadeViewModel>(context).consultarLista();
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
                          title: 'Produto Unidade - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ProdutoUnidadeViewModel>(context)
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
            child: listaProdutoUnidade == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Produto Unidade'),
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
									_sort<num>((ProdutoUnidade produtoUnidade) => produtoUnidade.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Sigla'),
								tooltip: 'Sigla',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ProdutoUnidade produtoUnidade) => produtoUnidade.sigla,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ProdutoUnidade produtoUnidade) => produtoUnidade.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Pode Fracionar'),
								tooltip: 'Pode Fracionar',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ProdutoUnidade produtoUnidade) => produtoUnidade.podeFracionar,
									columnIndex, ascending),
							),
                        ],
                        source: _produtoUnidadeDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<ProdutoUnidadeViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class ProdutoUnidadeDataSource extends DataTableSource {
  final List<ProdutoUnidade> listaProdutoUnidade;
  final BuildContext context;

  ProdutoUnidadeDataSource(this.listaProdutoUnidade, this.context);

  void _sort<T>(Comparable<T> getField(ProdutoUnidade produtoUnidade), bool ascending) {
    listaProdutoUnidade.sort((ProdutoUnidade a, ProdutoUnidade b) {
      if (!ascending) {
        final ProdutoUnidade c = a;
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
    if (index >= listaProdutoUnidade.length) return null;
    final ProdutoUnidade produtoUnidade = listaProdutoUnidade[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ produtoUnidade.id ?? ''}'), onTap: () {
          detalharProdutoUnidade(produtoUnidade, context);
        }),
		DataCell(Text('${produtoUnidade.sigla ?? ''}'), onTap: () {
			detalharProdutoUnidade(produtoUnidade, context);
		}),
		DataCell(Text('${produtoUnidade.descricao ?? ''}'), onTap: () {
			detalharProdutoUnidade(produtoUnidade, context);
		}),
		DataCell(Text('${produtoUnidade.podeFracionar ?? ''}'), onTap: () {
			detalharProdutoUnidade(produtoUnidade, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaProdutoUnidade.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharProdutoUnidade(ProdutoUnidade produtoUnidade, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/produtoUnidadeDetalhe',
    arguments: produtoUnidade,
  );
}