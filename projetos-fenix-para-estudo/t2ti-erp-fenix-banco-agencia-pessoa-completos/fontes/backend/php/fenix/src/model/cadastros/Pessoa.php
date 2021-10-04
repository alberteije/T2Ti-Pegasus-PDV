<?php

declare(strict_types=1);

use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity
 * @ORM\Table(name="pessoa")
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
     * @ORM\OneToMany(targetEntity="PessoaTelefone", mappedBy="pessoa", cascade={"persist", "remove"})
     */
    private $listaPessoaTelefone;

    /**
     * @ORM\OneToMany(targetEntity="PessoaEndereco", mappedBy="pessoa", cascade={"persist", "remove"})
     */
    private $listaPessoaEndereco;

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

    public function getCliente()
    {
        return $this->cliente;
    }

    public function setCliente($cliente)
    {
        $this->cliente = $cliente;
    }

    public function getColaborador()
    {
        return $this->colaborador;
    }

    public function setColaborador($colaborador)
    {
        $this->colaborador = $colaborador;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function setEmail($email)
    {
        $this->email = $email;
    }

    public function getFornecedor()
    {
        return $this->fornecedor;
    }

    public function setFornecedor($fornecedor)
    {
        $this->fornecedor = $fornecedor;
    }

    public function getNome()
    {
        return $this->nome;
    }

    public function setNome($nome)
    {
        $this->nome = $nome;
    }

    public function getSite()
    {
        return $this->site;
    }

    public function setSite($site)
    {
        $this->site = $site;
    }

    public function getTipo()
    {
        return $this->tipo;
    }

    public function setTipo($tipo)
    {
        $this->tipo = $tipo;
    }

    public function getTransportadora()
    {
        return $this->transportadora;
    }

    public function setTransportadora($transportadora)
    {
        $this->transportadora = $transportadora;
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

    public function setListaPessoaContato(Array $listaContato)
    {
        $this->listaPessoaContato = new ArrayCollection();
        for ($i = 0; $i < count($listaContato); $i++) {
            $contato = $listaContato[$i];
            $contato->setPessoa($this);
            $this->listaPessoaContato->add($contato);
        }
    }

    public function getListaPessoaTelefone()
    {
        return $this->listaPessoaTelefone->toArray();
    }

    public function setListaPessoaTelefone(Array $listaTelefone)
    {
        $this->listaPessoaTelefone = new ArrayCollection();
        for ($i = 0; $i < count($listaTelefone); $i++) {
            $telefone = $listaTelefone[$i];
            $telefone->setPessoa($this);
            $this->listaPessoaTelefone->add($telefone);
        }
    }

    public function getListaPessoaEndereco()
    {
        return $this->listaPessoaEndereco->toArray();
    }

    public function setListaPessoaEndereco(Array $listaEndereco)
    {
        $this->listaPessoaEndereco = new ArrayCollection();
        for ($i = 0; $i < count($listaEndereco); $i++) {
            $endereco = $listaEndereco[$i];
            $endereco->setPessoa($this);
            $this->listaPessoaEndereco->add($endereco);
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

        // Pessoa Física
        if (isset($objetoJson->pessoaFisica)) {
            $this->setPessoaFisica(new PessoaFisica($objetoJson->pessoaFisica));
            $this->getPessoaFisica()->setPessoa($this);
        }

        // Pessoa Jurídica
        if (isset($objetoJson->pessoaJuridica)) {
            $this->setPessoaJuridica(new PessoaJuridica($objetoJson->pessoaJuridica));
            $this->getPessoaJuridica()->setPessoa($this);
        }

        // Contatos
        $this->listaPessoaContato = new ArrayCollection();
        $contatos = $objetoJson->listaPessoaContato;
        if ($contatos != null) {
            for ($i = 0; $i < count($contatos); $i++) {
                $contato = new PessoaContato($contatos[$i]);
                $contato->setPessoa($this);
                $this->listaPessoaContato->add($contato);
            }
        }

        // Telefones
        $this->listaPessoaTelefone = new ArrayCollection();
        $telefones = $objetoJson->listaPessoaTelefone;
        if ($telefones != null) {
            for ($i = 0; $i < count($telefones); $i++) {
                $telefone = new PessoaTelefone($telefones[$i]);
                $telefone->setPessoa($this);
                $this->listaPessoaTelefone->add($telefone);
            }
        }

        // Endereços
        $this->listaPessoaEndereco = new ArrayCollection();
        $enderecos = $objetoJson->listaPessoaEndereco;
        if ($enderecos != null) {
            for ($i = 0; $i < count($enderecos); $i++) {
                $endereco = new PessoaEndereco($enderecos[$i]);
                $endereco->setPessoa($this);
                $this->listaPessoaEndereco->add($endereco);
            }
        }
    }

    /**
     * Mapping
     */
    public function mapear($objeto)
    {
        $this->setCliente($objeto->cliente);
        $this->setColaborador($objeto->colaborador);
        $this->setEmail($objeto->email);
        $this->setFornecedor($objeto->fornecedor);
        $this->setNome($objeto->nome);
        $this->setSite($objeto->site);
        $this->setTipo($objeto->tipo);
        $this->setTransportadora($objeto->transportadora);
        $this->setContador($objeto->contador);
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
            'listaPessoaTelefone' => $this->getListaPessoaTelefone(),
            'listaPessoaEndereco' => $this->getListaPessoaEndereco()
        ];
    }
}
