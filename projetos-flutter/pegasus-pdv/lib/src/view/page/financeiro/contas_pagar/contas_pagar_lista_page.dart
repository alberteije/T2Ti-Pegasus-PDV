/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [CONTAS_PAGAR] 
                                                                                
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
import 'package:backdrop/backdrop.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/model/filtro.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/filtro_page.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_caixa.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

import 'contas_pagar_persiste_page.dart';

class ContasPagarListaPage extends StatefulWidget {
  @override
  _ContasPagarListaPageState createState() => _ContasPagarListaPageState();
}

class _ContasPagarListaPageState extends State<ContasPagarListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = ContasPagarDao.colunas;
  final _campos = ContasPagarDao.campos;

  DateTime _mesAno = DateTime.now();
  String _statusPagamento = 'Todos';
  double _totalPagar = 0;
  double _totalPago = 0;
  double _totalGeral = 0;
  var _listaContasPagarMontado;

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
    _listaContasPagarMontado = Sessao.db.contasPagarDao.listaContasPagarMontado;

    final _ContasPagarDataSource _contasPagarDataSource = _ContasPagarDataSource(_listaContasPagarMontado, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(ContasPagarMontado contasPagarMontado), int columnIndex, bool ascending) {
      _contasPagarDataSource._sort<T>(getField, ascending);
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
            title: const Text('Contas a Pagar'),
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 90, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: 
                    InputDecorator(
                      decoration: getInputDecoration(
                        'Mês/Ano para o Filtro',
                        'Mês/Ano para o Filtro',
                        true),
                      isEmpty: _mesAno == null,
                      child: DatePickerItem(
                        mascara: 'MM/yyyy',
                        dateTime: _mesAno,
                        firstDate: DateTime.parse('1900-01-01'),
                        lastDate: DateTime.parse('2050-01-01'),
                        onChanged: (DateTime value) {
                          _mesAno = value;
                          _refrescarTela();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: 
                    InputDecorator(
                      decoration: getInputDecoration(
                        'Status Pagamento',
                        'Status Pagamento',
                        true, paddingVertical: 1),
                      isEmpty: _statusPagamento == null,
                      child: getDropDownButton(_statusPagamento,
                        (String newValue) {
                          _statusPagamento = newValue;
                          _refrescarTela();
                      }, <String>[
                        'Todos',
                        'Pagar',
                        'Pago',
                      ]),
                    ),                  
                  ),
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: BackdropScaffold(     
              appBar: BackdropAppBar(
                title: Text("Relação - Contas Pagar"),
                actions: <Widget>[
                  BackdropToggleButton(
                    icon: AnimatedIcons.list_view,
                  ),
                ],
              ),               
              stickyFrontLayer: true,
              backLayer: getResumoTotais(context),
              frontLayer: Scrollbar(
                child: _listaContasPagarMontado == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                  padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                  children: <Widget>[
                    PaginatedDataTable(                        
                      // header: const Text('Relação - Contas Pagar'),
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
                            _sort<num>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.id, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Fornecedor'),
                          tooltip: 'Conteúdo para o campo Fornecedor',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.fornecedor?.nome, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Data de Lançamento'),
                          tooltip: 'Data de Lançamento',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<DateTime>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.dataLancamento, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Data de Vencimento'),
                          tooltip: 'Data de Vencimento',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<DateTime>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.dataVencimento, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Data de Pagamento'),
                          tooltip: 'Data de Pagamento',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<DateTime>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.dataPagamento, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor a Pagar'),
                          tooltip: 'Valor a Pagar',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.valorAPagar, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Taxa Juros'),
                          tooltip: 'Taxa Juros',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.taxaJuro, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Taxa Multa'),
                          tooltip: 'Taxa Multa',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.taxaMulta, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Taxa Desconto'),
                          tooltip: 'Taxa Desconto',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.taxaDesconto, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Juros'),
                          tooltip: 'Valor Juros',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.valorJuro, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Multa'),
                          tooltip: 'Valor Multa',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.valorMulta, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Desconto'),
                          tooltip: 'Valor Desconto',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.valorDesconto, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Pago'),
                          tooltip: 'Valor Pago',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.valorPago, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Número do Documento'),
                          tooltip: 'Número do Documento',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.numeroDocumento, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Histórico'),
                          tooltip: 'Histórico',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.historico, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Status Pagamento'),
                          tooltip: 'Conteúdo para o campo Status Pagamento',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((ContasPagarMontado contasPagarMontado) => contasPagarMontado.contasPagar.statusPagamento, columnIndex, ascending),
                        ),
                      ],
                      source: _contasPagarDataSource,
                    ),
                  ],
                ),
              ),
            ),          
          ),
        ),
      ),
    );
  }

  Widget getResumoTotais(BuildContext context) {
    // _refrescarTela();
    return Scrollbar(
    child: SingleChildScrollView(
      dragStartBehavior: DragStartBehavior.down,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Colors.amber.shade500,
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10.0),
            getItemResumoValor(
              descricao: 'Total a Pagar: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalPagar ?? 0)}',
              corFundo: Colors.blue.shade100,
            ),
            getItemResumoValor(
              descricao: 'Total Pago: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalPago ?? 0)}',
              corFundo: Colors.red.shade100,
            ),
            getItemResumoValor(
              descricao: 'Total Geral: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalGeral ?? 0)}',
              corFundo: Colors.green.shade100,
            ),
            const SizedBox(height: 10.0),
          ],),
        ),
      ),
    );    
  }  


  void _inserir() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => 
            ContasPagarPersistePage(contasPagarMontado: ContasPagarMontado(
              fornecedor: Fornecedor(id: null,),
              contasPagar: ContasPagar(id: null, dataVencimento: DateTime.now(),),
            ), title: 'Contas a Pagar - Inserindo', operacao: 'I')))
      .then((_) async {
        await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'ContasPagar - Filtro',
            colunas: _colunas,
            campoPesquisaPadrao: 'Nome',
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Sessao.db.contasPagarDao.consultarListaFiltro(_filtro.campo, _filtro.valor);
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
    _listaContasPagarMontado = await Sessao.db.contasPagarDao.consultarListaMontado(mes: _mesAno.month, ano: _mesAno.year, status: _statusPagamento);
    _atualizarTotais();
    setState(() {
    });
  }

  _atualizarTotais() {
    _totalPagar = 0;
    _totalPago = 0;
    _totalGeral = 0;
    for (ContasPagarMontado contasPagarMontado in _listaContasPagarMontado) {
      if (contasPagarMontado.contasPagar.statusPagamento == 'A') {
        _totalPagar = _totalPagar + (contasPagarMontado.contasPagar.valorAPagar ?? 0);        
      } else if (contasPagarMontado.contasPagar.statusPagamento == 'P') {
        _totalPago = _totalPago + (contasPagarMontado.contasPagar.valorPago ?? 0);        
      }
      _totalGeral = _totalGeral + (contasPagarMontado.contasPagar.valorAPagar ?? 0);
    }     
  }
}


