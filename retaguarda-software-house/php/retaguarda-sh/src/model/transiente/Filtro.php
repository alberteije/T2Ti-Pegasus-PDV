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
	
    public function __construct($filter)
    {
		if (isset($filter)) {
			$partesDoFiltro = explode('?', $filter);
			
			for ($i=0; $i < count($partesDoFiltro); $i++) { 

				$condicoes = explode('||', $partesDoFiltro[$i]);

				if ($i > 0)
				{
					$this->where = $this->where . " AND ";
				}

				// $cont (LIKE %val%, contains)
				if ($condicoes[1] == '$cont') {
					$this->campo = $condicoes[0];
					$this->valor = $condicoes[2];

					$campoPesquisa = Biblioteca::camelCase($this->campo);
					$this->where = $this->where . " $campoPesquisa like '%" . $this->valor . "%'";
				}

				// $eq (=, equal)
				if ($condicoes[1] == '$eq') {
					$this->campo = $condicoes[0];
					$this->valor = $condicoes[2];

					$campoPesquisa = Biblioteca::camelCase($this->campo);
					$this->where = $this->where . " $campoPesquisa = '" . $this->valor . "'";
				}
				
				// $between (BETWEEN, between, accepts two values)
				if ($condicoes[1] == '$between') {
					$datas = explode(',', $condicoes[2]);
					$this->campo = $condicoes[0];
					$this->dataInicial = $datas[0];
					$this->dataFinal = $datas[1];

					$campoPesquisa = Biblioteca::camelCase($this->campo);
					$this->where = $this->where . " $campoPesquisa between '" . $this->dataInicial . "' and '" . $this->dataFinal . "'";
				}
		
			}			
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