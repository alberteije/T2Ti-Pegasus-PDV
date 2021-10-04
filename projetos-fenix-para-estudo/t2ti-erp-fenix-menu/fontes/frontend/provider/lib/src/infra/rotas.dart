import 'package:flutter/material.dart';

import 'package:fenix/src/view/menu/home_page.dart';
import 'package:fenix/src/view/menu/menu_cadastros.dart';

import 'package:fenix/src/model/cadastros/banco.dart';
import 'package:fenix/src/view/page/cadastros/banco/banco_detalhe_page.dart';
import 'package:fenix/src/view/page/cadastros/banco/banco_lista_page.dart';
import 'package:fenix/src/view/page/cadastros/banco/banco_persiste_page.dart';

import 'package:fenix/src/model/cadastros/banco_agencia.dart';
import 'package:fenix/src/view/page/cadastros/banco_agencia/banco_agencia_detalhe_page.dart';
import 'package:fenix/src/view/page/cadastros/banco_agencia/banco_agencia_lista_page.dart';
import 'package:fenix/src/view/page/cadastros/banco_agencia/banco_agencia_persiste_page.dart';

import 'package:fenix/src/model/cadastros/pessoa.dart';
import 'package:fenix/src/view/page/cadastros/pessoa/pessoa_detalhe_page.dart';
import 'package:fenix/src/view/page/cadastros/pessoa/pessoa_lista_page.dart';
import 'package:fenix/src/view/page/cadastros/pessoa/pessoa_persiste_page.dart';

class Rotas {
  static Route<dynamic> definirRotas(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());

      // Menus
      case '/cadastrosMenu':
        return MaterialPageRoute(builder: (_) => MenuCadastros());

      // Banco
      case '/bancoLista':
        return MaterialPageRoute(builder: (_) => BancoListaPage());
      case '/bancoDetalhe':
        var banco = settings.arguments as Banco;
        return MaterialPageRoute(
            builder: (_) => BancoDetalhePage(banco: banco));
      case '/bancoPersiste':
        return MaterialPageRoute(builder: (_) => BancoPersistePage());

      // BancoAgencia
      case '/bancoAgenciaLista':
        return MaterialPageRoute(builder: (_) => BancoAgenciaListaPage());
      case '/bancoAgenciaDetalhe':
        var bancoAgencia = settings.arguments as BancoAgencia;
        return MaterialPageRoute(
            builder: (_) =>
                BancoAgenciaDetalhePage(bancoAgencia: bancoAgencia));
      case '/bancoAgenciaPersiste':
        return MaterialPageRoute(builder: (_) => BancoAgenciaPersistePage());

      // Pessoa
      case '/pessoaLista':
        return MaterialPageRoute(builder: (_) => PessoaListaPage());
      case '/pessoaDetalhe':
        var pessoa = settings.arguments as Pessoa;
        return MaterialPageRoute(
            builder: (_) => PessoaDetalhePage(pessoa: pessoa));
      case '/pessoaPersiste':
        return MaterialPageRoute(builder: (_) => PessoaPersistePage());

      // default
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
              body: Center(
            child: Text('Nenhuma rota definida para {$settings.name}'),
          )),
        );
    }
  }
}
