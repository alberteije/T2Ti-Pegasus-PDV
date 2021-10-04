import 'package:fenix/src/model/filtro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                    DateItem(
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
                    DateItem(
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

class DateItem extends StatelessWidget {
  DateItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = DateTime(dateTime.year, dateTime.month, dateTime.day),
        super(key: key);

  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.subhead,
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
                    initialDate: date,
                    firstDate: date.subtract(const Duration(days: 30)),
                    lastDate: date.add(const Duration(days: 30)),
                  ).then<void>((DateTime value) {
                    if (value != null)
                      onChanged(DateTime(value.year, value.month, value.day));
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(DateFormat('EEE, MMM d yyyy').format(date)),
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
