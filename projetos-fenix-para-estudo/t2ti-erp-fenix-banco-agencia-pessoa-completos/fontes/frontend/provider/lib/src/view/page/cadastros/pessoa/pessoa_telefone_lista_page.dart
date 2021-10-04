import 'package:flutter/material.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_telefone.dart';

import 'pessoa_telefone_detalhe_page.dart';
import 'pessoa_telefone_persiste_page.dart';

class PessoaTelefoneListaPage extends StatefulWidget {
  final Pessoa pessoa;

  const PessoaTelefoneListaPage({Key key, this.pessoa}) : super(key: key);

  @override
  _PessoaTelefoneListaPageState createState() =>
      _PessoaTelefoneListaPageState();
}

class _PessoaTelefoneListaPageState extends State<PessoaTelefoneListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.add),
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
                if (pessoaTelefone.tipo == null) {
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
    for (var i = 0; i < PessoaTelefone.colunas.length; i++) {
      lista.add(DataColumn(label: Text(PessoaTelefone.colunas[i])));
    }
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
        DataCell(Text('${pessoaTelefone.id ?? ''}'), onTap: () {
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
                )))
        .then((_) {
      setState(() {
        getRows();
      });
    });
  }
}