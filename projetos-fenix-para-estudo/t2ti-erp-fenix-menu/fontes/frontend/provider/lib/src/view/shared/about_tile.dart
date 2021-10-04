import 'package:flutter/material.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

class MyAboutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationIcon: FlutterLogo(
        colors: Colors.yellow,
      ),
      icon: FlutterLogo(
        colors: Colors.yellow,
      ),
      aboutBoxChildren: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Developed By Team T2Ti",
        ),
        Text(
          "T2Ti.COM",
        ),
      ],
      applicationName: ViewUtilLib.appNameString,
      applicationVersion: "1.0.0",
      applicationLegalese: "MIT",
    );
  }
}