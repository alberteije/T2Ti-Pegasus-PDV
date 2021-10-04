/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [FIN_PARCELA_RECEBER] 
                                                                                
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

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'fin_parcela_receber_detalhe_page.dart';
import 'fin_parcela_receber_persiste_page.dart';

class FinParcelaReceberListaPage extends StatefulWidget {
  final FinLancamentoReceber finLancamentoReceber;

  const FinParcelaReceberListaPage({Key key, this.finLancamentoReceber}) : super(key: key);

  @override
  _FinParcelaReceberListaPageState createState() => _FinParcelaReceberListaPageState();
}

class _FinParcelaReceberListaPageState extends State<FinParcelaReceberListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var finParcelaReceber = new FinParcelaReceber();
            widget.finLancamentoReceber.listaFinParcelaReceber.add(finParcelaReceber);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        FinParcelaReceberPersistePage(
                            finLancamentoReceber: widget.finLancamentoReceber,
                            finParcelaReceber: finParcelaReceber,
                            title: 'Parcela Receber - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (finParcelaReceber.numeroParcela == null || finParcelaReceber.numeroParcela.toString() == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.finLancamentoReceber.listaFinParcelaReceber.remove(finParcelaReceber);
                }
                getRows();
              });
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: DataTable(columns: getColumns(), rows: getRows()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> getColumns() {
    List<DataColumn> lista = [];
	lista.add(DataColumn(numeric: true, label: Text('Id')));
	lista.add(DataColumn(label: Text('Status Parcela')));
	lista.add(DataColumn(label: Text('Tipo Recebimento')));
	lista.add(DataColumn(label: Text('Conta Caixa')));
	lista.add(DataColumn(numeric: true, label: Text('Cheque')));
	lista.add(DataColumn(numeric: true, label: Text('Número da Parcela')));
	lista.add(DataColumn(label: Text('Data de Emissão')));
	lista.add(DataColumn(label: Text('Data de Vencimento')));
	lista.add(DataColumn(numeric: true, label: Text('Valor')));
	lista.add(DataColumn(numeric: true, label: Text('Taxa Juros')));
	lista.add(DataColumn(numeric: true, label: Text('Taxa Multa')));
	lista.add(DataColumn(numeric: true, label: Text('Taxa Desconto')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Juros')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Multa')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Desconto')));
	lista.add(DataColumn(label: Text('Emitiu Boleto')));
	lista.add(DataColumn(label: Text('Boleto Nosso Número')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Recebido')));
	lista.add(DataColumn(label: Text('Histórico')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.finLancamentoReceber.listaFinParcelaReceber == null) {
      widget.finLancamentoReceber.listaFinParcelaReceber = [];
    }
    List<DataRow> lista = [];
    for (var finParcelaReceber in widget.finLancamentoReceber.listaFinParcelaReceber) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ finParcelaReceber.id ?? ''}'), onTap: () {
          detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
        }),
		DataCell(Text('${finParcelaReceber.finStatusParcela?.descricao ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.finTipoRecebimento?.descricao ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.bancoContaCaixa?.nome ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.finChequeRecebido?.numero ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.numeroParcela ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.dataEmissao ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.dataVencimento ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.valor != null ? Constantes.formatoDecimalValor.format(finParcelaReceber.valor) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.taxaJuro != null ? Constantes.formatoDecimalTaxa.format(finParcelaReceber.taxaJuro) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.taxaMulta != null ? Constantes.formatoDecimalTaxa.format(finParcelaReceber.taxaMulta) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(finParcelaReceber.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.valorJuro != null ? Constantes.formatoDecimalValor.format(finParcelaReceber.valorJuro) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.valorMulta != null ? Constantes.formatoDecimalValor.format(finParcelaReceber.valorMulta) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.valorDesconto != null ? Constantes.formatoDecimalValor.format(finParcelaReceber.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.emitiuBoleto ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.boletoNossoNumero ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.valorRecebido != null ? Constantes.formatoDecimalValor.format(finParcelaReceber.valorRecebido) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
		DataCell(Text('${finParcelaReceber.historico ?? ''}'), onTap: () {
			detalharFinParcelaReceber(widget.finLancamentoReceber, finParcelaReceber, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharFinParcelaReceber(
      FinLancamentoReceber finLancamentoReceber, FinParcelaReceber finParcelaReceber, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => FinParcelaReceberDetalhePage(
                  finLancamentoReceber: finLancamentoReceber,
                  finParcelaReceber: finParcelaReceber,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}