import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart';
import 'package:t2ti_erp_fenix/src/view/t2ti_erp_fenix_app.dart';

void main() => runApp(MyApp());

class MyApp extends App {
  @override
  AppView createView() => T2TiERPFenixApp();
}
