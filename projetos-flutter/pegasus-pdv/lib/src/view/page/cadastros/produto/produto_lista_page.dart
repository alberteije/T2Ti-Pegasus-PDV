/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [PRODUTO] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/model/filtro.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/filtro_page.dart';

class ProdutoListaPage extends StatefulWidget {
  const ProdutoListaPage({Key? key}) : super(key: key);

  @override
  _ProdutoListaPageState createState() => _ProdutoListaPageState();
}

class _ProdutoListaPageState extends State<ProdutoListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = ProdutoDao.colunas;
  final _campos = ProdutoDao.campos;

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosListaPage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    WidgetsBinding.instance!.addPostFrameCallback((_) => _refrescarTela());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.inserir:
        _inserir();
        break;
      case AtalhoTelaType.imprimir:
        _gerarRelatorio();
        break;
      case AtalhoTelaType.filtrar:
        _chamarFiltro();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final _listaProdutoMontado = Sessao.db.produtoDao.listaProdutoMontado;

    final _ProdutoDataSource _produtoDataSource = _ProdutoDataSource(_listaProdutoMontado, context, _refrescarTela);

    void _sort<T>(Comparable<T>? Function(ProdutoMontado produtoMontado) getField, int columnIndex, bool ascending) {
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
            title: const Text('Cadastro - Produto'),
            actions: const <Widget>[],
          ),
          floatingActionButton: FloatingActionButton(
            focusColor: ViewUtilLib.getBotaoFocusColor(),
            tooltip: Constantes.botaoInserirDica,
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              _inserir();
            }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),          
            shape: const CircularNotchedRectangle(),
            child: Row(
              children: getBotoesNavigationBarListaPage(
                context: context, 
                chamarFiltro: _chamarFiltro, 
                gerarRelatorio: _gerarRelatorio,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              // isAlwaysShown: true,
              child: _listaProdutoMontado == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(  
                    header: const Text('Relação - Produto'),
                    rowsPerPage: _rowsPerPage!,
                    onRowsPerPageChanged: (int? value) {
                      setState(() {
                        _rowsPerPage = value;
                      });
                    },
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    columns: _pegarColunas(_sort),                    
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

  List<DataColumn> _pegarColunas(Function _sort) {
    final List<DataColumn> _colunas = [];
    _colunas.add(
      DataColumn(
        numeric: true,
        label: const Text('Id'),
        tooltip: 'Id',
        onSort: (int columnIndex, bool ascending) =>
          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto!.id, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        label: const Text('Tipo'),
        tooltip: 'Conteúdo para o campo Tipo',
        onSort: (int columnIndex, bool ascending) =>
          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produtoTipo!.descricao, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        label: const Text('Subgrupo'),
        tooltip: 'Conteúdo para o campo Subgrupo',
        onSort: (int columnIndex, bool ascending) =>
          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produtoSubgrupo!.nome, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        label: const Text('Unidade'),
        tooltip: 'Conteúdo para o campo Unidade',
        onSort: (int columnIndex, bool ascending) =>
          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produtoUnidade!.sigla, columnIndex, ascending),
      ),
    );
    if(Sessao.configuracaoPdv!.modulo != 'G') { // não mostra a coluna do grupo tributário para o módulo gratuito
      _colunas.add(   
        DataColumn(
          label: const Text('Grupo Tributário'),
          tooltip: 'Conteúdo para o campo Grupo Tributário',
          onSort: (int columnIndex, bool ascending) =>
            _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.tributGrupoTributario!.descricao, columnIndex, ascending),
        ),
      );
    }
    _colunas.add(
      DataColumn(
        label: const Text('Gtin'),
        tooltip: 'Conteúdo para o campo Gtin',
        onSort: (int columnIndex, bool ascending) =>
          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produto!.gtin, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        label: const Text('Codigo Interno'),
        tooltip: 'Conteúdo para o campo Codigo Interno',
        onSort: (int columnIndex, bool ascending) =>
          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produto!.codigoInterno, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        label: const Text('Nome'),
        tooltip: 'Conteúdo para o campo Nome',
        onSort: (int columnIndex, bool ascending) =>
          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produto!.nome, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        label: const Text('Descricao'),
        tooltip: 'Conteúdo para o campo Descricao',
        onSort: (int columnIndex, bool ascending) =>
          _sort<String>((ProdutoMontado produtoMontado) => produtoMontado.produto!.descricao, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        numeric: true,
        label: const Text('Valor Compra'),
        tooltip: 'Conteúdo para o campo Valor Compra',
        onSort: (int columnIndex, bool ascending) =>
          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto!.valorCompra, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        numeric: true,
        label: const Text('Valor Venda'),
        tooltip: 'Conteúdo para o campo Valor Venda',
        onSort: (int columnIndex, bool ascending) =>
          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto!.valorVenda, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        numeric: true,
        label: const Text('Valor Custo'),
        tooltip: 'Conteúdo para o campo Valor Custo',
        onSort: (int columnIndex, bool ascending) =>
          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto!.valorCusto, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        numeric: true,
        label: const Text('Quantidade Estoque'),
        tooltip: 'Conteúdo para o campo Quantidade Estoque',
        onSort: (int columnIndex, bool ascending) =>
          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto!.quantidadeEstoque, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        numeric: true,
        label: const Text('Estoque Minimo'),
        tooltip: 'Conteúdo para o campo Estoque Minimo',
        onSort: (int columnIndex, bool ascending) =>
          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto!.estoqueMinimo, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        numeric: true,
        label: const Text('Estoque Maximo'),
        tooltip: 'Conteúdo para o campo Estoque Maximo',
        onSort: (int columnIndex, bool ascending) =>
          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto!.estoqueMaximo, columnIndex, ascending),
      ),
    );
    _colunas.add(
      DataColumn(
        numeric: true,
        label: const Text('IPPT'),
        tooltip: 'Produção [P]rópria ou [T]erceiros',
        onSort: (int columnIndex, bool ascending) =>
          _sort<num>((ProdutoMontado produtoMontado) => produtoMontado.produto!.ippt, columnIndex, ascending),
      ),
    );
    return _colunas;
  }

  void _inserir() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => 
            ProdutoPage(
              produtoMontado: ProdutoMontado(
                produto: Produto(id: null, situacao: 'A'), 
                produtoUnidade: ProdutoUnidade(id: null,),
                tributGrupoTributario: TributGrupoTributario(id: null),
                produtoTipo: ProdutoTipo(id: null),
                cardapio: Cardapio(id: null),
                produtoSubgrupo: ProdutoSubgrupo(id: null),
              ), 
              title: 'Produto - Inserindo', operacao: 'I')
            ))
      .then((_) async {
        await _refrescarTela();
    });
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
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.produtoDao.consultarListaMontado(campo: _filtro!.campo, valor: _filtro!.valor);
        setState(() {
        });
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxInformacao(
      context, 'Essa janela não possui relatório implementado');
  }

  Future _refrescarTela() async {
    await Sessao.db.produtoDao.consultarListaMontado();
    setState(() {
    });
  }
}


