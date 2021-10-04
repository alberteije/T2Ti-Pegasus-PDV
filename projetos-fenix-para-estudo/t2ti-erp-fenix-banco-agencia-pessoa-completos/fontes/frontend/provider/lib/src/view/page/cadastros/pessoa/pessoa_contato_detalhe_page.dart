import 'package:flutter/material.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_contato.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'pessoa_contato_persiste_page.dart';

class PessoaContatoDetalhePage extends StatefulWidget {
  final Pessoa pessoa;
  final PessoaContato pessoaContato;

  const PessoaContatoDetalhePage({Key key, this.pessoa, this.pessoaContato})
      : super(key: key);

  @override
  _PessoaContatoDetalhePageState createState() =>
      _PessoaContatoDetalhePageState();
}

class _PessoaContatoDetalhePageState extends State<PessoaContatoDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          platform: Theme.of(context).platform,
        ),
        child: Scaffold(
          appBar: AppBar(title: Text('Pessoa Contato'), actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.pessoa.listaPessoaContato.remove(widget.pessoaContato);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PessoaContatoPersistePage(
                                pessoa: widget.pessoa,
                                pessoaContato: widget.pessoaContato,
                                title: 'Pessoa Contato - Editando',
                                operacao: 'A')))
                    .then((_) {
                  setState(() {});
                });
              },
            ),
          ]),
          body: SingleChildScrollView(
            child: Theme(
              data: ThemeData(fontFamily: 'Raleway'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Detalhes de Pessoa Contato",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaContato.nome ?? ''),
                          subtitle: Text('Nome'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaContato.email ?? ''),
                          subtitle: Text('Email'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaContato.observacao ?? ''),
                          subtitle: Text('Observação'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
