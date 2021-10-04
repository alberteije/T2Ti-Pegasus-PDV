import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart';
import 'package:t2ti_erp_fenix/src/controller/banco_controller.dart';
import 'package:t2ti_erp_fenix/src/view/banco_persiste_page.dart';

class BancoDetalhePage extends StatelessWidget {
  BancoDetalhePage({this.banco, Key key}) : super(key: key) {
    BancoController.bancoFields.init(banco);
  }

  final Object banco;

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
                title: BancoController.bancoFields.fieldNome.text,
                actions: [
                  FlatButton(
                      child: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        showBox(text: 'Exclui esse banco?', context: context)
                            .then((bool delete) {
                          if (delete)
                            BancoController.excluir(banco).then((bool delete) {
                              if (delete)
                                BancoController.refrescarLista();
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
                    builder: (BuildContext context) => BancoPersistePage(
                        banco: banco, title: 'Editar um banco')));
              }),
            ),
            body: CustomScrollView(slivers: <Widget>[
              SliverList(
                //https://www.youtube.com/watch?v=ORiTTaVY6mM
                delegate: SliverChildListDelegate(<Widget>[
                  BancoController.bancoFields.fieldNome.onListTile(tap: () {
                    editBanco(banco, context);
                  }),
                  BancoController.bancoFields.fieldUrl.onListTile(tap: () {
                    editBanco(banco, context);
                  }),
                ]),
              )
            ])));
  }

  editBanco(Object banco, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            BancoPersistePage(banco: banco, title: 'Editar um banco')));
  }
}