/// codigo referente a fonte de dados
class _ProdutoDataSource extends DataTableSource {
  final List<ProdutoMontado>? listaProduto;
  final BuildContext context;
  final Function refrescarTela;
 
  _ProdutoDataSource(this.listaProduto, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T>? Function(ProdutoMontado produto) getField, bool ascending) {
    listaProduto!.sort((ProdutoMontado a, ProdutoMontado b) {
      if (!ascending) {
        final ProdutoMontado c = a;
        a = b;
        b = c;
      }
      Comparable<T>? aValue = getField(a);
      Comparable<T>? bValue = getField(b);

      aValue ??= '' as Comparable<T>;
      bValue ??= '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
  }

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    // assert(index >= 0);
    if (index >= listaProduto!.length) return null;
    return DataRow.byIndex(
      index: index,
      cells: _pegarCelulas(index),
    );
  }

  List<DataCell> _pegarCelulas(int index) {
    final ProdutoMontado produtoMontado = listaProduto![index];
    final Produto produto = produtoMontado.produto!;
    List<DataCell> _celulas = [];
    _celulas.add(
      DataCell(Text('${produto.id ?? ''}'), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(produtoMontado.produtoTipo?.descricao ?? ''), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(produtoMontado.produtoSubgrupo?.nome ?? ''), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(produtoMontado.produtoUnidade?.sigla ?? ''), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    if(Sessao.configuracaoPdv!.modulo != 'G') {
      _celulas.add(
        DataCell(Text(produtoMontado.tributGrupoTributario?.descricao ?? ''), onTap: () {
          _detalharProduto(produtoMontado, context, refrescarTela);
        }) 
      );
    }
    _celulas.add(
      DataCell(Text(produto.gtin ?? ''), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(produto.codigoInterno ?? ''), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(produto.nome ?? ''), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(produto.descricao ?? ''), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(Biblioteca.formatarValorDecimal(produto.valorCompra)), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(Biblioteca.formatarValorDecimal(produto.valorVenda)), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(Biblioteca.formatarValorDecimal(produto.valorCusto)), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(Biblioteca.formatarValorDecimal(produto.quantidadeEstoque)), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(Biblioteca.formatarValorDecimal(produto.estoqueMinimo)), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(Biblioteca.formatarValorDecimal(produto.estoqueMaximo)), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    _celulas.add(
      DataCell(Text(produto.ippt ?? ''), onTap: () {
        _detalharProduto(produtoMontado, context, refrescarTela);
      }),
    );
    return _celulas;
  }

  @override
  int get rowCount => listaProduto!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharProduto(ProdutoMontado produtoMontado, BuildContext context, Function refrescarTela) {
  produtoMontado.tributGrupoTributario ??= TributGrupoTributario(id: null); // se tributGrupoTributario for nulo, instancia
  produtoMontado.produtoTipo ??= ProdutoTipo(id: null); // se produtoTipo for nulo, instancia
  produtoMontado.cardapio ??= Cardapio(id: null); // se cardapio for nulo, instancia
  produtoMontado.produtoSubgrupo ??= ProdutoSubgrupo(id: null); // se produtoSubgrupo for nulo, instancia

  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => ProdutoPage(
      produtoMontado: produtoMontado, title: 'Produto - Editando', operacao: 'A')))
    .then((_) async {    
      await refrescarTela();
   });
}