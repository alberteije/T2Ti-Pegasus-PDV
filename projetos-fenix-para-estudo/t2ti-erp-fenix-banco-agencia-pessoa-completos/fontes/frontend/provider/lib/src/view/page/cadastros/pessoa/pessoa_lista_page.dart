import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/view_model/cadastros/pessoa_view_model.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/filtro_page.dart';

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
    var pessoaProvider = Provider.of<PessoaViewModel>(context);
    var listaPessoa = pessoaProvider.listaPessoa;
    var colunas = Pessoa.colunas;
    var campos = Pessoa.campos;

    final PessoaDataSource _pessoaDataSource =
        PessoaDataSource(listaPessoa, context);

    void _sort<T>(Comparable<T> getField(Pessoa pessoa), int columnIndex,
        bool ascending) {
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
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.add),
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
          color: Colors.black26,
          shape: CircularNotchedRectangle(),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.filter),
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
                ? Center(
                    child:
                        Provider.of<PessoaViewModel>(context).objetoJsonErro ==
                                null
                            ? Center(child: CircularProgressIndicator())
                            : ErroPage(
                                objetoJsonErro:
                                    Provider.of<PessoaViewModel>(context)
                                        .objetoJsonErro))
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
                            tooltip: 'Nome da pessoa',
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>((Pessoa pessoa) => pessoa.nome,
                                    columnIndex, ascending),
                          ),
                          DataColumn(
                            label: const Text('Tipo'),
                            tooltip: 'Tipo de Pessoa: Física ou Jurídica',
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>((Pessoa pessoa) => pessoa.tipo,
                                    columnIndex, ascending),
                          ),
                          DataColumn(
                            label: const Text('Site'),
                            tooltip: 'Site da Pessoa',
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>((Pessoa pessoa) => pessoa.site,
                                    columnIndex, ascending),
                          ),
                          DataColumn(
                            label: const Text('Email'),
                            tooltip: 'Email da Pessoa',
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>((Pessoa pessoa) => pessoa.email,
                                    columnIndex, ascending),
                          ),
                          DataColumn(
                            label: const Text('Cliente'),
                            tooltip: 'Pessoa é Cliente',
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>((Pessoa pessoa) => pessoa.cliente,
                                    columnIndex, ascending),
                          ),
                          DataColumn(
                            label: const Text('Fornecedor'),
                            tooltip: 'Pessoa é Fornecedor',
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>(
                                    (Pessoa pessoa) => pessoa.fornecedor,
                                    columnIndex,
                                    ascending),
                          ),
                          DataColumn(
                            label: const Text('Transportadora'),
                            tooltip: 'Pessoa é Transportadora',
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>(
                                    (Pessoa pessoa) => pessoa.transportadora,
                                    columnIndex,
                                    ascending),
                          ),
                          DataColumn(
                            label: const Text('Colaborador'),
                            tooltip: 'Pessoa é Colaborador',
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>(
                                    (Pessoa pessoa) => pessoa.colaborador,
                                    columnIndex,
                                    ascending),
                          ),
                          DataColumn(
                            label: const Text('Contador'),
                            tooltip: 'Pessoa é Contador',
                            onSort: (int columnIndex, bool ascending) =>
                                _sort<String>(
                                    (Pessoa pessoa) => pessoa.contador,
                                    columnIndex,
                                    ascending),
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
        DataCell(Text('${pessoa.id ?? ''}'), onTap: () {
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
