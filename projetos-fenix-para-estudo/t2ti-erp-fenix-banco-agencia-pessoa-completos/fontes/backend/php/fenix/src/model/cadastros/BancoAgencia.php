<?php

declare(strict_types=1);

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="banco_agencia")
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

    // https://www.doctrine-project.org/projects/doctrine-orm/en/2.6/reference/association-mapping.html
    /**
     * @ORM\ManyToOne(targetEntity="Banco", fetch="EAGER")
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
        $this->setNumero($objeto->numero);
        $this->setDigito($objeto->digito);
        $this->setNome($objeto->nome);
        $this->setTelefone($objeto->telefone);
        $this->setContato($objeto->contato);
        $this->setObservacao($objeto->observacao);
        $this->setGerente($objeto->gerente);
    }


    /**
     * Validation
     */
    public function validarObjetoRequisicao($objJson, $id)
    {
        return parent::validarObjeto($objJson, $id, 'Banco Agencia');
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
            'banco' => $this->getBanco()
        ];
    }
}
