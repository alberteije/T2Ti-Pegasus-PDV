import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/cadastros/banco.dart';
import 'package:fenix/src/view_model/cadastros/banco_view_model.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'banco_persiste_page.dart';

class BancoDetalhePage extends StatelessWidget {
  final Banco banco;

  const BancoDetalhePage({Key key, this.banco}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bancoProvider = Provider.of<BancoViewModel>(context);

    if (bancoProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Banco'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<BancoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            platform: Theme.of(context).platform,
          ),
          child: Scaffold(
            appBar: AppBar(title: Text('Banco'), actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    bancoProvider.excluir(banco.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => BancoPersistePage(
                          banco: banco, title: 'Banco - Editando', operacao: 'A')));
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
                        "Detalhes do Banco",
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
                            title: Text(banco.id?.toString() ?? ''),
                            subtitle: Text('Id'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(banco.codigo ?? ''),
                            subtitle: Text('Código'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(banco.nome ?? ''),
                            subtitle: Text('Nome'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                            ),
                            title: Text(banco.url ?? ''),
                            subtitle: Text('URL'),
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