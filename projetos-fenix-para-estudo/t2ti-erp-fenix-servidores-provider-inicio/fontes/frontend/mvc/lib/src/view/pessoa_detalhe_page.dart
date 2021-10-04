import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_controller.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_page.dart';

class PessoaDetalhePage extends StatelessWidget {
  PessoaDetalhePage({this.pessoa, Key key}) : super(key: key) {
    PessoaController.pessoaFields.init(pessoa);
  }

  final Object pessoa;

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
                title: PessoaController.pessoaFields.fieldNome.text,
                actions: [
                  FlatButton(
                      child: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        showBox(text: 'Exclui esse pessoa?', context: context)
                            .then((bool delete) {
                          if (delete)
                            PessoaController.excluir(pessoa).then((bool delete) {
                              if (delete)
                                PessoaController.refrescarLista();
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
                    builder: (BuildContext context) => PessoaPage(
                        pessoa: pessoa))).then((_) {
                          PessoaController.refrescarTela();
                          });
              }),
            ),
            body: CustomScrollView(slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  PessoaController.pessoaFields.fieldTipo.onListTile(tap: () {
                    editPessoa(pessoa, context);
                  }),
                  PessoaController.pessoaFields.fieldNome.onListTile(tap: () {
                    editPessoa(pessoa, context);
                  }),
                  PessoaController.pessoaFields.fieldEmail.onListTile(tap: () {
                    editPessoa(pessoa, context);
                  }),
                ]),
              )
            ])));
  }

  editPessoa(Object pessoa, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            PessoaPage(pessoa: pessoa)));
  }
}