import 'package:flutter/material.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/model/cadastros/pessoa_endereco.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'pessoa_endereco_persiste_page.dart';

class PessoaEnderecoDetalhePage extends StatefulWidget {
  final Pessoa pessoa;
  final PessoaEndereco pessoaEndereco;

  const PessoaEnderecoDetalhePage({Key key, this.pessoa, this.pessoaEndereco})
      : super(key: key);

  @override
  _PessoaEnderecoDetalhePageState createState() =>
      _PessoaEnderecoDetalhePageState();
}

class _PessoaEnderecoDetalhePageState extends State<PessoaEnderecoDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          platform: Theme.of(context).platform,
        ),
        child: Scaffold(
          appBar: AppBar(title: Text('Pessoa Endereco'), actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.pessoa.listaPessoaEndereco
                      .remove(widget.pessoaEndereco);
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
                            PessoaEnderecoPersistePage(
                                pessoa: widget.pessoa,
                                pessoaEndereco: widget.pessoaEndereco,
                                title: 'Pessoa Endereco - Editando',
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
                      "Detalhes de Pessoa Endereco",
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
                          title: Text(widget.pessoaEndereco.logradouro ?? ''),
                          subtitle: Text('Logradouro'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaEndereco.numero ?? ''),
                          subtitle: Text('Número'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaEndereco.bairro ?? ''),
                          subtitle: Text('Bairro'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title:
                              Text(widget.pessoaEndereco.municipioIbge.toString() ?? ''),
                          subtitle: Text('Município IBGE'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaEndereco.uf ?? ''),
                          subtitle: Text('UF'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaEndereco.cep ?? ''),
                          subtitle: Text('CEP'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaEndereco.cidade ?? ''),
                          subtitle: Text('Cidade'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaEndereco.complemento ?? ''),
                          subtitle: Text('Complemento'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaEndereco.principal ?? ''),
                          subtitle: Text('Principal'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaEndereco.entrega ?? ''),
                          subtitle: Text('Entrega'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title: Text(widget.pessoaEndereco.cobranca ?? ''),
                          subtitle: Text('Cobrança'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                          title:
                              Text(widget.pessoaEndereco.correspondencia ?? ''),
                          subtitle: Text('Correspondência'),
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
