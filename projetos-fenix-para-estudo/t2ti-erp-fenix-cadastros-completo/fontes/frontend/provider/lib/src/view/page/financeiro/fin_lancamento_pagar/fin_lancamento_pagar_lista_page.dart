/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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
import 'fin_lancamento_pagar_page.dart';

class FinLancamentoPagarListaPage extends StatefulWidget {
  @override
  _FinLancamentoPagarListaPageState createState() => _FinLancamentoPagarListaPageState();
}

class _FinLancamentoPagarListaPageState extends State<FinLancamentoPagarListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinLancamentoPagarViewModel>(context).listaFinLancamentoPagar == null && Provider.of<FinLancamentoPagarViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinLancamentoPagarViewModel>(context).consultarLista();
    }     
    var finLancamentoPagarProvider = Provider.of<FinLancamentoPagarViewModel>(context);
    var listaFinLancamentoPagar = finLancamentoPagarProvider.listaFinLancamentoPagar;
    var colunas = FinLancamentoPagar.colunas;
    var campos = FinLancamentoPagar.campos;

    final FinLancamentoPagarDataSource _finLancamentoPagarDataSource =
        FinLancamentoPagarDataSource(listaFinLancamentoPagar, context);

    void _sort<T>(Comparable<T> getField(FinLancamentoPagar finLancamentoPagar), int columnIndex, bool ascending) {
      _finLancamentoPagarDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinLancamentoPagarViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Lancamento Pagar'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinLancamentoPagarViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Lancamento Pagar'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      FinLancamentoPagarPage(finLancamentoPagar: FinLancamentoPagar(), title: 'Lancamento Pagar - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinLancamentoPagarViewModel>(context).consultarLista();
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
                          title: 'Lancamento Pagar - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinLancamentoPagarViewModel>(context)
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
            child: listaFinLancamentoPagar == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Lancamento Pagar'),
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
                                  _sort<num>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Documento de Origem'),
								tooltip: 'Documento de Origem',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.finDocumentoOrigem?.sigla,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Natureza Financeira'),
								tooltip: 'Natureza Financeira',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.finNaturezaFinanceira?.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Fornecedor'),
								tooltip: 'Fornecedor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.fornecedor?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Quantidade de Parcelas'),
								tooltip: 'Quantidade de Parcelas',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.quantidadeParcela,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Total'),
								tooltip: 'Valor Total',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.valorTotal,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor a Pagar'),
								tooltip: 'Valor a Pagar',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.valorAPagar,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Lançamento'),
								tooltip: 'Data de Lançamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.dataLancamento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Número do Documento'),
								tooltip: 'Número do Documento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.numeroDocumento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Imagem Documento'),
								tooltip: 'Imagem Documento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.imagemDocumento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data do Primeiro Vencimento'),
								tooltip: 'Data do Primeiro Vencimento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.primeiroVencimento,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Intervalo Entre Parcelas'),
								tooltip: 'Intervalo Entre Parcelas',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.intervaloEntreParcelas,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Dia Fixo'),
								tooltip: 'Dia Fixo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoPagar finLancamentoPagar) => finLancamentoPagar.diaFixo,
									columnIndex, ascending),
							),
                        ],
                        source: _finLancamentoPagarDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinLancamentoPagarViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinLancamentoPagarDataSource extends DataTableSource {
  final List<FinLancamentoPagar> listaFinLancamentoPagar;
  final BuildContext context;

  FinLancamentoPagarDataSource(this.listaFinLancamentoPagar, this.context);

  void _sort<T>(Comparable<T> getField(FinLancamentoPagar finLancamentoPagar), bool ascending) {
    listaFinLancamentoPagar.sort((FinLancamentoPagar a, FinLancamentoPagar b) {
      if (!ascending) {
        final FinLancamentoPagar c = a;
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
    if (index >= listaFinLancamentoPagar.length) return null;
    final FinLancamentoPagar finLancamentoPagar = listaFinLancamentoPagar[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finLancamentoPagar.id ?? ''}'), onTap: () {
          detalharFinLancamentoPagar(finLancamentoPagar, context);
        }),
		DataCell(Text('${finLancamentoPagar.finDocumentoOrigem?.sigla ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.finNaturezaFinanceira?.descricao ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.fornecedor?.pessoa?.nome ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.quantidadeParcela ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.valorTotal != null ? Constantes.formatoDecimalValor.format(finLancamentoPagar.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.valorAPagar != null ? Constantes.formatoDecimalValor.format(finLancamentoPagar.valorAPagar) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.dataLancamento ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.numeroDocumento ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.imagemDocumento ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.primeiroVencimento ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.intervaloEntreParcelas ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
		DataCell(Text('${finLancamentoPagar.diaFixo ?? ''}'), onTap: () {
			detalharFinLancamentoPagar(finLancamentoPagar, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinLancamentoPagar.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinLancamentoPagar(FinLancamentoPagar finLancamentoPagar, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finLancamentoPagarDetalhe',
    arguments: finLancamentoPagar,
  );
}
