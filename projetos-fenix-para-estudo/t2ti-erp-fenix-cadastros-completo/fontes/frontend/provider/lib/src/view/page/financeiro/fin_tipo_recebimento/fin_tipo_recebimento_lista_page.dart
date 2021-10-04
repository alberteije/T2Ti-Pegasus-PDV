/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FIN_TIPO_RECEBIMENTO] 
                                                                                
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
import 'fin_tipo_recebimento_persiste_page.dart';

class FinTipoRecebimentoListaPage extends StatefulWidget {
  @override
  _FinTipoRecebimentoListaPageState createState() => _FinTipoRecebimentoListaPageState();
}

class _FinTipoRecebimentoListaPageState extends State<FinTipoRecebimentoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinTipoRecebimentoViewModel>(context).listaFinTipoRecebimento == null && Provider.of<FinTipoRecebimentoViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinTipoRecebimentoViewModel>(context).consultarLista();
    }
    var listaFinTipoRecebimento = Provider.of<FinTipoRecebimentoViewModel>(context).listaFinTipoRecebimento;
    var colunas = FinTipoRecebimento.colunas;
    var campos = FinTipoRecebimento.campos;

    final FinTipoRecebimentoDataSource _finTipoRecebimentoDataSource =
        FinTipoRecebimentoDataSource(listaFinTipoRecebimento, context);

    void _sort<T>(Comparable<T> getField(FinTipoRecebimento finTipoRecebimento), int columnIndex, bool ascending) {
      _finTipoRecebimentoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinTipoRecebimentoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Tipo Recebimento'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinTipoRecebimentoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Tipo Recebimento'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FinTipoRecebimentoPersistePage(finTipoRecebimento: FinTipoRecebimento(), title: 'Tipo Recebimento - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinTipoRecebimentoViewModel>(context).consultarLista();
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
                          title: 'Tipo Recebimento - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinTipoRecebimentoViewModel>(context)
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
            child: listaFinTipoRecebimento == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Tipo Recebimento'),
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
									_sort<num>((FinTipoRecebimento finTipoRecebimento) => finTipoRecebimento.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código Recebimento'),
								tooltip: 'Código Recebimento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinTipoRecebimento finTipoRecebimento) => finTipoRecebimento.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinTipoRecebimento finTipoRecebimento) => finTipoRecebimento.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _finTipoRecebimentoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinTipoRecebimentoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinTipoRecebimentoDataSource extends DataTableSource {
  final List<FinTipoRecebimento> listaFinTipoRecebimento;
  final BuildContext context;

  FinTipoRecebimentoDataSource(this.listaFinTipoRecebimento, this.context);

  void _sort<T>(Comparable<T> getField(FinTipoRecebimento finTipoRecebimento), bool ascending) {
    listaFinTipoRecebimento.sort((FinTipoRecebimento a, FinTipoRecebimento b) {
      if (!ascending) {
        final FinTipoRecebimento c = a;
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
    if (index >= listaFinTipoRecebimento.length) return null;
    final FinTipoRecebimento finTipoRecebimento = listaFinTipoRecebimento[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finTipoRecebimento.id ?? ''}'), onTap: () {
          detalharFinTipoRecebimento(finTipoRecebimento, context);
        }),
		DataCell(Text('${finTipoRecebimento.codigo ?? ''}'), onTap: () {
			detalharFinTipoRecebimento(finTipoRecebimento, context);
		}),
		DataCell(Text('${finTipoRecebimento.descricao ?? ''}'), onTap: () {
			detalharFinTipoRecebimento(finTipoRecebimento, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinTipoRecebimento.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinTipoRecebimento(FinTipoRecebimento finTipoRecebimento, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finTipoRecebimentoDetalhe',
    arguments: finTipoRecebimento,
  );
}