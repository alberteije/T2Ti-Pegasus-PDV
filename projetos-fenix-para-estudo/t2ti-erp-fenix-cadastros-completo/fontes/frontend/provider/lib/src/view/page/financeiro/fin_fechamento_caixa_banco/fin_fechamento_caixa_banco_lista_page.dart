/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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
import 'package:intl/intl.dart';
import 'fin_fechamento_caixa_banco_persiste_page.dart';

class FinFechamentoCaixaBancoListaPage extends StatefulWidget {
  @override
  _FinFechamentoCaixaBancoListaPageState createState() => _FinFechamentoCaixaBancoListaPageState();
}

class _FinFechamentoCaixaBancoListaPageState extends State<FinFechamentoCaixaBancoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinFechamentoCaixaBancoViewModel>(context).listaFinFechamentoCaixaBanco == null && Provider.of<FinFechamentoCaixaBancoViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinFechamentoCaixaBancoViewModel>(context).consultarLista();
    }
    var listaFinFechamentoCaixaBanco = Provider.of<FinFechamentoCaixaBancoViewModel>(context).listaFinFechamentoCaixaBanco;
    var colunas = FinFechamentoCaixaBanco.colunas;
    var campos = FinFechamentoCaixaBanco.campos;

    final FinFechamentoCaixaBancoDataSource _finFechamentoCaixaBancoDataSource =
        FinFechamentoCaixaBancoDataSource(listaFinFechamentoCaixaBanco, context);

    void _sort<T>(Comparable<T> getField(FinFechamentoCaixaBanco finFechamentoCaixaBanco), int columnIndex, bool ascending) {
      _finFechamentoCaixaBancoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinFechamentoCaixaBancoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Fechamento Caixa Banco'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinFechamentoCaixaBancoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Fechamento Caixa Banco'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FinFechamentoCaixaBancoPersistePage(finFechamentoCaixaBanco: FinFechamentoCaixaBanco(), title: 'Fechamento Caixa Banco - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinFechamentoCaixaBancoViewModel>(context).consultarLista();
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
                          title: 'Fechamento Caixa Banco - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinFechamentoCaixaBancoViewModel>(context)
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
            child: listaFinFechamentoCaixaBanco == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Fechamento Caixa Banco'),
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
									_sort<num>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Conta Caixa'),
								tooltip: 'Conta Caixa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.bancoContaCaixa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data do Fechamento'),
								tooltip: 'Data do Fechamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.dataFechamento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Mês/Ano'),
								tooltip: 'Mês/Ano',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.mesAno,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Mês'),
								tooltip: 'Mês',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.mes,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Ano'),
								tooltip: 'Ano',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.ano,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Saldo Anterior'),
								tooltip: 'Valor Saldo Anterior',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.saldoAnterior,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Total Recebimentos'),
								tooltip: 'Total Recebimentos',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.recebimentos,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Total Pagamentos'),
								tooltip: 'Total Pagamentos',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.pagamentos,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Saldo em Conta'),
								tooltip: 'Saldo em Conta',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.saldoConta,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Cheques Não Compensados'),
								tooltip: 'Cheques Não Compensados',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.chequeNaoCompensado,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Saldo Disponível'),
								tooltip: 'Saldo Disponível',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinFechamentoCaixaBanco finFechamentoCaixaBanco) => finFechamentoCaixaBanco.saldoDisponivel,
									columnIndex, ascending),
							),
                        ],
                        source: _finFechamentoCaixaBancoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinFechamentoCaixaBancoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinFechamentoCaixaBancoDataSource extends DataTableSource {
  final List<FinFechamentoCaixaBanco> listaFinFechamentoCaixaBanco;
  final BuildContext context;

  FinFechamentoCaixaBancoDataSource(this.listaFinFechamentoCaixaBanco, this.context);

  void _sort<T>(Comparable<T> getField(FinFechamentoCaixaBanco finFechamentoCaixaBanco), bool ascending) {
    listaFinFechamentoCaixaBanco.sort((FinFechamentoCaixaBanco a, FinFechamentoCaixaBanco b) {
      if (!ascending) {
        final FinFechamentoCaixaBanco c = a;
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
    if (index >= listaFinFechamentoCaixaBanco.length) return null;
    final FinFechamentoCaixaBanco finFechamentoCaixaBanco = listaFinFechamentoCaixaBanco[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finFechamentoCaixaBanco.id ?? ''}'), onTap: () {
          detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
        }),
		DataCell(Text('${finFechamentoCaixaBanco.bancoContaCaixa?.nome ?? ''}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.dataFechamento != null ? DateFormat('dd/MM/yyyy').format(finFechamentoCaixaBanco.dataFechamento) : ''}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.mesAno ?? ''}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.mes ?? ''}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.ano ?? ''}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.saldoAnterior != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.saldoAnterior) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.recebimentos != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.recebimentos) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.pagamentos != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.pagamentos) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.saldoConta != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.saldoConta) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.chequeNaoCompensado != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.chequeNaoCompensado) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
		DataCell(Text('${finFechamentoCaixaBanco.saldoDisponivel != null ? Constantes.formatoDecimalValor.format(finFechamentoCaixaBanco.saldoDisponivel) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinFechamentoCaixaBanco(finFechamentoCaixaBanco, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinFechamentoCaixaBanco.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinFechamentoCaixaBanco(FinFechamentoCaixaBanco finFechamentoCaixaBanco, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finFechamentoCaixaBancoDetalhe',
    arguments: finFechamentoCaixaBanco,
  );
}