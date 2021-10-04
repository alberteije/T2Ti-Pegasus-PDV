<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [CHEQUE] 
                                                                                
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
 * @ORM\Table(name="CHEQUE")
 */
class Cheque extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="integer", name="NUMERO")
	 */
	private $numero;

	/**
	 * @ORM\Column(type="string", name="STATUS_CHEQUE")
	 */
	private $statusCheque;

	/**
	 * @ORM\Column(type="date", name="DATA_STATUS")
	 */
	private $dataStatus;


    /**
     * Relations
     */
    
    /**
     * @ORM\ManyToOne(targetEntity="TalonarioCheque", inversedBy="listaCheque")
     * @ORM\JoinColumn(name="ID_TALONARIO_CHEQUE", referencedColumnName="id")
     */
    private $talonarioCheque;


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

    public function getStatusCheque() 
	{
		return $this->statusCheque;
	}

	public function setStatusCheque($statusCheque) 
	{
		$this->statusCheque = $statusCheque;
	}

    public function getDataStatus() 
	{
		if ($this->dataStatus != null) {
			return $this->dataStatus->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataStatus($dataStatus) 
	{
		$this->dataStatus = $dataStatus != null ? new \DateTime($dataStatus) : null;
	}

    public function getTalonarioCheque(): ?TalonarioCheque 
	{
		return $this->talonarioCheque;
	}

	public function setTalonarioCheque(?TalonarioCheque $talonarioCheque) 
	{
		$this->talonarioCheque = $talonarioCheque;
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
			$this->setStatusCheque($objeto->statusCheque);
			$this->setDataStatus($objeto->dataStatus);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Cheque');
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
			'statusCheque' => $this->getStatusCheque(),
			'dataStatus' => $this->getDataStatus(),
        ];
    }
}
