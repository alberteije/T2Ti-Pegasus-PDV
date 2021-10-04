import 'package:fenix/src/model/banco.dart';
import 'package:fenix/src/view/page/cadastro/banco/banco_persiste_page.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view_model/banco_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BancoDetalhePage extends StatelessWidget {
  final Banco banco;

  const BancoDetalhePage({Key key, this.banco}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bancoProvider = Provider.of<BancoViewModel>(context);

    if (bancoProvider.objetoJsonErro != null) {
      Navigator.of(context).pop();
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
                  return showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Exclusão de Registro'),
                        content: Text('Deseja excluir esse registro?'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Sim'),
                            onPressed: () {
                              bancoProvider.excluir(banco.id);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('Não'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => BancoPersistePage(
                          banco: banco, title: 'Banco - Editando')));
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
