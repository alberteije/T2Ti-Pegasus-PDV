/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [TALONARIO_CHEQUE] 
                                                                                
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
import 'talonario_cheque_page.dart';

class TalonarioChequeListaPage extends StatefulWidget {
  @override
  _TalonarioChequeListaPageState createState() => _TalonarioChequeListaPageState();
}

class _TalonarioChequeListaPageState extends State<TalonarioChequeListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TalonarioChequeViewModel>(context).listaTalonarioCheque == null && Provider.of<TalonarioChequeViewModel>(context).objetoJsonErro == null) {
      Provider.of<TalonarioChequeViewModel>(context).consultarLista();
    }     
    var talonarioChequeProvider = Provider.of<TalonarioChequeViewModel>(context);
    var listaTalonarioCheque = talonarioChequeProvider.listaTalonarioCheque;
    var colunas = TalonarioCheque.colunas;
    var campos = TalonarioCheque.campos;

    final TalonarioChequeDataSource _talonarioChequeDataSource =
        TalonarioChequeDataSource(listaTalonarioCheque, context);

    void _sort<T>(Comparable<T> getField(TalonarioCheque talonarioCheque), int columnIndex, bool ascending) {
      _talonarioChequeDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<TalonarioChequeViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Talonario Cheque'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<TalonarioChequeViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Talonario Cheque'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      TalonarioChequePage(talonarioCheque: TalonarioCheque(), title: 'Talonario Cheque - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<TalonarioChequeViewModel>(context).consultarLista();
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
                          title: 'Talonario Cheque - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<TalonarioChequeViewModel>(context)
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
            child: listaTalonarioCheque == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Talonario Cheque'),
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
                                  _sort<num>((TalonarioCheque talonarioCheque) => talonarioCheque.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Conta Caixa'),
								tooltip: 'Conta Caixa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TalonarioCheque talonarioCheque) => talonarioCheque.bancoContaCaixa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código do Talão'),
								tooltip: 'Código do Talão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TalonarioCheque talonarioCheque) => talonarioCheque.talao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Número do Talão'),
								tooltip: 'Número do Talão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TalonarioCheque talonarioCheque) => talonarioCheque.numero,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Status do Talão'),
								tooltip: 'Status do Talão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TalonarioCheque talonarioCheque) => talonarioCheque.statusTalao,
									columnIndex, ascending),
							),
                        ],
                        source: _talonarioChequeDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<TalonarioChequeViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class TalonarioChequeDataSource extends DataTableSource {
  final List<TalonarioCheque> listaTalonarioCheque;
  final BuildContext context;

  TalonarioChequeDataSource(this.listaTalonarioCheque, this.context);

  void _sort<T>(Comparable<T> getField(TalonarioCheque talonarioCheque), bool ascending) {
    listaTalonarioCheque.sort((TalonarioCheque a, TalonarioCheque b) {
      if (!ascending) {
        final TalonarioCheque c = a;
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
    if (index >= listaTalonarioCheque.length) return null;
    final TalonarioCheque talonarioCheque = listaTalonarioCheque[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ talonarioCheque.id ?? ''}'), onTap: () {
          detalharTalonarioCheque(talonarioCheque, context);
        }),
		DataCell(Text('${talonarioCheque.bancoContaCaixa?.nome ?? ''}'), onTap: () {
			detalharTalonarioCheque(talonarioCheque, context);
		}),
		DataCell(Text('${talonarioCheque.talao ?? ''}'), onTap: () {
			detalharTalonarioCheque(talonarioCheque, context);
		}),
		DataCell(Text('${talonarioCheque.numero ?? ''}'), onTap: () {
			detalharTalonarioCheque(talonarioCheque, context);
		}),
		DataCell(Text('${talonarioCheque.statusTalao ?? ''}'), onTap: () {
			detalharTalonarioCheque(talonarioCheque, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaTalonarioCheque.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharTalonarioCheque(TalonarioCheque talonarioCheque, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/talonarioChequeDetalhe',
    arguments: talonarioCheque,
  );
}
