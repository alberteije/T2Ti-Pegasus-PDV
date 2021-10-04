<?php

/// classe transiente que controla o filtro
/// tomar como base o seguinte esquema para criar as condições de filtro (filter conditions)
/// https://github.com/nestjsx/crud/wiki/Requests
class Filtro implements \JsonSerializable
{
    public $campo;
    public $valor;
    public $dataInicial;
    public $dataFinal;
    public $where;

    public function __construct(string $filter)
    {
        $condicoes = explode('||', $filter);

        // $cont (LIKE %val%, contains)
        if ($condicoes[1] == '$cont') {
            $this->campo = $condicoes[0];
            $this->valor = $condicoes[2];
        }
    }



    /**
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
            'campo' => $this->campo,
            'valor' => $this->valor,
            'dataInicial' => $this->dataInicial,
            'dataFinal' => $this->dataFinal,
            'where' => $this->where,
        ];
    }
}