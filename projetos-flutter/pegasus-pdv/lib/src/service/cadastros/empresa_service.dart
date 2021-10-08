/*
Title: T2Ti ERP 3.0
Description: Service utilizado para consumir os webservices referentes à EMPRESA
                                                                                
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

import 'package:pegasus_pdv/src/service/service_base.dart';
import 'package:pegasus_pdv/src/model/model.dart';

class EmpresaService extends ServiceBase {
  var clienteHTTP = Client();

  Future<EmpresaConsultaPublica> consultarObjetoPublico(String cnpj) async {
    try {
      final _url = 'https://www.receitaws.com.br/v1/cnpj/$cnpj';
      final response = await clienteHTTP.get(Uri.tryParse(_url));

      if (response.statusCode == 200) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var empresaJson = json.decode(response.body);
          return EmpresaConsultaPublica.fromJson(empresaJson);
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

  Future<EmpresaModel> atualizar(EmpresaModel empresa) async {
    try {
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/empresa'),
        headers: ServiceBase.cabecalhoRequisicao,
        body: empresa.objetoEncodeJson(empresa),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var empresaJson = json.decode(response.body);
          return EmpresaModel.fromJson(empresaJson);
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
  
  Future<EmpresaModel> registrar(EmpresaModel empresa) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer " + Sessao.tokenJWT, "operacao": "registrar"} 
                            : {"content-type": "application/json", "authorization": "Bearer " + Sessao.tokenJWT, "operacao": "registrar"};      

      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/empresa/' + empresa.cnpj),
        headers: ServiceBase.cabecalhoRequisicao,
        body: empresa.objetoEncodeJson(empresa),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var empresaJson = json.decode(response.body);
          return EmpresaModel.fromJson(empresaJson);
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return null;
    }
    /* use para uma release de testes
    empresa.registrado = "S";
    return empresa;
    */
  }

  Future<bool> reenviarEmail(EmpresaModel empresa) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer " + Sessao.tokenJWT, "operacao": "reenviar-email"} 
                            : {"content-type": "application/json", "authorization": "Bearer " + Sessao.tokenJWT, "operacao": "reenviar-email"};      

      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/empresa/' + empresa.cnpj),
        headers: ServiceBase.cabecalhoRequisicao,
        body: empresa.objetoEncodeJson(empresa),
      );

      if (response.statusCode == 200) {
        if (response.headers["content-type"].contains("html")) {
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

  Future<EmpresaModel> conferirCodigoConfirmacao(EmpresaModel empresa, String codigoConfirmacao) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer " + Sessao.tokenJWT, "operacao": "confirmar-codigo", "codigo-confirmacao": codigoConfirmacao} 
                            : {"content-type": "application/json", "authorization": "Bearer " + Sessao.tokenJWT, "operacao": "confirmar-codigo", "codigo-confirmacao": codigoConfirmacao};      

      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/empresa/' + empresa.cnpj),
        headers: ServiceBase.cabecalhoRequisicao,
        body: empresa.objetoEncodeJson(empresa),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var empresaJson = json.decode(response.body);
          return EmpresaModel.fromJson(empresaJson);
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return null;
    }
     /* use para uma release de testes
    empresa.registrado = "S";
    return empresa;
    */
 }

}