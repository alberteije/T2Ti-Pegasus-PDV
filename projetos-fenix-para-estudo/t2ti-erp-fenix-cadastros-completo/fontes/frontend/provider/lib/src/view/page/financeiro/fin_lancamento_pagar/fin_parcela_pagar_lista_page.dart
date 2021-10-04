/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [FIN_PARCELA_PAGAR] 
                                                                                
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
import 'fin_parcela_pagar_detalhe_page.dart';
import 'fin_parcela_pagar_persiste_page.dart';

class FinParcelaPagarListaPage extends StatefulWidget {
  final FinLancamentoPagar finLancamentoPagar;

  const FinParcelaPagarListaPage({Key key, this.finLancamentoPagar}) : super(key: key);

  @override
  _FinParcelaPagarListaPageState createState() => _FinParcelaPagarListaPageState();
}

class _FinParcelaPagarListaPageState extends State<FinParcelaPagarListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var finParcelaPagar = new FinParcelaPagar();
            widget.finLancamentoPagar.listaFinParcelaPagar.add(finParcelaPagar);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        FinParcelaPagarPersistePage(
                            finLancamentoPagar: widget.finLancamentoPagar,
                            finParcelaPagar: finParcelaPagar,
                            title: 'Parcela Pagar - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (finParcelaPagar.numeroParcela == null || finParcelaPagar.numeroParcela.toString() == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.finLancamentoPagar.listaFinParcelaPagar.remove(finParcelaPagar);
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
	lista.add(DataColumn(label: Text('Conta Caixa')));
	lista.add(DataColumn(label: Text('Tipo Pagamento')));
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
	lista.add(DataColumn(numeric: true, label: Text('Valor Pago')));
	lista.add(DataColumn(label: Text('Histórico')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.finLancamentoPagar.listaFinParcelaPagar == null) {
      widget.finLancamentoPagar.listaFinParcelaPagar = [];
    }
    List<DataRow> lista = [];
    for (var finParcelaPagar in widget.finLancamentoPagar.listaFinParcelaPagar) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ finParcelaPagar.id ?? ''}'), onTap: () {
          detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
        }),
		DataCell(Text('${finParcelaPagar.finStatusParcela?.descricao ?? ''}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.bancoContaCaixa?.nome ?? ''}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.finTipoPagamento?.descricao ?? ''}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.finChequeEmitido?.cheque?.numero ?? ''}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.numeroParcela ?? ''}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.dataEmissao ?? ''}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.dataVencimento ?? ''}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.valor != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valor) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.taxaJuro != null ? Constantes.formatoDecimalTaxa.format(finParcelaPagar.taxaJuro) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.taxaMulta != null ? Constantes.formatoDecimalTaxa.format(finParcelaPagar.taxaMulta) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(finParcelaPagar.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.valorJuro != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valorJuro) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.valorMulta != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valorMulta) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.valorDesconto != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.valorPago != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valorPago) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
		DataCell(Text('${finParcelaPagar.historico ?? ''}'), onTap: () {
			detalharFinParcelaPagar(widget.finLancamentoPagar, finParcelaPagar, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharFinParcelaPagar(
      FinLancamentoPagar finLancamentoPagar, FinParcelaPagar finParcelaPagar, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => FinParcelaPagarDetalhePage(
                  finLancamentoPagar: finLancamentoPagar,
                  finParcelaPagar: finParcelaPagar,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}