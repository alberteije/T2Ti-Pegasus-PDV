/*
Title: T2Ti ERP 3.0                                                                
Description: Caixa - Página que serve para informar um valor com uma observação
            Útil para suprimento, sangria, desconto, acréscimo, etc
                                                                                
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

Based on: Flutter UI Challenges by Many - https://github.com/lohanidamodar/flutter_ui_challenges
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:pegasus_pdv/src/database/database.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class InformaValorPage extends StatefulWidget {
  final String title;
  final String operacao;
  
  const InformaValorPage({Key key, this.title, this.operacao}): super(key: key);

  @override
  _InformaValorPageState createState() => _InformaValorPageState();
}

class _InformaValorPageState extends State<InformaValorPage> {
	final _valorController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: 0);
  final _observacaoController = TextEditingController();
  var _subtitulo = 'Informe o valor e a observação';
  var _textoValor = 'Valor';
  final _valorFoco = FocusNode();

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();

    _valorController.afterChange = (_, __) {
      _valorController.selection = TextSelection.collapsed(
        offset: _valorController.text.length,
      );
    };

    _valorFoco.addListener(() {
      if(_valorFoco.hasFocus) {
        _valorController.selection = TextSelection(baseOffset: 0, extentOffset: _valorController.text.length);
      }
    });

    _shortcutMap = getAtalhosCaixa();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
    _valorFoco.requestFocus();        
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.cancelar:
        Navigator.pop(context);
        break;
      case AtalhoTelaType.confirmar:
        _efetuarOperacao();
        break;
      case AtalhoTelaType.escape:
        Navigator.pop(context, false);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.operacao == 'DESCONTO') {
      _valorController.updateValue(Sessao.vendaAtual.taxaDesconto ?? 0);
      _subtitulo = 'Informe a taxa e a observação';
      _textoValor = 'Taxa';
    } else if (widget.operacao == 'CANCELAR_NFCE') {
      _subtitulo = 'Informe o Motivo do Cancelamento da NFC-e';
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
                  gradient: _gradienteTopo(),
                ),
              ),
              ListView.builder(
                itemCount: 3,
                itemBuilder: _mainListBuilder,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return cabecalhoTela(context);
    // if (index == 1) return dadosFechamento(context);
    if (index == 1) return conteudoTela(context);
    return null;
  }
  
  Container cabecalhoTela(BuildContext context) {
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
                    widget.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(_subtitulo),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10.0,
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
                  backgroundImage: AssetImage(Constantes.informaValorIcon),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Container conteudoTela(BuildContext context) {
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
                    const SizedBox(height: 10.0),
                    Visibility(
                      visible: widget.operacao != 'CANCELAR_NFCE',
                      child: TextField(
                        // enableInteractiveSelection: !Biblioteca.isDesktop(),
                        textAlign: TextAlign.end,
                        focusNode: _valorFoco,
                        keyboardType: TextInputType.number,
                        controller: _valorController,
                        decoration: getInputDecoration(
                          'Informe o valor desejado',
                          _textoValor,
                          false),
                        onSubmitted: (value) {
                          _efetuarOperacao();
                        },
                        onChanged: (text) {
                          if (widget.operacao == 'DESCONTO') {
                            if (_valorController.numberValue >= 100) {
                              _valorController.updateValue(99.9);
                            }
                          }
                        },                      
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Visibility(
                      visible: widget.operacao != 'DESCONTO',
                      child: TextField(
                        maxLines: 3,
                        controller: _observacaoController,
                        decoration: getInputDecoration(
                            widget.operacao != 'CANCELAR_NFCE' ? 'Informe a observação' : 'Informe o Motivo do Cancelamento', 
                            widget.operacao != 'CANCELAR_NFCE' ? 'Observação' : 'Motivo do Cancelamento', 
                            false),
                        onChanged: (text) {
                        },
                      ),
                      ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getBotoesRodape(context: context),
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

  List<Widget> _getBotoesRodape({BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
      Container(
        width: Biblioteca.isTelaPequena(context) ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Cancelar' : 'Cancelar [F11]',
          cor: Colors.red, 
          onPressed: () {
            Navigator.pop(context, false);
          }
        ),        
      ),
    );
    listaBotoes.add(
      SizedBox(width: 10.0),
    );
    listaBotoes.add(
      Container(
        width: Biblioteca.isTelaPequena(context) ? 130 : 150,
        child: getBotaoGenericoPdv(
          descricao: Biblioteca.isMobile() ? 'Confirmar' : 'Confirmar [F12]',
          cor: Colors.green, 
          onPressed: () {
            _efetuarOperacao();
          }
        ),
      ),
    );
    return listaBotoes;
  }

  void _efetuarOperacao() {
    if (widget.operacao == 'DESCONTO') {
      Sessao.vendaAtual = Sessao.vendaAtual.copyWith(
        taxaDesconto: _valorController.numberValue,
        valorDesconto: Biblioteca.calcularDesconto(Sessao.vendaAtual.valorFinal, _valorController.numberValue),
      );
      Navigator.pop(context, true);
    } else if (widget.operacao == 'SUPRIMENTO') {
      PdvSuprimento suprimento = 
      PdvSuprimento(
        id: null,
        idPdvMovimento: Sessao.movimento.id,
        dataSuprimento: DateTime.now(), 
        horaSuprimento: Biblioteca.formatarHora(DateTime.now()),
        valor: _valorController.numberValue,
        observacao: _observacaoController.text.isEmpty ? null : _observacaoController.text,
      );
      Sessao.db.pdvSuprimentoDao.inserir(suprimento);
      Navigator.pop(context, true);
    } else if (widget.operacao == 'SANGRIA') {
      PdvSangria sangria = 
      PdvSangria(
        id: null,
        idPdvMovimento: Sessao.movimento.id,
        dataSangria: DateTime.now(), 
        horaSangria: Biblioteca.formatarHora(DateTime.now()), 
        valor: _valorController.numberValue,
        observacao: _observacaoController.text.isEmpty ? null : _observacaoController.text,
      );
      Sessao.db.pdvSangriaDao.inserir(sangria);
      Navigator.pop(context, true);
    } else if (widget.operacao == 'CANCELAR_NFCE') {
      Navigator.pop(context, _observacaoController.text);  
    }
  }

  LinearGradient _gradienteTopo() {
    if (widget.operacao == 'DESCONTO') {
      return LinearGradient(colors: [Colors.red.shade200, Colors.red.shade600]);
    } else if (widget.operacao == 'SUPRIMENTO') {
      return LinearGradient(colors: [Colors.blue.shade200, Colors.blue.shade600]);
    } else {
      return LinearGradient(colors: [Colors.pink.shade200, Colors.pink.shade600]);
    }
  }
}