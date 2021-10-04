<?php

declare(strict_types=1);

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="pessoa_endereco")
 */
class PessoaEndereco extends ModelBase implements \JsonSerializable
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @ORM\Column(type="string", name="LOGRADOURO")
     */
    private $logradouro;

    /**
     * @ORM\Column(type="string", name="NUMERO")
     */
    private $numero;

    /**
     * @ORM\Column(type="string", name="BAIRRO")
     */
    private $bairro;

    /**
     * @ORM\Column(type="integer", name="MUNICIPIO_IBGE")
     */
    private $municipioIbge;

    /**
     * @ORM\Column(type="string", name="COMPLEMENTO")
     */
    private $complemento;

    /**
     * @ORM\Column(type="string", name="PRINCIPAL")
     */
    private $principal;

    /**
     * @ORM\Column(type="string", name="ENTREGA")
     */
    private $entrega;

    /**
     * @ORM\Column(type="string", name="COBRANCA")
     */
    private $cobranca;

    /**
     * @ORM\Column(type="string", name="CORRESPONDENCIA")
     */
    private $correspondencia;

    /**
     * @ORM\Column(type="string", name="UF")
     */
    private $uf;

    /**
     * @ORM\Column(type="string", name="CEP")
     */
    private $cep;

    /**
     * @ORM\Column(type="string", name="CIDADE")
     */
    private $cidade;

    /**
     * Relations
     */

    /**
     * @ORM\ManyToOne(targetEntity="Pessoa", inversedBy="listaPessoaEndereco")
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

    public function getBairro()
    {
        return $this->bairro;
    }

    public function setBairro($bairro)
    {
        $this->bairro = $bairro;
    }

    public function getMunicipioIbge()
    {
        return $this->municipioIbge;
    }

    public function setMunicipioIbge($municipioIbge)
    {
        $this->municipioIbge = $municipioIbge;
    }

    public function getComplemento()
    {
        return $this->complemento;
    }

    public function setComplemento($complemento)
    {
        $this->complemento = $complemento;
    }

    public function getPrincipal()
    {
        return $this->principal;
    }

    public function setPrincipal($principal)
    {
        $this->principal = $principal;
    }

    public function getEntrega()
    {
        return $this->entrega;
    }

    public function setEntrega($entrega)
    {
        $this->entrega = $entrega;
    }

    public function getCobranca()
    {
        return $this->cobranca;
    }

    public function setCobranca($cobranca)
    {
        $this->cobranca = $cobranca;
    }

    public function getCorrespondencia()
    {
        return $this->correspondencia;
    }

    public function setCorrespondencia($correspondencia)
    {
        $this->correspondencia = $correspondencia;
    }

    public function getUf()
    {
        return $this->uf;
    }

    public function setUf($uf)
    {
        $this->uf = $uf;
    }

    public function getCep()
    {
        return $this->cep;
    }

    public function setCep($cep)
    {
        $this->cep = $cep;
    }

    public function getCidade()
    {
        return $this->cidade;
    }

    public function setCidade($cidade)
    {
        $this->cidade = $cidade;
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
    public function __construct($objJson)
    {
        isset($objJson->id) ? $this->setId($objJson->id) : $this->setId(null);
        $this->mapear($objJson);
    }


    /**
     * Mapping
     */
    public function mapear($objJson)
    {
        if (isset($objJson)) {
            $this->setLogradouro($objJson->logradouro);
            $this->setNumero($objJson->numero);
            $this->setBairro($objJson->bairro);
            $this->setMunicipioIbge($objJson->municipioIbge);
            $this->setComplemento($objJson->complemento);
            $this->setPrincipal($objJson->principal);
            $this->setEntrega($objJson->entrega);
            $this->setCobranca($objJson->cobranca);
            $this->setCorrespondencia($objJson->correspondencia);
            $this->setUf($objJson->uf);
            $this->setCep($objJson->cep);
            $this->setCidade($objJson->cidade);
        }
    }

    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Pessoa Endereco');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
            'id' => $this->getId(),
            'logradouro' => $this->getLogradouro(),
            'numero' => $this->getNumero(),
            'bairro' => $this->getBairro(),
            'municipioIbge' => $this->getMunicipioIbge(),
            'complemento' => $this->getComplemento(),
            'principal' => $this->getPrincipal(),
            'entrega' => $this->getEntrega(),
            'cobranca' => $this->getCobranca(),
            'correspondencia' => $this->getCorrespondencia(),
            'uf' => $this->getUf(),
            'cep' => $this->getCep(),
            'cidade' => $this->getCidade()
        ];
    }
}
