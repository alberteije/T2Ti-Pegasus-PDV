<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA] 
                                                                                
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
 * @ORM\Table(name="PESSOA")
 */
class Pessoa extends ModelBase implements \JsonSerializable
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
	 * @ORM\Column(type="string", name="TIPO")
	 */
	private $tipo;

	/**
	 * @ORM\Column(type="string", name="SITE")
	 */
	private $site;

	/**
	 * @ORM\Column(type="string", name="EMAIL")
	 */
	private $email;

	/**
	 * @ORM\Column(type="string", name="CLIENTE")
	 */
	private $cliente;

	/**
	 * @ORM\Column(type="string", name="FORNECEDOR")
	 */
	private $fornecedor;

	/**
	 * @ORM\Column(type="string", name="TRANSPORTADORA")
	 */
	private $transportadora;

	/**
	 * @ORM\Column(type="string", name="COLABORADOR")
	 */
	private $colaborador;

	/**
	 * @ORM\Column(type="string", name="CONTADOR")
	 */
	private $contador;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="PessoaFisica", mappedBy="pessoa", cascade={"persist", "remove"})
     */
    private $pessoaFisica;

    /**
     * @ORM\OneToOne(targetEntity="PessoaJuridica", mappedBy="pessoa", cascade={"persist", "remove"})
     */
    private $pessoaJuridica;

    /**
     * @ORM\OneToMany(targetEntity="PessoaContato", mappedBy="pessoa", cascade={"persist", "remove"})
     */
    private $listaPessoaContato;

    /**
     * @ORM\OneToMany(targetEntity="PessoaEndereco", mappedBy="pessoa", cascade={"persist", "remove"})
     */
    private $listaPessoaEndereco;

    /**
     * @ORM\OneToMany(targetEntity="PessoaTelefone", mappedBy="pessoa", cascade={"persist", "remove"})
     */
    private $listaPessoaTelefone;


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

    public function getTipo() 
	{
		return $this->tipo;
	}

	public function setTipo($tipo) 
	{
		$this->tipo = $tipo;
	}

    public function getSite() 
	{
		return $this->site;
	}

	public function setSite($site) 
	{
		$this->site = $site;
	}

    public function getEmail() 
	{
		return $this->email;
	}

	public function setEmail($email) 
	{
		$this->email = $email;
	}

    public function getCliente() 
	{
		return $this->cliente;
	}

	public function setCliente($cliente) 
	{
		$this->cliente = $cliente;
	}

    public function getFornecedor() 
	{
		return $this->fornecedor;
	}

	public function setFornecedor($fornecedor) 
	{
		$this->fornecedor = $fornecedor;
	}

    public function getTransportadora() 
	{
		return $this->transportadora;
	}

	public function setTransportadora($transportadora) 
	{
		$this->transportadora = $transportadora;
	}

    public function getColaborador() 
	{
		return $this->colaborador;
	}

	public function setColaborador($colaborador) 
	{
		$this->colaborador = $colaborador;
	}

    public function getContador() 
	{
		return $this->contador;
	}

	public function setContador($contador) 
	{
		$this->contador = $contador;
	}

    public function getPessoaFisica(): ?PessoaFisica 
	{
		return $this->pessoaFisica;
	}

	public function setPessoaFisica(?PessoaFisica $pessoaFisica) 
	{
		$this->pessoaFisica = $pessoaFisica;
	}

    public function getPessoaJuridica(): ?PessoaJuridica 
	{
		return $this->pessoaJuridica;
	}

	public function setPessoaJuridica(?PessoaJuridica $pessoaJuridica) 
	{
		$this->pessoaJuridica = $pessoaJuridica;
	}

    public function getListaPessoaContato() 
	{
		return $this->listaPessoaContato->toArray();
	}

	public function setListaPessoaContato(array $listaPessoaContato) {
		$this->listaPessoaContato = new ArrayCollection();
		for ($i = 0; $i < count($listaPessoaContato); $i++) {
			$pessoaContato = $listaPessoaContato[$i];
			$pessoaContato->setPessoa($this);
			$this->listaPessoaContato->add($pessoaContato);
		}
	}

    public function getListaPessoaEndereco() 
	{
		return $this->listaPessoaEndereco->toArray();
	}

	public function setListaPessoaEndereco(array $listaPessoaEndereco) {
		$this->listaPessoaEndereco = new ArrayCollection();
		for ($i = 0; $i < count($listaPessoaEndereco); $i++) {
			$pessoaEndereco = $listaPessoaEndereco[$i];
			$pessoaEndereco->setPessoa($this);
			$this->listaPessoaEndereco->add($pessoaEndereco);
		}
	}

    public function getListaPessoaTelefone() 
	{
		return $this->listaPessoaTelefone->toArray();
	}

	public function setListaPessoaTelefone(array $listaPessoaTelefone) {
		$this->listaPessoaTelefone = new ArrayCollection();
		for ($i = 0; $i < count($listaPessoaTelefone); $i++) {
			$pessoaTelefone = $listaPessoaTelefone[$i];
			$pessoaTelefone->setPessoa($this);
			$this->listaPessoaTelefone->add($pessoaTelefone);
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

		if (isset($objetoJson->pessoaFisica)) {
			$this->setPessoaFisica(new PessoaFisica($objetoJson->pessoaFisica));
			$this->getPessoaFisica()->setPessoa($this);
		}

		if (isset($objetoJson->pessoaJuridica)) {
			$this->setPessoaJuridica(new PessoaJuridica($objetoJson->pessoaJuridica));
			$this->getPessoaJuridica()->setPessoa($this);
		}

		
		$this->listaPessoaContato = new ArrayCollection();
		$listaPessoaContatoJson = $objetoJson->listaPessoaContato;
		if ($listaPessoaContatoJson != null) {
			for ($i = 0; $i < count($listaPessoaContatoJson); $i++) {
				$objeto = new PessoaContato($listaPessoaContatoJson[$i]);
				$objeto->setPessoa($this);
				$this->listaPessoaContato->add($objeto);
			}
		}

		$this->listaPessoaEndereco = new ArrayCollection();
		$listaPessoaEnderecoJson = $objetoJson->listaPessoaEndereco;
		if ($listaPessoaEnderecoJson != null) {
			for ($i = 0; $i < count($listaPessoaEnderecoJson); $i++) {
				$objeto = new PessoaEndereco($listaPessoaEnderecoJson[$i]);
				$objeto->setPessoa($this);
				$this->listaPessoaEndereco->add($objeto);
			}
		}

		$this->listaPessoaTelefone = new ArrayCollection();
		$listaPessoaTelefoneJson = $objetoJson->listaPessoaTelefone;
		if ($listaPessoaTelefoneJson != null) {
			for ($i = 0; $i < count($listaPessoaTelefoneJson); $i++) {
				$objeto = new PessoaTelefone($listaPessoaTelefoneJson[$i]);
				$objeto->setPessoa($this);
				$this->listaPessoaTelefone->add($objeto);
			}
		}

    }

    /**
     * Mapping
     */
    public function mapear($objeto)
    {
        if (isset($objeto)) {
			$this->setNome($objeto->nome);
			$this->setTipo($objeto->tipo);
			$this->setSite($objeto->site);
			$this->setEmail($objeto->email);
			$this->setCliente($objeto->cliente);
			$this->setFornecedor($objeto->fornecedor);
			$this->setTransportadora($objeto->transportadora);
			$this->setColaborador($objeto->colaborador);
			$this->setContador($objeto->contador);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Pessoa');
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
			'tipo' => $this->getTipo(),
			'site' => $this->getSite(),
			'email' => $this->getEmail(),
			'cliente' => $this->getCliente(),
			'fornecedor' => $this->getFornecedor(),
			'transportadora' => $this->getTransportadora(),
			'colaborador' => $this->getColaborador(),
			'contador' => $this->getContador(),
			'pessoaFisica' => $this->getPessoaFisica(),
			'pessoaJuridica' => $this->getPessoaJuridica(),
			'listaPessoaContato' => $this->getListaPessoaContato(),
			'listaPessoaEndereco' => $this->getListaPessoaEndereco(),
			'listaPessoaTelefone' => $this->getListaPessoaTelefone(),
        ];
    }
}
