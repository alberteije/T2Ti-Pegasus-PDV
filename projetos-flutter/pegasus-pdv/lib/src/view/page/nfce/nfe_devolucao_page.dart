/*
Title: T2Ti ERP 3.0                                                                
Description: Page relacionada à devolução de mercadoria
                                                                                
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
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';

import 'package:pegasus_pdv/src/database/database_classes.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_desktop_web.dart';
import 'package:pegasus_pdv/src/service/service.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/page/pdf_page.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_abas.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

import 'nfe_devolucao_persiste_page.dart';


List<Aba> _todasAsAbas = <Aba>[];

List<Aba> _getAbasAtivas() {
  List<Aba> retorno = [];
  for (var item in _todasAsAbas) {
    if (item.visible!) retorno.add(item);
  }
  return retorno;
}

class NfeDevolucaoPage extends StatefulWidget {
  final NfeCabecalhoMontado? nfeCabecalhoMontado;
  final String? title;

  const NfeDevolucaoPage({this.nfeCabecalhoMontado, this.title, Key? key})
      : super(key: key);

  @override
  NfeDevolucaoPageState createState() => NfeDevolucaoPageState();
}

class NfeDevolucaoPageState extends State<NfeDevolucaoPage> with SingleTickerProviderStateMixin {
  TabController? _abasController;
  String _estiloBotoesAba = 'iconsAndText';

  Map<LogicalKeySet, Intent>? _shortcutMap; 
  Map<Type, Action<Intent>>? _actionMap;
  FocusNode? myFocusNode;
  
  Map<String, bool>? itensSelecionados = {};

  // NfeCabecalho
  final GlobalKey<FormState> _nfeDevolucaoPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _nfeDevolucaoPersisteScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _atualizarAbas();
    _abasController = TabController(vsync: this, length: _getAbasAtivas().length);
    //_abasController!.addListener(_salvarForms);
    paginaMestreDetalheFoiAlterada = false; // vamos controlar as alterações nas paginas filhas aqui para alertar ao usuario sobre possivel perda de dados
  
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );

    _shortcutMap = getAtalhosPersistePage();

    /*_actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };*/

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode!.dispose();
    _abasController!.dispose();
    super.dispose();
  }
  
  /*void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.salvar:
        _salvarNfeCabecalho();
        break;
      default:
        break;
    }
  }*/

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
          _devolverItens,
          _alterarEstiloBotoes,
          _avisarUsuarioAlteracoesNaPagina,
          botoesPersonalizados: _getBotoesPersonalizados(),
        ),
      ),
    );
  }
  
  List<Widget> _getBotoesPersonalizados() {
    if (Biblioteca.isTelaPequena(context)!) {
      return <Widget>[
        getBotaoTelaPequena(
          tooltip: 'Devolver Itens',
          icone: const Icon(Icons.print),
          onPressed: _devolverItens,
        ),
      ];
    } else {
      return <Widget>[
        getBotaoTelaGrande(
          texto: 'Devolver Itens',
          icone: const Icon(Icons.print),
          onPressed: _devolverItens,
        ),
      ];
    }
  }

  void _devolverItens() {
    gerarDialogBoxConfirmacao(context, "Confirma devolução dos itens selecionados?", _processaDevolucaoItem);
  }

  void _processaDevolucaoItem() async {
    int qtdeSelecionada = 0;
    itensSelecionados?.forEach((key, value) {
      if (value && key != "-1") {
        qtdeSelecionada++;
      }
    });
    if (qtdeSelecionada == 0) {
      showInSnackBar('Nenhum item foi selecionado para devolução', context);
    } else {
      // verificar se a NFC-e já foi cancelada
      // verificar se foi emitida uma NFC-e para a venda selecionada
      if (widget.nfeCabecalhoMontado?.nfeCabecalho?.statusNota != "4") {
        gerarDialogBoxErro(context, "NFC-e não autorizada ou já cancelada.");
      } else {
        List<int> listaDetalheDevolucao = [];
        for (var nfeDetalheMontado in widget.nfeCabecalhoMontado!.listaNfeDetalheMontado!) {
          if (itensSelecionados![nfeDetalheMontado.nfeDetalhe!.id.toString()] == true) {
            listaDetalheDevolucao.add(nfeDetalheMontado.nfeDetalhe!.id!);
          }
        }
        bool gerouDadosOk = await NfceController.gerarDadosNfeDevolucaoMercadoria(widget.nfeCabecalhoMontado!.nfeCabecalho!.idPdvVendaCabecalho!, listaDetalheDevolucao);
        if (!mounted) return;
        if (gerouDadosOk) {
          Sessao.ultimoIniNfceEnviado = await NfceController.montarNfeDevolucao(widget.nfeCabecalhoMontado!.nfeCabecalho!.chaveAcesso!);
          final bytesNfce = utf8.encode(Sessao.ultimoIniNfceEnviado);      
          NfceService nfceService = NfceService();
          final retorno = await nfceService.emitirNfce(
            base64.encode(bytesNfce),
            Sessao.numeroNfce!.numero!.toString()
          );  
          if (!mounted) return;      
          if (retorno != null) {
            if (retorno is String) {
              Sessao.fecharDialogBoxEspera(context);
              gerarDialogBoxErro(context, 'Ocorreu um problema na geração da NF-e: \n$retorno');          
            } else if (retorno is Uint8List) {
              await NfceController.atualizarDadosNfce(chaveAcesso: widget.nfeCabecalhoMontado!.nfeCabecalho!.chaveAcesso, statusNota: '4'); // 4=autorizada
              await NfceController.marcaItemDevolvido(listaDetalheDevolucao);

              _imprimirDanfe(retorno);
            }
          } else {
            Sessao.fecharDialogBoxEspera(context);
          }
        } else {
          gerarDialogBoxErro(context, 'Ocorreu um problema na geração da NF-e');
        }
      }
    }
  }

  void _imprimirDanfe(Uint8List danfe) {
    Sessao.fecharDialogBoxEspera(context);
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => PdfPage(
          arquivoPdf: danfe, title: 'NF-e Devolução Mercadoria')
        )
      ).then(
        (value) {
          Navigator.pop(context);
        }
      );          
  }

  void _atualizarAbas() {
    _todasAsAbas.clear();
    // a primeira aba sempre é a de Persistencia da tabela Mestre
    _todasAsAbas.add(Aba(
      icon: Icons.receipt,
      text: "Selecione os itens para devolução",
      visible: true,
      pagina: NfeDevolucaoPersistePage(
        formKey: _nfeDevolucaoPersisteFormKey,
        scaffoldKey: _nfeDevolucaoPersisteScaffoldKey,
        nfeCabecalhoMontado: widget.nfeCabecalhoMontado,
        itensSelecionados: itensSelecionados,
        foco: myFocusNode,
    )));
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
    return false;
  }
}