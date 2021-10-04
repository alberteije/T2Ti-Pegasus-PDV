import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_contato_controller.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_contato_persiste_page.dart';

class PessoaContatoDetalhePage extends StatelessWidget {
  PessoaContatoDetalhePage({this.pessoaContato, Key key}) : super(key: key) {
    PessoaContatoController.pessoaContatoFields.init(pessoaContato);
  }

  final Object pessoaContato;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          brightness: Brightness.light,
          primarySwatch: App.colorTheme,
          platform: Theme.of(context).platform,
        ),
        child: Scaffold(
            appBar: AppBar(
                title: PessoaContatoController.pessoaContatoFields.fieldNome.text,
                actions: [
                  FlatButton(
                      child: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        showBox(text: 'Exclui esse contato?', context: context)
                            .then((bool delete) {
                          if (delete)
                            PessoaContatoController.excluir(pessoaContato).then((bool delete) {
                              if (delete)
                                PessoaContatoController.refrescarLista();
                              Navigator.of(context).pop();
                            });
                        });
                      }),
                ]),
            bottomNavigationBar: SimpleBottomAppBar(
              button01: HomeBarButton(onPressed: () {
                Navigator.of(context).pop();
              }),
              button02: SearchBarButton(),
              button03: EditBarButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PessoaContatoPersistePage(
                        pessoaContato: pessoaContato, title: 'Editar um Contato')));
              }),
            ),
            body: CustomScrollView(slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  PessoaContatoController.pessoaContatoFields.fieldNome.onListTile(tap: () {
                    editPessoaContato(pessoaContato, context);
                  }),
                  PessoaContatoController.pessoaContatoFields.fieldEmail.onListTile(tap: () {
                    editPessoaContato(pessoaContato, context);
                  }),
                  PessoaContatoController.pessoaContatoFields.fieldObservacao.onListTile(tap: () {
                    editPessoaContato(pessoaContato, context);
                  }),
                ]),
              )
            ])));
  }

  editPessoaContato(Object pessoaContato, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            PessoaContatoPersistePage(pessoaContato: pessoaContato, title: 'Editar um Contato')));
  }
}
