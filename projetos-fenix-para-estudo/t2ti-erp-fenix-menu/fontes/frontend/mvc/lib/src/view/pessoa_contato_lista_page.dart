import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_contato_controller.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_contato_detalhe_page.dart';

class PessoaContatoListaPage extends StatefulWidget {
  PessoaContatoListaPage({Key key}) : super(key: key);

  @override
  State createState() => _PessoaContatoListaState();
}

class _PessoaContatoListaState extends StateMVC<PessoaContatoListaPage> {
  _PessoaContatoListaState() : super(PessoaContatoController()) {
    pessoaContatoController = controller;
  }
  PessoaContatoController pessoaContatoController;

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
        key: PessoaContatoController.pessoaContatoFieldsLista.scaffoldKeyPessoaContatoListaPage,
        appBar: AppBar(title: Text('Contatos'), actions: <Widget>[
          FlatButton(
              child: Icon(Icons.sort_by_alpha, color: Colors.white),
              onPressed: () {
                PessoaContatoController.ordenar();
              }),
        ]),
        floatingActionButton: FloatingActionButton( 
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("/PessoaContatoAdd").then((_) {
                PessoaContatoController.refrescarTela();
              });
            }),
        body: SafeArea( 
          child: PessoaContatoController.listaPessoaContato == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder( 
                  itemCount: PessoaContatoController.listaPessoaContato?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                  Object pessoaContatoSelecionado = PessoaContatoController.pessoaContatoItemLista(index);
                  return PessoaContatoController.pessoaContatoFieldsLista.fieldId.onDismissible( 
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
                                    PessoaContatoDetalhePage(
                                        pessoaContato: pessoaContatoSelecionado)));
                          },
                          leading: PessoaContatoController.pessoaContatoFieldsLista.fieldId.circleAvatar,
                          title: PessoaContatoController.pessoaContatoFieldsLista.fieldNome.text,
                          subtitle: PessoaContatoController.pessoaContatoFieldsLista.fieldEmail.text,
                          trailing: PessoaContatoController.pessoaContatoFieldsLista.fieldId.circleAvatar,
                        ),
                      ),
                      dismissed: (DismissDirection direction) {
                        PessoaContatoController.excluir(pessoaContatoSelecionado).then((_) {
                          PessoaContatoController.refrescarLista();
                        });
                        PessoaContatoController.pessoaContatoFieldsLista.scaffoldKeyPessoaContatoListaPage.currentState //https://api.flutter.dev/flutter/material/ScaffoldState-class.html
                            ?.showSnackBar(SnackBar(
                                duration: Duration(milliseconds: 8000),
                                content: Text('Você Excluiu um Item.'),
                                action: SnackBarAction(
                                    label: 'Desfazer',
                                    onPressed: () {
                                      // PessoaContatoController.edit.undelete(pessoaContatoSelecionado);
                                      PessoaContatoController.refrescarTela();// .pessoaContatoListando.refresh();
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