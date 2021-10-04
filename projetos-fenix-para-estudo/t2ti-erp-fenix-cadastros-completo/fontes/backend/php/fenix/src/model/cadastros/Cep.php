<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [CEP] 
                                                                                
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
 * @ORM\Table(name="CEP")
 */
class Cep extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="string", name="NUMERO")
	 */
	private $numero;

	/**
	 * @ORM\Column(type="string", name="LOGRADOURO")
	 */
	private $logradouro;

	/**
	 * @ORM\Column(type="string", name="COMPLEMENTO")
	 */
	private $complemento;

	/**
	 * @ORM\Column(type="string", name="BAIRRO")
	 */
	private $bairro;

	/**
	 * @ORM\Column(type="string", name="MUNICIPIO")
	 */
	private $municipio;

	/**
	 * @ORM\Column(type="string", name="UF")
	 */
	private $uf;

	/**
	 * @ORM\Column(type="integer", name="CODIGO_IBGE_MUNICIPIO")
	 */
	private $codigoIbgeMunicipio;


    /**
     * Relations
     */
    

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

    public function getNumero() 
	{
		return $this->numero;
	}

	public function setNumero($numero) 
	{
		$this->numero = $numero;
	}

    public function getLogradouro() 
	{
		return $this->logradouro;
	}

	public function setLogradouro($logradouro) 
	{
		$this->logradouro = $logradouro;
	}

    public function getComplemento() 
	{
		return $this->complemento;
	}

	public function setComplemento($complemento) 
	{
		$this->complemento = $complemento;
	}

    public function getBairro() 
	{
		return $this->bairro;
	}

	public function setBairro($bairro) 
	{
		$this->bairro = $bairro;
	}

    public function getMunicipio() 
	{
		return $this->municipio;
	}

	public function setMunicipio($municipio) 
	{
		$this->municipio = $municipio;
	}

    public function getUf() 
	{
		return $this->uf;
	}

	public function setUf($uf) 
	{
		$this->uf = $uf;
	}

    public function getCodigoIbgeMunicipio() 
	{
		return $this->codigoIbgeMunicipio;
	}

	public function setCodigoIbgeMunicipio($codigoIbgeMunicipio) 
	{
		$this->codigoIbgeMunicipio = $codigoIbgeMunicipio;
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
			$this->setNumero($objeto->numero);
			$this->setLogradouro($objeto->logradouro);
			$this->setComplemento($objeto->complemento);
			$this->setBairro($objeto->bairro);
			$this->setMunicipio($objeto->municipio);
			$this->setUf($objeto->uf);
			$this->setCodigoIbgeMunicipio($objeto->codigoIbgeMunicipio);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Cep');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'numero' => $this->getNumero(),
			'logradouro' => $this->getLogradouro(),
			'complemento' => $this->getComplemento(),
			'bairro' => $this->getBairro(),
			'municipio' => $this->getMunicipio(),
			'uf' => $this->getUf(),
			'codigoIbgeMunicipio' => $this->getCodigoIbgeMunicipio(),
        ];
    }
}
