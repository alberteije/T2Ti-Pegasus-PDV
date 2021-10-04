/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [ESTADO_CIVIL] 
                                                                                
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
import 'estado_civil_persiste_page.dart';

class EstadoCivilListaPage extends StatefulWidget {
  @override
  _EstadoCivilListaPageState createState() => _EstadoCivilListaPageState();
}

class _EstadoCivilListaPageState extends State<EstadoCivilListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<EstadoCivilViewModel>(context).listaEstadoCivil == null && Provider.of<EstadoCivilViewModel>(context).objetoJsonErro == null) {
      Provider.of<EstadoCivilViewModel>(context).consultarLista();
    }
    var listaEstadoCivil = Provider.of<EstadoCivilViewModel>(context).listaEstadoCivil;
    var colunas = EstadoCivil.colunas;
    var campos = EstadoCivil.campos;

    final EstadoCivilDataSource _estadoCivilDataSource =
        EstadoCivilDataSource(listaEstadoCivil, context);

    void _sort<T>(Comparable<T> getField(EstadoCivil estadoCivil), int columnIndex, bool ascending) {
      _estadoCivilDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<EstadoCivilViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Estado Civil'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<EstadoCivilViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Estado Civil'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  EstadoCivilPersistePage(estadoCivil: EstadoCivil(), title: 'Estado Civil - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<EstadoCivilViewModel>(context).consultarLista();
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
                          title: 'Estado Civil - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<EstadoCivilViewModel>(context)
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
            child: listaEstadoCivil == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Estado Civil'),
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
									_sort<num>((EstadoCivil estadoCivil) => estadoCivil.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((EstadoCivil estadoCivil) => estadoCivil.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((EstadoCivil estadoCivil) => estadoCivil.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _estadoCivilDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<EstadoCivilViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class EstadoCivilDataSource extends DataTableSource {
  final List<EstadoCivil> listaEstadoCivil;
  final BuildContext context;

  EstadoCivilDataSource(this.listaEstadoCivil, this.context);

  void _sort<T>(Comparable<T> getField(EstadoCivil estadoCivil), bool ascending) {
    listaEstadoCivil.sort((EstadoCivil a, EstadoCivil b) {
      if (!ascending) {
        final EstadoCivil c = a;
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
    if (index >= listaEstadoCivil.length) return null;
    final EstadoCivil estadoCivil = listaEstadoCivil[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ estadoCivil.id ?? ''}'), onTap: () {
          detalharEstadoCivil(estadoCivil, context);
        }),
		DataCell(Text('${estadoCivil.nome ?? ''}'), onTap: () {
			detalharEstadoCivil(estadoCivil, context);
		}),
		DataCell(Text('${estadoCivil.descricao ?? ''}'), onTap: () {
			detalharEstadoCivil(estadoCivil, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaEstadoCivil.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharEstadoCivil(EstadoCivil estadoCivil, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/estadoCivilDetalhe',
    arguments: estadoCivil,
  );
}