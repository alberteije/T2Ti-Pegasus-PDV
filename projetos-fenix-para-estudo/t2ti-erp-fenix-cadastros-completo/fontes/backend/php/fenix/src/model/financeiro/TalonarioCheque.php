<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [TALONARIO_CHEQUE] 
                                                                                
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
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity
 * @ORM\Table(name="TALONARIO_CHEQUE")
 */
class TalonarioCheque extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="string", name="TALAO")
	 */
	private $talao;

	/**
	 * @ORM\Column(type="integer", name="NUMERO")
	 */
	private $numero;

	/**
	 * @ORM\Column(type="string", name="STATUS_TALAO")
	 */
	private $statusTalao;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="BancoContaCaixa", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_BANCO_CONTA_CAIXA", referencedColumnName="id")
     */
    private $bancoContaCaixa;

    /**
     * @ORM\OneToMany(targetEntity="Cheque", mappedBy="talonarioCheque", cascade={"persist", "remove"})
     */
    private $listaCheque;


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

    public function getTalao() 
	{
		return $this->talao;
	}

	public function setTalao($talao) 
	{
		$this->talao = $talao;
	}

    public function getNumero() 
	{
		return $this->numero;
	}

	public function setNumero($numero) 
	{
		$this->numero = $numero;
	}

    public function getStatusTalao() 
	{
		return $this->statusTalao;
	}

	public function setStatusTalao($statusTalao) 
	{
		$this->statusTalao = $statusTalao;
	}

    public function getBancoContaCaixa(): ?BancoContaCaixa 
	{
		return $this->bancoContaCaixa;
	}

	public function setBancoContaCaixa(?BancoContaCaixa $bancoContaCaixa) 
	{
		$this->bancoContaCaixa = $bancoContaCaixa;
	}

    public function getListaCheque() 
	{
		return $this->listaCheque->toArray();
	}

	public function setListaCheque(array $listaCheque) {
		$this->listaCheque = new ArrayCollection();
		for ($i = 0; $i < count($listaCheque); $i++) {
			$cheque = $listaCheque[$i];
			$cheque->setTalonarioCheque($this);
			$this->listaCheque->add($cheque);
		}
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

		
		$this->listaCheque = new ArrayCollection();
		$listaChequeJson = $objetoJson->listaCheque;
		if ($listaChequeJson != null) {
			for ($i = 0; $i < count($listaChequeJson); $i++) {
				$objeto = new Cheque($listaChequeJson[$i]);
				$objeto->setTalonarioCheque($this);
				$this->listaCheque->add($objeto);
			}
		}

    }

    /**
     * Mapping
     */
    public function mapear($objeto)
    {
        if (isset($objeto)) {
			$this->setTalao($objeto->talao);
			$this->setNumero($objeto->numero);
			$this->setStatusTalao($objeto->statusTalao);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'TalonarioCheque');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'talao' => $this->getTalao(),
			'numero' => $this->getNumero(),
			'statusTalao' => $this->getStatusTalao(),
			'bancoContaCaixa' => $this->getBancoContaCaixa(),
			'listaCheque' => $this->getListaCheque(),
        ];
    }
}
