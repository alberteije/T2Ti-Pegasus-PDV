import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/cadastros/banco_agencia.dart';
import 'package:fenix/src/view_model/cadastros/banco_agencia_view_model.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'banco_agencia_persiste_page.dart';

class BancoAgenciaDetalhePage extends StatelessWidget {
  final BancoAgencia bancoAgencia;

  const BancoAgenciaDetalhePage({Key key, this.bancoAgencia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bancoAgenciaProvider = Provider.of<BancoAgenciaViewModel>(context);

    if (bancoAgenciaProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Banco Agência'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<BancoAgenciaViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Banco Agencia'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    bancoAgenciaProvider.excluir(bancoAgencia.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BancoAgenciaPersistePage(
                              bancoAgencia: bancoAgencia,
                              title: 'Banco Agencia - Editando',
                              operacao: 'A')));
                },
              ),
            ]),
            body: SingleChildScrollView(
              child: Theme(
                data: ThemeData(fontFamily: 'Raleway'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ViewUtilLib.getPaddingDetalhePage(
                        'Detalhes de Banco Agencia'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                          ViewUtilLib.getListTileDataDetalhePageId(
                              bancoAgencia.id?.toString() ?? '', 'Id'),
                          ViewUtilLib.getListTileDataDetalhePage(
                              bancoAgencia.banco.nome ?? '', 'Banco'),
                          ViewUtilLib.getListTileDataDetalhePage(
                              bancoAgencia.numero ?? '', 'Número'),
                          ViewUtilLib.getListTileDataDetalhePage(
                              bancoAgencia.digito ?? '', 'Dígito'),
                          ViewUtilLib.getListTileDataDetalhePage(
                              bancoAgencia.nome ?? '', 'Nome'),
                          ViewUtilLib.getListTileDataDetalhePage(
                              bancoAgencia.telefone ?? '', 'Telefone'),
                          ViewUtilLib.getListTileDataDetalhePage(
                              bancoAgencia.contato ?? '', 'Contato'),
                          ViewUtilLib.getListTileDataDetalhePage(
                              bancoAgencia.observacao ?? '', 'Observação'),
                          ViewUtilLib.getListTileDataDetalhePage(
                              bancoAgencia.gerente ?? '', 'Gerente'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    }
  }
}
