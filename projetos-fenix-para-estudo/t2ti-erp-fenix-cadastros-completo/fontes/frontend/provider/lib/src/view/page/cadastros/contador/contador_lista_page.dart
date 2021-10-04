/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [CONTADOR] 
                                                                                
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
import 'contador_persiste_page.dart';

class ContadorListaPage extends StatefulWidget {
  @override
  _ContadorListaPageState createState() => _ContadorListaPageState();
}

class _ContadorListaPageState extends State<ContadorListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ContadorViewModel>(context).listaContador == null && Provider.of<ContadorViewModel>(context).objetoJsonErro == null) {
      Provider.of<ContadorViewModel>(context).consultarLista();
    }
    var listaContador = Provider.of<ContadorViewModel>(context).listaContador;
    var colunas = Contador.colunas;
    var campos = Contador.campos;

    final ContadorDataSource _contadorDataSource =
        ContadorDataSource(listaContador, context);

    void _sort<T>(Comparable<T> getField(Contador contador), int columnIndex, bool ascending) {
      _contadorDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ContadorViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Contador'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ContadorViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Contador'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  ContadorPersistePage(contador: Contador(), title: 'Contador - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<ContadorViewModel>(context).consultarLista();
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
                          title: 'Contador - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ContadorViewModel>(context)
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
            child: listaContador == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Contador'),
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
									_sort<num>((Contador contador) => contador.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Pessoa'),
								tooltip: 'Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Contador contador) => contador.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Inscrição CRC'),
								tooltip: 'Inscrição CRC',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Contador contador) => contador.crcInscricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('UF CRC'),
								tooltip: 'UF CRC',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Contador contador) => contador.crcUf,
									columnIndex, ascending),
							),
                        ],
                        source: _contadorDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<ContadorViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class ContadorDataSource extends DataTableSource {
  final List<Contador> listaContador;
  final BuildContext context;

  ContadorDataSource(this.listaContador, this.context);

  void _sort<T>(Comparable<T> getField(Contador contador), bool ascending) {
    listaContador.sort((Contador a, Contador b) {
      if (!ascending) {
        final Contador c = a;
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
    if (index >= listaContador.length) return null;
    final Contador contador = listaContador[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ contador.id ?? ''}'), onTap: () {
          detalharContador(contador, context);
        }),
		DataCell(Text('${contador.pessoa?.nome ?? ''}'), onTap: () {
			detalharContador(contador, context);
		}),
		DataCell(Text('${contador.crcInscricao ?? ''}'), onTap: () {
			detalharContador(contador, context);
		}),
		DataCell(Text('${contador.crcUf ?? ''}'), onTap: () {
			detalharContador(contador, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaContador.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharContador(Contador contador, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/contadorDetalhe',
    arguments: contador,
  );
}