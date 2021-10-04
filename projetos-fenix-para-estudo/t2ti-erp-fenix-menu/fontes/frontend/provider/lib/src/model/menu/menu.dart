import 'package:flutter/material.dart';

class Menu {
  String title;
  IconData icon;
  String image;
  String route;
  BuildContext context;
  Color menuColor;

  Menu(
      {this.title,
      this.icon,
      this.image,
      this.route,
      this.context,
      this.menuColor = Colors.black});
}
