/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [PRODUTO_SUBGRUPO] 
                                                                                
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
import 'produto_subgrupo_persiste_page.dart';

class ProdutoSubgrupoListaPage extends StatefulWidget {
  @override
  _ProdutoSubgrupoListaPageState createState() => _ProdutoSubgrupoListaPageState();
}

class _ProdutoSubgrupoListaPageState extends State<ProdutoSubgrupoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ProdutoSubgrupoViewModel>(context).listaProdutoSubgrupo == null && Provider.of<ProdutoSubgrupoViewModel>(context).objetoJsonErro == null) {
      Provider.of<ProdutoSubgrupoViewModel>(context).consultarLista();
    }
    var listaProdutoSubgrupo = Provider.of<ProdutoSubgrupoViewModel>(context).listaProdutoSubgrupo;
    var colunas = ProdutoSubgrupo.colunas;
    var campos = ProdutoSubgrupo.campos;

    final ProdutoSubgrupoDataSource _produtoSubgrupoDataSource =
        ProdutoSubgrupoDataSource(listaProdutoSubgrupo, context);

    void _sort<T>(Comparable<T> getField(ProdutoSubgrupo produtoSubgrupo), int columnIndex, bool ascending) {
      _produtoSubgrupoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ProdutoSubgrupoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Produto Subgrupo'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ProdutoSubgrupoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Produto Subgrupo'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  ProdutoSubgrupoPersistePage(produtoSubgrupo: ProdutoSubgrupo(), title: 'Produto Subgrupo - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<ProdutoSubgrupoViewModel>(context).consultarLista();
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
                          title: 'Produto Subgrupo - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ProdutoSubgrupoViewModel>(context)
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
            child: listaProdutoSubgrupo == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Produto Subgrupo'),
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
									_sort<num>((ProdutoSubgrupo produtoSubgrupo) => produtoSubgrupo.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Grupo'),
								tooltip: 'Grupo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ProdutoSubgrupo produtoSubgrupo) => produtoSubgrupo.produtoGrupo?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ProdutoSubgrupo produtoSubgrupo) => produtoSubgrupo.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ProdutoSubgrupo produtoSubgrupo) => produtoSubgrupo.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _produtoSubgrupoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<ProdutoSubgrupoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class ProdutoSubgrupoDataSource extends DataTableSource {
  final List<ProdutoSubgrupo> listaProdutoSubgrupo;
  final BuildContext context;

  ProdutoSubgrupoDataSource(this.listaProdutoSubgrupo, this.context);

  void _sort<T>(Comparable<T> getField(ProdutoSubgrupo produtoSubgrupo), bool ascending) {
    listaProdutoSubgrupo.sort((ProdutoSubgrupo a, ProdutoSubgrupo b) {
      if (!ascending) {
        final ProdutoSubgrupo c = a;
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
    if (index >= listaProdutoSubgrupo.length) return null;
    final ProdutoSubgrupo produtoSubgrupo = listaProdutoSubgrupo[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ produtoSubgrupo.id ?? ''}'), onTap: () {
          detalharProdutoSubgrupo(produtoSubgrupo, context);
        }),
		DataCell(Text('${produtoSubgrupo.produtoGrupo?.nome ?? ''}'), onTap: () {
			detalharProdutoSubgrupo(produtoSubgrupo, context);
		}),
		DataCell(Text('${produtoSubgrupo.nome ?? ''}'), onTap: () {
			detalharProdutoSubgrupo(produtoSubgrupo, context);
		}),
		DataCell(Text('${produtoSubgrupo.descricao ?? ''}'), onTap: () {
			detalharProdutoSubgrupo(produtoSubgrupo, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaProdutoSubgrupo.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharProdutoSubgrupo(ProdutoSubgrupo produtoSubgrupo, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/produtoSubgrupoDetalhe',
    arguments: produtoSubgrupo,
  );
}