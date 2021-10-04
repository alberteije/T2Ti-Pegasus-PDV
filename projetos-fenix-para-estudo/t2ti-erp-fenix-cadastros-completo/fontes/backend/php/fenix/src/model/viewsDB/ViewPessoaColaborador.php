<?php
/*******************************************************************************
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VIEW_PESSOA_COLABORADOR] 
                                                                                
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
 * @ORM\Table(name="VIEW_PESSOA_COLABORADOR")
 */
class ViewPessoaColaborador extends ModelBase implements \JsonSerializable
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
	 * @ORM\Column(type="string", name="EMAIL")
	 */
	private $email;

	/**
	 * @ORM\Column(type="string", name="SITE")
	 */
	private $site;

	/**
	 * @ORM\Column(type="string", name="CPF_CNPJ")
	 */
	private $cpfCnpj;

	/**
	 * @ORM\Column(type="string", name="RG_IE")
	 */
	private $rgIe;

	/**
	 * @ORM\Column(type="string", name="MATRICULA")
	 */
	private $matricula;

	/**
	 * @ORM\Column(type="date", name="DATA_CADASTRO")
	 */
	private $dataCadastro;

	/**
	 * @ORM\Column(type="date", name="DATA_ADMISSAO")
	 */
	private $dataAdmissao;

	/**
	 * @ORM\Column(type="date", name="DATA_DEMISSAO")
	 */
	private $dataDemissao;

	/**
	 * @ORM\Column(type="string", name="CTPS_NUMERO")
	 */
	private $ctpsNumero;

	/**
	 * @ORM\Column(type="string", name="CTPS_SERIE")
	 */
	private $ctpsSerie;

	/**
	 * @ORM\Column(type="date", name="CTPS_DATA_EXPEDICAO")
	 */
	private $ctpsDataExpedicao;

	/**
	 * @ORM\Column(type="string", name="CTPS_UF")
	 */
	private $ctpsUf;

	/**
	 * @ORM\Column(type="string", name="OBSERVACAO")
	 */
	private $observacao;

	/**
	 * @ORM\Column(type="string", name="LOGRADOURO")
	 */
	private $logradouro;

	/**
	 * @ORM\Column(type="string", name="NUMERO")
	 */
	private $numero;

	/**
	 * @ORM\Column(type="string", name="COMPLEMENTO")
	 */
	private $complemento;

	/**
	 * @ORM\Column(type="string", name="BAIRRO")
	 */
	private $bairro;

	/**
	 * @ORM\Column(type="string", name="CIDADE")
	 */
	private $cidade;

	/**
	 * @ORM\Column(type="string", name="CEP")
	 */
	private $cep;

	/**
	 * @ORM\Column(type="integer", name="MUNICIPIO_IBGE")
	 */
	private $municipioIbge;

	/**
	 * @ORM\Column(type="string", name="UF")
	 */
	private $uf;

	/**
	 * @ORM\Column(type="integer", name="ID_PESSOA")
	 */
	private $idPessoa;

	/**
	 * @ORM\Column(type="integer", name="ID_CARGO")
	 */
	private $idCargo;

	/**
	 * @ORM\Column(type="integer", name="ID_SETOR")
	 */
	private $idSetor;


    /**
     * Relations
     */
    

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

    public function getEmail() 
	{
		return $this->email;
	}

	public function setEmail($email) 
	{
		$this->email = $email;
	}

    public function getSite() 
	{
		return $this->site;
	}

	public function setSite($site) 
	{
		$this->site = $site;
	}

    public function getCpfCnpj() 
	{
		return $this->cpfCnpj;
	}

	public function setCpfCnpj($cpfCnpj) 
	{
		$this->cpfCnpj = $cpfCnpj;
	}

    public function getRgIe() 
	{
		return $this->rgIe;
	}

	public function setRgIe($rgIe) 
	{
		$this->rgIe = $rgIe;
	}

    public function getMatricula() 
	{
		return $this->matricula;
	}

	public function setMatricula($matricula) 
	{
		$this->matricula = $matricula;
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

    public function getDataAdmissao() 
	{
		if ($this->dataAdmissao != null) {
			return $this->dataAdmissao->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataAdmissao($dataAdmissao) 
	{
		$this->dataAdmissao = $dataAdmissao != null ? new \DateTime($dataAdmissao) : null;
	}

    public function getDataDemissao() 
	{
		if ($this->dataDemissao != null) {
			return $this->dataDemissao->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setDataDemissao($dataDemissao) 
	{
		$this->dataDemissao = $dataDemissao != null ? new \DateTime($dataDemissao) : null;
	}

    public function getCtpsNumero() 
	{
		return $this->ctpsNumero;
	}

	public function setCtpsNumero($ctpsNumero) 
	{
		$this->ctpsNumero = $ctpsNumero;
	}

    public function getCtpsSerie() 
	{
		return $this->ctpsSerie;
	}

	public function setCtpsSerie($ctpsSerie) 
	{
		$this->ctpsSerie = $ctpsSerie;
	}

    public function getCtpsDataExpedicao() 
	{
		if ($this->ctpsDataExpedicao != null) {
			return $this->ctpsDataExpedicao->format('Y-m-d');
		} else {
			return null;
		}
	}
	public function setCtpsDataExpedicao($ctpsDataExpedicao) 
	{
		$this->ctpsDataExpedicao = $ctpsDataExpedicao != null ? new \DateTime($ctpsDataExpedicao) : null;
	}

    public function getCtpsUf() 
	{
		return $this->ctpsUf;
	}

	public function setCtpsUf($ctpsUf) 
	{
		$this->ctpsUf = $ctpsUf;
	}

    public function getObservacao() 
	{
		return $this->observacao;
	}

	public function setObservacao($observacao) 
	{
		$this->observacao = $observacao;
	}

    public function getLogradouro() 
	{
		return $this->logradouro;
	}

	public function setLogradouro($logradouro) 
	{
		$this->logradouro = $logradouro;
	}

    public function getNumero() 
	{
		return $this->numero;
	}

	public function setNumero($numero) 
	{
		$this->numero = $numero;
	}

    public function getComplemento() 
	{
		return $this->complemento;
	}

	public function setComplemento($complemento) 
	{
		$this->complemento = $complemento;
	}

    public function getBairro() 
	{
		return $this->bairro;
	}

	public function setBairro($bairro) 
	{
		$this->bairro = $bairro;
	}

    public function getCidade() 
	{
		return $this->cidade;
	}

	public function setCidade($cidade) 
	{
		$this->cidade = $cidade;
	}

    public function getCep() 
	{
		return $this->cep;
	}

	public function setCep($cep) 
	{
		$this->cep = $cep;
	}

    public function getMunicipioIbge() 
	{
		return $this->municipioIbge;
	}

	public function setMunicipioIbge($municipioIbge) 
	{
		$this->municipioIbge = $municipioIbge;
	}

    public function getUf() 
	{
		return $this->uf;
	}

	public function setUf($uf) 
	{
		$this->uf = $uf;
	}

    public function getIdPessoa() 
	{
		return $this->idPessoa;
	}

	public function setIdPessoa($idPessoa) 
	{
		$this->idPessoa = $idPessoa;
	}

    public function getIdCargo() 
	{
		return $this->idCargo;
	}

	public function setIdCargo($idCargo) 
	{
		$this->idCargo = $idCargo;
	}

    public function getIdSetor() 
	{
		return $this->idSetor;
	}

	public function setIdSetor($idSetor) 
	{
		$this->idSetor = $idSetor;
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
			$this->setTipo($objeto->tipo);
			$this->setEmail($objeto->email);
			$this->setSite($objeto->site);
			$this->setCpfCnpj($objeto->cpfCnpj);
			$this->setRgIe($objeto->rgIe);
			$this->setMatricula($objeto->matricula);
			$this->setDataCadastro($objeto->dataCadastro);
			$this->setDataAdmissao($objeto->dataAdmissao);
			$this->setDataDemissao($objeto->dataDemissao);
			$this->setCtpsNumero($objeto->ctpsNumero);
			$this->setCtpsSerie($objeto->ctpsSerie);
			$this->setCtpsDataExpedicao($objeto->ctpsDataExpedicao);
			$this->setCtpsUf($objeto->ctpsUf);
			$this->setObservacao($objeto->observacao);
			$this->setLogradouro($objeto->logradouro);
			$this->setNumero($objeto->numero);
			$this->setComplemento($objeto->complemento);
			$this->setBairro($objeto->bairro);
			$this->setCidade($objeto->cidade);
			$this->setCep($objeto->cep);
			$this->setMunicipioIbge($objeto->municipioIbge);
			$this->setUf($objeto->uf);
			$this->setIdPessoa($objeto->idPessoa);
			$this->setIdCargo($objeto->idCargo);
			$this->setIdSetor($objeto->idSetor);
		}
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'ViewPessoaColaborador');
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
			'email' => $this->getEmail(),
			'site' => $this->getSite(),
			'cpfCnpj' => $this->getCpfCnpj(),
			'rgIe' => $this->getRgIe(),
			'matricula' => $this->getMatricula(),
			'dataCadastro' => $this->getDataCadastro(),
			'dataAdmissao' => $this->getDataAdmissao(),
			'dataDemissao' => $this->getDataDemissao(),
			'ctpsNumero' => $this->getCtpsNumero(),
			'ctpsSerie' => $this->getCtpsSerie(),
			'ctpsDataExpedicao' => $this->getCtpsDataExpedicao(),
			'ctpsUf' => $this->getCtpsUf(),
			'observacao' => $this->getObservacao(),
			'logradouro' => $this->getLogradouro(),
			'numero' => $this->getNumero(),
			'complemento' => $this->getComplemento(),
			'bairro' => $this->getBairro(),
			'cidade' => $this->getCidade(),
			'cep' => $this->getCep(),
			'municipioIbge' => $this->getMunicipioIbge(),
			'uf' => $this->getUf(),
			'idPessoa' => $this->getIdPessoa(),
			'idCargo' => $this->getIdCargo(),
			'idSetor' => $this->getIdSetor(),
        ];
    }
}
