/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [CLIENTE] 
                                                                                
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
import 'cliente_persiste_page.dart';

class ClienteListaPage extends StatefulWidget {
  @override
  _ClienteListaPageState createState() => _ClienteListaPageState();
}

class _ClienteListaPageState extends State<ClienteListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ClienteViewModel>(context).listaCliente == null && Provider.of<ClienteViewModel>(context).objetoJsonErro == null) {
      Provider.of<ClienteViewModel>(context).consultarLista();
    }
    var listaCliente = Provider.of<ClienteViewModel>(context).listaCliente;
    var colunas = Cliente.colunas;
    var campos = Cliente.campos;

    final ClienteDataSource _clienteDataSource =
        ClienteDataSource(listaCliente, context);

    void _sort<T>(Comparable<T> getField(Cliente cliente), int columnIndex, bool ascending) {
      _clienteDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ClienteViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cliente'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ClienteViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Cliente'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  ClientePersistePage(cliente: Cliente(), title: 'Cliente - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<ClienteViewModel>(context).consultarLista();
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
                          title: 'Cliente - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ClienteViewModel>(context)
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
            child: listaCliente == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Cliente'),
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
									_sort<num>((Cliente cliente) => cliente.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Pessoa'),
								tooltip: 'Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cliente cliente) => cliente.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Desde'),
								tooltip: 'Cliente Desde',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Cliente cliente) => cliente.desde,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Cadastro'),
								tooltip: 'Data de Cadastro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((Cliente cliente) => cliente.dataCadastro,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa de Desconto'),
								tooltip: 'Taxa de Desconto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Cliente cliente) => cliente.taxaDesconto,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Limite de Crédito'),
								tooltip: 'Limite de Crédito',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((Cliente cliente) => cliente.limiteCredito,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Cliente cliente) => cliente.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _clienteDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<ClienteViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class ClienteDataSource extends DataTableSource {
  final List<Cliente> listaCliente;
  final BuildContext context;

  ClienteDataSource(this.listaCliente, this.context);

  void _sort<T>(Comparable<T> getField(Cliente cliente), bool ascending) {
    listaCliente.sort((Cliente a, Cliente b) {
      if (!ascending) {
        final Cliente c = a;
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
    if (index >= listaCliente.length) return null;
    final Cliente cliente = listaCliente[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ cliente.id ?? ''}'), onTap: () {
          detalharCliente(cliente, context);
        }),
		DataCell(Text('${cliente.pessoa?.nome ?? ''}'), onTap: () {
			detalharCliente(cliente, context);
		}),
		DataCell(Text('${cliente.desde != null ? DateFormat('dd/MM/yyyy').format(cliente.desde) : ''}'), onTap: () {
			detalharCliente(cliente, context);
		}),
		DataCell(Text('${cliente.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(cliente.dataCadastro) : ''}'), onTap: () {
			detalharCliente(cliente, context);
		}),
		DataCell(Text('${cliente.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(cliente.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharCliente(cliente, context);
		}),
		DataCell(Text('${cliente.limiteCredito != null ? Constantes.formatoDecimalValor.format(cliente.limiteCredito) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharCliente(cliente, context);
		}),
		DataCell(Text('${cliente.observacao ?? ''}'), onTap: () {
			detalharCliente(cliente, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaCliente.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharCliente(Cliente cliente, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/clienteDetalhe',
    arguments: cliente,
  );
}