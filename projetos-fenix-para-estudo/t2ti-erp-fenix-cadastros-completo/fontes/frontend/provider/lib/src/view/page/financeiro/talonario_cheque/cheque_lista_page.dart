/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [CHEQUE] 
                                                                                
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
import 'cheque_detalhe_page.dart';
import 'cheque_persiste_page.dart';

class ChequeListaPage extends StatefulWidget {
  final TalonarioCheque talonarioCheque;

  const ChequeListaPage({Key key, this.talonarioCheque}) : super(key: key);

  @override
  _ChequeListaPageState createState() => _ChequeListaPageState();
}

class _ChequeListaPageState extends State<ChequeListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var cheque = new Cheque();
            widget.talonarioCheque.listaCheque.add(cheque);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ChequePersistePage(
                            talonarioCheque: widget.talonarioCheque,
                            cheque: cheque,
                            title: 'Cheque - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (cheque.numero == null || cheque.numero.toString() == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.talonarioCheque.listaCheque.remove(cheque);
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
	lista.add(DataColumn(numeric: true, label: Text('Número')));
	lista.add(DataColumn(label: Text('Status')));
	lista.add(DataColumn(label: Text('Data do Status')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.talonarioCheque.listaCheque == null) {
      widget.talonarioCheque.listaCheque = [];
    }
    List<DataRow> lista = [];
    for (var cheque in widget.talonarioCheque.listaCheque) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ cheque.id ?? ''}'), onTap: () {
          detalharCheque(widget.talonarioCheque, cheque, context);
        }),
		DataCell(Text('${cheque.numero ?? ''}'), onTap: () {
			detalharCheque(widget.talonarioCheque, cheque, context);
		}),
		DataCell(Text('${cheque.statusCheque ?? ''}'), onTap: () {
			detalharCheque(widget.talonarioCheque, cheque, context);
		}),
		DataCell(Text('${cheque.dataStatus ?? ''}'), onTap: () {
			detalharCheque(widget.talonarioCheque, cheque, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharCheque(
      TalonarioCheque talonarioCheque, Cheque cheque, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => ChequeDetalhePage(
                  talonarioCheque: talonarioCheque,
                  cheque: cheque,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}