<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA_ENDERECO] 
                                                                                
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
 * @ORM\Table(name="PESSOA_ENDERECO")
 */
class PessoaEndereco extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="string", name="LOGRADOURO")
	 */
	private $logradouro;

	/**
	 * @ORM\Column(type="string", name="NUMERO")
	 */
	private $numero;

	/**
	 * @ORM\Column(type="string", name="BAIRRO")
	 */
	private $bairro;

	/**
	 * @ORM\Column(type="integer", name="MUNICIPIO_IBGE")
	 */
	private $municipioIbge;

	/**
	 * @ORM\Column(type="string", name="UF")
	 */
	private $uf;

	/**
	 * @ORM\Column(type="string", name="CEP")
	 */
	private $cep;

	/**
	 * @ORM\Column(type="string", name="CIDADE")
	 */
	private $cidade;

	/**
	 * @ORM\Column(type="string", name="COMPLEMENTO")
	 */
	private $complemento;

	/**
	 * @ORM\Column(type="string", name="PRINCIPAL")
	 */
	private $principal;

	/**
	 * @ORM\Column(type="string", name="ENTREGA")
	 */
	private $entrega;

	/**
	 * @ORM\Column(type="string", name="COBRANCA")
	 */
	private $cobranca;

	/**
	 * @ORM\Column(type="string", name="CORRESPONDENCIA")
	 */
	private $correspondencia;


    /**
     * Relations
     */
    
    /**
     * @ORM\ManyToOne(targetEntity="Pessoa", inversedBy="listaPessoaEndereco")
     * @ORM\JoinColumn(name="ID_PESSOA", referencedColumnName="id")
     */
    private $pessoa;


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

    public function getLogradouro() 
	{
		return $this->logradouro;
	}

	public function setLogradouro($logradouro) 
	{
		$this->logradouro = $logradouro;
	}

    public function getNumero() 
	{
		return $this->numero;
	}

	public function setNumero($numero) 
	{
		$this->numero = $numero;
	}

    public function getBairro() 
	{
		return $this->bairro;
	}

	public function setBairro($bairro) 
	{
		$this->bairro = $bairro;
	}

    public function getMunicipioIbge() 
	{
		return $this->municipioIbge;
	}

	public function setMunicipioIbge($municipioIbge) 
	{
		$this->municipioIbge = $municipioIbge;
	}

    public function getUf() 
	{
		return $this->uf;
	}

	public function setUf($uf) 
	{
		$this->uf = $uf;
	}

    public function getCep() 
	{
		return $this->cep;
	}

	public function setCep($cep) 
	{
		$this->cep = $cep;
	}

    public function getCidade() 
	{
		return $this->cidade;
	}

	public function setCidade($cidade) 
	{
		$this->cidade = $cidade;
	}

    public function getComplemento() 
	{
		return $this->complemento;
	}

	public function setComplemento($complemento) 
	{
		$this->complemento = $complemento;
	}

    public function getPrincipal() 
	{
		return $this->principal;
	}

	public function setPrincipal($principal) 
	{
		$this->principal = $principal;
	}

    public function getEntrega() 
	{
		return $this->entrega;
	}

	public function setEntrega($entrega) 
	{
		$this->entrega = $entrega;
	}

    public function getCobranca() 
	{
		return $this->cobranca;
	}

	public function setCobranca($cobranca) 
	{
		$this->cobranca = $cobranca;
	}

    public function getCorrespondencia() 
	{
		return $this->correspondencia;
	}

	public function setCorrespondencia($correspondencia) 
	{
		$this->correspondencia = $correspondencia;
	}

    public function getPessoa(): ?Pessoa 
	{
		return $this->pessoa;
	}

	public function setPessoa(?Pessoa $pessoa) 
	{
		$this->pessoa = $pessoa;
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
			$this->setLogradouro($objeto->logradouro);
			$this->setNumero($objeto->numero);
			$this->setBairro($objeto->bairro);
			$this->setMunicipioIbge($objeto->municipioIbge);
			$this->setUf($objeto->uf);
			$this->setCep($objeto->cep);
			$this->setCidade($objeto->cidade);
			$this->setComplemento($objeto->complemento);
			$this->setPrincipal($objeto->principal);
			$this->setEntrega($objeto->entrega);
			$this->setCobranca($objeto->cobranca);
			$this->setCorrespondencia($objeto->correspondencia);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'PessoaEndereco');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'logradouro' => $this->getLogradouro(),
			'numero' => $this->getNumero(),
			'bairro' => $this->getBairro(),
			'municipioIbge' => $this->getMunicipioIbge(),
			'uf' => $this->getUf(),
			'cep' => $this->getCep(),
			'cidade' => $this->getCidade(),
			'complemento' => $this->getComplemento(),
			'principal' => $this->getPrincipal(),
			'entrega' => $this->getEntrega(),
			'cobranca' => $this->getCobranca(),
			'correspondencia' => $this->getCorrespondencia(),
        ];
    }
}
