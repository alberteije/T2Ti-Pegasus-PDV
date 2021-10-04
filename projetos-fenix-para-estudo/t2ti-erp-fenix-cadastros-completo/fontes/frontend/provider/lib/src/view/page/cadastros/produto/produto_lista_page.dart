/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [PRODUTO] 
                                                                                
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
import 'package:intl/intl.dart';
import 'produto_persiste_page.dart';

class ProdutoListaPage extends StatefulWidget {
  @override
  _ProdutoListaPageState createState() => _ProdutoListaPageState();
}

class _ProdutoListaPageState extends State<ProdutoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ProdutoViewModel>(context).listaProduto == null && Provider.of<ProdutoViewModel>(context).objetoJsonErro == null) {
      Provider.of<ProdutoViewModel>(context).consultarLista();
    }
    var listaProduto = Provider.of<ProdutoViewModel>(context).listaProduto;
    var colunas = Produto.colunas;
    var campos = Produto.campos;

    final ProdutoDataSource _produtoDataSource =
        ProdutoDataSource(listaProduto, context);

    void _sort<T>(Comparable<T> getField(Produto produto), int columnIndex, bool ascending) {
      _produtoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ProdutoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Produto'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ProdutoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Produto'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  ProdutoPersistePage(produto: Produto(), title: 'Produto - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<ProdutoViewModel>(context).consultarLista();
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
                          title: 'Produto - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ProdutoViewModel>(context)
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
            child: listaProduto == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Produto'),
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
									_sort<num>((Produto produto) => produto.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Subgrupo'),
								tooltip: 'Subgrupo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Produto produto) => produto.produtoSubgrupo?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Marca'),
								tooltip: 'Marca',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Produto produto) => produto.produtoMarca?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Unidade'),
								tooltip: 'Unidade',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Produto produto) => produto.produtoUnidade?.sigla,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Produto produto) => produto.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Produto produto) => produto.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('GTIN'),
								tooltip: 'GTIN',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Produto produto) => produto.gtin,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código Interno'),
								tooltip: 'Código Interno',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Produto produto) => produto.codigoInterno,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Compra'),
								tooltip: 'Valor Compra',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Produto produto) => produto.valorCompra,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Venda'),
								tooltip: 'Valor Venda',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Produto produto) => produto.valorVenda,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('NCM'),
								tooltip: 'NCM',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Produto produto) => produto.ncm,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Estoque Mínimo'),
								tooltip: 'Estoque Mínimo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Produto produto) => produto.estoqueMinimo,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Estoque Máximo'),
								tooltip: 'Estoque Máximo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Produto produto) => produto.estoqueMaximo,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Quantidade em Estoque'),
								tooltip: 'Quantidade em Estoque',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Produto produto) => produto.quantidadeEstoque,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Cadastro'),
								tooltip: 'Data de Cadastro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Produto produto) => produto.dataCadastro,
									columnIndex, ascending),
							),
                        ],
                        source: _produtoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<ProdutoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class ProdutoDataSource extends DataTableSource {
  final List<Produto> listaProduto;
  final BuildContext context;

  ProdutoDataSource(this.listaProduto, this.context);

  void _sort<T>(Comparable<T> getField(Produto produto), bool ascending) {
    listaProduto.sort((Produto a, Produto b) {
      if (!ascending) {
        final Produto c = a;
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
    if (index >= listaProduto.length) return null;
    final Produto produto = listaProduto[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ produto.id ?? ''}'), onTap: () {
          detalharProduto(produto, context);
        }),
		DataCell(Text('${produto.produtoSubgrupo?.nome ?? ''}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.produtoMarca?.nome ?? ''}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.produtoUnidade?.sigla ?? ''}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.nome ?? ''}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.descricao ?? ''}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.gtin ?? ''}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.codigoInterno ?? ''}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.valorCompra != null ? Constantes.formatoDecimalValor.format(produto.valorCompra) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.valorVenda != null ? Constantes.formatoDecimalValor.format(produto.valorVenda) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.ncm ?? ''}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.estoqueMinimo != null ? Constantes.formatoDecimalQuantidade.format(produto.estoqueMinimo) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.estoqueMaximo != null ? Constantes.formatoDecimalQuantidade.format(produto.estoqueMaximo) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.quantidadeEstoque != null ? Constantes.formatoDecimalQuantidade.format(produto.quantidadeEstoque) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharProduto(produto, context);
		}),
		DataCell(Text('${produto.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(produto.dataCadastro) : ''}'), onTap: () {
			detalharProduto(produto, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaProduto.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharProduto(Produto produto, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/produtoDetalhe',
    arguments: produto,
  );
}