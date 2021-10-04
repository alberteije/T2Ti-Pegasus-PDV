import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/view_model/cadastros/pessoa_view_model.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'pessoa_page.dart';

class PessoaDetalhePage extends StatelessWidget {
  final Pessoa pessoa;

  const PessoaDetalhePage({Key key, this.pessoa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pessoaProvider = Provider.of<PessoaViewModel>(context);

    if (pessoaProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pessoa'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<PessoaViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Pessoa'), actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    pessoaProvider.excluir(pessoa.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PessoaPage(
                          pessoa: pessoa,
                          title: 'Pessoa - Editando',
                          operacao: 'A')));
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
                        "Detalhes de Pessoa",
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
                              Icons.vpn_key,
                              color: Colors.blue,
                            ),
                            title: Text(pessoa.id?.toString() ?? ''),
                            subtitle: Text('Id'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(pessoa.nome ?? ''),
                            subtitle: Text('Nome'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(pessoa.tipo ?? ''),
                            subtitle: Text('Tipo'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(pessoa.site ?? ''),
                            subtitle: Text('Site'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(pessoa.email ?? ''),
                            subtitle: Text('Email'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(pessoa.cliente ?? ''),
                            subtitle: Text('Cliente'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(pessoa.fornecedor ?? ''),
                            subtitle: Text('Fornecedor'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(pessoa.transportadora ?? ''),
                            subtitle: Text('Transportadora'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(pessoa.colaborador ?? ''),
                            subtitle: Text('Colaborador'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(pessoa.contador ?? ''),
                            subtitle: Text('Contador'),
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
}
