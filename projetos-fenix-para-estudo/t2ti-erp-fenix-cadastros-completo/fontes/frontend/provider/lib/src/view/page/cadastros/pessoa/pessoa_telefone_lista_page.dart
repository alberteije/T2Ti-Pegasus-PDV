/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [PESSOA_TELEFONE] 
                                                                                
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
import 'pessoa_telefone_detalhe_page.dart';
import 'pessoa_telefone_persiste_page.dart';

class PessoaTelefoneListaPage extends StatefulWidget {
  final Pessoa pessoa;

  const PessoaTelefoneListaPage({Key key, this.pessoa}) : super(key: key);

  @override
  _PessoaTelefoneListaPageState createState() => _PessoaTelefoneListaPageState();
}

class _PessoaTelefoneListaPageState extends State<PessoaTelefoneListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var pessoaTelefone = new PessoaTelefone();
            widget.pessoa.listaPessoaTelefone.add(pessoaTelefone);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PessoaTelefonePersistePage(
                            pessoa: widget.pessoa,
                            pessoaTelefone: pessoaTelefone,
                            title: 'Pessoa Telefone - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (pessoaTelefone.tipo == null) { // se esse atributo estiver vazio, o objeto será removido
                  widget.pessoa.listaPessoaTelefone.remove(pessoaTelefone);
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
	lista.add(DataColumn(label: Text('Tipo')));
	lista.add(DataColumn(label: Text('Número')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.pessoa.listaPessoaTelefone == null) {
      widget.pessoa.listaPessoaTelefone = [];
    }
    List<DataRow> lista = [];
    for (var pessoaTelefone in widget.pessoa.listaPessoaTelefone) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ pessoaTelefone.id ?? ''}'), onTap: () {
          detalharPessoaTelefone(widget.pessoa, pessoaTelefone, context);
        }),
		DataCell(Text('${pessoaTelefone.tipo ?? ''}'), onTap: () {
			detalharPessoaTelefone(widget.pessoa, pessoaTelefone, context);
		}),
		DataCell(Text('${pessoaTelefone.numero ?? ''}'), onTap: () {
			detalharPessoaTelefone(widget.pessoa, pessoaTelefone, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharPessoaTelefone(
      Pessoa pessoa, PessoaTelefone pessoaTelefone, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => PessoaTelefoneDetalhePage(
                  pessoa: pessoa,
                  pessoaTelefone: pessoaTelefone,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}