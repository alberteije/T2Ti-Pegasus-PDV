/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FIN_EXTRATO_CONTA_BANCO] 
                                                                                
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
import 'fin_extrato_conta_banco_persiste_page.dart';

class FinExtratoContaBancoListaPage extends StatefulWidget {
  @override
  _FinExtratoContaBancoListaPageState createState() => _FinExtratoContaBancoListaPageState();
}

class _FinExtratoContaBancoListaPageState extends State<FinExtratoContaBancoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinExtratoContaBancoViewModel>(context).listaFinExtratoContaBanco == null && Provider.of<FinExtratoContaBancoViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinExtratoContaBancoViewModel>(context).consultarLista();
    }
    var listaFinExtratoContaBanco = Provider.of<FinExtratoContaBancoViewModel>(context).listaFinExtratoContaBanco;
    var colunas = FinExtratoContaBanco.colunas;
    var campos = FinExtratoContaBanco.campos;

    final FinExtratoContaBancoDataSource _finExtratoContaBancoDataSource =
        FinExtratoContaBancoDataSource(listaFinExtratoContaBanco, context);

    void _sort<T>(Comparable<T> getField(FinExtratoContaBanco finExtratoContaBanco), int columnIndex, bool ascending) {
      _finExtratoContaBancoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinExtratoContaBancoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Extrato Conta Banco'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinExtratoContaBancoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Extrato Conta Banco'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FinExtratoContaBancoPersistePage(finExtratoContaBanco: FinExtratoContaBanco(), title: 'Extrato Conta Banco - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinExtratoContaBancoViewModel>(context).consultarLista();
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
                          title: 'Extrato Conta Banco - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinExtratoContaBancoViewModel>(context)
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
            child: listaFinExtratoContaBanco == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Extrato Conta Banco'),
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
									_sort<num>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Conta Caixa'),
								tooltip: 'Conta Caixa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.bancoContaCaixa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Mês/Ano'),
								tooltip: 'Mês/Ano',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.mesAno,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Mês'),
								tooltip: 'Mês',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.mes,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Ano'),
								tooltip: 'Ano',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.ano,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Movimento'),
								tooltip: 'Data de Movimento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.dataMovimento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data do Balancete'),
								tooltip: 'Data do Balancete',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.dataBalancete,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Histórico'),
								tooltip: 'Histórico',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.historico,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Documento'),
								tooltip: 'Documento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.documento,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor'),
								tooltip: 'Valor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.valor,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Conciliado'),
								tooltip: 'Conciliado',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.conciliado,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinExtratoContaBanco finExtratoContaBanco) => finExtratoContaBanco.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _finExtratoContaBancoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinExtratoContaBancoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinExtratoContaBancoDataSource extends DataTableSource {
  final List<FinExtratoContaBanco> listaFinExtratoContaBanco;
  final BuildContext context;

  FinExtratoContaBancoDataSource(this.listaFinExtratoContaBanco, this.context);

  void _sort<T>(Comparable<T> getField(FinExtratoContaBanco finExtratoContaBanco), bool ascending) {
    listaFinExtratoContaBanco.sort((FinExtratoContaBanco a, FinExtratoContaBanco b) {
      if (!ascending) {
        final FinExtratoContaBanco c = a;
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
    if (index >= listaFinExtratoContaBanco.length) return null;
    final FinExtratoContaBanco finExtratoContaBanco = listaFinExtratoContaBanco[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finExtratoContaBanco.id ?? ''}'), onTap: () {
          detalharFinExtratoContaBanco(finExtratoContaBanco, context);
        }),
		DataCell(Text('${finExtratoContaBanco.bancoContaCaixa?.nome ?? ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.mesAno ?? ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.mes ?? ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.ano ?? ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.dataMovimento != null ? DateFormat('dd/MM/yyyy').format(finExtratoContaBanco.dataMovimento) : ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.dataBalancete != null ? DateFormat('dd/MM/yyyy').format(finExtratoContaBanco.dataBalancete) : ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.historico ?? ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.documento ?? ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.valor != null ? Constantes.formatoDecimalValor.format(finExtratoContaBanco.valor) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.conciliado ?? ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
		DataCell(Text('${finExtratoContaBanco.observacao ?? ''}'), onTap: () {
			detalharFinExtratoContaBanco(finExtratoContaBanco, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinExtratoContaBanco.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinExtratoContaBanco(FinExtratoContaBanco finExtratoContaBanco, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finExtratoContaBancoDetalhe',
    arguments: finExtratoContaBanco,
  );
}