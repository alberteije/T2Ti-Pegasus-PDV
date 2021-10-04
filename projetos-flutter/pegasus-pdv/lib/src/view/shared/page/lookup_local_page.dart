/*
Title: T2Ti ERP 3.0                                                                
Description: Página de lookup para consultas no banco de dados local
                                                                                
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
import 'package:recase/recase.dart';

import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/infra/atalhos_pdv.dart';

import 'package:pegasus_pdv/src/model/filtro.dart';

import 'package:pegasus_pdv/src/view/shared/caixas_de_dialogo.dart';

class LookupLocalPage extends StatefulWidget {
  final String title;
  final List<String> colunas;
  final List<String> campos;
  final String rota;
  final String campoPesquisaPadrao;
  final String valorPesquisaPadrao;
  final String filtroAdicional;
  final Function metodoConsultaCallBack;
  final Function metodoCadastroCallBack;
  final bool permiteCadastro;

  // TODO: limitar a quantidade de registros para não deixar a consulta lenta
  const LookupLocalPage(
      {Key key,
      this.title,
      this.colunas,
      this.campos,
      this.rota,
      this.campoPesquisaPadrao,
      this.valorPesquisaPadrao,
      this.metodoConsultaCallBack,
      this.metodoCadastroCallBack,
      this.filtroAdicional,
      this.permiteCadastro = false})
      : super(key: key);

  @override
  _LookupLocalPageState createState() => _LookupLocalPageState();
}

class _LookupLocalPageState extends State<LookupLocalPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static Map<String, dynamic> _resultadoFiltro = {};
  static bool _dadosCarregados = true;
  String _campoFiltro;
  List<DataRow> _rowList = [];
  final _valorFiltroController = TextEditingController();
  final _focusNode = FocusNode();

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
    if (widget.campoPesquisaPadrao != null) {
      _campoFiltro = widget.colunas[widget.campos.indexOf(widget.campoPesquisaPadrao.constantCase)];
    }
    if (widget.valorPesquisaPadrao != null) {
      _valorFiltroController.text = widget.valorPesquisaPadrao; 
      WidgetsBinding.instance.addPostFrameCallback((_) => _efetuarConsulta());
    }
    _focusNode.requestFocus();
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
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title),
            actions: _getActions(),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Coluna',
                    hintText: 'Selecione a coluna para o filtro',
                    contentPadding: EdgeInsets.zero,
                  ),
                  isEmpty: _campoFiltro == null,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _campoFiltro,
                    onChanged: (String newValue) {
                      setState(() {
                        _campoFiltro = newValue;
                      });
                    },
                    items: widget.colunas
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 1.0),
                Container(
                  height: 90.0,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  alignment: Alignment.bottomLeft,
                  child: TextField(
                    focusNode: _focusNode,
                    onSubmitted: (value) async {
                      await _efetuarConsulta();
                    },
                    controller: _valorFiltroController,
                    decoration: const InputDecoration(
                      labelText: 'Valor',
                      hintText: 'Informe o valor do filtro para a consulta',
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8.0),
                  child: _dadosCarregados == false
                      ? Center(child: CircularProgressIndicator())
                      : DataTable(columns: _getColumns(), rows: _rowList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _efetuarConsulta() async {
    if (_campoFiltro == null) {
      showInSnackBar('Por favor, selecione a coluna para o filtro', context);
      _focusNode.requestFocus();
    } else {
      if (_valorFiltroController.text == '') {
        showInSnackBar('Por favor, informe um valor para o filtro', context);
        _focusNode.requestFocus();
      } else {
        // refresca a tela
        setState(() {
          _dadosCarregados = false;
        });
        _rowList.clear();
        var filtro = Filtro();
        filtro.campo = widget.campos[widget.colunas.indexOf(_campoFiltro)];
        filtro.valor = _valorFiltroController.text;
        filtro.condicao = 'cont';
        filtro.where = widget.filtroAdicional;
        await widget.metodoConsultaCallBack(filtro.campo, filtro.valor);
        await _carregarDados(filtro);
      }
    }
  }

  Future _carregarDados(Filtro filtro) async {
    var listaDadosJson = json.decode(Sessao.retornoJsonLookup) as List<dynamic>;

    // faz o laço na lista de registros da consulta
    for (var objetoJson in listaDadosJson) {
      // cria o array que vai armazenar as celulas - cada linha da tabela possui um array de celulas
      List<DataCell> celulas = [];

      /// compara os campos do objeto Json com as colunas desejadas para a datatable e
      /// preenche os campos de acordo
      for (var i = 0; i < widget.campos.length; i++) {
        var nomeCampoTabela = widget.campos[i].camelCase;
        for (var j = 0; j < objetoJson.length; j++) {
          var nomeCampoJson = objetoJson.keys.toList()[j];
          if (nomeCampoJson == nomeCampoTabela) {
            var conteudoCampo = objetoJson.values.toList()[j];
            DataCell celula = DataCell(Text(Biblioteca.formatarCampoLookup(conteudoCampo.toString(), 
            formatoTimeStamp: nomeCampoJson.contains('data'))), onTap: () {
              _resultadoFiltro = objetoJson;
              Navigator.pop(context, _resultadoFiltro);
            });
            celulas.add(celula);
          }
        }
      }
      _rowList.add(DataRow(cells: celulas));
    }
    // refresca a tela
    setState(() {
      _dadosCarregados = true;
    });
    _focusNode.requestFocus();
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> lista = [];
    for (var i = 0; i < widget.colunas.length; i++) {
      lista.add(DataColumn(label: Text(widget.colunas[i])));
    }
    return lista;
  }

  List<Widget> _getActions() {
    List<Widget> botoes = [];
    botoes.add(
      IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: () async {
          await _efetuarConsulta();
        },
      ),
    );

    if (widget.permiteCadastro) {
      botoes.add(
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: widget.metodoCadastroCallBack,
        ),
      );
    }

    return botoes;      
  }
}
