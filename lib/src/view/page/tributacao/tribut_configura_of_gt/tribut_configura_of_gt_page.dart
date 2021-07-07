/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre Page relacionada à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/widgets_abas.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

import 'tribut_configura_of_gt_persiste_page.dart';
import 'tribut_cofins_persiste_page.dart';
import 'tribut_icms_uf_persiste_page.dart';
import 'tribut_pis_persiste_page.dart';

List<Aba> _todasAsAbas = <Aba>[];

List<Aba> _getAbasAtivas() {
  List<Aba> retorno = [];
  for (var item in _todasAsAbas) {
    if (item.visible) retorno.add(item);
  }
  return retorno;
}

class TributConfiguraOfGtPage extends StatefulWidget {
  final TributConfiguraOfGtMontado tributConfiguraOfGtMontado;
  final String title;
  final String operacao;

  TributConfiguraOfGtPage({this.tributConfiguraOfGtMontado, this.title, this.operacao, Key key})
      : super(key: key);

  @override
  _TributConfiguraOfGtPageState createState() => _TributConfiguraOfGtPageState();
}

class _TributConfiguraOfGtPageState extends State<TributConfiguraOfGtPage> with SingleTickerProviderStateMixin {
  TabController _abasController;
  String _estiloBotoesAba = 'iconsAndText';

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;
  FocusNode myFocusNode;
  
