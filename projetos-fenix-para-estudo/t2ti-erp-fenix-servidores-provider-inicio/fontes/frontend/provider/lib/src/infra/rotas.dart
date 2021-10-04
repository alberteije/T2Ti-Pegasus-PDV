import 'package:fenix/src/model/banco.dart';
import 'package:fenix/src/view/page/cadastro/banco/banco_detalhe_page.dart';
import 'package:fenix/src/view/page/cadastro/banco/banco_lista_page.dart';
import 'package:fenix/src/view/page/cadastro/banco/banco_persiste_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rotas {
  static Route<dynamic> definirRotas(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => BancoListaPage());
      case '/bancoLista':
        return MaterialPageRoute(builder: (_) => BancoListaPage());
      case '/bancoDetalhe':
        var banco = settings.arguments as Banco;
        return MaterialPageRoute(builder: (_) => BancoDetalhePage(banco: banco));
      case '/bancoPersiste':
        return MaterialPageRoute(builder: (_) => BancoPersistePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Nenhuma rota definida para {$settings.name}'),
            )
          ),
        );
    }
  }
}
