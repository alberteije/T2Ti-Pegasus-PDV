/*
Title: T2Ti ERP 3.0                                                                
Description: ListaPage relacionada à tabela [DELIVERY] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2022 T2Ti.COM                                          
                                                                                
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
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';

import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

class DeliveryListaPage extends StatefulWidget {
  const DeliveryListaPage({Key? key}) : super(key: key);

  @override
  DeliveryListaPageState createState() => DeliveryListaPageState();
}

class DeliveryListaPageState extends State<DeliveryListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;

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
    final listaDeliveryMontado = Sessao.db.deliveryDao.listaDeliveryMontado;

    final _DeliveryDataSource deliveryDataSource = _DeliveryDataSource(listaDeliveryMontado, context, _refrescarTela);
  
    void _sort<T>(Comparable<T>? Function(DeliveryMontado deliveryMontado) getField, int columnIndex, bool ascending) {
      deliveryDataSource._sort<T>(getField, ascending);
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
            title: const Text('Delivery'),
            actions: const <Widget>[],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),          
            shape: const CircularNotchedRectangle(),
            child: const SizedBox(height: 1,)
            // Row(
            //   children: getBotoesNavigationBarListaPage(
            //     context: context, 
            //     chamarFiltro: _chamarFiltro, 
            //     gerarRelatorio: _gerarRelatorio,
            //   ),
            // ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              child: ListView(
                padding: const EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  PaginatedDataTable(                        
                    header: const Text('Relação - Delivery'),
                    rowsPerPage: _rowsPerPage!,
                    onRowsPerPageChanged: (int? value) {
                      setState(() {
                        _rowsPerPage = value;
                      });
                    },
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Text('Acerto'),
                        tooltip: 'Acerto',
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Id'),
                        tooltip: 'Id',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.id, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Comanda'),
                        tooltip: '',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.idComanda, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Taxa de Entrega'),
                        tooltip: 'Taxa de Entrega',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.taxaEntrega?.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Colaborador'),
                        tooltip: 'Colaborador',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.colaborador?.nome, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Nome Cliente'),
                        tooltip: 'Nome Cliente',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.nomeCliente, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Telefone Principal'),
                        tooltip: 'Telefone Principal',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.telefonePrincipal, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Telefone Recado'),
                        tooltip: 'Telefone Recado',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.telefoneRecado, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Celular'),
                        tooltip: 'Celular',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.celular, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Logradouro'),
                        tooltip: 'Logradouro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.logradouro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Número'),
                        tooltip: 'Número',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.numero, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Complemento'),
                        tooltip: 'Complemento',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.complemento, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('CEP'),
                        tooltip: 'CEP',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.cep, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Bairro'),
                        tooltip: 'Bairro',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.bairro, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Município'),
                        tooltip: 'Município',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.cidade, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Código UF'),
                        tooltip: 'Código UF',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.uf, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Frete'),
                        tooltip: 'Valor Frete',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.valorFrete, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Recebido'),
                        tooltip: 'Valor Recebido',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.valorRecebido, columnIndex, ascending),
                      ),
                      DataColumn(
                        numeric: true,
                        label: const Text('Valor Solicitado Troco'),
                        tooltip: 'Valor Solicitado Troco',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<num>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.valorSolicitadoTroco, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Previsão Preparo'),
                        tooltip: 'Previsão Preparo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.previsaoPreparo, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Início Preparo'),
                        tooltip: 'Início Preparo',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.inicioPreparo, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Previsão Entrega'),
                        tooltip: 'Previsão Entrega',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.previsaoEntrega, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Saiu para Entrega'),
                        tooltip: 'Saiu para Entrega',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.saiuParaEntrega, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Entregue'),
                        tooltip: 'Entregue',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.entregue, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Previsao Retirada'),
                        tooltip: 'Previsao Retirada',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.previsaoRetirada, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Pronto para Retirada'),
                        tooltip: 'Pronto para Retirada',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.prontoParaRetirada, columnIndex, ascending),
                      ),
                      DataColumn(
                        label: const Text('Retirou'),
                        tooltip: 'Retirou',
                        onSort: (int columnIndex, bool ascending) =>
                          _sort<DateTime>((DeliveryMontado deliveryMontado) => deliveryMontado.delivery!.retirou, columnIndex, ascending),
                      ),
                    ],
                    source: deliveryDataSource,
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
    // Navigator.of(context)
    //   .push(MaterialPageRoute(
    //     builder: (BuildContext context) => 
    //       DeliveryPersistePage(delivery: Delivery(id: null,), title: 'Delivery - Inserindo', operacao: 'I')))
    //   .then((_) async {
    //     await _refrescarTela();
    // });
  }

  void _chamarFiltro() {
    gerarDialogBoxInformacao(context, 'Essa janela não possui filtro implementado');
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxInformacao(context, 'Essa janela não possui relatório implementado');
  }

  Future _refrescarTela() async {
    await Sessao.db.deliveryDao.consultarListaMontado();
    setState(() {
    });
  }
}

/// codigo referente a fonte de dados
class _DeliveryDataSource extends DataTableSource {
  final List<DeliveryMontado>? listaDeliveryMontado;
  final BuildContext context;
  final Function refrescarTela;

  _DeliveryDataSource(this.listaDeliveryMontado, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T>? Function(DeliveryMontado deliveryMontado) getField, bool ascending) {
    listaDeliveryMontado!.sort((DeliveryMontado a, DeliveryMontado b) {
      if (!ascending) {
        final DeliveryMontado c = a;
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
    if (index >= listaDeliveryMontado!.length) return null;
    final DeliveryMontado deliveryMontado = listaDeliveryMontado![index];
    final Delivery delivery = deliveryMontado.delivery!;
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
        getBotaoGenericoPdv(
          descricao: 'Acerto',
          cor: Colors.green.shade400, 
          padding: const EdgeInsets.all(5),
          onPressed: () async {
            final deliveryAcertoComanda = await Sessao.db.deliveryAcertoComandaDao.consultarObjetoFiltro('ID_DELIVERY', delivery.id.toString());
            DeliveryAcerto? deliveryacerto; 
            if (deliveryAcertoComanda != null) {
              deliveryacerto = await Sessao.db.deliveryAcertoDao.consultarObjetoFiltro('ID', deliveryAcertoComanda.idDeliveryAcerto.toString());
            }            
            // ignore: use_build_context_synchronously
            Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (BuildContext context) => DeliveryAcertoPersistePage(
                  deliveryAcertoMontado: DeliveryAcertoMontado(
                    delivery: delivery, 
                    deliveryAcerto: deliveryacerto ?? DeliveryAcerto(id: null),
                    deliveryAcertoComanda: deliveryAcertoComanda ?? DeliveryAcertoComanda(id: null),
                  ), 
                  title: 'Acerto do Delivery', 
                )))
              .then((_) {    
            });            
          }
        ),
       ),
       DataCell(Text(delivery.id.toString()), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(delivery.idComanda?.toString() ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(deliveryMontado.taxaEntrega?.nome?.toString() ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(deliveryMontado.colaborador?.nome?.toString() ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(delivery.nomeCliente ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(MaskedTextController(text: delivery.telefonePrincipal, mask: Constantes.mascaraTELEFONE).text), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(MaskedTextController(text: delivery.telefoneRecado, mask: Constantes.mascaraTELEFONE).text), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(MaskedTextController(text: delivery.celular, mask: Constantes.mascaraTELEFONE).text), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(delivery.logradouro ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(delivery.numero ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(delivery.complemento ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(MaskedTextController(text: delivery.cep, mask: Constantes.mascaraCEP).text), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(delivery.bairro ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(delivery.cidade ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(delivery.uf ?? ''), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarValorDecimal(delivery.valorFrete)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarValorDecimal(delivery.valorRecebido)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarValorDecimal(delivery.valorSolicitadoTroco)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(delivery.previsaoPreparo)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(delivery.inicioPreparo)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(delivery.previsaoEntrega)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(delivery.saiuParaEntrega)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(delivery.entregue)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(delivery.previsaoRetirada)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(delivery.prontoParaRetirada)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
        DataCell(Text(Biblioteca.formatarData(delivery.retirou)), onTap: () {
          _detalharDelivery(deliveryMontado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaDeliveryMontado!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharDelivery(DeliveryMontado deliveryMontado, BuildContext context, Function refrescarTela) {
  deliveryMontado.colaborador = deliveryMontado.colaborador ?? Colaborador(id:null);
  deliveryMontado.taxaEntrega = deliveryMontado.taxaEntrega ?? TaxaEntrega(id:null);
  Navigator.of(context)
    .push(MaterialPageRoute(
      builder: (BuildContext context) => DeliveryPersistePage(
      deliveryMontado: deliveryMontado, title: 'Delivery - Editando', operacao: 'A')))
    .then((_) async {    
      await refrescarTela();
   });
}