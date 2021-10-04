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
	int id;
	int idEmpresa;
	String certificadoDigitalSerie;
	String certificadoDigitalCaminho;
	String certificadoDigitalSenha;
	int tipoEmissao;
	int formatoImpressaoDanfe;
	int processoEmissao;
	String versaoProcessoEmissao;
	String caminhoLogomarca;
	String salvarXml;
	String caminhoSalvarXml;
	String caminhoSchemas;
	String caminhoArquivoDanfe;
	String caminhoSalvarPdf;
	String webserviceUf;
	int webserviceAmbiente;
	String webserviceProxyHost;
	int webserviceProxyPorta;
	String webserviceProxyUsuario;
	String webserviceProxySenha;
	String webserviceVisualizar;
	String emailServidorSmtp;
	int emailPorta;
	String emailUsuario;
	String emailSenha;
	String emailAssunto;
	String emailAutenticaSsl;
	String emailTexto;
	String nfceIdCsc;
	String nfceCsc;
	String nfceModeloImpressao;
	String nfceImprimirItensUmaLinha;
	String nfceImprimirDescontoPorItem;
	String nfceImprimirQrcodeLateral;
	String nfceImprimirGtin;
	String nfceImprimirNomeFantasia;
	String nfceImpressaoTributos;
	double nfceMargemSuperior;
	double nfceMargemInferior;
	double nfceMargemDireita;
	double nfceMargemEsquerda;
	int nfceResolucaoImpressao;
	int nfceTamanhoFonteItem;
	String respTecCnpj;
	String respTecContato;
	String respTecEmail;
	String respTecFone;
	String respTecIdCsrt;
	String respTecHashCsrt;

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
		this.certificadoDigitalSerie = nfeConfiguracao.certificadoDigitalSerie;
		this.certificadoDigitalCaminho = nfeConfiguracao.certificadoDigitalCaminho;
		this.certificadoDigitalSenha = nfeConfiguracao.certificadoDigitalSenha;
		this.tipoEmissao = nfeConfiguracao.tipoEmissao;
		this.formatoImpressaoDanfe = nfeConfiguracao.formatoImpressaoDanfe;
		this.processoEmissao = nfeConfiguracao.processoEmissao;
		this.versaoProcessoEmissao = nfeConfiguracao.versaoProcessoEmissao;
		this.caminhoLogomarca = nfeConfiguracao.caminhoLogomarca;
		this.salvarXml = nfeConfiguracao.salvarXml;
		this.caminhoSalvarXml = nfeConfiguracao.caminhoSalvarXml;
		this.caminhoSchemas = nfeConfiguracao.caminhoSchemas;
		this.caminhoArquivoDanfe = nfeConfiguracao.caminhoArquivoDanfe;
		this.caminhoSalvarPdf = nfeConfiguracao.caminhoSalvarPdf;
		this.webserviceUf = nfeConfiguracao.webserviceUf;
		this.webserviceAmbiente = nfeConfiguracao.webserviceAmbiente;
		this.webserviceProxyHost = nfeConfiguracao.webserviceProxyHost;
		this.webserviceProxyPorta = nfeConfiguracao.webserviceProxyPorta;
		this.webserviceProxyUsuario = nfeConfiguracao.webserviceProxyUsuario;
		this.webserviceProxySenha = nfeConfiguracao.webserviceProxySenha;
		this.webserviceVisualizar = nfeConfiguracao.webserviceVisualizar;
		this.emailServidorSmtp = nfeConfiguracao.emailServidorSmtp;
		this.emailPorta = nfeConfiguracao.emailPorta;
		this.emailUsuario = nfeConfiguracao.emailUsuario;
		this.emailSenha = nfeConfiguracao.emailSenha;
		this.emailAssunto = nfeConfiguracao.emailAssunto;
		this.emailAutenticaSsl = nfeConfiguracao.emailAutenticaSsl;
		this.emailTexto = nfeConfiguracao.emailTexto;
		this.nfceIdCsc = nfeConfiguracao.nfceIdCsc;
		this.nfceCsc = nfeConfiguracao.nfceCsc;
		this.nfceModeloImpressao = nfeConfiguracao.nfceModeloImpressao;
		this.nfceImprimirItensUmaLinha = nfeConfiguracao.nfceImprimirItensUmaLinha;
		this.nfceImprimirDescontoPorItem = nfeConfiguracao.nfceImprimirDescontoPorItem;
		this.nfceImprimirQrcodeLateral = nfeConfiguracao.nfceImprimirQrcodeLateral;
		this.nfceImprimirGtin = nfeConfiguracao.nfceImprimirGtin;
		this.nfceImprimirNomeFantasia = nfeConfiguracao.nfceImprimirNomeFantasia;
		this.nfceImpressaoTributos = nfeConfiguracao.nfceImpressaoTributos;
		this.nfceMargemSuperior = nfeConfiguracao.nfceMargemSuperior;
		this.nfceMargemInferior = nfeConfiguracao.nfceMargemInferior;
		this.nfceMargemDireita = nfeConfiguracao.nfceMargemDireita;
		this.nfceMargemEsquerda = nfeConfiguracao.nfceMargemEsquerda;
		this.nfceResolucaoImpressao = nfeConfiguracao.nfceResolucaoImpressao;
		this.nfceTamanhoFonteItem = nfeConfiguracao.nfceTamanhoFonteItem;
		this.respTecCnpj = nfeConfiguracao.respTecCnpj;
		this.respTecContato = nfeConfiguracao.respTecContato;
		this.respTecEmail = nfeConfiguracao.respTecEmail;
		this.respTecFone = nfeConfiguracao.respTecFone;
		this.respTecIdCsrt = nfeConfiguracao.respTecIdCsrt;
		this.respTecHashCsrt = nfeConfiguracao.respTecHashCsrt;
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
		nfceMargemSuperior = jsonDados['nfceMargemSuperior'] != null ? jsonDados['nfceMargemSuperior'].toDouble() : null;
		nfceMargemInferior = jsonDados['nfceMargemInferior'] != null ? jsonDados['nfceMargemInferior'].toDouble() : null;
		nfceMargemDireita = jsonDados['nfceMargemDireita'] != null ? jsonDados['nfceMargemDireita'].toDouble() : null;
		nfceMargemEsquerda = jsonDados['nfceMargemEsquerda'] != null ? jsonDados['nfceMargemEsquerda'].toDouble() : null;
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
		Map<String, dynamic> jsonDados = Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idEmpresa'] = this.idEmpresa ?? 0;
		jsonDados['certificadoDigitalSerie'] = this.certificadoDigitalSerie;
		jsonDados['certificadoDigitalCaminho'] = this.certificadoDigitalCaminho;
		jsonDados['certificadoDigitalSenha'] = this.certificadoDigitalSenha;
		jsonDados['tipoEmissao'] = this.tipoEmissao ?? 0;
		jsonDados['formatoImpressaoDanfe'] = this.formatoImpressaoDanfe ?? 0;
		jsonDados['processoEmissao'] = this.processoEmissao ?? 0;
		jsonDados['versaoProcessoEmissao'] = this.versaoProcessoEmissao;
		jsonDados['caminhoLogomarca'] = this.caminhoLogomarca;
		jsonDados['salvarXml'] = this.salvarXml;
		jsonDados['caminhoSalvarXml'] = this.caminhoSalvarXml;
		jsonDados['caminhoSchemas'] = this.caminhoSchemas;
		jsonDados['caminhoArquivoDanfe'] = this.caminhoArquivoDanfe;
		jsonDados['caminhoSalvarPdf'] = this.caminhoSalvarPdf;
		jsonDados['webserviceUf'] = this.webserviceUf;
		jsonDados['webserviceAmbiente'] = this.webserviceAmbiente ?? 0;
		jsonDados['webserviceProxyHost'] = this.webserviceProxyHost;
		jsonDados['webserviceProxyPorta'] = this.webserviceProxyPorta ?? 0;
		jsonDados['webserviceProxyUsuario'] = this.webserviceProxyUsuario;
		jsonDados['webserviceProxySenha'] = this.webserviceProxySenha;
		jsonDados['webserviceVisualizar'] = this.webserviceVisualizar;
		jsonDados['emailServidorSmtp'] = this.emailServidorSmtp;
		jsonDados['emailPorta'] = this.emailPorta ?? 0;
		jsonDados['emailUsuario'] = this.emailUsuario;
		jsonDados['emailSenha'] = this.emailSenha;
		jsonDados['emailAssunto'] = this.emailAssunto;
		jsonDados['emailAutenticaSsl'] = this.emailAutenticaSsl;
		jsonDados['emailTexto'] = this.emailTexto;
		jsonDados['nfceIdCsc'] = this.nfceIdCsc;
		jsonDados['nfceCsc'] = this.nfceCsc;
		jsonDados['nfceModeloImpressao'] = this.nfceModeloImpressao;
		jsonDados['nfceImprimirItensUmaLinha'] = this.nfceImprimirItensUmaLinha;
		jsonDados['nfceImprimirDescontoPorItem'] = this.nfceImprimirDescontoPorItem;
		jsonDados['nfceImprimirQrcodeLateral'] = this.nfceImprimirQrcodeLateral;
		jsonDados['nfceImprimirGtin'] = this.nfceImprimirGtin;
		jsonDados['nfceImprimirNomeFantasia'] = this.nfceImprimirNomeFantasia;
		jsonDados['nfceImpressaoTributos'] = this.nfceImpressaoTributos;
		jsonDados['nfceMargemSuperior'] = this.nfceMargemSuperior;
		jsonDados['nfceMargemInferior'] = this.nfceMargemInferior;
		jsonDados['nfceMargemDireita'] = this.nfceMargemDireita;
		jsonDados['nfceMargemEsquerda'] = this.nfceMargemEsquerda;
		jsonDados['nfceResolucaoImpressao'] = this.nfceResolucaoImpressao ?? 0;
		jsonDados['nfceTamanhoFonteItem'] = this.nfceTamanhoFonteItem ?? 0;
		jsonDados['respTecCnpj'] = this.respTecCnpj;
		jsonDados['respTecContato'] = this.respTecContato;
		jsonDados['respTecEmail'] = this.respTecEmail;
		jsonDados['respTecFone'] = this.respTecFone;
		jsonDados['respTecIdCsrt'] = this.respTecIdCsrt;
		jsonDados['respTecHashCsrt'] = this.respTecHashCsrt;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(NfeConfiguracaoModel objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}