/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FIN_CHEQUE_RECEBIDO] 
                                                                                
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
import 'fin_cheque_recebido_persiste_page.dart';

class FinChequeRecebidoListaPage extends StatefulWidget {
  @override
  _FinChequeRecebidoListaPageState createState() => _FinChequeRecebidoListaPageState();
}

class _FinChequeRecebidoListaPageState extends State<FinChequeRecebidoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinChequeRecebidoViewModel>(context).listaFinChequeRecebido == null && Provider.of<FinChequeRecebidoViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinChequeRecebidoViewModel>(context).consultarLista();
    }
    var listaFinChequeRecebido = Provider.of<FinChequeRecebidoViewModel>(context).listaFinChequeRecebido;
    var colunas = FinChequeRecebido.colunas;
    var campos = FinChequeRecebido.campos;

    final FinChequeRecebidoDataSource _finChequeRecebidoDataSource =
        FinChequeRecebidoDataSource(listaFinChequeRecebido, context);

    void _sort<T>(Comparable<T> getField(FinChequeRecebido finChequeRecebido), int columnIndex, bool ascending) {
      _finChequeRecebidoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinChequeRecebidoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Cheque Recebido'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinChequeRecebidoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Cheque Recebido'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FinChequeRecebidoPersistePage(finChequeRecebido: FinChequeRecebido(), title: 'Cheque Recebido - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinChequeRecebidoViewModel>(context).consultarLista();
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
                          title: 'Cheque Recebido - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinChequeRecebidoViewModel>(context)
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
            child: listaFinChequeRecebido == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Cheque Recebido'),
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
									_sort<num>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Pessoa'),
								tooltip: 'Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('CPF'),
								tooltip: 'CPF',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.cpf,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('CNPJ'),
								tooltip: 'CNPJ',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.cnpj,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código Banco'),
								tooltip: 'Código Banco',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.codigoBanco,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código Agência'),
								tooltip: 'Código Agência',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.codigoAgencia,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Conta'),
								tooltip: 'Conta',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.conta,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Número do Cheque'),
								tooltip: 'Número do Cheque',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.numero,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Emissão'),
								tooltip: 'Data de Emissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.dataEmissao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Cheque Bom Para'),
								tooltip: 'Cheque Bom Para',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.bomPara,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Compensação'),
								tooltip: 'Data de Compensação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.dataCompensacao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor'),
								tooltip: 'Valor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.valor,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Tarifa Custódia'),
								tooltip: 'Tarifa Custódia',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.custodiaTarifa,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Custódia Comissão'),
								tooltip: 'Custódia Comissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.custodiaComissao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Tarifa Desconto'),
								tooltip: 'Tarifa Desconto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.descontoTarifa,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Desconto Comissão'),
								tooltip: 'Desconto Comissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.descontoComissao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Recebido'),
								tooltip: 'Valor Recebido',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinChequeRecebido finChequeRecebido) => finChequeRecebido.valorRecebido,
									columnIndex, ascending),
							),
                        ],
                        source: _finChequeRecebidoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinChequeRecebidoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinChequeRecebidoDataSource extends DataTableSource {
  final List<FinChequeRecebido> listaFinChequeRecebido;
  final BuildContext context;

  FinChequeRecebidoDataSource(this.listaFinChequeRecebido, this.context);

  void _sort<T>(Comparable<T> getField(FinChequeRecebido finChequeRecebido), bool ascending) {
    listaFinChequeRecebido.sort((FinChequeRecebido a, FinChequeRecebido b) {
      if (!ascending) {
        final FinChequeRecebido c = a;
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
    if (index >= listaFinChequeRecebido.length) return null;
    final FinChequeRecebido finChequeRecebido = listaFinChequeRecebido[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finChequeRecebido.id ?? ''}'), onTap: () {
          detalharFinChequeRecebido(finChequeRecebido, context);
        }),
		DataCell(Text('${finChequeRecebido.pessoa?.nome ?? ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.cpf ?? ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.cnpj ?? ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.nome ?? ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.codigoBanco ?? ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.codigoAgencia ?? ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.conta ?? ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.numero ?? ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.dataEmissao != null ? DateFormat('dd/MM/yyyy').format(finChequeRecebido.dataEmissao) : ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.bomPara != null ? DateFormat('dd/MM/yyyy').format(finChequeRecebido.bomPara) : ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.dataCompensacao != null ? DateFormat('dd/MM/yyyy').format(finChequeRecebido.dataCompensacao) : ''}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.valor != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.valor) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.custodiaTarifa != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.custodiaTarifa) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.custodiaComissao != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.custodiaComissao) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.descontoTarifa != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.descontoTarifa) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.descontoComissao != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.descontoComissao) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
		DataCell(Text('${finChequeRecebido.valorRecebido != null ? Constantes.formatoDecimalValor.format(finChequeRecebido.valorRecebido) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinChequeRecebido(finChequeRecebido, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinChequeRecebido.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinChequeRecebido(FinChequeRecebido finChequeRecebido, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finChequeRecebidoDetalhe',
    arguments: finChequeRecebido,
  );
}