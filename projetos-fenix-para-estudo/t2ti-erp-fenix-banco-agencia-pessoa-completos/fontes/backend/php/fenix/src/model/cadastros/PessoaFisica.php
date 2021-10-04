<?php

declare(strict_types=1);

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="pessoa_fisica")
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
            $this->setCpf($objJson->cpf);
            $this->setRg($objJson->rg);
            $this->setOrgaoRg($objJson->orgaoRg);
            $this->setDataEmissaoRg($objJson->dataEmissaoRg);
            $this->setDataNascimento($objJson->dataNascimento);
            $this->setSexo($objJson->sexo);
            $this->setRaca($objJson->raca);
            $this->setNacionalidade($objJson->nacionalidade);
            $this->setNaturalidade($objJson->naturalidade);
            $this->setNomePai($objJson->nomePai);
            $this->setNomeMae($objJson->nomeMae);
        }
    }

    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Pessoa Fisica');
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
            'nomeMae' => $this->getNomeMae()
        ];
    }
}
