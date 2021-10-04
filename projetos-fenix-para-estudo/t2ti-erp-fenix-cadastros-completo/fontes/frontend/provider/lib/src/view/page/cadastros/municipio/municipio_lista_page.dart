/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [MUNICIPIO] 
                                                                                
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

class MunicipioListaPage extends StatefulWidget {
  @override
  _MunicipioListaPageState createState() => _MunicipioListaPageState();
}

class _MunicipioListaPageState extends State<MunicipioListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<MunicipioViewModel>(context).listaMunicipio == null && Provider.of<MunicipioViewModel>(context).objetoJsonErro == null) {
      Provider.of<MunicipioViewModel>(context).consultarLista();
    }
    var listaMunicipio = Provider.of<MunicipioViewModel>(context).listaMunicipio;
    var colunas = Municipio.colunas;
    var campos = Municipio.campos;

    final MunicipioDataSource _municipioDataSource =
        MunicipioDataSource(listaMunicipio, context);

    void _sort<T>(Comparable<T> getField(Municipio municipio), int columnIndex, bool ascending) {
      _municipioDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<MunicipioViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Municipio'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<MunicipioViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Municipio'),
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
                          title: 'Municipio - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<MunicipioViewModel>(context)
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
            child: listaMunicipio == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Municipio'),
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
									_sort<num>((Municipio municipio) => municipio.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('UF'),
								tooltip: 'UF',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Municipio municipio) => municipio.uf?.sigla,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Municipio municipio) => municipio.nome,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Município IBGE'),
								tooltip: 'Código IBGE do Município',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Municipio municipio) => municipio.codigoIbge,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Código Receita Federal'),
								tooltip: 'Código Receita Federal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Municipio municipio) => municipio.codigoReceitaFederal,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Código Estadual'),
								tooltip: 'Código Estadual',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Municipio municipio) => municipio.codigoEstadual,
									columnIndex, ascending),
							),
                        ],
                        source: _municipioDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<MunicipioViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class MunicipioDataSource extends DataTableSource {
  final List<Municipio> listaMunicipio;
  final BuildContext context;

  MunicipioDataSource(this.listaMunicipio, this.context);

  void _sort<T>(Comparable<T> getField(Municipio municipio), bool ascending) {
    listaMunicipio.sort((Municipio a, Municipio b) {
      if (!ascending) {
        final Municipio c = a;
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
    if (index >= listaMunicipio.length) return null;
    final Municipio municipio = listaMunicipio[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ municipio.id ?? ''}'), onTap: () {
          detalharMunicipio(municipio, context);
        }),
		DataCell(Text('${municipio.uf?.sigla ?? ''}'), onTap: () {
			detalharMunicipio(municipio, context);
		}),
		DataCell(Text('${municipio.nome ?? ''}'), onTap: () {
			detalharMunicipio(municipio, context);
		}),
		DataCell(Text('${municipio.codigoIbge ?? ''}'), onTap: () {
			detalharMunicipio(municipio, context);
		}),
		DataCell(Text('${municipio.codigoReceitaFederal ?? ''}'), onTap: () {
			detalharMunicipio(municipio, context);
		}),
		DataCell(Text('${municipio.codigoEstadual ?? ''}'), onTap: () {
			detalharMunicipio(municipio, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaMunicipio.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharMunicipio(Municipio municipio, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/municipioDetalhe',
    arguments: municipio,
  );
}