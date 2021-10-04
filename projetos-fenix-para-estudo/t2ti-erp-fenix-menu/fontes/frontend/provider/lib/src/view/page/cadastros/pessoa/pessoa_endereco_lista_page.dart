import 'package:flutter/material.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_endereco.dart';

import 'pessoa_endereco_detalhe_page.dart';
import 'pessoa_endereco_persiste_page.dart';

class PessoaEnderecoListaPage extends StatefulWidget {
  final Pessoa pessoa;

  const PessoaEnderecoListaPage({Key key, this.pessoa}) : super(key: key);

  @override
  _PessoaEnderecoListaPageState createState() =>
      _PessoaEnderecoListaPageState();
}

class _PessoaEnderecoListaPageState extends State<PessoaEnderecoListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.add),
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
                if (pessoaEndereco.logradouro == null) {
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
    for (var i = 0; i < PessoaEndereco.colunas.length; i++) {
      lista.add(DataColumn(label: Text(PessoaEndereco.colunas[i])));
    }
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
        DataCell(Text('${pessoaEndereco.id ?? ''}'), onTap: () {
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
                )))
        .then((_) {
      setState(() {
        getRows();
      });
    });
  }
}