import 'package:flutter/material.dart';
import 'package:fenix/src/view/menu/menu_interno_botao.dart';

class MenuInternoBotoes extends StatelessWidget {
  final BotaoMenu primeiroBotao;
  final BotaoMenu segundoBotao;
  final BotaoMenu terceiroBotao;
  final BotaoMenu quartoBotao;

  const MenuInternoBotoes(
      {Key key,
      this.primeiroBotao,
      this.segundoBotao,
      this.terceiroBotao,
      this.quartoBotao})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: botoes(),
      ),
    );
  }

  List<Widget> botoes() {
    List<Widget> lista = [];
    if (primeiroBotao != null) {
      lista.add(MenuInternoBotao(
        icon: primeiroBotao.icon,
        label: primeiroBotao.label,
        circleColor: primeiroBotao.circleColor,
        rota: primeiroBotao.rota,
      ));
    }

    if (segundoBotao != null) {
      lista.add(MenuInternoBotao(
        icon: segundoBotao.icon,
        label: segundoBotao.label,
        circleColor: segundoBotao.circleColor,
        rota: segundoBotao.rota,
      ));
    }

    if (terceiroBotao != null) {
      lista.add(MenuInternoBotao(
        icon: terceiroBotao.icon,
        label: terceiroBotao.label,
        circleColor: terceiroBotao.circleColor,
        rota: terceiroBotao.rota,
      ));
    }

    if (quartoBotao != null) {
      lista.add(MenuInternoBotao(
        icon: quartoBotao.icon,
        label: quartoBotao.label,
        circleColor: quartoBotao.circleColor,
        rota: quartoBotao.rota,
      ));
    }
    return lista;
  }
}

class BotaoMenu {
  IconData icon;
  String label;
  Color circleColor;
  String rota;

  BotaoMenu(
    {this.icon,
    this.label,
    this.circleColor,
    this.rota,}
  );
}
