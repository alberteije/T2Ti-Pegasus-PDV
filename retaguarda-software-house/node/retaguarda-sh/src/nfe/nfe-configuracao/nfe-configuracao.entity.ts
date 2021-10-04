/*******************************************************************************
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
import { Entity, Column, PrimaryGeneratedColumn, OneToOne, JoinColumn } from 'typeorm';
import { Empresa } from '../../entities-export';

@Entity({ name: 'NFE_CONFIGURACAO' })
export class NfeConfiguracao { 

	@PrimaryGeneratedColumn()
	id: number;

	@Column({ name: 'CERTIFICADO_DIGITAL_SERIE' })
	certificadoDigitalSerie: string;

	@Column({ name: 'CERTIFICADO_DIGITAL_CAMINHO' })
	certificadoDigitalCaminho: string;

	@Column({ name: 'CERTIFICADO_DIGITAL_SENHA' })
	certificadoDigitalSenha: string;

	@Column({ name: 'TIPO_EMISSAO' })
	tipoEmissao: number;

	@Column({ name: 'FORMATO_IMPRESSAO_DANFE' })
	formatoImpressaoDanfe: number;

	@Column({ name: 'PROCESSO_EMISSAO' })
	processoEmissao: number;

	@Column({ name: 'VERSAO_PROCESSO_EMISSAO' })
	versaoProcessoEmissao: string;

	@Column({ name: 'CAMINHO_LOGOMARCA' })
	caminhoLogomarca: string;

	@Column({ name: 'SALVAR_XML' })
	salvarXml: string;

	@Column({ name: 'CAMINHO_SALVAR_XML' })
	caminhoSalvarXml: string;

	@Column({ name: 'CAMINHO_SCHEMAS' })
	caminhoSchemas: string;

	@Column({ name: 'CAMINHO_ARQUIVO_DANFE' })
	caminhoArquivoDanfe: string;

	@Column({ name: 'CAMINHO_SALVAR_PDF' })
	caminhoSalvarPdf: string;

	@Column({ name: 'WEBSERVICE_UF' })
	webserviceUf: string;

	@Column({ name: 'WEBSERVICE_AMBIENTE' })
	webserviceAmbiente: number;

	@Column({ name: 'WEBSERVICE_PROXY_HOST' })
	webserviceProxyHost: string;

	@Column({ name: 'WEBSERVICE_PROXY_PORTA' })
	webserviceProxyPorta: number;

	@Column({ name: 'WEBSERVICE_PROXY_USUARIO' })
	webserviceProxyUsuario: string;

	@Column({ name: 'WEBSERVICE_PROXY_SENHA' })
	webserviceProxySenha: string;

	@Column({ name: 'WEBSERVICE_VISUALIZAR' })
	webserviceVisualizar: string;

	@Column({ name: 'EMAIL_SERVIDOR_SMTP' })
	emailServidorSmtp: string;

	@Column({ name: 'EMAIL_PORTA' })
	emailPorta: number;

	@Column({ name: 'EMAIL_USUARIO' })
	emailUsuario: string;

	@Column({ name: 'EMAIL_SENHA' })
	emailSenha: string;

	@Column({ name: 'EMAIL_ASSUNTO' })
	emailAssunto: string;

	@Column({ name: 'EMAIL_AUTENTICA_SSL' })
	emailAutenticaSsl: string;

	@Column({ name: 'EMAIL_TEXTO' })
	emailTexto: string;

	@Column({ name: 'NFCE_ID_CSC' })
	nfceIdCsc: string;

	@Column({ name: 'NFCE_CSC' })
	nfceCsc: string;

	@Column({ name: 'NFCE_MODELO_IMPRESSAO' })
	nfceModeloImpressao: string;

	@Column({ name: 'NFCE_IMPRIMIR_ITENS_UMA_LINHA' })
	nfceImprimirItensUmaLinha: string;

	@Column({ name: 'NFCE_IMPRIMIR_DESCONTO_POR_ITEM' })
	nfceImprimirDescontoPorItem: string;

	@Column({ name: 'NFCE_IMPRIMIR_QRCODE_LATERAL' })
	nfceImprimirQrcodeLateral: string;

	@Column({ name: 'NFCE_IMPRIMIR_GTIN' })
	nfceImprimirGtin: string;

	@Column({ name: 'NFCE_IMPRIMIR_NOME_FANTASIA' })
	nfceImprimirNomeFantasia: string;

	@Column({ name: 'NFCE_IMPRESSAO_TRIBUTOS' })
	nfceImpressaoTributos: string;

	@Column({ name: 'NFCE_MARGEM_SUPERIOR' })
	nfceMargemSuperior: number;

	@Column({ name: 'NFCE_MARGEM_INFERIOR' })
	nfceMargemInferior: number;

	@Column({ name: 'NFCE_MARGEM_DIREITA' })
	nfceMargemDireita: number;

	@Column({ name: 'NFCE_MARGEM_ESQUERDA' })
	nfceMargemEsquerda: number;

	@Column({ name: 'NFCE_RESOLUCAO_IMPRESSAO' })
	nfceResolucaoImpressao: number;

	@Column({ name: 'NFCE_TAMANHO_FONTE_ITEM' })
	nfceTamanhoFonteItem: number;

	@Column({ name: 'RESP_TEC_CNPJ' })
	respTecCnpj: string;

	@Column({ name: 'RESP_TEC_CONTATO' })
	respTecContato: string;

	@Column({ name: 'RESP_TEC_EMAIL' })
	respTecEmail: string;

	@Column({ name: 'RESP_TEC_FONE' })
	respTecFone: string;

	@Column({ name: 'RESP_TEC_ID_CSRT' })
	respTecIdCsrt: string;

	@Column({ name: 'RESP_TEC_HASH_CSRT' })
	respTecHashCsrt: string;

	/**
	* Relations
	*/
    @OneToOne(() => Empresa)
    @JoinColumn({ name: "ID_EMPRESA" })
    empresa: Empresa;

	/**
	* Constructor
	*/
	constructor(objetoJson: {}) {
		if (objetoJson != null) {
			this.id = objetoJson['id'] == 0 ? undefined : objetoJson['id'];
			this.certificadoDigitalSerie = objetoJson['certificadoDigitalSerie'];
			this.certificadoDigitalCaminho = objetoJson['certificadoDigitalCaminho'];
			this.certificadoDigitalSenha = objetoJson['certificadoDigitalSenha'];
			this.tipoEmissao = objetoJson['tipoEmissao'];
			this.formatoImpressaoDanfe = objetoJson['formatoImpressaoDanfe'];
			this.processoEmissao = objetoJson['processoEmissao'];
			this.versaoProcessoEmissao = objetoJson['versaoProcessoEmissao'];
			this.caminhoLogomarca = objetoJson['caminhoLogomarca'];
			this.salvarXml = objetoJson['salvarXml'];
			this.caminhoSalvarXml = objetoJson['caminhoSalvarXml'];
			this.caminhoSchemas = objetoJson['caminhoSchemas'];
			this.caminhoArquivoDanfe = objetoJson['caminhoArquivoDanfe'];
			this.caminhoSalvarPdf = objetoJson['caminhoSalvarPdf'];
			this.webserviceUf = objetoJson['webserviceUf'];
			this.webserviceAmbiente = objetoJson['webserviceAmbiente'];
			this.webserviceProxyHost = objetoJson['webserviceProxyHost'];
			this.webserviceProxyPorta = objetoJson['webserviceProxyPorta'];
			this.webserviceProxyUsuario = objetoJson['webserviceProxyUsuario'];
			this.webserviceProxySenha = objetoJson['webserviceProxySenha'];
			this.webserviceVisualizar = objetoJson['webserviceVisualizar'];
			this.emailServidorSmtp = objetoJson['emailServidorSmtp'];
			this.emailPorta = objetoJson['emailPorta'];
			this.emailUsuario = objetoJson['emailUsuario'];
			this.emailSenha = objetoJson['emailSenha'];
			this.emailAssunto = objetoJson['emailAssunto'];
			this.emailAutenticaSsl = objetoJson['emailAutenticaSsl'];
			this.emailTexto = objetoJson['emailTexto'];
			this.nfceIdCsc = objetoJson['nfceIdCsc'];
			this.nfceCsc = objetoJson['nfceCsc'];
			this.nfceModeloImpressao = objetoJson['nfceModeloImpressao'];
			this.nfceImprimirItensUmaLinha = objetoJson['nfceImprimirItensUmaLinha'];
			this.nfceImprimirDescontoPorItem = objetoJson['nfceImprimirDescontoPorItem'];
			this.nfceImprimirQrcodeLateral = objetoJson['nfceImprimirQrcodeLateral'];
			this.nfceImprimirGtin = objetoJson['nfceImprimirGtin'];
			this.nfceImprimirNomeFantasia = objetoJson['nfceImprimirNomeFantasia'];
			this.nfceImpressaoTributos = objetoJson['nfceImpressaoTributos'];
			this.nfceMargemSuperior = objetoJson['nfceMargemSuperior'];
			this.nfceMargemInferior = objetoJson['nfceMargemInferior'];
			this.nfceMargemDireita = objetoJson['nfceMargemDireita'];
			this.nfceMargemEsquerda = objetoJson['nfceMargemEsquerda'];
			this.nfceResolucaoImpressao = objetoJson['nfceResolucaoImpressao'];
			this.nfceTamanhoFonteItem = objetoJson['nfceTamanhoFonteItem'];
			this.respTecCnpj = objetoJson['respTecCnpj'];
			this.respTecContato = objetoJson['respTecContato'];
			this.respTecEmail = objetoJson['respTecEmail'];
			this.respTecFone = objetoJson['respTecFone'];
			this.respTecIdCsrt = objetoJson['respTecIdCsrt'];
			this.respTecHashCsrt = objetoJson['respTecHashCsrt'];
			
			if (objetoJson['empresa'] != null) {
				this.empresa = new Empresa(objetoJson['empresa']);
			}			
			
		}
	}
}