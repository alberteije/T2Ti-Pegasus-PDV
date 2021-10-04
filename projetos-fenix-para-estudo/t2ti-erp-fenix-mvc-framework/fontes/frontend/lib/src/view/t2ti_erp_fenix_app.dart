import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart';
import 'package:t2ti_erp_fenix/src/view/banco_lista_page.dart';
import 'package:t2ti_erp_fenix/src/view/banco_persiste_page.dart';
import 'package:t2ti_erp_fenix/src/view/banco_agencia_lista_page.dart';
import 'package:t2ti_erp_fenix/src/view/banco_agencia_persiste_page.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_page.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_persiste_page.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_lista_page.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_contato_persiste_page.dart';

class T2TiERPFenixApp extends AppView {
  T2TiERPFenixApp()
  : super(
    title: 'T2Ti ERP Fenix',
    routes: {
      '/BancoAdd': (BuildContext context) => BancoPersistePage(),
      '/BancoAgenciaAdd': (BuildContext context) => BancoAgenciaPersistePage(),
      '/PessoaAdd': (BuildContext context) => PessoaPage(),
      '/PessoaContatoAdd': (BuildContext context) => PessoaContatoPersistePage(),
      },
    home: PessoaListaPage(),//ScrollableTabsDemo(),//BancoListaPage(),//BancoAgenciaListaPage(),
    theme: ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.orangeAccent[400],
    ),
  );
}



