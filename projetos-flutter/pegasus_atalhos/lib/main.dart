// exemplo retirado de https://medium.com/flutter/handling-web-gestures-in-flutter-e16946a04745

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MaterialApp(home: FAD()));
}

class FAD extends StatefulWidget {
  FAD({Key key}) : super(key: key);
  @override
  _FADState createState() => _FADState();
}

class _FADState extends State<FAD> {
  Map<LogicalKeySet, Intent> _shortcutMap; //Intent - This class is what the Shortcuts.shortcuts map has as values, and is used by an ActionDispatcher to look up an action and invoke it, giving it this object to extract configuration information from.
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = <LogicalKeySet, Intent>{
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f2) : LogicalKeySet(LogicalKeyboardKey.f2):
          const AtalhoTelaIntent.inserir(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f3) : LogicalKeySet(LogicalKeyboardKey.f3):
          const AtalhoTelaIntent.alterar(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f8) : LogicalKeySet(LogicalKeyboardKey.f8):
          const AtalhoTelaIntent.imprimir(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f9) : LogicalKeySet(LogicalKeyboardKey.f9):
          const AtalhoTelaIntent.excluir(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f11) : LogicalKeySet(LogicalKeyboardKey.f11):
          const AtalhoTelaIntent.filtrar(),
      kIsWeb == true ? LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f12) : LogicalKeySet(LogicalKeyboardKey.f12):
          const AtalhoTelaIntent.salvar(),
    };

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _actionHandler,
      ),
    };
  }

  List<Widget> children = [
    Expanded(
      child: Focus(
        autofocus: true,
        child: Container(
          color: Colors.red,
          child: Text('Chame uma das opções de Menu: Control+F2, Control+F3, Control+F8, Control+F9, Control+F11, Control+F12 - DESKTOP? Chame sem o Control.'),
        ),
      ),
    ),
  ];

  void _actionHandler(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case atalhoTelaType.inserir:
        setState(() {
          children.add(
            Expanded(
              child: Container(
                color: Colors.orange,
                child: Text('Pressionou o atalho para INSERIR'),
              ),
            ),
          );
        });
        break;
      case atalhoTelaType.alterar:
        setState(() {
          children.add(
            Expanded(
              child: Container(
                color: Colors.yellow,
                child: Text('Pressionou o atalho para ALTERAR'),
              ),
            ),
          );
        });
        break;
      case atalhoTelaType.imprimir:
        setState(() {
          children.add(
            Expanded(
              child: Container(
                color: Colors.green,
                child: Text('Pressionou o atalho para IMPRIMIR'),
              ),
            ),
          );
        });
        break;
      case atalhoTelaType.excluir:
        setState(() {
          children.add(
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Text('Pressionou o atalho para EXCLUIR'),
              ),
            ),
          );
        });
        break;
      case atalhoTelaType.filtrar:
        setState(() {
          children.add(
            Expanded(
              child: Container(
                color: Colors.indigo,
                child: Text('Pressionou o atalho para FILTRAR'),
              ),
            ),
          );
        });
        break;
      case atalhoTelaType.salvar:
        setState(() {
          children.add(
            Expanded(
              child: Container(
                color: Colors.pink,
                child: Text('Pressionou o atalho para SALVAR'),
              ),
            ),
          );
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Focusable Action Detector'),
          actions: [
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

class AtalhoTelaIntent extends Intent {
  const AtalhoTelaIntent({@required this.type});

  const AtalhoTelaIntent.inserir() : type = atalhoTelaType.inserir;

  const AtalhoTelaIntent.alterar() : type = atalhoTelaType.alterar;

  const AtalhoTelaIntent.imprimir() : type = atalhoTelaType.imprimir;

  const AtalhoTelaIntent.excluir() : type = atalhoTelaType.excluir;

  const AtalhoTelaIntent.filtrar() : type = atalhoTelaType.filtrar;

  const AtalhoTelaIntent.salvar() : type = atalhoTelaType.salvar;

  final atalhoTelaType type;
}

enum atalhoTelaType {
  inserir,
  alterar,
  imprimir,
  excluir,
  filtrar,
  salvar,
}
