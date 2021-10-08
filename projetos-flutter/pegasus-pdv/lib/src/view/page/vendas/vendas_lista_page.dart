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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/service/service.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  @override
  void dispose() {
    final tipoOperacao = Sessao.configuracaoPdv.moduloFiscalPrincipal == null ? 'REC' : Sessao.configuracaoPdv.moduloFiscalPrincipal;
    Sessao.vendaAtual = PdvVendaCabecalho(id: null, idPdvMovimento: Sessao.movimento.id, tipoOperacao: tipoOperacao);
    super.dispose();
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

    final _PdvVendaCabecalhoDataSource _pdvVendaCabecalhoDataSource = 
      _PdvVendaCabecalhoDataSource(_listaPdvVendaCabecalho, context, _refrescarTela, _cancelarVenda);

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
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Vendas'),
            actions: Sessao.configuracaoPdv.moduloFiscalPrincipal == 'NFC' ? _getBotoesPersonalizados() : <Widget>[],
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
              appBar: BackdropAppBar(
                title: Text("Relação - Vendas"),
                actions: <Widget>[
                  BackdropToggleButton(
                    icon: AnimatedIcons.list_view,
                  ),
                ],
              ),               
              stickyFrontLayer: true,
              backLayer: getResumoTotais(context),
              frontLayer: Scrollbar(
                child: _listaPdvVendaCabecalho == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                  padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                  children: <Widget>[
                    PaginatedDataTable(                        
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
                        DataColumn(
                          label: const Text('Tipo Operação'),
                          tooltip: 'Recibo / NFC-e / SAT / MFE',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((PdvVendaCabecalho pdvVendaCabecalho) => pdvVendaCabecalho.cupomCancelado, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Dados NFC-e'),
                          tooltip: 'Dados da NFC-e',                          
                        ),
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

  List<Widget> _getBotoesPersonalizados() {
    if (Biblioteca.isTelaPequena(context)) {
      return <Widget>[
        getBotaoTelaPequena(
          tooltip: 'Baixar XMLs Período',
          icone: Icon(Icons.download),
          onPressed: _baixarXmls,
        ),
      ];
    } else {
      return <Widget>[
        getBotaoTelaGrande(
          texto: 'Baixar XMLs Período',
          icone: Icon(Icons.download),
          onPressed: _baixarXmls,
        ),
      ];
    }
  }

  void _baixarXmls() async {
    NfceService servicoNfce = NfceService();
    gerarDialogBoxEspera(context);
    final periodo = Biblioteca.formatarDataAAAAMM(_mesAno);
    final retorno = await servicoNfce.baixarArquivosXml(periodo);
    final diretorio = await getApplicationDocumentsDirectory();

    if (retorno != null) {
      final caminhoArquivo = '${diretorio.path}\\notasFiscais_$periodo.zip';
      final arquivoZip = File(caminhoArquivo);
      arquivoZip.writeAsBytesSync(retorno);
      Sessao.fecharDialogBoxEspera(context); 

      if (Platform.isWindows) {
        gerarDialogBoxInformacao(context, 'Arquivo salvo em: ' + caminhoArquivo + '.');
      } else {
        Share.shareFiles([caminhoArquivo], subject: 'Arquivos XML do mês - Notas Fiscais', text: 'Seguem os arquivos das notas para o movimento $periodo');
      }
    } else {
      showInSnackBar('Ocorreu um erro ao tentar baixar os arquivos.', context);
    }

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

  Future _cancelarVenda() async {
    final recebimentos = await Sessao.db.contasReceberDao.consultarRecebimentosDeUmaVenda(Sessao.vendaAtual.id, 'R');
    if (recebimentos.length > 0) {
      showInSnackBar("Essa venda não pode ser cancelada, pois já existem parcelas com o status Recebido.", context);          
    } else {
      if (Sessao.vendaAtual.tipoOperacao == 'NFC') {
        gerarDialogBoxConfirmacao(context, 'Essa venda é vinculada a uma NFC-e. Deseja cancelar a Nota Fiscal e a Venda?', () async {
          await _cancelarNfce(context);
        });
      } else { // sistema gratuito só cancela a venda
        gerarDialogBoxConfirmacao(context, 'Deseja cancelar a venda selecionada?', () async {
          await _cancelarOperacaoVenda();
        });
      }

    }
  }

  Future _cancelarOperacaoVenda() async {
    Sessao.vendaAtual = 
    Sessao.vendaAtual.copyWith(
      statusVenda: 'C',
      cupomCancelado: 'S',
      valorCancelado: Sessao.vendaAtual.valorFinal,
    );
    await Sessao.db.pdvVendaCabecalhoDao.cancelarVenda(Sessao.vendaAtual).then((value) async => await _refrescarTela());
  }

  Future _cancelarNfce(BuildContext context) async {
    // consulta a nota vinculada à venda   
    final nfceCabecalho = await Sessao.db.nfeCabecalhoDao.consultarNotaPorVenda(Sessao.vendaAtual.id);
    if (nfceCabecalho == null) {
      gerarDialogBoxErro(context, 'Não existe uma NFC-e vinculada a esta venda ou a nota foi emitida em Contingência e ainda não foi autorizada.');
    } else {
      NfceController.instanciarNfceMontado();
      NfceController.nfeCabecalhoMontado.nfeCabecalho = nfceCabecalho;
      final motivoCancelamento = await showDialog(context: context, 
        builder: (BuildContext context){
          return InformaValorPage(title: 'Cancelar NFC-e', operacao: 'CANCELAR_NFCE', );
        });

      if (motivoCancelamento != false) { // só será false se o cara tiver teclado ESC no no botão CANCELAR
        if (motivoCancelamento == '') {
          gerarDialogBoxErro(context, 'É necessário informar um motivo para o cancelamento da nota.');
        } else {
          NfceAcbrService servicoNfce = NfceAcbrService();
          try {
            await servicoNfce.conectar(
              context, 
              formaEmissao: '1',
              funcaoDeCallBack: _cancelarOperacaoVenda, 
              operacao: 'CANCELAR', 
              chaveAcesso: nfceCabecalho.chaveAcesso,
              motivoCancelamento: motivoCancelamento,
            ).then((socket) async {
              socket.write('NFe.CANCELARNFE("' + nfceCabecalho.chaveAcesso + '", "' + motivoCancelamento + '", "' + Sessao.empresa.cnpj + '")\r\n.\r\n');
            });                 
          } catch (e) {
            gerarDialogBoxErro(context, 'Ocorreu um problema ao tentar realizar o procedimento: ' + e.toString());
          }   
        }
      }
    }
  }

}


/// codigo referente a fonte de dados
class _PdvVendaCabecalhoDataSource extends DataTableSource {
  final List<PdvVendaCabecalho> listaPdvVendaCabecalho;
  final BuildContext context;
  final Function refrescarTela;
  final Function cancelarVenda;
 
  _PdvVendaCabecalhoDataSource(this.listaPdvVendaCabecalho, this.context, this.refrescarTela, this.cancelarVenda);

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
          ? Text('Cancelada')
          : getBotaoGenericoPdv(
              descricao: 'Cancela',
              cor: Colors.red.shade400, 
              padding: EdgeInsets.all(5),
              onPressed: () async {
                // vinculamos a venda selecionada à venda da sessão, pois o método de cancelamente será chamado via callback pelo service da NFC-e
                Sessao.vendaAtual = pdvVendaCabecalho;
                await cancelarVenda();
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
        DataCell(Text('${pdvVendaCabecalho.tipoOperacao ?? ''}'), ),
        DataCell(
          ((pdvVendaCabecalho.cupomCancelado != null) && (pdvVendaCabecalho.cupomCancelado == 'S'))  
          ? Text('Cancelada')
          : ((pdvVendaCabecalho.statusVenda != 'F') || (pdvVendaCabecalho.tipoOperacao != 'NFC'))
            ? Text('')
            : getBotaoGenericoPdv(
                descricao: 'Visualizar',
                tamanho: Size.fromWidth(100),
                cor: Colors.green.shade400, 
                padding: EdgeInsets.all(5),
                onPressed: () async {
                  final nfeCabecalhoMontado = await Sessao.db.nfeCabecalhoDao.consultarObjetoMontado('ID_PDV_VENDA_CABECALHO', pdvVendaCabecalho.id.toString());
                  if (nfeCabecalhoMontado.nfeCabecalho == null) {
                    gerarDialogBoxInformacao(context, 'Nota fiscal não autorizada. Verifique se foi contigenciada e se está pendente de autorização.');
                  } else {
                    Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (BuildContext context) => NfeCabecalhoPage(
                          nfeCabecalhoMontado: nfeCabecalhoMontado, 
                          title: 'Detalhe da NFC-e', 
                        )))
                      .then((_) async {    
                        await refrescarTela();
                    });
                  }
                }
              ),
        ),
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