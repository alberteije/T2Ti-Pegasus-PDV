import 'package:flutter/material.dart';
import 'package:mvc_application/mvc.dart';
import 'package:t2ti_erp_fenix/src/controller/pessoa_controller.dart';

class PessoaJuridicaPersistePage extends StatefulWidget {
  PessoaJuridicaPersistePage({this.pessoaJuridica, Key key}) : super(key: key);
  final Object pessoaJuridica;

  @override
  State createState() => _PessoaJuridicaPersisteState();
}

class _PessoaJuridicaPersisteState extends StateMVC<PessoaJuridicaPersistePage> {
  @override
  void initState() {
    super.initState();
    PessoaController.pessoaJuridicaFieldsPersiste.init(widget.pessoaJuridica);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
            key: PessoaController.pessoaJuridicaFieldsPersiste.formKeyPessoaJuridicaPersistePage,
            child: ListView(
              children: [
                PessoaController.pessoaJuridicaFieldsPersiste.fieldCnpj.textFormField,
                PessoaController.pessoaJuridicaFieldsPersiste.fieldNomeFantasia.textFormField,
                PessoaController.pessoaJuridicaFieldsPersiste.fieldInscricaoEstadual.textFormField,
                PessoaController.pessoaJuridicaFieldsPersiste.fieldInscricaoMunicipal.textFormField,
                PessoaController.pessoaJuridicaFieldsPersiste.fieldDataConstituicao.textFormField,
                PessoaController.pessoaJuridicaFieldsPersiste.fieldTipoRegime.textFormField,
                PessoaController.pessoaJuridicaFieldsPersiste.fieldCrt.textFormField,
              ],
            )),
      ),
    );
  }
}
