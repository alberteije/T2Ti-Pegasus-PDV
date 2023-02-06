/*
Title: T2Ti ERP 3.0
Description: Service utilizado para sincronizar os dados
                                                                                
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

import 'package:http/http.dart' show Client;
import 'package:pegasus_pdv/src/infra/infra.dart';
import 'package:pegasus_pdv/src/model/model.dart';

import 'package:pegasus_pdv/src/service/service_base.dart';

/// classe responsável por requisições ao servidor REST
class SincronizaService extends ServiceBase {
  var clienteHTTP = Client();

  // use para subir o banco SQLite completo
  Future<bool> subirDadosServidor(String arquivoBase64) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/sincroniza/upload/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        body: Biblioteca.cifrar(arquivoBase64),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return false;
        } else {
          return true;
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return false;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return false;
    }
  }

  // use para subir as tabelas no formato JSON
  Future<bool> subirTabelasCentrais(String listaSincroniza) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/sincroniza/upload/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        body: Biblioteca.cifrar(listaSincroniza),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return false;
        } else {
          return true;
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return false;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return false;
    }
  }

  Future<bool> subirDadosMovimento(String arquivoBase64) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!),
                              "dispositivo": Biblioteca.cifrar(Sessao.pdvCaixa!.nome!),
                              "movimento": Biblioteca.cifrar(Sessao.movimento!.id.toString())
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!),
                              "dispositivo": Biblioteca.cifrar(Sessao.pdvCaixa!.nome!),
                              "movimento": Biblioteca.cifrar(Sessao.movimento!.id.toString())
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/sincroniza/upload-movimento/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        body: Biblioteca.cifrar(arquivoBase64),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return false;
        } else {
          return true;
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return false;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return false;
    }
  }

  Future<List<ObjetoSincroniza>?> descerDadosServidor() async {
    try {
      List<ObjetoSincroniza> listaObjetoSincroniza = [];

      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              };   

      final response = await clienteHTTP.get(
        Uri.tryParse('$endpoint/sincroniza/download/')!,
        headers: ServiceBase.cabecalhoRequisicao
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var parsed = json.decode(Biblioteca.decifrar(response.body)) as List<dynamic>;
          for (var objSincroniza in parsed) {
            listaObjetoSincroniza.add(ObjetoSincroniza.fromJson(objSincroniza));
          }
          return listaObjetoSincroniza;
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return null;
    }
  }

}