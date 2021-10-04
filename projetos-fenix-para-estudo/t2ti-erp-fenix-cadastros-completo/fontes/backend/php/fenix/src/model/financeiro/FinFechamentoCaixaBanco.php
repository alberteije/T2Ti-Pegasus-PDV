<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_FECHAMENTO_CAIXA_BANCO] 
                                                                                
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
 * @ORM\Table(name="FIN_FECHAMENTO_CAIXA_BANCO")
 */
class FinFechamentoCaixaBanco extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="date", name="DATA_FECHAMENTO")
	 */
	private $dataFechamento;

	/**
	 * @ORM\Column(type="string", name="MES_ANO")
	 */
	private $mesAno;

	/**
	 * @ORM\Column(type="string", name="MES")
	 */
	private $mes;

	/**
	 * @ORM\Column(type="string", name="ANO")
	 */
	private $ano;

	/**
	 * @ORM\Column(type="float", name="SALDO_ANTERIOR")
	 */
	private $saldoAnterior;

	/**
	 * @ORM\Column(type="float", name="RECEBIMENTOS")
	 */
	private $recebimentos;

	/**
	 * @ORM\Column(type="float", name="PAGAMENTOS")
	 */
	private $pagamentos;

	/**
	 * @ORM\Column(type="float", name="SALDO_CONTA")
	 */
	private $saldoConta;

	/**
	 * @ORM\Column(type="float", name="CHEQUE_NAO_COMPENSADO")
	 */
	private $chequeNaoCompensado;

	/**
	 * @ORM\Column(type="float", name="SALDO_DISPONIVEL")
	 */
	private $saldoDisponivel;


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

    public function getDataFechamento() 
	{
		if ($this->dataFechamento != null) {
			return $this->dataFechamento->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataFechamento($dataFechamento) 
	{
		$this->dataFechamento = $dataFechamento != null ? new \DateTime($dataFechamento) : null;
	}

    public function getMesAno() 
	{
		return $this->mesAno;
	}

	public function setMesAno($mesAno) 
	{
		$this->mesAno = $mesAno;
	}

    public function getMes() 
	{
		return $this->mes;
	}

	public function setMes($mes) 
	{
		$this->mes = $mes;
	}

    public function getAno() 
	{
		return $this->ano;
	}

	public function setAno($ano) 
	{
		$this->ano = $ano;
	}

    public function getSaldoAnterior() 
	{
		return $this->saldoAnterior;
	}

	public function setSaldoAnterior($saldoAnterior) 
	{
		$this->saldoAnterior = $saldoAnterior;
	}

    public function getRecebimentos() 
	{
		return $this->recebimentos;
	}

	public function setRecebimentos($recebimentos) 
	{
		$this->recebimentos = $recebimentos;
	}

    public function getPagamentos() 
	{
		return $this->pagamentos;
	}

	public function setPagamentos($pagamentos) 
	{
		$this->pagamentos = $pagamentos;
	}

    public function getSaldoConta() 
	{
		return $this->saldoConta;
	}

	public function setSaldoConta($saldoConta) 
	{
		$this->saldoConta = $saldoConta;
	}

    public function getChequeNaoCompensado() 
	{
		return $this->chequeNaoCompensado;
	}

	public function setChequeNaoCompensado($chequeNaoCompensado) 
	{
		$this->chequeNaoCompensado = $chequeNaoCompensado;
	}

    public function getSaldoDisponivel() 
	{
		return $this->saldoDisponivel;
	}

	public function setSaldoDisponivel($saldoDisponivel) 
	{
		$this->saldoDisponivel = $saldoDisponivel;
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
			$this->setDataFechamento($objeto->dataFechamento);
			$this->setMesAno($objeto->mesAno);
			$this->setMes($objeto->mes);
			$this->setAno($objeto->ano);
			$this->setSaldoAnterior($objeto->saldoAnterior);
			$this->setRecebimentos($objeto->recebimentos);
			$this->setPagamentos($objeto->pagamentos);
			$this->setSaldoConta($objeto->saldoConta);
			$this->setChequeNaoCompensado($objeto->chequeNaoCompensado);
			$this->setSaldoDisponivel($objeto->saldoDisponivel);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'FinFechamentoCaixaBanco');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'dataFechamento' => $this->getDataFechamento(),
			'mesAno' => $this->getMesAno(),
			'mes' => $this->getMes(),
			'ano' => $this->getAno(),
			'saldoAnterior' => $this->getSaldoAnterior(),
			'recebimentos' => $this->getRecebimentos(),
			'pagamentos' => $this->getPagamentos(),
			'saldoConta' => $this->getSaldoConta(),
			'chequeNaoCompensado' => $this->getChequeNaoCompensado(),
			'saldoDisponivel' => $this->getSaldoDisponivel(),
			'bancoContaCaixa' => $this->getBancoContaCaixa(),
        ];
    }
}
