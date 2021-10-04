/*
Title: T2Ti ERP 3.0
Description: Service utilizado para cadastrar o usuário do PDV na regatuarda da SH
                                                                                
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

import 'package:pegasus_pdv/src/service/service_base.dart';
import 'package:pegasus_pdv/src/model/filtro.dart';
import 'package:pegasus_pdv/src/model/model.dart';

/// classe responsável por requisições ao servidor REST
class UsuarioService extends ServiceBase {
  var clienteHTTP = Client();

  Future<List<UsuarioModel>> consultarLista({Filtro filtro}) async {
    var listaUsuarioModel = [];

    tratarFiltro(filtro, '/usuario/');
    final response = await clienteHTTP.get(Uri.tryParse(url));

    if (response.statusCode == 200) {
      if (response.headers["content-type"].contains("html")) {
        tratarRetornoErro(response.body, response.headers);
        return null;
      } else {
        var parsed = json.decode(response.body) as List<dynamic>;
        for (var usuario in parsed) {
          listaUsuarioModel.add(UsuarioModel.fromJson(usuario));
        }
        return listaUsuarioModel;
      }
    } else {
      tratarRetornoErro(response.body, response.headers);
      return null;
    }
  }

  Future<UsuarioModel> consultarObjeto(int id) async {
    final response = await clienteHTTP.get(Uri.http(endpoint, 'usuario/$id'));

    if (response.statusCode == 200) {
      if (response.headers["content-type"].contains("html")) {
        tratarRetornoErro(response.body, response.headers);
        return null;
      } else {
        var usuarioJson = json.decode(response.body);
        return UsuarioModel.fromJson(usuarioJson);
      }
    } else {
      tratarRetornoErro(response.body, response.headers);
      return null;
    }
  }

  Future<UsuarioModel> inserir(UsuarioModel usuario) async {
    final response = await clienteHTTP.post(
      Uri.tryParse('$endpoint/usuario'),
      headers: {"content-type": "application/json"},
      body: usuario.objetoEncodeJson(usuario),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.headers["content-type"].contains("html")) {
        tratarRetornoErro(response.body, response.headers);
        return null;
      } else {
        var usuarioJson = json.decode(response.body);
        return UsuarioModel.fromJson(usuarioJson);
      }
    } else {
      tratarRetornoErro(response.body, response.headers);
      return null;
    }
  }

  Future<UsuarioModel> alterar(UsuarioModel usuario) async {
    var id = usuario.id;
    final response = await clienteHTTP.put(
      Uri.tryParse('$endpoint/usuario/$id'),
      headers: {"content-type": "application/json"},
      body: usuario.objetoEncodeJson(usuario),
    );

    if (response.statusCode == 200) {
      if (response.headers["content-type"].contains("html")) {
        tratarRetornoErro(response.body, response.headers);
        return null;
      } else {
        var usuarioJson = json.decode(response.body);
        return UsuarioModel.fromJson(usuarioJson);
      }
    } else {
      tratarRetornoErro(response.body, response.headers);
      return null;
    }
  }

  Future<bool> excluir(int id) async {
    final response = await clienteHTTP.delete(
      Uri.tryParse('$endpoint/usuario/$id'),
      headers: {"content-type": "application/json"},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      tratarRetornoErro(response.body, response.headers);
      return null;
    }
  }  

  Future<UsuarioModel> registrar(UsuarioModel usuario) async {
    final response = await clienteHTTP.post(
      Uri.tryParse('$endpoint/usuario/registro'),
      headers: {
        "content-type": "application/json",
        },
      body: usuario.objetoEncodeJson(usuario),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.headers["content-type"].contains("html")) {
        tratarRetornoErro(response.body, response.headers);
        return null;
      } else {
        var usuarioJson = json.decode(response.body);
        return UsuarioModel.fromJson(usuarioJson);
      }
    } else {
      await tratarRetornoErro(response.body, response.headers);
      return null;
    }
  } 

  Future<UsuarioModel> gravarDadosInformacao(UsuarioModel usuario) async {
    final response = await clienteHTTP.post(
      Uri.tryParse('$endpoint/usuario/grava-dados-informacao'),
      headers: {
        "content-type": "application/json",
        },
      body: usuario.objetoEncodeJson(usuario),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.headers["content-type"].contains("html")) {
        tratarRetornoErro(response.body, response.headers);
        return null;
      } else {
        var usuarioJson = json.decode(response.body);
        return UsuarioModel.fromJson(usuarioJson);
      }
    } else {
      await tratarRetornoErro(response.body, response.headers);
      return null;
    }
  }   
}