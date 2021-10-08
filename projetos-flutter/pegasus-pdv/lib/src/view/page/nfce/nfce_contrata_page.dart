/*
Title: T2Ti ERP 3.0                                                                
Description: Tela de Contratação da NFC-e
                                                                                
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
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';
import 'package:pegasus_pdv/src/model/model.dart';
import 'package:pegasus_pdv/src/service/service.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';
import 'package:url_launcher/url_launcher.dart';

class NfceContrataPage extends StatefulWidget {
  const NfceContrataPage({Key key}) : super(key: key);

  @override
  _NfceContrataPageState createState() => _NfceContrataPageState();
}

class _NfceContrataPageState extends State<NfceContrataPage> {
  List<PdvTipoPlanoModel> _listaTipoPlano = [];

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  String _mensagemInformativa = 'Selecione um plano e aguarde o carregamento do PagSeguro.';
  bool _podeContratar = false;
  bool _clicouBotaoVerificarPlano = false;
  final _codigoTransacaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosCaixa();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _carregarDados());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.escape:
        Navigator.pop(context);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    if (Sessao.nfcePlanoPagamento != null) {
      _mensagemInformativa = 'Plano NFC-e ativo até ' + Biblioteca.formatarData(Sessao.nfcePlanoPagamento.dataPlanoExpira);
    }

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blueGrey.shade200, Colors.blueGrey.shade600]),
                ),
              ),
              ListView.builder(
                itemCount: 4,
                itemBuilder: _mainListBuilder,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _regiaoTipoPlano(context);
    if (index == 1) return _conteudoTela(context);
    if (index == 2) return _rodapeTela(context);
    return null;
  }

  Container _regiaoTipoPlano(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    'Contratação da NFC-e',
                    style: Biblioteca.isTelaPequena(context) ? Theme.of(context).textTheme.headline6 : Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  BootstrapContainer(                    
                    fluid: true,
                    decoration: BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
                    children: <Widget>[			  			  
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Plano de Pagamento",
                                            style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: Biblioteca.isTelaPequena(context) ? 13.0 : 15.0),
                                          ),
                                          getBotaoGenericoPdv(
                                            descricao: Biblioteca.isTelaPequena(context) ? 'Checar' : 'Verificar se Foi Confirmado',
                                            cor: Colors.green, 
                                            onPressed: () async {
                                              if (Sessao.nfcePlanoPagamento == null) {
                                                _clicouBotaoVerificarPlano = true;
                                                await _verificarPlano();
                                              } else {
                                                gerarDialogBoxInformacao(context, 'Seu plano está ativo.');
                                              }
                                            }
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      thickness: 2,
                                    ),
                                    Row(              
                                      children: <Widget> [ 
                                        Expanded(
                                          flex: 1,
                                          child: _getTile(
                                            _getItemPlanoPagamento(
                                              _listaTipoPlano.length > 0 ? _listaTipoPlano[0]?.plano : '', 
                                              _listaTipoPlano.length > 0 ? _listaTipoPlano[0]?.valor : 0, 
                                              Colors.blue.shade900, 
                                              FontAwesomeIcons.calendarAlt,
                                            ),
                                            onTap: () {
                                              if (Sessao.nfcePlanoPagamento == null) {
                                                _contratarPlano('M');
                                              } else {
                                                gerarDialogBoxInformacao(context, 'Seu plano está ativo.');
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: _getTile(
                                            _getItemPlanoPagamento(
                                              _listaTipoPlano.length > 0 ? _listaTipoPlano[1]?.plano : '', 
                                              _listaTipoPlano.length > 0 ? _listaTipoPlano[1]?.valor : 0, 
                                              Colors.green.shade900, 
                                              FontAwesomeIcons.calendarWeek,
                                            ),
                                            onTap: () {
                                              if (Sessao.nfcePlanoPagamento == null) {
                                                _contratarPlano('S');
                                              } else {
                                                gerarDialogBoxInformacao(context, 'Seu plano está ativo.');
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: _getTile(
                                            _getItemPlanoPagamento(
                                              _listaTipoPlano.length > 0 ? _listaTipoPlano[2]?.plano : '', 
                                              _listaTipoPlano.length > 0 ? _listaTipoPlano[2]?.valor : 0, 
                                              Colors.purple.shade900, 
                                              FontAwesomeIcons.calendar,
                                            ),
                                            onTap: () {
                                              if (Sessao.nfcePlanoPagamento == null) {
                                                _contratarPlano('A');
                                              } else {
                                                gerarDialogBoxInformacao(context, 'Seu plano está ativo.');
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                                      child: Text(              
                                        _mensagemInformativa,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600, 
                                          fontSize: 17.0, 
                                          color: Colors.red, 
                                          fontStyle: FontStyle.italic
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),                          
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage(Constantes.nfceBanner),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _conteudoTela(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Transação",
                            style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: Biblioteca.isTelaPequena(context) ? 13.0 : 15.0),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                    Text('Se houver realizado o pagamento com um e-mail diferente do cadastrado aqui, por favor, informe abaixo o código da transação.'),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      controller: _codigoTransacaoController,
                      decoration: getInputDecoration(
                        'Informe o código da transação',
                        'Código da Transação',
                        false),
                      onSubmitted: (value) async {
                        await _confirmarTransacao();
                      },
                      onChanged: (text) {
                      },                      
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getBotaoConfirmarTransacao(context: context),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            onTap: onTap != null
                ? () => onTap()
                : () { print('Nada foi implementado'); },
            child: child));
  }

  Widget _getItemPlanoPagamento(String descricao, double valor, Color corIcone, IconData icone) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 32, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: corIcone,
            shape: CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(icone, color: Colors.white, size: 30.0),
            )),
          Padding(padding: EdgeInsets.only(bottom: 16.0)),
          Text(descricao ?? '', style: 
            TextStyle(
              color: Colors.black87,
              fontSize: Biblioteca.isTelaPequena(context) ? 12 : 14,
            )
          ),
          Text(
            Biblioteca.isTelaPequena(context) 
            ? '${Constantes.formatoDecimalValor.format(valor ?? 0)}' //valor
            : 'R\$ ${Constantes.formatoDecimalValor.format(valor ?? 0)}', //valor            
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: Biblioteca.isTelaPequena(context) ? 16 : 24)),
        ]
      ),
    );
  }

  Container _rodapeTela(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getBotoesRodape(context: context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getBotoesRodape({BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
      Container(
        width: 200,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Sair' : 'Sair [ESC]',
          cor: Colors.green, 
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      )
    );
    return listaBotoes;
  }

  List<Widget> _getBotaoConfirmarTransacao({BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
       Container(
        width: 200,
        child: getBotaoGenericoPdv(
          descricao: 'Confirmar Transação',
          cor: Colors.blue, 
          onPressed: () async {
            await _confirmarTransacao();
          }
        ),
      ),
    );
    return listaBotoes;
  }

  Future _confirmarTransacao() async {
    if (Sessao.nfcePlanoPagamento == null) {
      gerarDialogBoxEspera(context);
      NfceService servicoNfce = NfceService();
      final retorno = await servicoNfce.confirmarTransacao(_codigoTransacaoController.text);  
      if (retorno == 200) {
        await _verificarPlano();
        Sessao.fecharDialogBoxEspera(context);
      } else if (retorno == 202) {
        Sessao.fecharDialogBoxEspera(context);
        gerarDialogBoxInformacao(context, 'Código de transação localizado, mas pendente de pagamento.');
      } else if (retorno == 404) {
        Sessao.fecharDialogBoxEspera(context);
        gerarDialogBoxInformacao(context, 'Código de transação não localizado.');
      } else if (retorno == 418) {
        Sessao.fecharDialogBoxEspera(context);
        gerarDialogBoxInformacao(context, 'Código de transação já utilizado.');
      }
      setState(() {
      });
    } else {
      gerarDialogBoxInformacao(context, 'Seu plano está ativo.');
    }            
  }

  Future _carregarDados() async {
    NfceService servicoNfce = NfceService();

    gerarDialogBoxEspera(context);

    _listaTipoPlano = await servicoNfce.consultarListaTipoPlanoNfce();  
    if (_listaTipoPlano == null) {
      Sessao.fecharDialogBoxEspera(context); 
      Navigator.pop(context); // fecha janela de contratação
    } else {
      await _verificarPlano();      
      Sessao.fecharDialogBoxEspera(context); 
      setState(() {
      });
    }
  }

  _contratarPlano(String tipoPlano) async {
    gerarDialogBoxEspera(context);
    await _verificarPlano();
    if (_podeContratar) {
      switch (tipoPlano) {	  
        case 'M' : 
          final _url = 'https://pag.ae/7XsrnNVw4';
          await canLaunch(_url) ? await launch(_url) : throw 'Houve um problema ao tentar abrir o link de pagamento: $_url';
          break;
        case 'S' : 
          final _url = 'https://pag.ae/7XsAYgam9';
          await canLaunch(_url) ? await launch(_url) : throw 'Houve um problema ao tentar abrir o link de pagamento: $_url';
          break;
        case 'A' : 
          final _url = 'https://pag.ae/7XsAYQKb8';
          await canLaunch(_url) ? await launch(_url) : throw 'Houve um problema ao tentar abrir o link de pagamento: $_url';
          break;
        default:
      }      
    }

    Sessao.fecharDialogBoxEspera(context);
    setState(() {
    });
  }

  Future _verificarPlano() async {
    NfceService servicoNfce = NfceService();

    final nfcePlanoPagamentoModel = await servicoNfce.verificarPlano();  
    
    if (nfcePlanoPagamentoModel != null) {
      switch (nfcePlanoPagamentoModel.statusPagamento) {
        case '1' : 
          _mensagemInformativa = 'Status: aguardando pagamento. Realize o pagamento ou inicie uma nova compra.'; 
          _bloquearDispositivoParaNfce(nfcePlanoPagamentoModel); 
          _podeContratar = true;
          break;
        case '2' : 
          _mensagemInformativa = 'Status: compra com cartão - em análise.'; 
          _bloquearDispositivoParaNfce(nfcePlanoPagamentoModel); 
          break;
        case '3' : 
          _liberarDispositivoParaNfce(nfcePlanoPagamentoModel); 
          break;
        case '5' : 
          _mensagemInformativa = 'Status: disputa aberta pelo comprador.'; 
          _bloquearDispositivoParaNfce(nfcePlanoPagamentoModel); 
          break;
        case '6' : 
          _mensagemInformativa = 'Status: valor devolvido ao comprador.'; 
          _bloquearDispositivoParaNfce(nfcePlanoPagamentoModel); 
          _podeContratar = true;
          break;
        case '7' : 
          _mensagemInformativa = 'Status: compra cancelada.'; 
          _podeContratar = true;
          _bloquearDispositivoParaNfce(nfcePlanoPagamentoModel); 
          break;
        case '8' : 
          _mensagemInformativa = 'Status: valor devolvido ao comprador.'; 
          _podeContratar = true;
          _bloquearDispositivoParaNfce(nfcePlanoPagamentoModel); 
          break;
        case '9' : 
          _mensagemInformativa = 'Status: compra contestada pelo comprador.'; 
          _bloquearDispositivoParaNfce(nfcePlanoPagamentoModel); 
          break;
        default:
      }
    } else {
      if (_clicouBotaoVerificarPlano) {
        _mensagemInformativa = 'Pagamento não localizado. Se pagou com outro e-mail, use a opção abaixo para confirmar a transação.';
      }
      _podeContratar = true;
    }
    setState(() {
    });      
  }

  void _liberarDispositivoParaNfce(NfcePlanoPagamentoModel nfcePlanoPagamentoModel) async {
    final dataPlanoExpiraFormatada = Biblioteca.formatarData(nfcePlanoPagamentoModel.dataPlanoExpira);
    
    Sessao.nfcePlanoPagamento = 
      NfcePlanoPagamento(
        id: null, 
        dataSolicitacao: nfcePlanoPagamentoModel.dataSolicitacao,
        dataPagamento: nfcePlanoPagamentoModel.dataPagamento,
        tipoPlano: nfcePlanoPagamentoModel.plano,
        valor: nfcePlanoPagamentoModel.valor,
        statusPagamento: nfcePlanoPagamentoModel.statusPagamento,
        codigoTransacao: nfcePlanoPagamentoModel.codigoTransacao,
        metodoPagamento: nfcePlanoPagamentoModel.metodoPagamento,
        codigoTipoPagamento: nfcePlanoPagamentoModel.codigoTipoPagamento,
        dataPlanoExpira: nfcePlanoPagamentoModel.dataPlanoExpira,
        hashRegistro: md5.convert(utf8.encode(dataPlanoExpiraFormatada + Constantes.chave)).toString()
      );
    await Sessao.db.nfcePlanoPagamentoDao.inserir(Sessao.nfcePlanoPagamento);
    Sessao.nfcePlanoPagamento = await Sessao.db.nfcePlanoPagamentoDao.consultarPlanoAtivo();    

    Sessao.configuracaoPdv = 
      Sessao.configuracaoPdv.copyWith(
        modulo: 'F',
        plano: nfcePlanoPagamentoModel.plano,
        planoSituacao: 'A',
        planoValor: nfcePlanoPagamentoModel.valor,
        moduloFiscalPrincipal: 'NFC',
      );
    await Sessao.db.pdvConfiguracaoDao.alterar(Sessao.configuracaoPdv);
    Sessao.configuracaoPdv = await Sessao.db.pdvConfiguracaoDao.consultarObjeto(1);

    // se for a primeira vez que o plano é armazenado, vamos vincular o grupo tributário 2 a todos os produtos
    final listaPagamentos = await Sessao.db.nfcePlanoPagamentoDao.consultarLista();
    if (listaPagamentos.length == 1) {
      await Sessao.db.produtoDao.atualizarGrupoTributario(2); // produto adquirido de terceiro    
    }
  }

  void _bloquearDispositivoParaNfce(NfcePlanoPagamentoModel nfcePlanoPagamentoModel) async {
    if(Sessao.nfcePlanoPagamento != null) {
      final dataPlanoExpiraFormatada = Biblioteca.formatarData(nfcePlanoPagamentoModel.dataPlanoExpira);
      Sessao.nfcePlanoPagamento = Sessao.nfcePlanoPagamento.copyWith(
        dataSolicitacao: nfcePlanoPagamentoModel.dataSolicitacao,
        dataPagamento: nfcePlanoPagamentoModel.dataPagamento,
        tipoPlano: nfcePlanoPagamentoModel.plano,
        valor: nfcePlanoPagamentoModel.valor,
        statusPagamento: nfcePlanoPagamentoModel.statusPagamento,
        codigoTransacao: nfcePlanoPagamentoModel.codigoTransacao,
        metodoPagamento: nfcePlanoPagamentoModel.metodoPagamento,
        codigoTipoPagamento: nfcePlanoPagamentoModel.codigoTipoPagamento,
        dataPlanoExpira: nfcePlanoPagamentoModel.dataPlanoExpira,
        hashRegistro: md5.convert(utf8.encode(dataPlanoExpiraFormatada + Constantes.chave)).toString()
      );
      await Sessao.db.nfcePlanoPagamentoDao.alterar(Sessao.nfcePlanoPagamento);
      Sessao.nfcePlanoPagamento = await Sessao.db.nfcePlanoPagamentoDao.consultarPlanoAtivo();    
    }  

    // se tem algum pagamento de plano já armazenado, então a aplicação não pode mais voltar para o modo gratuito
    final listaPagamentos = await Sessao.db.nfcePlanoPagamentoDao.consultarLista();
    var modulo = 'G';
    var moduloFiscal;
    if (listaPagamentos.length > 0) {
      modulo = 'F';
      moduloFiscal = 'NFC';
    } else {
      modulo = 'G';
      moduloFiscal = null;
    }

    // qualquer tipo de status que seja diferente de 1, indica que o usuário pagou pelo módulo fiscal e não pode retornar para o gratuito
    if (nfcePlanoPagamentoModel.statusPagamento != '1') {
      modulo = 'F';
      moduloFiscal = 'NFC';
    }

    Sessao.configuracaoPdv = 
      Sessao.configuracaoPdv.copyWith(
        modulo: modulo,
        planoSituacao: nfcePlanoPagamentoModel.statusPagamento == '2' ? 'B' : 'I',
        moduloFiscalPrincipal: moduloFiscal,
      );
    await Sessao.db.pdvConfiguracaoDao.alterar(Sessao.configuracaoPdv);
    Sessao.configuracaoPdv = await Sessao.db.pdvConfiguracaoDao.consultarObjeto(1);
  }

}