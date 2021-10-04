/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre ListaPage relacionada à tabela [NFE_CABECALHO] 
                                                                                
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/service/service.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';

import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/page/pdf_page.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';

class NfeCabecalhoListaPage extends StatefulWidget {
  @override
  _NfeCabecalhoListaPageState createState() => _NfeCabecalhoListaPageState();
}

class _NfeCabecalhoListaPageState extends State<NfeCabecalhoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  NfeCabecalhoMontado nfceCabecalhoInicial = NfeCabecalhoMontado();
  var _listaNfeCabecalho;

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
    _listaNfeCabecalho = Sessao.db.nfeCabecalhoDao.listaNfeCabecalho;

    final _NfeCabecalhoDataSource _nfeCabecalhoDataSource = 
      _NfeCabecalhoDataSource(_listaNfeCabecalho, context, _refrescarTela, _transmitirNota);

    void _sort<T>(Comparable<T> getField(NfeCabecalho nfeCabecalho), int columnIndex, bool ascending) {
      _nfeCabecalhoDataSource._sort<T>(getField, ascending);
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
            title: const Text('NFC-e em Contingência'),
            actions: <Widget>[],
          ),
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),
            shape: CircularNotchedRectangle(),
            child: Row(
              children: [],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              child: _listaNfeCabecalho == null
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
                        numeric: true,
                        label: const Text('Cancelar'),
                        tooltip: 'Cancelar',
                      ),
                      DataColumn(
                        label: const Text('Número'),
                        tooltip: 'Número',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((NfeCabecalho nfeCabecalho) => nfeCabecalho.numero, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Data/Hora Emissão'),
                        tooltip: 'Data/Hora Emissão',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((NfeCabecalho nfeCabecalho) => nfeCabecalho.dataHoraEmissao, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Prazo Limite'),
                        tooltip: 'Prazo Limite para Transmissão',
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Total NF'),
                        tooltip: 'Valor Total NF',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((NfeCabecalho nfeCabecalho) => nfeCabecalho.valorTotal, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Número da Venda'),
                        tooltip: 'Número da Venda',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((NfeCabecalho nfeCabecalho) => nfeCabecalho.idPdvVendaCabecalho, columnIndex, ascending),
                      ),
                    ],
                    source: _nfeCabecalhoDataSource,
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
    _listaNfeCabecalho = await Sessao.db.nfeCabecalhoDao.consultarListaFiltro('STATUS_NOTA', '6'); //traz somente as notas em contingencia
    setState(() {
    });
  }

  // nesse método precisamos imprimir o danfe e também atualizar a nota inicial que está com status=9  
  // seu número precisa ser inutilizado ou ela precisa ser cancelada
  Future _imprimirDanfe(String danfeBase64) async {
    // Sessao.fecharDialogBoxEspera(context);
    var decodeB64 = base64.decode(danfeBase64); 
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => PdfPage(
          arquivoPdf: decodeB64, title: 'NFC-e')
        )
      ).then(
        (value) async {
          await _inutilizarNumero();
        }
      );          
  }  

  Future _inutilizarNumero() async {
    // pesquisa pela nota com status igual a 9 - essa nota foi gerada e tentamos emiti-la, mas houve erro e outra foi impressa em contingência
    nfceCabecalhoInicial.nfeCabecalho = 
      await Sessao.db.nfeCabecalhoDao.consultarNotaPorVenda(NfceController.nfeCabecalhoMontado.nfeCabecalho.idPdvVendaCabecalho, status: '9');

    // vamos inutilizar o número
    NfceAcbrService servicoNfce = NfceAcbrService();
    try {
      NfceController.instanciarNfceMontado();
      await servicoNfce.conectar(
        context, 
        formaEmissao: '1',
        operacao: 'INUTILIZAR_NUMERO', 
        chaveAcesso: nfceCabecalhoInicial.nfeCabecalho.chaveAcesso,
        funcaoDeCallBack: _atualizarNotaInicial, 
      ).then((socket) {
        NfceController.enviarComandoInutilizacaoNumero(
          socket: socket, 
          cnpj: Sessao.empresa.cnpj, 
          justificativa: 'NOTA EMITIDA EM CONTINGENCIA OFFLINE', 
          ano: nfceCabecalhoInicial.nfeCabecalho.dataHoraEmissao.year.toString(), 
          modelo: nfceCabecalhoInicial.nfeCabecalho.codigoModelo, 
          serie: nfceCabecalhoInicial.nfeCabecalho.serie, 
          numeroInicial: nfceCabecalhoInicial.nfeCabecalho.numero, 
          numeroFinal: nfceCabecalhoInicial.nfeCabecalho.numero
        );
      });                 
    } catch (e) {
      // se acontecer um erro aqui, não vamos fazer nada, a nota continuará com status=9 e seu número deverá ser inutilizado posteriormente
      // gerarDialogBoxErro(context, 'Ocorreu um problema ao tentar realizar o procedimento: ' + e.toString());
    }   
  }

  Future _atualizarNotaInicial() async {
    // atualiza nota
    nfceCabecalhoInicial.nfeCabecalho = 
    nfceCabecalhoInicial.nfeCabecalho.copyWith(
      statusNota: '8',
    );
    await Sessao.db.nfeCabecalhoDao.alterar(nfceCabecalhoInicial, atualizaFilhos: false).then((value) async => await _refrescarTela());
    
    // insere registro na tabela de inutilização
    NfeNumeroInutilizado inutilizado = 
      NfeNumeroInutilizado(
        id: null,
        serie: nfceCabecalhoInicial.nfeCabecalho.serie,
        numero: int.tryParse(nfceCabecalhoInicial.nfeCabecalho.numero),
        dataInutilizacao: DateTime.now(),
        observacao: 'NOTA EMITIDA EM CONTINGENCIA OFFLINE',
      );
    await Sessao.db.nfeNumeroInutilizadoDao.inserir(inutilizado);
  }

  Future _transmitirNota(NfeCabecalho nfeCabecalhoContingenciada) async {
    NfceAcbrService servicoNfce = NfceAcbrService();
    try {
      NfceController.instanciarNfceMontado();
      NfceController.nfeCabecalhoMontado.nfeCabecalho = nfeCabecalhoContingenciada;
      await servicoNfce.conectar(
        context, 
        formaEmissao: '1',
        funcaoDeCallBack: _imprimirDanfe, 
        operacao: 'TRANSMITIR_CONTINGENCIADA', 
        chaveAcesso: nfeCabecalhoContingenciada.chaveAcesso,
      ).then((socket) async {
        socket.write('NFe.EnviarNFe("C:\\ACBrMonitor\\' + Sessao.empresa.cnpj + '\\LOG_NFe\\' + nfeCabecalhoContingenciada.chaveAcesso + '-nfe.xml", "001", , , , "1", , )\r\n.\r\n');
      });                 
    } catch (e) {
      gerarDialogBoxErro(context, 'Ocorreu um problema ao tentar realizar o procedimento: ' + e.toString());
    }   
  }  
}

