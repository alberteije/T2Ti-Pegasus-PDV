import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_controller.dart';

class PessoaPersistePage extends StatefulWidget {
  PessoaPersistePage({this.pessoa, Key key}) : super(key: key);
  final Object pessoa;

  @override
  State createState() => _PessoaPersisteState();
}

class _PessoaPersisteState extends StateMVC<PessoaPersistePage> {
  @override
  void initState() {
    super.initState();
    PessoaController.pessoaFieldsPersiste.init(widget.pessoa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
            key: PessoaController.pessoaFieldsPersiste.formKeyPessoaPersistePage,
            child: ListView(
              children: [

                PessoaController.pessoaFieldsPersiste.fieldTipo.onListTile(
                  leading: Icon(Icons.recent_actors),
                  title: Text('Tipo'),
                  trailing: 
                    DropdownButton<String>(
                      value: PessoaController.pessoaFieldsPersiste.fieldTipo.value,
                      onChanged: (String newValue) {
                        setState( () {
                          if (newValue != null) {
                            PessoaController.pessoaFieldsPersiste.fieldTipo.onSaved(newValue);
                          }    
                        });
                      },
                      items: <String>['Física', 'Jurídica'].
                        map<DropdownMenuItem<String>>( (String value) {
                          return DropdownMenuItem<String> (
                            value: value,
                            child: Text(value));
                          }
                        ).toList(),
                    ),
                ),                

                PessoaController.pessoaFieldsPersiste.fieldNome.textFormField,
                PessoaController.pessoaFieldsPersiste.fieldSite.textFormField,
                PessoaController.pessoaFieldsPersiste.fieldEmail.textFormField,

                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('Pessoa é Cliente'),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        child: PessoaController.pessoaFieldsPersiste.fieldCliente.onCheckBox(
                          value: PessoaController.pessoaFieldsPersiste.fieldCliente.object.cliente == "S",
                          onChanged: (bool value) {
                            setState(() => PessoaController.pessoaFieldsPersiste.fieldCliente.value = value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Divider(),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('Pessoa é Fornecedor'),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        child: 
                            PessoaController.pessoaFieldsPersiste.fieldFornecedor.onCheckBox(
                              value: PessoaController.pessoaFieldsPersiste.fieldFornecedor.object.fornecedor == "S",
                              onChanged: (bool value) {
                                setState(() => PessoaController.pessoaFieldsPersiste.fieldFornecedor.value = value);
                                },
                            ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Divider(),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('Pessoa é Transportadora'),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        child: 
                            PessoaController.pessoaFieldsPersiste.fieldTransportadora.onCheckBox(
                              value: PessoaController.pessoaFieldsPersiste.fieldTransportadora.object.transportadora == "S",
                              onChanged: (bool value) {
                                setState(() => PessoaController.pessoaFieldsPersiste.fieldTransportadora.value = value);
                                },
                            ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Divider(),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('Pessoa é Colaborador'),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        child: 
                            PessoaController.pessoaFieldsPersiste.fieldColaborador.onCheckBox(
                              value: PessoaController.pessoaFieldsPersiste.fieldColaborador.object.colaborador == "S",
                              onChanged: (bool value) {
                                setState(() => PessoaController.pessoaFieldsPersiste.fieldColaborador.value = value);
                                },
                            ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Divider(),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text('Pessoa é Contador'),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        child: 
                            PessoaController.pessoaFieldsPersiste.fieldContador.onCheckBox(
                              value: PessoaController.pessoaFieldsPersiste.fieldContador.object.contador == "S",
                              onChanged: (bool value) {
                                setState(() => PessoaController.pessoaFieldsPersiste.fieldContador.value = value);
                                },
                            ),
                      ),
                    ),
                  ],
                ),

              ],
            )),
      ),
    );
  }
}
