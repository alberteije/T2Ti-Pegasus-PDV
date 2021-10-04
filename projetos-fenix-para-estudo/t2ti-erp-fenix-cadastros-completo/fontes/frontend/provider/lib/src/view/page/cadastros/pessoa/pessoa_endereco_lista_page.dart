/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [PESSOA_ENDERECO] 
                                                                                
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
import 'pessoa_endereco_detalhe_page.dart';
import 'pessoa_endereco_persiste_page.dart';

class PessoaEnderecoListaPage extends StatefulWidget {
  final Pessoa pessoa;

  const PessoaEnderecoListaPage({Key key, this.pessoa}) : super(key: key);

  @override
  _PessoaEnderecoListaPageState createState() => _PessoaEnderecoListaPageState();
}

class _PessoaEnderecoListaPageState extends State<PessoaEnderecoListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var pessoaEndereco = new PessoaEndereco();
            widget.pessoa.listaPessoaEndereco.add(pessoaEndereco);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PessoaEnderecoPersistePage(
                            pessoa: widget.pessoa,
                            pessoaEndereco: pessoaEndereco,
                            title: 'Pessoa Endereco - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (pessoaEndereco.logradouro == null || pessoaEndereco.logradouro == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.pessoa.listaPessoaEndereco.remove(pessoaEndereco);
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
	lista.add(DataColumn(label: Text('Logradouro')));
	lista.add(DataColumn(label: Text('Número')));
	lista.add(DataColumn(label: Text('Bairro')));
	lista.add(DataColumn(numeric: true, label: Text('Município IBGE')));
	lista.add(DataColumn(label: Text('UF')));
	lista.add(DataColumn(label: Text('CEP')));
	lista.add(DataColumn(label: Text('Cidade')));
	lista.add(DataColumn(label: Text('Complemento')));
	lista.add(DataColumn(label: Text('É Endereço Principal')));
	lista.add(DataColumn(label: Text('É Endereço de Entrega')));
	lista.add(DataColumn(label: Text('É Endereço de Cobrança')));
	lista.add(DataColumn(label: Text('É Endereço de Correspondência')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.pessoa.listaPessoaEndereco == null) {
      widget.pessoa.listaPessoaEndereco = [];
    }
    List<DataRow> lista = [];
    for (var pessoaEndereco in widget.pessoa.listaPessoaEndereco) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ pessoaEndereco.id ?? ''}'), onTap: () {
          detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
		DataCell(Text('${pessoaEndereco.logradouro ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.numero ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.bairro ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.municipioIbge ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.uf ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.cep ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.cidade ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.complemento ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.principal ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.entrega ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.cobranca ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
		DataCell(Text('${pessoaEndereco.correspondencia ?? ''}'), onTap: () {
			detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharPessoaEndereco(
      Pessoa pessoa, PessoaEndereco pessoaEndereco, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => PessoaEnderecoDetalhePage(
                  pessoa: pessoa,
                  pessoaEndereco: pessoaEndereco,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}