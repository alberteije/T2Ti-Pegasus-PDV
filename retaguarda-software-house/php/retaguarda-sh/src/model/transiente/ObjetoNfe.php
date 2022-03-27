<?php

class ObjetoNfe implements \JsonSerializable
{
	public $cnpj;
	public $justificativa;
	public $ano;
	public $modelo;
	public $serie;
	public $numeroInicial;
	public $numeroFinal;
	public $chaveAcesso;

    /**
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
            'cnpj' => $this->cnpj,
            'justificativa' => $this->justificativa,
            'ano' => $this->ano,
            'modelo' => $this->modelo,
            'serie' => $this->serie,
            'numeroInicial' => $this->numeroInicial,
            'numeroFinal' => $this->numeroFinal,
            'chaveAcesso' => $this->chaveAcesso
        ];
    }


}