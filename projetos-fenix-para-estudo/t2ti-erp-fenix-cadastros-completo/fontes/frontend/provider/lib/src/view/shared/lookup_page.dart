/*
Title: T2Ti ERP Fenix                                                                
Description: Página de lookup
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:recase/recase.dart';

import 'erro_page.dart';

import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/model/retorno_json_erro.dart';
import 'package:fenix/src/service/service_base.dart';

class LookupPage extends StatefulWidget {
  final String title;
  final List<String> colunas;
  final List<String> campos;
  final String rota;
  final String campoPesquisaPadrao;
  final String valorPesquisaPadrao;

  const LookupPage(
      {Key key,
      this.title,
      this.colunas,
      this.campos,
      this.rota,
      this.campoPesquisaPadrao,
      this.valorPesquisaPadrao})
      : super(key: key);

  @override
  LookupPageState createState() => LookupPageState();
}

class LookupPageState extends State<LookupPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static Map<String, dynamic> resultadoFiltro = {};
  static bool _dadosCarregados = true;
  static var objetoJsonErro = RetornoJsonErro();
  String campoFiltro;
  List<DataRow> _rowList = [];
  var valorFiltroController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.campoPesquisaPadrao != null) {
      campoFiltro = widget.colunas[widget.campos.indexOf(widget.campoPesquisaPadrao.constantCase)];
    }
    if (widget.valorPesquisaPadrao != null) {
      valorFiltroController.text = widget.valorPesquisaPadrao; 
      efetuarConsulta();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (objetoJsonErro.error != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[],
        ),
        body: ErroPage(objetoJsonErro: objetoJsonErro),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () async {
                await efetuarConsulta();
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Coluna',
                    hintText: 'Selecione a coluna para o filtro',
                    contentPadding: EdgeInsets.zero,
                  ),
                  isEmpty: campoFiltro == null,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: campoFiltro,
                    onChanged: (String newValue) {
                      setState(() {
                        campoFiltro = newValue;
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
                  child: TextFormField(
                    controller: valorFiltroController,
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
                      : DataTable(columns: getColumns(), rows: _rowList),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future efetuarConsulta() async {
    if (campoFiltro == null) {
      ViewUtilLib.showInSnackBar(
          'Por favor, selecione a coluna para o filtro',
          _scaffoldKey);
    } else {
      if (valorFiltroController.text == '') {
        ViewUtilLib.showInSnackBar(
            'Por favor, informe um valor para o filtro',
            _scaffoldKey);
      } else {
        // refresca a tela
        setState(() {
          _dadosCarregados = false;
        });
        _rowList.clear();
        var filtro = new Filtro();
        filtro.campo = widget.campos[widget.colunas.indexOf(campoFiltro)];
        filtro.valor = valorFiltroController.text;
        await filtarServidor(filtro);
      }
    }
  }

  Future filtarServidor(Filtro filtro) async {
    // pega o service base
    var serviceBase = new ServiceBase();
    // faz o tratamento do filtro
    serviceBase.tratarFiltro(filtro, widget.rota);
    // chama a API REST
    http.Response response = await http.get(serviceBase.url);

    if (response.statusCode == 200) {
      if (response.headers["content-type"].contains("html")) {
        objetoJsonErro.error = response.statusCode.toString();
        tratarErro(response.body, response.headers);
        return null;
      } else {
        var listaDadosJson = json.decode(response.body) as List<dynamic>;

        // faz o laço na lista de registros que desceu do servidor
        for (var objetoJson in listaDadosJson) {
          // cria o array que vai armazenar as celulas - cada linha da tabela possui um array de celulas
          List<DataCell> celulas = new List<DataCell>();

          /// compara os campos do objeto Json com as colunas desejadas para a datatable e
          /// preenche os campos de acordo
          for (var i = 0; i < widget.campos.length; i++) {
            var nomeCampoTabela = widget.campos[i].camelCase;
            for (var j = 0; j < objetoJson.length; j++) {
              var nomeCampoJson = objetoJson.keys.toList()[j];
              if (nomeCampoJson == nomeCampoTabela) {
                var conteudoCampo = objetoJson.values.toList()[j];
                DataCell celula =
                    new DataCell(Text(conteudoCampo.toString()), onTap: () {
                  resultadoFiltro = objetoJson;
                  Navigator.pop(context, resultadoFiltro);
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
      }
    } else {
      objetoJsonErro.error = response.statusCode.toString();
      tratarErro(response.body, response.headers);
      setState(() {
        _dadosCarregados = false;
      });
    }
  }

  List<DataColumn> getColumns() {
    List<DataColumn> lista = [];
    for (var i = 0; i < widget.colunas.length; i++) {
      lista.add(DataColumn(label: Text(widget.colunas[i])));
    }
    return lista;
  }

  void tratarErro(String corpo, Map<String, String> headers) {
    if (headers["content-type"].contains("application/json")) {
      Map<String, dynamic> body = json.decode(corpo);
      objetoJsonErro.status = body['status']?.toString() ?? body['statuscode'].toString();
      objetoJsonErro.error = body['error'] ?? body['classname'].toString();
      objetoJsonErro.message = body['message'];
      objetoJsonErro.trace = body['trace'];
      objetoJsonErro.tipo = 'json';
    } else if (headers["content-type"].contains("html")) {
      objetoJsonErro.message = corpo;
      objetoJsonErro.tipo = 'html';
    } else if (headers["content-type"].contains("plain")) {
      // texto puro
      objetoJsonErro.message = corpo;
      objetoJsonErro.tipo = 'text';
    }
  }

  // 20200501 - EIJE - substituido pelo método acima para tratar erros em outros formatos
  // tratarErro(Map<String, dynamic> erro) {
  //   objetoJsonErro.status = erro['status']?.toString() ?? erro['statuscode'].toString();
  //   objetoJsonErro.error = erro['error'] ?? erro['classname'].toString();
  //   objetoJsonErro.message = erro['message'];
  //   objetoJsonErro.trace = erro['trace'];
  // }
}
