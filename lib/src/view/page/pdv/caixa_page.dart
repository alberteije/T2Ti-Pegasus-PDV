/*
Title: T2Ti ERP Pegasus                                                                
Description: Tela do caixa do Pegasus PDV
                                                                                
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
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:bottomreveal/bottomreveal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pegasus_pdv/src/controller/pdv/nfce_controller.dart';
import 'package:charcode/ascii.dart';

import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';
import 'package:pegasus_pdv/src/service/service.dart';

import 'package:pegasus_pdv/src/view/menu/menu_lateral_pdv.dart';
import 'package:pegasus_pdv/src/view/login/registro_page.dart';
import 'package:pegasus_pdv/src/view/page/page.dart';
import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';
import 'package:pegasus_pdv/src/view/shared/page/pdf_page.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_caixa.dart';
import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';


class CaixaPage extends StatefulWidget {
  @override
  _CaixaPageState createState() => _CaixaPageState();
}

class _CaixaPageState extends State<CaixaPage> {
  final BottomRevealController _menuController = BottomRevealController();
  final _pesquisaProdutoController = TextEditingController();
  final _focusNode = FocusNode();

  String _codigoDeBarras;
  double _quantidadeInformada = 1;
  bool _fornecidoDescontoNoItem = false;
  String _tituloJanela = Constantes.tituloCaixaAberto;
  bool _abriuDialogBoxEspera = false;

  Produto _produto = Produto(id: null);

  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosCaixa();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) => _verificarRegistro());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.identificarVendedor:
        _identificarVendedor();
        break;
      case AtalhoTelaType.identificarCliente:
        _identificarCliente();
        break;
      case AtalhoTelaType.acessarOpcoesGerenciais:
        _acessarOpcoesGerenciais();
        break;
      case AtalhoTelaType.recuperarVenda:
        _recuperarVenda();
        break;
      case AtalhoTelaType.concederDesconto:
        _concederDesconto();
        break;
      case AtalhoTelaType.cancelar:
        _cancelarVenda();
        break;
      case AtalhoTelaType.confirmar:
        _salvarVenda();
        break;
      case AtalhoTelaType.importarProduto:
        _importarProduto();
        break;
      case AtalhoTelaType.encerrarVenda:
        _encerrarVenda();
        break;
      case AtalhoTelaType.escape:
        _fecharMenus();
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
        autofocus: true,
        child: Scaffold(
          key: _keyScaffold,
          endDrawer: MenuLateralPDV(),
          appBar: AppBar(
            title: Text(_tituloJanela),
            actions: _getBotoesAppBar(context: context),
            ),
          body: BottomReveal(
            openIcon: Icons.menu,
            closeIcon: Icons.close,
            revealWidth: Biblioteca.isTelaPequena(context) ? 90 : 100,
            revealHeight: Biblioteca.isTelaPequena(context) ? 120 : 100,
            backColor: Colors.grey.shade600,
            frontColor: Colors.grey.shade300,
            rightContent: menuInternoDireita(context),
            bottomContent: menuInternoRodape(context),
            controller: _menuController,
            body: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: TextField(
                            focusNode: _focusNode,
                            // autofocus: true,
                            controller: _pesquisaProdutoController,
                            onSubmitted: (value) { _localizarProduto(value); _pesquisaProdutoController.text = ''; },
                            decoration: getInputDecoration(
                              'Pesquise Nome ou Código de Barras',
                              'Pesquisar Produto',
                              false),
                            onChanged: (text) {
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: IconButton(
                          tooltip: 'Pesquisar Produto',
                          icon: ViewUtilLib.getIconBotaoLookup(),
                          onPressed: () {
                            _localizarProduto(_pesquisaProdutoController.text); _pesquisaProdutoController.text = '';
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: Sessao.listaVendaAtualDetalhe.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          _excluirProduto(index: index, perguntaAntes: false);
                        },
                        background: Container(color: Colors.red),
                        child: itensDaVenda(context, index, onDelete: () => _excluirProduto(index: index, perguntaAntes: true)),
                      );
                    },
                  ),
                ),
                clienteSelecionado(context),
                vendedorSelecionado(context),
                rodape(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

// #region widgets Caixa

  Widget itensDaVenda(BuildContext context, int index, {Function onDelete}) {
    var _item = index + 1;
    return Card(child:
      ListTile(
        minLeadingWidth: Biblioteca.isTelaPequena(context) ? 0 : 20,
        onTap: () {
          Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (BuildContext context) => ProdutoDetalhePage(title: 'Detalhe do Produto', item: Sessao.listaVendaAtualDetalhe[index])))
            .then((_) {
              if (Sessao.listaVendaAtualDetalhe[index].pdvVendaDetalhe.quantidade <= 0) {
                _excluirProduto(index: index, perguntaAntes: false);
              }
              else {
                setState(() {
                  _atualizarTotais();
                });
              }
            });
        },
        title: 
        Text(montarDescricaoItem(index),
          style: 
          (Sessao.listaVendaAtualDetalhe[index].pdvVendaDetalhe.valorDesconto ?? 0) > 0 
          ? TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.red, fontStyle: FontStyle.italic)
          : TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
        leading: Text(
          _item.toString(),
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
        ),
        subtitle: Row(          
          mainAxisAlignment: Biblioteca.isTelaPequena(context) ? MainAxisAlignment.center : MainAxisAlignment.end,
          children: <Widget>[
            // valor unitário
            getCardValorUnitario(context: context, valorUnitario: Sessao.listaVendaAtualDetalhe[index].pdvVendaDetalhe.valorUnitario),
            SizedBox(
              width: 8,
            ),
            getBotaoDecrementaCaixa(decrementar: () {_decrementarItem(item: Sessao.listaVendaAtualDetalhe[index]);} ),
            // quantidade e unidade
            getCardQuantidade(context: context, quantidade: Sessao.listaVendaAtualDetalhe[index].pdvVendaDetalhe.quantidade),
            getBotaoIncrementaCaixa(incrementar: () {_incrementarItem(item: Sessao.listaVendaAtualDetalhe[index]);} ),
            SizedBox(
              width: 8,
            ),
            // valor total
            getCardValorTotal(context: context, valorTotal: Sessao.listaVendaAtualDetalhe[index].pdvVendaDetalhe.valorTotal),
          ],
        ),
        trailing: 
          Biblioteca.isTelaPequena(context)
          ? null
          : IconButton(
            onPressed: onDelete,
            color: Colors.red,
            icon: Icon(Icons.delete),
            iconSize: 20,
          ),
      ),
    );
  }

  String montarDescricaoItem(int index) {
    if ((Sessao.listaVendaAtualDetalhe[index].pdvVendaDetalhe.valorDesconto ?? 0) > 0 ) {
      String retorno = Sessao.listaVendaAtualDetalhe[index].produto.gtin + ' - ' + Sessao.listaVendaAtualDetalhe[index].produto.nome;
      retorno = retorno + ' [desconto: (' + 
      Constantes.formatoDecimalValor.format(Sessao.listaVendaAtualDetalhe[index].pdvVendaDetalhe.taxaDesconto ?? 0) + '%) R\$ ' + 
      Constantes.formatoDecimalValor.format(Sessao.listaVendaAtualDetalhe[index].pdvVendaDetalhe.valorDesconto ?? 0) + ']';
      return retorno;
    } else {
      return Sessao.listaVendaAtualDetalhe[index].produto.gtin + ' - ' + Sessao.listaVendaAtualDetalhe[index].produto.nome;
    }
  }

  Widget clienteSelecionado(BuildContext context) {
    if (Sessao.vendaAtual.nomeCliente != null || Sessao.vendaAtual.cpfCnpjCliente != null) {
      return Material(
        color: Colors.blueGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
              child: Text(
                "Cliente: " + (Sessao.vendaAtual.nomeCliente ?? '') + ' - CPF: ' + (Sessao.vendaAtual.cpfCnpjCliente ?? ''),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      return Material();
    }
  }

  Widget vendedorSelecionado(BuildContext context) {
    if (Sessao.vendaAtual.idColaborador != null) {
      return Material(
        color: Colors.blueGrey.shade900,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
              child: Text(
                "Vendedor: " + Sessao.vendaAtual.idColaborador.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      return Material();
    }
  }

  Widget rodape(BuildContext context) {
    return Material(
      color: Colors.lightBlue.shade900,
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 0, left: 10, right: 10),
                    child: Text(
                      "Itens: " + Sessao.listaVendaAtualDetalhe.length.toString(), 
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 15, left: 10, right: 10),
                child: Text(
                  Constantes.formatoDecimalValor.format(Sessao.vendaAtual.valorFinal ?? 0),
                  style: 
                  (Sessao.vendaAtual.valorDesconto ?? 0) > 0 
                  ? TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.amberAccent, fontStyle: FontStyle.italic)
                  : TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.yellow),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 90, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: Biblioteca.isTelaPequena(context) ? 130 : 150,
                  child:ElevatedButton(
                    child: Text("Encerrar Venda", 
                      style: Biblioteca.isTelaPequena(context) ? TextStyle(fontSize: 15) : TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      padding: Biblioteca.isTelaPequena(context) 
                                ? EdgeInsets.only(left: 6.0, right: 6.0, top: 12.0, bottom: 12.0) 
                                : EdgeInsets.all(15.0),
                      primary: Colors.green.shade700, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    ),
                    onPressed: () {
                      _encerrarVenda();
                    },
                  ),
                ),
              ],
            )
          ),        
        ],
      ),
    );
  }

  Row menuInternoRodape(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        getBotaoInternoCaixa(
          texto: Constantes.botaoCaixaVendedor,
          icone: FontAwesomeIcons.userTie,
          tamanhoIcone: 35,
          corBotao: Colors.black54,
          paddingAll: 15,
          onPressed: () {
            _identificarVendedor();
          },
        ),
        const SizedBox(width: 10.0),
        getBotaoInternoCaixa(
          texto: Constantes.botaoCaixaCliente,
          icone: FontAwesomeIcons.userTag,
          tamanhoIcone: 35,
          corBotao: Colors.black45,
          paddingAll: 15,
          onPressed: () {
            _identificarCliente();
          },
        ),
        const SizedBox(width: 10.0),
        getBotaoInternoCaixa(
          texto: Constantes.botaoCaixaOpcoes,
            icone: FontAwesomeIcons.portrait,
            tamanhoIcone: 35,
            corBotao: Colors.black38,
            paddingAll: 15,
            onPressed: () {
              _acessarOpcoesGerenciais();
            }),
      ],
    );
  }

  FittedBox menuInternoDireita(BuildContext context) {
    return FittedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getBotaoInternoCaixa(
              texto: Constantes.botaoCaixaSalvar,
              icone: FontAwesomeIcons.save,
              tamanhoIcone: 30,
              corBotao: Colors.blue.shade900,
              paddingAll: 0,
              onPressed: () {
                _salvarVenda();
              }),
          const SizedBox(height: 10.0),
          getBotaoInternoCaixa(
              texto: Constantes.botaoCaixaCancelar,
              icone: FontAwesomeIcons.windowClose,
              tamanhoIcone: 30,
              corBotao: Colors.red.shade900,
              paddingAll: 0,
              onPressed: () {
                _cancelarVenda();
              }),
          const SizedBox(height: 10.0),
          getBotaoInternoCaixa(
            texto: Constantes.botaoCaixaRecuperar,
            icone: FontAwesomeIcons.redo,
            tamanhoIcone: 30,
            corBotao: Colors.orange.shade900,
            paddingAll: 0,
            onPressed: () {
              _recuperarVenda();
            },
          ),
          const SizedBox(height: 10.0),
          getBotaoInternoCaixa(
              texto: Constantes.botaoCaixaDesconto,
              icone: FontAwesomeIcons.percentage,
              tamanhoIcone: 30,
              corBotao: Colors.green.shade900,
              paddingAll: 0,
              onPressed: () {
                _concederDesconto();
              }),
        ],
      )
    );
  }

  List<Widget> _getBotoesAppBar({BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
      IconButton(
        icon: ViewUtilLib.getIconBotaoInserir(),
        tooltip: Constantes.botaoCaixaImportarProdutoDica,
        onPressed: () {
          _importarProduto();
        },
      ),
    );

    listaBotoes.add(
      IconButton(
        icon: FaIcon(FontAwesomeIcons.fileInvoice),
        tooltip: 'Reimpressão de Recibo',
        onPressed: () async {
          _reimprimirRecibo();
        },
      ),
    );

    // se a plataforma for mobile, insere o botão para ler o código de barras com o celular
    if (Biblioteca.isMobile()) {
      listaBotoes.add(
        IconButton(
          icon: FaIcon(FontAwesomeIcons.barcode),
          tooltip: "Ler código de barras",
          onPressed: () async {
            try {
              _codigoDeBarras = await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666", "Cancelar", true, ScanMode.BARCODE);
            } catch (e) {
              throw ('Erro lendo código de barras: ' + DateTime.now().toIso8601String() + ' - ' + e.toString());
            }
            _localizarProduto(_codigoDeBarras);
          },
        ),
      );
    }
    return listaBotoes;
  }

// #endregion widgets Caixa


// #region métodos Caixa

  void _acessarOpcoesGerenciais() {
    if (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento) {
      _exibirMensagemExisteVendaEmAndamento();
    } else {
      _keyScaffold.currentState.openEndDrawer();
    }
  }

  void _salvarVenda() {
    if (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento) {
      gerarDialogBoxConfirmacao(context, 'Deseja salvar a venda e iniciar uma nova?', () async {
        await Sessao.db.pdvVendaCabecalhoDao.alterar(Sessao.vendaAtual, Sessao.listaVendaAtualDetalhe);
        // Navigator.of(context).pop();
        _configurarDadosTelaPadrao();
      });
    } else {
      _exibirMensagemNaoExisteVendaEmAndamento();
    }
  }

  void _cancelarVenda() {
    if (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento) {
      gerarDialogBoxConfirmacao(context, 'Deseja cancelar a venda e iniciar uma nova?', () async {
        await Sessao.db.pdvVendaCabecalhoDao.excluir(Sessao.vendaAtual);
        // Navigator.of(context).pop();
        _configurarDadosTelaPadrao();
      });
    } else {
      _exibirMensagemNaoExisteVendaEmAndamento();
    }
  }

  void _encerrarVenda() async {
    if (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento) {
      if (Sessao.listaVendaAtualDetalhe.length > 0) {
        bool encerrouVenda = await Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => EfetuaPagamentoPage(title: 'Encerramento da Venda')));
          if (encerrouVenda ?? false) {
            Sessao.vendaAtual = 
            Sessao.vendaAtual.copyWith(
              statusVenda: 'F'
            );
            await Sessao.db.pdvVendaCabecalhoDao.alterar(Sessao.vendaAtual, Sessao.listaVendaAtualDetalhe, listaDadosPagamento: Sessao.listaDadosPagamento);
            if (Sessao.configuracaoPdv.moduloFiscalPrincipal == 'NFC') {
              await _encerrarVendaComNfce();
            } else {
              _imprimirRecibo();
            }
          }
      }  else {
        _exibirMensagemExisteVendaSemItens();
      }
    } else {
      _exibirMensagemNaoExisteVendaEmAndamento();
    }
  }

  Future<void> _encerrarVendaComNfce() async {
    NfceService servicoNfce = NfceService();
    try {
      await servicoNfce.conectar().then((socket) async {
        if (NfceController.nfeCabecalhoMontado == null) {
          await NfceController.gerarDadosNfce();
        }
        final nfceFormatoIni = NfceController.montarNfce();
        socket.write('NFe.CriarEnviarNFe("' + nfceFormatoIni + '", "001", , , , , , "1")\r\n.\r\n');
        socket.listen((data) async {
          final respostaServidor = String.fromCharCodes(data).trim();                  
          final caractereFinal = respostaServidor.substring(respostaServidor.length - 1, respostaServidor.length);
          final contemEndOfText = (caractereFinal.codeUnitAt(0) == $etx);

          if (respostaServidor.contains('Rejeicao')) {
            _abriuDialogBoxEspera = false;
            var respostaJson;
            if (contemEndOfText) {
              respostaJson = json.decode(respostaServidor.substring(4, respostaServidor.length - 1));
            } else {
              respostaJson = json.decode(respostaServidor.substring(4, respostaServidor.length));
            }
            final motivo = respostaJson.values.toList()[0]['Retorno'].values.toList()[4]['xMotivo'];
            Navigator.of(context).pop();
            gerarDialogBoxErro(context, 'Ocorreu um problema ao tentar emitir a NFC-e: ' + motivo);
          } else if (respostaServidor.contains('ChaveDFe')) {
            var respostaJson;
            if (contemEndOfText) {
              respostaJson = json.decode(respostaServidor.substring(4, respostaServidor.length - 1));
            } else {
              respostaJson = json.decode(respostaServidor.substring(4, respostaServidor.length));
            }
            final chave = respostaJson.values.toList()[0]['Retorno']['ChaveDFe'];
            NfceController.nfeCabecalhoMontado.nfeCabecalho = 
              NfceController.nfeCabecalhoMontado.nfeCabecalho.copyWith(
                chaveAcesso: chave,
                statusNota: '4',
              );
            await Sessao.db.nfeCabecalhoDao.alterar(NfceController.nfeCabecalhoMontado);
            socket.write('ACBr.EncodeBase64("C:\\ACBrMonitor\\PDF\\'+Sessao.empresa.cnpj+'\\NFCe\\'+chave+'-nfe.pdf")\r\n.\r\n');
          } else if (respostaServidor.contains('ERRO')) {
            gerarDialogBoxErro(context, 'Ocorreu um problema ao tentar emitir a NFC-e: ' + respostaServidor);
            Navigator.of(context).pop();
            _abriuDialogBoxEspera = false;
          } else if (respostaServidor.length > 5000) { // é o arquivo PDF
            _abriuDialogBoxEspera = false;
            if (contemEndOfText) {
              _imprimirDanfe(respostaServidor.substring(4, respostaServidor.length - 1));
            } else {
              _imprimirDanfe(respostaServidor.substring(4, respostaServidor.length));
            }
          } else if (respostaServidor.codeUnitAt(0) == $etx) { // se voltar apenas o ETX do ACBrMonitor, não faz nada
            print('RESPOSTA SERVIDOR = ' + respostaServidor);
          } else {
            if (!_abriuDialogBoxEspera) {
              _abriuDialogBoxEspera = true;
              gerarDialogBoxEspera(context);
            }
          }
        });
      });                 
    } catch (e) {
      gerarDialogBoxErro(context, 'Ocorreu um problema ao tentar emitir a NFC-e: ' + e.toString());
    }
  }

  void _imprimirRecibo() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) { 
          if (Sessao.configuracaoPdv.reciboFormatoPagina == 'A4') {
            return ReciboRelatorioA4(); 
          } else if (Sessao.configuracaoPdv.reciboFormatoPagina == '80') {
            return ReciboRelatorio80(); 
          } else {
            return ReciboRelatorio57(); 
          }
        }))
      .then((_) {
        _configurarDadosTelaPadrao();
      });
  }

  void _imprimirDanfe(String danfeBase64) {
    var decodeB64 = base64.decode(danfeBase64); 
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => PdfPage(
          arquivoPdf: decodeB64, title: 'NFC-e')
        )
      ).then(
        (value) {
          Navigator.of(context).pop(); // fecha a tela gerarDialogBoxEspera
          _configurarDadosTelaPadrao();
        }
      );          
  }

  void _reimprimirRecibo() async {
    if (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento) {
      _exibirMensagemExisteVendaEmAndamento();
    } else {
      Map<String, dynamic> objetoJsonRetorno = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LookupLocalPage(
              title: 'Reimprimir Recibo de Venda',
              colunas: PdvVendaCabecalhoDao.colunas,
              campos: PdvVendaCabecalhoDao.campos,
              campoPesquisaPadrao: 'id',
              valorPesquisaPadrao: '%',
              metodoConsultaCallBack: _filtrarVendaFechadaLookup,
            ),
            fullscreenDialog: true,
          ));
      if (objetoJsonRetorno != null) {
        Sessao.vendaAtual = await Sessao.db.pdvVendaCabecalhoDao.consultarObjeto(objetoJsonRetorno['id']);
        Sessao.listaVendaAtualDetalhe = await Sessao.db.pdvVendaDetalheDao.consultarListaComProduto(objetoJsonRetorno['id']);
        _imprimirRecibo();
      }          
    }
  }

  void _recuperarVenda() async {
    if (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento) {
      _exibirMensagemExisteVendaEmAndamento();
    } else {
      Map<String, dynamic> objetoJsonRetorno = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LookupLocalPage(
              title: 'Recuperar Venda',
              colunas: PdvVendaCabecalhoDao.colunas,
              campos: PdvVendaCabecalhoDao.campos,
              campoPesquisaPadrao: 'id',
              valorPesquisaPadrao: '%',
              metodoConsultaCallBack: _filtrarVendaLookup,
            ),
            fullscreenDialog: true,
          ));
      if (objetoJsonRetorno != null) {
        Sessao.vendaAtual = await Sessao.db.pdvVendaCabecalhoDao.consultarObjeto(objetoJsonRetorno['id']);
        Sessao.listaVendaAtualDetalhe = await Sessao.db.pdvVendaDetalheDao.consultarListaComProduto(objetoJsonRetorno['id']);
        setState(() {
          Sessao.statusCaixa = StatusCaixa.vendaEmAndamento;
        });
      }          
    }
  }

  void _filtrarVendaLookup(String campo, String valor) async {
    final filtroAdicional = "STATUS_VENDA='A'";
    var listaFiltrada = await Sessao.db.pdvVendaCabecalhoDao.consultarListaFiltro(campo, valor, filtroAdicional: filtroAdicional);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _filtrarVendaFechadaLookup(String campo, String valor) async {
    final filtroAdicional = "STATUS_VENDA='F'";
    var listaFiltrada = await Sessao.db.pdvVendaCabecalhoDao.consultarListaFiltro(campo, valor, filtroAdicional: filtroAdicional);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _concederDesconto() {
    if (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento) {
      if (_fornecidoDescontoNoItem) {
        gerarDialogBoxInformacao(context, 'Não é possível fornecer desconto nos itens e no total da venda.');
      } else {
        Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (BuildContext context) => InformaValorPage(title: 'Desconto na Venda', operacao: 'DESCONTO', )))
          .then((_) {
            setState(() {
              _atualizarTotais();
            });
          });
      }
    } else {
      _exibirMensagemNaoExisteVendaEmAndamento();
    }
  }

  void _incrementarItem({VendaDetalhe item}) {
    setState(() {
      item.pdvVendaDetalhe = item.pdvVendaDetalhe.copyWith(
        quantidade: item.pdvVendaDetalhe.quantidade + 1,
        valorTotalItem: (item.pdvVendaDetalhe.quantidade + 1) * item.pdvVendaDetalhe.valorUnitario,
        valorTotal: (item.pdvVendaDetalhe.quantidade + 1) * item.pdvVendaDetalhe.valorUnitario,
      );
      _atualizarTotais();
    });
  }

  void _decrementarItem({VendaDetalhe item}) {
    if (item.pdvVendaDetalhe.quantidade > 1) {
      setState(() {
        item.pdvVendaDetalhe = item.pdvVendaDetalhe.copyWith(
          quantidade: item.pdvVendaDetalhe.quantidade - 1,
          valorTotalItem: (item.pdvVendaDetalhe.quantidade - 1) * item.pdvVendaDetalhe.valorUnitario,
          valorTotal: (item.pdvVendaDetalhe.quantidade - 1) * item.pdvVendaDetalhe.valorUnitario,
        );
        _atualizarTotais();
      });
    }
  }

  void _excluirProduto({int index, bool perguntaAntes}) {
    if (perguntaAntes) {
      gerarDialogBoxExclusao(context, () async {
        setState(() {
          Sessao.listaVendaAtualDetalhe = List.from(Sessao.listaVendaAtualDetalhe)..removeAt(index);
          _atualizarTotais();
        });
        // Navigator.of(context).pop();
      });
    } else {
      setState(() {
        Sessao.listaVendaAtualDetalhe = List.from(Sessao.listaVendaAtualDetalhe)..removeAt(index);
        _atualizarTotais();
      });
    }
    _focusNode.requestFocus();
  }    

  Future _verificarRegistro() async {
    // se a empresa não está registrada ainda no banco de dados da SH, verifica se chegou a hora do registro
    if (Sessao.empresa.registrado == null || Sessao.empresa.registrado == false) {
      final totalRegistrosVendas = await Sessao.db.pdvVendaCabecalhoDao.consultarTotalRegistros();
      if (totalRegistrosVendas > 100) {
        showDialog(
          context: context, 
          builder: (BuildContext context){
            return RegistroPage(title: 'Registro do Usuário');
          })
          .then((_) {
          });
      }
    }
    _configurarDadosTelaPadrao();
  }

  void _configurarDadosTelaPadrao() {
    _fecharMenus();
    final tipoOperacao = Sessao.configuracaoPdv.moduloFiscalPrincipal == null ? 'REC' : Sessao.configuracaoPdv.moduloFiscalPrincipal;
    setState(() {
      Sessao.vendaAtual = PdvVendaCabecalho(id: null, idPdvMovimento: Sessao.movimento.id, tipoOperacao: tipoOperacao);
      Sessao.listaVendaAtualDetalhe = [];
      Sessao.listaDadosPagamento = [];
      Sessao.listaParcelamento = [];
      Sessao.statusCaixa = StatusCaixa.aberto;
      Sessao.objetoJsonErro = null;
      NfceController.nfeCabecalhoMontado = null;
      _tituloJanela = Constantes.tituloCaixaAberto;
      _fornecidoDescontoNoItem = false;
      _focusNode.requestFocus();
    });
  }
  
  Future<void> _instanciarVendaAtual() async {
    if (Sessao.vendaAtual.id == null) {
      Sessao.vendaAtual = 
      Sessao.vendaAtual.copyWith(
        idPdvMovimento: Sessao.movimento.id,
        dataVenda: DateTime.now(),
        horaVenda: Biblioteca.formatarHora(DateTime.now()),
        statusVenda: 'A'
      );

      int idInserido = await Sessao.db.pdvVendaCabecalhoDao.inserir(Sessao.vendaAtual);
      Sessao.vendaAtual = await Sessao.db.pdvVendaCabecalhoDao.consultarObjeto(idInserido);
      setState(() {
        _tituloJanela = Constantes.tituloCaixaVendaEmAndamento;
        Sessao.statusCaixa = StatusCaixa.vendaEmAndamento;
      });
    }
  }

  void _localizarProduto(String dadoInformado) async {
    bool podeRealizarVenda = false;
    if (Sessao.configuracaoPdv.modulo != 'G') {
      if (Sessao.configuracaoPdv.moduloFiscalPrincipal == 'NFC') {
        String mensagemRetorno = await NfceController.verificarSeAptoParaEmitirNfce();
        if (mensagemRetorno.isNotEmpty) {
          gerarDialogBoxInformacao(context, mensagemRetorno);
        } else {
          podeRealizarVenda = true;
        }
      }
    } else {
      podeRealizarVenda = true;
    }

    if (podeRealizarVenda) {
      await _instanciarVendaAtual();
      _quantidadeInformada = 1;
      final digitouQuantidade = dadoInformado.split('*');
      if (digitouQuantidade.length > 1) {
        _quantidadeInformada = double.tryParse(digitouQuantidade[0]);
        dadoInformado = digitouQuantidade[1];
      }

      var campoParaConsulta = '';
      int dadoNumerico = int.tryParse(dadoInformado);
      if (dadoNumerico != null) {
        if (dadoInformado.length == 13 || dadoInformado.length == 14) {
          campoParaConsulta = 'GTIN';
        } else {
          campoParaConsulta = 'CODIGO_INTERNO';
        }
      } else {
        campoParaConsulta = 'DESCRICAO_PDV';
      }
      _produto = await Sessao.db.produtoDao.consultarObjetoFiltro(campoParaConsulta, dadoInformado);   

      if (_produto != null) {
        _comporItemParaVenda();
      } else {
        _importarProduto(criterioPesquisa: dadoInformado);
      }
    }
    _focusNode.requestFocus();
  }

  void _comporItemParaVenda() {
    final _quantidadeFutura = (_produto.quantidadeEstoque ?? 0) - _quantidadeInformada;

    if(Sessao.configuracaoPdv.modulo != 'G' && _produto.idTributGrupoTributario == null) {
      _exibirMensagemGrupoTributario();
    } else if ((Sessao.configuracaoPdv.permiteEstoqueNegativo ?? 'S') == 'N' && _quantidadeFutura < 0) {
      _exibirMensagemEstoqueNegativo();
    } else {
      PdvVendaDetalhe pdvVendaDetalhe = 
      PdvVendaDetalhe(
        id: null, 
        idProduto: _produto.id,
        gtin: _produto.gtin == '' ? _produto.id.toString() : _produto.gtin,
        cst: _produto.cst,
        taxaIcms: _produto.taxaIcms,
        movimentaEstoque: _produto.ippt == 'T' ? 'S' : 'N',
        quantidade: _quantidadeInformada,
        valorUnitario: _produto.valorVenda,
        valorTotalItem: _quantidadeInformada * _produto.valorVenda,
        valorTotal: _quantidadeInformada * _produto.valorVenda,
      );

      VendaDetalhe vendaDetalhe = VendaDetalhe(pdvVendaDetalhe: pdvVendaDetalhe, produto: _produto);
      setState(() {
        Sessao.listaVendaAtualDetalhe.add(vendaDetalhe);
        _atualizarTotais();
      });      
    }
  }
  
  void _atualizarTotais() {
    double totalGeral = 0;
    double subTotal = 0;        
    double totalDescontosItens = 0;
    for (var item in Sessao.listaVendaAtualDetalhe) {
      totalGeral = totalGeral + item.pdvVendaDetalhe.valorTotalItem;
      subTotal = subTotal + item.pdvVendaDetalhe.valorTotal;
      totalDescontosItens = totalDescontosItens + (item.pdvVendaDetalhe.valorDesconto ?? 0);
    }
    double taxaDesconto = 0;
    double valorDesconto = 0;
    if (totalDescontosItens > 0) {
      valorDesconto = totalDescontosItens;
      taxaDesconto = valorDesconto / totalGeral * 100;
      taxaDesconto = num.parse(taxaDesconto.toStringAsFixed(Constantes.decimaisValor));
      _fornecidoDescontoNoItem = true;
    } else {
      taxaDesconto = Sessao.vendaAtual.taxaDesconto;
      valorDesconto = Biblioteca.calcularDesconto(subTotal, Sessao.vendaAtual.taxaDesconto);
      _fornecidoDescontoNoItem = false;
    }
    Sessao.vendaAtual = 
    Sessao.vendaAtual.copyWith(
      valorVenda: totalGeral,
      taxaDesconto: taxaDesconto,
      valorDesconto: valorDesconto,
      valorFinal: totalGeral - valorDesconto,
      valorBaseIcms: totalGeral - valorDesconto,
    );
  }

  void _fecharMenus() {
    _menuController.close();
    if (_keyScaffold.currentState.isEndDrawerOpen) {
      Navigator.pop(context);
    }
  }

  void _identificarVendedor() async {  
    if (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento) {
      Map<String, dynamic> objetoJsonRetorno = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LookupLocalPage(
              title: 'Importar Vendedor',
              colunas: ColaboradorDao.colunas,
              campos: ColaboradorDao.campos,
              campoPesquisaPadrao: 'nome',
              valorPesquisaPadrao: '%',
              metodoConsultaCallBack: _filtrarVendedorLookup,
            ),
            fullscreenDialog: true,
          ));
      if (objetoJsonRetorno != null) {
        setState(() {
          Sessao.vendaAtual = 
          Sessao.vendaAtual.copyWith(
            idColaborador: objetoJsonRetorno['id'],
          );
        });
      }
      _fecharMenus();
    } else {
      _exibirMensagemNaoExisteVendaEmAndamento();
    }
 }

  void _filtrarVendedorLookup(String campo, String valor) async {
    var listaFiltrada = await Sessao.db.colaboradorDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _identificarCliente() async {
    if (Sessao.statusCaixa == StatusCaixa.vendaEmAndamento) {
      Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => IdentificaClientePage(title: 'Identifica Cliente')))
        .then((_) {
          setState(() {
          });
        });      
      _fecharMenus();
    } else {
      _exibirMensagemNaoExisteVendaEmAndamento();
    }
  }

  void _importarProduto({String criterioPesquisa}) async {
    Map<String, dynamic> objetoJsonRetorno = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LookupLocalPage(
            title: 'Importar Produto',
            colunas: ProdutoDao.colunas,
            campos: ProdutoDao.campos,
            campoPesquisaPadrao: 'nome',
            valorPesquisaPadrao: (criterioPesquisa == null || criterioPesquisa == '') ? '%' : criterioPesquisa,
            metodoConsultaCallBack: _filtrarProdutoLookup,
            permiteCadastro: true,
            metodoCadastroCallBack: () { Navigator.pushNamed(context, '/produtoLista',); },
          ),
          fullscreenDialog: true,
        ));
    if (objetoJsonRetorno != null) {
      _localizarProduto(objetoJsonRetorno['gtin']);
    }    
  }  

  void _filtrarProdutoLookup(String campo, String valor) async {
    var listaFiltrada = await Sessao.db.produtoDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _exibirMensagemNaoExisteVendaEmAndamento() {
    gerarDialogBoxInformacao(context, 'Não existe uma venda em andamento.');
  }

  void _exibirMensagemExisteVendaEmAndamento() {
    gerarDialogBoxInformacao(context, 'Existe uma venda em andamento.');
  }

  void _exibirMensagemExisteVendaSemItens() {
    gerarDialogBoxInformacao(context, 'Não existem itens na venda.');
  }

  void _exibirMensagemEstoqueNegativo() {
    gerarDialogBoxInformacao(context, 'Não é permitido vender um item com estoque negativo.');
  }

  void _exibirMensagemGrupoTributario() {
    gerarDialogBoxInformacao(context, 'Produto sem Grupo Tributário vinculado.');
  }
// #endregion métodos Caixa

}