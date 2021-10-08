/*
Title: T2Ti ERP 3.0
Description: Service utilizado para consumir os métodos da NFC-e no servidor
                                                                                
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
import 'dart:typed_data';

import 'package:http/http.dart' show Client;
import 'package:pegasus_pdv/src/infra/infra.dart';

import 'package:pegasus_pdv/src/service/service_base.dart';
import 'package:pegasus_pdv/src/model/filtro.dart';
import 'package:pegasus_pdv/src/model/model.dart';

/// classe responsável por requisições ao servidor REST
class NfceService extends ServiceBase {
  var clienteHTTP = Client();

  Future<List<PdvTipoPlanoModel>> consultarListaTipoPlanoNfce({Filtro filtro}) async {
    List<PdvTipoPlanoModel> listaNfceTipoPlanoModel = [];
    
    try {
      tratarFiltro(filtro, '/pdv-tipo-plano/');
	  	
      final response = await clienteHTTP.get(Uri.tryParse(url), headers: ServiceBase.cabecalhoRequisicao);

      if (response.statusCode == 200) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var parsed = json.decode(response.body) as List<dynamic>;
          for (var pdvTipoPlano in parsed) {
            final tipoPlano = PdvTipoPlanoModel.fromJson(pdvTipoPlano);
            if (tipoPlano.moduloFiscal == 'NFC') {
              listaNfceTipoPlanoModel.add(tipoPlano);
            }
          }
          return listaNfceTipoPlanoModel;
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
    List<PdvTipoPlanoModel> listaNfceTipoPlanoModel = [];
    PdvTipoPlanoModel plano1 = PdvTipoPlanoModel();
    plano1.id = 1;
    plano1.modulo = 'F';
    plano1.plano = 'Mensal';
    plano1.moduloFiscal = 'NFC';
    plano1.valor = 15;
    listaNfceTipoPlanoModel.add(plano1);
    PdvTipoPlanoModel plano2 = PdvTipoPlanoModel();
    plano2.id = 2;
    plano2.modulo = 'F';
    plano2.plano = 'Semestral';
    plano2.moduloFiscal = 'NFC';
    plano2.valor = 75;
    listaNfceTipoPlanoModel.add(plano2);
    PdvTipoPlanoModel plano3 = PdvTipoPlanoModel();
    plano3.id = 3;
    plano3.modulo = 'F';
    plano3.plano = 'Anual';
    plano3.moduloFiscal = 'NFC';
    plano3.valor = 120;
    listaNfceTipoPlanoModel.add(plano3);
    return listaNfceTipoPlanoModel;
    */
  }

  Future<NfcePlanoPagamentoModel> verificarPlano() async {  
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer " + Sessao.tokenJWT, "cnpj": Sessao.empresa.cnpj} 
                            : {"content-type": "application/json", "authorization": "Bearer " + Sessao.tokenJWT, "cnpj": Sessao.empresa.cnpj};      
      final response = await clienteHTTP.get(Uri.tryParse('$endpoint/pdv-plano-pagamento/'+Sessao.empresa.cnpj), headers: ServiceBase.cabecalhoRequisicao);

      if (response.statusCode == 200) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var objetoJson = json.decode(response.body);
          return NfcePlanoPagamentoModel.fromJson(objetoJson);
        }
      } else if (response.statusCode == 404) {
        return null;
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return null;
    }
    /* use para uma release de testes
    NfcePlanoPagamentoModel plano = NfcePlanoPagamentoModel();
    plano.statusPagamento = '3';
    plano.dataPlanoExpira = DateTime(2036, 4, 24);
    return plano;
    */  
  }  

  Future<Uint8List> baixarArquivosXml(String periodo) async { 
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer " + Sessao.tokenJWT, "cnpj": Sessao.empresa.cnpj, "periodo": periodo} 
                            : {"content-type": "application/json", "authorization": "Bearer " + Sessao.tokenJWT, "cnpj": Sessao.empresa.cnpj, "periodo": periodo};      
      final response = await clienteHTTP.get(Uri.tryParse('$endpoint/nfe-configuracao'), headers: ServiceBase.cabecalhoRequisicao);

      if (response.statusCode == 200) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          final arquivoZip = response.bodyBytes;
          return arquivoZip; 
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

  Future<NfeConfiguracaoModel> atualizarConfiguracoesMonitor(NfeConfiguracaoModel nfeConfiguracao, String cnpj) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer " + Sessao.tokenJWT, "pdv-configuracao": json.encode(Sessao.configuracaoPdv)} 
                            : {"content-type": "application/json", "authorization": "Bearer " + Sessao.tokenJWT, "pdv-configuracao": json.encode(Sessao.configuracaoPdv)};      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/nfe-configuracao/$cnpj'),
        headers: ServiceBase.cabecalhoRequisicao,
        body: nfeConfiguracao.objetoEncodeJson(nfeConfiguracao),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var configuracaoJson = json.decode(response.body);
          final enderecoMonitor = response.headers["endereco-monitor"];
          final portaMonitor = response.headers["porta-monitor"];
          Sessao.configuracaoPdv = Sessao.configuracaoPdv.copyWith(
            acbrMonitorEndereco: enderecoMonitor,
            acbrMonitorPorta: int.tryParse(portaMonitor),
          );
          await Sessao.db.pdvConfiguracaoDao.alterar(Sessao.configuracaoPdv);
          return NfeConfiguracaoModel.fromJson(configuracaoJson);
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
    final enderecoMonitor = '127.0.0.1';
    final portaMonitor = '3434';
    Sessao.configuracaoPdv = Sessao.configuracaoPdv.copyWith(
      acbrMonitorEndereco: enderecoMonitor,
      acbrMonitorPorta: int.tryParse(portaMonitor),
    );
    await Sessao.db.pdvConfiguracaoDao.alterar(Sessao.configuracaoPdv);    
    return nfeConfiguracao;
    */
  }

  Future<int> confirmarTransacao(String codigoTransacao) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer " + Sessao.tokenJWT, "cnpj": Sessao.empresa.cnpj} 
                            : {"content-type": "application/json", "authorization": "Bearer " + Sessao.tokenJWT, "cnpj": Sessao.empresa.cnpj};      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/pdv-plano-pagamento/$codigoTransacao'),
        headers: ServiceBase.cabecalhoRequisicao,
        // body: {"vazio": "vazio"} ,
      );

      return response.statusCode;
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return null;
    }
    /* use para uma release de testes
    return 200;
    */
  }

  Future<bool> atualizarCertificadoDigital(String arquivoBase64, String senha) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer " + Sessao.tokenJWT, "hash-registro": senha, "cnpj": Sessao.empresa.cnpj} 
                            : {"content-type": "application/json", "authorization": "Bearer " + Sessao.tokenJWT, "hash-registro": senha, "cnpj": Sessao.empresa.cnpj};      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/nfe-configuracao'),
        headers: ServiceBase.cabecalhoRequisicao,
        body: arquivoBase64,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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

}