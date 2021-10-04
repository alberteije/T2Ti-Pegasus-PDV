/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [CARGO] 
                                                                                
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
import 'package:fenix/src/infra/constantes.dart';
import 'cargo_persiste_page.dart';

class CargoListaPage extends StatefulWidget {
  @override
  _CargoListaPageState createState() => _CargoListaPageState();
}

class _CargoListaPageState extends State<CargoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CargoViewModel>(context).listaCargo == null && Provider.of<CargoViewModel>(context).objetoJsonErro == null) {
      Provider.of<CargoViewModel>(context).consultarLista();
    }
    var listaCargo = Provider.of<CargoViewModel>(context).listaCargo;
    var colunas = Cargo.colunas;
    var campos = Cargo.campos;

    final CargoDataSource _cargoDataSource =
        CargoDataSource(listaCargo, context);

    void _sort<T>(Comparable<T> getField(Cargo cargo), int columnIndex, bool ascending) {
      _cargoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<CargoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cargo'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<CargoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cargo'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  CargoPersistePage(cargo: Cargo(), title: 'Cargo - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<CargoViewModel>(context).consultarLista();
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
                          title: 'Cargo - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<CargoViewModel>(context)
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
            child: listaCargo == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Cargo'),
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
									_sort<num>((Cargo cargo) => cargo.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cargo cargo) => cargo.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cargo cargo) => cargo.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Salário'),
								tooltip: 'Valor Salário',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Cargo cargo) => cargo.salario,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('CBO 1994'),
								tooltip: 'CBO 1994',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cargo cargo) => cargo.cbo1994,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('CBO 2002'),
								tooltip: 'CBO 2002',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cargo cargo) => cargo.cbo2002,
									columnIndex, ascending),
							),
                        ],
                        source: _cargoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<CargoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class CargoDataSource extends DataTableSource {
  final List<Cargo> listaCargo;
  final BuildContext context;

  CargoDataSource(this.listaCargo, this.context);

  void _sort<T>(Comparable<T> getField(Cargo cargo), bool ascending) {
    listaCargo.sort((Cargo a, Cargo b) {
      if (!ascending) {
        final Cargo c = a;
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
    if (index >= listaCargo.length) return null;
    final Cargo cargo = listaCargo[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ cargo.id ?? ''}'), onTap: () {
          detalharCargo(cargo, context);
        }),
		DataCell(Text('${cargo.nome ?? ''}'), onTap: () {
			detalharCargo(cargo, context);
		}),
		DataCell(Text('${cargo.descricao ?? ''}'), onTap: () {
			detalharCargo(cargo, context);
		}),
		DataCell(Text('${cargo.salario != null ? Constantes.formatoDecimalValor.format(cargo.salario) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharCargo(cargo, context);
		}),
		DataCell(Text('${cargo.cbo1994 ?? ''}'), onTap: () {
			detalharCargo(cargo, context);
		}),
		DataCell(Text('${cargo.cbo2002 ?? ''}'), onTap: () {
			detalharCargo(cargo, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaCargo.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharCargo(Cargo cargo, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/cargoDetalhe',
    arguments: cargo,
  );
}