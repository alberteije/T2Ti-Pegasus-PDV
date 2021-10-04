<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CONFIGURACAO_BOLETO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
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

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="FIN_CONFIGURACAO_BOLETO")
 */
class FinConfiguracaoBoleto extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="string", name="INSTRUCAO01")
	 */
	private $instrucao01;

	/**
	 * @ORM\Column(type="string", name="INSTRUCAO02")
	 */
	private $instrucao02;

	/**
	 * @ORM\Column(type="string", name="CAMINHO_ARQUIVO_REMESSA")
	 */
	private $caminhoArquivoRemessa;

	/**
	 * @ORM\Column(type="string", name="CAMINHO_ARQUIVO_RETORNO")
	 */
	private $caminhoArquivoRetorno;

	/**
	 * @ORM\Column(type="string", name="CAMINHO_ARQUIVO_LOGOTIPO")
	 */
	private $caminhoArquivoLogotipo;

	/**
	 * @ORM\Column(type="string", name="CAMINHO_ARQUIVO_PDF")
	 */
	private $caminhoArquivoPdf;

	/**
	 * @ORM\Column(type="string", name="MENSAGEM")
	 */
	private $mensagem;

	/**
	 * @ORM\Column(type="string", name="LOCAL_PAGAMENTO")
	 */
	private $localPagamento;

	/**
	 * @ORM\Column(type="string", name="LAYOUT_REMESSA")
	 */
	private $layoutRemessa;

	/**
	 * @ORM\Column(type="string", name="ACEITE")
	 */
	private $aceite;

	/**
	 * @ORM\Column(type="string", name="ESPECIE")
	 */
	private $especie;

	/**
	 * @ORM\Column(type="string", name="CARTEIRA")
	 */
	private $carteira;

	/**
	 * @ORM\Column(type="string", name="CODIGO_CONVENIO")
	 */
	private $codigoConvenio;

	/**
	 * @ORM\Column(type="string", name="CODIGO_CEDENTE")
	 */
	private $codigoCedente;

	/**
	 * @ORM\Column(type="float", name="TAXA_MULTA")
	 */
	private $taxaMulta;

	/**
	 * @ORM\Column(type="float", name="TAXA_JURO")
	 */
	private $taxaJuro;

	/**
	 * @ORM\Column(type="integer", name="DIAS_PROTESTO")
	 */
	private $diasProtesto;

	/**
	 * @ORM\Column(type="string", name="NOSSO_NUMERO_ANTERIOR")
	 */
	private $nossoNumeroAnterior;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="BancoContaCaixa", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_BANCO_CONTA_CAIXA", referencedColumnName="id")
     */
    private $bancoContaCaixa;


    /**
     * Gets e Sets
     */

    public function getId() 
	{
		return $this->id;
	}

	public function setId($id) 
	{
		$this->id = $id;
	}

    public function getInstrucao01() 
	{
		return $this->instrucao01;
	}

	public function setInstrucao01($instrucao01) 
	{
		$this->instrucao01 = $instrucao01;
	}

    public function getInstrucao02() 
	{
		return $this->instrucao02;
	}

	public function setInstrucao02($instrucao02) 
	{
		$this->instrucao02 = $instrucao02;
	}

    public function getCaminhoArquivoRemessa() 
	{
		return $this->caminhoArquivoRemessa;
	}

	public function setCaminhoArquivoRemessa($caminhoArquivoRemessa) 
	{
		$this->caminhoArquivoRemessa = $caminhoArquivoRemessa;
	}

    public function getCaminhoArquivoRetorno() 
	{
		return $this->caminhoArquivoRetorno;
	}

	public function setCaminhoArquivoRetorno($caminhoArquivoRetorno) 
	{
		$this->caminhoArquivoRetorno = $caminhoArquivoRetorno;
	}

    public function getCaminhoArquivoLogotipo() 
	{
		return $this->caminhoArquivoLogotipo;
	}

	public function setCaminhoArquivoLogotipo($caminhoArquivoLogotipo) 
	{
		$this->caminhoArquivoLogotipo = $caminhoArquivoLogotipo;
	}

    public function getCaminhoArquivoPdf() 
	{
		return $this->caminhoArquivoPdf;
	}

	public function setCaminhoArquivoPdf($caminhoArquivoPdf) 
	{
		$this->caminhoArquivoPdf = $caminhoArquivoPdf;
	}

    public function getMensagem() 
	{
		return $this->mensagem;
	}

	public function setMensagem($mensagem) 
	{
		$this->mensagem = $mensagem;
	}

    public function getLocalPagamento() 
	{
		return $this->localPagamento;
	}

	public function setLocalPagamento($localPagamento) 
	{
		$this->localPagamento = $localPagamento;
	}

    public function getLayoutRemessa() 
	{
		return $this->layoutRemessa;
	}

	public function setLayoutRemessa($layoutRemessa) 
	{
		$this->layoutRemessa = $layoutRemessa;
	}

    public function getAceite() 
	{
		return $this->aceite;
	}

	public function setAceite($aceite) 
	{
		$this->aceite = $aceite;
	}

    public function getEspecie() 
	{
		return $this->especie;
	}

	public function setEspecie($especie) 
	{
		$this->especie = $especie;
	}

    public function getCarteira() 
	{
		return $this->carteira;
	}

	public function setCarteira($carteira) 
	{
		$this->carteira = $carteira;
	}

    public function getCodigoConvenio() 
	{
		return $this->codigoConvenio;
	}

	public function setCodigoConvenio($codigoConvenio) 
	{
		$this->codigoConvenio = $codigoConvenio;
	}

    public function getCodigoCedente() 
	{
		return $this->codigoCedente;
	}

	public function setCodigoCedente($codigoCedente) 
	{
		$this->codigoCedente = $codigoCedente;
	}

    public function getTaxaMulta() 
	{
		return $this->taxaMulta;
	}

	public function setTaxaMulta($taxaMulta) 
	{
		$this->taxaMulta = $taxaMulta;
	}

    public function getTaxaJuro() 
	{
		return $this->taxaJuro;
	}

	public function setTaxaJuro($taxaJuro) 
	{
		$this->taxaJuro = $taxaJuro;
	}

    public function getDiasProtesto() 
	{
		return $this->diasProtesto;
	}

	public function setDiasProtesto($diasProtesto) 
	{
		$this->diasProtesto = $diasProtesto;
	}

    public function getNossoNumeroAnterior() 
	{
		return $this->nossoNumeroAnterior;
	}

	public function setNossoNumeroAnterior($nossoNumeroAnterior) 
	{
		$this->nossoNumeroAnterior = $nossoNumeroAnterior;
	}

    public function getBancoContaCaixa(): ?BancoContaCaixa 
	{
		return $this->bancoContaCaixa;
	}

	public function setBancoContaCaixa(?BancoContaCaixa $bancoContaCaixa) 
	{
		$this->bancoContaCaixa = $bancoContaCaixa;
	}


    /**
     * Constructor
     */
    public function __construct($objetoJson)
    {
        if (isset($objetoJson)) {
            isset($objetoJson->id) ? $this->setId($objetoJson->id) : $this->setId(null);
            $this->mapear($objetoJson);
        }

		
    }

    /**
     * Mapping
     */
    public function mapear($objeto)
    {
        if (isset($objeto)) {
			$this->setInstrucao01($objeto->instrucao01);
			$this->setInstrucao02($objeto->instrucao02);
			$this->setCaminhoArquivoRemessa($objeto->caminhoArquivoRemessa);
			$this->setCaminhoArquivoRetorno($objeto->caminhoArquivoRetorno);
			$this->setCaminhoArquivoLogotipo($objeto->caminhoArquivoLogotipo);
			$this->setCaminhoArquivoPdf($objeto->caminhoArquivoPdf);
			$this->setMensagem($objeto->mensagem);
			$this->setLocalPagamento($objeto->localPagamento);
			$this->setLayoutRemessa($objeto->layoutRemessa);
			$this->setAceite($objeto->aceite);
			$this->setEspecie($objeto->especie);
			$this->setCarteira($objeto->carteira);
			$this->setCodigoConvenio($objeto->codigoConvenio);
			$this->setCodigoCedente($objeto->codigoCedente);
			$this->setTaxaMulta($objeto->taxaMulta);
			$this->setTaxaJuro($objeto->taxaJuro);
			$this->setDiasProtesto($objeto->diasProtesto);
			$this->setNossoNumeroAnterior($objeto->nossoNumeroAnterior);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'FinConfiguracaoBoleto');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'instrucao01' => $this->getInstrucao01(),
			'instrucao02' => $this->getInstrucao02(),
			'caminhoArquivoRemessa' => $this->getCaminhoArquivoRemessa(),
			'caminhoArquivoRetorno' => $this->getCaminhoArquivoRetorno(),
			'caminhoArquivoLogotipo' => $this->getCaminhoArquivoLogotipo(),
			'caminhoArquivoPdf' => $this->getCaminhoArquivoPdf(),
			'mensagem' => $this->getMensagem(),
			'localPagamento' => $this->getLocalPagamento(),
			'layoutRemessa' => $this->getLayoutRemessa(),
			'aceite' => $this->getAceite(),
			'especie' => $this->getEspecie(),
			'carteira' => $this->getCarteira(),
			'codigoConvenio' => $this->getCodigoConvenio(),
			'codigoCedente' => $this->getCodigoCedente(),
			'taxaMulta' => $this->getTaxaMulta(),
			'taxaJuro' => $this->getTaxaJuro(),
			'diasProtesto' => $this->getDiasProtesto(),
			'nossoNumeroAnterior' => $this->getNossoNumeroAnterior(),
			'bancoContaCaixa' => $this->getBancoContaCaixa(),
        ];
    }
}
