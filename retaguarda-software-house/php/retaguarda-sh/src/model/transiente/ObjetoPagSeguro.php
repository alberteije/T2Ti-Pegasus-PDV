<?php

/// classe transiente que armazena o objeto enviado pelo PagSeguro
class ObjetoPagSeguro implements \JsonSerializable
{
	public $codigoTransacao;
	public $statusTransacao;
	public $codigoStatusTransacao;
	public $emailCliente;
	public $metodoPagamento;
	public $codigoTipoPagamento;
	public $codigoProduto;
	public $descricaoProduto;
	public $valorUnitario;

    /**
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
            'codigoTransacao' => $this->codigoTransacao,
            'statusTransacao' => $this->statusTransacao,
            'codigoStatusTransacao' => $this->codigoStatusTransacao,
            'emailCliente' => $this->emailCliente,
            'metodoPagamento' => $this->metodoPagamento,
            'codigoTipoPagamento' => $this->codigoTipoPagamento,
            'codigoProduto' => $this->codigoProduto,
            'descricaoProduto' => $this->descricaoProduto,
            'valorUnitario' => $this->valorUnitario
        ];
    }


}