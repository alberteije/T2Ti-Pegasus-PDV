<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [BANCO_AGENCIA] 
                                                                                
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
 * @ORM\Table(name="BANCO_AGENCIA")
 */
class BancoAgencia extends ModelBase implements \JsonSerializable
{
	/**
	 * @ORM\Id
	 * @ORM\Column(type="integer")
	 * @ORM\GeneratedValue(strategy="AUTO")
	 */
	private $id;

	/**
	 * @ORM\Column(type="string", name="NUMERO")
	 */
	private $numero;

	/**
	 * @ORM\Column(type="string", name="DIGITO")
	 */
	private $digito;

	/**
	 * @ORM\Column(type="string", name="NOME")
	 */
	private $nome;

	/**
	 * @ORM\Column(type="string", name="TELEFONE")
	 */
	private $telefone;

	/**
	 * @ORM\Column(type="string", name="CONTATO")
	 */
	private $contato;

	/**
	 * @ORM\Column(type="string", name="OBSERVACAO")
	 */
	private $observacao;

	/**
	 * @ORM\Column(type="string", name="GERENTE")
	 */
	private $gerente;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="Banco", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_BANCO", referencedColumnName="id")
     */
    private $banco;


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

    public function getDigito() 
	{
		return $this->digito;
	}

	public function setDigito($digito) 
	{
		$this->digito = $digito;
	}

    public function getNome() 
	{
		return $this->nome;
	}

	public function setNome($nome) 
	{
		$this->nome = $nome;
	}

    public function getTelefone() 
	{
		return $this->telefone;
	}

	public function setTelefone($telefone) 
	{
		$this->telefone = $telefone;
	}

    public function getContato() 
	{
		return $this->contato;
	}

	public function setContato($contato) 
	{
		$this->contato = $contato;
	}

    public function getObservacao() 
	{
		return $this->observacao;
	}

	public function setObservacao($observacao) 
	{
		$this->observacao = $observacao;
	}

    public function getGerente() 
	{
		return $this->gerente;
	}

	public function setGerente($gerente) 
	{
		$this->gerente = $gerente;
	}

    public function getBanco(): ?Banco 
	{
		return $this->banco;
	}

	public function setBanco(?Banco $banco) 
	{
		$this->banco = $banco;
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
			$this->setDigito($objeto->digito);
			$this->setNome($objeto->nome);
			$this->setTelefone($objeto->telefone);
			$this->setContato($objeto->contato);
			$this->setObservacao($objeto->observacao);
			$this->setGerente($objeto->gerente);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'BancoAgencia');
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
			'digito' => $this->getDigito(),
			'nome' => $this->getNome(),
			'telefone' => $this->getTelefone(),
			'contato' => $this->getContato(),
			'observacao' => $this->getObservacao(),
			'gerente' => $this->getGerente(),
			'banco' => $this->getBanco(),
        ];
    }
}
