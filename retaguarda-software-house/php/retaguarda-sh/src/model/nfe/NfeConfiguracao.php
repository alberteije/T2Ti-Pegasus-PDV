<?php
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
declare(strict_types=1);

class NfeConfiguracao extends EloquentModel implements \JsonSerializable
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'NFE_CONFIGURACAO';

    /**
     * Eager Loading - Relacionamentos que devem ser sempre carregados por padrão
     *
     * @var array
     */
	
    /**
     * Relations
     */
    public function getIdempresaAttribute()
    {
		return $this->attributes['ID_EMPRESA'];
    	// return $this->belongsTo(Empresa::class, 'ID_EMPRESA', 'ID');
    }

	public function setIdEmpresaAttribute($idEmpresa) 
	{
		$this->attributes['ID_EMPRESA'] = $idEmpresa;
	}


    /**
     * Gets e Sets
     */
    public function getIdAttribute() 
	{
		return $this->attributes['ID'];
	}

	public function setIdAttribute($id) 
	{
		$this->attributes['ID'] = $id;
	}

    public function getCertificadoDigitalSerieAttribute() 
	{
		return $this->attributes['CERTIFICADO_DIGITAL_SERIE'];
	}

	public function setCertificadoDigitalSerieAttribute($certificadoDigitalSerie) 
	{
		$this->attributes['CERTIFICADO_DIGITAL_SERIE'] = $certificadoDigitalSerie;
	}

    public function getCertificadoDigitalCaminhoAttribute() 
	{
		return $this->attributes['CERTIFICADO_DIGITAL_CAMINHO'];
	}

	public function setCertificadoDigitalCaminhoAttribute($certificadoDigitalCaminho) 
	{
		$this->attributes['CERTIFICADO_DIGITAL_CAMINHO'] = $certificadoDigitalCaminho;
	}

    public function getCertificadoDigitalSenhaAttribute() 
	{
		return $this->attributes['CERTIFICADO_DIGITAL_SENHA'];
	}

	public function setCertificadoDigitalSenhaAttribute($certificadoDigitalSenha) 
	{
		$this->attributes['CERTIFICADO_DIGITAL_SENHA'] = $certificadoDigitalSenha;
	}

    public function getTipoEmissaoAttribute() 
	{
		return $this->attributes['TIPO_EMISSAO'];
	}

	public function setTipoEmissaoAttribute($tipoEmissao) 
	{
		$this->attributes['TIPO_EMISSAO'] = $tipoEmissao;
	}

    public function getFormatoImpressaoDanfeAttribute() 
	{
		return $this->attributes['FORMATO_IMPRESSAO_DANFE'];
	}

	public function setFormatoImpressaoDanfeAttribute($formatoImpressaoDanfe) 
	{
		$this->attributes['FORMATO_IMPRESSAO_DANFE'] = $formatoImpressaoDanfe;
	}

    public function getProcessoEmissaoAttribute() 
	{
		return $this->attributes['PROCESSO_EMISSAO'];
	}

	public function setProcessoEmissaoAttribute($processoEmissao) 
	{
		$this->attributes['PROCESSO_EMISSAO'] = $processoEmissao;
	}

    public function getVersaoProcessoEmissaoAttribute() 
	{
		return $this->attributes['VERSAO_PROCESSO_EMISSAO'];
	}

	public function setVersaoProcessoEmissaoAttribute($versaoProcessoEmissao) 
	{
		$this->attributes['VERSAO_PROCESSO_EMISSAO'] = $versaoProcessoEmissao;
	}

    public function getCaminhoLogomarcaAttribute() 
	{
		return $this->attributes['CAMINHO_LOGOMARCA'];
	}

	public function setCaminhoLogomarcaAttribute($caminhoLogomarca) 
	{
		$this->attributes['CAMINHO_LOGOMARCA'] = $caminhoLogomarca;
	}

    public function getSalvarXmlAttribute() 
	{
		return $this->attributes['SALVAR_XML'];
	}

	public function setSalvarXmlAttribute($salvarXml) 
	{
		$this->attributes['SALVAR_XML'] = $salvarXml;
	}

    public function getCaminhoSalvarXmlAttribute() 
	{
		return $this->attributes['CAMINHO_SALVAR_XML'];
	}

	public function setCaminhoSalvarXmlAttribute($caminhoSalvarXml) 
	{
		$this->attributes['CAMINHO_SALVAR_XML'] = $caminhoSalvarXml;
	}

    public function getCaminhoSchemasAttribute() 
	{
		return $this->attributes['CAMINHO_SCHEMAS'];
	}

	public function setCaminhoSchemasAttribute($caminhoSchemas) 
	{
		$this->attributes['CAMINHO_SCHEMAS'] = $caminhoSchemas;
	}

    public function getCaminhoArquivoDanfeAttribute() 
	{
		return $this->attributes['CAMINHO_ARQUIVO_DANFE'];
	}

	public function setCaminhoArquivoDanfeAttribute($caminhoArquivoDanfe) 
	{
		$this->attributes['CAMINHO_ARQUIVO_DANFE'] = $caminhoArquivoDanfe;
	}

    public function getCaminhoSalvarPdfAttribute() 
	{
		return $this->attributes['CAMINHO_SALVAR_PDF'];
	}

	public function setCaminhoSalvarPdfAttribute($caminhoSalvarPdf) 
	{
		$this->attributes['CAMINHO_SALVAR_PDF'] = $caminhoSalvarPdf;
	}

    public function getWebserviceUfAttribute() 
	{
		return $this->attributes['WEBSERVICE_UF'];
	}

	public function setWebserviceUfAttribute($webserviceUf) 
	{
		$this->attributes['WEBSERVICE_UF'] = $webserviceUf;
	}

    public function getWebserviceAmbienteAttribute() 
	{
		return $this->attributes['WEBSERVICE_AMBIENTE'];
	}

	public function setWebserviceAmbienteAttribute($webserviceAmbiente) 
	{
		$this->attributes['WEBSERVICE_AMBIENTE'] = $webserviceAmbiente;
	}

    public function getWebserviceProxyHostAttribute() 
	{
		return $this->attributes['WEBSERVICE_PROXY_HOST'];
	}

	public function setWebserviceProxyHostAttribute($webserviceProxyHost) 
	{
		$this->attributes['WEBSERVICE_PROXY_HOST'] = $webserviceProxyHost;
	}

    public function getWebserviceProxyPortaAttribute() 
	{
		return $this->attributes['WEBSERVICE_PROXY_PORTA'];
	}

	public function setWebserviceProxyPortaAttribute($webserviceProxyPorta) 
	{
		$this->attributes['WEBSERVICE_PROXY_PORTA'] = $webserviceProxyPorta;
	}

    public function getWebserviceProxyUsuarioAttribute() 
	{
		return $this->attributes['WEBSERVICE_PROXY_USUARIO'];
	}

	public function setWebserviceProxyUsuarioAttribute($webserviceProxyUsuario) 
	{
		$this->attributes['WEBSERVICE_PROXY_USUARIO'] = $webserviceProxyUsuario;
	}

    public function getWebserviceProxySenhaAttribute() 
	{
		return $this->attributes['WEBSERVICE_PROXY_SENHA'];
	}

	public function setWebserviceProxySenhaAttribute($webserviceProxySenha) 
	{
		$this->attributes['WEBSERVICE_PROXY_SENHA'] = $webserviceProxySenha;
	}

    public function getWebserviceVisualizarAttribute() 
	{
		return $this->attributes['WEBSERVICE_VISUALIZAR'];
	}

	public function setWebserviceVisualizarAttribute($webserviceVisualizar) 
	{
		$this->attributes['WEBSERVICE_VISUALIZAR'] = $webserviceVisualizar;
	}

    public function getEmailServidorSmtpAttribute() 
	{
		return $this->attributes['EMAIL_SERVIDOR_SMTP'];
	}

	public function setEmailServidorSmtpAttribute($emailServidorSmtp) 
	{
		$this->attributes['EMAIL_SERVIDOR_SMTP'] = $emailServidorSmtp;
	}

    public function getEmailPortaAttribute() 
	{
		return $this->attributes['EMAIL_PORTA'];
	}

	public function setEmailPortaAttribute($emailPorta) 
	{
		$this->attributes['EMAIL_PORTA'] = $emailPorta;
	}

    public function getEmailUsuarioAttribute() 
	{
		return $this->attributes['EMAIL_USUARIO'];
	}

	public function setEmailUsuarioAttribute($emailUsuario) 
	{
		$this->attributes['EMAIL_USUARIO'] = $emailUsuario;
	}

    public function getEmailSenhaAttribute() 
	{
		return $this->attributes['EMAIL_SENHA'];
	}

	public function setEmailSenhaAttribute($emailSenha) 
	{
		$this->attributes['EMAIL_SENHA'] = $emailSenha;
	}

    public function getEmailAssuntoAttribute() 
	{
		return $this->attributes['EMAIL_ASSUNTO'];
	}

	public function setEmailAssuntoAttribute($emailAssunto) 
	{
		$this->attributes['EMAIL_ASSUNTO'] = $emailAssunto;
	}

    public function getEmailAutenticaSslAttribute() 
	{
		return $this->attributes['EMAIL_AUTENTICA_SSL'];
	}

	public function setEmailAutenticaSslAttribute($emailAutenticaSsl) 
	{
		$this->attributes['EMAIL_AUTENTICA_SSL'] = $emailAutenticaSsl;
	}

    public function getEmailTextoAttribute() 
	{
		return $this->attributes['EMAIL_TEXTO'];
	}

	public function setEmailTextoAttribute($emailTexto) 
	{
		$this->attributes['EMAIL_TEXTO'] = $emailTexto;
	}

    public function getNfceIdCscAttribute() 
	{
		return $this->attributes['NFCE_ID_CSC'];
	}

	public function setNfceIdCscAttribute($nfceIdCsc) 
	{
		$this->attributes['NFCE_ID_CSC'] = $nfceIdCsc;
	}

    public function getNfceCscAttribute() 
	{
		return $this->attributes['NFCE_CSC'];
	}

	public function setNfceCscAttribute($nfceCsc) 
	{
		$this->attributes['NFCE_CSC'] = $nfceCsc;
	}

    public function getNfceModeloImpressaoAttribute() 
	{
		return $this->attributes['NFCE_MODELO_IMPRESSAO'];
	}

	public function setNfceModeloImpressaoAttribute($nfceModeloImpressao) 
	{
		$this->attributes['NFCE_MODELO_IMPRESSAO'] = $nfceModeloImpressao;
	}

    public function getNfceImprimirItensUmaLinhaAttribute() 
	{
		return $this->attributes['NFCE_IMPRIMIR_ITENS_UMA_LINHA'];
	}

	public function setNfceImprimirItensUmaLinhaAttribute($nfceImprimirItensUmaLinha) 
	{
		$this->attributes['NFCE_IMPRIMIR_ITENS_UMA_LINHA'] = $nfceImprimirItensUmaLinha;
	}

    public function getNfceImprimirDescontoPorItemAttribute() 
	{
		return $this->attributes['NFCE_IMPRIMIR_DESCONTO_POR_ITEM'];
	}

	public function setNfceImprimirDescontoPorItemAttribute($nfceImprimirDescontoPorItem) 
	{
		$this->attributes['NFCE_IMPRIMIR_DESCONTO_POR_ITEM'] = $nfceImprimirDescontoPorItem;
	}

    public function getNfceImprimirQrcodeLateralAttribute() 
	{
		return $this->attributes['NFCE_IMPRIMIR_QRCODE_LATERAL'];
	}

	public function setNfceImprimirQrcodeLateralAttribute($nfceImprimirQrcodeLateral) 
	{
		$this->attributes['NFCE_IMPRIMIR_QRCODE_LATERAL'] = $nfceImprimirQrcodeLateral;
	}

    public function getNfceImprimirGtinAttribute() 
	{
		return $this->attributes['NFCE_IMPRIMIR_GTIN'];
	}

	public function setNfceImprimirGtinAttribute($nfceImprimirGtin) 
	{
		$this->attributes['NFCE_IMPRIMIR_GTIN'] = $nfceImprimirGtin;
	}

    public function getNfceImprimirNomeFantasiaAttribute() 
	{
		return $this->attributes['NFCE_IMPRIMIR_NOME_FANTASIA'];
	}

	public function setNfceImprimirNomeFantasiaAttribute($nfceImprimirNomeFantasia) 
	{
		$this->attributes['NFCE_IMPRIMIR_NOME_FANTASIA'] = $nfceImprimirNomeFantasia;
	}

    public function getNfceImpressaoTributosAttribute() 
	{
		return $this->attributes['NFCE_IMPRESSAO_TRIBUTOS'];
	}

	public function setNfceImpressaoTributosAttribute($nfceImpressaoTributos) 
	{
		$this->attributes['NFCE_IMPRESSAO_TRIBUTOS'] = $nfceImpressaoTributos;
	}

    public function getNfceMargemSuperiorAttribute() 
	{
		return $this->attributes['NFCE_MARGEM_SUPERIOR'];
	}

	public function setNfceMargemSuperiorAttribute($nfceMargemSuperior) 
	{
		$this->attributes['NFCE_MARGEM_SUPERIOR'] = $nfceMargemSuperior;
	}

    public function getNfceMargemInferiorAttribute() 
	{
		return $this->attributes['NFCE_MARGEM_INFERIOR'];
	}

	public function setNfceMargemInferiorAttribute($nfceMargemInferior) 
	{
		$this->attributes['NFCE_MARGEM_INFERIOR'] = $nfceMargemInferior;
	}

    public function getNfceMargemDireitaAttribute() 
	{
		return $this->attributes['NFCE_MARGEM_DIREITA'];
	}

	public function setNfceMargemDireitaAttribute($nfceMargemDireita) 
	{
		$this->attributes['NFCE_MARGEM_DIREITA'] = $nfceMargemDireita;
	}

    public function getNfceMargemEsquerdaAttribute() 
	{
		return $this->attributes['NFCE_MARGEM_ESQUERDA'];
	}

	public function setNfceMargemEsquerdaAttribute($nfceMargemEsquerda) 
	{
		$this->attributes['NFCE_MARGEM_ESQUERDA'] = $nfceMargemEsquerda;
	}

    public function getNfceResolucaoImpressaoAttribute() 
	{
		return $this->attributes['NFCE_RESOLUCAO_IMPRESSAO'];
	}

	public function setNfceResolucaoImpressaoAttribute($nfceResolucaoImpressao) 
	{
		$this->attributes['NFCE_RESOLUCAO_IMPRESSAO'] = $nfceResolucaoImpressao;
	}

    public function getNfceTamanhoFonteItemAttribute() 
	{
		return $this->attributes['NFCE_TAMANHO_FONTE_ITEM'];
	}

	public function setNfceTamanhoFonteItemAttribute($nfceTamanhoFonteItem) 
	{
		$this->attributes['NFCE_TAMANHO_FONTE_ITEM'] = $nfceTamanhoFonteItem;
	}

    public function getRespTecCnpjAttribute() 
	{
		return $this->attributes['RESP_TEC_CNPJ'];
	}

	public function setRespTecCnpjAttribute($respTecCnpj) 
	{
		$this->attributes['RESP_TEC_CNPJ'] = $respTecCnpj;
	}

    public function getRespTecContatoAttribute() 
	{
		return $this->attributes['RESP_TEC_CONTATO'];
	}

	public function setRespTecContatoAttribute($respTecContato) 
	{
		$this->attributes['RESP_TEC_CONTATO'] = $respTecContato;
	}

    public function getRespTecEmailAttribute() 
	{
		return $this->attributes['RESP_TEC_EMAIL'];
	}

	public function setRespTecEmailAttribute($respTecEmail) 
	{
		$this->attributes['RESP_TEC_EMAIL'] = $respTecEmail;
	}

    public function getRespTecFoneAttribute() 
	{
		return $this->attributes['RESP_TEC_FONE'];
	}

	public function setRespTecFoneAttribute($respTecFone) 
	{
		$this->attributes['RESP_TEC_FONE'] = $respTecFone;
	}

    public function getRespTecIdCsrtAttribute() 
	{
		return $this->attributes['RESP_TEC_ID_CSRT'];
	}

	public function setRespTecIdCsrtAttribute($respTecIdCsrt) 
	{
		$this->attributes['RESP_TEC_ID_CSRT'] = $respTecIdCsrt;
	}

    public function getRespTecHashCsrtAttribute() 
	{
		return $this->attributes['RESP_TEC_HASH_CSRT'];
	}

	public function setRespTecHashCsrtAttribute($respTecHashCsrt) 
	{
		$this->attributes['RESP_TEC_HASH_CSRT'] = $respTecHashCsrt;
	}


    /**
     * Mapping
     */
    public function mapear($objeto)
    {
        if (isset($objeto)) {
            isset($objeto->id) ? $this->setIdAttribute($objeto->id) : $this->setIdAttribute(null);

			$this->setCertificadoDigitalSerieAttribute($objeto->certificadoDigitalSerie);
			$this->setCertificadoDigitalCaminhoAttribute($objeto->certificadoDigitalCaminho);
			$this->setCertificadoDigitalSenhaAttribute($objeto->certificadoDigitalSenha);
			$this->setTipoEmissaoAttribute($objeto->tipoEmissao);
			$this->setFormatoImpressaoDanfeAttribute($objeto->formatoImpressaoDanfe);
			$this->setProcessoEmissaoAttribute($objeto->processoEmissao);
			$this->setVersaoProcessoEmissaoAttribute($objeto->versaoProcessoEmissao);
			$this->setCaminhoLogomarcaAttribute($objeto->caminhoLogomarca);
			$this->setSalvarXmlAttribute($objeto->salvarXml);
			$this->setCaminhoSalvarXmlAttribute($objeto->caminhoSalvarXml);
			$this->setCaminhoSchemasAttribute($objeto->caminhoSchemas);
			$this->setCaminhoArquivoDanfeAttribute($objeto->caminhoArquivoDanfe);
			$this->setCaminhoSalvarPdfAttribute($objeto->caminhoSalvarPdf);
			$this->setWebserviceUfAttribute($objeto->webserviceUf);
			$this->setWebserviceAmbienteAttribute($objeto->webserviceAmbiente);
			$this->setWebserviceProxyHostAttribute($objeto->webserviceProxyHost);
			$this->setWebserviceProxyPortaAttribute($objeto->webserviceProxyPorta);
			$this->setWebserviceProxyUsuarioAttribute($objeto->webserviceProxyUsuario);
			$this->setWebserviceProxySenhaAttribute($objeto->webserviceProxySenha);
			$this->setWebserviceVisualizarAttribute($objeto->webserviceVisualizar);
			$this->setEmailServidorSmtpAttribute($objeto->emailServidorSmtp);
			$this->setEmailPortaAttribute($objeto->emailPorta);
			$this->setEmailUsuarioAttribute($objeto->emailUsuario);
			$this->setEmailSenhaAttribute($objeto->emailSenha);
			$this->setEmailAssuntoAttribute($objeto->emailAssunto);
			$this->setEmailAutenticaSslAttribute($objeto->emailAutenticaSsl);
			$this->setEmailTextoAttribute($objeto->emailTexto);
			$this->setNfceIdCscAttribute($objeto->nfceIdCsc);
			$this->setNfceCscAttribute($objeto->nfceCsc);
			$this->setNfceModeloImpressaoAttribute($objeto->nfceModeloImpressao);
			$this->setNfceImprimirItensUmaLinhaAttribute($objeto->nfceImprimirItensUmaLinha);
			$this->setNfceImprimirDescontoPorItemAttribute($objeto->nfceImprimirDescontoPorItem);
			$this->setNfceImprimirQrcodeLateralAttribute($objeto->nfceImprimirQrcodeLateral);
			$this->setNfceImprimirGtinAttribute($objeto->nfceImprimirGtin);
			$this->setNfceImprimirNomeFantasiaAttribute($objeto->nfceImprimirNomeFantasia);
			$this->setNfceImpressaoTributosAttribute($objeto->nfceImpressaoTributos);
			$this->setNfceMargemSuperiorAttribute($objeto->nfceMargemSuperior);
			$this->setNfceMargemInferiorAttribute($objeto->nfceMargemInferior);
			$this->setNfceMargemDireitaAttribute($objeto->nfceMargemDireita);
			$this->setNfceMargemEsquerdaAttribute($objeto->nfceMargemEsquerda);
			$this->setNfceResolucaoImpressaoAttribute($objeto->nfceResolucaoImpressao);
			$this->setNfceTamanhoFonteItemAttribute($objeto->nfceTamanhoFonteItem);
			$this->setRespTecCnpjAttribute($objeto->respTecCnpj);
			$this->setRespTecContatoAttribute($objeto->respTecContato);
			$this->setRespTecEmailAttribute($objeto->respTecEmail);
			$this->setRespTecFoneAttribute($objeto->respTecFone);
			$this->setRespTecIdCsrtAttribute($objeto->respTecIdCsrt);
			$this->setRespTecHashCsrtAttribute($objeto->respTecHashCsrt);

			// vincular objetos
        }
    }

    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getIdAttribute(),
			'certificadoDigitalSerie' => $this->getCertificadoDigitalSerieAttribute(),
			'certificadoDigitalCaminho' => $this->getCertificadoDigitalCaminhoAttribute(),
			'certificadoDigitalSenha' => $this->getCertificadoDigitalSenhaAttribute(),
			'tipoEmissao' => $this->getTipoEmissaoAttribute(),
			'formatoImpressaoDanfe' => $this->getFormatoImpressaoDanfeAttribute(),
			'processoEmissao' => $this->getProcessoEmissaoAttribute(),
			'versaoProcessoEmissao' => $this->getVersaoProcessoEmissaoAttribute(),
			'caminhoLogomarca' => $this->getCaminhoLogomarcaAttribute(),
			'salvarXml' => $this->getSalvarXmlAttribute(),
			'caminhoSalvarXml' => $this->getCaminhoSalvarXmlAttribute(),
			'caminhoSchemas' => $this->getCaminhoSchemasAttribute(),
			'caminhoArquivoDanfe' => $this->getCaminhoArquivoDanfeAttribute(),
			'caminhoSalvarPdf' => $this->getCaminhoSalvarPdfAttribute(),
			'webserviceUf' => $this->getWebserviceUfAttribute(),
			'webserviceAmbiente' => $this->getWebserviceAmbienteAttribute(),
			'webserviceProxyHost' => $this->getWebserviceProxyHostAttribute(),
			'webserviceProxyPorta' => $this->getWebserviceProxyPortaAttribute(),
			'webserviceProxyUsuario' => $this->getWebserviceProxyUsuarioAttribute(),
			'webserviceProxySenha' => $this->getWebserviceProxySenhaAttribute(),
			'webserviceVisualizar' => $this->getWebserviceVisualizarAttribute(),
			'emailServidorSmtp' => $this->getEmailServidorSmtpAttribute(),
			'emailPorta' => $this->getEmailPortaAttribute(),
			'emailUsuario' => $this->getEmailUsuarioAttribute(),
			'emailSenha' => $this->getEmailSenhaAttribute(),
			'emailAssunto' => $this->getEmailAssuntoAttribute(),
			'emailAutenticaSsl' => $this->getEmailAutenticaSslAttribute(),
			'emailTexto' => $this->getEmailTextoAttribute(),
			'nfceIdCsc' => $this->getNfceIdCscAttribute(),
			'nfceCsc' => $this->getNfceCscAttribute(),
			'nfceModeloImpressao' => $this->getNfceModeloImpressaoAttribute(),
			'nfceImprimirItensUmaLinha' => $this->getNfceImprimirItensUmaLinhaAttribute(),
			'nfceImprimirDescontoPorItem' => $this->getNfceImprimirDescontoPorItemAttribute(),
			'nfceImprimirQrcodeLateral' => $this->getNfceImprimirQrcodeLateralAttribute(),
			'nfceImprimirGtin' => $this->getNfceImprimirGtinAttribute(),
			'nfceImprimirNomeFantasia' => $this->getNfceImprimirNomeFantasiaAttribute(),
			'nfceImpressaoTributos' => $this->getNfceImpressaoTributosAttribute(),
			'nfceMargemSuperior' => $this->getNfceMargemSuperiorAttribute(),
			'nfceMargemInferior' => $this->getNfceMargemInferiorAttribute(),
			'nfceMargemDireita' => $this->getNfceMargemDireitaAttribute(),
			'nfceMargemEsquerda' => $this->getNfceMargemEsquerdaAttribute(),
			'nfceResolucaoImpressao' => $this->getNfceResolucaoImpressaoAttribute(),
			'nfceTamanhoFonteItem' => $this->getNfceTamanhoFonteItemAttribute(),
			'respTecCnpj' => $this->getRespTecCnpjAttribute(),
			'respTecContato' => $this->getRespTecContatoAttribute(),
			'respTecEmail' => $this->getRespTecEmailAttribute(),
			'respTecFone' => $this->getRespTecFoneAttribute(),
			'respTecIdCsrt' => $this->getRespTecIdCsrtAttribute(),
			'respTecHashCsrt' => $this->getRespTecHashCsrtAttribute(),
        ];
    }
}