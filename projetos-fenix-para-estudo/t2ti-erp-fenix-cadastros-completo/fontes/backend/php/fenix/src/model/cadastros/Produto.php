<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PRODUTO] 
                                                                                
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
 * @ORM\Table(name="PRODUTO")
 */
class Produto extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="string", name="NOME")
	 */
	private $nome;

	/**
	 * @ORM\Column(type="string", name="DESCRICAO")
	 */
	private $descricao;

	/**
	 * @ORM\Column(type="string", name="GTIN")
	 */
	private $gtin;

	/**
	 * @ORM\Column(type="string", name="CODIGO_INTERNO")
	 */
	private $codigoInterno;

	/**
	 * @ORM\Column(type="float", name="VALOR_COMPRA")
	 */
	private $valorCompra;

	/**
	 * @ORM\Column(type="float", name="VALOR_VENDA")
	 */
	private $valorVenda;

	/**
	 * @ORM\Column(type="string", name="NCM")
	 */
	private $ncm;

	/**
	 * @ORM\Column(type="float", name="ESTOQUE_MINIMO")
	 */
	private $estoqueMinimo;

	/**
	 * @ORM\Column(type="float", name="ESTOQUE_MAXIMO")
	 */
	private $estoqueMaximo;

	/**
	 * @ORM\Column(type="float", name="QUANTIDADE_ESTOQUE")
	 */
	private $quantidadeEstoque;

	/**
	 * @ORM\Column(type="date", name="DATA_CADASTRO")
	 */
	private $dataCadastro;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="ProdutoSubgrupo", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_PRODUTO_SUBGRUPO", referencedColumnName="id")
     */
    private $produtoSubgrupo;

    /**
     * @ORM\OneToOne(targetEntity="ProdutoMarca", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_PRODUTO_MARCA", referencedColumnName="id")
     */
    private $produtoMarca;

    /**
     * @ORM\OneToOne(targetEntity="ProdutoUnidade", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_PRODUTO_UNIDADE", referencedColumnName="id")
     */
    private $produtoUnidade;


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

    public function getNome() 
	{
		return $this->nome;
	}

	public function setNome($nome) 
	{
		$this->nome = $nome;
	}

    public function getDescricao() 
	{
		return $this->descricao;
	}

	public function setDescricao($descricao) 
	{
		$this->descricao = $descricao;
	}

    public function getGtin() 
	{
		return $this->gtin;
	}

	public function setGtin($gtin) 
	{
		$this->gtin = $gtin;
	}

    public function getCodigoInterno() 
	{
		return $this->codigoInterno;
	}

	public function setCodigoInterno($codigoInterno) 
	{
		$this->codigoInterno = $codigoInterno;
	}

    public function getValorCompra() 
	{
		return $this->valorCompra;
	}

	public function setValorCompra($valorCompra) 
	{
		$this->valorCompra = $valorCompra;
	}

    public function getValorVenda() 
	{
		return $this->valorVenda;
	}

	public function setValorVenda($valorVenda) 
	{
		$this->valorVenda = $valorVenda;
	}

    public function getNcm() 
	{
		return $this->ncm;
	}

	public function setNcm($ncm) 
	{
		$this->ncm = $ncm;
	}

    public function getEstoqueMinimo() 
	{
		return $this->estoqueMinimo;
	}

	public function setEstoqueMinimo($estoqueMinimo) 
	{
		$this->estoqueMinimo = $estoqueMinimo;
	}

    public function getEstoqueMaximo() 
	{
		return $this->estoqueMaximo;
	}

	public function setEstoqueMaximo($estoqueMaximo) 
	{
		$this->estoqueMaximo = $estoqueMaximo;
	}

    public function getQuantidadeEstoque() 
	{
		return $this->quantidadeEstoque;
	}

	public function setQuantidadeEstoque($quantidadeEstoque) 
	{
		$this->quantidadeEstoque = $quantidadeEstoque;
	}

    public function getDataCadastro() 
	{
		if ($this->dataCadastro != null) {
			return $this->dataCadastro->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataCadastro($dataCadastro) 
	{
		$this->dataCadastro = $dataCadastro != null ? new \DateTime($dataCadastro) : null;
	}

    public function getProdutoSubgrupo(): ?ProdutoSubgrupo 
	{
		return $this->produtoSubgrupo;
	}

	public function setProdutoSubgrupo(?ProdutoSubgrupo $produtoSubgrupo) 
	{
		$this->produtoSubgrupo = $produtoSubgrupo;
	}

    public function getProdutoMarca(): ?ProdutoMarca 
	{
		return $this->produtoMarca;
	}

	public function setProdutoMarca(?ProdutoMarca $produtoMarca) 
	{
		$this->produtoMarca = $produtoMarca;
	}

    public function getProdutoUnidade(): ?ProdutoUnidade 
	{
		return $this->produtoUnidade;
	}

	public function setProdutoUnidade(?ProdutoUnidade $produtoUnidade) 
	{
		$this->produtoUnidade = $produtoUnidade;
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
			$this->setNome($objeto->nome);
			$this->setDescricao($objeto->descricao);
			$this->setGtin($objeto->gtin);
			$this->setCodigoInterno($objeto->codigoInterno);
			$this->setValorCompra($objeto->valorCompra);
			$this->setValorVenda($objeto->valorVenda);
			$this->setNcm($objeto->ncm);
			$this->setEstoqueMinimo($objeto->estoqueMinimo);
			$this->setEstoqueMaximo($objeto->estoqueMaximo);
			$this->setQuantidadeEstoque($objeto->quantidadeEstoque);
			$this->setDataCadastro($objeto->dataCadastro);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Produto');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
			'id' => $this->getId(),
			'nome' => $this->getNome(),
			'descricao' => $this->getDescricao(),
			'gtin' => $this->getGtin(),
			'codigoInterno' => $this->getCodigoInterno(),
			'valorCompra' => $this->getValorCompra(),
			'valorVenda' => $this->getValorVenda(),
			'ncm' => $this->getNcm(),
			'estoqueMinimo' => $this->getEstoqueMinimo(),
			'estoqueMaximo' => $this->getEstoqueMaximo(),
			'quantidadeEstoque' => $this->getQuantidadeEstoque(),
			'dataCadastro' => $this->getDataCadastro(),
			'produtoSubgrupo' => $this->getProdutoSubgrupo(),
			'produtoMarca' => $this->getProdutoMarca(),
			'produtoUnidade' => $this->getProdutoUnidade(),
        ];
    }
}
