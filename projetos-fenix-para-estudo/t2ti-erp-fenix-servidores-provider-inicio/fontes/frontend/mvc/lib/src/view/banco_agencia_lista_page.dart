import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/controller/banco_agencia_controller.dart';
import 'package:t2ti_erp_fenix/src/view/banco_agencia_detalhe_page.dart';

class BancoAgenciaListaPage extends StatefulWidget {
  BancoAgenciaListaPage({Key key}) : super(key: key);

  @override
  State createState() => _BancoAgenciaListaState();
}

class _BancoAgenciaListaState extends StateMVC<BancoAgenciaListaPage> {
  _BancoAgenciaListaState() : super(BancoAgenciaController()) {
    bancoAgenciaController = controller;
  }
  BancoAgenciaController bancoAgenciaController;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = App.theme;
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primarySwatch: App.colorTheme,
        platform: Theme.of(context).platform,
      ),
      child: Scaffold(
        key: BancoAgenciaController.bancoAgenciaListando.scaffoldKey,
        appBar: AppBar(title: Text('Cadastro de Agencias'), actions: <Widget>[
          FlatButton(
              child: Icon(Icons.sort_by_alpha, color: Colors.white),
              onPressed: () {
                BancoAgenciaController.bancoAgenciaListando.sort();
              }),
        ]),
        floatingActionButton: FloatingActionButton( 
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("/BancoAgenciaAdd").then((_) {
                BancoAgenciaController.bancoAgenciaListando.refresh();
              });
            }),
        body: SafeArea( 
          child: BancoAgenciaController.bancoAgenciaListando.items == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder( 
                  itemCount: BancoAgenciaController.bancoAgenciaListando.items?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                  Object bancoAgenciaSelecionado = bancoAgenciaController.child(index);
                  return BancoAgenciaController.bancoAgenciaListando.numero.onDismissible(
                      child: Container( 
                        decoration: BoxDecoration(
                            color: _theme.canvasColor,
                            border: Border(
                                bottom:
                                    BorderSide(color: _theme.dividerColor))),
                        child: ListTile( 
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BancoAgenciaDetalhePage(
                                        bancoAgencia: bancoAgenciaSelecionado)));
                          },
                          leading: BancoAgenciaController.bancoAgenciaListando.numero.circleAvatar,
                          title: BancoAgenciaController.bancoAgenciaListando.nome.text,
                          subtitle: BancoAgenciaController.bancoAgenciaListando.gerente.text,
                          trailing: BancoAgenciaController.bancoAgenciaListando.numero.circleAvatar,
                        ),
                      ),
                      dismissed: (DismissDirection direction) {
                        BancoAgenciaController.excluir(bancoAgenciaSelecionado).then((_) {
                          BancoAgenciaController.bancoAgenciaListando.refresh();
                        });
                        BancoAgenciaController.bancoAgenciaListando.scaffoldKey.currentState 
                            ?.showSnackBar(SnackBar(
                                duration: Duration(milliseconds: 8000),
                                content: Text('Você Excluiu um Item.'),
                                action: SnackBarAction(
                                    label: 'Desfazer',
                                    onPressed: () {                                      
                                      BancoAgenciaController.bancoAgenciaListando.refresh();
                                    })));
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
