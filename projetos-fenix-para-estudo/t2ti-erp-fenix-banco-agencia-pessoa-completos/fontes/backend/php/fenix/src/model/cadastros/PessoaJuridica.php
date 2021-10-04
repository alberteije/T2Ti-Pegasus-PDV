<?php

declare(strict_types=1);

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="pessoa_juridica")
 */
class PessoaJuridica extends ModelBase implements \JsonSerializable
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @ORM\Column(type="string", name="CNPJ")
     */
    private $cnpj;

    /**
     * @ORM\Column(type="string", name="NOME_FANTASIA")
     */
    private $nomeFantasia;

    /**
     * @ORM\Column(type="date", name="DATA_CONSTITUICAO")
     */
    private $dataConstituicao;

    /**
     * @ORM\Column(type="string", name="INSCRICAO_ESTADUAL")
     */
    private $inscricaoEstadual;

    /**
     * @ORM\Column(type="string", name="INSCRICAO_MUNICIPAL")
     */
    private $inscricaoMunicipal;

    /**
     * @ORM\Column(type="string", name="TIPO_REGIME")
     */
    private $tipoRegime;

    /**
     * @ORM\Column(type="string", name="CRT")
     */
    private $crt;


    /**
     * Relations
     */

    /**
     * @ORM\OneToOne(targetEntity="Pessoa", inversedBy="pessoaJuridica")
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

    public function getCnpj()
    {
        return $this->cnpj;
    }

    public function setCnpj($cnpj)
    {
        $this->cnpj = $cnpj;
    }

    public function getNomeFantasia()
    {
        return $this->nomeFantasia;
    }

    public function setNomeFantasia($nomeFantasia)
    {
        $this->nomeFantasia = $nomeFantasia;
    }

    public function getDataConstituicao()
    {
        if ($this->dataConstituicao != null) {
            return $this->dataConstituicao->format('Y-m-d');
        } else {
            return null;
        }
    }

    public function setDataConstituicao($dataConstituicao)
    {
        $this->dataConstituicao = $dataConstituicao != null ? new \DateTime($dataConstituicao) : null;
    }

    public function getInscricaoEstadual()
    {
        return $this->inscricaoEstadual;
    }

    public function setInscricaoEstadual($inscricaoEstadual)
    {
        $this->inscricaoEstadual = $inscricaoEstadual;
    }

    public function getInscricaoMunicipal()
    {
        return $this->inscricaoMunicipal;
    }

    public function setInscricaoMunicipal($inscricaoMunicipal)
    {
        $this->inscricaoMunicipal = $inscricaoMunicipal;
    }

    public function getTipoRegime()
    {
        return $this->tipoRegime;
    }

    public function setTipoRegime($tipoRegime)
    {
        $this->tipoRegime = $tipoRegime;
    }

    public function getCrt()
    {
        return $this->crt;
    }

    public function setCrt($crt)
    {
        $this->crt = $crt;
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
            $this->setCnpj($objJson->cnpj);
            $this->setNomeFantasia($objJson->nomeFantasia);
            $this->setDataConstituicao($objJson->dataConstituicao);
            $this->setInscricaoEstadual($objJson->inscricaoEstadual);
            $this->setInscricaoMunicipal($objJson->inscricaoMunicipal);
            $this->setTipoRegime($objJson->tipoRegime);
            $this->setCrt($objJson->crt);
        }
    }

    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Pessoa Juridica');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
            'id' => $this->getId(),
            'cnpj' => $this->getCnpj(),
            'nomeFantasia' => $this->getNomeFantasia(),
            'dataConstituicao' => $this->getDataConstituicao(),
            'inscricaoEstadual' => $this->getInscricaoEstadual(),
            'inscricaoMunicipal' => $this->getInscricaoMunicipal(),
            'tipoRegime' => $this->getTipoRegime(),
            'crt' => $this->getCrt()
        ];
    }
}
