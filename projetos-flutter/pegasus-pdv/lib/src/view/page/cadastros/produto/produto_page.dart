/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre Page relacionada à tabela [PRODUTO] 
                                                                                
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
import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';

import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_abas.dart';

import 'cardapio_persiste_page.dart';
import 'produto_ficha_tecnica_lista_page.dart';
import 'produto_persiste_page.dart';

List<Aba> _todasAsAbas = <Aba>[];

List<Aba> _getAbasAtivas() {
  List<Aba> retorno = [];
  for (var item in _todasAsAbas) {
    if (item.visible!) retorno.add(item);
  }
  return retorno;
}

class ProdutoPage extends StatefulWidget {
  final ProdutoMontado? produtoMontado;
  final String? title;
  final String? operacao;

  const ProdutoPage({this.produtoMontado, this.title, this.operacao, Key? key})
      : super(key: key);

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> with TickerProviderStateMixin {
  TabController? _abasController;
  String _estiloBotoesAba = 'iconsAndText';

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;
  FocusNode? myFocusNode;
  
  // Produto
  final GlobalKey<FormState> _produtoPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _produtoPersisteScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _cardapioPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _cardapioPersisteScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _atualizarAbas();
    _abasController = TabController(vsync: this, length: _getAbasAtivas().length);
    _abasController!.addListener(_salvarForms);
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

    WidgetsBinding.instance!.addPostFrameCallback((_) => _carregarListas());
  }

  Future _carregarListas() async {
    if (widget.produtoMontado?.produto?.ippt == 'P') {
      ProdutoController.listaProdutoFichaTecnica = await Sessao.db.produtoFichaTecnicaDao.consultarListaFiltro('ID_PRODUTO', widget.produtoMontado!.produto!.id.toString());
      ProdutoController.listaCardapioPerguntaPadraoMontado = await Sessao.db.cardapioPerguntaPadraoDao.consultarListaPerguntaMontado(widget.produtoMontado!.cardapio?.id ?? 0);
    } else {
      ProdutoController.listaProdutoFichaTecnica = [];
      ProdutoController.listaCardapioPerguntaPadraoMontado = [];
    }
    setState(() {
    });
  }

  @override
  void dispose() {
    myFocusNode!.dispose();
    _abasController!.dispose();
    super.dispose();
  }
  
  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.salvar:
        _salvarProduto();
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
          widget.title!,
          context,
          _abasController,
          _getAbasAtivas(),
          _getIndicator(),
          _estiloBotoesAba,
          _salvarProduto,
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
      pagina: ProdutoPersistePage(
        formKey: _produtoPersisteFormKey,
        scaffoldKey: _produtoPersisteScaffoldKey,
        produtoMontado: widget.produtoMontado,
        foco: myFocusNode,
        salvarProdutoCallBack: _salvarProduto,
        atualizarProdutoCallBack: _atualizarDados,
    )));
    _todasAsAbas.add(Aba(
      icon: Icons.person,
      text: 'Cardápio',
      visible: (widget.produtoMontado?.produto?.ippt == 'P' && Sessao.cnaePermiteModuloFood),
      pagina: CardapioPersistePage(
        formKey: _cardapioPersisteFormKey,
        scaffoldKey: _cardapioPersisteScaffoldKey,
        produtoMontado: widget.produtoMontado!,
        foco: myFocusNode,
        salvarProdutoCallBack: _salvarProduto,
    )));
    _todasAsAbas.add(Aba(
      icon: Icons.group,
      text: 'Ficha Técnica',
      visible: widget.produtoMontado?.produto?.ippt == 'P',
      pagina: ProdutoFichaTecnicaListaPage(
        produto: widget.produtoMontado!.produto,
        foco: myFocusNode,
        salvarProdutoCallBack: _salvarProduto,
    )));
  }

  void _atualizarDados() { // serve para atualizar algum dado após alguma ação numa página filha
    if (widget.produtoMontado?.produto?.ippt == 'P') {
      if (Sessao.cnaePermiteModuloFood) {
        _abasController = TabController(vsync: this, length: 3);
        _todasAsAbas[1].visible = true;
        _todasAsAbas[2].visible = true;
      } else {
        _abasController = TabController(vsync: this, length: 2);
        // _todasAsAbas[1].visible = true;
        _todasAsAbas[2].visible = true;
      }
    } else {
      _abasController = TabController(vsync: this, length: 1);
      _todasAsAbas[1].visible = false;
      _todasAsAbas[2].visible = false;
    }
    setState(() {
    });
  }

  bool _salvarForms() {
    // valida e salva os forms
    FormState? formProduto = _produtoPersisteFormKey.currentState;
    if (formProduto != null) {
      if (!formProduto.validate()) {
        _abasController!.animateTo(0);
		    return false;
      } else {
        _produtoPersisteFormKey.currentState?.save();
        return true;
      }
    }

    FormState? formCardapio = _cardapioPersisteFormKey.currentState;
    if (formCardapio != null) {
      if (!formCardapio.validate()) {
        _abasController!.animateTo(1);
        return false;
      } else {
        _cardapioPersisteFormKey.currentState?.save();
        return true;
      }
    }
  	return true;
  }

  void _salvarProduto() async {
    if (_salvarForms()) {  
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        bool tudoCerto = false;
        if (widget.operacao == 'A') {
          await Sessao.db.produtoDao.alterar(
            widget.produtoMontado!, 
            ProdutoController.listaProdutoFichaTecnica, 
            ProdutoController.listaProdutoImagem, 
            ProdutoController.listaCardapioPerguntaPadraoMontado
          );
          tudoCerto = true;
        } else {
          final produto = await Sessao.db.produtoDao.consultarObjetoFiltro('GTIN', widget.produtoMontado!.produto!.gtin!);
          if (produto == null) {
            await Sessao.db.produtoDao.inserir(
              widget.produtoMontado!, 
              ProdutoController.listaProdutoFichaTecnica, 
              ProdutoController.listaProdutoImagem, 
              ProdutoController.listaCardapioPerguntaPadraoMontado
            );
            tudoCerto = true;
          } else {
            showInSnackBar('Já existe um produto cadastrado com o GTIN informado.', context);
          }
        }
        if (tudoCerto) {
          Navigator.of(context).pop();
        }
      });
    } else {
        showInSnackBar("Por favor, corrija os erros apresentados antes de continuar.", context);
    }
  }

  void _excluir() {
    gerarDialogBoxExclusao(context, () async {
      widget.produtoMontado!.produto = widget.produtoMontado!.produto!.copyWith(situacao: 'I');
      Sessao.db.produtoDao.excluir(widget.produtoMontado!);
      Navigator.of(context).pop();
    },
    mensagemPersonalizada: 'Deseja marcar esse produto como Inativo? Ele não será excluído do banco de dados.');
  }

  void _alterarEstiloBotoes(String style) {
    setState(() {
      _estiloBotoesAba = style;
    });
  }

  Decoration? _getIndicator() {
    return getShapeDecorationAbaPage(_estiloBotoesAba);
  }

  Future<bool> _avisarUsuarioAlteracoesNaPagina() async {
    if (!paginaMestreDetalheFoiAlterada) {
      return true;
    } else {
      await (gerarDialogBoxFormAlterado(context));
      return false;
    }
  }
}