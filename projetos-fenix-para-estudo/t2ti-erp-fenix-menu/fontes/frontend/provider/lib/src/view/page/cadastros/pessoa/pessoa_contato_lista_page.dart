import 'package:flutter/material.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_contato.dart';

import 'pessoa_contato_detalhe_page.dart';
import 'pessoa_contato_persiste_page.dart';

class PessoaContatoListaPage extends StatefulWidget {
  final Pessoa pessoa;

  const PessoaContatoListaPage({Key key, this.pessoa}) : super(key: key);

  @override
  _PessoaContatoListaPageState createState() => _PessoaContatoListaPageState();
}

class _PessoaContatoListaPageState extends State<PessoaContatoListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.add),
          onPressed: () {
            var pessoaContato = new PessoaContato();
            widget.pessoa.listaPessoaContato.add(pessoaContato);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PessoaContatoPersistePage(
                            pessoa: widget.pessoa,
                            pessoaContato: pessoaContato,
                            title: 'Pessoa Contato - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (pessoaContato.nome == null) {
                  widget.pessoa.listaPessoaContato.remove(pessoaContato);
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
    for (var i = 0; i < PessoaContato.colunas.length; i++) {
      lista.add(DataColumn(label: Text(PessoaContato.colunas[i])));
    }
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.pessoa.listaPessoaContato == null) {
      widget.pessoa.listaPessoaContato = [];
    }
    List<DataRow> lista = [];
    for (var pessoaContato in widget.pessoa.listaPessoaContato) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${pessoaContato.id ?? ''}'), onTap: () {
          detalharPessoaContato(widget.pessoa, pessoaContato, context);
        }),
        DataCell(Text('${pessoaContato.nome ?? ''}'), onTap: () {
          detalharPessoaContato(widget.pessoa, pessoaContato, context);
        }),
        DataCell(Text('${pessoaContato.email ?? ''}'), onTap: () {
          detalharPessoaContato(widget.pessoa, pessoaContato, context);
        }),
        DataCell(Text('${pessoaContato.observacao ?? ''}'), onTap: () {
          detalharPessoaContato(widget.pessoa, pessoaContato, context);
        }),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharPessoaContato(
      Pessoa pessoa, PessoaContato pessoaContato, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => PessoaContatoDetalhePage(
                  pessoa: pessoa,
                  pessoaContato: pessoaContato,
                )))
        .then((_) {
      setState(() {
        getRows();
      });
    });
  }
}