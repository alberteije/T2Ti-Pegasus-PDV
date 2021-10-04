<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_EXTRATO_CONTA_BANCO] 
                                                                                
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
 * @ORM\Table(name="FIN_EXTRATO_CONTA_BANCO")
 */
class FinExtratoContaBanco extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

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
	 * @ORM\Column(type="date", name="DATA_MOVIMENTO")
	 */
	private $dataMovimento;

	/**
	 * @ORM\Column(type="date", name="DATA_BALANCETE")
	 */
	private $dataBalancete;

	/**
	 * @ORM\Column(type="string", name="HISTORICO")
	 */
	private $historico;

	/**
	 * @ORM\Column(type="string", name="DOCUMENTO")
	 */
	private $documento;

	/**
	 * @ORM\Column(type="float", name="VALOR")
	 */
	private $valor;

	/**
	 * @ORM\Column(type="string", name="CONCILIADO")
	 */
	private $conciliado;

	/**
	 * @ORM\Column(type="string", name="OBSERVACAO")
	 */
	private $observacao;


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

    public function getDataMovimento() 
	{
		if ($this->dataMovimento != null) {
			return $this->dataMovimento->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataMovimento($dataMovimento) 
	{
		$this->dataMovimento = $dataMovimento != null ? new \DateTime($dataMovimento) : null;
	}

    public function getDataBalancete() 
	{
		if ($this->dataBalancete != null) {
			return $this->dataBalancete->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataBalancete($dataBalancete) 
	{
		$this->dataBalancete = $dataBalancete != null ? new \DateTime($dataBalancete) : null;
	}

    public function getHistorico() 
	{
		return $this->historico;
	}

	public function setHistorico($historico) 
	{
		$this->historico = $historico;
	}

    public function getDocumento() 
	{
		return $this->documento;
	}

	public function setDocumento($documento) 
	{
		$this->documento = $documento;
	}

    public function getValor() 
	{
		return $this->valor;
	}

	public function setValor($valor) 
	{
		$this->valor = $valor;
	}

    public function getConciliado() 
	{
		return $this->conciliado;
	}

	public function setConciliado($conciliado) 
	{
		$this->conciliado = $conciliado;
	}

    public function getObservacao() 
	{
		return $this->observacao;
	}

	public function setObservacao($observacao) 
	{
		$this->observacao = $observacao;
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
			$this->setMesAno($objeto->mesAno);
			$this->setMes($objeto->mes);
			$this->setAno($objeto->ano);
			$this->setDataMovimento($objeto->dataMovimento);
			$this->setDataBalancete($objeto->dataBalancete);
			$this->setHistorico($objeto->historico);
			$this->setDocumento($objeto->documento);
			$this->setValor($objeto->valor);
			$this->setConciliado($objeto->conciliado);
			$this->setObservacao($objeto->observacao);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'FinExtratoContaBanco');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'mesAno' => $this->getMesAno(),
			'mes' => $this->getMes(),
			'ano' => $this->getAno(),
			'dataMovimento' => $this->getDataMovimento(),
			'dataBalancete' => $this->getDataBalancete(),
			'historico' => $this->getHistorico(),
			'documento' => $this->getDocumento(),
			'valor' => $this->getValor(),
			'conciliado' => $this->getConciliado(),
			'observacao' => $this->getObservacao(),
			'bancoContaCaixa' => $this->getBancoContaCaixa(),
        ];
    }
}
