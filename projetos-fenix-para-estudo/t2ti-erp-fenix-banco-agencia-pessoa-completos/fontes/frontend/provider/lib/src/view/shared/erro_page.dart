import 'package:fenix/src/model/retorno_json_erro.dart';
import 'package:flutter/material.dart';

class ErroPage extends StatelessWidget {
  const ErroPage({Key key, this.objetoJsonErro}) : super(key: key);

  final RetornoJsonErro objetoJsonErro;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 180.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/error.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ocorreu um Erro',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Status: ' + objetoJsonErro.status ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.blueAccent),
                        textAlign: TextAlign.left),
                    Text('Erro: ' + objetoJsonErro.error ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.purple),
                        textAlign: TextAlign.left),
                    Text('Mensagem: ' + objetoJsonErro.message ?? ''),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    color: Colors.black12,
                    child:
                        Text('Reportar Erro', semanticsLabel: 'Reportar erro'),
                    textColor: Colors.indigo,
                    onPressed: () {
                      print('pressed');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}