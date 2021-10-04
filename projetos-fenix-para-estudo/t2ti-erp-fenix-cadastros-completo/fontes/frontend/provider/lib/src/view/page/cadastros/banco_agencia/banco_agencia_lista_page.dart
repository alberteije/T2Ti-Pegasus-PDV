/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [BANCO_AGENCIA] 
                                                                                
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
import 'banco_agencia_persiste_page.dart';

class BancoAgenciaListaPage extends StatefulWidget {
  @override
  _BancoAgenciaListaPageState createState() => _BancoAgenciaListaPageState();
}

class _BancoAgenciaListaPageState extends State<BancoAgenciaListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<BancoAgenciaViewModel>(context).listaBancoAgencia == null && Provider.of<BancoAgenciaViewModel>(context).objetoJsonErro == null) {
      Provider.of<BancoAgenciaViewModel>(context).consultarLista();
    }
    var listaBancoAgencia = Provider.of<BancoAgenciaViewModel>(context).listaBancoAgencia;
    var colunas = BancoAgencia.colunas;
    var campos = BancoAgencia.campos;

    final BancoAgenciaDataSource _bancoAgenciaDataSource =
        BancoAgenciaDataSource(listaBancoAgencia, context);

    void _sort<T>(Comparable<T> getField(BancoAgencia bancoAgencia), int columnIndex, bool ascending) {
      _bancoAgenciaDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<BancoAgenciaViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Banco Agencia'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<BancoAgenciaViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Banco Agencia'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  BancoAgenciaPersistePage(bancoAgencia: BancoAgencia(), title: 'Banco Agencia - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<BancoAgenciaViewModel>(context).consultarLista();
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
                          title: 'Banco Agencia - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<BancoAgenciaViewModel>(context)
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
            child: listaBancoAgencia == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Banco Agencia'),
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
									_sort<num>((BancoAgencia bancoAgencia) => bancoAgencia.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Banco'),
								tooltip: 'Banco',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((BancoAgencia bancoAgencia) => bancoAgencia.banco.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Número'),
								tooltip: 'Número',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((BancoAgencia bancoAgencia) => bancoAgencia.numero,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Dígito'),
								tooltip: 'Dígito',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((BancoAgencia bancoAgencia) => bancoAgencia.digito,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((BancoAgencia bancoAgencia) => bancoAgencia.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Telefone'),
								tooltip: 'Telefone',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((BancoAgencia bancoAgencia) => bancoAgencia.telefone,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Contato'),
								tooltip: 'Contato',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((BancoAgencia bancoAgencia) => bancoAgencia.contato,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((BancoAgencia bancoAgencia) => bancoAgencia.observacao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Gerente'),
								tooltip: 'Gerente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((BancoAgencia bancoAgencia) => bancoAgencia.gerente,
									columnIndex, ascending),
							),
                        ],
                        source: _bancoAgenciaDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<BancoAgenciaViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class BancoAgenciaDataSource extends DataTableSource {
  final List<BancoAgencia> listaBancoAgencia;
  final BuildContext context;

  BancoAgenciaDataSource(this.listaBancoAgencia, this.context);

  void _sort<T>(Comparable<T> getField(BancoAgencia bancoAgencia), bool ascending) {
    listaBancoAgencia.sort((BancoAgencia a, BancoAgencia b) {
      if (!ascending) {
        final BancoAgencia c = a;
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
    if (index >= listaBancoAgencia.length) return null;
    final BancoAgencia bancoAgencia = listaBancoAgencia[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ bancoAgencia.id ?? ''}'), onTap: () {
          detalharBancoAgencia(bancoAgencia, context);
        }),
		DataCell(Text('${bancoAgencia.banco.nome ?? ''}'), onTap: () {
			detalharBancoAgencia(bancoAgencia, context);
		}),
		DataCell(Text('${bancoAgencia.numero ?? ''}'), onTap: () {
			detalharBancoAgencia(bancoAgencia, context);
		}),
		DataCell(Text('${bancoAgencia.digito ?? ''}'), onTap: () {
			detalharBancoAgencia(bancoAgencia, context);
		}),
		DataCell(Text('${bancoAgencia.nome ?? ''}'), onTap: () {
			detalharBancoAgencia(bancoAgencia, context);
		}),
		DataCell(Text('${bancoAgencia.telefone ?? ''}'), onTap: () {
			detalharBancoAgencia(bancoAgencia, context);
		}),
		DataCell(Text('${bancoAgencia.contato ?? ''}'), onTap: () {
			detalharBancoAgencia(bancoAgencia, context);
		}),
		DataCell(Text('${bancoAgencia.observacao ?? ''}'), onTap: () {
			detalharBancoAgencia(bancoAgencia, context);
		}),
		DataCell(Text('${bancoAgencia.gerente ?? ''}'), onTap: () {
			detalharBancoAgencia(bancoAgencia, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaBancoAgencia.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharBancoAgencia(BancoAgencia bancoAgencia, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/bancoAgenciaDetalhe',
    arguments: bancoAgencia,
  );
}