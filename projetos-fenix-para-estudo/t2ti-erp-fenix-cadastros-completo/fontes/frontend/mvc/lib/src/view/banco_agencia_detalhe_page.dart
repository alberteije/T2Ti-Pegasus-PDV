import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart';
import 'package:t2ti_erp_fenix/src/controller/banco_agencia_controller.dart';
import 'package:t2ti_erp_fenix/src/view/banco_agencia_persiste_page.dart';

class BancoAgenciaDetalhePage extends StatelessWidget {
  BancoAgenciaDetalhePage({this.bancoAgencia, Key key}) : super(key: key) {
    BancoAgenciaController.bancoAgenciaEditando.init(bancoAgencia);
  }

  final Object bancoAgencia;

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
                title: BancoAgenciaController.bancoAgenciaEditando.nome.text,
                actions: [
                  FlatButton(
                      child: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        showBox(text: 'Exclui essa Agencia?', context: context)
                            .then((bool delete) {
                          if (delete)
                            BancoAgenciaController.excluir(bancoAgencia).then((bool delete) {
                              if (delete)
                                BancoAgenciaController.bancoAgenciaListando.refresh();
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
                    builder: (BuildContext context) => BancoAgenciaPersistePage(
                        bancoAgencia: bancoAgencia, title: 'Editar Agencia')));
              }),
            ),
            body: CustomScrollView(slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  BancoAgenciaController.bancoAgenciaEditando.idBanco.onListTile(tap: () {
                    editBancoAgencia(bancoAgencia, context);
                  }),
                  BancoAgenciaController.bancoAgenciaEditando.numero.onListTile(tap: () {
                    editBancoAgencia(bancoAgencia, context);
                  }),
                  BancoAgenciaController.bancoAgenciaEditando.digito.onListTile(tap: () {
                    editBancoAgencia(bancoAgencia, context);
                  }),
                  BancoAgenciaController.bancoAgenciaEditando.nome.onListTile(tap: () {
                    editBancoAgencia(bancoAgencia, context);
                  }),
                  BancoAgenciaController.bancoAgenciaEditando.gerente.onListTile(tap: () {
                    editBancoAgencia(bancoAgencia, context);
                  }),
                  BancoAgenciaController.bancoAgenciaEditando.contato.onListTile(tap: () {
                    editBancoAgencia(bancoAgencia, context);
                  }),
                  BancoAgenciaController.bancoAgenciaEditando.telefone.onListTile(tap: () {
                    editBancoAgencia(bancoAgencia, context);
                  }),
                  BancoAgenciaController.bancoAgenciaEditando.observacao.onListTile(tap: () {
                    editBancoAgencia(bancoAgencia, context);
                  }),
                ]),
              )
            ])));
  }

  editBancoAgencia(Object bancoAgencia, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            BancoAgenciaPersistePage(bancoAgencia: bancoAgencia, title: 'Editar Agencia')));
  }
}
