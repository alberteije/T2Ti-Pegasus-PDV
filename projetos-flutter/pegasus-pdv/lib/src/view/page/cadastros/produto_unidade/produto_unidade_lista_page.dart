/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [PRODUTO_UNIDADE] 
                                                                                
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

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/filtro_page.dart';

import 'produto_unidade_persiste_page.dart';

class ProdutoUnidadeListaPage extends StatefulWidget {
  @override
  _ProdutoUnidadeListaPageState createState() => _ProdutoUnidadeListaPageState();
}

class _ProdutoUnidadeListaPageState extends State<ProdutoUnidadeListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = ProdutoUnidadeDao.colunas;
  final _campos = ProdutoUnidadeDao.campos;

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
    final _listaProdutoUnidade = Sessao.db.produtoUnidadeDao.listaProdutoUnidade;

    final _ProdutoUnidadeDataSource _produtoUnidadeDataSource = _ProdutoUnidadeDataSource(_listaProdutoUnidade, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(ProdutoUnidade produtoUnidade), int columnIndex, bool ascending) {
      _produtoUnidadeDataSource._sort<T>(getField, ascending);
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
            title: const Text('Cadastro - Produto Unidade'),
            actions: <Widget>[],
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
            shape: CircularNotchedRectangle(),
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
              child: _listaProdutoUnidade == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
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
                        numeric: true,
                        label: const Text('Id'),
                        tooltip: 'Id',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ProdutoUnidade produtoUnidade) => produtoUnidade.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Sigla'),
                        tooltip: 'Conteúdo para o campo Sigla',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoUnidade produtoUnidade) => produtoUnidade.sigla, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Descricao'),
                        tooltip: 'Conteúdo para o campo Descricao',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoUnidade produtoUnidade) => produtoUnidade.descricao, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Pode Fracionar'),
                        tooltip: 'Conteúdo para o campo Pode Fracionar',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoUnidade produtoUnidade) => produtoUnidade.podeFracionar, columnIndex, ascending),
                      ),
                    ],
                    source: _produtoUnidadeDataSource,
                  ),
                ],
              ),
            ),
          ),          
        ),
      ),
    );
  }

  void _inserir() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => 
            ProdutoUnidadePersistePage(produtoUnidade: ProdutoUnidade(id: null,), title: 'Produto Unidade - Inserindo', operacao: 'I')))
      .then((_) async {
        await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Produto Unidade - Filtro',
            colunas: _colunas,
            campoPesquisaPadrao: 'Sigla',
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Sessao.db.produtoUnidadeDao.consultarListaFiltro(_filtro.campo, _filtro.valor);
        setState(() {
        });
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxInformacao(context, 'Essa janela não possui relatório implementado');
  }

  Future _refrescarTela() async {
    await Sessao.db.produtoUnidadeDao.consultarLista();
    setState(() {
    });
  }
}

/// codigo referente a fonte de dados
class _ProdutoUnidadeDataSource extends DataTableSource {
  final List<ProdutoUnidade> listaProdutoUnidade;
  final BuildContext context;
  final Function refrescarTela;
 
  _ProdutoUnidadeDataSource(this.listaProdutoUnidade, this.context, this.refrescarTela);

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
        DataCell(Text('${produtoUnidade.id ?? ''}'), onTap: () {
          _detalharProdutoUnidade(produtoUnidade, context, refrescarTela);
        }),
        DataCell(Text('${produtoUnidade.sigla ?? ''}'), onTap: () {
          _detalharProdutoUnidade(produtoUnidade, context, refrescarTela);
        }),
        DataCell(Text('${produtoUnidade.descricao ?? ''}'), onTap: () {
          _detalharProdutoUnidade(produtoUnidade, context, refrescarTela);
        }),
        DataCell(Text('${produtoUnidade.podeFracionar ?? ''}'), onTap: () {
          _detalharProdutoUnidade(produtoUnidade, context, refrescarTela);
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

void _detalharProdutoUnidade(ProdutoUnidade produtoUnidade, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => ProdutoUnidadePersistePage(
      produtoUnidade: produtoUnidade, title: 'Produto Unidade - Editando', operacao: 'A')))
    .then((_) async {    
      await refrescarTela();
   });
}