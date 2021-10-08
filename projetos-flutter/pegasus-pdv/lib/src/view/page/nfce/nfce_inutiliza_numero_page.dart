/*
Title: T2Ti ERP 3.0                                                                
Description: NFC-e - Página que serve para inutilizar números
                                                                                
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
import 'package:pegasus_pdv/src/service/service.dart';
import 'package:pegasus_pdv/src/controller/controller.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';

class NfceInutilizaNumeroPage extends StatefulWidget {
  
  const NfceInutilizaNumeroPage({Key key}): super(key: key);

  @override
  _NfceInutilizaNumeroPageState createState() => _NfceInutilizaNumeroPageState();
}

class _NfceInutilizaNumeroPageState extends State<NfceInutilizaNumeroPage> {
  final _titulo = 'NFC-e Inutilizar Número(s)';
  final _subtitulo = 'Informe os dados para inutilização do(s) número(s) da NFC-e';
  final _valorFoco = FocusNode();

  final _justificativaController = TextEditingController();
  final _numeroInicialController = MaskedTextController(
    mask: '000000000',
  );
  final _numeroFinalController = MaskedTextController(
    mask: '000000000',
  );

  static List<NfeCabecalho> _listaContingenciadasOrfas = [];

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
    _valorFoco.requestFocus();        

    WidgetsBinding.instance.addPostFrameCallback((_) => _listarContingenciadasOrfas());
  }

  Future<void> _tratarAcoesAtalhos(AtalhoTelaIntent intent) async {
    switch (intent.type) {
      case AtalhoTelaType.cancelar:
        Navigator.pop(context);
        break;
      case AtalhoTelaType.confirmar:
        await _efetuarOperacao();
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
                    _titulo,
                    style: Biblioteca.isTelaPequena(context) ? Theme.of(context).textTheme.headline6 : Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(_subtitulo, textAlign: TextAlign.center,),
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
                  backgroundImage: AssetImage(Constantes.dashboardIcon),
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
                    TextField(
                      enableInteractiveSelection: !Biblioteca.isDesktop(),
                      textAlign: TextAlign.end,
                      focusNode: _valorFoco,
                      keyboardType: TextInputType.number,
                      controller: _numeroInicialController,
                      decoration: getInputDecoration(
                        'Informe o número Inicial',
                        'Número Inicial',
                        false),
                      onSubmitted: (value) {
                      },
                      onChanged: (text) {
                      },                      
                    ),                    
                    const SizedBox(height: 24.0),
                    TextField(
                      enableInteractiveSelection: !Biblioteca.isDesktop(),
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      controller: _numeroFinalController,
                      decoration: getInputDecoration(
                        'Informe o número Final',
                        'Número Final',
                        false),
                      onSubmitted: (value) {
                      },
                      onChanged: (text) {
                      },                      
                    ),                    
                    const SizedBox(height: 24.0),
                    TextField(
                      maxLines: 3,
                      controller: _justificativaController,
                      decoration: getInputDecoration(
                          'Informe o Motivo da Inutilização', 
                          'Motivo da Inutilização', 
                          false),
                      onChanged: (text) {
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 170.0,
                      child: Scrollbar(
                        child: ListView(
                          padding: const EdgeInsets.all(2.0),
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Card(
                                color: Colors.white,
                                elevation: 2.0,
                                child: DataTable(
                                  columns: getColumnsOrfas(),
                                  rows: getRowsOrfas()),
                              ),
                            ),
                          ],
                        ),
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
          onPressed: () async {
            await _efetuarOperacao();
          }
        ),
      ),
    );
    return listaBotoes;
  }

  Future _listarContingenciadasOrfas() async {
    _listaContingenciadasOrfas = await Sessao.db.nfeCabecalhoDao.consultarNotasContingenciadasParaInutilizacao();
    setState(() {
    });
  }

  List<DataColumn> getColumnsOrfas() {
    List<DataColumn> lista = [];
    lista.add(DataColumn(
      label: Text(
        "Números Pendentes de Inutilização",
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ));
    return lista;
  }

  List<DataRow> getRowsOrfas() {
    List<DataRow> lista = [];
    for (var item in _listaContingenciadasOrfas) {
      List<DataCell> celulas = [];
      celulas = [
        DataCell(
          Text(
            item.numero,
          ), 
          onTap: () {
            _numeroInicialController.text = item.numero;
            _numeroFinalController.text = item.numero;
            _justificativaController.text = 'NOTA EMITIDA EM CONTINGENCIA OFFLINE';
          }),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  Future _efetuarOperacao() async {
    NfceAcbrService servicoNfce = NfceAcbrService();
    try {
      NfceController.instanciarNfceMontado();
      await servicoNfce.conectar(
        context, 
        formaEmissao: '1',
        operacao: 'INUTILIZAR_NUMERO', 
        funcaoDeCallBack: _atualizarDadosLocais, 
      ).then((socket) {
        NfceController.enviarComandoInutilizacaoNumero(
          socket: socket, 
          cnpj: Sessao.empresa.cnpj, 
          justificativa: _justificativaController.text, 
          ano: DateTime.now().year.toString(), 
          modelo: Sessao.numeroNfce.modelo, 
          serie: Sessao.numeroNfce.serie, 
          numeroInicial: _numeroInicialController.text, 
          numeroFinal: _numeroFinalController.text
        );
      });                 
    } catch (e) {
      gerarDialogBoxErro(context, 'Ocorreu um problema ao tentar realizar o procedimento: ' + e.toString());
    }   
  }

  Future _atualizarDadosLocais() async {
    NfceController.instanciarNfceMontado();
    int inicio = int.tryParse(_numeroInicialController.text);
    int fim = int.tryParse(_numeroFinalController.text);
    for (var i = inicio; i <= fim; i++) {
      // tabela de inutilização
      NfeNumeroInutilizado inutilizado = 
        NfeNumeroInutilizado(
          id: null,
          serie: Sessao.numeroNfce.serie,
          numero: i,
          dataInutilizacao: DateTime.now(),
          observacao: _justificativaController.text,
        );
      await Sessao.db.nfeNumeroInutilizadoDao.inserir(inutilizado);          
  
      // tabela de cabeçalho da nota
      NfceController.nfeCabecalhoMontado.nfeCabecalho = 
        await Sessao.db.nfeCabecalhoDao.consultarObjetoFiltro('NUMERO', i.toString().padLeft(9, '0')); // verifica se existe essa nota na base de dados, ela estará com o status=9
      if (NfceController.nfeCabecalhoMontado.nfeCabecalho != null) {
        NfceController.nfeCabecalhoMontado.nfeCabecalho = 
        NfceController.nfeCabecalhoMontado.nfeCabecalho.copyWith(
          statusNota: '8',
        );
        await Sessao.db.nfeCabecalhoDao.alterar(NfceController.nfeCabecalhoMontado, atualizaFilhos: false);
      }
    }
    
    gerarDialogBoxInformacao(context, 'Número(s) inutilizados com sucesso.');
    setState(() {
    });
  }    

  LinearGradient _gradienteTopo() {
    return LinearGradient(colors: [Colors.green.shade200, Colors.green.shade600]);
  }

}