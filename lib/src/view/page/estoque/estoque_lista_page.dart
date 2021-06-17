/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [PRODUTO] - Estoque 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/model/filtro.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/page/filtro_page.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

import 'package:pegasus_pdv/src/view/page/compras/pedido/compra_pedido_cabecalho_lista_page.dart';

class EstoqueListaPage extends StatefulWidget {
  @override
  _EstoqueListaPageState createState() => _EstoqueListaPageState();
}

class _EstoqueListaPageState extends State<EstoqueListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  String _statusEstoque = 'Todos';
  var _filtro = Filtro();
  final _colunas = ProdutoDao.colunas;
  final _campos = ProdutoDao.campos;
  var _listaProdutoMontado;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosListaPage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) => _refrescarTela());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.filtrar:
        _chamarFiltro();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    _listaProdutoMontado = Sessao.db.produtoDao.listaProdutoMontado;

    final _ProdutoDataSource _produtoDataSource = _ProdutoDataSource(_listaProdutoMontado, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(ProdutoMontado produtoMontado), int columnIndex, bool ascending) {
      _produtoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }
	
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Estoque'),
            actions: <Widget>[
              getBotaoGerarPedido(context: context, gerarPedido: _gerarPedido,),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),          
            shape: CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(              
                children: <Widget> [ 
                  Expanded(
                    flex: 1,
                    child: 
                    InputDecorator(
                      decoration: getInputDecoration(
                        'Status Estoque',
                        'Status Estoque',
                        true, paddingVertical: 1),
                      isEmpty: _statusEstoque == null,
                      child: getDropDownButton(_statusEstoque,
                        (String newValue) {
                          _statusEstoque = newValue;
                          _refrescarTela();
                      }, <String>[
                        'Todos',
                        'Crítico',
                      ]),
                    ),                  
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 0,
                    child: getBotaoFiltro(
                      context: context, 
                      chamarFiltro: _chamarFiltro,),
                  ),
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              child: _listaProdutoMontado == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Produtos'),
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
                        numeric: true,
                        label: const Text('Id'),
                        tooltip: 'Id',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Quantidade Estoque'),
                        tooltip: 'Conteúdo para o campo Quantidade Estoque',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto.quantidadeEstoque, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Estoque Minimo'),
                        tooltip: 'Conteúdo para o campo Estoque Minimo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto.estoqueMinimo, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Estoque Maximo'),
                        tooltip: 'Conteúdo para o campo Estoque Maximo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto.estoqueMaximo, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Nome'),
                        tooltip: 'Conteúdo para o campo Nome',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produto.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Unidade'),
                        tooltip: 'Conteúdo para o campo Unidade',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produtoUnidade.sigla, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Gtin'),
                        tooltip: 'Conteúdo para o campo Gtin',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produto.gtin, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Codigo Interno'),
                        tooltip: 'Conteúdo para o campo Codigo Interno',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produto.codigoInterno, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Descricao'),
                        tooltip: 'Conteúdo para o campo Descricao',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produto.descricao, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Descricao Pdv'),
                        tooltip: 'Conteúdo para o campo Descricao Pdv',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produto.descricaoPdv, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Compra'),
                        tooltip: 'Conteúdo para o campo Valor Compra',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto.valorCompra, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Venda'),
                        tooltip: 'Conteúdo para o campo Valor Venda',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto.valorVenda, columnIndex, ascending),
                      ),
                    ],
                    source: _produtoDataSource,
                  ),
                ],
              ),
            ),
          ),          
        ),
      ),
    );
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Produto - Filtro',
            colunas: _colunas,
            campoPesquisaPadrao: 'Nome',
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Sessao.db.produtoDao.consultarListaMontado(campo: _filtro.campo, valor: _filtro.valor);
        setState(() {
        });
      }
    }    
  }

  Future _refrescarTela() async {
    _listaProdutoMontado = await Sessao.db.produtoDao.consultarListaMontado(status: _statusEstoque);
    setState(() {
    });
  }

  void _gerarPedido() {
    double totalPedido = 0;
    
    // monta detalhes
    List<CompraDetalhe> listaCompraDetalhe = [];
    for (ProdutoMontado produtoMontado in _listaProdutoMontado) {
      final produto = produtoMontado.produto;
      if ((produto.quantidadeEstoque ?? 0) < (produto.estoqueMinimo ?? 0)) {
        double quantidade = (produto.quantidadeEstoque * -1) + (produto.estoqueMinimo ?? 0);
        double valorCompra = produto.valorCompra ?? 1;
        CompraPedidoDetalhe compraPedidoDetalhe = 
          CompraPedidoDetalhe(
            id: null,
            idProduto: produto.id,
            quantidade: quantidade,
            valorUnitario: valorCompra,
            valorSubtotal: quantidade * valorCompra,
            valorTotal: quantidade * valorCompra,
          );
        CompraDetalhe compraDetalhe = CompraDetalhe(compraPedidoDetalhe: compraPedidoDetalhe, produto: produto);
        listaCompraDetalhe.add(compraDetalhe);
        totalPedido = totalPedido + compraPedidoDetalhe.valorTotal;
      }
    }     

    if (listaCompraDetalhe.length > 0) {
      // monta cabecalho
      CompraPedidoCabecalho compraPedidoCabecalho = 
        CompraPedidoCabecalho(
          id: null,
          idColaborador: 1, // numa compra realizada a partir do estoque o colaborador ADMINISTRADOR é atribuido por padrão
          dataPedido: DateTime.now(),
          valorSubtotal: totalPedido,
          valorTotal: totalPedido,
        );

      // faz o pedido
      CompraPedidoCabecalhoListaPage.compraPedidoCabecalho = compraPedidoCabecalho;
      CompraPedidoCabecalhoListaPage.listaCompraDetalhe = listaCompraDetalhe;
      Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (BuildContext context) => CompraPedidoCabecalhoListaPage()))
        .then((_) async {    
          await _refrescarTela();
      });
    } else {
      showInSnackBar("Não existem itens para compor um Pedido de Compras.", context);      
    }
    
  }  
}

