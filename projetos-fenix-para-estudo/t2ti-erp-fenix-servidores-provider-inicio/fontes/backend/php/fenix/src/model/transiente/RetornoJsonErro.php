<?php

/// classe transiente que armazena o objeto do erro que será retornado para o cliente
class RetornoJsonErro implements \JsonSerializable
{
    private $status;
    private $message;
    private $error;
    private $trace;

    public function __construct(int $codigo, string $mensagem, ?Exception $erro)
    {
        $this->status = $codigo;
        $this->message = $mensagem;

        switch ($this->status) {
            case 400:
                $this->error = 'Bad Request';
                break;
            case 404:
                $this->error = 'Not Found';
                break;
            case 500:
                $this->error = 'Internal Server Error';
                break;
            default:
                $this->error = 'Erro não mapeado';
                break;
        }

        if ($erro != null) {
            $this->message = $this->message . " - Exceção: " . $erro->getMessage();
            $this->trace = $erro->getTraceAsString();
        }
    }

    /**
     * {@inheritdoc}
     */
    public function jsonSerialize()
    {
        return [
            'status' => $this->status,
            'message' => $this->message,
            'error' => $this->error,
            'trace' => $this->trace
        ];
    }


}