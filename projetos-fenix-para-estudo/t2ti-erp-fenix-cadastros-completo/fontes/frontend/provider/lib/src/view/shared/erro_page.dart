/*
Title: T2Ti ERP Fenix                                                                
Description: Página que exibe um erro local ou que retornou do servidor
                                                                                
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
import 'package:http/http.dart' show Client;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:fenix/src/model/retorno_json_erro.dart';

class ErroPage extends StatefulWidget {
  final RetornoJsonErro objetoJsonErro;

  const ErroPage({Key key, this.objetoJsonErro}) : super(key: key);

  @override
  ErroPageState createState() => ErroPageState();
}

class ErroPageState extends State<ErroPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 180.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/error.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ocorreu um Erro',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: getErro(context),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    color: Colors.black12,
                    child: Text('Área de Trabalho',
                        semanticsLabel: 'Área de Trabalho'),
                    textColor: Colors.indigo,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/home',
                      );
                    },
                  ),
                  FlatButton(
                    color: Colors.black12,
                    child:
                        Text('Reportar Erro', semanticsLabel: 'Reportar erro'),
                    textColor: Colors.indigo,
                    onPressed: () async {
                      await reportarErro();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getErro(BuildContext context) {
    if (widget.objetoJsonErro.tipo == 'json') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Status: ' + widget.objetoJsonErro.status ?? '',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.blueAccent),
              textAlign: TextAlign.left),
          Text('Erro: ' + widget.objetoJsonErro.error ?? '',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.purple),
              textAlign: TextAlign.left),
          Text('Mensagem: ' + widget.objetoJsonErro.message ?? ''),
        ],
      );
    } else if (widget.objetoJsonErro.tipo == 'text') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Erro: ' + widget.objetoJsonErro.error ?? '',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.purple),
              textAlign: TextAlign.left),
          Text('Mensagem: ' + widget.objetoJsonErro.message ?? ''),
        ],
      );
    } else if (widget.objetoJsonErro.tipo == 'html') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Html(
            data: widget.objetoJsonErro.message.replaceAll('font', 'br'),
          ),
        ],
      );
    }
    return Text('Erro desconhecido.');
  }

  Future reportarErro() async {
    // pega o id da lista
    String idLista = '5eab0466df710a3jd7ufvb55';

    // key e token
    String key = 'gere sua key: https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/';
    String token = 'gere sey token: https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/';

    // pega os dados do usuário
    // TODO: pegar os dados reais do usuário
    // TODO: impedir que o usuário reporte o mesmo problema várias vezes
    String usuario = 'Albert Eije - 555666';

    // dados do erro
    String codigo = widget.objetoJsonErro.status ?? '';
    String error = widget.objetoJsonErro.error ?? '';
    String mensagem = widget.objetoJsonErro.message ?? '';
    mensagem = mensagem.replaceAll('#', '');
    String trace = widget.objetoJsonErro.trace ?? '';
    trace = trace.replaceAll('#', '');

    if (widget.objetoJsonErro.tipo == 'html') {
      mensagem = 'Arquivo HTML em Anexo';
    }

    // formata a mensagem
    String nomeCartao = '[30/04/2019] BUG Reportado por ' + usuario;
    String descricaoCartao = '';
    descricaoCartao = descricaoCartao + 'Erro reportado pelo usuário ' + usuario + '\n';
    descricaoCartao = descricaoCartao + '===\n';
    descricaoCartao = descricaoCartao + '**Formato do Erro**\n';
    descricaoCartao = descricaoCartao + widget.objetoJsonErro.tipo + '\n';
    descricaoCartao = descricaoCartao + '**Código**\n';
    descricaoCartao = descricaoCartao + codigo + '\n';
    descricaoCartao = descricaoCartao + '**Erro**\n';
    descricaoCartao = descricaoCartao + error + '\n';
    descricaoCartao = descricaoCartao + '**Mensagem**\n';
    descricaoCartao = descricaoCartao + mensagem + '\n';
    descricaoCartao = descricaoCartao + '**Trace**\n';
    descricaoCartao = descricaoCartao + trace + '\n';

    // monta a URL
    String urlBase = 'https://api.trello.com/1/cards?idList=' + idLista + '&pos=top&key=' + key + '&token=' + token + '&name=' + nomeCartao + '&desc=' + descricaoCartao;

    // executa o POST
    var clienteHTTP = Client();

    // primeiro cria o cartão
    var response = await clienteHTTP.post(
      urlBase,
      headers: {"content-type": "application/json"},
    );

    // se o cartão foi inserido com sucesso, pega o id dele e continua com a lógica
    if (response.statusCode == 200) {
      var cartaoInserido = json.decode(response.body);

      // se tiver HTML, anexa o conteúdo ao cartão
      if (widget.objetoJsonErro.tipo == 'html') {
        urlBase = 'https://api.trello.com/1/cards/' + cartaoInserido["id"] + '/attachments?key=' + key + '&token=' + token + '&mimeType=text/html&name=erro.html&file=' + widget.objetoJsonErro.message.replaceAll('#', '');

        response = await clienteHTTP.post(
          urlBase,
          headers: {"Accept": "application/json"},
        );
      }

      ViewUtilLib.gerarDialogBoxInformacao(
          context, 'Erro reportado com sucesso!', () {
        Navigator.pushNamed(context, '/home',);
      });
      
    } else {
      ViewUtilLib.gerarDialogBoxInformacao(
          context, 'Ocorreu um Problema ao Tentar Reportar o Erro', () {
        Navigator.pushNamed(context, '/home',);
      });
    }

  }
}
