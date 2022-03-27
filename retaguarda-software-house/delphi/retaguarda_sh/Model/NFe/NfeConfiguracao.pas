{*******************************************************************************
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
*******************************************************************************}
unit NfeConfiguracao;

interface

uses
  MVCFramework.Serializer.Commons, ModelBase;

type

  [MVCNameCase(ncLowerCase)]
  TNfeConfiguracao = class(TModelBase)
  private
    FId: Integer;
    FCertificadoDigitalSerie: string;
    FCertificadoDigitalCaminho: string;
    FCertificadoDigitalSenha: string;
    FTipoEmissao: Integer;
    FFormatoImpressaoDanfe: Integer;
    FProcessoEmissao: Integer;
    FVersaoProcessoEmissao: string;
    FCaminhoLogomarca: string;
    FSalvarXml: string;
    FCaminhoSalvarXml: string;
    FCaminhoSchemas: string;
    FCaminhoArquivoDanfe: string;
    FCaminhoSalvarPdf: string;
    FWebserviceUf: string;
    FWebserviceAmbiente: Integer;
    FWebserviceProxyHost: string;
    FWebserviceProxyPorta: Integer;
    FWebserviceProxyUsuario: string;
    FWebserviceProxySenha: string;
    FWebserviceVisualizar: string;
    FEmailServidorSmtp: string;
    FEmailPorta: Integer;
    FEmailUsuario: string;
    FEmailSenha: string;
    FEmailAssunto: string;
    FEmailAutenticaSsl: string;
    FEmailTexto: string;
    FNfceIdCsc: string;
    FNfceCsc: string;
    FNfceModeloImpressao: string;
    FNfceImprimirItensUmaLinha: string;
    FNfceImprimirDescontoPorItem: string;
    FNfceImprimirQrcodeLateral: string;
    FNfceImprimirGtin: string;
    FNfceImprimirNomeFantasia: string;
    FNfceImpressaoTributos: string;
    FNfceMargemSuperior: Extended;
    FNfceMargemInferior: Extended;
    FNfceMargemDireita: Extended;
    FNfceMargemEsquerda: Extended;
    FNfceResolucaoImpressao: Integer;
    FNfceTamanhoFonteItem: Integer;
    FRespTecCnpj: string;
    FRespTecContato: string;
    FRespTecEmail: string;
    FRespTecFone: string;
    FRespTecIdCsrt: string;
    FRespTecHashCsrt: string;
    FIdEmpresa: Integer;

  public
