/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [RESERVA] 
                                                                                
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
import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/model/model.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/filtro_page.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

import 'reserva_persiste_page.dart';

class ReservaListaPage extends StatefulWidget {
  const ReservaListaPage({Key? key}) : super(key: key);

  @override
  ReservaListaPageState createState() => ReservaListaPageState();
}

class ReservaListaPageState extends State<ReservaListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = ReservaDao.colunas;
  final _campos = ReservaDao.campos;

  DateTime _dataInicio = DateTime.now();
  DateTime _dataFim = DateTime.now();
  String? _situacaoReserva = 'Todas';

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
    final listaReservaMontado = Sessao.db.reservaDao.listaReservaMontado;

    final _ReservaDataSource reservaDataSource = _ReservaDataSource(listaReservaMontado, context, _refrescarTela);
  
    void _sort<T>(Comparable<T>? Function(ReservaMontado reservaMontado) getField, int columnIndex, bool ascending) {
      reservaDataSource._sort<T>(getField, ascending);
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
            title: const Text('Cadastro - Reserva'),
            actions: const <Widget>[],
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
                        'Situação',
                        'Situação',
                        true, paddingVertical: 1),
                      isEmpty: _situacaoReserva == null,
                      child: getDropDownButton(_situacaoReserva,
                        (String? newValue) {
                          _situacaoReserva = newValue;
                          _refrescarTela();
                      }, <String>[
                        'Todas',
                        'Ativa',
                        'Cancelada',
                        'Utilizada',
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
              child: listaReservaMontado == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Relação - Reserva'),
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
                          _sort<num>((ReservaMontado reservaMontado) => reservaMontado.reserva!.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Cliente'),
                        tooltip: 'Cliente',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ReservaMontado reservaMontado) => reservaMontado.cliente!.nome, columnIndex, ascending), 
                      ),
                      DataColumn(
                        label: const Text('Data Reserva'),
                        tooltip: 'Data Reserva',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((ReservaMontado reservaMontado) => reservaMontado.reserva!.dataReserva, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Hora Reserva'),
                        tooltip: 'Hora Reserva',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ReservaMontado reservaMontado) => reservaMontado.reserva!.horaReserva, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Quantidade de Pessoas'),
                        tooltip: 'Quantidade de Pessoas',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((ReservaMontado reservaMontado) => reservaMontado.reserva!.quantidadePessoas, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Contato'),
                        tooltip: 'Contato',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ReservaMontado reservaMontado) => reservaMontado.reserva!.nomeContato, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Telefone'),
                        tooltip: 'Telefone',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ReservaMontado reservaMontado) => reservaMontado.reserva!.telefoneContato, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Situação'),
                        tooltip: 'Situação',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((ReservaMontado reservaMontado) => reservaMontado.reserva!.situacao, columnIndex, ascending),
                      ),
                    ],
                    source: reservaDataSource,
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
          ReservaPersistePage(reservaMontado: ReservaMontado(reserva: Reserva(id: null,), cliente: Cliente(id: null)), title: 'Reserva - Inserindo', operacao: 'I')))
      .then((_) async {
        await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Reserva - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.reservaDao.consultarListaFiltro(_filtro!.campo!, _filtro!.valor!);
        setState(() {
        });
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxInformacao(context, 'Essa janela não possui relatório implementado');
  }

  Future _refrescarTela() async {
    await Sessao.db.reservaDao.consultarListaMontado(
      dataInicio: Biblioteca.removerTempoDaData(_dataInicio)!, 
      dataFim: Biblioteca.removerTempoDaData(_dataFim)!, 
      situacao: _situacaoReserva!
    );
    setState(() {
    });
  }
}

/// codigo referente a fonte de dados
class _ReservaDataSource extends DataTableSource {
  final List<ReservaMontado>? listaReservaMontado;
  final BuildContext context;
  final Function refrescarTela;

  _ReservaDataSource(this.listaReservaMontado, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T>? Function(ReservaMontado reservaMontado) getField, bool ascending) {
    listaReservaMontado!.sort((ReservaMontado a, ReservaMontado b) {
      if (!ascending) {
        final ReservaMontado c = a;
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
    if (index >= listaReservaMontado!.length) return null;
    final ReservaMontado reservaMontado = listaReservaMontado![index];
    return DataRow.byIndex(
      color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        switch (reservaMontado.reserva!.situacao) {
          case 'Ativa' :
            return Colors.yellow.withOpacity(0.3);
          case 'Cancelada' :
            return Colors.red.withOpacity(0.3);
          case 'Utilizada' :
            return Colors.blue.withOpacity(0.3);
          default:
            return null;
        }        
      }),
      index: index,
      cells: <DataCell>[
        DataCell(Text(reservaMontado.reserva!.id.toString()), onTap: () {
          _detalharReserva(reservaMontado, context, refrescarTela);
        }),
        DataCell(Text(reservaMontado.cliente?.nome?.toString() ?? ''), onTap: () {
          _detalharReserva(reservaMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(reservaMontado.reserva!.dataReserva)), onTap: () {
          _detalharReserva(reservaMontado, context, refrescarTela);
        }),
        DataCell(Text(reservaMontado.reserva!.horaReserva ?? ''), onTap: () {
          _detalharReserva(reservaMontado, context, refrescarTela);
        }),
        DataCell(Text(reservaMontado.reserva!.quantidadePessoas?.toString() ?? ''), onTap: () {
          _detalharReserva(reservaMontado, context, refrescarTela);
        }),
        DataCell(Text(reservaMontado.reserva!.nomeContato ?? ''), onTap: () {
          _detalharReserva(reservaMontado, context, refrescarTela);
        }),
        DataCell(Text(reservaMontado.reserva!.telefoneContato ?? ''), onTap: () {
          _detalharReserva(reservaMontado, context, refrescarTela);
        }),
        DataCell(Text(reservaMontado.reserva!.situacao ?? ''), onTap: () {
          _detalharReserva(reservaMontado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaReservaMontado!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharReserva(ReservaMontado reservaMontado, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => ReservaPersistePage(
      reservaMontado: reservaMontado, title: 'Reserva - Editando', operacao: 'A')))
    .then((_) async {    
      await refrescarTela();
   });
}