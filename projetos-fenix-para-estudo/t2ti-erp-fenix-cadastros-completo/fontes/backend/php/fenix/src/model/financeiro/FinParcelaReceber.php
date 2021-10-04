<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_PARCELA_RECEBER] 
                                                                                
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
 * @ORM\Table(name="FIN_PARCELA_RECEBER")
 */
class FinParcelaReceber extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="integer", name="NUMERO_PARCELA")
	 */
	private $numeroParcela;

	/**
	 * @ORM\Column(type="date", name="DATA_EMISSAO")
	 */
	private $dataEmissao;

	/**
	 * @ORM\Column(type="date", name="DATA_VENCIMENTO")
	 */
	private $dataVencimento;

	/**
	 * @ORM\Column(type="date", name="DESCONTO_ATE")
	 */
	private $descontoAte;

	/**
	 * @ORM\Column(type="float", name="VALOR")
	 */
	private $valor;

	/**
	 * @ORM\Column(type="float", name="TAXA_JURO")
	 */
	private $taxaJuro;

	/**
	 * @ORM\Column(type="float", name="TAXA_MULTA")
	 */
	private $taxaMulta;

	/**
	 * @ORM\Column(type="float", name="TAXA_DESCONTO")
	 */
	private $taxaDesconto;

	/**
	 * @ORM\Column(type="float", name="VALOR_JURO")
	 */
	private $valorJuro;

	/**
	 * @ORM\Column(type="float", name="VALOR_MULTA")
	 */
	private $valorMulta;

	/**
	 * @ORM\Column(type="float", name="VALOR_DESCONTO")
	 */
	private $valorDesconto;

	/**
	 * @ORM\Column(type="string", name="EMITIU_BOLETO")
	 */
	private $emitiuBoleto;

	/**
	 * @ORM\Column(type="string", name="BOLETO_NOSSO_NUMERO")
	 */
	private $boletoNossoNumero;

	/**
	 * @ORM\Column(type="float", name="VALOR_RECEBIDO")
	 */
	private $valorRecebido;

	/**
	 * @ORM\Column(type="string", name="HISTORICO")
	 */
	private $historico;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="FinStatusParcela", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_FIN_STATUS_PARCELA", referencedColumnName="id")
     */
    private $finStatusParcela;

    /**
     * @ORM\OneToOne(targetEntity="FinTipoRecebimento", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_FIN_TIPO_RECEBIMENTO", referencedColumnName="id")
     */
    private $finTipoRecebimento;

    /**
     * @ORM\OneToOne(targetEntity="BancoContaCaixa", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_BANCO_CONTA_CAIXA", referencedColumnName="id")
     */
    private $bancoContaCaixa;

    /**
     * @ORM\OneToOne(targetEntity="FinChequeRecebido", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_FIN_CHEQUE_RECEBIDO", referencedColumnName="id")
     */
    private $finChequeRecebido;

    /**
     * @ORM\ManyToOne(targetEntity="FinLancamentoReceber", inversedBy="listaFinParcelaReceber")
     * @ORM\JoinColumn(name="ID_FIN_LANCAMENTO_RECEBER", referencedColumnName="id")
     */
    private $finLancamentoReceber;


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

    public function getNumeroParcela() 
	{
		return $this->numeroParcela;
	}

	public function setNumeroParcela($numeroParcela) 
	{
		$this->numeroParcela = $numeroParcela;
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

    public function getDataVencimento() 
	{
		if ($this->dataVencimento != null) {
			return $this->dataVencimento->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataVencimento($dataVencimento) 
	{
		$this->dataVencimento = $dataVencimento != null ? new \DateTime($dataVencimento) : null;
	}

    public function getDescontoAte() 
	{
		if ($this->descontoAte != null) {
			return $this->descontoAte->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDescontoAte($descontoAte) 
	{
		$this->descontoAte = $descontoAte != null ? new \DateTime($descontoAte) : null;
	}

    public function getValor() 
	{
		return $this->valor;
	}

	public function setValor($valor) 
	{
		$this->valor = $valor;
	}

    public function getTaxaJuro() 
	{
		return $this->taxaJuro;
	}

	public function setTaxaJuro($taxaJuro) 
	{
		$this->taxaJuro = $taxaJuro;
	}

    public function getTaxaMulta() 
	{
		return $this->taxaMulta;
	}

	public function setTaxaMulta($taxaMulta) 
	{
		$this->taxaMulta = $taxaMulta;
	}

    public function getTaxaDesconto() 
	{
		return $this->taxaDesconto;
	}

	public function setTaxaDesconto($taxaDesconto) 
	{
		$this->taxaDesconto = $taxaDesconto;
	}

    public function getValorJuro() 
	{
		return $this->valorJuro;
	}

	public function setValorJuro($valorJuro) 
	{
		$this->valorJuro = $valorJuro;
	}

    public function getValorMulta() 
	{
		return $this->valorMulta;
	}

	public function setValorMulta($valorMulta) 
	{
		$this->valorMulta = $valorMulta;
	}

    public function getValorDesconto() 
	{
		return $this->valorDesconto;
	}

	public function setValorDesconto($valorDesconto) 
	{
		$this->valorDesconto = $valorDesconto;
	}

    public function getEmitiuBoleto() 
	{
		return $this->emitiuBoleto;
	}

	public function setEmitiuBoleto($emitiuBoleto) 
	{
		$this->emitiuBoleto = $emitiuBoleto;
	}

    public function getBoletoNossoNumero() 
	{
		return $this->boletoNossoNumero;
	}

	public function setBoletoNossoNumero($boletoNossoNumero) 
	{
		$this->boletoNossoNumero = $boletoNossoNumero;
	}

    public function getValorRecebido() 
	{
		return $this->valorRecebido;
	}

	public function setValorRecebido($valorRecebido) 
	{
		$this->valorRecebido = $valorRecebido;
	}

    public function getHistorico() 
	{
		return $this->historico;
	}

	public function setHistorico($historico) 
	{
		$this->historico = $historico;
	}

    public function getFinLancamentoReceber(): ?FinLancamentoReceber 
	{
		return $this->finLancamentoReceber;
	}

	public function setFinLancamentoReceber(?FinLancamentoReceber $finLancamentoReceber) 
	{
		$this->finLancamentoReceber = $finLancamentoReceber;
	}

    public function getFinStatusParcela(): ?FinStatusParcela 
	{
		return $this->finStatusParcela;
	}

	public function setFinStatusParcela(?FinStatusParcela $finStatusParcela) 
	{
		$this->finStatusParcela = $finStatusParcela;
	}

    public function getFinTipoRecebimento(): ?FinTipoRecebimento 
	{
		return $this->finTipoRecebimento;
	}

	public function setFinTipoRecebimento(?FinTipoRecebimento $finTipoRecebimento) 
	{
		$this->finTipoRecebimento = $finTipoRecebimento;
	}

    public function getBancoContaCaixa(): ?BancoContaCaixa 
	{
		return $this->bancoContaCaixa;
	}

	public function setBancoContaCaixa(?BancoContaCaixa $bancoContaCaixa) 
	{
		$this->bancoContaCaixa = $bancoContaCaixa;
	}

    public function getFinChequeRecebido(): ?FinChequeRecebido 
	{
		return $this->finChequeRecebido;
	}

	public function setFinChequeRecebido(?FinChequeRecebido $finChequeRecebido) 
	{
		$this->finChequeRecebido = $finChequeRecebido;
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
			$this->setNumeroParcela($objeto->numeroParcela);
			$this->setDataEmissao($objeto->dataEmissao);
			$this->setDataVencimento($objeto->dataVencimento);
			$this->setDescontoAte($objeto->descontoAte);
			$this->setValor($objeto->valor);
			$this->setTaxaJuro($objeto->taxaJuro);
			$this->setTaxaMulta($objeto->taxaMulta);
			$this->setTaxaDesconto($objeto->taxaDesconto);
			$this->setValorJuro($objeto->valorJuro);
			$this->setValorMulta($objeto->valorMulta);
			$this->setValorDesconto($objeto->valorDesconto);
			$this->setEmitiuBoleto($objeto->emitiuBoleto);
			$this->setBoletoNossoNumero($objeto->boletoNossoNumero);
			$this->setValorRecebido($objeto->valorRecebido);
			$this->setHistorico($objeto->historico);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'FinParcelaReceber');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'numeroParcela' => $this->getNumeroParcela(),
			'dataEmissao' => $this->getDataEmissao(),
			'dataVencimento' => $this->getDataVencimento(),
			'descontoAte' => $this->getDescontoAte(),
			'valor' => $this->getValor(),
			'taxaJuro' => $this->getTaxaJuro(),
			'taxaMulta' => $this->getTaxaMulta(),
			'taxaDesconto' => $this->getTaxaDesconto(),
			'valorJuro' => $this->getValorJuro(),
			'valorMulta' => $this->getValorMulta(),
			'valorDesconto' => $this->getValorDesconto(),
			'emitiuBoleto' => $this->getEmitiuBoleto(),
			'boletoNossoNumero' => $this->getBoletoNossoNumero(),
			'valorRecebido' => $this->getValorRecebido(),
			'historico' => $this->getHistorico(),
			'finStatusParcela' => $this->getFinStatusParcela(),
			'finTipoRecebimento' => $this->getFinTipoRecebimento(),
			'bancoContaCaixa' => $this->getBancoContaCaixa(),
			'finChequeRecebido' => $this->getFinChequeRecebido(),
        ];
    }
}