//    procedure ValidarInsercao; override;
//    procedure ValidarAlteracao; override;
//    procedure ValidarExclusao; override;

    [MVCColumnAttribute('ID', True)]
		[MVCNameAsAttribute('id')]
		property Id: Integer read FId write FId;
    [MVCColumnAttribute('CERTIFICADO_DIGITAL_SERIE')]
		[MVCNameAsAttribute('certificadoDigitalSerie')]
		property CertificadoDigitalSerie: string read FCertificadoDigitalSerie write FCertificadoDigitalSerie;
    [MVCColumnAttribute('CERTIFICADO_DIGITAL_CAMINHO')]
		[MVCNameAsAttribute('certificadoDigitalCaminho')]
		property CertificadoDigitalCaminho: string read FCertificadoDigitalCaminho write FCertificadoDigitalCaminho;
    [MVCColumnAttribute('CERTIFICADO_DIGITAL_SENHA')]
		[MVCNameAsAttribute('certificadoDigitalSenha')]
		property CertificadoDigitalSenha: string read FCertificadoDigitalSenha write FCertificadoDigitalSenha;
    [MVCColumnAttribute('TIPO_EMISSAO')]
		[MVCNameAsAttribute('tipoEmissao')]
		property TipoEmissao: Integer read FTipoEmissao write FTipoEmissao;
    [MVCColumnAttribute('FORMATO_IMPRESSAO_DANFE')]
		[MVCNameAsAttribute('formatoImpressaoDanfe')]
		property FormatoImpressaoDanfe: Integer read FFormatoImpressaoDanfe write FFormatoImpressaoDanfe;
    [MVCColumnAttribute('PROCESSO_EMISSAO')]
		[MVCNameAsAttribute('processoEmissao')]
		property ProcessoEmissao: Integer read FProcessoEmissao write FProcessoEmissao;
    [MVCColumnAttribute('VERSAO_PROCESSO_EMISSAO')]
		[MVCNameAsAttribute('versaoProcessoEmissao')]
		property VersaoProcessoEmissao: string read FVersaoProcessoEmissao write FVersaoProcessoEmissao;
    [MVCColumnAttribute('CAMINHO_LOGOMARCA')]
		[MVCNameAsAttribute('caminhoLogomarca')]
		property CaminhoLogomarca: string read FCaminhoLogomarca write FCaminhoLogomarca;
    [MVCColumnAttribute('SALVAR_XML')]
		[MVCNameAsAttribute('salvarXml')]
		property SalvarXml: string read FSalvarXml write FSalvarXml;
    [MVCColumnAttribute('CAMINHO_SALVAR_XML')]
		[MVCNameAsAttribute('caminhoSalvarXml')]
		property CaminhoSalvarXml: string read FCaminhoSalvarXml write FCaminhoSalvarXml;
    [MVCColumnAttribute('CAMINHO_SCHEMAS')]
		[MVCNameAsAttribute('caminhoSchemas')]
		property CaminhoSchemas: string read FCaminhoSchemas write FCaminhoSchemas;
    [MVCColumnAttribute('CAMINHO_ARQUIVO_DANFE')]
		[MVCNameAsAttribute('caminhoArquivoDanfe')]
		property CaminhoArquivoDanfe: string read FCaminhoArquivoDanfe write FCaminhoArquivoDanfe;
    [MVCColumnAttribute('CAMINHO_SALVAR_PDF')]
		[MVCNameAsAttribute('caminhoSalvarPdf')]
		property CaminhoSalvarPdf: string read FCaminhoSalvarPdf write FCaminhoSalvarPdf;
    [MVCColumnAttribute('WEBSERVICE_UF')]
		[MVCNameAsAttribute('webserviceUf')]
		property WebserviceUf: string read FWebserviceUf write FWebserviceUf;
    [MVCColumnAttribute('WEBSERVICE_AMBIENTE')]
		[MVCNameAsAttribute('webserviceAmbiente')]
		property WebserviceAmbiente: Integer read FWebserviceAmbiente write FWebserviceAmbiente;
    [MVCColumnAttribute('WEBSERVICE_PROXY_HOST')]
		[MVCNameAsAttribute('webserviceProxyHost')]
		property WebserviceProxyHost: string read FWebserviceProxyHost write FWebserviceProxyHost;
    [MVCColumnAttribute('WEBSERVICE_PROXY_PORTA')]
		[MVCNameAsAttribute('webserviceProxyPorta')]
		property WebserviceProxyPorta: Integer read FWebserviceProxyPorta write FWebserviceProxyPorta;
    [MVCColumnAttribute('WEBSERVICE_PROXY_USUARIO')]
		[MVCNameAsAttribute('webserviceProxyUsuario')]
		property WebserviceProxyUsuario: string read FWebserviceProxyUsuario write FWebserviceProxyUsuario;
    [MVCColumnAttribute('WEBSERVICE_PROXY_SENHA')]
		[MVCNameAsAttribute('webserviceProxySenha')]
		property WebserviceProxySenha: string read FWebserviceProxySenha write FWebserviceProxySenha;
    [MVCColumnAttribute('WEBSERVICE_VISUALIZAR')]
		[MVCNameAsAttribute('webserviceVisualizar')]
		property WebserviceVisualizar: string read FWebserviceVisualizar write FWebserviceVisualizar;
    [MVCColumnAttribute('EMAIL_SERVIDOR_SMTP')]
		[MVCNameAsAttribute('emailServidorSmtp')]
		property EmailServidorSmtp: string read FEmailServidorSmtp write FEmailServidorSmtp;
    [MVCColumnAttribute('EMAIL_PORTA')]
		[MVCNameAsAttribute('emailPorta')]
		property EmailPorta: Integer read FEmailPorta write FEmailPorta;
    [MVCColumnAttribute('EMAIL_USUARIO')]
		[MVCNameAsAttribute('emailUsuario')]
		property EmailUsuario: string read FEmailUsuario write FEmailUsuario;
    [MVCColumnAttribute('EMAIL_SENHA')]
		[MVCNameAsAttribute('emailSenha')]
		property EmailSenha: string read FEmailSenha write FEmailSenha;
    [MVCColumnAttribute('EMAIL_ASSUNTO')]
		[MVCNameAsAttribute('emailAssunto')]
		property EmailAssunto: string read FEmailAssunto write FEmailAssunto;
    [MVCColumnAttribute('EMAIL_AUTENTICA_SSL')]
		[MVCNameAsAttribute('emailAutenticaSsl')]
		property EmailAutenticaSsl: string read FEmailAutenticaSsl write FEmailAutenticaSsl;
    [MVCColumnAttribute('EMAIL_TEXTO')]
		[MVCNameAsAttribute('emailTexto')]
		property EmailTexto: string read FEmailTexto write FEmailTexto;
    [MVCColumnAttribute('NFCE_ID_CSC')]
		[MVCNameAsAttribute('nfceIdCsc')]
		property NfceIdCsc: string read FNfceIdCsc write FNfceIdCsc;
    [MVCColumnAttribute('NFCE_CSC')]
		[MVCNameAsAttribute('nfceCsc')]
		property NfceCsc: string read FNfceCsc write FNfceCsc;
    [MVCColumnAttribute('NFCE_MODELO_IMPRESSAO')]
		[MVCNameAsAttribute('nfceModeloImpressao')]
		property NfceModeloImpressao: string read FNfceModeloImpressao write FNfceModeloImpressao;
    [MVCColumnAttribute('NFCE_IMPRIMIR_ITENS_UMA_LINHA')]
		[MVCNameAsAttribute('nfceImprimirItensUmaLinha')]
		property NfceImprimirItensUmaLinha: string read FNfceImprimirItensUmaLinha write FNfceImprimirItensUmaLinha;
    [MVCColumnAttribute('NFCE_IMPRIMIR_DESCONTO_POR_ITEM')]
		[MVCNameAsAttribute('nfceImprimirDescontoPorItem')]
		property NfceImprimirDescontoPorItem: string read FNfceImprimirDescontoPorItem write FNfceImprimirDescontoPorItem;
    [MVCColumnAttribute('NFCE_IMPRIMIR_QRCODE_LATERAL')]
		[MVCNameAsAttribute('nfceImprimirQrcodeLateral')]
		property NfceImprimirQrcodeLateral: string read FNfceImprimirQrcodeLateral write FNfceImprimirQrcodeLateral;
    [MVCColumnAttribute('NFCE_IMPRIMIR_GTIN')]
		[MVCNameAsAttribute('nfceImprimirGtin')]
		property NfceImprimirGtin: string read FNfceImprimirGtin write FNfceImprimirGtin;
    [MVCColumnAttribute('NFCE_IMPRIMIR_NOME_FANTASIA')]
		[MVCNameAsAttribute('nfceImprimirNomeFantasia')]
		property NfceImprimirNomeFantasia: string read FNfceImprimirNomeFantasia write FNfceImprimirNomeFantasia;
    [MVCColumnAttribute('NFCE_IMPRESSAO_TRIBUTOS')]
		[MVCNameAsAttribute('nfceImpressaoTributos')]
		property NfceImpressaoTributos: string read FNfceImpressaoTributos write FNfceImpressaoTributos;
    [MVCColumnAttribute('NFCE_MARGEM_SUPERIOR')]
		[MVCNameAsAttribute('nfceMargemSuperior')]
		property NfceMargemSuperior: Extended read FNfceMargemSuperior write FNfceMargemSuperior;
    [MVCColumnAttribute('NFCE_MARGEM_INFERIOR')]
		[MVCNameAsAttribute('nfceMargemInferior')]
		property NfceMargemInferior: Extended read FNfceMargemInferior write FNfceMargemInferior;
    [MVCColumnAttribute('NFCE_MARGEM_DIREITA')]
		[MVCNameAsAttribute('nfceMargemDireita')]
		property NfceMargemDireita: Extended read FNfceMargemDireita write FNfceMargemDireita;
    [MVCColumnAttribute('NFCE_MARGEM_ESQUERDA')]
		[MVCNameAsAttribute('nfceMargemEsquerda')]
		property NfceMargemEsquerda: Extended read FNfceMargemEsquerda write FNfceMargemEsquerda;
    [MVCColumnAttribute('NFCE_RESOLUCAO_IMPRESSAO')]
		[MVCNameAsAttribute('nfceResolucaoImpressao')]
		property NfceResolucaoImpressao: Integer read FNfceResolucaoImpressao write FNfceResolucaoImpressao;
    [MVCColumnAttribute('NFCE_TAMANHO_FONTE_ITEM')]
		[MVCNameAsAttribute('nfceTamanhoFonteItem')]
		property NfceTamanhoFonteItem: Integer read FNfceTamanhoFonteItem write FNfceTamanhoFonteItem;
    [MVCColumnAttribute('RESP_TEC_CNPJ')]
		[MVCNameAsAttribute('respTecCnpj')]
		property RespTecCnpj: string read FRespTecCnpj write FRespTecCnpj;
    [MVCColumnAttribute('RESP_TEC_CONTATO')]
		[MVCNameAsAttribute('respTecContato')]
		property RespTecContato: string read FRespTecContato write FRespTecContato;
    [MVCColumnAttribute('RESP_TEC_EMAIL')]
		[MVCNameAsAttribute('respTecEmail')]
		property RespTecEmail: string read FRespTecEmail write FRespTecEmail;
    [MVCColumnAttribute('RESP_TEC_FONE')]
		[MVCNameAsAttribute('respTecFone')]
		property RespTecFone: string read FRespTecFone write FRespTecFone;
    [MVCColumnAttribute('RESP_TEC_ID_CSRT')]
		[MVCNameAsAttribute('respTecIdCsrt')]
		property RespTecIdCsrt: string read FRespTecIdCsrt write FRespTecIdCsrt;
    [MVCColumnAttribute('RESP_TEC_HASH_CSRT')]
		[MVCNameAsAttribute('respTecHashCsrt')]
		property RespTecHashCsrt: string read FRespTecHashCsrt write FRespTecHashCsrt;
    [MVCColumnAttribute('ID_EMPRESA')]
		[MVCNameAsAttribute('idEmpresa')]
		property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
  end;

implementation

{ TNfeConfiguracao }



end.