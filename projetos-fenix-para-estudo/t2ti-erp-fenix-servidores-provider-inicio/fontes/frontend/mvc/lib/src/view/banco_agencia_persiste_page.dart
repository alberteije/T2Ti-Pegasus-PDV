import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/controller/banco_agencia_controller.dart';
import 'package:t2ti_erp_fenix/src/view/delegate/data_search.dart';

class BancoAgenciaPersistePage extends StatefulWidget {
  BancoAgenciaPersistePage({this.bancoAgencia, this.title, Key key})
      : super(key: key);
  final Object bancoAgencia;
  final String title;

  @override
  State createState() => _BancoAgenciaPersisteState();
}

class _BancoAgenciaPersisteState extends StateMVC<BancoAgenciaPersistePage> {
  @override
  void initState() {
    super.initState();
    BancoAgenciaController.bancoAgenciaPersistindo.init(widget.bancoAgencia);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "Adicionar Agencia"),
        actions: [
          FlatButton(
            child: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              BancoAgenciaController.bancoAgenciaPersistindo.onPressed();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
            key: BancoAgenciaController.bancoAgenciaPersistindo.formKey,
            child: ListView(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: BancoAgenciaController.bancoAgenciaPersistindo.idBanco.textFormField,
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: IconButton(
                        tooltip: 'Importar Banco',
                        icon: const Icon(Icons.search),
                        onPressed: () async {
                          final String bancoSelecionado = await showSearch<String>(
                              context: context,
                              delegate: DataSearch(),
                          );
                          if (bancoSelecionado != null) {
                            BancoAgenciaController.bancoAgenciaPersistindo.setBanco(bancoSelecionado);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                BancoAgenciaController.bancoAgenciaPersistindo.numero.textFormField,
                BancoAgenciaController.bancoAgenciaPersistindo.digito.textFormField,
                BancoAgenciaController.bancoAgenciaPersistindo.nome.textFormField,
                BancoAgenciaController.bancoAgenciaPersistindo.telefone.textFormField,
                BancoAgenciaController.bancoAgenciaPersistindo.contato.textFormField,
                BancoAgenciaController.bancoAgenciaPersistindo.observacao.textFormField,
                BancoAgenciaController.bancoAgenciaPersistindo.gerente.textFormField,
              ],
            )),
      ),
    );
  }
}
