<?php

declare(strict_types=1);

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="pessoa_contato")
 */
class PessoaContato extends ModelBase implements \JsonSerializable
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
     * @ORM\Column(type="string", name="EMAIL")
     */
    private $email;

    /**
     * @ORM\Column(type="string", name="OBSERVACAO")
     */
    private $observacao;


    /**
     * Relations
     */

    /**
     * @ORM\ManyToOne(targetEntity="Pessoa", inversedBy="listaPessoaContato")
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

    public function getNome()
    {
        return $this->nome;
    }

    public function setNome($nome)
    {
        $this->nome = $nome;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function setEmail($email)
    {
        $this->email = $email;
    }

    public function getObservacao()
    {
        return $this->observacao;
    }

    public function setObservacao($observacao)
    {
        $this->observacao = $observacao;
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
            $this->setNome($objJson->nome);
            $this->setEmail($objJson->email);
            $this->setObservacao($objJson->observacao);
        }
    }

    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Pessoa Contato');
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
            'email' => $this->getEmail(),
            'observacao' => $this->getObservacao()
        ];
    }
}