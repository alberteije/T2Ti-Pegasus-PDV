<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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
 * @ORM\Table(name="FIN_LANCAMENTO_RECEBER")
 */
class FinLancamentoReceber extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="integer", name="QUANTIDADE_PARCELA")
	 */
	private $quantidadeParcela;

	/**
	 * @ORM\Column(type="float", name="VALOR_TOTAL")
	 */
	private $valorTotal;

	/**
	 * @ORM\Column(type="float", name="VALOR_A_RECEBER")
	 */
	private $valorAReceber;

	/**
	 * @ORM\Column(type="date", name="DATA_LANCAMENTO")
	 */
	private $dataLancamento;

	/**
	 * @ORM\Column(type="string", name="NUMERO_DOCUMENTO")
	 */
	private $numeroDocumento;

	/**
	 * @ORM\Column(type="date", name="PRIMEIRO_VENCIMENTO")
	 */
	private $primeiroVencimento;

	/**
	 * @ORM\Column(type="float", name="TAXA_COMISSAO")
	 */
	private $taxaComissao;

	/**
	 * @ORM\Column(type="float", name="VALOR_COMISSAO")
	 */
	private $valorComissao;

	/**
	 * @ORM\Column(type="integer", name="INTERVALO_ENTRE_PARCELAS")
	 */
	private $intervaloEntreParcelas;

	/**
	 * @ORM\Column(type="string", name="DIA_FIXO")
	 */
	private $diaFixo;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="FinDocumentoOrigem", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_FIN_DOCUMENTO_ORIGEM", referencedColumnName="id")
     */
    private $finDocumentoOrigem;

    /**
     * @ORM\OneToOne(targetEntity="FinNaturezaFinanceira", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_FIN_NATUREZA_FINANCEIRA", referencedColumnName="id")
     */
    private $finNaturezaFinanceira;

    /**
     * @ORM\OneToOne(targetEntity="Cliente", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_CLIENTE", referencedColumnName="id")
     */
    private $cliente;

    /**
     * @ORM\OneToMany(targetEntity="FinParcelaReceber", mappedBy="finLancamentoReceber", cascade={"persist", "remove"})
     */
    private $listaFinParcelaReceber;


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

    public function getQuantidadeParcela() 
	{
		return $this->quantidadeParcela;
	}

	public function setQuantidadeParcela($quantidadeParcela) 
	{
		$this->quantidadeParcela = $quantidadeParcela;
	}

    public function getValorTotal() 
	{
		return $this->valorTotal;
	}

	public function setValorTotal($valorTotal) 
	{
		$this->valorTotal = $valorTotal;
	}

    public function getValorAReceber() 
	{
		return $this->valorAReceber;
	}

	public function setValorAReceber($valorAReceber) 
	{
		$this->valorAReceber = $valorAReceber;
	}

    public function getDataLancamento() 
	{
		if ($this->dataLancamento != null) {
			return $this->dataLancamento->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataLancamento($dataLancamento) 
	{
		$this->dataLancamento = $dataLancamento != null ? new \DateTime($dataLancamento) : null;
	}

    public function getNumeroDocumento() 
	{
		return $this->numeroDocumento;
	}

	public function setNumeroDocumento($numeroDocumento) 
	{
		$this->numeroDocumento = $numeroDocumento;
	}

    public function getPrimeiroVencimento() 
	{
		if ($this->primeiroVencimento != null) {
			return $this->primeiroVencimento->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setPrimeiroVencimento($primeiroVencimento) 
	{
		$this->primeiroVencimento = $primeiroVencimento != null ? new \DateTime($primeiroVencimento) : null;
	}

    public function getTaxaComissao() 
	{
		return $this->taxaComissao;
	}

	public function setTaxaComissao($taxaComissao) 
	{
		$this->taxaComissao = $taxaComissao;
	}

    public function getValorComissao() 
	{
		return $this->valorComissao;
	}

	public function setValorComissao($valorComissao) 
	{
		$this->valorComissao = $valorComissao;
	}

    public function getIntervaloEntreParcelas() 
	{
		return $this->intervaloEntreParcelas;
	}

	public function setIntervaloEntreParcelas($intervaloEntreParcelas) 
	{
		$this->intervaloEntreParcelas = $intervaloEntreParcelas;
	}

    public function getDiaFixo() 
	{
		return $this->diaFixo;
	}

	public function setDiaFixo($diaFixo) 
	{
		$this->diaFixo = $diaFixo;
	}

    public function getFinDocumentoOrigem(): ?FinDocumentoOrigem 
	{
		return $this->finDocumentoOrigem;
	}

	public function setFinDocumentoOrigem(?FinDocumentoOrigem $finDocumentoOrigem) 
	{
		$this->finDocumentoOrigem = $finDocumentoOrigem;
	}

    public function getFinNaturezaFinanceira(): ?FinNaturezaFinanceira 
	{
		return $this->finNaturezaFinanceira;
	}

	public function setFinNaturezaFinanceira(?FinNaturezaFinanceira $finNaturezaFinanceira) 
	{
		$this->finNaturezaFinanceira = $finNaturezaFinanceira;
	}

    public function getCliente(): ?Cliente 
	{
		return $this->cliente;
	}

	public function setCliente(?Cliente $cliente) 
	{
		$this->cliente = $cliente;
	}

    public function getListaFinParcelaReceber() 
	{
		return $this->listaFinParcelaReceber->toArray();
	}

	public function setListaFinParcelaReceber(array $listaFinParcelaReceber) {
		$this->listaFinParcelaReceber = new ArrayCollection();
		for ($i = 0; $i < count($listaFinParcelaReceber); $i++) {
			$finParcelaReceber = $listaFinParcelaReceber[$i];
			$finParcelaReceber->setFinLancamentoReceber($this);
			$this->listaFinParcelaReceber->add($finParcelaReceber);
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

		
		$this->listaFinParcelaReceber = new ArrayCollection();
		$listaFinParcelaReceberJson = $objetoJson->listaFinParcelaReceber;
		if ($listaFinParcelaReceberJson != null) {
			for ($i = 0; $i < count($listaFinParcelaReceberJson); $i++) {
				$objeto = new FinParcelaReceber($listaFinParcelaReceberJson[$i]);
				$objeto->setFinLancamentoReceber($this);
				$this->listaFinParcelaReceber->add($objeto);
			}
		}

    }

    /**
     * Mapping
     */
    public function mapear($objeto)
    {
        if (isset($objeto)) {
			$this->setQuantidadeParcela($objeto->quantidadeParcela);
			$this->setValorTotal($objeto->valorTotal);
			$this->setValorAReceber($objeto->valorAReceber);
			$this->setDataLancamento($objeto->dataLancamento);
			$this->setNumeroDocumento($objeto->numeroDocumento);
			$this->setPrimeiroVencimento($objeto->primeiroVencimento);
			$this->setTaxaComissao($objeto->taxaComissao);
			$this->setValorComissao($objeto->valorComissao);
			$this->setIntervaloEntreParcelas($objeto->intervaloEntreParcelas);
			$this->setDiaFixo($objeto->diaFixo);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'FinLancamentoReceber');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'quantidadeParcela' => $this->getQuantidadeParcela(),
			'valorTotal' => $this->getValorTotal(),
			'valorAReceber' => $this->getValorAReceber(),
			'dataLancamento' => $this->getDataLancamento(),
			'numeroDocumento' => $this->getNumeroDocumento(),
			'primeiroVencimento' => $this->getPrimeiroVencimento(),
			'taxaComissao' => $this->getTaxaComissao(),
			'valorComissao' => $this->getValorComissao(),
			'intervaloEntreParcelas' => $this->getIntervaloEntreParcelas(),
			'diaFixo' => $this->getDiaFixo(),
			'finDocumentoOrigem' => $this->getFinDocumentoOrigem(),
			'finNaturezaFinanceira' => $this->getFinNaturezaFinanceira(),
			'cliente' => $this->getCliente(),
			'listaFinParcelaReceber' => $this->getListaFinParcelaReceber(),
        ];
    }
}
