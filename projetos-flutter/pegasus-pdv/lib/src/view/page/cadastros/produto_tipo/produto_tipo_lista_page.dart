/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [PRODUTO_TIPO] 
                                                                                
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

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/filtro_page.dart';

import 'produto_tipo_persiste_page.dart';

class ProdutoTipoListaPage extends StatefulWidget {
  const ProdutoTipoListaPage({Key? key}) : super(key: key);

  @override
  _ProdutoTipoListaPageState createState() => _ProdutoTipoListaPageState();
}

class _ProdutoTipoListaPageState extends State<ProdutoTipoListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = ProdutoTipoDao.colunas;
  final _campos = ProdutoTipoDao.campos;

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
    final _listaProdutoTipo = Sessao.db.produtoTipoDao.listaProdutoTipo;

    final _ProdutoTipoDataSource _produtoTipoDataSource = _ProdutoTipoDataSource(_listaProdutoTipo, context, _refrescarTela);
  
    void _sort<T>(Comparable<T>? Function(ProdutoTipo produtoTipo) getField, int columnIndex, bool ascending) {
      _produtoTipoDataSource._sort<T>(getField, ascending);
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
            title: const Text('Cadastro - Produto Tipo'),
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
              child: _listaProdutoTipo == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Relação - Produto Tipo'),
                    rowsPerPage: _rowsPerPage!,
                    onRowsPerPageChanged: (int? value) {
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
                          _sort<num>((ProdutoTipo produtoTipo) => produtoTipo.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Código'),
                        tooltip: 'Código',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoTipo produtoTipo) => produtoTipo.codigo, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Descrição'),
                        tooltip: 'Descrição',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoTipo produtoTipo) => produtoTipo.descricao, columnIndex, ascending),
                      ),
                    ],
                    source: _produtoTipoDataSource,
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
          ProdutoTipoPersistePage(produtoTipo: ProdutoTipo(id: null,), title: 'Produto Tipo - Inserindo', operacao: 'I')))
      .then((_) async {
        await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Produto Tipo - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.produtoTipoDao.consultarListaFiltro(_filtro!.campo!, _filtro!.valor!);
        setState(() {
        });
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxInformacao(context, 'Essa janela não possui relatório implementado');
  }

  Future _refrescarTela() async {
    await Sessao.db.produtoTipoDao.consultarLista();
    setState(() {
    });
  }
}

/// codigo referente a fonte de dados
class _ProdutoTipoDataSource extends DataTableSource {
  final List<ProdutoTipo>? listaProdutoTipo;
  final BuildContext context;
  final Function refrescarTela;

  _ProdutoTipoDataSource(this.listaProdutoTipo, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T>? Function(ProdutoTipo produtoTipo) getField, bool ascending) {
    listaProdutoTipo!.sort((ProdutoTipo a, ProdutoTipo b) {
      if (!ascending) {
        final ProdutoTipo c = a;
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
    assert(index >= 0);
    if (index >= listaProdutoTipo!.length) return null;
    final ProdutoTipo produtoTipo = listaProdutoTipo![index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(produtoTipo.id?.toString() ?? ''), onTap: () {
          _detalharProdutoTipo(produtoTipo, context, refrescarTela);
        }),
        DataCell(Text(produtoTipo.codigo ?? ''), onTap: () {
          _detalharProdutoTipo(produtoTipo, context, refrescarTela);
        }),
        DataCell(Text(produtoTipo.descricao ?? ''), onTap: () {
          _detalharProdutoTipo(produtoTipo, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaProdutoTipo!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharProdutoTipo(ProdutoTipo produtoTipo, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => ProdutoTipoPersistePage(
      produtoTipo: produtoTipo, title: 'ProdutoTipo - Editando', operacao: 'A')))
    .then((_) async {    
      await refrescarTela();
   });
}