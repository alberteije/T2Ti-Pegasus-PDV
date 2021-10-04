/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [CEP] 
                                                                                
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

class CepListaPage extends StatefulWidget {
  @override
  _CepListaPageState createState() => _CepListaPageState();
}

class _CepListaPageState extends State<CepListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CepViewModel>(context).listaCep == null && Provider.of<CepViewModel>(context).objetoJsonErro == null) {
      Provider.of<CepViewModel>(context).consultarLista();
    }
    var listaCep = Provider.of<CepViewModel>(context).listaCep;
    var colunas = Cep.colunas;
    var campos = Cep.campos;

    final CepDataSource _cepDataSource =
        CepDataSource(listaCep, context);

    void _sort<T>(Comparable<T> getField(Cep cep), int columnIndex, bool ascending) {
      _cepDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<CepViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cep'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<CepViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cep'),
          actions: <Widget>[],
        ),
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
                          title: 'Cep - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<CepViewModel>(context)
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
            child: listaCep == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Cep'),
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
									_sort<num>((Cep cep) => cep.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Número CEP'),
								tooltip: 'Número CEP',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cep cep) => cep.numero,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Logradouro'),
								tooltip: 'Logradouro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cep cep) => cep.logradouro,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Complemento'),
								tooltip: 'Complemento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cep cep) => cep.complemento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Bairro'),
								tooltip: 'Bairro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cep cep) => cep.bairro,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Município'),
								tooltip: 'Município',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cep cep) => cep.municipio,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('UF'),
								tooltip: 'UF',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cep cep) => cep.uf,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Município IBGE'),
								tooltip: 'Código IBGE do Município',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Cep cep) => cep.codigoIbgeMunicipio,
									columnIndex, ascending),
							),
                        ],
                        source: _cepDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<CepViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class CepDataSource extends DataTableSource {
  final List<Cep> listaCep;
  final BuildContext context;

  CepDataSource(this.listaCep, this.context);

  void _sort<T>(Comparable<T> getField(Cep cep), bool ascending) {
    listaCep.sort((Cep a, Cep b) {
      if (!ascending) {
        final Cep c = a;
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
    if (index >= listaCep.length) return null;
    final Cep cep = listaCep[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ cep.id ?? ''}'), onTap: () {
          detalharCep(cep, context);
        }),
		DataCell(Text('${cep.numero ?? ''}'), onTap: () {
			detalharCep(cep, context);
		}),
		DataCell(Text('${cep.logradouro ?? ''}'), onTap: () {
			detalharCep(cep, context);
		}),
		DataCell(Text('${cep.complemento ?? ''}'), onTap: () {
			detalharCep(cep, context);
		}),
		DataCell(Text('${cep.bairro ?? ''}'), onTap: () {
			detalharCep(cep, context);
		}),
		DataCell(Text('${cep.municipio ?? ''}'), onTap: () {
			detalharCep(cep, context);
		}),
		DataCell(Text('${cep.uf ?? ''}'), onTap: () {
			detalharCep(cep, context);
		}),
		DataCell(Text('${cep.codigoIbgeMunicipio ?? ''}'), onTap: () {
			detalharCep(cep, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaCep.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharCep(Cep cep, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/cepDetalhe',
    arguments: cep,
  );
}