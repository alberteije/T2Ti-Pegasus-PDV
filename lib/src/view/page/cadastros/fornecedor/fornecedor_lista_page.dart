/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [FORNECEDOR] 
                                                                                
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

import 'fornecedor_persiste_page.dart';

class FornecedorListaPage extends StatefulWidget {
  @override
  _FornecedorListaPageState createState() => _FornecedorListaPageState();
}

class _FornecedorListaPageState extends State<FornecedorListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = FornecedorDao.colunas;
  final _campos = FornecedorDao.campos;

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
    final _listaFornecedor = Sessao.db.fornecedorDao.listaFornecedor;

    final _FornecedorDataSource _fornecedorDataSource = _FornecedorDataSource(_listaFornecedor, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(Fornecedor fornecedor), int columnIndex, bool ascending) {
      _fornecedorDataSource._sort<T>(getField, ascending);
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
            title: const Text('Cadastro - Fornecedor'),
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
              child: _listaFornecedor == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Relação - Fornecedor'),
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
                          _sort<num>((Fornecedor fornecedor) => fornecedor.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Tipo Pessoa'),
                        tooltip: 'Conteúdo para o campo Tipo Pessoa',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.tipoPessoa, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Nome'),
                        tooltip: 'Conteúdo para o campo Nome',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Fantasia'),
                        tooltip: 'Conteúdo para o campo Fantasia',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.fantasia, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Email'),
                        tooltip: 'Conteúdo para o campo Email',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.email, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Url'),
                        tooltip: 'Conteúdo para o campo Url',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.url, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cpf Cnpj'),
                        tooltip: 'Conteúdo para o campo Cpf Cnpj',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.cpfCnpj, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Rg'),
                        tooltip: 'Conteúdo para o campo Rg',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.rg, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Orgao Rg'),
                        tooltip: 'Conteúdo para o campo Orgao Rg',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.orgaoRg, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Emissao Rg'),
                        tooltip: 'Conteúdo para o campo Data Emissao Rg',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((Fornecedor fornecedor) => fornecedor.dataEmissaoRg, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Sexo'),
                        tooltip: 'Conteúdo para o campo Sexo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.sexo, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Inscricao Estadual'),
                        tooltip: 'Conteúdo para o campo Inscricao Estadual',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.inscricaoEstadual, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Inscricao Municipal'),
                        tooltip: 'Conteúdo para o campo Inscricao Municipal',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.inscricaoMunicipal, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Cadastro'),
                        tooltip: 'Conteúdo para o campo Data Cadastro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((Fornecedor fornecedor) => fornecedor.dataCadastro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Logradouro'),
                        tooltip: 'Conteúdo para o campo Logradouro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.logradouro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Numero'),
                        tooltip: 'Conteúdo para o campo Numero',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.numero, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Complemento'),
                        tooltip: 'Conteúdo para o campo Complemento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.complemento, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cep'),
                        tooltip: 'Conteúdo para o campo Cep',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.cep, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Bairro'),
                        tooltip: 'Conteúdo para o campo Bairro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.bairro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cidade'),
                        tooltip: 'Conteúdo para o campo Cidade',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.cidade, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Uf'),
                        tooltip: 'Conteúdo para o campo Uf',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.uf, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Telefone'),
                        tooltip: 'Conteúdo para o campo Telefone',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.telefone, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Celular'),
                        tooltip: 'Conteúdo para o campo Celular',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.celular, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Contato'),
                        tooltip: 'Conteúdo para o campo Contato',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Fornecedor fornecedor) => fornecedor.contato, columnIndex, ascending),
                      ),
                    ],
                    source: _fornecedorDataSource,
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
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => 
            FornecedorPersistePage(fornecedor: Fornecedor(id: null, dataCadastro: DateTime.now()), title: 'Fornecedor - Inserindo', operacao: 'I')))
      .then((_) async {
        await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Fornecedor - Filtro',
            colunas: _colunas,
            campoPesquisaPadrao: 'Nome',
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Sessao.db.fornecedorDao.consultarListaFiltro(_filtro.campo, _filtro.valor);
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
    await Sessao.db.fornecedorDao.consultarLista();
    setState(() {
    });
  }
}


/// codigo referente a fonte de dados
class _FornecedorDataSource extends DataTableSource {
  final List<Fornecedor> listaFornecedor;
  final BuildContext context;
  final Function refrescarTela;
 
  _FornecedorDataSource(this.listaFornecedor, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T> getField(Fornecedor fornecedor), bool ascending) {
    listaFornecedor.sort((Fornecedor a, Fornecedor b) {
      if (!ascending) {
        final Fornecedor c = a;
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
    if (index >= listaFornecedor.length) return null;
    final Fornecedor fornecedor = listaFornecedor[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${fornecedor.id ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.tipoPessoa ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.nome ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.fantasia ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.email ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.url ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.cpfCnpj ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.rg ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.orgaoRg ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.dataEmissaoRg != null ? DateFormat('dd/MM/yyyy').format(fornecedor.dataEmissaoRg) : ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.sexo ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.inscricaoEstadual ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.inscricaoMunicipal ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(fornecedor.dataCadastro) : ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.logradouro ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.numero ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.complemento ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.cep ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.bairro ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.cidade ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.uf ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.telefone ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.celular ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
        DataCell(Text('${fornecedor.contato ?? ''}'), onTap: () {
          _detalharFornecedor(fornecedor, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaFornecedor.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharFornecedor(Fornecedor fornecedor, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => FornecedorPersistePage(
      fornecedor: fornecedor, title: 'Fornecedor - Editando', operacao: 'A')))
    .then((_) async {    
      await refrescarTela();
   });
}