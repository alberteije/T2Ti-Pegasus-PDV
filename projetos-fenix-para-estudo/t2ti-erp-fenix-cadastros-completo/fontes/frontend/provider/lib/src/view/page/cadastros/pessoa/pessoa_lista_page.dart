/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [PESSOA] 
                                                                                
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
import 'pessoa_page.dart';

class PessoaListaPage extends StatefulWidget {
  @override
  _PessoaListaPageState createState() => _PessoaListaPageState();
}

class _PessoaListaPageState extends State<PessoaListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<PessoaViewModel>(context).listaPessoa == null && Provider.of<PessoaViewModel>(context).objetoJsonErro == null) {
      Provider.of<PessoaViewModel>(context).consultarLista();
    }     
    var pessoaProvider = Provider.of<PessoaViewModel>(context);
    var listaPessoa = pessoaProvider.listaPessoa;
    var colunas = Pessoa.colunas;
    var campos = Pessoa.campos;

    final PessoaDataSource _pessoaDataSource =
        PessoaDataSource(listaPessoa, context);

    void _sort<T>(Comparable<T> getField(Pessoa pessoa), int columnIndex, bool ascending) {
      _pessoaDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<PessoaViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Pessoa'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<PessoaViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Pessoa'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      PessoaPage(pessoa: Pessoa(), title: 'Pessoa - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<PessoaViewModel>(context).consultarLista();
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
                          title: 'Pessoa - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<PessoaViewModel>(context)
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
            child: listaPessoa == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Pessoa'),
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
                                  _sort<num>((Pessoa pessoa) => pessoa.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Pessoa pessoa) => pessoa.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Tipo'),
								tooltip: 'Tipo de Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Pessoa pessoa) => pessoa.tipo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Site'),
								tooltip: 'Site',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Pessoa pessoa) => pessoa.site,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('E-Mail'),
								tooltip: 'E-Mail',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Pessoa pessoa) => pessoa.email,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('É Cliente'),
								tooltip: 'Pessoa é Cliente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Pessoa pessoa) => pessoa.cliente,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('É Fornecedor'),
								tooltip: 'Pessoa é Fornecedor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Pessoa pessoa) => pessoa.fornecedor,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('É Transportadora'),
								tooltip: 'Pessoa é Transportadora',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Pessoa pessoa) => pessoa.transportadora,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('É Colaborador'),
								tooltip: 'Pessoa é Colaborador',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Pessoa pessoa) => pessoa.colaborador,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('É Contador'),
								tooltip: 'Pessoa é Contador',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((Pessoa pessoa) => pessoa.contador,
									columnIndex, ascending),
							),
                        ],
                        source: _pessoaDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<PessoaViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class PessoaDataSource extends DataTableSource {
  final List<Pessoa> listaPessoa;
  final BuildContext context;

  PessoaDataSource(this.listaPessoa, this.context);

  void _sort<T>(Comparable<T> getField(Pessoa pessoa), bool ascending) {
    listaPessoa.sort((Pessoa a, Pessoa b) {
      if (!ascending) {
        final Pessoa c = a;
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
    if (index >= listaPessoa.length) return null;
    final Pessoa pessoa = listaPessoa[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ pessoa.id ?? ''}'), onTap: () {
          detalharPessoa(pessoa, context);
        }),
		DataCell(Text('${pessoa.nome ?? ''}'), onTap: () {
			detalharPessoa(pessoa, context);
		}),
		DataCell(Text('${pessoa.tipo ?? ''}'), onTap: () {
			detalharPessoa(pessoa, context);
		}),
		DataCell(Text('${pessoa.site ?? ''}'), onTap: () {
			detalharPessoa(pessoa, context);
		}),
		DataCell(Text('${pessoa.email ?? ''}'), onTap: () {
			detalharPessoa(pessoa, context);
		}),
		DataCell(Text('${pessoa.cliente ?? ''}'), onTap: () {
			detalharPessoa(pessoa, context);
		}),
		DataCell(Text('${pessoa.fornecedor ?? ''}'), onTap: () {
			detalharPessoa(pessoa, context);
		}),
		DataCell(Text('${pessoa.transportadora ?? ''}'), onTap: () {
			detalharPessoa(pessoa, context);
		}),
		DataCell(Text('${pessoa.colaborador ?? ''}'), onTap: () {
			detalharPessoa(pessoa, context);
		}),
		DataCell(Text('${pessoa.contador ?? ''}'), onTap: () {
			detalharPessoa(pessoa, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaPessoa.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharPessoa(Pessoa pessoa, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/pessoaDetalhe',
    arguments: pessoa,
  );
}
