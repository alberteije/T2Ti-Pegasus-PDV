/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [PDV_VENDA_CABECALHO] 
                                                                                
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

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_caixa.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class VendasListaPage extends StatefulWidget {
  @override
  _VendasListaPageState createState() => _VendasListaPageState();
}

class _VendasListaPageState extends State<VendasListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;

  DateTime _mesAno = DateTime.now();
  String _statusVenda = 'Todas';
  double _totalVendido = 0;
  double _totalDesconto = 0;
  double _totalFinal = 0;
  double _totalCancelado = 0;
  var _listaPdvVendaCabecalho;

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
    _listaPdvVendaCabecalho = Sessao.db.pdvVendaCabecalhoDao.listaPdvVendaCabecalho;

    final _PdvVendaCabecalhoDataSource _pdvVendaCabecalhoDataSource = _PdvVendaCabecalhoDataSource(_listaPdvVendaCabecalho, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(PdvVendaCabecalho pdvVendaCabecalho), int columnIndex, bool ascending) {
      _pdvVendaCabecalhoDataSource._sort<T>(getField, ascending);
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
            title: const Text('Vendas'),
            actions: <Widget>[],
          ),
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),          
            shape: CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                        'Status Venda',
                        'Status Venda',
                        true, paddingVertical: 1),
                      isEmpty: _statusVenda == null,
                      child: getDropDownButton(_statusVenda,
                        (String newValue) {
                          _statusVenda = newValue;
                          _refrescarTela();
                      }, <String>[
                        'Todas',
                        'Fechadas',
                        'Abertas',
                        'Canceladas',
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
              iconPosition: BackdropIconPosition.leading,
              title: Text("Relação - Vendas"),
              backLayer: getResumoTotais(context),
              frontLayer: Scrollbar(
                child: _listaPdvVendaCabecalho == null
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
                          label: const Text('Cancelar'),
                          tooltip: 'Cancelar',
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Id'),
                          tooltip: 'Id',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.id, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Movimento'),
                          tooltip: 'Movimento',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.idPdvMovimento, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Data Venda'),
                          tooltip: 'Data Venda',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<DateTime>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.dataVenda, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Hora Venda'),
                          tooltip: 'Hora Venda',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.horaVenda, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Venda'),
                          tooltip: 'Valor Venda',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.valorVenda, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Taxa Desconto'),
                          tooltip: 'Taxa Desconto',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.taxaDesconto, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Desconto'),
                          tooltip: 'Valor Desconto',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.valorDesconto, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Final'),
                          tooltip: 'Valor Final',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.valorFinal, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Recebido'),
                          tooltip: 'Valor Recebido',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.valorRecebido, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Troco'),
                          tooltip: 'Valor Troco',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.valorTroco, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Valor Cancelado'),
                          tooltip: 'Valor Cancelado',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.valorCancelado, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Nome Cliente'),
                          tooltip: 'Nome Cliente',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.nomeCliente, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Cpf/Cnpj Cliente'),
                          tooltip: 'Cpf/Cnpj Cliente',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.cpfCnpjCliente, columnIndex, ascending),
                        ),
                        DataColumn(
                          numeric: true,
                          label: const Text('Código Vendedor'),
                          tooltip: 'Código Vendedor ',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.idColaborador, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Status Venda'),
                          tooltip: 'Status Venda',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.statusVenda, columnIndex, ascending),
                        ),
                        // DataColumn(
                        //   label: const Text('Cupom Cancelado'),
                        //   tooltip: 'Venda cancelada após ter sido efetivada',
                        //   onSort: (int columnIndex, bool ascending) =>
                        //     _sort<String>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.cupomCancelado, columnIndex, ascending),
                        // ),
                      ],
                      source: _pdvVendaCabecalhoDataSource,
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
              descricao: 'Total Vendido: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalVendido ?? 0)}',
              corFundo: Colors.blue.shade100,
            ),
            getItemResumoValor(
              descricao: 'Total Desconto: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalDesconto ?? 0)}',
              corFundo: Colors.red.shade100,
            ),
            getItemResumoValor(
              descricao: 'Total Final: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalFinal ?? 0)}',
              corFundo: Colors.green.shade100,
            ),
            getItemResumoValor(
              descricao: 'Total Cancelado: ',
              valor: 'R\$ ${Constantes.formatoDecimalValor.format(_totalCancelado ?? 0)}',
              corFundo: Colors.red.shade100,
            ),
            const SizedBox(height: 10.0),
          ],),
        ),
      ),
    );    
  }  

  Future _refrescarTela() async {
    _listaPdvVendaCabecalho = await Sessao.db.pdvVendaCabecalhoDao.consultarVendasPorPeriodoEStatus(
      mes: Biblioteca.formatarMes(_mesAno), 
      ano: _mesAno.year, 
      status: _statusVenda
    );
    _atualizarTotais();
    setState(() {
    });
  }

  _atualizarTotais() {
    _totalVendido = 0;
    _totalDesconto = 0;
    _totalFinal = 0;
    _totalCancelado = 0;
    for (PdvVendaCabecalho pdvVendaCabecalho in _listaPdvVendaCabecalho) {
        _totalVendido = _totalVendido + (pdvVendaCabecalho.valorVenda ?? 0);        
        _totalDesconto = _totalDesconto + (pdvVendaCabecalho.valorDesconto ?? 0);        
        _totalFinal = _totalFinal + (pdvVendaCabecalho.valorFinal ?? 0);        
        _totalCancelado = _totalCancelado + (pdvVendaCabecalho.valorCancelado ?? 0);        
    }     
  }
}


