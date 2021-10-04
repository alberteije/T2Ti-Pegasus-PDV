<?php

declare(strict_types=1);

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="banco")
 */
class Banco implements \JsonSerializable
{
    /**
     * @var int
     *
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(type="string", name="CODIGO")
     */
    private $codigo;

    /**
     * @var string
     *
     * @ORM\Column(type="string", name="NOME")
     */
    private $nome;

    /**
     * @var string
     *
     * @ORM\Column(type="string", name="URL")
     */
    private $url;

    public function __construct($objetoJson)
    {
        if (isset($objetoJson)) {
            isset($objetoJson->id) ? $this->id = $objetoJson->id : $this->id = null;
            $this->codigo = $objetoJson->codigo;
            $this->nome = $objetoJson->nome;
            $this->url = $objetoJson->url;
        }
    }

    public function mapear($dbBanco)
    {
        $this->codigo = $dbBanco->codigo;
        $this->nome = $dbBanco->nome;
        $this->url = $dbBanco->url;
    }

    public function validarObjetoRequisicao($bancoJson, $id)
    {
        if (!isset($bancoJson->id)) {
            $mensagemErro = 'Objeto inválido [Alterar Banco] - objeto não enviado.';
            return $mensagemErro;
        }
        if ($bancoJson->id == 0) {
            $mensagemErro = 'Objeto inválido [Alterar Banco] - ID zerado.';
            return $mensagemErro;
        }
        if ($id != $bancoJson->id) {
            $mensagemErro = 'Objeto inválido [Alterar Banco] - ID do objeto difere do ID da URL.';
            return $mensagemErro;
        }
    }

    /**
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'codigo' => $this->codigo,
            'nome' => $this->nome,
            'url' => $this->url
        ];
    }
}