import 'package:flutter/material.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_telefone.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'pessoa_telefone_persiste_page.dart';

class PessoaTelefoneDetalhePage extends StatefulWidget {
  final Pessoa pessoa;
  final PessoaTelefone pessoaTelefone;

  const PessoaTelefoneDetalhePage({Key key, this.pessoa, this.pessoaTelefone})
      : super(key: key);

  @override
  _PessoaTelefoneDetalhePageState createState() =>
      _PessoaTelefoneDetalhePageState();
}

class _PessoaTelefoneDetalhePageState extends State<PessoaTelefoneDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          platform: Theme.of(context).platform,
        ),
        child: Scaffold(
          appBar: AppBar(title: Text('Pessoa Telefone'), actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.pessoa.listaPessoaTelefone
                      .remove(widget.pessoaTelefone);
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
                            PessoaTelefonePersistePage(
                                pessoa: widget.pessoa,
                                pessoaTelefone: widget.pessoaTelefone,
                                title: 'Pessoa Telefone - Editando',
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
                      "Detalhes de Pessoa Telefone",
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
                          title: Text(widget.pessoaTelefone.tipo ?? ''),
                          subtitle: Text('Tipo'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaTelefone.numero ?? ''),
                          subtitle: Text('Número'),
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
