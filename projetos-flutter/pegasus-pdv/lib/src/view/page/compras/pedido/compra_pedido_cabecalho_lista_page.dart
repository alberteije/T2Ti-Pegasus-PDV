/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre ListaPage relacionada à tabela [COMPRA_PEDIDO_CABECALHO] 
                                                                                
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
import 'package:pegasus_pdv/src/controller/controller.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

import 'compra_pedido_cabecalho_page.dart';

class CompraPedidoCabecalhoListaPage extends StatefulWidget {
  static CompraPedidoCabecalho compraPedidoCabecalho; //usado quando esta tela for chamada pelo Estoque para fazer um pedido
  static List<CompraDetalhe> listaCompraDetalhe; //usado quando esta tela for chamada pelo Estoque para fazer um pedido

  @override
  _CompraPedidoCabecalhoListaPageState createState() => _CompraPedidoCabecalhoListaPageState();
}

class _CompraPedidoCabecalhoListaPageState extends State<CompraPedidoCabecalhoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  DateTime _mesAno = DateTime.now();

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
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final _listaCompraPedidoCabecalhoMontado = Sessao.db.compraPedidoCabecalhoDao.listaCompraPedidoCabecalhoMontado;

    final _CompraPedidoCabecalhoDataSource _compraPedidoCabecalhoDataSource = _CompraPedidoCabecalhoDataSource(_listaCompraPedidoCabecalhoMontado, context, _refrescarTela);

    void _sort<T>(Comparable<T> getField(CompraPedidoCabecalhoMontado compraPedidoCabecalhoMontado), int columnIndex, bool ascending) {
      _compraPedidoCabecalhoDataSource._sort<T>(getField, ascending);
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
            title: const Text('Pedido de Compra'),
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
                children: 
                <Widget>[
                  Expanded(
                    flex: 1,
                    child: InputDecorator(
                      decoration: getInputDecoration(
                        'Mês/Ano para o Filtro',
                        'Selecione um dia dentro do mês desejado',
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
              child: _listaCompraPedidoCabecalhoMontado == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(
                    header: const Text('Relação - Pedido de Compra'),
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
                          _sort<num>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Colaborador'),
                        tooltip: 'Conteúdo para o campo Colaborador',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.colaborador?.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Fornecedor'),
                        tooltip: 'Conteúdo para o campo Fornecedor',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.fornecedor?.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data do Pedido'),
                        tooltip: 'Data do Pedido',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.dataPedido, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Prevista para Entrega'),
                        tooltip: 'Data Prevista para Entrega',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.dataPrevisaoEntrega, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Previsão Pagamento'),
                        tooltip: 'Data Previsão Pagamento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.dataPrevisaoPagamento, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Local de Entrega'),
                        tooltip: 'Local de Entrega',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.localEntrega, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Local de Cobrança'),
                        tooltip: 'Local de Cobrança',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.localCobranca, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Nome do Contato'),
                        tooltip: 'Nome do Contato',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.contato, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Subtotal'),
                        tooltip: 'Valor Subtotal',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.valorSubtotal, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Taxa Desconto'),
                        tooltip: 'Taxa Desconto',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.taxaDesconto, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Desconto'),
                        tooltip: 'Valor Desconto',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.valorDesconto, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Total'),
                        tooltip: 'Valor Total',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.valorTotal, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Forma de Pagamento'),
                        tooltip: 'Forma de Pagamento de Pessoa',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.formaPagamento, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Gera Financeiro'),
                        tooltip: 'Conteúdo para o campo Gera Financeiro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.geraFinanceiro, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Quantidade de Parcelas'),
                        tooltip: 'Quantidade de Parcelas',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.quantidadeParcelas, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Dia Primeiro Vencimento'),
                        tooltip: 'Dia Primeiro Vencimento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.diaPrimeiroVencimento, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Intervalo entre Parcelas'),
                        tooltip: 'Intervalo entre Parcelas',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.intervaloEntreParcelas, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Dia Fixo da Parcela'),
                        tooltip: 'Dia Fixo da Parcela',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.diaFixoParcela, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data Recebimento Itens'),
                        tooltip: 'Conteúdo para o campo Data Recebimento Itens',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.dataRecebimentoItens, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Hora Recebimento Itens'),
                        tooltip: 'Conteúdo para o campo Hora Recebimento Itens',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.horaRecebimentoItens, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Atualizou Estoque'),
                        tooltip: 'Conteúdo para o campo Atualizou Estoque',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.atualizouEstoque, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Numero Documento Entrada'),
                        tooltip: 'Conteúdo para o campo Numero Documento Entrada',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((CompraPedidoCabecalhoMontado compraPedidoCabecalho) => compraPedidoCabecalho.compraPedidoCabecalho.numeroDocumentoEntrada, columnIndex, ascending),
                      ),
                    ],
                    source: _compraPedidoCabecalhoDataSource,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _inserir() async {
    final _colaborador = await Sessao.db.colaboradorDao.consultarObjeto(1);
    CompraPedidoCabecalhoController.listaCompraDetalhe = CompraPedidoCabecalhoListaPage.listaCompraDetalhe == null ? [] : CompraPedidoCabecalhoListaPage.listaCompraDetalhe;
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => 
          CompraPedidoCabecalhoPage(
            compraPedidoCabecalhoMontado: CompraPedidoCabecalhoMontado(
              compraPedidoCabecalho: CompraPedidoCabecalhoListaPage.compraPedidoCabecalho,
              colaborador: _colaborador,
            ), 
            title: 'Pedido de Compra - Inserindo', 
            operacao: 'I'
          )))
      .then((_) async {
        CompraPedidoCabecalhoListaPage.compraPedidoCabecalho = null;
        CompraPedidoCabecalhoListaPage.listaCompraDetalhe = [];
        await _refrescarTela();
    });
  }

  Future _refrescarTela() async {
    if (CompraPedidoCabecalhoListaPage.compraPedidoCabecalho != null) { // vai entrar aqui caso a tela do estoque tenha enviado itens
      _inserir();      
    }
    await Sessao.db.compraPedidoCabecalhoDao.consultarListaMontado(mes: _mesAno.month, ano: _mesAno.year);
    setState(() {
    });
  }
}

