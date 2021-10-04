/*
Title: T2Ti ERP 3.0                                                                
Description: Caixa - Página de parcelamento para o contas a receber
                                                                                
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:pegasus_pdv/src/database/database.dart';
import 'package:pegasus_pdv/src/database/database_classes.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/view/shared/botoes.dart';
import 'package:pegasus_pdv/src/view/shared/widgets_input.dart';
import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';
import 'package:pegasus_pdv/src/view/shared/view_util_lib.dart';
import 'package:pegasus_pdv/src/view/shared/page/lookup_local_page.dart';

class ParcelamentoReceitasPage extends StatefulWidget {
  final String title;
  final double totalParcelamento;

  const ParcelamentoReceitasPage({Key key, this.title, this.totalParcelamento}) : super(key: key);

  @override
  _ParcelamentoReceitasPageState createState() => _ParcelamentoReceitasPageState();
}

class _ParcelamentoReceitasPageState extends State<ParcelamentoReceitasPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  final _valorFoco = FocusNode();
  List<ContasReceber> _listaParcelas = [];

  final _quantidadeParcelasController = MaskedTextController(
    mask: Constantes.mascaraQUANTIDADE_INTEIRO,
    text: '',
  );
  final _diaFixoParcelaController = MaskedTextController(
    mask: Constantes.mascaraDIA,
    text: '',
  );
  final _intervaloEntreParcelasController = MaskedTextController(
    mask: Constantes.mascaraQUANTIDADE_INTEIRO,
    text: '',
  );
  DateTime _diaPrimeiroVencimento = DateTime.now();
  final _importaClienteController = TextEditingController(
    text: Sessao.vendaAtual.nomeCliente,
  );

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
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );
    _valorFoco.requestFocus();        
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.cancelar:
        Navigator.pop(context);
        break;
      case AtalhoTelaType.confirmar:
        _confirmar();
        break;
      case AtalhoTelaType.escape:
        Navigator.pop(context);
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
          body: Form(
            key: _formKey,
            autovalidateMode: _autoValidate,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.deepOrangeAccent.shade200, Colors.deepPurple.shade600]),
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
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return cabecalhoTela(context);
    // if (index == 1) return dadosFechamento(context);
    if (index == 1) return rodapeTela(context);
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
                  BootstrapContainer(                    
                    fluid: true,
                    decoration: BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
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
                                    Text("Financeiro - Contas a Receber",),
                                    Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      thickness: 2,
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    BootstrapRow(
                                      height: 40,
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-12',
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10),
                                            height: 30,
                                            child: FittedBox(
                                              child: Text(
                                                'Valor a Parcelar: R\$ ${Constantes.formatoDecimalValor.format(widget.totalParcelamento ?? 0)}',
                                                style: TextStyle(
                                                  color: Colors.blue.shade900,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    BootstrapRow(
                                      height: 60,
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-12',
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: TextFormField(
                                                    validator: ValidaCampoFormulario.validarObrigatorio,
                                                    controller: _importaClienteController,
                                                    readOnly: true,
                                                    decoration: getInputDecoration(
                                                      'Conteúdo para o campo Cliente',
                                                      'Cliente *',
                                                      false),
                                                    onSaved: (String value) {
                                                    },
                                                    onChanged: (text) {
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 0,
                                                child: IconButton(
                                                  tooltip: 'Importar Cliente',
                                                  icon: ViewUtilLib.getIconBotaoLookup(),
                                                  onPressed: () async {
                                                    ///chamando o lookup
                                                    Map<String, dynamic> _objetoJsonRetorno =
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext context) =>
                                                          LookupLocalPage(
                                                            title: 'Importar Cliente',
                                                            colunas: ClienteDao.colunas,
                                                            campos: ClienteDao.campos,
                                                            campoPesquisaPadrao: 'Nome',
                                                            valorPesquisaPadrao: '%',
                                                            metodoConsultaCallBack: _filtrarClienteLookup,  
                                                            permiteCadastro: true,
                                                            metodoCadastroCallBack: () { Navigator.pushNamed(context, '/clienteLista',); },                                           
                                                          ),
                                                          fullscreenDialog: true,
                                                        ));
                                                    if (_objetoJsonRetorno != null) {
                                                      if (_objetoJsonRetorno['nome'] != null) {
                                                        _importaClienteController.text = _objetoJsonRetorno['nome'];
                                                        Sessao.vendaAtual = 
                                                        Sessao.vendaAtual.copyWith(
                                                          idCliente: _objetoJsonRetorno['id'],
                                                          nomeCliente: _objetoJsonRetorno['nome'],
                                                          cpfCnpjCliente: _objetoJsonRetorno['cpfCnpj'],
                                                        );
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(color: Colors.white,),
                                    BootstrapRow(
                                      height: 60,
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-12 col-md-6',
                                          child: Padding(
                                            padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                            child: TextFormField(
                                              enableInteractiveSelection: !Biblioteca.isDesktop(),
                                              focusNode: _valorFoco,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.end,
                                              controller: _quantidadeParcelasController,
                                              decoration: getInputDecoration(
                                                '',
                                                'Quantidade de Parcelas',
                                                false,),
                                              onSaved: (String value) {
                                              },
                                              onChanged: (text) {
                                              },
                                            ),
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-12 col-md-6',
                                          child: Padding(
                                            padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              maxLength: 2,
                                              maxLines: 1,
                                              controller: _intervaloEntreParcelasController,
                                              decoration: getInputDecoration(
                                                '',
                                                'Intervalo entre Parcelas',
                                                false),
                                              onSaved: (String value) {
                                              },
                                              onChanged: (text) {
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(color: Colors.white,),
                                    BootstrapRow(
                                      height: 60,
                                      children: <BootstrapCol>[
                                        BootstrapCol(
                                          sizes: 'col-12 col-md-6',
                                          child: Padding(
                                            padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                            child: InputDecorator(
                                              decoration: getInputDecoration(
                                                'Conteúdo para o campo Dia Primeiro Vencimento',
                                                'Dia Primeiro Vencimento',
                                                true),
                                              isEmpty: _diaPrimeiroVencimento == null,
                                              child: DatePickerItem(
                                                mascara: 'dd/MM/yyyy',
                                                dateTime: _diaPrimeiroVencimento,
                                                firstDate: DateTime.parse('1900-01-01'),
                                                lastDate: DateTime.parse('2050-01-01'),
                                                onChanged: (DateTime value) {
                                                  setState(() {
                                                    _diaPrimeiroVencimento = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        BootstrapCol(
                                          sizes: 'col-12 col-md-6',
                                          child: Padding(
                                            padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                            child: TextFormField(
                                              maxLength: 2,
                                              keyboardType: TextInputType.number,
                                              controller: _diaFixoParcelaController,
                                              decoration: getInputDecoration(
                                                'Permite informar um dia fixo para as parcelas que serão geradas no Contas a Pagar.',
                                                'Dia Fixo da Parcela',
                                                true,
                                                paddingVertical: 15,
                                                ),
                                              onSaved: (String value) {
                                              },
                                              onChanged: (text) {
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(color: Colors.white,),
                                    getBotaoGenericoPdv(
                                      descricao: 'Gerar Parcelas',
                                      cor: Colors.blue, 
                                      onPressed: () {
                                        _gerarParcelas();
                                      }
                                    ),                                         
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Divider(
                                      indent: 0,
                                      endIndent: 0,
                                      thickness: 2,
                                    ),
                                    Container(
                                      height: 200.0,
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
                                                    columns: getColumnsParcelamento(),
                                                    rows: getRowsParcelamento()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Divider(
                                      indent: 0,
                                      endIndent: 0,
                                      thickness: 2,
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
                  backgroundImage: AssetImage(Constantes.parcelamentoIcon),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<DataColumn> getColumnsParcelamento() {
    List<DataColumn> lista = [];
    lista.add(DataColumn(
      label: Text(
        "Vencimento",
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ));
    lista.add(DataColumn(
      numeric: true,
      label: Text(
        "Valor",
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ));
    lista.add(DataColumn(
      label: Text(
        "Histórico",
        style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ));
    return lista;
  }

  List<DataRow> getRowsParcelamento() {
    List<DataRow> lista = [];
    for (var parcelaReceber in _listaParcelas) {
      List<DataCell> celulas = [];

      celulas = [
        DataCell(
          Text(Biblioteca.formatarData( parcelaReceber.dataVencimento)), 
        ),
        DataCell(
          Text('${Constantes.formatoDecimalValor.format(parcelaReceber.valorAReceber ?? 0)}'),
        ),
        DataCell(
          Text(parcelaReceber.historico),
        ),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  Container rodapeTela(BuildContext context) {
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
            _confirmar();
          }
        ),
      ),
    );
    return listaBotoes;
  }

  void _filtrarClienteLookup(String campo, String valor) async {
    var listaFiltrada = await Sessao.db.clienteDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  bool _gerarParcelas() {
    bool podeGerar = true;
    var dataPrimeiroVencimento = _diaPrimeiroVencimento;
    final diaFixoParcela = int.tryParse(_diaFixoParcelaController.text) ?? 0;
    final quantidadeParcelas = int.tryParse(_quantidadeParcelasController.text) ?? 0;
    final intervaloEntreParcelas = int.tryParse(_intervaloEntreParcelasController.text) ?? 0;
    final diaVencimentoFixo = diaFixoParcela > 0;

    if (quantidadeParcelas <= 0) {
      showInSnackBar("Por favor, informe a quantidade de parcelas.", context);          
      podeGerar = false;
    }
    if (dataPrimeiroVencimento == null) {
      showInSnackBar("Por favor, informe o primeiro dia do vencimento.", context);          
      podeGerar = false;
    }
    if (intervaloEntreParcelas <= 0 && diaFixoParcela <= 0) {
      showInSnackBar("Por favor, informe o intervalo entre as pacelas OU o dia fixo.", context);          
      podeGerar = false;
    }
    // gera as parcelas
    if (podeGerar) {
      _listaParcelas = [];

      // se tiver dia fixo, calcula as parcelas levando em conta apenas o mes
      if (diaVencimentoFixo) {
        dataPrimeiroVencimento = DateTime.utc(_diaPrimeiroVencimento.year, _diaPrimeiroVencimento.month, diaFixoParcela);        
      } 

      // gera as parcelas de acordo com critérios informados
      Sessao.listaParcelamento = [];
      num somaParcelas = 0;
      num residuo = 0;
      for (var i = 0; i < quantidadeParcelas; i++) {
        var parcelaReceber = 
          ContasReceber(
            id: null,
            idCliente: Sessao.vendaAtual.idCliente,
            idPdvVendaCabecalho: Sessao.vendaAtual.id,
            dataLancamento: DateTime.now(),
            dataVencimento: (diaVencimentoFixo) 
                            ? DateTime.utc(dataPrimeiroVencimento.year, dataPrimeiroVencimento.month + i, dataPrimeiroVencimento.day)
                            : dataPrimeiroVencimento.add(Duration(days: intervaloEntreParcelas * i)),
            valorAReceber: num.parse((widget.totalParcelamento / quantidadeParcelas).toStringAsFixed(Constantes.decimaisValor)),
            statusRecebimento: 'A',
            historico: 'Gerado pela venda número ' + Sessao.vendaAtual.id.toString() + ' Parcela ' + (i+1).toString() + ' de ' + _quantidadeParcelasController.text,
          );
        _listaParcelas.add(parcelaReceber);
        Sessao.listaParcelamento.add(ContasReceberMontado(contasReceber: parcelaReceber));
        somaParcelas = somaParcelas + parcelaReceber.valorAReceber;
      }
      // verifica se sobraram centavos no cálculo e lança na primeira parcela
      residuo = widget.totalParcelamento - somaParcelas;
      if (residuo != 0) {
        var primeiraParcela = _listaParcelas[0];
        primeiraParcela = primeiraParcela.copyWith(
          valorAReceber: primeiraParcela.valorAReceber + residuo,
        );
      } 
      setState(() {
      });
    }
    return podeGerar;
  }

  void _confirmar() {
    if (_gerarParcelas()) {
      final FormState form = _formKey.currentState;
      if (!form.validate()) {
        _autoValidate = AutovalidateMode.always;
        showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
      } else {
        gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
          await Sessao.db.contasReceberDao.inserirParcelas(_listaParcelas);
          Navigator.of(context).pop(true);
        });
      }
    }
  }

}