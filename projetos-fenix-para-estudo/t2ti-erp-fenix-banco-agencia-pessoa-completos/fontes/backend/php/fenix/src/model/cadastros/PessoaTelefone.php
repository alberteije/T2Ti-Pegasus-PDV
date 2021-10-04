<?php

declare(strict_types=1);

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="pessoa_telefone")
 */
class PessoaTelefone extends ModelBase implements \JsonSerializable
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @ORM\Column(type="string", name="TIPO")
     */
    private $tipo;

    /**
     * @ORM\Column(type="string", name="NUMERO")
     */
    private $numero;



    /**
     * Relations
     */

    /**
     * @ORM\ManyToOne(targetEntity="Pessoa", inversedBy="listaPessoaTelefone")
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

    public function getTipo()
    {
        return $this->tipo;
    }

    public function setTipo($tipo)
    {
        $this->tipo = $tipo;
    }

    public function getNumero()
    {
        return $this->numero;
    }

    public function setNumero($numero)
    {
        $this->numero = $numero;
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
            $this->setTipo($objJson->tipo);
            $this->setNumero($objJson->numero);
        }
    }

    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Pessoa Telefone');
    }


    /**
     * Serialization
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
            'id' => $this->getId(),
            'tipo' => $this->getTipo(),
            'numero' => $this->getNumero()
        ];
    }
}
