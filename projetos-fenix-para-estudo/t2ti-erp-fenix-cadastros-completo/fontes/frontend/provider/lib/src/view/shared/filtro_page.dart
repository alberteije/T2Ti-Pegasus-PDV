/*
Title: T2Ti ERP Fenix                                                                
Description: Página de filtro
                                                                                
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

import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

class FiltroPage extends StatefulWidget {
  final String title;
  final List<String> colunas;
  final bool filtroPadrao;

  const FiltroPage({Key key, this.title, this.colunas, this.filtroPadrao})
      : super(key: key);

  @override
  FiltroPageState createState() => FiltroPageState();
}

class FiltroPageState extends State<FiltroPage> {
  DateTime _dataInicial = DateTime.now();
  DateTime _dataFinal = DateTime.now();

  Filtro filtro = Filtro();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    filtro.dataInicial = DateFormat('yyyy-MM-dd').format(_dataInicial);
    filtro.dataFinal = DateFormat('yyyy-MM-dd').format(_dataFinal);

    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              final FormState form = _formKey.currentState;
              form.save();
              Navigator.pop(context, filtro);
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Coluna',
                  hintText: 'Selecione a coluna para o filtro',
                  contentPadding: EdgeInsets.zero,
                ),
                isEmpty: filtro.campo == null,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: filtro.campo,
                  onChanged: (String newValue) {
                    setState(() {
                      filtro.campo = newValue;
                    });
                  },
                  items: widget.colunas
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: widget.colunas.indexOf(value).toString(),
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 1.0),
              Visibility(
                visible: widget.filtroPadrao ?? false,
                child: Container(
                  height: 90.0,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  alignment: Alignment.bottomLeft,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Filtro',
                      hintText: 'Informe o valor para o filtro',
                      filled: true,
                    ),
                    onSaved: (String value) {
                      filtro.valor = value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Visibility(
                visible: !widget.filtroPadrao ?? false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Data Inicial', style: theme.textTheme.caption),
                    DatePickerItem(
                      dateTime: _dataInicial,
                      onChanged: (DateTime value) {
                        filtro.dataInicial = value.toString();
                        setState(() {
                          _dataInicial = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Visibility(
                visible: !widget.filtroPadrao ?? false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Data Final', style: theme.textTheme.caption),
                    DatePickerItem(
                      dateTime: _dataFinal,
                      onChanged: (DateTime value) {
                        filtro.dataFinal = value.toString();
                        setState(() {
                          _dataFinal = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

