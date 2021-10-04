// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_controller.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_contato_lista_page.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_juridica_persiste_page.dart';
import 'package:t2ti_erp_fenix/src/view/pessoa_persiste_page.dart';

enum TabsDemoStyle {
  iconsAndText,
  iconsOnly,
  textOnly
}

class _Aba {
  _Aba({ this.icon, this.text, this.visible, this.pagina });
  IconData icon;
  String text;
  bool visible;
  Widget pagina;
}

List<_Aba> _todasAsAbas = <_Aba>[];

List<_Aba> abasAtivas() {
  List<_Aba> retorno = [];
  for (var item in _todasAsAbas) {
    if (item.visible) retorno.add(item);
  }
  return retorno;
}
  
class PessoaPage extends StatefulWidget {
  PessoaPage({this.pessoa, Key key}) : super(key: key);

  final Object pessoa;

  @override
  PessoaPageState createState() => PessoaPageState();
}

class PessoaPageState extends State<PessoaPage> with SingleTickerProviderStateMixin {
  TabController _abasController;
  TabsDemoStyle _demoStyle = TabsDemoStyle.iconsAndText;
  bool _customIndicator = false;

  @override
  void initState() {
    super.initState();
    _todasAsAbas.clear();
    _todasAsAbas.add(_Aba(icon: Icons.receipt, text: 'Detalhes', visible: true, pagina: PessoaPersistePage(pessoa: widget.pessoa)));
    _todasAsAbas.add(_Aba(icon: Icons.person, text: 'Pessoa Física', visible: false, pagina: null));
    _todasAsAbas.add(_Aba(icon: Icons.business, text: 'Pessoa Jurídica', visible: true, pagina: PessoaJuridicaPersistePage(pessoaJuridica: null)));
    _todasAsAbas.add(_Aba(icon: Icons.group, text: 'Contatos', visible: true, pagina: PessoaContatoListaPage()));
    _todasAsAbas.add(_Aba(icon: Icons.place, text: 'Endereços', visible: true, pagina: null));
    _todasAsAbas.add(_Aba(icon: Icons.phone, text: 'Telefones', visible: true, pagina: null));
    _abasController = TabController(vsync: this, length: abasAtivas().length);
  }

  @override
  void dispose() {
    _abasController.dispose();
    super.dispose();
  }

  void changeDemoStyle(TabsDemoStyle style) {
    setState(() {
      _demoStyle = style;
    });
  }

  Decoration getIndicator() {
    if (!_customIndicator)
      return const UnderlineTabIndicator();

    switch(_demoStyle) {
      case TabsDemoStyle.iconsAndText:
        return ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            side: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) + const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );

      case TabsDemoStyle.iconsOnly:
        return ShapeDecoration(
          shape: const CircleBorder(
            side: BorderSide(
              color: Colors.white24,
              width: 4.0,
            ),
          ) + const CircleBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );

      case TabsDemoStyle.textOnly:
        return ShapeDecoration(
          shape: const StadiumBorder(
            side: BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) + const StadiumBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pessoa'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () {
              PessoaController.pessoaFieldsPersiste.onPressedBotaoSalvar();
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: const Icon(Icons.sentiment_very_satisfied),
            onPressed: () {
              setState(() {
                _customIndicator = !_customIndicator;
              });
            },
          ),
          PopupMenuButton<TabsDemoStyle>(
            onSelected: changeDemoStyle,
            itemBuilder: (BuildContext context) => <PopupMenuItem<TabsDemoStyle>>[
              const PopupMenuItem<TabsDemoStyle>(
                value: TabsDemoStyle.iconsAndText,
                child: Text('Ícones e Texto'),
              ),
              const PopupMenuItem<TabsDemoStyle>(
                value: TabsDemoStyle.iconsOnly,
                child: Text('Apenas Ícones'),
              ),
              const PopupMenuItem<TabsDemoStyle>(
                value: TabsDemoStyle.textOnly,
                child: Text('Apenas Texto'),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _abasController,
          isScrollable: true,
          indicator: getIndicator(),
          tabs: abasAtivas().map<Tab>((_Aba aba) {
            assert(_demoStyle != null);
            switch (_demoStyle) {
              case TabsDemoStyle.iconsAndText:
                return Tab(text: aba.text, icon: Icon(aba.icon));
              case TabsDemoStyle.iconsOnly:
                return Tab(icon: Icon(aba.icon));
              case TabsDemoStyle.textOnly:
                return Tab(text: aba.text);
            }
            return null;
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _abasController,
        children: abasAtivas().map<Widget>((_Aba aba) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Container(
              key: ObjectKey(aba.icon),
              padding: const EdgeInsets.all(12.0),
              child: 
              
              aba.pagina == null
              ?
              Card(
                child: Center(
                  child: Icon(
                    aba.icon,
                    color: iconColor,
                    size: 128.0,
                    semanticLabel: 'Placeholder for ${aba.text} tab',
                  ),
                ),
              )
              :
              aba.pagina,

            ),
          );
        }).toList(),
      ),
    );
  }
}
