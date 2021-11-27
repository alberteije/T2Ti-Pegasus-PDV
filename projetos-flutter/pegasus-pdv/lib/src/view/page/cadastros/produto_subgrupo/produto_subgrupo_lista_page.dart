/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [PRODUTO_SUBGRUPO] 
                                                                                
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

import 'produto_subgrupo_persiste_page.dart';

class ProdutoSubgrupoListaPage extends StatefulWidget {
  const ProdutoSubgrupoListaPage({Key? key}) : super(key: key);

  @override
  _ProdutoSubgrupoListaPageState createState() => _ProdutoSubgrupoListaPageState();
}

class _ProdutoSubgrupoListaPageState extends State<ProdutoSubgrupoListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = ProdutoSubgrupoDao.colunas;
  final _campos = ProdutoSubgrupoDao.campos;

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
    final _listaProdutoSubgrupoMontadoMontado = Sessao.db.produtoSubgrupoDao.listaProdutoSubgrupoMontado;

    final _ProdutoSubgrupoMontadoDataSource _produtoSubgrupoMontadoDataSource = _ProdutoSubgrupoMontadoDataSource(_listaProdutoSubgrupoMontadoMontado, context, _refrescarTela);
  
    void _sort<T>(Comparable<T>? Function(ProdutoSubgrupoMontado produtoSubgrupoMontado) getField, int columnIndex, bool ascending) {
      _produtoSubgrupoMontadoDataSource._sort<T>(getField, ascending);
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
            title: const Text('Cadastro - Produto Subgrupo'),
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
              child: _listaProdutoSubgrupoMontadoMontado == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Relação - Produto Subgrupo'),
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
                          _sort<num>((ProdutoSubgrupoMontado produtoSubgrupoMontado) => produtoSubgrupoMontado.produtoSubgrupo!.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Grupo'),
                        tooltip: 'Grupo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoSubgrupoMontado produtoSubgrupoMontado) => produtoSubgrupoMontado.produtoGrupo!.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Nome'),
                        tooltip: 'Nome',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoSubgrupoMontado produtoSubgrupoMontado) => produtoSubgrupoMontado.produtoSubgrupo!.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Descrição'),
                        tooltip: 'Descrição',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ProdutoSubgrupoMontado produtoSubgrupoMontado) => produtoSubgrupoMontado.produtoSubgrupo!.descricao, columnIndex, ascending),
                      ),
                    ],
                    source: _produtoSubgrupoMontadoDataSource,
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
          ProdutoSubgrupoPersistePage(
            produtoSubgrupoMontado: ProdutoSubgrupoMontado(
              produtoSubgrupo: ProdutoSubgrupo(id: null,),
              produtoGrupo: ProdutoGrupo(id: null,),
            ), 
            title: 'Produto Subgrupo - Inserindo', operacao: 'I'
          )))
      .then((_) async {
        await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Produto Subgrupo - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.produtoSubgrupoDao.consultarListaMontado(campo: _filtro!.campo, valor: _filtro!.valor);
        setState(() {
        });
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxInformacao(context, 'Essa janela não possui relatório implementado');
  }

  Future _refrescarTela() async {
    await Sessao.db.produtoSubgrupoDao.consultarListaMontado();
    setState(() {
    });
  }
}

/// codigo referente a fonte de dados
class _ProdutoSubgrupoMontadoDataSource extends DataTableSource {
  final List<ProdutoSubgrupoMontado>? listaProdutoSubgrupoMontado;
  final BuildContext context;
  final Function refrescarTela;

  _ProdutoSubgrupoMontadoDataSource(this.listaProdutoSubgrupoMontado, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T>? Function(ProdutoSubgrupoMontado produtoSubgrupoMontado) getField, bool ascending) {
    listaProdutoSubgrupoMontado!.sort((ProdutoSubgrupoMontado a, ProdutoSubgrupoMontado b) {
      if (!ascending) {
        final ProdutoSubgrupoMontado c = a;
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
    if (index >= listaProdutoSubgrupoMontado!.length) return null;
    final ProdutoSubgrupoMontado produtoSubgrupoMontado = listaProdutoSubgrupoMontado![index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(produtoSubgrupoMontado.produtoSubgrupo?.id?.toString() ?? ''), onTap: () {
          _detalharProdutoSubgrupoMontado(produtoSubgrupoMontado, context, refrescarTela);
        }),
        DataCell(Text(produtoSubgrupoMontado.produtoGrupo?.nome ?? ''), onTap: () {
          _detalharProdutoSubgrupoMontado(produtoSubgrupoMontado, context, refrescarTela);
        }),
        DataCell(Text(produtoSubgrupoMontado.produtoSubgrupo?.nome ?? ''), onTap: () {
          _detalharProdutoSubgrupoMontado(produtoSubgrupoMontado, context, refrescarTela);
        }),
        DataCell(Text(produtoSubgrupoMontado.produtoSubgrupo?.descricao ?? ''), onTap: () {
          _detalharProdutoSubgrupoMontado(produtoSubgrupoMontado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaProdutoSubgrupoMontado!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharProdutoSubgrupoMontado(ProdutoSubgrupoMontado produtoSubgrupoMontado, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => ProdutoSubgrupoPersistePage(
      produtoSubgrupoMontado: produtoSubgrupoMontado, title: 'ProdutoSubgrupoMontado - Editando', operacao: 'A')))
    .then((_) async {    
      await refrescarTela();
   });
}