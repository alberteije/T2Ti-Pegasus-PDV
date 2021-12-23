/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [COMANDA] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/model/filtro.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/page/filtro_page.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class ComandaListaPage extends StatefulWidget {
  const ComandaListaPage({Key? key}) : super(key: key);

  @override
  _ComandaListaPageState createState() => _ComandaListaPageState();
}

class _ComandaListaPageState extends State<ComandaListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = ComandaDao.colunas;
  final _campos = ComandaDao.campos;

  DateTime _dataInicio = DateTime.now();
  DateTime _dataFim = DateTime.now();
  String? _tipoComanda = 'Todas';

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosListaPage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    WidgetsBinding.instance!.addPostFrameCallback((_) => _refrescarTela());
  }
  
  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.inserir:
        break;
      case AtalhoTelaType.imprimir:
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
    final _listaComandaMontado = Sessao.db.comandaDao.listaComandaMontado;

    final _ComandaDataSource _comandaDataSource = _ComandaDataSource(_listaComandaMontado, context, _refrescarTela);
  
    void _sort<T>(Comparable<T>? Function(ComandaMontado comandaMontado) getField, int columnIndex, bool ascending) {
      _comandaDataSource._sort<T>(getField, ascending);
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
            title: const Text('Comandas'),
            actions: const <Widget>[],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),          
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: 
                    InputDecorator(
                      decoration: getInputDecoration(
                        'Filtro: Data Início',
                        'Filtro: Data Início',
                        true),
                      child: DatePickerItem(
                        mascara: 'dd/MM/yyyy',
                        dateTime: _dataInicio,
                        firstDate: DateTime.parse('1900-01-01'),
                        lastDate: DateTime.parse('2050-01-01'),
                        onChanged: (DateTime? value) {
                          _dataInicio = value!;
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
                        'Filtro: Data Fim',
                        'Filtro: Data Fim',
                        true),
                      child: DatePickerItem(
                        mascara: 'dd/MM/yyyy',
                        dateTime: _dataFim,
                        firstDate: DateTime.parse('1900-01-01'),
                        lastDate: DateTime.parse('2050-01-01'),
                        onChanged: (DateTime? value) {
                          _dataFim = value!;
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
                        'Tipo',
                        'Tipo',
                        true, paddingVertical: 1),
                      isEmpty: _tipoComanda == null,
                      child: getDropDownButton(_tipoComanda,
                        (String? newValue) {
                          _tipoComanda = newValue;
                          _refrescarTela();
                      }, <String>[
                        'Todas',
                        'Indoor',
                        'Takeout',
                        'Delivery',
                      ]),
                    ),                  
                  ),
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              child: ListView(
                padding: const EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Relação - Comanda'),
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
                          _sort<num>((ComandaMontado comandaMontado) => comandaMontado.comanda!.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Colaborador'),
                        tooltip: 'Colaborador',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ComandaMontado comandaMontado) => comandaMontado.colaborador?.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Mesa'),
                        tooltip: 'Mesa',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ComandaMontado comandaMontado) => comandaMontado.mesa?.numero, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cliente'),
                        tooltip: 'Cliente',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ComandaMontado comandaMontado) => comandaMontado.cliente?.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text(''),
                        tooltip: '',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ComandaMontado comandaMontado) => comandaMontado.comanda!.idEmpresaDeliveryPedido, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Situação'),
                        tooltip: 'Situação',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ComandaMontado comandaMontado) => comandaMontado.comanda!.situacao, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data da Chegada'),
                        tooltip: 'Data da Chegada',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((ComandaMontado comandaMontado) => comandaMontado.comanda!.dataChegada, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Hora da Chegada'),
                        tooltip: 'Hora da Chegada',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ComandaMontado comandaMontado) => comandaMontado.comanda!.horaChegada, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data da Saída'),
                        tooltip: 'Data da Saída',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((ComandaMontado comandaMontado) => comandaMontado.comanda!.dataSaida, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Hora da Saída'),
                        tooltip: 'Hora da Saída',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ComandaMontado comandaMontado) => comandaMontado.comanda!.horaSaida, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor SubTotal'),
                        tooltip: 'Valor Total',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ComandaMontado comandaMontado) => comandaMontado.comanda!.valorSubtotal, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Desconto'),
                        tooltip: 'Valor Desconto',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ComandaMontado comandaMontado) => comandaMontado.comanda!.valorDesconto, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Total'),
                        tooltip: 'Valor Total',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ComandaMontado comandaMontado) => comandaMontado.comanda!.valorTotal, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Tipo'),
                        tooltip: 'Tipo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ComandaMontado comandaMontado) => comandaMontado.comanda!.tipo, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Quantidade de Pessoas'),
                        tooltip: 'Quantidade de Pessoas',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ComandaMontado comandaMontado) => comandaMontado.comanda!.quantidadePessoas, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor por Pessoa'),
                        tooltip: 'Valor por Pessoa',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ComandaMontado comandaMontado) => comandaMontado.comanda!.valorPorPessoa, columnIndex, ascending),
                      ),
                    ],
                    source: _comandaDataSource,
                  ),
                ],
              ),
            ),
          ),          
        ),
      ),
    );
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Comanda - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.comandaDao.consultarListaFiltro(_filtro!.campo!, _filtro!.valor!);
        setState(() {
        });
      }
    }    
  }

  Future _refrescarTela() async {
    await Sessao.db.comandaDao.consultarListaMontadoPeriodo(
      dataInicio: Biblioteca.removerTempoDaData(_dataInicio)!, 
      dataFim: Biblioteca.removerTempoDaData(_dataFim)!, 
      tipo: _tipoComanda!
    );
    setState(() {
    });
  }

}