/// codigo referente a fonte de dados
class _ContasPagarDataSource extends DataTableSource {
  final List<ContasPagarMontado> listaContasPagar;
  final BuildContext context;
  final Function refrescarTela;
 
  _ContasPagarDataSource(this.listaContasPagar, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T> getField(ContasPagarMontado contasPagar), bool ascending) {
    listaContasPagar.sort((ContasPagarMontado a, ContasPagarMontado b) {
      if (!ascending) {
        final ContasPagarMontado c = a;
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
    if (index >= listaContasPagar.length) return null;
    final ContasPagarMontado contasPagarMontado = listaContasPagar[index];
    final ContasPagar contasPagar = contasPagarMontado.contasPagar;
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${contasPagar.id ?? ''}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagarMontado.fornecedor?.nome ?? ''}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.dataLancamento != null ? DateFormat('dd/MM/yyyy').format(contasPagar.dataLancamento) : ''}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.dataVencimento != null ? DateFormat('dd/MM/yyyy').format(contasPagar.dataVencimento) : ''}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.dataPagamento != null ? DateFormat('dd/MM/yyyy').format(contasPagar.dataPagamento) : ''}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.valorAPagar != null ? Constantes.formatoDecimalValor.format(contasPagar.valorAPagar) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.taxaJuro != null ? Constantes.formatoDecimalTaxa.format(contasPagar.taxaJuro) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.taxaMulta != null ? Constantes.formatoDecimalTaxa.format(contasPagar.taxaMulta) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(contasPagar.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.valorJuro != null ? Constantes.formatoDecimalValor.format(contasPagar.valorJuro) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.valorMulta != null ? Constantes.formatoDecimalValor.format(contasPagar.valorMulta) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.valorDesconto != null ? Constantes.formatoDecimalValor.format(contasPagar.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.valorPago != null ? Constantes.formatoDecimalValor.format(contasPagar.valorPago) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.numeroDocumento ?? ''}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.historico ?? ''}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
        DataCell(Text('${contasPagar.statusPagamento ?? ''}'), onTap: () {
          _detalharContasPagar(contasPagarMontado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaContasPagar.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharContasPagar(ContasPagarMontado contasPagarMontado, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => ContasPagarPersistePage(
      contasPagarMontado: contasPagarMontado, title: 'Contas a Pagar - Editando', operacao: 'A')))
    .then((_) async {    
      await refrescarTela();
   });
}