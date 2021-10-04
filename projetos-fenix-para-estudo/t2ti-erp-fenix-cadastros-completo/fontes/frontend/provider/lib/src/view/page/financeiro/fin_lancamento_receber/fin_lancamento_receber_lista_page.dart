/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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
import 'fin_lancamento_receber_page.dart';

class FinLancamentoReceberListaPage extends StatefulWidget {
  @override
  _FinLancamentoReceberListaPageState createState() => _FinLancamentoReceberListaPageState();
}

class _FinLancamentoReceberListaPageState extends State<FinLancamentoReceberListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinLancamentoReceberViewModel>(context).listaFinLancamentoReceber == null && Provider.of<FinLancamentoReceberViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinLancamentoReceberViewModel>(context).consultarLista();
    }     
    var finLancamentoReceberProvider = Provider.of<FinLancamentoReceberViewModel>(context);
    var listaFinLancamentoReceber = finLancamentoReceberProvider.listaFinLancamentoReceber;
    var colunas = FinLancamentoReceber.colunas;
    var campos = FinLancamentoReceber.campos;

    final FinLancamentoReceberDataSource _finLancamentoReceberDataSource =
        FinLancamentoReceberDataSource(listaFinLancamentoReceber, context);

    void _sort<T>(Comparable<T> getField(FinLancamentoReceber finLancamentoReceber), int columnIndex, bool ascending) {
      _finLancamentoReceberDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinLancamentoReceberViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Lancamento Receber'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinLancamentoReceberViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Lancamento Receber'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      FinLancamentoReceberPage(finLancamentoReceber: FinLancamentoReceber(), title: 'Lancamento Receber - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinLancamentoReceberViewModel>(context).consultarLista();
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
                          title: 'Lancamento Receber - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinLancamentoReceberViewModel>(context)
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
            child: listaFinLancamentoReceber == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Lancamento Receber'),
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
                                  _sort<num>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Documento de Origem'),
								tooltip: 'Documento de Origem',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.finDocumentoOrigem?.sigla,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Natureza Financeira'),
								tooltip: 'Natureza Financeira',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.finNaturezaFinanceira?.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Cliente'),
								tooltip: 'Cliente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.cliente?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Quantidade de Parcelas'),
								tooltip: 'Quantidade de Parcelas',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.quantidadeParcela,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Total'),
								tooltip: 'Valor Total',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.valorTotal,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor a Receber'),
								tooltip: 'Valor a Receber',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.valorAReceber,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Lançamento'),
								tooltip: 'Data de Lançamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.dataLancamento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Número do Documento'),
								tooltip: 'Número do Documento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.numeroDocumento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data do Primeiro Vencimento'),
								tooltip: 'Data do Primeiro Vencimento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.primeiroVencimento,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa de Comissão'),
								tooltip: 'Taxa de Comissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.taxaComissao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Comissão'),
								tooltip: 'Valor Comissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.valorComissao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Intervalo Entre Parcelas'),
								tooltip: 'Intervalo Entre Parcelas',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.intervaloEntreParcelas,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Dia Fixo'),
								tooltip: 'Dia Fixo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinLancamentoReceber finLancamentoReceber) => finLancamentoReceber.diaFixo,
									columnIndex, ascending),
							),
                        ],
                        source: _finLancamentoReceberDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinLancamentoReceberViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinLancamentoReceberDataSource extends DataTableSource {
  final List<FinLancamentoReceber> listaFinLancamentoReceber;
  final BuildContext context;

  FinLancamentoReceberDataSource(this.listaFinLancamentoReceber, this.context);

  void _sort<T>(Comparable<T> getField(FinLancamentoReceber finLancamentoReceber), bool ascending) {
    listaFinLancamentoReceber.sort((FinLancamentoReceber a, FinLancamentoReceber b) {
      if (!ascending) {
        final FinLancamentoReceber c = a;
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
    if (index >= listaFinLancamentoReceber.length) return null;
    final FinLancamentoReceber finLancamentoReceber = listaFinLancamentoReceber[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finLancamentoReceber.id ?? ''}'), onTap: () {
          detalharFinLancamentoReceber(finLancamentoReceber, context);
        }),
		DataCell(Text('${finLancamentoReceber.finDocumentoOrigem?.sigla ?? ''}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.finNaturezaFinanceira?.descricao ?? ''}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.cliente?.pessoa?.nome ?? ''}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.quantidadeParcela ?? ''}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.valorTotal != null ? Constantes.formatoDecimalValor.format(finLancamentoReceber.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.valorAReceber != null ? Constantes.formatoDecimalValor.format(finLancamentoReceber.valorAReceber) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.dataLancamento ?? ''}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.numeroDocumento ?? ''}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.primeiroVencimento ?? ''}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.taxaComissao != null ? Constantes.formatoDecimalTaxa.format(finLancamentoReceber.taxaComissao) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.valorComissao != null ? Constantes.formatoDecimalValor.format(finLancamentoReceber.valorComissao) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.intervaloEntreParcelas ?? ''}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
		DataCell(Text('${finLancamentoReceber.diaFixo ?? ''}'), onTap: () {
			detalharFinLancamentoReceber(finLancamentoReceber, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinLancamentoReceber.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinLancamentoReceber(FinLancamentoReceber finLancamentoReceber, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finLancamentoReceberDetalhe',
    arguments: finLancamentoReceber,
  );
}
