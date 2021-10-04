import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/controller/banco_controller.dart';
import 'package:t2ti_erp_fenix/src/view/banco_detalhe_page.dart';

class BancoListaPage extends StatefulWidget {
  BancoListaPage({Key key}) : super(key: key);

  @override
  State createState() => _BancoListaState();
}

class _BancoListaState extends StateMVC<BancoListaPage> {
  _BancoListaState() : super(BancoController()) {
    bancoController = controller;
  }
  BancoController bancoController;

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
        key: BancoController.bancoFieldsLista.scaffoldKeyBancoListaPage,
        appBar: AppBar(title: Text('Cadastro de Bancos'), actions: <Widget>[
          FlatButton(
              child: Icon(Icons.sort_by_alpha, color: Colors.white),
              onPressed: () {
                BancoController.ordenar();
              }),
        ]),
        floatingActionButton: FloatingActionButton( //https://www.youtube.com/watch?v=2uaoEDOgk_I
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("/BancoAdd").then((_) {
                BancoController.refrescarTela();
              });
            }),
        body: SafeArea( //https://www.youtube.com/watch?v=lkF0TQJO0bA
          child: BancoController.listaBanco == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder( //https://www.youtube.com/watch?v=KJpkjHGiI5A
                  itemCount: BancoController.listaBanco?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                  Object bancoSelecionado = bancoController.bancoItemLista(index);
                  return BancoController.bancoFieldsLista.fieldCodigo.onDismissible( //https://www.youtube.com/watch?v=iEMgjrfuc58
                      child: Container( //https://www.youtube.com/watch?v=c1xLMaTUWCY
                        decoration: BoxDecoration(
                            color: _theme.canvasColor,
                            border: Border(
                                bottom:
                                    BorderSide(color: _theme.dividerColor))),
                        child: ListTile( //https://www.youtube.com/watch?v=l8dj0yPBvgQ
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BancoDetalhePage(
                                        banco: bancoSelecionado)));
                          },
                          leading: BancoController.bancoFieldsLista.fieldCodigo.circleAvatar,
                          title: BancoController.bancoFieldsLista.fieldNome.text,
                          subtitle: BancoController.bancoFieldsLista.fieldUrl.text,
                          trailing: BancoController.bancoFieldsLista.fieldCodigo.circleAvatar,
                        ),
                      ),
                      dismissed: (DismissDirection direction) {
                        BancoController.excluir(bancoSelecionado).then((_) {
                          BancoController.refrescarLista();
                        });
                        BancoController.bancoFieldsLista.scaffoldKeyBancoListaPage.currentState //https://api.flutter.dev/flutter/material/ScaffoldState-class.html
                            ?.showSnackBar(SnackBar(
                                duration: Duration(milliseconds: 8000),
                                content: Text('Você Excluiu um Item.'),
                                action: SnackBarAction(
                                    label: 'Desfazer',
                                    onPressed: () {
                                      // BancoController.edit.undelete(bancoSelecionado);
                                      BancoController.refrescarTela();// .bancoListando.refresh();
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
