import 'package:fenix/src/model/banco.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';
import 'package:fenix/src/view_model/banco_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BancoPersistePage extends StatefulWidget {
  final Banco banco;
  final String title;

  const BancoPersistePage({Key key, this.banco, this.title}) : super(key: key);

  @override
  BancoPersistePageState createState() => BancoPersistePageState();
}

class BancoPersistePageState extends State<BancoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var bancoProvider = Provider.of<BancoViewModel>(context);

    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () async {
              final FormState form = _formKey.currentState;
              if (!form.validate()) {
                _autoValidate = true;
                showInSnackBar(
                    'Por favor, corrija os erros apresentados antes de continuar.');
              } else {
                form.save();
                if (widget.title == 'Banco - Editando') {
                  await bancoProvider.alterar(widget.banco);
                } else {
                  await bancoProvider.inserir(widget.banco);
                }
                Navigator.pop(context);
              }
            },
          ),
          ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          onWillPop: _avisarUsuarioFormAlterado,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      hintText: 'Informe o código FEBRABAN para o banco',
                      labelText: 'Código *',
                    ),
                    onSaved: (String value) { widget.banco.codigo = value; },
                    initialValue: widget.banco?.codigo ?? '',
                    validator: ValidaCampoFormulario.validarObrigatorioNumerico,
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      hintText: 'Informe o nome do Banco',
                      labelText: 'Nome *',
                    ),
                    onSaved: (String value) { widget.banco.nome = value; },
                    initialValue: widget.banco?.nome ?? '',
                    validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      hintText: 'Informe a URL do Banco',
                      labelText: 'URL',
                    ),
                    onSaved: (String value) { widget.banco.url = value; },
                    initialValue: widget.banco?.url ?? '',
                    onChanged: (text) {
                      _formFoiAlterado = true;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    '* indica que o campo é obrigatório',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formFoiAlterado)
      return true;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alterações não Concluídas'),
          content: const Text('Deseja fechar o formulário e perder as alteraçõe?'),
          actions: <Widget> [
            FlatButton(
              child: const Text('Sim'),
              onPressed: () { Navigator.of(context).pop(true); },
            ),
            FlatButton(
              child: const Text('Não'),
              onPressed: () { Navigator.of(context).pop(false); },
            ),
          ],
        );
      },
    ) ?? false;
  }

}