/// codigo referente a fonte de dados
class _CompraPedidoCabecalhoDataSource extends DataTableSource {
  final List<CompraPedidoCabecalhoMontado> listaCompraPedidoCabecalho;
  final BuildContext context;
  final Function refrescarTela;
 
  _CompraPedidoCabecalhoDataSource(this.listaCompraPedidoCabecalho, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T> getField(CompraPedidoCabecalhoMontado compraPedidoCabecalho), bool ascending) {
    listaCompraPedidoCabecalho.sort((CompraPedidoCabecalhoMontado a, CompraPedidoCabecalhoMontado b) {
      if (!ascending) {
        final CompraPedidoCabecalhoMontado c = a;
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
    if (index >= listaCompraPedidoCabecalho.length) return null;
    final CompraPedidoCabecalhoMontado compraPedidoCabecalhoMontado = listaCompraPedidoCabecalho[index];
    final CompraPedidoCabecalho compraPedidoCabecalho = compraPedidoCabecalhoMontado.compraPedidoCabecalho;
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${compraPedidoCabecalho.id ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalhoMontado.colaborador?.nome ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalhoMontado.fornecedor?.nome ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.dataPedido != null ? DateFormat('dd/MM/yyyy').format(compraPedidoCabecalho.dataPedido) : ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.dataPrevisaoEntrega != null ? DateFormat('dd/MM/yyyy').format(compraPedidoCabecalho.dataPrevisaoEntrega) : ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.dataPrevisaoPagamento != null ? DateFormat('dd/MM/yyyy').format(compraPedidoCabecalho.dataPrevisaoPagamento) : ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.localEntrega ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.localCobranca ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.contato ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.valorSubtotal != null ? Constantes.formatoDecimalValor.format(compraPedidoCabecalho.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(compraPedidoCabecalho.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.valorDesconto != null ? Constantes.formatoDecimalValor.format(compraPedidoCabecalho.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.valorTotal != null ? Constantes.formatoDecimalValor.format(compraPedidoCabecalho.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.formaPagamento ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.geraFinanceiro ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.quantidadeParcelas ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.diaPrimeiroVencimento ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.intervaloEntreParcelas ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.diaFixoParcela ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.dataRecebimentoItens != null ? DateFormat('dd/MM/yyyy').format(compraPedidoCabecalho.dataRecebimentoItens) : ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.horaRecebimentoItens ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.atualizouEstoque ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
        DataCell(Text('${compraPedidoCabecalho.numeroDocumentoEntrada ?? ''}'), onTap: () {
          _detalharCompraPedidoCabecalho(compraPedidoCabecalhoMontado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaCompraPedidoCabecalho.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharCompraPedidoCabecalho(CompraPedidoCabecalhoMontado compraPedidoCabecalhoMontado, BuildContext context, Function refrescarTela) async {
  //carrega lista de detalhes
  CompraPedidoCabecalhoController.listaCompraDetalhe = 
    await Sessao.db.compraPedidoDetalheDao.consultarListaComProduto(compraPedidoCabecalhoMontado.compraPedidoCabecalho.id);
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => CompraPedidoCabecalhoPage(
        compraPedidoCabecalhoMontado: compraPedidoCabecalhoMontado, 
        title: 'Pedido de Compra - Editando', 
        operacao: 'A'
      )))
    .then((_) async {    
      await refrescarTela();
   });
}