import 'package:flutter/material.dart';
import 'package:flutter_uikit/ui/widgets/label_below_icon.dart';

class DashboardMenuRow extends StatelessWidget {
  final BotaoMenu primeiroBotao;
  final BotaoMenu segundoBotao;
  final BotaoMenu terceiroBotao;
  final BotaoMenu quartoBotao;

  const DashboardMenuRow(
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
      lista.add(LabelBelowIcon(
        icon: primeiroBotao.icon,
        label: primeiroBotao.label,
        circleColor: primeiroBotao.circleColor,
      ));
    }

    if (segundoBotao != null) {
      lista.add(LabelBelowIcon(
        icon: segundoBotao.icon,
        label: segundoBotao.label,
        circleColor: segundoBotao.circleColor,
      ));
    }

    if (terceiroBotao != null) {
      lista.add(LabelBelowIcon(
        icon: terceiroBotao.icon,
        label: terceiroBotao.label,
        circleColor: terceiroBotao.circleColor,
      ));
    }

    if (quartoBotao != null) {
      lista.add(LabelBelowIcon(
        icon: quartoBotao.icon,
        label: quartoBotao.label,
        circleColor: quartoBotao.circleColor,
      ));
    }
    return lista;
  }
}

class BotaoMenu {
  IconData icon;
  String label;
  Color circleColor;

  BotaoMenu(
    this.icon,
    this.label,
    this.circleColor,
  );
}
