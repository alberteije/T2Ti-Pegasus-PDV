<?php

require './src/service/BancoService.php';
require './src/model/transiente/RetornoJsonErro.php';
require './src/model/transiente/Filtro.php';

class BancoController
{

    public function consultarLista($request, $response, $args)
    {
        try {
            if (count($request->getQueryParams()) > 0) {
                $filtro = new Filtro($request->getQueryParams()['filter']);
                $listaConsulta = BancoService::consultarListaFiltroValor($filtro->campo, $filtro->valor);
            } else {
                $listaConsulta = BancoService::consultarLista();
            }
            $retorno = json_encode($listaConsulta);
            $response->getBody()->write($retorno);
            return $response->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            $jsonErro = new RetornoJsonErro(500, 'Erro no Servidor [Consultar Lista Banco]', $e);
            $retorno = json_encode($jsonErro);
            $response->getBody()->write($retorno);
            return $response
                ->withStatus(500)
                ->withHeader('Content-Type', 'application/json');
        }
    }
    
    // public function consultarListaFiltroValor($request, $response, $args)
    // {
    //     try {
    //         $listaConsulta = BancoService::consultarListaFiltroValor($args['campo'], $args['valor']);
    //         $retorno = json_encode($listaConsulta);
    //         $response->getBody()->write($retorno);
    //         return $response->withHeader('Content-Type', 'application/json');
    //     } catch (Exception $e) {
    //         $jsonErro = new RetornoJsonErro(500, 'Erro no Servidor [Consultar Lista Filtro Valor Banco]', $e);
    //         $retorno = json_encode($jsonErro);
    //         $response->getBody()->write($retorno);
    //         return $response
    //             ->withStatus(500)
    //             ->withHeader('Content-Type', 'application/json');
    //     }
    // }

    public function consultarObjeto($request, $response, $args)
    {
        try {
            $objeto = BancoService::consultarObjeto($args['id']);

            if ($objeto == null) {
                $jsonErro = new RetornoJsonErro(404, 'Registro não localizado [Consultar Objeto Banco]', null);
                $retorno = json_encode($jsonErro);
                $response->getBody()->write($retorno);
                return $response
                    ->withStatus(404)
                    ->withHeader('Content-Type', 'application/json');
            } else {
                $retorno = json_encode($objeto);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            $jsonErro = new RetornoJsonErro(500, 'Erro no Servidor [Consultar Objeto Banco]', $e);
            $retorno = json_encode($jsonErro);
            $response->getBody()->write($retorno);
            return $response
                ->withStatus(500)
                ->withHeader('Content-Type', 'application/json');
        }
    }

    public function inserir($request, $response, $args)
    {
        try {
            // pegar o objeto da requisição
            $bancoJson = json_decode($request->getBody());
            $banco = new Banco($bancoJson);

            BancoService::salvar($banco);

            $retorno = json_encode($bancoJson);
            $response->getBody()->write($retorno);

            return $response
                ->withStatus(201)
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            $jsonErro = new RetornoJsonErro(500, 'Erro no Servidor [Inserir Banco]', $e);
            $retorno = json_encode($jsonErro);
            $response->getBody()->write($retorno);
            return $response
                ->withStatus(500)
                ->withHeader('Content-Type', 'application/json');
        }
    }

    public function alterar($request, $response, $args)
    {
        // pegar o objeto da requisição
        $bancoJson = json_decode($request->getBody());

        // valida objeto
        $banco = new Banco($bancoJson);
        $mensagemErro = $banco->validarObjetoRequisicao($bancoJson, $args['id']);
        if ($mensagemErro != '') {
            $jsonErro = new RetornoJsonErro(400, $mensagemErro, null);
            $retorno = json_encode($jsonErro);
            $response->getBody()->write($retorno);
            return $response
                ->withStatus(400)
                ->withHeader('Content-Type', 'application/json');
        }

        try {
            $dbBanco = BancoService::consultarObjeto($bancoJson->id);

            if ($dbBanco == null) {
                $jsonErro = new RetornoJsonErro(400, 'Objeto inválido [Alterar Banco]', null);
                $retorno = json_encode($jsonErro);
                $response->getBody()->write($retorno);
                return $response
                    ->withStatus(400)
                    ->withHeader('Content-Type', 'application/json');
            } else {
                $dbBanco->mapear($banco);
                BancoService::salvar($dbBanco);

                $retorno = json_encode($bancoJson);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            $jsonErro = new RetornoJsonErro(500, 'Erro no Servidor [Alterar Banco]', $e);
            $retorno = json_encode($jsonErro);
            $response->getBody()->write($retorno);
            return $response
                ->withStatus(500)
                ->withHeader('Content-Type', 'application/json');
        }
    }

    public function excluir($request, $response, $args)
    {
        try {
            $dbBanco = BancoService::consultarObjeto($args['id']);

            if ($dbBanco == null) {
                $jsonErro = new RetornoJsonErro(400, 'Objeto inválido [Excluir Banco]', null);
                $retorno = json_encode($jsonErro);
                $response->getBody()->write($retorno);
                return $response
                    ->withStatus(400)
                    ->withHeader('Content-Type', 'application/json');
            } else {
                BancoService::excluir($dbBanco);

                return $response
                    ->withStatus(200)
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            $jsonErro = new RetornoJsonErro(500, 'Erro no Servidor [Excluir Banco]', $e);
            $retorno = json_encode($jsonErro);
            $response->getBody()->write($retorno);
            return $response
                ->withStatus(500)
                ->withHeader('Content-Type', 'application/json');
        }
    }
}
