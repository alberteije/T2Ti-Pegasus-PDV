/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [COLABORADOR] 
                                                                                
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

import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/model/filtro.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/filtro_page.dart';

import 'colaborador_persiste_page.dart';

class ColaboradorListaPage extends StatefulWidget {
  @override
  _ColaboradorListaPageState createState() => _ColaboradorListaPageState();
}

class _ColaboradorListaPageState extends State<ColaboradorListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = ColaboradorDao.colunas;
  final _campos = ColaboradorDao.campos;

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
    final _listaColaborador = Sessao.db.colaboradorDao.listaColaborador;

    final _ColaboradorDataSource _colaboradorDataSource = _ColaboradorDataSource(_listaColaborador, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(Colaborador colaborador), int columnIndex, bool ascending) {
      _colaboradorDataSource._sort<T>(getField, ascending);
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
            title: const Text('Cadastro - Colaborador'),
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
              child: _listaColaborador == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Relação - Colaborador'),
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
                          _sort<num>((Colaborador colaborador) => colaborador.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Nome'),
                        tooltip: 'Conteúdo para o campo Nome',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Colaborador colaborador) => colaborador.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cpf'),
                        tooltip: 'Conteúdo para o campo Cpf',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Colaborador colaborador) => colaborador.cpf, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Telefone'),
                        tooltip: 'Conteúdo para o campo Telefone',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Colaborador colaborador) => colaborador.telefone, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Celular'),
                        tooltip: 'Conteúdo para o campo Celular',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Colaborador colaborador) => colaborador.celular, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Email'),
                        tooltip: 'Conteúdo para o campo Email',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Colaborador colaborador) => colaborador.email, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Comissao Vista'),
                        tooltip: 'Conteúdo para o campo Comissao Vista',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((Colaborador colaborador) => colaborador.comissaoVista, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Comissao Prazo'),
                        tooltip: 'Conteúdo para o campo Comissao Prazo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((Colaborador colaborador) => colaborador.comissaoPrazo, columnIndex, ascending),
                      ),
                    ],
                    source: _colaboradorDataSource,
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
            ColaboradorPersistePage(colaborador: Colaborador(id: null,), title: 'Colaborador - Inserindo', operacao: 'I')))
      .then((_) async {
        await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Colaborador - Filtro',
            colunas: _colunas,
            campoPesquisaPadrao: 'Nome',
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Sessao.db.colaboradorDao.consultarListaFiltro(_filtro.campo, _filtro.valor);
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
    await Sessao.db.colaboradorDao.consultarLista();
    setState(() {
    });
  }
}

/// codigo referente a fonte de dados
class _ColaboradorDataSource extends DataTableSource {
  final List<Colaborador> listaColaborador;
  final BuildContext context;
  final Function refrescarTela;
 
  _ColaboradorDataSource(this.listaColaborador, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T> getField(Colaborador colaborador), bool ascending) {
    listaColaborador.sort((Colaborador a, Colaborador b) {
      if (!ascending) {
        final Colaborador c = a;
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
    if (index >= listaColaborador.length) return null;
    final Colaborador colaborador = listaColaborador[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${colaborador.id ?? ''}'), onTap: () {
          _detalharColaborador(colaborador, context, refrescarTela);
        }),
        DataCell(Text('${colaborador.nome ?? ''}'), onTap: () {
          _detalharColaborador(colaborador, context, refrescarTela);
        }),
        DataCell(Text('${colaborador.cpf ?? ''}'), onTap: () {
          _detalharColaborador(colaborador, context, refrescarTela);
        }),
        DataCell(Text('${colaborador.telefone ?? ''}'), onTap: () {
          _detalharColaborador(colaborador, context, refrescarTela);
        }),
        DataCell(Text('${colaborador.celular ?? ''}'), onTap: () {
          _detalharColaborador(colaborador, context, refrescarTela);
        }),
        DataCell(Text('${colaborador.email ?? ''}'), onTap: () {
          _detalharColaborador(colaborador, context, refrescarTela);
        }),
        DataCell(Text('${colaborador.comissaoVista != null ? Constantes.formatoDecimalValor.format(colaborador.comissaoVista) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharColaborador(colaborador, context, refrescarTela);
        }),
        DataCell(Text('${colaborador.comissaoPrazo != null ? Constantes.formatoDecimalValor.format(colaborador.comissaoPrazo) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharColaborador(colaborador, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaColaborador.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharColaborador(Colaborador colaborador, BuildContext context, Function refrescarTela) {
  if (colaborador.id != 1) {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => ColaboradorPersistePage(
        colaborador: colaborador, title: 'Colaborador - Editando', operacao: 'A')))
      .then((_) async {    
        await refrescarTela();
    });
  }
}