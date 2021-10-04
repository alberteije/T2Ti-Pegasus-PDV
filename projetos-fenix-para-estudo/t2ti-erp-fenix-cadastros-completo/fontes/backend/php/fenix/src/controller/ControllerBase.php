<?php

class ControllerBase
{
    public function tratarErro($response, $codigo, $mensagem, $excecao)
    {
        $jsonErro = new RetornoJsonErro($codigo, $mensagem, $excecao);
        $retorno = json_encode($jsonErro);
        $response->getBody()->write($retorno);
        return $response
            ->withStatus($codigo)
            ->withHeader('Content-Type', 'application/json');
    }

    public function browserOptionsRetornarResponse($request, $response, $args)
    {
        return $response;
    }

}