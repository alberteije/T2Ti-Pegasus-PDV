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

    public function retornarArquivo($response, $stream, $tipoArquivo) {
        return $response
        ->withHeader('Content-Type', $tipoArquivo)
        ->withHeader('Content-Description', 'File Transfer')
        ->withHeader('Content-Transfer-Encoding', 'binary')
        //->withHeader('Content-Disposition', 'attachment; filename="' . basename($file) . '"') - use se quiser forçar o download
        ->withHeader('Expires', '0')
        ->withHeader('Cache-Control', 'must-revalidate, post-check=0, pre-check=0')
        ->withHeader('Pragma', 'public')
        ->withBody($stream);     
    }

    public function browserOptionsRetornarResponse($request, $response, $args)
    {
        return $response;
    }

}