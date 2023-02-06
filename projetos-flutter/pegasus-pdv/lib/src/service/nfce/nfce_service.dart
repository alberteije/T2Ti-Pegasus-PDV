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
import 'package:pegasus_pdv/src/model/model.dart';

/// classe responsável por requisições ao servidor REST
class NfceService extends ServiceBase {
  var clienteHTTP = Client();

  Future<List<PdvTipoPlanoModel>?> consultarListaTipoPlanoNfce({Filtro? filtro}) async {
    List<PdvTipoPlanoModel> listaNfceTipoPlanoModel = [];
    
    try {
      tratarFiltro(filtro, '/pdv-tipo-plano/');
	  	
      final response = await clienteHTTP.get(Uri.tryParse(url)!, headers: ServiceBase.cabecalhoRequisicao);

      if (response.statusCode == 200) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var parsed = json.decode(Biblioteca.decifrar(response.body)) as List<dynamic>;
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

  Future<NfcePlanoPagamentoModel?> verificarPlano() async {  
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
      final response = await clienteHTTP.get(
        Uri.tryParse('$endpoint/pdv-plano-pagamento/consulta-plano/')!, 
        headers: ServiceBase.cabecalhoRequisicao
      );

      if (response.statusCode == 200) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var objetoJson = json.decode(Biblioteca.decifrar(response.body));
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

  Future<int?> confirmarTransacao(String codigoTransacao) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!),
                              "codigo": Biblioteca.cifrar(codigoTransacao)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!),
                              "codigo": Biblioteca.cifrar(codigoTransacao)
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/pdv-plano-pagamento/confirma-transacao/')!,
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

  Future<NfeConfiguracaoModel?> atualizarConfiguracoesMonitor(NfeConfiguracaoModel nfeConfiguracao, String? cnpj) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!),
                              "pdv-configuracao": Biblioteca.cifrar(json.encode(Sessao.configuracaoPdv))
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!),
                              "pdv-configuracao": Biblioteca.cifrar(json.encode(Sessao.configuracaoPdv))
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/nfe-configuracao/atualiza-dados/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        body: Biblioteca.cifrar(nfeConfiguracao.objetoEncodeJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var configuracaoJson = json.decode(Biblioteca.decifrar(response.body));
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

  Future<Uint8List?> baixarArquivosXml(String periodo) async { 
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!),
                              "periodo": Biblioteca.cifrar(periodo)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!),
                              "periodo": Biblioteca.cifrar(periodo)
                              };      
      final response = await clienteHTTP.get(
        Uri.tryParse('$endpoint/acbr-monitor/download-xml-periodo/')!,
        headers: ServiceBase.cabecalhoRequisicao
      );

      if (response.statusCode == 200) {
        if (response.headers["content-type"]!.contains("html")) {
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

  Future<bool> atualizarCertificadoDigital(String arquivoBase64, String senha) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "hash-registro": Biblioteca.cifrar(senha), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "hash-registro": Biblioteca.cifrar(senha), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/acbr-monitor/atualiza-certificado/')!,
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

  /////////////////////////////////////////
  /// Métodos relacionados ao ACBrMonitor
  /////////////////////////////////////////
  Future<dynamic> emitirNfce(String nfceBase64, String numero) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "numero": Biblioteca.cifrar(numero), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "numero": Biblioteca.cifrar(numero), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/acbr-monitor/emite-nfce/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        body: Biblioteca.cifrar(nfceBase64),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          // Sessao.ultimaChaveDeAcesso = Biblioteca.decifrar(response.headers["chave"] ?? '');
          final danfe = response.bodyBytes;
          return danfe;          
        }
      } else if (response.statusCode == 418) {
        return json.decode(response.body)["message"];
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return null;
    }
  }

  Future<dynamic> emitirNfceContingencia(String nfceBase64, String numero) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "numero": Biblioteca.cifrar(numero), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "numero": Biblioteca.cifrar(numero), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/acbr-monitor/emite-nfce-contingencia/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        body: Biblioteca.cifrar(nfceBase64),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          // Sessao.ultimaChaveDeAcesso = Biblioteca.decifrar(response.headers["chave"] ?? '');
          final danfe = response.bodyBytes;
          return danfe;          
        }
      } else if (response.statusCode == 418) {
        return json.decode(response.body)["message"];
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return null;
    }
  }

  Future<dynamic> transmitirNfceContingenciada(String chave) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "chave": Biblioteca.cifrar(chave), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "chave": Biblioteca.cifrar(chave), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/acbr-monitor/transmite-nfce-contingenciada/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        // body: {"vazio": "vazio"} ,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          final danfe = response.bodyBytes;
          return danfe;          
        }
      } else if (response.statusCode == 418) {
        return json.decode(response.body)["message"];
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return null;
    }
  }

  Future<String> inutilizarNumeroNfce(ObjetoNfe objetoNfe) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer ${Sessao.tokenJWT}"} 
                            : {"content-type": "application/json", "authorization": "Bearer ${Sessao.tokenJWT}"};      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/acbr-monitor/inutiliza-numero-nota/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        body: Biblioteca.cifrar(objetoNfe.objetoEncodeJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return '';
        } else {
          return Biblioteca.decifrar(response.body);
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return '';
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return '';
    }
  }

  Future<String> cancelarNota(ObjetoNfe objetoNfe) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer ${Sessao.tokenJWT}"} 
                            : {"content-type": "application/json", "authorization": "Bearer ${Sessao.tokenJWT}"};      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/acbr-monitor/cancela-nfce/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        body: Biblioteca.cifrar(objetoNfe.objetoEncodeJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return '';
        } else {
          return Biblioteca.decifrar(response.body);
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
          return '';
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return '';
    }
  }

  Future<String> tratarNotaAnteriorContingencia(ObjetoNfe objetoNfe) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {"content-type": "application/json", "authentication": "Bearer ${Sessao.tokenJWT}"} 
                            : {"content-type": "application/json", "authorization": "Bearer ${Sessao.tokenJWT}"};      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/acbr-monitor/trata-nota-anterior-contingencia/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        body: Biblioteca.cifrar(objetoNfe.objetoEncodeJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return '';
        } else {
          return Biblioteca.decifrar(response.body);
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
          return '';
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
      return '';
    }
  }

  Future<dynamic> gerarPdfDanfe(String chave) async {
    try {
      ServiceBase.cabecalhoRequisicao = Constantes.linguagemServidor == 'delphi' 
                            ? {
                              "content-type": "application/json", 
                              "authentication": "Bearer ${Sessao.tokenJWT}", 
                              "chave": Biblioteca.cifrar(chave), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              } 
                            : {
                              "content-type": "application/json", 
                              "authorization": "Bearer ${Sessao.tokenJWT}", 
                              "chave": Biblioteca.cifrar(chave), 
                              "cnpj": Biblioteca.cifrar(Sessao.empresa!.cnpj!)
                              };      
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/acbr-monitor/gera-pdf-danfe-nfce/')!,
        headers: ServiceBase.cabecalhoRequisicao,
        // body: {"vazio": "vazio"} ,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"]!.contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          final danfe = response.bodyBytes;
          return danfe;          
        }
      } else if (response.statusCode == 418) {
        return json.decode(response.body)["message"];
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