/// codigo referente a fonte de dados
class _NfeCabecalhoDataSource extends DataTableSource {
  final List<NfeCabecalho> listaNfeCabecalho;
  final BuildContext context;
  final Function refrescarTela;
  final Function transmitirNota;

  _NfeCabecalhoDataSource(this.listaNfeCabecalho, this.context, this.refrescarTela, this.transmitirNota);

  void _sort<T>(Comparable<T> getField(NfeCabecalho nfeCabecalho), bool ascending) {
    listaNfeCabecalho.sort((NfeCabecalho a, NfeCabecalho b) {
      if (!ascending) {
        final NfeCabecalho c = a;
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
    if (index >= listaNfeCabecalho.length) return null;
    final nfeCabecalho = listaNfeCabecalho[index];
    
    final prazoLimite = nfeCabecalho.dataHoraEmissao.add(Duration(hours: 24));

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
         DataCell(
            getBotaoGenericoPdv(
              descricao: 'Transmitir',
              tamanho: Size.fromWidth(100),
              cor: Colors.green.shade400, 
              padding: EdgeInsets.all(5),
              onPressed: () async {
                await transmitirNota(nfeCabecalho);
              }
            ),
        ),       
        DataCell(Text('${nfeCabecalho.numero ?? ''}'), ),
        DataCell(Text('${nfeCabecalho.dataHoraEmissao != null ? Biblioteca.formatarDataHora(nfeCabecalho.dataHoraEmissao) : ''}'), ),
        DataCell(Text('${prazoLimite != null ? Biblioteca.formatarDataHora(prazoLimite) : ''}'), ),
        DataCell(Text('${Constantes.formatoDecimalValor.format(nfeCabecalho.valorTotal ?? 0)}'), ),
        DataCell(Text('${nfeCabecalho.idPdvVendaCabecalho ?? ''}'), ),
      ],
    );
  }

  @override
  int get rowCount => listaNfeCabecalho.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}