/// codigo referente a fonte de dados
class _ComandaDataSource extends DataTableSource {
  final List<ComandaMontado>? listaComandaMontado;
  final BuildContext context;
  final Function refrescarTela;

  _ComandaDataSource(this.listaComandaMontado, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T>? Function(ComandaMontado comandaMontado) getField, bool ascending) {
    listaComandaMontado!.sort((ComandaMontado a, ComandaMontado b) {
      if (!ascending) {
        final ComandaMontado c = a;
        a = b;
        b = c;
      }
      Comparable<T>? aValue = getField(a);
      Comparable<T>? bValue = getField(b);

      aValue ??= '' as Comparable<T>;
      bValue ??= '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
  }

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= listaComandaMontado!.length) return null;
    final ComandaMontado comandaMontado = listaComandaMontado![index];
    final Comanda comanda = comandaMontado.comanda!;
    return DataRow.byIndex(
      color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        switch (comandaMontado.comanda!.tipo) {
          case 'I' :
            return Colors.yellow.withOpacity(0.2);
          case 'T' :
            return Colors.red.withOpacity(0.2);
          case 'D' :
            return Colors.blue.withOpacity(0.2);
          default:
            return null;
        }        
      }),
      index: index,
      cells: <DataCell>[
        DataCell(Text(comanda.id?.toString() ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(comandaMontado.colaborador?.nome ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(comandaMontado.mesa?.numero?.toString() ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(comandaMontado.cliente?.nome ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(comanda.idEmpresaDeliveryPedido?.toString() ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(comanda.situacao ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(comanda.dataChegada)), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(comanda.horaChegada ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(comanda.dataSaida)), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(comanda.horaSaida ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(Constantes.formatoDecimalValor.format(comanda.valorSubtotal ?? 0)), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(Constantes.formatoDecimalValor.format(comanda.valorDesconto ?? 0)), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(Constantes.formatoDecimalValor.format(comanda.valorTotal ?? 0)), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(comanda.tipo ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(comanda.quantidadePessoas?.toString() ?? ''), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
        DataCell(Text(Constantes.formatoDecimalValor.format(comanda.valorPorPessoa ?? 0)), onTap: () {
          _detalharComanda(comandaMontado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaComandaMontado!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharComanda(ComandaMontado comandaMontado, BuildContext context, Function refrescarTela) {
  Navigator.push(
    context, MaterialPageRoute(builder: (_) => ComandaPage(
      title: 'Comandas', 
      mesa: comandaMontado.mesa == null ? Mesa(id: null) : comandaMontado.mesa!, 
      tipo: comandaMontado.comanda!.tipo!,
      comandaMontado: comandaMontado,
    )),
  ).then((value) async { await refrescarTela(); });
}