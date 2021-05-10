/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada aos movimentos do PDV 
                                                                                
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

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/page/relatorios/encerra_movimento_relatorio.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class MovimentoListaPage extends StatefulWidget {
  @override
  _MovimentoListaPageState createState() => _MovimentoListaPageState();
}

class _MovimentoListaPageState extends State<MovimentoListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;

  DateTime _mesAno = DateTime.now();

  var _listaMovimento;

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
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    _listaMovimento = Sessao.db.pdvMovimentoDao.listaMovimento;

    final _PdvMovimentoDataSource _pdvMovimentoDataSource = _PdvMovimentoDataSource(_listaMovimento, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(PdvMovimento pdvMovimento), int columnIndex, bool ascending) {
      _pdvMovimentoDataSource._sort<T>(getField, ascending);
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
            title: const Text('Relação de Movimentos'),
            actions: <Widget>[],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),          
            shape: CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(              
                children: <Widget> [ 
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
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              child: _listaMovimento == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Movimentos'),
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
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Abertura'),
                        tooltip: 'Conteúdo para o campo Data Abertura',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((PdvMovimento pdvMovimento) => pdvMovimento.dataAbertura, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Hora Abertura'),
                        tooltip: 'Conteúdo para o campo Hora Abertura',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((PdvMovimento pdvMovimento) => pdvMovimento.horaAbertura, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Fechamento'),
                        tooltip: 'Conteúdo para o campo Data Fechamento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((PdvMovimento pdvMovimento) => pdvMovimento.dataFechamento, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Hora Fechamento'),
                        tooltip: 'Conteúdo para o campo Hora Fechamento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((PdvMovimento pdvMovimento) => pdvMovimento.horaFechamento, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Suprimento'),
                        tooltip: 'Conteúdo para o campo Total Suprimento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalSuprimento, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Sangria'),
                        tooltip: 'Conteúdo para o campo Total Sangria',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalSangria, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Nao Fiscal'),
                        tooltip: 'Conteúdo para o campo Total Nao Fiscal',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalNaoFiscal, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Venda'),
                        tooltip: 'Conteúdo para o campo Total Venda',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalVenda, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Desconto'),
                        tooltip: 'Conteúdo para o campo Total Desconto',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalDesconto, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Acrescimo'),
                        tooltip: 'Conteúdo para o campo Total Acrescimo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalAcrescimo, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Final'),
                        tooltip: 'Conteúdo para o campo Total Final',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalFinal, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Recebido'),
                        tooltip: 'Conteúdo para o campo Total Recebido',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalRecebido, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Troco'),
                        tooltip: 'Conteúdo para o campo Total Troco',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalTroco, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Total Cancelado'),
                        tooltip: 'Conteúdo para o campo Total Cancelado',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((PdvMovimento pdvMovimento) => pdvMovimento.totalCancelado, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Status Movimento'),
                        tooltip: 'Conteúdo para o campo Status Movimento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((PdvMovimento pdvMovimento) => pdvMovimento.statusMovimento, columnIndex, ascending),
                      ),
                    ],
                    source: _pdvMovimentoDataSource,
                  ),
                ],
              ),
            ),
          ),          
        ),
      ),
    );
  }

  Future _refrescarTela() async {
    _listaMovimento = await Sessao.db.pdvMovimentoDao.consultarListaPeriodo(mes: _mesAno.month, ano: _mesAno.year);
    setState(() {
    });
  }

}

/// codigo referente a fonte de dados
class _PdvMovimentoDataSource extends DataTableSource {
  final List<PdvMovimento> listaProduto;
  final BuildContext context;
  final Function refrescarTela;
 
  _PdvMovimentoDataSource(this.listaProduto, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T> getField(PdvMovimento pdvMovimento), bool ascending) {
    listaProduto.sort((PdvMovimento a, PdvMovimento b) {
      if (!ascending) {
        final PdvMovimento c = a;
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
    if (index >= listaProduto.length) return null;
    final PdvMovimento pdvMovimento = listaProduto[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${pdvMovimento.id ?? ''}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${pdvMovimento.dataAbertura != null ? DateFormat('dd/MM/yyyy').format(pdvMovimento.dataAbertura) : ''}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${pdvMovimento.horaAbertura ?? ''}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${pdvMovimento.dataFechamento != null ? DateFormat('dd/MM/yyyy').format(pdvMovimento.dataFechamento) : ''}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${pdvMovimento.horaFechamento ?? ''}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalSuprimento ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalSangria ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalNaoFiscal ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalVenda ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalDesconto ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalAcrescimo ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalFinal ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalRecebido ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalTroco ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvMovimento.totalCancelado ?? 0)}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
        DataCell(Text('${pdvMovimento.statusMovimento ?? ''}'), onTap: () {
          _imprimirPdvMovimento(pdvMovimento, context);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaProduto.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _imprimirPdvMovimento(PdvMovimento pdvMovimento, BuildContext context) {
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => EncerraMovimentoRelatorio(movimento: pdvMovimento)))
    .then((_) {
    });
}