/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [EMPRESA] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
import 'package:intl/intl.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/model/filtro.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/filtro_page.dart';

class EmpresaListaPage extends StatefulWidget {
  @override
  _EmpresaListaPageState createState() => _EmpresaListaPageState();
}

class _EmpresaListaPageState extends State<EmpresaListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = EmpresaDao.colunas;
  final _campos = EmpresaDao.campos;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosListaPage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) => _refrescarTela());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.inserir:
        _inserir();
        break;
      case AtalhoTelaType.imprimir:
        _gerarRelatorio();
        break;
      case AtalhoTelaType.filtrar:
        _chamarFiltro();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final _listaEmpresa = Sessao.db.empresaDao.listaEmpresa;

    final _EmpresaDataSource _empresaDataSource = _EmpresaDataSource(_listaEmpresa, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(Empresa empresa), int columnIndex, bool ascending) {
      _empresaDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }
	
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Cadastro - Empresa'),
            actions: <Widget>[],
          ),
          floatingActionButton: FloatingActionButton(
            focusColor: ViewUtilLib.getBotaoFocusColor(),
            tooltip: Constantes.botaoInserirDica,
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              _inserir();
            }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),          
            shape: CircularNotchedRectangle(),
            child: Row(
              children: getBotoesNavigationBarListaPage(
                context: context, 
                chamarFiltro: _chamarFiltro, 
                gerarRelatorio: _gerarRelatorio,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              child: _listaEmpresa == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Relação - Empresa'),
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
                        numeric: true,
                        label: const Text('Id'),
                        tooltip: 'Id',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((Empresa empresa) => empresa.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Razao Social'),
                        tooltip: 'Conteúdo para o campo Razao Social',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.razaoSocial, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Nome Fantasia'),
                        tooltip: 'Conteúdo para o campo Nome Fantasia',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.nomeFantasia, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cnpj'),
                        tooltip: 'Conteúdo para o campo Cnpj',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.cnpj, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Inscricao Estadual'),
                        tooltip: 'Conteúdo para o campo Inscricao Estadual',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.inscricaoEstadual, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Inscricao Municipal'),
                        tooltip: 'Conteúdo para o campo Inscricao Municipal',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.inscricaoMunicipal, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Constituicao'),
                        tooltip: 'Conteúdo para o campo Data Constituicao',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((Empresa empresa) => empresa.dataConstituicao, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Tipo'),
                        tooltip: 'Conteúdo para o campo Tipo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.tipo, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Email'),
                        tooltip: 'Conteúdo para o campo Email',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.email, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Logradouro'),
                        tooltip: 'Conteúdo para o campo Logradouro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.logradouro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Numero'),
                        tooltip: 'Conteúdo para o campo Numero',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.numero, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Complemento'),
                        tooltip: 'Conteúdo para o campo Complemento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.complemento, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cep'),
                        tooltip: 'Conteúdo para o campo Cep',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.cep, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Bairro'),
                        tooltip: 'Conteúdo para o campo Bairro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.bairro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cidade'),
                        tooltip: 'Conteúdo para o campo Cidade',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.cidade, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Uf'),
                        tooltip: 'Conteúdo para o campo Uf',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.uf, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Fone'),
                        tooltip: 'Conteúdo para o campo Fone',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.fone, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Contato'),
                        tooltip: 'Conteúdo para o campo Contato',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Empresa empresa) => empresa.contato, columnIndex, ascending),
                      ),
                    ],
                    source: _empresaDataSource,
                  ),
                ],
              ),
            ),
          ),          
        ),
      ),
    );
  }

  void _inserir() {
    // Comentado, pois vamos chamar diretamente a página de persistência, permitindo a persistência da única empresa no BD
    // Navigator.of(context)
    //   .push(MaterialPageRoute(
    //     builder: (BuildContext context) => 
    //         EmpresaPersistePage(empresa: Empresa(id: null,), title: 'Empresa - Inserindo', operacao: 'I')))
    //   .then((_) async {
    //     await _refrescarTela();
    // });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Empresa - Filtro',
            colunas: _colunas,
            campoPesquisaPadrao: 'Nome',
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Sessao.db.empresaDao.consultarListaFiltro(_filtro.campo, _filtro.valor);
        setState(() {
        });
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxInformacao(
      context, 'Essa janela não possui relatório implementado');
  }

  Future _refrescarTela() async {
    await Sessao.db.empresaDao.consultarLista();
    setState(() {
    });
  }
}


/// codigo referente a fonte de dados
class _EmpresaDataSource extends DataTableSource {
  final List<Empresa> listaEmpresa;
  final BuildContext context;
  final Function refrescarTela;
 
  _EmpresaDataSource(this.listaEmpresa, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T> getField(Empresa empresa), bool ascending) {
    listaEmpresa.sort((Empresa a, Empresa b) {
      if (!ascending) {
        final Empresa c = a;
        a = b;
        b = c;
      }
      Comparable<T> aValue = getField(a);
      Comparable<T> bValue = getField(b);

      if (aValue == null) aValue = '' as Comparable<T>;
      if (bValue == null) bValue = '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= listaEmpresa.length) return null;
    final Empresa empresa = listaEmpresa[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${empresa.id ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.razaoSocial ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.nomeFantasia ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.cnpj ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.inscricaoEstadual ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.inscricaoMunicipal ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.dataConstituicao != null ? DateFormat('dd/MM/yyyy').format(empresa.dataConstituicao) : ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.tipo ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.email ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.logradouro ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.numero ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.complemento ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.cep ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.bairro ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.cidade ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.uf ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.fone ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
        DataCell(Text('${empresa.contato ?? ''}'), onTap: () {
          _detalharEmpresa(empresa, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaEmpresa.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharEmpresa(Empresa empresa, BuildContext context, Function refrescarTela) {
  // Comentado, pois vamos chamar diretamente a página de persistência, permitindo a persistência da única empresa no BD
  // Navigator.of(context)
  //   .push(MaterialPageRoute(
  //     builder: (BuildContext context) => EmpresaPersistePage(
  //     empresa: empresa, title: 'Empresa - Editando', operacao: 'A')))
  //   .then((_) async {    
  //     await refrescarTela();
  //  });
}