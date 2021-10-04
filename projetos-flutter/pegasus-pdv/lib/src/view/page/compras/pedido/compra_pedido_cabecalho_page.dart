/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre Page relacionada à tabela [COMPRA_PEDIDO_CABECALHO] 
                                                                                
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
import 'package:pegasus_pdv/src/controller/controller.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/widgets_abas.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

import 'compra_pedido_cabecalho_persiste_page.dart';
import 'compra_pedido_detalhe_lista_page.dart';

List<Aba> _todasAsAbas = <Aba>[];

List<Aba> _getAbasAtivas() {
  List<Aba> retorno = [];
  for (var item in _todasAsAbas) {
    if (item.visible) retorno.add(item);
  }
  return retorno;
}

class CompraPedidoCabecalhoPage extends StatefulWidget {
  final CompraPedidoCabecalhoMontado compraPedidoCabecalhoMontado;
  final String title;
  final String operacao;

  // static CompraPedidoCabecalho compraPedidoCabecalho;
  // static List<CompraDetalhe> listaCompraDetalhe = [];
  static bool descontoNosItems = false;

  CompraPedidoCabecalhoPage({this.compraPedidoCabecalhoMontado, this.title, this.operacao, Key key}): super(key: key);

  @override
  _CompraPedidoCabecalhoPageState createState() => _CompraPedidoCabecalhoPageState();
}

class _CompraPedidoCabecalhoPageState extends State<CompraPedidoCabecalhoPage> with SingleTickerProviderStateMixin {
  TabController _abasController;
  String _estiloBotoesAba = 'iconsAndText';

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;
  FocusNode myFocusNode;
  
  // CompraPedidoCabecalho
  final GlobalKey<FormState> _compraPedidoCabecalhoPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _compraPedidoCabecalhoPersisteScaffoldKey = GlobalKey<ScaffoldState>();

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
    CompraPedidoCabecalhoController.compraPedidoCabecalho = widget.compraPedidoCabecalhoMontado.compraPedidoCabecalho;
    if (CompraPedidoCabecalhoController.compraPedidoCabecalho == null) {
      CompraPedidoCabecalhoController.compraPedidoCabecalho = 
        CompraPedidoCabecalho(
          id: null, 
          dataPedido: DateTime.now(), 
          idColaborador: widget.compraPedidoCabecalhoMontado.colaborador?.id,
        );
    }
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
        _salvarCompraPedidoCabecalho();
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
          _salvarCompraPedidoCabecalho,
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
      pagina: CompraPedidoCabecalhoPersistePage(
        formKey: _compraPedidoCabecalhoPersisteFormKey,
        scaffoldKey: _compraPedidoCabecalhoPersisteScaffoldKey,
        compraPedidoCabecalhoMontado: widget.compraPedidoCabecalhoMontado,
        foco: myFocusNode,
        salvarCompraPedidoCabecalhoCallBack: _salvarCompraPedidoCabecalho,
        atualizarCompraPedidoCabecalhoCallBack: _atualizarDados,
    )));
    _todasAsAbas.add(Aba(
      icon: Icons.group,
      text: 'Itens do Pedido',
      visible: true,
      pagina: CompraPedidoDetalheListaPage(
        compraPedidoCabecalhoMontado: widget.compraPedidoCabecalhoMontado,
        foco: myFocusNode,
        salvarCompraPedidoCabecalhoCallBack: _salvarCompraPedidoCabecalho,
    )));
  }

  void _atualizarDados() { // serve para atualizar algum dado após alguma ação numa página filha
    setState(() {
		// implemente este método de acordo com a necessidade
    });
  }

  bool _salvarForms() {
    // valida e salva o form CompraPedidoCabecalhoDetalhe
    FormState formCompraPedidoCabecalho = _compraPedidoCabecalhoPersisteFormKey.currentState;
    if (formCompraPedidoCabecalho != null) {
      if (!formCompraPedidoCabecalho.validate()) {
        _abasController.animateTo(0);
		    return false;
      } else {
        _compraPedidoCabecalhoPersisteFormKey.currentState?.save();
		    return true;
      }
    }

    return true;
  }

  void _salvarCompraPedidoCabecalho() async {
	  if (_salvarForms()) {  
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        if (widget.operacao == 'A') {
          await Sessao.db.compraPedidoCabecalhoDao.alterar(CompraPedidoCabecalhoController.compraPedidoCabecalho, CompraPedidoCabecalhoController.listaCompraDetalhe);
        } else {
          await Sessao.db.compraPedidoCabecalhoDao.inserir(CompraPedidoCabecalhoController.compraPedidoCabecalho, CompraPedidoCabecalhoController.listaCompraDetalhe);
        }
        Navigator.pop(context);
      });
    } else {
      showInSnackBar("Por favor, corrija os erros apresentados antes de continuar.", context);
    }
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

  void _excluir() {
    gerarDialogBoxExclusao(context, () async {
      Sessao.db.compraPedidoCabecalhoDao.excluir(CompraPedidoCabecalhoController.compraPedidoCabecalho, CompraPedidoCabecalhoController.listaCompraDetalhe);
      Navigator.of(context).pop();
    }, mensagemPersonalizada: 'Deseja excluir o pedido? Isso poderá causar alterações no estoque e no financeiro!');
  }  


}