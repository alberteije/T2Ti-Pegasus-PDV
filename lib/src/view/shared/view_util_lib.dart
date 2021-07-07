/*
Title: T2Ti ERP 3.0                                                                
Description: Classe que armazena alguns métodos e widgets úteis para as páginas da aplicação.
            Normalmente retornaremos widgets para preencher partes das páginas.
            É possível também efetuar algumas operações que são comuns para parte das páginas 
            e podem ficar nesta classe.
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 T2Ti.COM                                          
                                                                                
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
import 'package:flutter/foundation.dart';

class ViewUtilLib {
  /// singleton
  factory ViewUtilLib() {
    _this ??= ViewUtilLib._();
    return _this;
  }
  static ViewUtilLib _this;
  ViewUtilLib._() : super();


// #region Ícones
  static Icon getIconBotaoExcluir() {
    return Icon(Icons.delete, color: Colors.white);
  }

  static Icon getIconBotaoAlterar() {
    return Icon(Icons.edit, color: Colors.white);
  }

  static Icon getIconBotaoInserir() {
    return Icon(Icons.add);
  }

  static Icon getIconBotaoFiltro() {
    return Icon(Icons.filter);
  }

  static Icon getIconBotaoPdf() {
    return Icon(Icons.picture_as_pdf);
  }

  static Icon getIconBotaoSalvar() {
    return Icon(Icons.save, color: Colors.white);
  }

  static Icon getIconBotaoLookup() {
    return Icon(Icons.search);
  }
// #endregion Ícones


// #region Cores
  static Color getBackgroundColorBotaoInserir() {
    return Colors.blueGrey;
  }

  static Color getBotaoFocusColor() {
    return Colors.indigo;
  }

  static Color getBackgroundColorBarraTelaDetalhe() {
    return Colors.blueGrey;
  }

  static Color getBottomAppBarColor() {
    return Colors.black26;
  }

  static Color getBottomAppBarFiltroLocalColor() {
    return Colors.blueGrey.shade200;
  }

  static Color getTextFieldReadOnlyColor() {
    return Colors.amber.shade100;
  }

  static Color getBackgroundColorSnackBarVermelho() {
    return Colors.red.shade900;
  }

  static Color getBackgroundColorSnackBarAzul() {
    return Colors.blue.shade900;
  }

  static Color getBackgroundColorCardValor(num valor) {
    if (valor == null || valor == 0) {
      return Colors.blue.shade100;
    } else if (valor > 0) {
      return Colors.green.shade100;
    } else {
      return Colors.red.shade100;
    }
  }

  static List<Color> kitGradients = [
    Colors.blueGrey.shade800,
    Colors.black87,
  ];

  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];
// #endregion Cores


// #region Padding
  static EdgeInsets paddingBootstrapContainerTelaPequena = EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0);
  static EdgeInsets paddingBootstrapContainerTelaGrande = EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0);
  static EdgeInsets paddingAbaPersistePage = EdgeInsets.symmetric(horizontal: 16.0);
// #region Padding

static SliderThemeData sliderThemeData(BuildContext context) {
  return SliderTheme.of(context).copyWith(
    activeTrackColor: Colors.blue[700],
    inactiveTrackColor: Colors.blue[100],
    trackShape: RoundedRectSliderTrackShape(),
    trackHeight: 4.0,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
    thumbColor: Colors.blueAccent,
    overlayColor: Colors.blue.withAlpha(32),
    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
    tickMarkShape: RoundSliderTickMarkShape(),
    activeTickMarkColor: Colors.blue[700],
    inactiveTickMarkColor: Colors.blue[100],
    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
    valueIndicatorColor: Colors.blueAccent,
    valueIndicatorTextStyle: TextStyle(
      color: Colors.white,
    ),
  );
}

}

/// Controla o Date Picker
// ignore: must_be_immutable
class DatePickerItem extends StatelessWidget {
  DatePickerItem({Key key, DateTime dateTime, @required this.onChanged, this.firstDate, this.lastDate, this.mascara, this.readOnly})
      : date = dateTime == null
            ? null
            : DateTime(dateTime.year, dateTime.month, dateTime.day),
        super(key: key);

  final DateTime firstDate;
  final DateTime lastDate;
  final String mascara;
  DateTime date;
  final ValueChanged<DateTime> onChanged;
  final bool readOnly;

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
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: theme.dividerColor))),
              child: InkWell(
                onDoubleTap: () {
                  onChanged(null);
                },
                onTap: () {
                  if (readOnly == null || readOnly == false) {
                    showDatePicker(
                      context: context,
                      initialDate: date != null ? date : hoje,
                      firstDate: firstDate,
                      lastDate: lastDate,
                    ).then<void>((DateTime value) {
                      if (value != null) {
                        onChanged(DateTime(value.year, value.month, value.day));
                      }
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(date != null
                        ? DateFormat(mascara != null ? mascara : 'EEE, d / MMM / yyyy').format(date)
                        : ''),
                    ),
                    Expanded(
                      flex: 0,
                      child: Icon(Icons.arrow_drop_down, color: Colors.black54),
                    ),
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