import 'package:flutter/material.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

class MenuInternoBotao extends StatelessWidget {
  final label;
  final IconData icon;
  final iconColor;
  final onPressed;
  final circleColor;
  final isCircleEnabled;
  final betweenHeight;
  final String rota;

  MenuInternoBotao(
      {this.label,
      this.icon,
      this.onPressed,
      this.iconColor = Colors.white,
      this.circleColor,
      this.isCircleEnabled = true,
      this.rota,
      this.betweenHeight = 5.0});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => abrirJanela(context, this.rota),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          isCircleEnabled
              ? CircleAvatar(
                  backgroundColor: circleColor,
                  radius: 20.0,
                  child: Icon(
                    icon,
                    size: 18.0,
                    color: iconColor,
                  ),
                )
              : Icon(
                  icon,
                  size: 18.0,
                  color: iconColor,
                ),
          SizedBox(
            height: betweenHeight,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: ViewUtilLib.ralewayFont),
          )
        ],
      ),
    );
  }
}

abrirJanela(BuildContext context, String rota) {
  if (rota != '' && rota != null) {
    Navigator.pushNamed(
      context,
      rota,
    );
  }
}
