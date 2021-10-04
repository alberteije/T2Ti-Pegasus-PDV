import 'package:fenix/src/infra/locator.dart';
import 'package:fenix/src/infra/rotas.dart';
import 'package:fenix/src/view_model/banco_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<BancoViewModel>()),
        // ChangeNotifierProvider(create: (_) => locator<BancoAgenciaViewModel>()),
        // ChangeNotifierProvider(create: (_) => locator<PessoaViewModel>()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        initialRoute: '/',
        title: 'T2Ti ERP Fenix',
        onGenerateRoute: Rotas.definirRotas,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}