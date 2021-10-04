<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [PESSOA_FISICA] 
                                                                                
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
 * @ORM\Table(name="PESSOA_FISICA")
 */
class PessoaFisica extends ModelBase implements \JsonSerializable
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
	 * @ORM\Column(type="string", name="RG")
	 */
	private $rg;

	/**
	 * @ORM\Column(type="string", name="ORGAO_RG")
	 */
	private $orgaoRg;

	/**
	 * @ORM\Column(type="date", name="DATA_EMISSAO_RG")
	 */
	private $dataEmissaoRg;

	/**
	 * @ORM\Column(type="date", name="DATA_NASCIMENTO")
	 */
	private $dataNascimento;

	/**
	 * @ORM\Column(type="string", name="SEXO")
	 */
	private $sexo;

	/**
	 * @ORM\Column(type="string", name="RACA")
	 */
	private $raca;

	/**
	 * @ORM\Column(type="string", name="NACIONALIDADE")
	 */
	private $nacionalidade;

	/**
	 * @ORM\Column(type="string", name="NATURALIDADE")
	 */
	private $naturalidade;

	/**
	 * @ORM\Column(type="string", name="NOME_PAI")
	 */
	private $nomePai;

	/**
	 * @ORM\Column(type="string", name="NOME_MAE")
	 */
	private $nomeMae;


    /**
     * Relations
     */
    
    /**
     * @ORM\OneToOne(targetEntity="Pessoa", inversedBy="pessoaFisica")
     * @ORM\JoinColumn(name="ID_PESSOA", referencedColumnName="id")
     */
    private $pessoa;

    /**
     * @ORM\OneToOne(targetEntity="NivelFormacao", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_NIVEL_FORMACAO", referencedColumnName="id")
     */
    private $nivelFormacao;

    /**
     * @ORM\OneToOne(targetEntity="EstadoCivil", fetch="EAGER")
     * @ORM\JoinColumn(name="ID_ESTADO_CIVIL", referencedColumnName="id")
     */
    private $estadoCivil;


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

    public function getRg() 
	{
		return $this->rg;
	}

	public function setRg($rg) 
	{
		$this->rg = $rg;
	}

    public function getOrgaoRg() 
	{
		return $this->orgaoRg;
	}

	public function setOrgaoRg($orgaoRg) 
	{
		$this->orgaoRg = $orgaoRg;
	}

    public function getDataEmissaoRg() 
	{
		if ($this->dataEmissaoRg != null) {
			return $this->dataEmissaoRg->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataEmissaoRg($dataEmissaoRg) 
	{
		$this->dataEmissaoRg = $dataEmissaoRg != null ? new \DateTime($dataEmissaoRg) : null;
	}

    public function getDataNascimento() 
	{
		if ($this->dataNascimento != null) {
			return $this->dataNascimento->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataNascimento($dataNascimento) 
	{
		$this->dataNascimento = $dataNascimento != null ? new \DateTime($dataNascimento) : null;
	}

    public function getSexo() 
	{
		return $this->sexo;
	}

	public function setSexo($sexo) 
	{
		$this->sexo = $sexo;
	}

    public function getRaca() 
	{
		return $this->raca;
	}

	public function setRaca($raca) 
	{
		$this->raca = $raca;
	}

    public function getNacionalidade() 
	{
		return $this->nacionalidade;
	}

	public function setNacionalidade($nacionalidade) 
	{
		$this->nacionalidade = $nacionalidade;
	}

    public function getNaturalidade() 
	{
		return $this->naturalidade;
	}

	public function setNaturalidade($naturalidade) 
	{
		$this->naturalidade = $naturalidade;
	}

    public function getNomePai() 
	{
		return $this->nomePai;
	}

	public function setNomePai($nomePai) 
	{
		$this->nomePai = $nomePai;
	}

    public function getNomeMae() 
	{
		return $this->nomeMae;
	}

	public function setNomeMae($nomeMae) 
	{
		$this->nomeMae = $nomeMae;
	}

    public function getPessoa(): ?Pessoa 
	{
		return $this->pessoa;
	}

	public function setPessoa(?Pessoa $pessoa) 
	{
		$this->pessoa = $pessoa;
	}

    public function getNivelFormacao(): ?NivelFormacao 
	{
		return $this->nivelFormacao;
	}

	public function setNivelFormacao(?NivelFormacao $nivelFormacao) 
	{
		$this->nivelFormacao = $nivelFormacao;
	}

    public function getEstadoCivil(): ?EstadoCivil 
	{
		return $this->estadoCivil;
	}

	public function setEstadoCivil(?EstadoCivil $estadoCivil) 
	{
		$this->estadoCivil = $estadoCivil;
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
			$this->setRg($objeto->rg);
			$this->setOrgaoRg($objeto->orgaoRg);
			$this->setDataEmissaoRg($objeto->dataEmissaoRg);
			$this->setDataNascimento($objeto->dataNascimento);
			$this->setSexo($objeto->sexo);
			$this->setRaca($objeto->raca);
			$this->setNacionalidade($objeto->nacionalidade);
			$this->setNaturalidade($objeto->naturalidade);
			$this->setNomePai($objeto->nomePai);
			$this->setNomeMae($objeto->nomeMae);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'PessoaFisica');
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
			'rg' => $this->getRg(),
			'orgaoRg' => $this->getOrgaoRg(),
			'dataEmissaoRg' => $this->getDataEmissaoRg(),
			'dataNascimento' => $this->getDataNascimento(),
			'sexo' => $this->getSexo(),
			'raca' => $this->getRaca(),
			'nacionalidade' => $this->getNacionalidade(),
			'naturalidade' => $this->getNaturalidade(),
			'nomePai' => $this->getNomePai(),
			'nomeMae' => $this->getNomeMae(),
			'nivelFormacao' => $this->getNivelFormacao(),
			'estadoCivil' => $this->getEstadoCivil(),
        ];
    }
}
