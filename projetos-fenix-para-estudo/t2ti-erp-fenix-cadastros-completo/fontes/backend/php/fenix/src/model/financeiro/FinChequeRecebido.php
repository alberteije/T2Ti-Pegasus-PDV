<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [FIN_CHEQUE_RECEBIDO] 
                                                                                
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
 * @ORM\Table(name="FIN_CHEQUE_RECEBIDO")
 */
class FinChequeRecebido extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="string", name="CPF")
	 */
	private $cpf;

	/**
	 * @ORM\Column(type="string", name="CNPJ")
	 */
	private $cnpj;

	/**
	 * @ORM\Column(type="string", name="NOME")
	 */
	private $nome;

	/**
	 * @ORM\Column(type="string", name="CODIGO_BANCO")
	 */
	private $codigoBanco;

	/**
	 * @ORM\Column(type="string", name="CODIGO_AGENCIA")
	 */
	private $codigoAgencia;

	/**
	 * @ORM\Column(type="string", name="CONTA")
	 */
	private $conta;

	/**
	 * @ORM\Column(type="integer", name="NUMERO")
	 */
	private $numero;

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
	 * @ORM\Column(type="date", name="CUSTODIA_DATA")
	 */
	private $custodiaData;

	/**
	 * @ORM\Column(type="float", name="CUSTODIA_TARIFA")
	 */
	private $custodiaTarifa;

	/**
	 * @ORM\Column(type="float", name="CUSTODIA_COMISSAO")
	 */
	private $custodiaComissao;

	/**
	 * @ORM\Column(type="date", name="DESCONTO_DATA")
	 */
	private $descontoData;

	/**
	 * @ORM\Column(type="float", name="DESCONTO_TARIFA")
	 */
	private $descontoTarifa;

	/**
	 * @ORM\Column(type="float", name="DESCONTO_COMISSAO")
	 */
	private $descontoComissao;

	/**
	 * @ORM\Column(type="float", name="VALOR_RECEBIDO")
	 */
	private $valorRecebido;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="Pessoa", fetch="EAGER")
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

    public function getCpf() 
	{
		return $this->cpf;
	}

	public function setCpf($cpf) 
	{
		$this->cpf = $cpf;
	}

    public function getCnpj() 
	{
		return $this->cnpj;
	}

	public function setCnpj($cnpj) 
	{
		$this->cnpj = $cnpj;
	}

    public function getNome() 
	{
		return $this->nome;
	}

	public function setNome($nome) 
	{
		$this->nome = $nome;
	}

    public function getCodigoBanco() 
	{
		return $this->codigoBanco;
	}

	public function setCodigoBanco($codigoBanco) 
	{
		$this->codigoBanco = $codigoBanco;
	}

    public function getCodigoAgencia() 
	{
		return $this->codigoAgencia;
	}

	public function setCodigoAgencia($codigoAgencia) 
	{
		$this->codigoAgencia = $codigoAgencia;
	}

    public function getConta() 
	{
		return $this->conta;
	}

	public function setConta($conta) 
	{
		$this->conta = $conta;
	}

    public function getNumero() 
	{
		return $this->numero;
	}

	public function setNumero($numero) 
	{
		$this->numero = $numero;
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

    public function getCustodiaData() 
	{
		if ($this->custodiaData != null) {
			return $this->custodiaData->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setCustodiaData($custodiaData) 
	{
		$this->custodiaData = $custodiaData != null ? new \DateTime($custodiaData) : null;
	}

    public function getCustodiaTarifa() 
	{
		return $this->custodiaTarifa;
	}

	public function setCustodiaTarifa($custodiaTarifa) 
	{
		$this->custodiaTarifa = $custodiaTarifa;
	}

    public function getCustodiaComissao() 
	{
		return $this->custodiaComissao;
	}

	public function setCustodiaComissao($custodiaComissao) 
	{
		$this->custodiaComissao = $custodiaComissao;
	}

    public function getDescontoData() 
	{
		if ($this->descontoData != null) {
			return $this->descontoData->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDescontoData($descontoData) 
	{
		$this->descontoData = $descontoData != null ? new \DateTime($descontoData) : null;
	}

    public function getDescontoTarifa() 
	{
		return $this->descontoTarifa;
	}

	public function setDescontoTarifa($descontoTarifa) 
	{
		$this->descontoTarifa = $descontoTarifa;
	}

    public function getDescontoComissao() 
	{
		return $this->descontoComissao;
	}

	public function setDescontoComissao($descontoComissao) 
	{
		$this->descontoComissao = $descontoComissao;
	}

    public function getValorRecebido() 
	{
		return $this->valorRecebido;
	}

	public function setValorRecebido($valorRecebido) 
	{
		$this->valorRecebido = $valorRecebido;
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
			$this->setCpf($objeto->cpf);
			$this->setCnpj($objeto->cnpj);
			$this->setNome($objeto->nome);
			$this->setCodigoBanco($objeto->codigoBanco);
			$this->setCodigoAgencia($objeto->codigoAgencia);
			$this->setConta($objeto->conta);
			$this->setNumero($objeto->numero);
			$this->setDataEmissao($objeto->dataEmissao);
			$this->setBomPara($objeto->bomPara);
			$this->setDataCompensacao($objeto->dataCompensacao);
			$this->setValor($objeto->valor);
			$this->setCustodiaData($objeto->custodiaData);
			$this->setCustodiaTarifa($objeto->custodiaTarifa);
			$this->setCustodiaComissao($objeto->custodiaComissao);
			$this->setDescontoData($objeto->descontoData);
			$this->setDescontoTarifa($objeto->descontoTarifa);
			$this->setDescontoComissao($objeto->descontoComissao);
			$this->setValorRecebido($objeto->valorRecebido);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'FinChequeRecebido');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'cpf' => $this->getCpf(),
			'cnpj' => $this->getCnpj(),
			'nome' => $this->getNome(),
			'codigoBanco' => $this->getCodigoBanco(),
			'codigoAgencia' => $this->getCodigoAgencia(),
			'conta' => $this->getConta(),
			'numero' => $this->getNumero(),
			'dataEmissao' => $this->getDataEmissao(),
			'bomPara' => $this->getBomPara(),
			'dataCompensacao' => $this->getDataCompensacao(),
			'valor' => $this->getValor(),
			'custodiaData' => $this->getCustodiaData(),
			'custodiaTarifa' => $this->getCustodiaTarifa(),
			'custodiaComissao' => $this->getCustodiaComissao(),
			'descontoData' => $this->getDescontoData(),
			'descontoTarifa' => $this->getDescontoTarifa(),
			'descontoComissao' => $this->getDescontoComissao(),
			'valorRecebido' => $this->getValorRecebido(),
			'pessoa' => $this->getPessoa(),
        ];
    }
}