/// codigo referente a fonte de dados
class _PdvVendaCabecalhoDataSource extends DataTableSource {
  final List<PdvVendaCabecalho> listaPdvVendaCabecalho;
  final BuildContext context;
  final Function refrescarTela;
 
  _PdvVendaCabecalhoDataSource(this.listaPdvVendaCabecalho, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T> getField(PdvVendaCabecalho contasPagar), bool ascending) {
    listaPdvVendaCabecalho.sort((PdvVendaCabecalho a, PdvVendaCabecalho b) {
      if (!ascending) {
        final PdvVendaCabecalho c = a;
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
    if (index >= listaPdvVendaCabecalho.length) return null;
    final PdvVendaCabecalho pdvVendaCabecalho = listaPdvVendaCabecalho[index];
    return DataRow.byIndex(
      color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if ((pdvVendaCabecalho.cupomCancelado != null) && (pdvVendaCabecalho.cupomCancelado == 'S'))
          return Theme.of(context).colorScheme.error.withOpacity(0.2);
        return null;  
      }),
      index: index,
      cells: <DataCell>[
        DataCell(
          ((pdvVendaCabecalho.cupomCancelado != null) && (pdvVendaCabecalho.cupomCancelado == 'S'))  
          ?
            Text('Cancelada')
          :
            getBotaoGenericoPdv(
              descricao: 'Cancelar',
              cor: Colors.red.shade400, 
              onPressed: () {
                _cancelarVenda(pdvVendaCabecalho, context, refrescarTela: refrescarTela);
              }
            ),
        ),
        DataCell(Text('${pdvVendaCabecalho.id ?? ''}'), ),
        DataCell(Text('${pdvVendaCabecalho.idPdvMovimento ?? ''}'), ),
        DataCell(Text('${pdvVendaCabecalho.dataVenda != null ? DateFormat('dd/MM/yyyy').format(pdvVendaCabecalho.dataVenda) : ''}'), ),
        DataCell(Text('${pdvVendaCabecalho.horaVenda ?? ''}'), ),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvVendaCabecalho.valorVenda ?? 0)}'), ),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvVendaCabecalho.taxaDesconto ?? 0)}'), ),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvVendaCabecalho.valorDesconto ?? 0)}'), ),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvVendaCabecalho.valorFinal ?? 0)}'), ),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvVendaCabecalho.valorRecebido ?? 0)}'), ),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvVendaCabecalho.valorTroco ?? 0)}'),),
        DataCell(Text('${Constantes.formatoDecimalValor.format(pdvVendaCabecalho.valorCancelado ?? 0)}'), ),
        DataCell(Text('${pdvVendaCabecalho.nomeCliente ?? ''}'), ),
        DataCell(Text('${pdvVendaCabecalho.cpfCnpjCliente ?? ''}'), ),
        DataCell(Text('${pdvVendaCabecalho.idColaborador ?? ''}'), ),
        DataCell(Text('${pdvVendaCabecalho.statusVenda ?? ''}'),),
        // DataCell(Text('${pdvVendaCabecalho.cupomCancelado ?? ''}'), ),
      ],
    );
  }

  @override
  int get rowCount => listaPdvVendaCabecalho.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _cancelarVenda(PdvVendaCabecalho pdvVendaCabecalho, BuildContext context, {Function refrescarTela}) async {
    final recebimentos = await Sessao.db.contasReceberDao.consultarRecebimentosDeUmaVenda(pdvVendaCabecalho.id, 'R');
    if (recebimentos.length > 0) {
      showInSnackBar("Essa venda não pode ser cancelada, pois já existem parcelas com o status Recebido.", context);          
    } else {
      gerarDialogBoxConfirmacao(context, 'Deseja cancelar a venda selecionada?', () async {
          pdvVendaCabecalho = 
          pdvVendaCabecalho.copyWith(
            statusVenda: 'C',
            cupomCancelado: 'S',
            valorCancelado: pdvVendaCabecalho.valorFinal,
          );
          await Sessao.db.pdvVendaCabecalhoDao.cancelarVenda(pdvVendaCabecalho).then((value) async => await refrescarTela());
      });
    }
  }