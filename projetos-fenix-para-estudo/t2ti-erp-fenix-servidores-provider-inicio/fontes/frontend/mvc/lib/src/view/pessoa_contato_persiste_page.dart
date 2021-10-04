import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_contato_controller.dart';

class PessoaContatoPersistePage extends StatefulWidget {
  PessoaContatoPersistePage({this.pessoaContato, this.title, Key key}) : super(key: key);
  final Object pessoaContato;
  final String title;

  @override
  State createState() => _PessoaContatoPersisteState();
}

class _PessoaContatoPersisteState extends StateMVC<PessoaContatoPersistePage> {
  @override
  void initState() {
    super.initState();
    PessoaContatoController.pessoaContatoFieldsPersiste.init(widget.pessoaContato);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "Adicionar Contato"),
        actions: [
          FlatButton(
            child: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              PessoaContatoController.pessoaContatoFieldsPersiste.onPressedBotaoSalvar();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
            key: PessoaContatoController.pessoaContatoFieldsPersiste.formKeyPessoaContatoPersistePage,
            child: ListView(
              children: [
                PessoaContatoController.pessoaContatoFieldsPersiste.fieldNome.textFormField,
                PessoaContatoController.pessoaContatoFieldsPersiste.fieldEmail.textFormField,
                PessoaContatoController.pessoaContatoFieldsPersiste.fieldObservacao.textFormField,
              ],
            )),
      ),
    );
  }
}
