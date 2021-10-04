/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [COLABORADOR] 
                                                                                
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
import 'colaborador_page.dart';

class ColaboradorListaPage extends StatefulWidget {
  @override
  _ColaboradorListaPageState createState() => _ColaboradorListaPageState();
}

class _ColaboradorListaPageState extends State<ColaboradorListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ColaboradorViewModel>(context).listaColaborador == null && Provider.of<ColaboradorViewModel>(context).objetoJsonErro == null) {
      Provider.of<ColaboradorViewModel>(context).consultarLista();
    }     
    var colaboradorProvider = Provider.of<ColaboradorViewModel>(context);
    var listaColaborador = colaboradorProvider.listaColaborador;
    var colunas = Colaborador.colunas;
    var campos = Colaborador.campos;

    final ColaboradorDataSource _colaboradorDataSource =
        ColaboradorDataSource(listaColaborador, context);

    void _sort<T>(Comparable<T> getField(Colaborador colaborador), int columnIndex, bool ascending) {
      _colaboradorDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ColaboradorViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Colaborador'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ColaboradorViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Colaborador'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      ColaboradorPage(colaborador: Colaborador(), title: 'Colaborador - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<ColaboradorViewModel>(context).consultarLista();
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
                          title: 'Colaborador - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ColaboradorViewModel>(context)
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
            child: listaColaborador == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
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
                              label: const Text('Id'),
                              numeric: true,
                              onSort: (int columnIndex, bool ascending) =>
                                  _sort<num>((Colaborador colaborador) => colaborador.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Pessoa'),
								tooltip: 'Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Colaborador colaborador) => colaborador.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Cargo'),
								tooltip: 'Cargo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Colaborador colaborador) => colaborador.cargo?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Setor'),
								tooltip: 'Setor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Colaborador colaborador) => colaborador.setor?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Matrícula'),
								tooltip: 'Matrícula',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Colaborador colaborador) => colaborador.matricula,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Cadastro'),
								tooltip: 'Data de Cadastro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Colaborador colaborador) => colaborador.dataCadastro,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Admissão'),
								tooltip: 'Data de Admissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Colaborador colaborador) => colaborador.dataAdmissao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Demissão'),
								tooltip: 'Data de Demissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Colaborador colaborador) => colaborador.dataDemissao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Número CTPS'),
								tooltip: 'Número CTPS',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Colaborador colaborador) => colaborador.ctpsNumero,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Série CTPS'),
								tooltip: 'Série CTPS',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Colaborador colaborador) => colaborador.ctpsSerie,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Expedição'),
								tooltip: 'Data de Expedição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Colaborador colaborador) => colaborador.ctpsDataExpedicao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('UF CTPS'),
								tooltip: 'UF CTPS',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Colaborador colaborador) => colaborador.ctpsUf,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Colaborador colaborador) => colaborador.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _colaboradorDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<ColaboradorViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class ColaboradorDataSource extends DataTableSource {
  final List<Colaborador> listaColaborador;
  final BuildContext context;

  ColaboradorDataSource(this.listaColaborador, this.context);

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
    notifyListeners();
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
        DataCell(Text('${ colaborador.id ?? ''}'), onTap: () {
          detalharColaborador(colaborador, context);
        }),
		DataCell(Text('${colaborador.pessoa?.nome ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.cargo?.nome ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.setor?.nome ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.matricula ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.dataCadastro ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.dataAdmissao ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.dataDemissao ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.ctpsNumero ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.ctpsSerie ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.ctpsDataExpedicao ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.ctpsUf ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
		}),
		DataCell(Text('${colaborador.observacao ?? ''}'), onTap: () {
			detalharColaborador(colaborador, context);
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

detalharColaborador(Colaborador colaborador, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/colaboradorDetalhe',
    arguments: colaborador,
  );
}
