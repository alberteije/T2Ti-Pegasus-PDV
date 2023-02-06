/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [CLIENTE_FIADO] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_caixa.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class ClienteFiadoListaPage extends StatefulWidget {
  final Cliente cliente;
  const ClienteFiadoListaPage({required this.cliente, Key? key}) : super(key: key);

  @override
  ClienteFiadoListaPageState createState() => ClienteFiadoListaPageState();
}

class ClienteFiadoListaPageState extends State<ClienteFiadoListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  DateTime _mesAno = DateTime.now();
  String? _statusPagamento = 'Todos';
  double _totalPagar = 0;
  double _totalPago = 0;
  double _totalGeral = 0;
  List<ClienteFiadoMontado>? _listaClienteFiadoMontado;

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;

  final ScrollController controllerScroll = ScrollController();

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
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    _listaClienteFiadoMontado = Sessao.db.clienteFiadoDao.listaClienteFiadoMontado;

    final _ClienteFiadoDataSource clienteFiadoDataSource = _ClienteFiadoDataSource(_listaClienteFiadoMontado, context, _refrescarTela);

    void _sort<T>(Comparable<T>? Function(ClienteFiadoMontado clienteFiadoMontado) getField, int columnIndex, bool ascending) {
      clienteFiadoDataSource._sort<T>(getField, ascending);
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
            title: Text('Fiados do Cliente ${widget.cliente.nome!}'),
            actions: const <Widget>[],
          ),
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),          
            shape: const CircularNotchedRectangle(),
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
                      child: DatePickerItem(
                        mascara: 'MM/yyyy',
                        dateTime: _mesAno,
                        firstDate: DateTime.parse('1900-01-01'),
                        lastDate: DateTime.parse('2050-01-01'),
                        onChanged: (DateTime? value) {
                          _mesAno = value!;
                          _refrescarTela();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
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
                        (String? newValue) {
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
                // title: const Text("Relação - Contas Pagar"),
                actions: const <Widget>[
                  BackdropToggleButton(
                    icon: AnimatedIcons.list_view,
                  ),
                ],
              ),               
              stickyFrontLayer: true,
              backLayer: getResumoTotais(context),
              frontLayer: Scrollbar(
                child: _listaClienteFiadoMontado == null
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                  controller: controllerScroll,
                  padding: const EdgeInsets.all(Constantes.paddingListViewListaPage),
                  children: <Widget>[
                    PaginatedDataTable(                        
                      // header: const Text('Relação - Contas Pagar'),
                      rowsPerPage: _rowsPerPage!,
                      onRowsPerPageChanged: (int? value) {
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
                            _sort<num>((ClienteFiadoMontado clienteFiadoMontado) => clienteFiadoMontado.clienteFiado!.id, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Id Venda'),
                          tooltip: 'Conteúdo para o campo Id Venda',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ClienteFiadoMontado clienteFiadoMontado) => clienteFiadoMontado.clienteFiado!.idPdvVendaCabecalho, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Data da Venda'),
                          tooltip: 'Data de Lançamento',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<DateTime>((ClienteFiadoMontado clienteFiadoMontado) => clienteFiadoMontado.pdvVendaCabecalho!.dataVenda, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Venda'),
                          tooltip: 'Valor Venda',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ClienteFiadoMontado clienteFiadoMontado) => clienteFiadoMontado.pdvVendaCabecalho!.valorFinal, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor do Fiado'),
                          tooltip: 'Valor do Fiado',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ClienteFiadoMontado clienteFiadoMontado) => clienteFiadoMontado.clienteFiado!.valorPendente, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Data de Pagamento'),
                          tooltip: 'Data de Pagamento',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<DateTime>((ClienteFiadoMontado clienteFiadoMontado) => clienteFiadoMontado.clienteFiado!.dataPagamento, columnIndex, ascending),
                        ),                        
                      ],
                      source: clienteFiadoDataSource,
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
        color: Colors.grey.shade500,
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10.0),
            getItemResumoValor(
              descricao: 'Total a Pagar: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalPagar)}',
              corFundo: Colors.blue.shade100,
            ),
            getItemResumoValor(
              descricao: 'Total Pago: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalPago)}',
              corFundo: Colors.red.shade100,
            ),
            getItemResumoValor(
              descricao: 'Total Geral: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalGeral)}',
              corFundo: Colors.green.shade100,
            ),
            const SizedBox(height: 10.0),
          ],),
        ),
      ),
    );    
  }  

  Future _refrescarTela() async {
    _listaClienteFiadoMontado = await Sessao.db.clienteFiadoDao.consultarListaMontado(mes: _mesAno.month, ano: _mesAno.year, status: _statusPagamento!, idCliente: widget.cliente.id!);
    _atualizarTotais();
    setState(() {
    });
  }

  _atualizarTotais() {
    _totalPagar = 0;
    _totalPago = 0;
    _totalGeral = 0;
    for (ClienteFiadoMontado clienteFiadoMontado in _listaClienteFiadoMontado!) {
      if (clienteFiadoMontado.clienteFiado!.dataPagamento == null) {
        _totalPagar = _totalPagar + (clienteFiadoMontado.clienteFiado!.valorPendente ?? 0);        
      } else {
        _totalPago = _totalPago + (clienteFiadoMontado.clienteFiado!.valorPendente ?? 0);        
      }
      _totalGeral = _totalGeral + (clienteFiadoMontado.clienteFiado!.valorPendente ?? 0);
    }     
  }
}


