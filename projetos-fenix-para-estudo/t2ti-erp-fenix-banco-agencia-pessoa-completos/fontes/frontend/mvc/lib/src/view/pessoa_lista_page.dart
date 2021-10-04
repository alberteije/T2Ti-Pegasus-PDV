import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_controller.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_detalhe_page.dart';

class PessoaListaPage extends StatefulWidget {
  PessoaListaPage({Key key}) : super(key: key);

  @override
  State createState() => _PessoaListaState();
}

class _PessoaListaState extends StateMVC<PessoaListaPage> {
  _PessoaListaState() : super(PessoaController()) {
    pessoaController = controller;
  }
  PessoaController pessoaController;

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
        key: PessoaController.pessoaFieldsLista.scaffoldKeyPessoaListaPage,
        appBar: AppBar(title: Text('Cadastro da Pessoa'), actions: <Widget>[
          FlatButton(
              child: Icon(Icons.sort_by_alpha, color: Colors.white),
              onPressed: () {
                PessoaController.ordenar();
              }),
        ]),
        floatingActionButton: FloatingActionButton( 
            child: Icon(Icons.add),
            onPressed: () {
                Navigator.of(context).pushNamed("/PessoaAdd").then((_) {
                PessoaController.refrescarTela();
              });
            }),
        body: SafeArea( 
          child: PessoaController.listaPessoa == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder( 
                  itemCount: PessoaController.listaPessoa?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                  Object itemSelecionado = PessoaController.pessoaItemLista(index);
                  return PessoaController.pessoaFieldsLista.fieldId.onDismissible( 
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
                                    PessoaDetalhePage(
                                        pessoa: itemSelecionado)));
                          },
                          leading: PessoaController.pessoaFieldsLista.fieldId.circleAvatar,
                          title: PessoaController.pessoaFieldsLista.fieldNome.text,
                          subtitle: PessoaController.pessoaFieldsLista.fieldEmail.text,
                          trailing: PessoaController.pessoaFieldsLista.fieldTipo.circleAvatar,
                        ),
                      ),
                      dismissed: (DismissDirection direction) {
                        PessoaController.excluir(itemSelecionado).then((_) {
                          PessoaController.refrescarLista();
                        });
                        PessoaController.pessoaFieldsLista.scaffoldKeyPessoaListaPage.currentState //https://api.flutter.dev/flutter/material/ScaffoldState-class.html
                            ?.showSnackBar(SnackBar(
                                duration: Duration(milliseconds: 8000),
                                content: Text('Você Excluiu um Item.'),
                                action: SnackBarAction(
                                    label: 'Desfazer',
                                    onPressed: () {
                                      // PessoaController.edit.undelete(pessoaSelecionado);
                                      PessoaController.refrescarTela();// .pessoaListando.refresh();
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