  // TributConfiguraOfGt
  final GlobalKey<FormState> _tributConfiguraOfGtPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _tributConfiguraOfGtPersisteScaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _tributCofinsPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _tributCofinsPersisteScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _tributPisPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _tributPisPersisteScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _tributIcmsUfPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _tributIcmsUfPersisteScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _atualizarAbas();
    _abasController = TabController(vsync: this, length: _getAbasAtivas().length);
    _abasController.addListener(_salvarForms);
    paginaMestreDetalheFoiAlterada = false; // vamos controlar as alterações nas paginas filhas aqui para alertar ao usuario sobre possivel perda de dados
  
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );

    _shortcutMap = getAtalhosPersistePage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _abasController.dispose();
    super.dispose();
  }
  
  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.salvar:
        _salvarTributConfiguraOfGt();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: false, //o foco deve ser enviado para as páginas filhas e elas devem chamar o método salvar
        child: getScaffoldAbaPage(
          widget.title,
          context,
          _abasController,
          _getAbasAtivas(),
          _getIndicator(),
          _estiloBotoesAba,
          _salvarTributConfiguraOfGt,
          _alterarEstiloBotoes,
          _avisarUsuarioAlteracoesNaPagina,
          comBotaoExclusao: widget.operacao == 'A',
          excluir: _excluir,
        ),
      ),
    );
  }
  
  void _atualizarAbas() {
    _todasAsAbas.clear();
    // a primeira aba sempre é a de Persistencia da tabela Mestre
    _todasAsAbas.add(Aba(
      icon: Icons.receipt,
      text: Constantes.tituloAbaDetalhePrincipal,
      visible: true,
      pagina: TributConfiguraOfGtPersistePage(
        formKey: _tributConfiguraOfGtPersisteFormKey,
        scaffoldKey: _tributConfiguraOfGtPersisteScaffoldKey,
        tributConfiguraOfGtMontado: widget.tributConfiguraOfGtMontado,
        foco: myFocusNode,
        salvarTributConfiguraOfGtCallBack: _salvarTributConfiguraOfGt,
        atualizarTributConfiguraOfGtCallBack: _atualizarDados,
    )));
    _todasAsAbas.add(Aba(
      icon: Icons.person,
      text: 'ICMS',
      visible: true,
      pagina: TributIcmsUfPersistePage(
        formKey: _tributIcmsUfPersisteFormKey,
        scaffoldKey: _tributIcmsUfPersisteScaffoldKey,
        tributConfiguraOfGtMontado: widget.tributConfiguraOfGtMontado,
        foco: myFocusNode,
        salvarTributConfiguraOfGtCallBack: _salvarTributConfiguraOfGt,
    )));
    _todasAsAbas.add(Aba(
      icon: Icons.person,
      text: 'Cofins',
      visible: true,
      pagina: TributCofinsPersistePage(
        formKey: _tributCofinsPersisteFormKey,
        scaffoldKey: _tributCofinsPersisteScaffoldKey,
        tributConfiguraOfGtMontado: widget.tributConfiguraOfGtMontado,
        foco: myFocusNode,
        salvarTributConfiguraOfGtCallBack: _salvarTributConfiguraOfGt,
    )));
    _todasAsAbas.add(Aba(
      icon: Icons.person,
      text: 'Pis',
      visible: true,
      pagina: TributPisPersistePage(
        formKey: _tributPisPersisteFormKey,
        scaffoldKey: _tributPisPersisteScaffoldKey,
        tributConfiguraOfGtMontado: widget.tributConfiguraOfGtMontado,
        foco: myFocusNode,
        salvarTributConfiguraOfGtCallBack: _salvarTributConfiguraOfGt,
    )));
  }

  void _atualizarDados() { // serve para atualizar algum dado após alguma ação numa página filha
    setState(() {
		// implemente este método de acordo com a necessidade
    });
  }

  bool _salvarForms() {  
    // valida e salva o form TributConfiguraOfGtDetalhe
    FormState formTributConfiguraOfGt = _tributConfiguraOfGtPersisteFormKey.currentState;
    if (formTributConfiguraOfGt != null) {
      if (!formTributConfiguraOfGt.validate()) {
        _abasController.animateTo(0);
		    return false;
      } else {
        _tributConfiguraOfGtPersisteFormKey.currentState?.save();
		    return true;
      }
    }

    // valida e salva os forms OneToOne
    FormState formTributIcmsUf = _tributIcmsUfPersisteFormKey.currentState;
    if (formTributIcmsUf != null) {
      if (!formTributIcmsUf.validate()) {
        _abasController.animateTo(1);
        return false;
      } else {
        _tributIcmsUfPersisteFormKey.currentState?.save();
        return true;
      }
    }
    FormState formTributCofins = _tributCofinsPersisteFormKey.currentState;
    if (formTributCofins != null) {
      if (!formTributCofins.validate()) {
        _abasController.animateTo(1);
        return false;
      } else {
        _tributCofinsPersisteFormKey.currentState?.save();
        return true;
      }
    }
    FormState formTributPis = _tributPisPersisteFormKey.currentState;
    if (formTributPis != null) {
      if (!formTributPis.validate()) {
        _abasController.animateTo(1);
        return false;
      } else {
        _tributPisPersisteFormKey.currentState?.save();
        return true;
      }
    }
	
	  return true;
  }

  void _salvarTributConfiguraOfGt() async {
    if (_salvarForms()) {  
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        if (widget.operacao == 'A') {
          await Sessao.db.tributConfiguraOfGtDao.alterar(widget.tributConfiguraOfGtMontado);
        } else {
          await Sessao.db.tributConfiguraOfGtDao.inserir(widget.tributConfiguraOfGtMontado);
        }
        Navigator.pop(context);
      });
    } else {
      showInSnackBar("Por favor, corrija os erros apresentados antes de continuar.", context);
    }
  }

  void _excluir() {
    gerarDialogBoxExclusao(context, () async {
      await Sessao.db.tributConfiguraOfGtDao.excluir(widget.tributConfiguraOfGtMontado);
      Navigator.of(context).pop();
  	  showInSnackBar("Registro excluído com sucesso!", context, corFundo: Colors.green);
    });
  }

  void _alterarEstiloBotoes(String style) {
    setState(() {
      _estiloBotoesAba = style;
    });
  }

  Decoration _getIndicator() {
    return getShapeDecorationAbaPage(_estiloBotoesAba);
  }

  Future<bool> _avisarUsuarioAlteracoesNaPagina() async {
    if (!paginaMestreDetalheFoiAlterada) return true;
    return await gerarDialogBoxFormAlterado(context);
  }
}