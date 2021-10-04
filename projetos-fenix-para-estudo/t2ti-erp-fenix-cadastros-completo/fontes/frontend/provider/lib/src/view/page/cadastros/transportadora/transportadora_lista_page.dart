/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [TRANSPORTADORA] 
                                                                                
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
import 'transportadora_persiste_page.dart';

class TransportadoraListaPage extends StatefulWidget {
  @override
  _TransportadoraListaPageState createState() => _TransportadoraListaPageState();
}

class _TransportadoraListaPageState extends State<TransportadoraListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TransportadoraViewModel>(context).listaTransportadora == null && Provider.of<TransportadoraViewModel>(context).objetoJsonErro == null) {
      Provider.of<TransportadoraViewModel>(context).consultarLista();
    }
    var listaTransportadora = Provider.of<TransportadoraViewModel>(context).listaTransportadora;
    var colunas = Transportadora.colunas;
    var campos = Transportadora.campos;

    final TransportadoraDataSource _transportadoraDataSource =
        TransportadoraDataSource(listaTransportadora, context);

    void _sort<T>(Comparable<T> getField(Transportadora transportadora), int columnIndex, bool ascending) {
      _transportadoraDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<TransportadoraViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Transportadora'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<TransportadoraViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Transportadora'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  TransportadoraPersistePage(transportadora: Transportadora(), title: 'Transportadora - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<TransportadoraViewModel>(context).consultarLista();
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
                          title: 'Transportadora - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<TransportadoraViewModel>(context)
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
            child: listaTransportadora == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Transportadora'),
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
									_sort<num>((Transportadora transportadora) => transportadora.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Pessoa'),
								tooltip: 'Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Transportadora transportadora) => transportadora.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Cadastro'),
								tooltip: 'Data de Cadastro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Transportadora transportadora) => transportadora.dataCadastro,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Transportadora transportadora) => transportadora.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _transportadoraDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<TransportadoraViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class TransportadoraDataSource extends DataTableSource {
  final List<Transportadora> listaTransportadora;
  final BuildContext context;

  TransportadoraDataSource(this.listaTransportadora, this.context);

  void _sort<T>(Comparable<T> getField(Transportadora transportadora), bool ascending) {
    listaTransportadora.sort((Transportadora a, Transportadora b) {
      if (!ascending) {
        final Transportadora c = a;
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
    if (index >= listaTransportadora.length) return null;
    final Transportadora transportadora = listaTransportadora[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ transportadora.id ?? ''}'), onTap: () {
          detalharTransportadora(transportadora, context);
        }),
		DataCell(Text('${transportadora.pessoa?.nome ?? ''}'), onTap: () {
			detalharTransportadora(transportadora, context);
		}),
		DataCell(Text('${transportadora.dataCadastro ?? ''}'), onTap: () {
			detalharTransportadora(transportadora, context);
		}),
		DataCell(Text('${transportadora.observacao ?? ''}'), onTap: () {
			detalharTransportadora(transportadora, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaTransportadora.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharTransportadora(Transportadora transportadora, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/transportadoraDetalhe',
    arguments: transportadora,
  );
}