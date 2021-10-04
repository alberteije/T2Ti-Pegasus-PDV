import 'package:flutter/material.dart';
import 'package:flutter_uikit/utils/uidata.dart';

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
      applicationName: UIData.appName,
      applicationVersion: "1.0.0",
      applicationLegalese: "MIT",
    );
  }
}
