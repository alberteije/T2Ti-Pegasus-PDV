/*
Title: T2Ti ERP 3.0                                                                
Description: AbaMestre Page relacionada à tabela [NFE_CABECALHO] 
                                                                                
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/service/service.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/page/pdf_page.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_abas.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

import 'nfe_cabecalho_persiste_page.dart';
import 'nfe_detalhe_lista_page.dart';

List<Aba> _todasAsAbas = <Aba>[];

List<Aba> _getAbasAtivas() {
  List<Aba> retorno = [];
  for (var item in _todasAsAbas) {
    if (item.visible) retorno.add(item);
  }
  return retorno;
}

class NfeCabecalhoPage extends StatefulWidget {
  final NfeCabecalhoMontado nfeCabecalhoMontado;
  final String title;

  NfeCabecalhoPage({this.nfeCabecalhoMontado, this.title, Key key})
      : super(key: key);

  @override
  _NfeCabecalhoPageState createState() => _NfeCabecalhoPageState();
}

class _NfeCabecalhoPageState extends State<NfeCabecalhoPage> with SingleTickerProviderStateMixin {
  TabController _abasController;
  String _estiloBotoesAba = 'iconsAndText';

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;
  FocusNode myFocusNode;
  
  // NfeCabecalho
  final GlobalKey<FormState> _nfeCabecalhoPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _nfeCabecalhoPersisteScaffoldKey = GlobalKey<ScaffoldState>();

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
        _salvarNfeCabecalho();
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
          _salvarNfeCabecalho,
          _alterarEstiloBotoes,
          _avisarUsuarioAlteracoesNaPagina,
          botoesPersonalizados: _getBotoesPersonalizados(),
        ),
      ),
    );
  }
  
  List<Widget> _getBotoesPersonalizados() {
    if (Biblioteca.isTelaPequena(context)) {
      return <Widget>[
        getBotaoTelaPequena(
          tooltip: 'Imprimir DANFE',
          icone: Icon(Icons.print),
          onPressed: _baixarDanfe,
        ),
      ];
    } else {
      return <Widget>[
        getBotaoTelaGrande(
          texto: 'Imprimir DANFE',
          icone: Icon(Icons.print),
          onPressed: _baixarDanfe,
        ),
      ];
    }
  }

  void _baixarDanfe() async {
    NfceAcbrService servicoNfce = NfceAcbrService();
    try {
      await servicoNfce.conectar(
        context, 
        formaEmissao: '1',
        operacao: 'IMPRIMIR_DANFE', 
        chaveAcesso: widget.nfeCabecalhoMontado.nfeCabecalho.chaveAcesso,
        funcaoDeCallBack: _imprimirDanfe, 
      ).then((socket) {
        socket.write('NFE.ImprimirDANFEPDF("' 
          + Sessao.configuracaoNfce.caminhoSalvarXml 
          + Biblioteca.formatarDataAAAAMM(DateTime.now())
          + '\\NFCe\\'
          + widget.nfeCabecalhoMontado.nfeCabecalho.chaveAcesso 
          + '-nfe.xml")\r\n.\r\n');
      });                 
    } catch (e) {
      gerarDialogBoxErro(context, 'Ocorreu um problema ao tentar realizar o procedimento: ' + e.toString());
    }   

  }

  Future _imprimirDanfe(String danfeBase64) async {
    var decodeB64 = base64.decode(danfeBase64); 
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => PdfPage(
          arquivoPdf: decodeB64, title: 'NFC-e')
        )
      ).then(
        (value) {
        }
      );          
  }   

  void _atualizarAbas() {
    _todasAsAbas.clear();
    // a primeira aba sempre é a de Persistencia da tabela Mestre
    _todasAsAbas.add(Aba(
      icon: Icons.receipt,
      text: Constantes.tituloAbaDetalhePrincipal,
      visible: true,
      pagina: NfeCabecalhoPersistePage(
        formKey: _nfeCabecalhoPersisteFormKey,
        scaffoldKey: _nfeCabecalhoPersisteScaffoldKey,
        nfeCabecalhoMontado: widget.nfeCabecalhoMontado,
        foco: myFocusNode,
    )));
    _todasAsAbas.add(Aba(
      icon: Icons.group,
      text: 'Itens da Nf-e',
      visible: true,
      pagina: NfeDetalheListaPage(
        nfeCabecalhoMontado: widget.nfeCabecalhoMontado,
        foco: myFocusNode,
    )));    
  }

  bool _salvarForms() {
	  
    // valida e salva o form NfeCabecalhoDetalhe
    FormState formNfeCabecalho = _nfeCabecalhoPersisteFormKey.currentState;
    if (formNfeCabecalho != null) {
      if (!formNfeCabecalho.validate()) {
        _abasController.animateTo(0);
		return false;
      } else {
        _nfeCabecalhoPersisteFormKey.currentState?.save();
		return true;
      }
    }
	
	return true;
  }

  void _salvarNfeCabecalho() async {
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