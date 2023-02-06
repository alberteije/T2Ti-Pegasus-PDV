/*
Title: T2Ti ERP 3.0                                                                
Description: Model relacionado à tabela [NFE_CONFIGURACAO] 
                                                                                
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

import 'package:pegasus_pdv/src/database/database.dart';

class NfeConfiguracaoModel {
	int? id;
	int? idEmpresa;
	String? certificadoDigitalSerie;
	String? certificadoDigitalCaminho;
	String? certificadoDigitalSenha;
	int? tipoEmissao;
	int? formatoImpressaoDanfe;
	int? processoEmissao;
	String? versaoProcessoEmissao;
	String? caminhoLogomarca;
	String? salvarXml;
	String? caminhoSalvarXml;
	String? caminhoSchemas;
	String? caminhoArquivoDanfe;
	String? caminhoSalvarPdf;
	String? webserviceUf;
	int? webserviceAmbiente;
	String? webserviceProxyHost;
	int? webserviceProxyPorta;
	String? webserviceProxyUsuario;
	String? webserviceProxySenha;
	String? webserviceVisualizar;
	String? emailServidorSmtp;
	int? emailPorta;
	String? emailUsuario;
	String? emailSenha;
	String? emailAssunto;
	String? emailAutenticaSsl;
	String? emailTexto;
	String? nfceIdCsc;
	String? nfceCsc;
	String? nfceModeloImpressao;
	String? nfceImprimirItensUmaLinha;
	String? nfceImprimirDescontoPorItem;
	String? nfceImprimirQrcodeLateral;
	String? nfceImprimirGtin;
	String? nfceImprimirNomeFantasia;
	String? nfceImpressaoTributos;
	double? nfceMargemSuperior;
	double? nfceMargemInferior;
	double? nfceMargemDireita;
	double? nfceMargemEsquerda;
	int? nfceResolucaoImpressao;
	int? nfceTamanhoFonteItem;
	String? respTecCnpj;
	String? respTecContato;
	String? respTecEmail;
	String? respTecFone;
	String? respTecIdCsrt;
	String? respTecHashCsrt;

	NfeConfiguracaoModel({
		this.id,
		this.idEmpresa,
		this.certificadoDigitalSerie,
		this.certificadoDigitalCaminho,
		this.certificadoDigitalSenha,
		this.tipoEmissao,
		this.formatoImpressaoDanfe,
		this.processoEmissao,
		this.versaoProcessoEmissao,
		this.caminhoLogomarca,
		this.salvarXml,
		this.caminhoSalvarXml,
		this.caminhoSchemas,
		this.caminhoArquivoDanfe,
		this.caminhoSalvarPdf,
		this.webserviceUf,
		this.webserviceAmbiente,
		this.webserviceProxyHost,
		this.webserviceProxyPorta,
		this.webserviceProxyUsuario,
		this.webserviceProxySenha,
		this.webserviceVisualizar,
		this.emailServidorSmtp,
		this.emailPorta,
		this.emailUsuario,
		this.emailSenha,
		this.emailAssunto,
		this.emailAutenticaSsl,
		this.emailTexto,
		this.nfceIdCsc,
		this.nfceCsc,
		this.nfceModeloImpressao,
		this.nfceImprimirItensUmaLinha,
		this.nfceImprimirDescontoPorItem,
		this.nfceImprimirQrcodeLateral,
		this.nfceImprimirGtin,
		this.nfceImprimirNomeFantasia,
		this.nfceImpressaoTributos,
		this.nfceMargemSuperior = 0.0,
		this.nfceMargemInferior = 0.0,
		this.nfceMargemDireita = 0.0,
		this.nfceMargemEsquerda = 0.0,
		this.nfceResolucaoImpressao,
		this.nfceTamanhoFonteItem,
		this.respTecCnpj,
		this.respTecContato,
		this.respTecEmail,
		this.respTecFone,
		this.respTecIdCsrt,
		this.respTecHashCsrt,
	});

  NfeConfiguracaoModel.fromDB(NfeConfiguracao nfeConfiguracao) {
		certificadoDigitalSerie = nfeConfiguracao.certificadoDigitalSerie;
		certificadoDigitalCaminho = nfeConfiguracao.certificadoDigitalCaminho;
		certificadoDigitalSenha = nfeConfiguracao.certificadoDigitalSenha;
		tipoEmissao = nfeConfiguracao.tipoEmissao;
		formatoImpressaoDanfe = nfeConfiguracao.formatoImpressaoDanfe;
		processoEmissao = nfeConfiguracao.processoEmissao;
		versaoProcessoEmissao = nfeConfiguracao.versaoProcessoEmissao;
		caminhoLogomarca = nfeConfiguracao.caminhoLogomarca;
		salvarXml = nfeConfiguracao.salvarXml;
		caminhoSalvarXml = nfeConfiguracao.caminhoSalvarXml;
		caminhoSchemas = nfeConfiguracao.caminhoSchemas;
		caminhoArquivoDanfe = nfeConfiguracao.caminhoArquivoDanfe;
		caminhoSalvarPdf = nfeConfiguracao.caminhoSalvarPdf;
		webserviceUf = nfeConfiguracao.webserviceUf;
		webserviceAmbiente = nfeConfiguracao.webserviceAmbiente;
		webserviceProxyHost = nfeConfiguracao.webserviceProxyHost;
		webserviceProxyPorta = nfeConfiguracao.webserviceProxyPorta;
		webserviceProxyUsuario = nfeConfiguracao.webserviceProxyUsuario;
		webserviceProxySenha = nfeConfiguracao.webserviceProxySenha;
		webserviceVisualizar = nfeConfiguracao.webserviceVisualizar;
		emailServidorSmtp = nfeConfiguracao.emailServidorSmtp;
		emailPorta = nfeConfiguracao.emailPorta;
		emailUsuario = nfeConfiguracao.emailUsuario;
		emailSenha = nfeConfiguracao.emailSenha;
		emailAssunto = nfeConfiguracao.emailAssunto;
		emailAutenticaSsl = nfeConfiguracao.emailAutenticaSsl;
		emailTexto = nfeConfiguracao.emailTexto;
		nfceIdCsc = nfeConfiguracao.nfceIdCsc;
		nfceCsc = nfeConfiguracao.nfceCsc;
		nfceModeloImpressao = nfeConfiguracao.nfceModeloImpressao;
		nfceImprimirItensUmaLinha = nfeConfiguracao.nfceImprimirItensUmaLinha;
		nfceImprimirDescontoPorItem = nfeConfiguracao.nfceImprimirDescontoPorItem;
		nfceImprimirQrcodeLateral = nfeConfiguracao.nfceImprimirQrcodeLateral;
		nfceImprimirGtin = nfeConfiguracao.nfceImprimirGtin;
		nfceImprimirNomeFantasia = nfeConfiguracao.nfceImprimirNomeFantasia;
		nfceImpressaoTributos = nfeConfiguracao.nfceImpressaoTributos;
		nfceMargemSuperior = nfeConfiguracao.nfceMargemSuperior;
		nfceMargemInferior = nfeConfiguracao.nfceMargemInferior;
		nfceMargemDireita = nfeConfiguracao.nfceMargemDireita;
		nfceMargemEsquerda = nfeConfiguracao.nfceMargemEsquerda;
		nfceResolucaoImpressao = nfeConfiguracao.nfceResolucaoImpressao;
		nfceTamanhoFonteItem = nfeConfiguracao.nfceTamanhoFonteItem;
		respTecCnpj = nfeConfiguracao.respTecCnpj;
		respTecContato = nfeConfiguracao.respTecContato;
		respTecEmail = nfeConfiguracao.respTecEmail;
		respTecFone = nfeConfiguracao.respTecFone;
		respTecIdCsrt = nfeConfiguracao.respTecIdCsrt;
		respTecHashCsrt = nfeConfiguracao.respTecHashCsrt;
  }

	NfeConfiguracaoModel.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idEmpresa = jsonDados['idEmpresa'];
		certificadoDigitalSerie = jsonDados['certificadoDigitalSerie'];
		certificadoDigitalCaminho = jsonDados['certificadoDigitalCaminho'];
		certificadoDigitalSenha = jsonDados['certificadoDigitalSenha'];
		tipoEmissao = jsonDados['tipoEmissao'];
		formatoImpressaoDanfe = jsonDados['formatoImpressaoDanfe'];
		processoEmissao = jsonDados['processoEmissao'];
		versaoProcessoEmissao = jsonDados['versaoProcessoEmissao'];
		caminhoLogomarca = jsonDados['caminhoLogomarca'];
		salvarXml = jsonDados['salvarXml'];
		caminhoSalvarXml = jsonDados['caminhoSalvarXml'];
		caminhoSchemas = jsonDados['caminhoSchemas'];
		caminhoArquivoDanfe = jsonDados['caminhoArquivoDanfe'];
		caminhoSalvarPdf = jsonDados['caminhoSalvarPdf'];
		webserviceUf = jsonDados['webserviceUf'];
		webserviceAmbiente = jsonDados['webserviceAmbiente'];
		webserviceProxyHost = jsonDados['webserviceProxyHost'];
		webserviceProxyPorta = jsonDados['webserviceProxyPorta'];
		webserviceProxyUsuario = jsonDados['webserviceProxyUsuario'];
		webserviceProxySenha = jsonDados['webserviceProxySenha'];
		webserviceVisualizar = jsonDados['webserviceVisualizar'];
		emailServidorSmtp = jsonDados['emailServidorSmtp'];
		emailPorta = jsonDados['emailPorta'];
		emailUsuario = jsonDados['emailUsuario'];
		emailSenha = jsonDados['emailSenha'];
		emailAssunto = jsonDados['emailAssunto'];
		emailAutenticaSsl = jsonDados['emailAutenticaSsl'];
		emailTexto = jsonDados['emailTexto'];
		nfceIdCsc = jsonDados['nfceIdCsc'];
		nfceCsc = jsonDados['nfceCsc'];
		nfceModeloImpressao = jsonDados['nfceModeloImpressao'];
		nfceImprimirItensUmaLinha = jsonDados['nfceImprimirItensUmaLinha'];
		nfceImprimirDescontoPorItem = jsonDados['nfceImprimirDescontoPorItem'];
		nfceImprimirQrcodeLateral = jsonDados['nfceImprimirQrcodeLateral'];
		nfceImprimirGtin = jsonDados['nfceImprimirGtin'];
		nfceImprimirNomeFantasia = jsonDados['nfceImprimirNomeFantasia'];
		nfceImpressaoTributos = jsonDados['nfceImpressaoTributos'];
		nfceMargemSuperior = jsonDados['nfceMargemSuperior']?.toDouble();
		nfceMargemInferior = jsonDados['nfceMargemInferior']?.toDouble();
		nfceMargemDireita = jsonDados['nfceMargemDireita']?.toDouble();
		nfceMargemEsquerda = jsonDados['nfceMargemEsquerda']?.toDouble();
		nfceResolucaoImpressao = jsonDados['nfceResolucaoImpressao'];
		nfceTamanhoFonteItem = jsonDados['nfceTamanhoFonteItem'];
		respTecCnpj = jsonDados['respTecCnpj'];
		respTecContato = jsonDados['respTecContato'];
		respTecEmail = jsonDados['respTecEmail'];
		respTecFone = jsonDados['respTecFone'];
		respTecIdCsrt = jsonDados['respTecIdCsrt'];
		respTecHashCsrt = jsonDados['respTecHashCsrt'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = <String, dynamic>{};

		jsonDados['id'] = id ?? 0;
		jsonDados['idEmpresa'] = idEmpresa ?? 0;
		jsonDados['certificadoDigitalSerie'] = certificadoDigitalSerie;
		jsonDados['certificadoDigitalCaminho'] = certificadoDigitalCaminho;
		jsonDados['certificadoDigitalSenha'] = certificadoDigitalSenha;
		jsonDados['tipoEmissao'] = tipoEmissao ?? 0;
		jsonDados['formatoImpressaoDanfe'] = formatoImpressaoDanfe ?? 0;
		jsonDados['processoEmissao'] = processoEmissao ?? 0;
		jsonDados['versaoProcessoEmissao'] = versaoProcessoEmissao;
		jsonDados['caminhoLogomarca'] = caminhoLogomarca;
		jsonDados['salvarXml'] = salvarXml;
		jsonDados['caminhoSalvarXml'] = caminhoSalvarXml;
		jsonDados['caminhoSchemas'] = caminhoSchemas;
		jsonDados['caminhoArquivoDanfe'] = caminhoArquivoDanfe;
		jsonDados['caminhoSalvarPdf'] = caminhoSalvarPdf;
		jsonDados['webserviceUf'] = webserviceUf;
		jsonDados['webserviceAmbiente'] = webserviceAmbiente ?? 0;
		jsonDados['webserviceProxyHost'] = webserviceProxyHost;
		jsonDados['webserviceProxyPorta'] = webserviceProxyPorta ?? 0;
		jsonDados['webserviceProxyUsuario'] = webserviceProxyUsuario;
		jsonDados['webserviceProxySenha'] = webserviceProxySenha;
		jsonDados['webserviceVisualizar'] = webserviceVisualizar;
		jsonDados['emailServidorSmtp'] = emailServidorSmtp;
		jsonDados['emailPorta'] = emailPorta ?? 0;
		jsonDados['emailUsuario'] = emailUsuario;
		jsonDados['emailSenha'] = emailSenha;
		jsonDados['emailAssunto'] = emailAssunto;
		jsonDados['emailAutenticaSsl'] = emailAutenticaSsl;
		jsonDados['emailTexto'] = emailTexto;
		jsonDados['nfceIdCsc'] = nfceIdCsc;
		jsonDados['nfceCsc'] = nfceCsc;
		jsonDados['nfceModeloImpressao'] = nfceModeloImpressao;
		jsonDados['nfceImprimirItensUmaLinha'] = nfceImprimirItensUmaLinha;
		jsonDados['nfceImprimirDescontoPorItem'] = nfceImprimirDescontoPorItem;
		jsonDados['nfceImprimirQrcodeLateral'] = nfceImprimirQrcodeLateral;
		jsonDados['nfceImprimirGtin'] = nfceImprimirGtin;
		jsonDados['nfceImprimirNomeFantasia'] = nfceImprimirNomeFantasia;
		jsonDados['nfceImpressaoTributos'] = nfceImpressaoTributos;
		jsonDados['nfceMargemSuperior'] = nfceMargemSuperior;
		jsonDados['nfceMargemInferior'] = nfceMargemInferior;
		jsonDados['nfceMargemDireita'] = nfceMargemDireita;
		jsonDados['nfceMargemEsquerda'] = nfceMargemEsquerda;
		jsonDados['nfceResolucaoImpressao'] = nfceResolucaoImpressao ?? 0;
		jsonDados['nfceTamanhoFonteItem'] = nfceTamanhoFonteItem ?? 0;
		jsonDados['respTecCnpj'] = respTecCnpj;
		jsonDados['respTecContato'] = respTecContato;
		jsonDados['respTecEmail'] = respTecEmail;
		jsonDados['respTecFone'] = respTecFone;
		jsonDados['respTecIdCsrt'] = respTecIdCsrt;
		jsonDados['respTecHashCsrt'] = respTecHashCsrt;
	
		return jsonDados;
	}
	

	String objetoEncodeJson() {
	  final jsonDados = toJson;
	  return json.encode(jsonDados);
	}
	
}