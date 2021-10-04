<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CHEQUE_EMITIDO] 
                                                                                
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
 * @ORM\Table(name="FIN_CHEQUE_EMITIDO")
 */
class FinChequeEmitido extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="date", name="DATA_EMISSAO")
	 */
	private $dataEmissao;

	/**
	 * @ORM\Column(type="date", name="BOM_PARA")
	 */
	private $bomPara;

	/**
	 * @ORM\Column(type="date", name="DATA_COMPENSACAO")
	 */
	private $dataCompensacao;

	/**
	 * @ORM\Column(type="float", name="VALOR")
	 */
	private $valor;

	/**
	 * @ORM\Column(type="string", name="NOMINAL_A")
	 */
	private $nominalA;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="Cheque", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_CHEQUE", referencedColumnName="id")
     */
    private $cheque;


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

    public function getDataEmissao() 
	{
		if ($this->dataEmissao != null) {
			return $this->dataEmissao->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataEmissao($dataEmissao) 
	{
		$this->dataEmissao = $dataEmissao != null ? new \DateTime($dataEmissao) : null;
	}

    public function getBomPara() 
	{
		if ($this->bomPara != null) {
			return $this->bomPara->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setBomPara($bomPara) 
	{
		$this->bomPara = $bomPara != null ? new \DateTime($bomPara) : null;
	}

    public function getDataCompensacao() 
	{
		if ($this->dataCompensacao != null) {
			return $this->dataCompensacao->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataCompensacao($dataCompensacao) 
	{
		$this->dataCompensacao = $dataCompensacao != null ? new \DateTime($dataCompensacao) : null;
	}

    public function getValor() 
	{
		return $this->valor;
	}

	public function setValor($valor) 
	{
		$this->valor = $valor;
	}

    public function getNominalA() 
	{
		return $this->nominalA;
	}

	public function setNominalA($nominalA) 
	{
		$this->nominalA = $nominalA;
	}

    public function getCheque(): ?Cheque 
	{
		return $this->cheque;
	}

	public function setCheque(?Cheque $cheque) 
	{
		$this->cheque = $cheque;
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
			$this->setDataEmissao($objeto->dataEmissao);
			$this->setBomPara($objeto->bomPara);
			$this->setDataCompensacao($objeto->dataCompensacao);
			$this->setValor($objeto->valor);
			$this->setNominalA($objeto->nominalA);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'FinChequeEmitido');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'dataEmissao' => $this->getDataEmissao(),
			'bomPara' => $this->getBomPara(),
			'dataCompensacao' => $this->getDataCompensacao(),
			'valor' => $this->getValor(),
			'nominalA' => $this->getNominalA(),
			'cheque' => $this->getCheque(),
        ];
    }
}
