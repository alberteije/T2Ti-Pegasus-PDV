import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/controller/banco_controller.dart';

class BancoPersistePage extends StatefulWidget {
  BancoPersistePage({this.banco, this.title, Key key}) : super(key: key);
  final Object banco;
  final String title;

  @override
  State createState() => _BancoPersisteState();
}

class _BancoPersisteState extends StateMVC<BancoPersistePage> {
  @override
  void initState() {
    super.initState();
    BancoController.bancoFieldsPersiste.init(widget.banco);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "Adicionar Banco"),
        actions: [
          FlatButton(
            child: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              BancoController.bancoFieldsPersiste.onPressedBotaoSalvar();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
            key: BancoController.bancoFieldsPersiste.formKeyBancoPersistePage,
            child: ListView(
              children: [
                BancoController.bancoFieldsPersiste.fieldCodigo.textFormField,
                BancoController.bancoFieldsPersiste.fieldNome.textFormField,
                BancoController.bancoFieldsPersiste.fieldUrl.textFormField,
              ],
            )),
      ),
    );
  }
}
