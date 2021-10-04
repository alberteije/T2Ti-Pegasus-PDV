<?php

class BancoController extends ControllerBase
{

    /**
     * $objJson = objeto que veio na requisição
     * $objEntidade = objeto instanciado, que pode ser utilizado para operações pelo ORM
     * $objBanco = objeto instanciado, mas que consultou o banco de dados para atualização
     **/     

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
            return parent::tratarErro($response, 500, 'Erro no Servidor [Consultar Lista Banco]', $e);
            /*
            $jsonErro = new RetornoJsonErro(500, 'Erro no Servidor [Consultar Lista Banco Agencia]', $e);
            $retorno = json_encode($jsonErro);
            $response->getBody()->write($retorno);
            return $response
                ->withStatus(500)
                ->withHeader('Content-Type', 'application/json');
            */
        }
    }
    
    public function consultarObjeto($request, $response, $args)
    {
        try {
            $objeto = BancoService::consultarObjeto($args['id']);

            if ($objeto == null) {
                return parent::tratarErro($response, 404, 'Registro não localizado [Consultar Objeto Banco]', null);
            } else {
                $retorno = json_encode($objeto);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Consultar Objeto Banco]', $e);
        }
    }

    public function inserir($request, $response, $args)
    {
        try {
            // pegar o objeto da requisição
            $objJson = json_decode($request->getBody());

            // valida o objeto
            $objEntidade = new Banco($objJson);
            if (!isset($objJson)) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Incluir Banco] - objeto não enviado.', null);
            }

            BancoService::salvar($objEntidade);

            $retorno = json_encode($objEntidade);
            $response->getBody()->write($retorno);

            return $response
                ->withStatus(201)
                ->withHeader('Content-Type', 'application/json');
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Erro no Servidor [Inserir Banco]', $e);
        }
    }

    public function alterar($request, $response, $args)
    {
        // pegar o objeto da requisição
        $objJson = json_decode($request->getBody());

        // valida objeto
        $objEntidade = new Banco($objJson);
        $mensagemErro = $objEntidade->validarObjetoRequisicao($objJson, $args['id']);
        if ($mensagemErro != '') {
            return parent::tratarErro($response, 400, $mensagemErro, null);
        }

        try {
            $objBanco = BancoService::consultarObjeto($objJson->id);

            if ($objBanco == null) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Alterar Banco]', null);
            } else {
                $objBanco->mapear($objEntidade);
                BancoService::salvar($objBanco);

                $retorno = json_encode($objJson);
                $response->getBody()->write($retorno);
                return $response
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Objeto inválido [Alterar Banco]', $e);
        }
    }

    public function excluir($request, $response, $args)
    {
        try {
            $objBanco = BancoService::consultarObjeto($args['id']);

            if ($objBanco == null) {
                return parent::tratarErro($response, 400, 'Objeto inválido [Excluir Banco]', null);
            } else {
                BancoService::excluir($objBanco);

                return $response
                    ->withStatus(200)
                    ->withHeader('Content-Type', 'application/json');
            }
        } catch (Exception $e) {
            return parent::tratarErro($response, 500, 'Objeto inválido [Excluir Banco]', $e);
        }
    }
}
