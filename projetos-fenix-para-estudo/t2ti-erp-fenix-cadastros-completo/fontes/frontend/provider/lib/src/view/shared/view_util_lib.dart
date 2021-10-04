/*
Title: T2Ti ERP Fenix                                                                
Description: Classe que armazena alguns métodos úteis para as páginas da aplicação.
            Normalmente retornaremos widgets para preencher partes das páginas.
            É possível também efetuar algumas operações que são comuns para parte das páginas 
            e podem ficar nesta classe.
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewUtilLib {
  /// singleton
  factory ViewUtilLib() {
    _this ??= ViewUtilLib._();
    return _this;
  }
  static ViewUtilLib _this;
  ViewUtilLib._() : super();

// #region Diálogos e avisos para o usuário

  /// Retorna a dialog box informando que o form foi alterado
  static Future<bool> gerarDialogBoxFormAlterado(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alterações não Concluídas'),
              content: const Text(
                  'Deseja fechar o formulário e perder as alterações?'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Sim'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: const Text('Não'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// Retorna um diálogo de exclusão
  static gerarDialogBoxExclusao(BuildContext context, Function onPressed) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exclusão de Registro'),
          content: Text('Deseja excluir esse registro?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Sim'),
              onPressed: onPressed,
            ),
            FlatButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Retorna um diálogo de informação
  static gerarDialogBoxInformacao(BuildContext context, String mensagem, Function onPressed) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informação do Sistema'),
          content: Text(mensagem),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: onPressed,
            ),
          ],
        );
      },
    );
  }

  /// Mostra uma snackbar com uma mensagem
  static showInSnackBar(String value, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: Colors.red,
    ));
  }

// #endregion Diálogos e avisos para o usuário

// #region Widgets para páginas de detalhe

  static Icon getIconBotaoExcluir() {
    return Icon(Icons.delete, color: Colors.white);
  }

  static Icon getIconBotaoAlterar() {
    return Icon(Icons.edit, color: Colors.white);
  }

  /// Retorna o Padding para a página de detalhe - cabeçalho da página
  static Padding getPaddingDetalhePage(String titulo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        titulo,
        style: TextStyle(color: Colors.grey.shade700),
      ),
    );
  }

  /// Retorna o Theme para a página de detalhe
  static ThemeData getThemeDataDetalhePage(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      platform: Theme.of(context).platform,
    );
  }

  /// Retorna o ListTile para a página de detalhe
  static ListTile getListTileDataDetalhePage(String title, String subtitle) {
    return ListTile(
      leading: Icon(
        Icons.arrow_right,
        color: Colors.grey,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  /// Retorna o ListTile para a página de detalhe - campos do tipo Id
  static ListTile getListTileDataDetalhePageId(String title, String subtitle) {
    return ListTile(
      leading: Icon(
        Icons.vpn_key,
        color: Colors.blue,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

// #endregion Widgets para páginas de detalhe

// #region Widgets para páginas de listagem

  static Icon getIconBotaoInserir() {
    return Icon(Icons.add);
  }

  static Icon getIconBotaoFiltro() {
    return Icon(Icons.filter);
  }

  static Color getBackgroundColorBotaoInserir() {
    return Colors.blueGrey;
  }

  static Color getBottomAppBarColor() {
    return Colors.black26;
  }

// #endregion Widgets para páginas de listagem

// #region Widgets para páginas de persistência

  static Icon getIconBotaoSalvar() {
    return Icon(Icons.save, color: Colors.white);
  }

  /// InputDecoration utilizada nas páginas de Persistência
  ///
  /// Os argumentos passados são os mesmos utilizados pela InputDecoration.
  /// Temos no entanto uma novidade:
  /// [aplicaPadding] deve ser true para controles que o necessitem, tais como DropDownButton e DatePickerItem.
  /// Os demais controles devem aplicar o padding padrão.
  static InputDecoration getInputDecorationPersistePage(
      String hintText, String labelText, bool aplicaPadding) {
    return InputDecoration(
      border: UnderlineInputBorder(),
      hintText: hintText,
      labelText: labelText,
      filled: true,
      contentPadding: aplicaPadding
          ? EdgeInsets.symmetric(vertical: 5, horizontal: 20)
          : null,
    );
  }

  /// Retorna um DropdownButton
  static DropdownButton<String> getDropDownButton(
      String value, Function(String) onChanged, List<String> items) {
    return DropdownButton<String>(
      isExpanded: true,
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

// #endregion Widgets para páginas de persistência

// #region Abas - Página Mestre-Detalhe

  /// Utilizado para saber se algo foi alterado em qualquer uma das páginas de detalhe
  /// para avisar ao usuário que dados serão perdidos caso ele saia da tela/página.
  static bool paginaMestreDetalheFoiAlterada;

  /// Retorna o ShapeDecoration para a página de abas
  static ShapeDecoration getShapeDecorationAbaPage(String estiloBotoesAba) {
    switch (estiloBotoesAba) {
      case 'iconsAndText':
        return ShapeDecoration(
          shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                side: BorderSide(
                  color: Colors.white24,
                  width: 2.0,
                ),
              ) +
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                side: BorderSide(
                  color: Colors.transparent,
                  width: 4.0,
                ),
              ),
        );

      case 'iconsOnly':
        return ShapeDecoration(
          shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.white24,
                  width: 4.0,
                ),
              ) +
              const CircleBorder(
                side: BorderSide(
                  color: Colors.transparent,
                  width: 4.0,
                ),
              ),
        );

      case 'textOnly':
        return ShapeDecoration(
          shape: const StadiumBorder(
                side: BorderSide(
                  color: Colors.white24,
                  width: 2.0,
                ),
              ) +
              const StadiumBorder(
                side: BorderSide(
                  color: Colors.transparent,
                  width: 4.0,
                ),
              ),
        );

      default:
        return null;
    }
  }

  /// Retorna o Scaffold da página de Abas - Página mestre/detalhe
  static WillPopScope getScaffoldAbaPage(
      String title,
      BuildContext context,
      TabController controllerAbas,
      List<Aba> abasAtivas,
      Decoration indicatorTabBar,
      String estiloBotoesAba,
      Function() onPressedIconButton,
      Function(String) onSelectedPopupMenuButton,
      Future<bool> Function() onWillPop) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save, color: Colors.white),
              onPressed: onPressedIconButton,
            ),
            PopupMenuButton<String>(
              onSelected: onSelectedPopupMenuButton,
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                const PopupMenuItem<String>(
                  value: 'iconsAndText',
                  child: Text('Ícones e Texto'),
                ),
                const PopupMenuItem<String>(
                  value: 'iconsOnly',
                  child: Text('Apenas Ícones'),
                ),
                const PopupMenuItem<String>(
                  value: 'textOnly',
                  child: Text('Apenas Texto'),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            controller: controllerAbas,
            isScrollable: true,
            indicator: indicatorTabBar,
            tabs: abasAtivas.map<Tab>((Aba aba) {
              switch (estiloBotoesAba) {
                case 'iconsAndText':
                  return Tab(text: aba.text, icon: Icon(aba.icon));
                case 'iconsOnly':
                  return Tab(icon: Icon(aba.icon));
                case 'textOnly':
                  return Tab(text: aba.text);
              }
              return null;
            }).toList(),
          ),
        ),
        body: TabBarView(
          controller: controllerAbas,
          children: abasAtivas.map<Widget>((Aba aba) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Container(
                key: ObjectKey(aba.icon),
                padding: const EdgeInsets.all(12.0),
                child: aba.pagina == null
                    ? Card(
                        child: Center(
                          child: Icon(
                            aba.icon,
                            color: Theme.of(context).accentColor,
                            size: 128.0,
                          ),
                        ),
                      )
                    : aba.pagina,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

// #endregion Abas - Página Mestre-Detalhe

// #region Cores
  static List<Color> kitGradients = [
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];
// #endregion Cores


}

/// Classe usada para montar a aba nas páginas mestre/detalhe
class Aba {
  Aba({this.icon, this.text, this.visible, this.pagina});
  IconData icon;
  String text;
  bool visible;
  Widget pagina;
}

/// Controla o Date Picker
class DatePickerItem extends StatelessWidget {
  DatePickerItem({Key key, DateTime dateTime, @required this.onChanged, this.firstDate, this.lastDate, this.mascara})
      : assert(onChanged != null),
        date = dateTime == null
            ? null
            : DateTime(dateTime.year, dateTime.month, dateTime.day),
        super(key: key);

  final DateTime firstDate;
  final DateTime lastDate;
  final String mascara;
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var hoje = DateTime.now();
    return DefaultTextStyle(
      style: theme.textTheme.subtitle1,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: theme.dividerColor))),
              child: InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: date != null ? date : hoje,
                    firstDate: firstDate,
                        // date != null
                        // ? date.subtract(const Duration(days: 30))
                        // : hoje.subtract(const Duration(days: 30)),
                    lastDate: lastDate,
                        // date != null
                        // ? date.add(const Duration(days: 30))
                        // : hoje.add(const Duration(days: 30)),
                  ).then<void>((DateTime value) {
                    if (value != null)
                      onChanged(DateTime(value.year, value.month, value.day));
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(date != null
                        ? DateFormat(mascara != null ? mascara : 'EEE, d / MMM / yyyy').format(date)
                        : ''),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
