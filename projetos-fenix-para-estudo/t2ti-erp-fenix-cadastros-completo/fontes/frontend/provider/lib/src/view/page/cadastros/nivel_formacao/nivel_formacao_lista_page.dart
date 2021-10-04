/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [NIVEL_FORMACAO] 
                                                                                
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
import 'nivel_formacao_persiste_page.dart';

class NivelFormacaoListaPage extends StatefulWidget {
  @override
  _NivelFormacaoListaPageState createState() => _NivelFormacaoListaPageState();
}

class _NivelFormacaoListaPageState extends State<NivelFormacaoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<NivelFormacaoViewModel>(context).listaNivelFormacao == null && Provider.of<NivelFormacaoViewModel>(context).objetoJsonErro == null) {
      Provider.of<NivelFormacaoViewModel>(context).consultarLista();
    }
    var listaNivelFormacao = Provider.of<NivelFormacaoViewModel>(context).listaNivelFormacao;
    var colunas = NivelFormacao.colunas;
    var campos = NivelFormacao.campos;

    final NivelFormacaoDataSource _nivelFormacaoDataSource =
        NivelFormacaoDataSource(listaNivelFormacao, context);

    void _sort<T>(Comparable<T> getField(NivelFormacao nivelFormacao), int columnIndex, bool ascending) {
      _nivelFormacaoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<NivelFormacaoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Nivel Formacao'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<NivelFormacaoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Nivel Formacao'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  NivelFormacaoPersistePage(nivelFormacao: NivelFormacao(), title: 'Nivel Formacao - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<NivelFormacaoViewModel>(context).consultarLista();
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
                          title: 'Nivel Formacao - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<NivelFormacaoViewModel>(context)
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
            child: listaNivelFormacao == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Nivel Formacao'),
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
									_sort<num>((NivelFormacao nivelFormacao) => nivelFormacao.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NivelFormacao nivelFormacao) => nivelFormacao.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NivelFormacao nivelFormacao) => nivelFormacao.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _nivelFormacaoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<NivelFormacaoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class NivelFormacaoDataSource extends DataTableSource {
  final List<NivelFormacao> listaNivelFormacao;
  final BuildContext context;

  NivelFormacaoDataSource(this.listaNivelFormacao, this.context);

  void _sort<T>(Comparable<T> getField(NivelFormacao nivelFormacao), bool ascending) {
    listaNivelFormacao.sort((NivelFormacao a, NivelFormacao b) {
      if (!ascending) {
        final NivelFormacao c = a;
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
    if (index >= listaNivelFormacao.length) return null;
    final NivelFormacao nivelFormacao = listaNivelFormacao[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ nivelFormacao.id ?? ''}'), onTap: () {
          detalharNivelFormacao(nivelFormacao, context);
        }),
		DataCell(Text('${nivelFormacao.nome ?? ''}'), onTap: () {
			detalharNivelFormacao(nivelFormacao, context);
		}),
		DataCell(Text('${nivelFormacao.descricao ?? ''}'), onTap: () {
			detalharNivelFormacao(nivelFormacao, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaNivelFormacao.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharNivelFormacao(NivelFormacao nivelFormacao, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/nivelFormacaoDetalhe',
    arguments: nivelFormacao,
  );
}