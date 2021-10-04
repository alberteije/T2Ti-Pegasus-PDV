/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/filtro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'fin_configuracao_boleto_persiste_page.dart';

class FinConfiguracaoBoletoListaPage extends StatefulWidget {
  @override
  _FinConfiguracaoBoletoListaPageState createState() => _FinConfiguracaoBoletoListaPageState();
}

class _FinConfiguracaoBoletoListaPageState extends State<FinConfiguracaoBoletoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<FinConfiguracaoBoletoViewModel>(context).listaFinConfiguracaoBoleto == null && Provider.of<FinConfiguracaoBoletoViewModel>(context).objetoJsonErro == null) {
      Provider.of<FinConfiguracaoBoletoViewModel>(context).consultarLista();
    }
    var listaFinConfiguracaoBoleto = Provider.of<FinConfiguracaoBoletoViewModel>(context).listaFinConfiguracaoBoleto;
    var colunas = FinConfiguracaoBoleto.colunas;
    var campos = FinConfiguracaoBoleto.campos;

    final FinConfiguracaoBoletoDataSource _finConfiguracaoBoletoDataSource =
        FinConfiguracaoBoletoDataSource(listaFinConfiguracaoBoleto, context);

    void _sort<T>(Comparable<T> getField(FinConfiguracaoBoleto finConfiguracaoBoleto), int columnIndex, bool ascending) {
      _finConfiguracaoBoletoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<FinConfiguracaoBoletoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Configuracao Boleto'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinConfiguracaoBoletoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Financeiro - Configuracao Boleto'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  FinConfiguracaoBoletoPersistePage(finConfiguracaoBoleto: FinConfiguracaoBoleto(), title: 'Configuracao Boleto - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<FinConfiguracaoBoletoViewModel>(context).consultarLista();
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: ViewUtilLib.getBottomAppBarColor(),
          shape: CircularNotchedRectangle(),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoFiltro(),
                onPressed: () async {
                  Filtro filtro = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FiltroPage(
                          title: 'Configuracao Boleto - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<FinConfiguracaoBoletoViewModel>(context)
                          .consultarLista(filtro: filtro);
                    }
                  }
                },
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refrescarTela,
          child: Scrollbar(
            child: listaFinConfiguracaoBoleto == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Configuracao Boleto'),
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
								label: const Text('Id'),
								numeric: true,
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.id,
										columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Conta Caixa'),
								tooltip: 'Conta Caixa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.idBancoContaCaixa,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Instrução 01'),
								tooltip: 'Instrução 01',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.instrucao01,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Instrução 02'),
								tooltip: 'Instrução 02',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.instrucao02,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Caminho Arquivo Remessa'),
								tooltip: 'Caminho Arquivo Remessa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.caminhoArquivoRemessa,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Caminho Arquivo Retorno'),
								tooltip: 'Caminho Arquivo Retorno',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.caminhoArquivoRetorno,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Caminho Arquivo Logotipo'),
								tooltip: 'Caminho Arquivo Logotipo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.caminhoArquivoLogotipo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Caminho Arquivo PDF'),
								tooltip: 'Caminho Arquivo PDF',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.caminhoArquivoPdf,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Mensagem'),
								tooltip: 'Mensagem',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.mensagem,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Local Pagamento'),
								tooltip: 'Local Pagamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.localPagamento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Layout Remessa'),
								tooltip: 'Layout Remessa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.layoutRemessa,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Aceite'),
								tooltip: 'Aceite',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.aceite,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Espécie'),
								tooltip: 'Espécie',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.especie,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Carteira'),
								tooltip: 'Carteira',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.carteira,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código Convênio'),
								tooltip: 'Código Convênio',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.codigoConvenio,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código Cedente'),
								tooltip: 'Código Cedente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.codigoCedente,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Multa'),
								tooltip: 'Taxa Multa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.taxaMulta,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Juros'),
								tooltip: 'Taxa Juros',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.taxaJuro,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Dias Protesto'),
								tooltip: 'Dias Protesto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.diasProtesto,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nosso Número Anterior'),
								tooltip: 'Nosso Número Anterior',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((FinConfiguracaoBoleto finConfiguracaoBoleto) => finConfiguracaoBoleto.nossoNumeroAnterior,
									columnIndex, ascending),
							),
                        ],
                        source: _finConfiguracaoBoletoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<FinConfiguracaoBoletoViewModel>(context).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class FinConfiguracaoBoletoDataSource extends DataTableSource {
  final List<FinConfiguracaoBoleto> listaFinConfiguracaoBoleto;
  final BuildContext context;

  FinConfiguracaoBoletoDataSource(this.listaFinConfiguracaoBoleto, this.context);

  void _sort<T>(Comparable<T> getField(FinConfiguracaoBoleto finConfiguracaoBoleto), bool ascending) {
    listaFinConfiguracaoBoleto.sort((FinConfiguracaoBoleto a, FinConfiguracaoBoleto b) {
      if (!ascending) {
        final FinConfiguracaoBoleto c = a;
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
    if (index >= listaFinConfiguracaoBoleto.length) return null;
    final FinConfiguracaoBoleto finConfiguracaoBoleto = listaFinConfiguracaoBoleto[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ finConfiguracaoBoleto.id ?? ''}'), onTap: () {
          detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
        }),
		DataCell(Text('${finConfiguracaoBoleto.idBancoContaCaixa ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.instrucao01 ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.instrucao02 ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.caminhoArquivoRemessa ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.caminhoArquivoRetorno ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.caminhoArquivoLogotipo ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.caminhoArquivoPdf ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.mensagem ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.localPagamento ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.layoutRemessa ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.aceite ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.especie ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.carteira ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.codigoConvenio ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.codigoCedente ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.taxaMulta != null ? Constantes.formatoDecimalTaxa.format(finConfiguracaoBoleto.taxaMulta) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.taxaJuro != null ? Constantes.formatoDecimalTaxa.format(finConfiguracaoBoleto.taxaJuro) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.diasProtesto ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
		DataCell(Text('${finConfiguracaoBoleto.nossoNumeroAnterior ?? ''}'), onTap: () {
			detalharFinConfiguracaoBoleto(finConfiguracaoBoleto, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaFinConfiguracaoBoleto.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharFinConfiguracaoBoleto(FinConfiguracaoBoleto finConfiguracaoBoleto, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/finConfiguracaoBoletoDetalhe',
    arguments: finConfiguracaoBoleto,
  );
}