/// codigo referente a fonte de dados
class _ProdutoDataSource extends DataTableSource {
  final List<ProdutoMontado> listaProduto;
  final BuildContext context;
  final Function refrescarTela;
 
  _ProdutoDataSource(this.listaProduto, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T> getField(ProdutoMontado produto), bool ascending) {
    listaProduto.sort((ProdutoMontado a, ProdutoMontado b) {
      if (!ascending) {
        final ProdutoMontado c = a;
        a = b;
        b = c;
      }
      Comparable<T> aValue = getField(a);
      Comparable<T> bValue = getField(b);

      if (aValue == null) aValue = '' as Comparable<T>;
      if (bValue == null) bValue = '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    if (index >= listaProduto.length) return null;
    final ProdutoMontado produtoMontado = listaProduto[index];
    final Produto produto = produtoMontado.produto;
    return DataRow.byIndex(
      color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if ((produto.quantidadeEstoque ?? 0) < (produto.estoqueMinimo ?? 0))
          return Theme.of(context).colorScheme.error.withOpacity(0.2);
        return null;  
      }),
      index: index,
      cells: <DataCell>[
        DataCell(Text('${produto.id ?? ''}'), onTap: () {
        }),
        DataCell(
          Text('${Constantes.formatoDecimalQuantidade.format(produto.quantidadeEstoque ?? 0)}',
          ), onTap: () {
        }),
        DataCell(Text('${Constantes.formatoDecimalQuantidade.format(produto.estoqueMinimo ?? 0)}'), onTap: () {
        }),
        DataCell(Text('${Constantes.formatoDecimalQuantidade.format(produto.estoqueMaximo ?? 0)}'), onTap: () {
        }),
        DataCell(Text('${produto.nome ?? ''}'), onTap: () {
        }),
        DataCell(Text('${produtoMontado.produtoUnidade.sigla ?? ''}'), onTap: () {
        }),
        DataCell(Text('${produto.gtin ?? ''}'), onTap: () {
        }),
        DataCell(Text('${produto.codigoInterno ?? ''}'), onTap: () {
       }),
        DataCell(Text('${produto.descricao ?? ''}'), onTap: () {
        }),
        DataCell(Text('${produto.descricaoPdv ?? ''}'), onTap: () {
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(produto.valorCompra ?? 0)}'), onTap: () {
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(produto.valorVenda ?? 0)}'), onTap: () {
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

Widget getBotaoGerarPedido({BuildContext context, Function gerarPedido}) {
  if (Biblioteca.isTelaPequena(context)) {
    return getBotaoTelaPequena(
        tooltip: 'Gera Pedido de Compras',                
        icone: Icon(Icons.dashboard_customize),
        onPressed: gerarPedido
      );
  } else {
    return getBotaoTelaGrande(
        texto: 'Gera Pedido de Compras',
        icone: Icon(Icons.dashboard_customize),
        onPressed: gerarPedido,
      );
  }
}
