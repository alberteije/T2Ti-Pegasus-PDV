/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [CLIENTE] 
                                                                                
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

import 'cliente_persiste_page.dart';

class ClienteListaPage extends StatefulWidget {
  @override
  _ClienteListaPageState createState() => _ClienteListaPageState();
}

class _ClienteListaPageState extends State<ClienteListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = ClienteDao.colunas;
  final _campos = ClienteDao.campos;

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
    final _listaCliente = Sessao.db.clienteDao.listaCliente;

    final _ClienteDataSource _clienteDataSource = _ClienteDataSource(_listaCliente, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(Cliente cliente), int columnIndex, bool ascending) {
      _clienteDataSource._sort<T>(getField, ascending);
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
            title: const Text('Cadastro - Cliente'),
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
              child: _listaCliente == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
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
                        numeric: true,
                        label: const Text('Id'),
                        tooltip: 'Id',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((Cliente cliente) => cliente.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Tipo Pessoa'),
                        tooltip: 'Conteúdo para o campo Tipo Pessoa',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.tipoPessoa, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Nome'),
                        tooltip: 'Conteúdo para o campo Nome',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Fantasia'),
                        tooltip: 'Conteúdo para o campo Fantasia',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.fantasia, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Email'),
                        tooltip: 'Conteúdo para o campo Email',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.email, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Url'),
                        tooltip: 'Conteúdo para o campo Url',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.url, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cpf Cnpj'),
                        tooltip: 'Conteúdo para o campo Cpf Cnpj',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.cpfCnpj, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Rg'),
                        tooltip: 'Conteúdo para o campo Rg',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.rg, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Orgao Rg'),
                        tooltip: 'Conteúdo para o campo Orgao Rg',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.orgaoRg, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Emissao Rg'),
                        tooltip: 'Conteúdo para o campo Data Emissao Rg',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((Cliente cliente) => cliente.dataEmissaoRg, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Sexo'),
                        tooltip: 'Conteúdo para o campo Sexo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.sexo, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Inscricao Estadual'),
                        tooltip: 'Conteúdo para o campo Inscricao Estadual',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.inscricaoEstadual, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Inscricao Municipal'),
                        tooltip: 'Conteúdo para o campo Inscricao Municipal',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.inscricaoMunicipal, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Cadastro'),
                        tooltip: 'Conteúdo para o campo Data Cadastro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((Cliente cliente) => cliente.dataCadastro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Logradouro'),
                        tooltip: 'Conteúdo para o campo Logradouro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.logradouro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Numero'),
                        tooltip: 'Conteúdo para o campo Numero',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.numero, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Complemento'),
                        tooltip: 'Conteúdo para o campo Complemento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.complemento, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cep'),
                        tooltip: 'Conteúdo para o campo Cep',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.cep, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Bairro'),
                        tooltip: 'Conteúdo para o campo Bairro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.bairro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cidade'),
                        tooltip: 'Conteúdo para o campo Cidade',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.cidade, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Uf'),
                        tooltip: 'Conteúdo para o campo Uf',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.uf, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Telefone'),
                        tooltip: 'Conteúdo para o campo Telefone',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.telefone, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Celular'),
                        tooltip: 'Conteúdo para o campo Celular',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.celular, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Contato'),
                        tooltip: 'Conteúdo para o campo Contato',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((Cliente cliente) => cliente.contato, columnIndex, ascending),
                      ),
                    ],
                    source: _clienteDataSource,
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
            ClientePersistePage(cliente: Cliente(id: null, dataCadastro: DateTime.now()), title: 'Cliente - Inserindo', operacao: 'I')))
      .then((_) async {
        await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Cliente - Filtro',
            colunas: _colunas,
            campoPesquisaPadrao: 'Nome',
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Sessao.db.clienteDao.consultarListaFiltro(_filtro.campo, _filtro.valor);
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
    await Sessao.db.clienteDao.consultarLista();
    setState(() {
    });
  }
}


/// codigo referente a fonte de dados
class _ClienteDataSource extends DataTableSource {
  final List<Cliente> listaCliente;
  final BuildContext context;
  final Function refrescarTela;
 
  _ClienteDataSource(this.listaCliente, this.context, this.refrescarTela);

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
        DataCell(Text('${cliente.id ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.tipoPessoa ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.nome ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.fantasia ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.email ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.url ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.cpfCnpj ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.rg ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.orgaoRg ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.dataEmissaoRg != null ? DateFormat('dd/MM/yyyy').format(cliente.dataEmissaoRg) : ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.sexo ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.inscricaoEstadual ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.inscricaoMunicipal ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(cliente.dataCadastro) : ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.logradouro ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.numero ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.complemento ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.cep ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.bairro ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.cidade ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.uf ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.telefone ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.celular ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
        }),
        DataCell(Text('${cliente.contato ?? ''}'), onTap: () {
          _detalharCliente(cliente, context, refrescarTela);
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

void _detalharCliente(Cliente cliente, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => ClientePersistePage(
      cliente: cliente, title: 'Cliente - Editando', operacao: 'A')))
    .then((_) async {    
      await refrescarTela();
   });
}