/// codigo referente a fonte de dados
class _ClienteFiadoDataSource extends DataTableSource {
  final List<ClienteFiadoMontado>? listaClienteFiado;
  final BuildContext context;
  final Function refrescarTela;
 
  _ClienteFiadoDataSource(this.listaClienteFiado, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T>? Function(ClienteFiadoMontado clienteFiado) getField, bool ascending) {
    listaClienteFiado!.sort((ClienteFiadoMontado a, ClienteFiadoMontado b) {
      if (!ascending) {
        final ClienteFiadoMontado c = a;
        a = b;
        b = c;
      }
      Comparable<T>? aValue = getField(a);
      Comparable<T>? bValue = getField(b);

      aValue ??= '' as Comparable<T>;
      bValue ??= '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= listaClienteFiado!.length) return null;
    final ClienteFiadoMontado clienteFiadoMontado = listaClienteFiado![index];
    final ClienteFiado clienteFiado = clienteFiadoMontado.clienteFiado!;
    return DataRow.byIndex(
      color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (clienteFiado.dataPagamento == null) {
          return Colors.red.withOpacity(0.2);
        } else {
          return Colors.blue.withOpacity(0.2);
        }
      }),
      index: index,
      cells: <DataCell>[
        DataCell(Text('${clienteFiado.id}'), onTap: () async {
          await _atualizarDadosFiado(clienteFiadoMontado, context, refrescarTela);
        }),
        DataCell(Text('${clienteFiadoMontado.clienteFiado!.idPdvVendaCabecalho ?? ''}'), onTap: () async {
          await _atualizarDadosFiado(clienteFiadoMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(clienteFiadoMontado.pdvVendaCabecalho!.dataVenda)), onTap: () async {
          await _atualizarDadosFiado(clienteFiadoMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarValorDecimal(clienteFiadoMontado.pdvVendaCabecalho!.valorFinal)), onTap: () async {
          await _atualizarDadosFiado(clienteFiadoMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarValorDecimal(clienteFiadoMontado.clienteFiado!.valorPendente)), onTap: () async {
          await _atualizarDadosFiado(clienteFiadoMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(clienteFiadoMontado.clienteFiado!.dataPagamento)), onTap: () async {
          await _atualizarDadosFiado(clienteFiadoMontado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaClienteFiado!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

Future<void> _atualizarDadosFiado(ClienteFiadoMontado clienteFiadoMontado, BuildContext context, Function refrescarTela) async {
  if (clienteFiadoMontado.clienteFiado!.dataPagamento == null) {
    clienteFiadoMontado.clienteFiado = clienteFiadoMontado.clienteFiado!.copyWith(
      dataPagamento: DateTime.now(), 
    );
    await Sessao.db.clienteFiadoDao.alterar(clienteFiadoMontado.clienteFiado!);
  } else {
    ClienteFiado clienteFiado = ClienteFiado(
      id: clienteFiadoMontado.clienteFiado!.id,
      idCliente: clienteFiadoMontado.clienteFiado!.idCliente,
      idPdvVendaCabecalho: clienteFiadoMontado.clienteFiado!.idPdvVendaCabecalho,
      valorPendente: clienteFiadoMontado.clienteFiado!.valorPendente,
      dataLancamento: clienteFiadoMontado.clienteFiado!.dataLancamento,
    );
    await Sessao.db.clienteFiadoDao.alterar(clienteFiado);
  }
  await refrescarTela();
}