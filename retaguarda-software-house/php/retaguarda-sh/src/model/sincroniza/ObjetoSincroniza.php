<?php

class ObjetoSincroniza implements \JsonSerializable
{
	public $tabela;
	public $registros;

    /**
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
            'tabela' => $this->tabela,
            'registros' => $this->registros
        ];
    }


}